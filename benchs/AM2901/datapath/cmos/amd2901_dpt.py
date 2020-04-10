#!/usr/bin/env python

try:
  import sys
  from   helpers import l
  from   stratus import *
except ImportError, e:
  serror = str(e)
  if serror.startswith('No module named'):
    module = serror.split()[-1]
    print '[ERROR] The <%s> python module or symbol cannot be loaded.' % module
    print '        Please check the integrity of the <coriolis> package.'
    sys.exit(1)
  if str(e).find('cannot open shared object file'):
    library = serror.split(':')[0]
    print '[ERROR] The <%s> shared library cannot be loaded.' % library
    print '        Under RHEL 6, you must be under devtoolset-2.'
    print '        (scl enable devtoolset-2 bash)'
  sys.exit(1)
except Exception, e:
  print '[ERROR] A strange exception occurred while loading the basic Coriolis/Python'
  print '        modules. Something may be wrong at Python/C API level.\n'
  print '        %s' % e
  sys.exit(2)


class amd2901_dpt ( Model ) :

  def Interface ( self ) :

    # Command for selecting operands R and S.
    self.ops_mx     = SignalIn    ( "ops_mx",     3 )
    self.opr_mx     = SignalIn    ( "opr_mx",     2 )
                                                 
    # ALU commands and auxiliary terminals.      
    self.alu_k      = SignalIn    ( "alu_k",      5 )
    self.alu_cin    = SignalIn    ( "alu_cin",    1 ) 
    self.alu_cout   = SignalOut   ( "alu_cout",   1 ) 
    self.alu_over   = SignalInOut ( "alu_over",   1 )
    
    # RAM, ACCU shifter commands and auxiliary terminals.
    self.ram_sh     = SignalIn    ( "ram_sh",     2 ) 
    self.acc_sh     = SignalIn    ( "acc_sh",     2 ) 
    
    # RAM shifter inputs
    self.ram_i_up   = SignalIn    ( "ram_i_up",   1 )
    self.ram_i_down = SignalIn    ( "ram_i_down", 1 )
    
    # ACCU shifter inputs.
    self.acc_i_up   = SignalIn    ( "acc_i_up",   1 ) 
    self.acc_i_down = SignalIn    ( "acc_i_down", 1 ) 
    
    # ACCU shifter outputs ("acc_scout" is "acc_q_up").
    self.acc_q_down = SignalOut   ( "acc_q_down", 1 )
    self.acc_q_up   = SignalOut   ( "acc_q_up",   1 )
    
    # Output multiplexer commnand (for X bus).
    self.out_mx     = SignalIn    ( "out_mx",     1 )
    
    # ACCU controls terminals.
    self.acc_ck     = SignalIn    ( "acc_ck",     1 )
    self.acc_wen    = SignalIn    ( "acc_wen",    1 )
    
    # Register file controls terminals.
    self.ram_ck     = SignalIn    ( "ram_ck",    16 )   # Register clocks (ck) 
    self.b_w        = SignalIn    ( "b_w",       16 )   # Write enable 
    self.a          = SignalIn    ( "a",         16 )   # Register A address. 
    self.b          = SignalIn    ( "b",         16 )   # Register B address. 
    
    # Data buses terminals.
    self.opr_d      = SignalIn    ( "opr_d",      4 )
    self.alu_f      = SignalInOut ( "alu_f",      4 )
    self.alu_np     = SignalOut   ( "alu_np",     4 )
    self.alu_ng     = SignalOut   ( "alu_ng",     4 )
    self.out_x      = SignalOut   ( "out_x",      4 )
     
    # Power supply connectors. 
    self.vdd = VddIn ( "vdd" )
    self.vss = VssIn ( "vss" )


  def Netlist ( self ) :

    Generate ( "DpgenSff",                    "sff_4bits", param = {'nbit' : 4,                     'physical' : True, 'flags' : 0} )
    Generate ( "DpgenNbuse",                "nbuse_4bits", param = {'nbit' : 4,                     'physical' : True, 'flags' : 0} )
    Generate ( "DpgenInv",             "inv_drive8_4bits", param = {'nbit' : 4, 'drive' : 8,        'physical' : True, 'flags' : 0} )
    Generate ( "DpgenMux2",                  "mux2_4bits", param = {'nbit' : 4,                     'physical' : True, 'flags' : 0} )
    Generate ( "DpgenNand2mask", "nand2mask_0b0000_4bits", param = {'nbit' : 4, 'const' : "0b0000", 'physical' : True, 'flags' : 0} )
    Generate ( "DpgenXnor2",                "xnor2_4bits", param = {'nbit' : 4,                     'physical' : True, 'flags' : 0} )
    Generate ( "DpgenNand2",                "nand2_4bits", param = {'nbit' : 4,                     'physical' : True, 'flags' : 0} )
    Generate ( "DpgenNor2",                  "nor2_4bits", param = {'nbit' : 4,                     'physical' : True, 'flags' : 0} )
    Generate ( "DpgenXor2",                  "xor2_4bits", param = {'nbit' : 4,                     'physical' : True, 'flags' : 0} )
    Generate ( "DpgenXnor2",         "xnor2_drive4_4bits", param = {'nbit' : 4, 'drive' : 4,        'physical' : True, 'flags' : 0} )
    Generate ( "DpgenBuff",                  "buff_2bits", param = {'nbit' : 2,                     'physical' : True, 'flags' : 0} )

    # List of Signals  
    ram_d       = Signal ( "ram_d",      4 )
    ram_nra     = Signal ( "ram_nra",    4 )
    ram_nrb     = Signal ( "ram_nrb",    4 )
    ram_ra      = Signal ( "ram_ra",     4 )
    ram_rb      = Signal ( "ram_rb",     4 )
                                         
    mux_shram   = Signal ( "mux_shram",  4 )
    acc_q       = Signal ( "acc_q",      4 )
    ops0_out    = Signal ( "ops0_out",   4 )
    ops1_out    = Signal ( "ops1_out",   4 )
    opr0_out    = Signal ( "opr0_out",   4 )
    alu_ns      = Signal ( "alu_ns",     4 )
    alu_nr      = Signal ( "alu_nr",     4 )
    alu_int0    = Signal ( "alu_int0",   4 )
    alu_int1    = Signal ( "alu_int1",   4 )
    alu_int2    = Signal ( "alu_int2",   4 )
    alu_int3    = Signal ( "alu_int3",   4 )
    alu_int4    = Signal ( "alu_int4",   4 )
    alu_int5    = Signal ( "alu_int5",   4 )
    alu_int6    = Signal ( "alu_int6",   4 )
    alu_int7    = Signal ( "alu_int7",   4 )
    mux_shacc0  = Signal ( "mux_shacc0", 4 )   
    mux_shacc1  = Signal ( "mux_shacc1", 4 )   
    carry       = Signal ( "carry",      2 )

    # Array of Signals
    ram_q = []
    for i in range ( 16 ) : ram_q += [Signal ( "ram_q%ld" % i, 4 )]
      
    # Register file description.
    self.ram_reg  = {}
    self.ram_ntsa = {}
    self.ram_ntsb = {}
    
    for i in range ( 16 ) :
      # Register part.
      self.ram_reg[i] = Inst ( "sff_4bits", "ram_reg%ld" % i
                             , map   = { 'wen'  : self.b_w[i]
                                       , 'ck'   : self.ram_ck[i]
                                       , 'i0'   : ram_d
                                       , 'q'    : ram_q[i]
                                       , 'vdd'  : self.vdd
                                       , 'vss'  : self.vss
                                       }
                             )
      
      # Tristate for A output. 
      self.ram_ntsa[i] = Inst ( "nbuse_4bits", "ram_ntsa%ld" % i
                              , map   = { 'cmd'  : self.a[i]
                                        , 'i0'   : ram_q[i]
                                        , 'nq'   : ram_nra
                                        , 'vdd'  : self.vdd
                                        , 'vss'  : self.vss
                                        }
                              )

      
      # Tristate for B output. 
      self.ram_ntsb[i] = Inst ( "nbuse_4bits", "ram_ntsb%ld" % i
                              , map   = { 'cmd'  : self.b[i]
                                        , 'i0'   : ram_q[i]
                                        , 'nq'   : ram_nrb
                                        , 'vdd'  : self.vdd
                                        , 'vss'  : self.vss
                                        }
                              )

    
    # Output drivers for A & B output. 
    self.inv_ra = Inst ( "inv_drive8_4bits", "inv_ra"
                       , map   = { 'i0'    : ram_nra
                                 , 'nq'    : ram_ra
                                 , 'vdd'   : self.vdd
                                 , 'vss'   : self.vss
                                 }
                       )

    self.inv_rb = Inst ( "inv_drive8_4bits", "inv_rb"
                       , map   = { 'i0'    : ram_nrb
                                 , 'nq'    : ram_rb
                                 , 'vdd'   : self.vdd
                                 , 'vss'   : self.vss
                                 }
                       )
     
    #  --------------------------------------------------------------
    #  RAM shifter.
    self.mx2_ram_sh0 = Inst ( "mux2_4bits", "mx2_ram_sh0"
                            , map   = { 'i0'   : Cat ( self.alu_f[2:0], self.ram_i_down )
                                      , 'i1'   : Cat ( self.ram_i_up, self.alu_f[3:1] )
                                      , 'cmd'  : self.ram_sh[0]
                                      , 'q'    : mux_shram
                                      , 'vdd'  : self.vdd
                                      , 'vss'  : self.vss
                                      }
                            )
    self.mx2_ram_sh1 = Inst ( "mux2_4bits", "mx2_ram_sh1"
                            , map   = { 'i0'   : mux_shram
                                      , 'i1'   : self.alu_f
                                      , 'cmd'  : self.ram_sh[1]
                                      , 'q'    : ram_d
                                      , 'vdd'  : self.vdd
                                      , 'vss'  : self.vss
                                      } 
                            )
    

    # *********************** Operand S ************************ 
    self.mx2_ops0 = Inst ( "mux2_4bits", "mx2_ops0"
                         , map   = { 'i0'   : acc_q
                                   , 'i1'   : ram_rb
                                   , 'cmd'  : self.ops_mx[0]
                                   , 'q'    : ops0_out
                                   , 'vdd'  : self.vdd
                                   , 'vss'  : self.vss
                                   } 
                         )
    self.mx2_ops1 = Inst ( "mux2_4bits", "mx2_ops1"
                         , map   = { 'i0'   : ops0_out
                                   , 'i1'   : ram_ra
                                   , 'cmd'  : self.ops_mx[1]
                                   , 'q'    : ops1_out
                                   , 'vdd'  : self.vdd
                                   , 'vss'  : self.vss
                                   } 
                         )
    self.nand2mask_s = Inst ( "nand2mask_0b0000_4bits", "nand2mask_s"
                            , map   = { 'i0'    : ops1_out
                                      , 'cmd'   : self.ops_mx[2]
                                      , 'nq'    : alu_ns
                                      , 'vdd'   : self.vdd
                                      , 'vss'   : self.vss
                                      } 
                            )
     
    # *********************** Operand R ************************ 
    self.mx2_opr0 = Inst ( "mux2_4bits", "mx2_opr0"
                         , map   = { 'i0'   : ram_ra
                                   , 'i1'   : self.opr_d
                                   , 'cmd'  : self.opr_mx[0]
                                   , 'q'    : opr0_out
                                   , 'vdd'  : self.vdd
                                   , 'vss'  : self.vss
                                   } 
                         )
    self.nand2mask_r = Inst ( "nand2mask_0b0000_4bits", "nand2mask_r"
                            , map   = { 'i0'    : opr0_out
                                      , 'cmd'   : self.opr_mx[1]
                                      , 'nq'    : alu_nr
                                      , 'vdd'   : self.vdd
                                      , 'vss'   : self.vss
                                      } 
                            )
    
    # *********************** ALU Description ****************** 
    self.xnor2_alu0 = Inst ( "xnor2_4bits", "xnor2_alu0"
                           , map   = { 'i0'   : alu_nr
                                     , 'i1'   : Cat ( self.alu_k[0]
                                                    , self.alu_k[0]
                                                    , self.alu_k[0]
                                                    , self.alu_k[0]
                                                    ) 
                                     , 'nq'   : alu_int0
                                     , 'vdd'  : self.vdd
                                     , 'vss'  : self.vss
                                     } 
                           )
     
    self.xnor2_alu1 = Inst ( "xnor2_4bits", "xnor2_alu1"
                           , map   = { 'i0'   : alu_ns
                                     , 'i1'   : Cat ( self.alu_k[1]
                                                    , self.alu_k[1]
                                                    , self.alu_k[1]
                                                    , self.alu_k[1]
                                                    ) 
                                     , 'nq'   : alu_int1
                                     , 'vdd'  : self.vdd
                                     , 'vss'  : self.vss
                                     } 
                           )
     
    # Compute of "generate".
    self.nand2_ng = Inst ( "nand2_4bits", "nand2_ng"
                         , map   = { 'i0'   : alu_int0
                                   , 'i1'   : alu_int1
                                   , 'nq'   : self.alu_ng
                                   , 'vdd'  : self.vdd
                                   , 'vss'  : self.vss
                                   }
                         )

    # Compute of "propagate". 
    self.nor2_np = Inst ( "nor2_4bits", "nor2_np"
                        , map   = { 'i0'   : alu_int0
                                  , 'i1'   : alu_int1
                                  , 'nq'   : self.alu_np
                                  , 'vdd'  : self.vdd
                                  , 'vss'  : self.vss
                                  }
                        )
    
    # Compute of carry. 
    self.inv_np = Inst ( "inv_drive8_4bits", "inv_np"
                       , map   = { 'i0'    : self.alu_np
                                 , 'nq'    : alu_int2
                                 , 'vdd'   : self.vdd
                                 , 'vss'   : self.vss
                                 }
                       )
    self.nand2_cout_in = Inst ( "nand2_4bits", "nand2_cout_in"
                              , map   = { 'i0'   : alu_int2
                                        , 'i1'   : Cat ( self.alu_over, carry, self.alu_cin )
                                        , 'nq'   : alu_int3
                                        , 'vdd'  : self.vdd
                                        , 'vss'  : self.vss
                                        }
                              )
    self.nand2_cout = Inst ( "nand2_4bits", "nand2_cout"
                           , map   = { 'i0'   : alu_int3
                                     , 'i1'   : self.alu_ng
                                     , 'nq'   : Cat ( self.alu_cout, self.alu_over, carry ) 
                                     , 'vdd'  : self.vdd
                                     , 'vss'  : self.vss
                                     }
                           )
    
    # Logical and arithmetical operators. 
    self.nor2_alu_int7 = Inst ( "nor2_4bits", "nor2_alu_int7"
                              , map   = { 'i0'   : Cat ( self.alu_over
                                                       , carry
                                                       , self.alu_cin
                                                       ) 
                                        , 'i1'   : Cat ( self.alu_k[4]
                                                       , self.alu_k[4]
                                                       , self.alu_k[4]
                                                       , self.alu_k[4]
                                                       )
                                        , 'nq'   : alu_int7
                                        , 'vdd'  : self.vdd
                                        , 'vss'  : self.vss
                                        }
                              )

    self.nor2_alu_int4 = Inst ( "nor2_4bits", "nor2_alu_int4"
                              , map   = { 'i0'   : self.alu_ng
                                        , 'i1'   : Cat ( self.alu_k[2]
                                                       , self.alu_k[2]
                                                       , self.alu_k[2]
                                                       , self.alu_k[2]
                                                       ) 
                                        , 'nq'   : alu_int4
                                        , 'vdd'  : self.vdd
                                        , 'vss'  : self.vss
                                        }
                              )

    self.nor2_alu_int5 = Inst ( "nor2_4bits", "nor2_alu_int5"
                              , map   = { 'i0'   : self.alu_np
                                        , 'i1'   : Cat ( self.alu_k[3]
                                                       , self.alu_k[3]
                                                       , self.alu_k[3]
                                                       , self.alu_k[3]
                                                       )
                                        , 'nq'   : alu_int5
                                        , 'vdd'  : self.vdd
                                        , 'vss'  : self.vss
                                        }
                              )
    
    self.xor2_alu_int6 = Inst ("xor2_4bits", "xor2_alu_int6"
                              , map   = { 'i0'   : alu_int4
                                        , 'i1'   : alu_int5
                                        , 'q'    : alu_int6
                                        , 'vdd'  : self.vdd
                                        , 'vss'  : self.vss
                                        } 
                              )
     
    # Output. 
    self.xnor2_alu_f = Inst ( "xnor2_drive4_4bits", "xnor2_alu_f"
                            , map   = { 'i0'   : alu_int6
                                      , 'i1'   : alu_int7
                                      , 'nq'   : self.alu_f
                                      , 'vdd'  : self.vdd
                                      , 'vss'  : self.vss
                                      } 
                            ) 
     
    # ******************** ACCU Description ******************** 
    self.mx2_acc_sh0 = Inst ( "mux2_4bits", "mx2_acc_sh0"
                            , map   = { 'i0'   : Cat ( acc_q[2:0], self.acc_i_down ) 
                                      , 'i1'   : Cat ( self.acc_i_up, acc_q[3:1] ) 
                                      , 'cmd'  : self.acc_sh[0]
                                      , 'q'    : mux_shacc0
                                      , 'vdd'  : self.vdd
                                      , 'vss'  : self.vss
                                      } 
                            )
    self.mx2_acc_sh1 = Inst ( "mux2_4bits", "mx2_acc_sh1"
                            , map   = { 'i0'   : mux_shacc0
                                      , 'i1'   : self.alu_f
                                      , 'cmd'  : self.acc_sh[1]
                                      , 'q'    : mux_shacc1
                                      , 'vdd'  : self.vdd
                                      , 'vss'  : self.vss
                                      } 
                            )
    self.acc_reg = Inst ( "sff_4bits", "acc_reg"
                        , map   = { 'wen'  : self.acc_wen
                                  , 'ck'   : self.acc_ck
                                  , 'i0'   : mux_shacc1
                                  , 'q'    : acc_q
                                  , 'vdd'  : self.vdd
                                  , 'vss'  : self.vss
                                  }
                        )
    self.acc_buff = Inst ( "buff_2bits", "acc_buff0"
                         , map   = { 'i0'   : Cat ( acc_q[0], acc_q[3] ) 
                                   , 'q'    : Cat ( self.acc_q_down, self.acc_q_up )
                                   , 'vdd'  : self.vdd
                                   , 'vss'  : self.vss
                                   }
                         )
     
    # ******************* Output Multiplexer ******************* 
    self.mx2_out = Inst ( "mux2_4bits", "mx2_out"
                        , map   = { 'i0'   : self.alu_f
                                  , 'i1'   : ram_ra
                                  , 'cmd'  : self.out_mx
                                  , 'q'    : self.out_x
                                  , 'vdd'  : self.vdd
                                  , 'vss'  : self.vss
                                  } 
                        )


  # *********************************************************
  # *********************  Placement   **********************
  # *********************************************************
  def Layout (self):
   
    for i in range ( 8 ) :
      if i == 0 : Place ( self.ram_reg[i], NOSYM, XY ( l(0), l(0) ) )
      else      : PlaceRight ( self.ram_reg[i], NOSYM )
      PlaceRight ( self.ram_ntsa[i], NOSYM )
      PlaceRight ( self.ram_ntsb[i], NOSYM )
    
    for i in range ( 8, 16 ) :
      if i == 8 : Place ( self.ram_reg[i], NOSYM, XY ( l(0), l(300) ) )
      else      : PlaceRight ( self.ram_reg[i], NOSYM )
      PlaceRight ( self.ram_ntsa[i], NOSYM )
      PlaceRight ( self.ram_ntsb[i], NOSYM )
    
    SetRefIns  ( self.ram_reg[8]           )
    PlaceTop   ( self.inv_ra,        NOSYM )
    PlaceRight ( self.inv_rb,        NOSYM )
    PlaceRight ( self.mx2_ops0,      NOSYM )
    PlaceRight ( self.mx2_ops1,      NOSYM )
    PlaceRight ( self.nand2mask_s,   NOSYM )
    PlaceRight ( self.mx2_opr0,      NOSYM )
    PlaceRight ( self.nand2mask_r,   NOSYM )
    PlaceRight ( self.xnor2_alu0,    NOSYM )
    PlaceRight ( self.xnor2_alu1,    NOSYM )
    PlaceRight ( self.nand2_ng,      NOSYM )
    PlaceRight ( self.nor2_np,       NOSYM )
    PlaceRight ( self.inv_np,        NOSYM )
    PlaceRight ( self.nand2_cout_in, NOSYM )
    PlaceRight ( self.nand2_cout,    NOSYM )
    PlaceRight ( self.nor2_alu_int4, NOSYM )
    PlaceRight ( self.nor2_alu_int5, NOSYM )
    PlaceRight ( self.nor2_alu_int7, NOSYM )
    PlaceRight ( self.xor2_alu_int6, NOSYM )
    PlaceRight ( self.xnor2_alu_f,   NOSYM )
    PlaceRight ( self.mx2_acc_sh0,   NOSYM )
    PlaceRight ( self.mx2_acc_sh1,   NOSYM )
    PlaceRight ( self.acc_reg,       NOSYM )
    PlaceRight ( self.acc_buff,      NOSYM )
    PlaceRight ( self.mx2_ram_sh0,   NOSYM )
    PlaceRight ( self.mx2_ram_sh1,   NOSYM )
    PlaceRight ( self.mx2_out,       NOSYM )


def scriptMain ( **kw ):
  if kw.has_key('editor') and kw['editor']: setEditor( kw['editor'] )

  datapath = amd2901_dpt( "amd2901_dpt" )

  datapath.Interface()
  datapath.Netlist  ()
  datapath.View     ( message="After Netlist Generation" )
  datapath.Layout   ()
  datapath.View     ( message="After Layout Generation" )
  datapath.Save     (PHYSICAL)
  return 1


if __name__ == "__main__" :
  kw      = {}
  success = scriptMain( **kw )
  if not success: shellSuccess = 1

  sys.exit( shellSuccess )
