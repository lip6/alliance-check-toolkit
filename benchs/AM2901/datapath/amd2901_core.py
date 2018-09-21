#!/usr/bin/env python

from helpers import l
from stratus import *


class amd2901_core ( Model ) :

  def Interface ( self ) :
    # Pin terminals associated with ALU.
    self.cin        = SignalIn  ( "cin",        1 )
    self.cout       = SignalOut ( "cout",       1 )
    self.np         = SignalOut ( "np",         1 )
    self.ng         = SignalOut ( "ng",         1 )
    self.over       = SignalOut ( "over",       1 )
    self.zero       = SignalOut ( "zero",       1 )
    
    # Pin terminals associated with the RAM and ACCU shifter.
    # RAM and ACCU I/O plots controls.
    self.sh_right   = SignalOut ( "sh_right",   1 )
    self.sh_left    = SignalOut ( "sh_left",    1 )
    
    # RAM shifter I/O.
    self.ram_o_down = SignalOut ( "ram_o_down", 1 ) # alu_f[0]
    self.ram_o_up   = SignalOut ( "ram_o_up",   1 ) # alu_f[3]
    self.ram_i_down = SignalIn  ( "ram_i_down", 1 )
    self.ram_i_up   = SignalIn  ( "ram_i_up",   1 )
    
    # ACC shifter I/O.
    self.acc_o_down = SignalOut ( "acc_o_down", 1 )
    self.acc_o_up   = SignalOut ( "acc_o_up",   1 )
    self.acc_i_down = SignalIn  ( "acc_i_down", 1 )
    self.acc_i_up   = SignalIn  ( "acc_i_up",   1 )
    
    # ACCU controls terminals.
    self.ck         = SignalIn  ( "ck",         1 )
    
    # Data bus terminals.
    self.a          = SignalIn  ( "a",          4 )
    self.b          = SignalIn  ( "b",          4 )
    self.d          = SignalIn  ( "d",          4 )
    self.i          = SignalIn  ( "i",          9 )
    self.y          = SignalOut ( "y",          4 )
    self.noe        = SignalIn  ( "noe",        1 )
    self.oe         = SignalIn  ( "oe",         1 )
    
    # Power suplies terminals.
    self.vdd = VddIn ( "vdd" )
    self.vss = VssIn ( "vss" )
    return


  def Netlist ( self ) :
    ops_mx   = Signal ( "ops_mx",    3 )
    opr_mx   = Signal ( "opr_mx",    2 )
    alu_k    = Signal ( "alu_k",     5 )
    alu_over = Signal ( "alu_over",  1 )
    ram_sh   = Signal ( "ram_sh",    2 )
    out_mx   = Signal ( "out_mx",    1 )
    acc_wen  = Signal ( "acc_wen",   1 )
    deca     = Signal ( "deca",     16 )
    decb     = Signal ( "decb",     16 )
    decwb    = Signal ( "decwb",    16 )
    alu_np   = Signal ( "alu_np",    4 )
    alu_ng   = Signal ( "alu_ng",    4 )
    temp     = Signal ( "temp",      2 )
    alu_f    = Signal ( "alu_f",     4 )

    self.ram_o_down.Alias ( alu_f[0]   )
    temp.Alias            ( alu_f[2:1] )
    self.ram_o_up.Alias   ( alu_f[3]   )

    # Data-Path.
    self.dpt = Inst ( "amd2901_dpt", "dpt"
                    , map = { 'ram_ck'     : Cat ( self.ck, self.ck, self.ck, self.ck, self.ck, self.ck, self.ck, self.ck
                                                 , self.ck, self.ck, self.ck, self.ck, self.ck, self.ck, self.ck, self.ck )
	                        , 'ops_mx'     : ops_mx
	                        , 'opr_mx'     : opr_mx
	                        , 'alu_k'      : alu_k
	                        , 'alu_cin'    : self.cin
	                        , 'alu_cout'   : self.cout
	                        , 'alu_over'   : alu_over
                            , 'ram_sh'     : ram_sh
                            , 'acc_sh'     : ram_sh
                            , 'ram_i_up'   : self.ram_i_up
                            , 'ram_i_down' : self.ram_i_down
                            , 'acc_i_up'   : self.acc_i_up
                            , 'acc_i_down' : self.acc_i_down
                            , 'acc_q_down' : self.acc_o_down
                            , 'acc_q_up'   : self.acc_o_up
                            , 'out_mx'     : out_mx
                            , 'acc_ck'     : self.ck
                            , 'acc_wen'    : acc_wen
                            , 'a'          : deca
                            , 'b'          : decb
                            , 'b_w'        : decwb
                            , 'opr_d'      : self.d
                            , 'alu_f'      : alu_f
                            , 'alu_np'     : alu_np
                            , 'alu_ng'     : alu_ng
                            , 'out_x'      : self.y
                            , 'vdd'        : self.vdd
                            , 'vss'        : self.vss
                            }
                    )

    # Control.
    self.ctl = Inst ( "amd2901_ctl", "ctl"
                    , map = { 'ops_mx'        : ops_mx
                            , 'opr_mx'        : opr_mx
                            , 'alu_k'         : alu_k
                            , 'alu_cout'      : self.cout
                            , 'alu_over'      : alu_over
                            , 'deca'          : deca
                            , 'decb'          : decb
                            , 'decwb'         : decwb
                            , 'a'             : self.a
                            , 'b'             : self.b  # bw == b
                            , 'ram_sh'        : ram_sh
                            , 'out_mx'        : out_mx
                            , 'acc_wen'       : acc_wen
                            , 'alu_f'         : alu_f
                            , 'alu_np'        : alu_np
                            , 'alu_ng'        : alu_ng
                            , 'core_np'       : self.np  
                            , 'core_ng'       : self.ng  
                            , 'core_over'     : self.over
                            , 'core_zero'     : self.zero
                            , 'core_sh_right' : self.sh_right
                            , 'core_sh_left'  : self.sh_left
                            , 'i'             : self.i
                            , 'noe'           : self.noe
                            , 'oe'            : self.oe
                            , 'vdd'           : self.vdd
                            , 'vss'           : self.vss
                            }
                    )
    return


  def Layout ( self ) :
    Place   ( self.dpt, NOSYM, XY(l(0), l(0)) )
    ResizeAb( l(0), l(0), l(0), l(200) )
    return

