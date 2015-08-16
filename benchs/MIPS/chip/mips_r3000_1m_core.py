#!/usr/bin/env python

from stratus import *

class mips_r3000_1m_core ( Model ):

  def Interface (self):
    self.ck       = SignalIn  ("ck"        , 1 ) # bit                        external clock
    self.reset_n  = SignalIn  ("reset_n"   , 1 ) # bit                        external reset
    self.it_n     = SignalIn  ("it_n"      , 6 ) # bit_vector (  5 downto 0)  hw interrupts
                                                   
   #self.i_a      = SignalOut ("i_a"       , 32) # bit_vector ( 31 downto 0)  inst address
    self.i_ftch   = SignalOut ("i_ftch"    , 1 ) # bit                        inst fetch
    self.i_ack    = SignalOut ("i_ack"     , 1 ) # bit                        inst fetch ack
    self.i_berr_n = SignalIn  ("i_berr_n"  , 1 ) # bit                        inst bus error
    self.i_frz    = SignalIn  ("i_frz"     , 1 ) # bit                        inst cache busy
    self.i        = SignalIn  ("i"         , 32) # bit_vector ( 31 downto 0)  instruction
                                                   
    self.addr     = SignalOut ("addr"      , 32) # bit_vector ( 31 downto 0)  data address
   #self.d_a      = SignalOut ("d_a"       , 32) # bit_vector ( 31 downto 0)  data address
    self.d_rq     = SignalOut ("d_rq"      , 1 ) # bit                        data request
    self.d_lock   = SignalOut ("d_lock"    , 1 ) # bit                        locked access
    self.d_atype  = SignalOut ("d_atype"   , 2 ) # bit_vector (  1 downto 0)  access type
    self.d_ack    = SignalOut ("d_ack"     , 1 ) # bit                        data fetch ack
    self.d_berr_n = SignalIn  ("d_berr_n"  , 1 ) # bit                        data bus error
    self.d_frz    = SignalIn  ("d_frz"     , 1 ) # bit                        data cache busy
    self.d_in     = SignalIn  ("d_in"      , 32) # bit_vector ( 31 downto 0)  data (input )
    self.d_out    = SignalOut ("d_out"     , 32) # bit_vector ( 31 downto 0)  data (output)
    self.dout_e   = SignalOut ("dout_e"    , 4)  # bit_vector ( 31 downto 0)   data (output)
                                                   
    self.test     = SignalIn  ("test"      , 1 ) # bit                        test mode
    self.scin     = SignalIn  ("scin"      , 1 ) # bit                        scan in
    self.scout    = SignalOut ("scout"     , 1 ) # bit                        scan out
                                                   
    self.vdd      = VddIn     ("vdd"           ) # bit                          
    self.vss      = VssIn     ("vss"           ) # bit                          
    return


  def Netlist (self):
    carith_32_se = Signal("carith_32_se" , 1 ) # bit                          
    carith_31_se = Signal("carith_31_se" , 1 ) # bit                          
    rarith_31_se = Signal("rarith_31_se" , 1 ) # bit                          
    nextpc_0_se  = Signal("nextpc_0_se"  , 1 ) # bit                          
    nextpc_1_se  = Signal("nextpc_1_se"  , 1 ) # bit                          
    nextpc_31_se = Signal("nextpc_31_se" , 1 ) # bit                          
                                               
    res_sm       = Signal("res_sm"       , 32) # bit_vector (31 downto  0)    
                                               
    s_31_sd      = Signal("s_31_sd"      , 1 ) # bit                          s (31)
    s_eq_t_sd    = Signal("s_eq_t_sd"    , 1 ) # bit                          s =  t
    s_eq_z_sd    = Signal("s_eq_z_sd"    , 1 ) # bit                          s = 0
                                               
    s_4_0_se     = Signal("s_4_0_se"     , 5 ) # bit_vector ( 4 downto  0)    s (4 downto 0)
                                               
    rsdnbr_sd    = Signal("rsdnbr_sd"    , 32) # bit_vector (31 downto  0)    source reg nbr
    rtdnbr_sd    = Signal("rtdnbr_sd"    , 32) # bit_vector (31 downto  0)    source reg nbr
                                               
    hz_sdm_sd    = Signal("hz_sdm_sd"    , 1 ) # bit                          s = d(i-2)
    hz_sdmw_sd   = Signal("hz_sdmw_sd"   , 1 ) # bit                          s = d(i-3,i-2)
    hz_tdm_sd    = Signal("hz_tdm_sd"    , 1 ) # bit                          t = d(i-2)
    hz_tdmw_sd   = Signal("hz_tdmw_sd"   , 1 ) # bit                          t = d(i-3,i-2)
                                               
    hz_sdm_se    = Signal("hz_sdm_se"    , 1 ) # bit                          s = d(i-1)
    hz_sdmw_se   = Signal("hz_sdmw_se"   , 1 ) # bit                          s = d(i-2,i-1)
    hz_tdm_se    = Signal("hz_tdm_se"    , 1 ) # bit                          t = d(i-1)
    hz_tdmw_se   = Signal("hz_tdmw_se"   , 1 ) # bit                          t = d(i-2,i-1)
                                               
    i_jr_sd      = Signal("i_jr_sd"      , 1 ) # bit                          jump register
    btaken_sd    = Signal("btaken_sd"    , 1 ) # bit                          branch taken
    i_allj_sd    = Signal("i_allj_sd"    , 1 ) # bit                          all jumps
    i_link_sd    = Signal("i_link_sd"    , 1 ) # bit                          link inst
                                               
    iopsel_sd    = Signal("iopsel_sd"    , 4 ) # bit_vector ( 3 downto 0)     i oper select
                                               
    imdsgn_sd    = Signal("imdsgn_sd"    , 1 ) # bit                          imd sign
    i_rsgnd_se   = Signal("i_rsgnd_se"   , 1 ) # bit                          signed result
                                               
    i_ifmt_se    = Signal("i_ifmt_se"    , 1 ) # bit                          i format
    i_oper_se    = Signal("i_oper_se"    , 7 ) # bit_vector ( 6 downto 0)     alu operation
    i_logic_se   = Signal("i_logic_se"   , 2 ) # bit_vector ( 1 downto 0)     logic operation
    i_sub_se     = Signal("i_sub_se"     , 1 ) # bit                          subtract
    i_right_se   = Signal("i_right_se"   , 1 ) # bit                          shift right
                                               
    setbit_se    = Signal("setbit_se"    , 1 ) # bit                          result for set
                                               
    datext_sm    = Signal("datext_sm"    , 1 ) # bit                          data extension
    bytsub_sm    = Signal("bytsub_sm"    , 3 , 1)# bit_vector ( 3 downto 1)   byte substitute
    read_sm      = Signal("read_sm"      , 1 ) # bit                          data read
                                               
    bubble_si    = Signal("bubble_si"    , 1 ) # bit                          introduce  bubble
    hold_si      = Signal("hold_si"      , 1 ) # bit                          hold   the inst
    nothold_si   = Signal("nothold_si"   , 1 ) # bit                          don't hold the inst
    shift_si     = Signal("shift_si"     , 1 ) # bit                          shift  new inst
    keep_si      = Signal("keep_si"      , 1 ) # bit                          keep   the data
    load_si      = Signal("load_si"      , 1 ) # bit                          load a new data
                                               
    notstall_sd  = Signal("notstall_sd"  , 1 ) # bit                          don't stall the inst
    bubble_sd    = Signal("bubble_sd"    , 1 ) # bit                          introduce bubble
    hold_sd      = Signal("hold_sd"      , 1 ) # bit                          hold   the inst
    nothold_sd   = Signal("nothold_sd"   , 1 ) # bit                          don't hold the inst
    shift_sd     = Signal("shift_sd"     , 1 ) # bit                          shift  new inst
    keep_sd      = Signal("keep_sd"      , 1 ) # bit                          keep   the data
    load_sd      = Signal("load_sd"      , 1 ) # bit                          load a new data
                                               
    bubble_se    = Signal("bubble_se"    , 1 ) # bit                          introduce bubble
    hold_se      = Signal("hold_se"      , 1 ) # bit                          hold   the inst
    nothold_se   = Signal("nothold_se"   , 1 ) # bit                          don't hold the inst
    shift_se     = Signal("shift_se"     , 1 ) # bit                          shift  new inst
    keep_se      = Signal("keep_se"      , 1 ) # bit                          keep   the data
    load_se      = Signal("load_se"      , 1 ) # bit                          load a new data
                                               
    bubble_sm    = Signal("bubble_sm"    , 1 ) # bit                          introduce bubble
    hold_sm      = Signal("hold_sm"      , 1 ) # bit                          hold   the inst
    nothold_sm   = Signal("nothold_sm"   , 1 ) # bit                          don't hold the inst
    shift_sm     = Signal("shift_sm"     , 1 ) # bit                          shift  new inst
    keep_sm      = Signal("keep_sm"      , 1 ) # bit                          keep   the data
    load_sm      = Signal("load_sm"      , 1 ) # bit                          load a new data
                                               
    wreg_sw      = Signal("wreg_sw"      , 32) # bit_vector (31 downto 0)     integer reg wen
    wredopc_se   = Signal("wredopc_se"   , 1 ) # bit                          redopc write en
                                               
    wlo_sw       = Signal("wlo_sw"       , 1 ) # bit                          low reg write en
    whi_sw       = Signal("whi_sw"       , 1 ) # bit                          high reg write en
                                               
    wepc_xx      = Signal("wepc_xx"      , 1 ) # bit                          epc write en
    wepc_xm      = Signal("wepc_xm"      , 1 ) # bit                          epc write en
                                               
    bootev_xx    = Signal("bootev_xx"    , 1 ) # bit                          bootstrap exc
                                               
    badia_xm     = Signal("badia_xm"     , 1 ) # bit                          bad inst adr
    badda_xm     = Signal("badda_xm"     , 1 ) # bit                          bad data adr
                                               
    lui_sd       = Signal("lui_sd"       , 1 ) # bit                          lui inst
                                               
    shamt_se     = Signal("shamt_se"     , 5 ) # bit_vector ( 4 downto 0)     shift amount
                                               
    reset_xx     = Signal("reset_xx"     , 1 ) # bit                          synchro reset
    wnxtpc_xx    = Signal("wnxtpc_xx"    , 1 ) # bit                          nxt inst ad wen
                                               
    sr_cr_sd     = Signal("sr_cr_sd"     , 32) # bit_vector (31 downto  0)    status/cause
    be_sd        = Signal("be_sd"        , 1 ) # bit                          bad ad reg/epc
    scbe_sd      = Signal("scbe_sd"      , 1 ) # bit                          c0 reg selection
                                               
    bdslot_se    = Signal("bdslot_se"    , 1 ) # bit
    bdslot_sm    = Signal("bdslot_sm"    , 1 ) # bit
                                               
    scout_xx     = Signal("scout_xx"     , 1 ) # bit
    daccess_sm   = Signal("daccess_sm"   , 1 ) # bit
    
    self.ct = Inst( "mips_r3000_1m_ct"
                  , "mips_r3000_1m_ct"
                  , map = { 'ck'           : self.ck
    
                          , 'daccess_sm'   : daccess_sm
    
                          , 'reset_n'      : self.reset_n
                          , 'it_n'         : self.it_n
                            
                          , 'i_ftch'       : self.i_ftch
                          , 'i_ack'        : self.i_ack
                          , 'i_berr_n'     : self.i_berr_n
                          , 'i_frz'        : self.i_frz
                          , 'dout_e'       : self.dout_e
                          , 'i'            : self.i
                            
                          , 'd_rq'         : self.d_rq
                          , 'd_lock'       : self.d_lock
                          , 'd_atype'      : self.d_atype
                          , 'd_ack'        : self.d_ack
                          , 'd_berr_n'     : self.d_berr_n
                          , 'd_frz'        : self.d_frz
                            
                          , 'd_in_7'       : self.d_in [ 7]
                          , 'd_in_15'      : self.d_in [15]
                          , 'd_in_23'      : self.d_in [23]
                            
                          , 'carith_32_se' : carith_32_se
                          , 'carith_31_se' : carith_31_se
                          , 'rarith_31_se' : rarith_31_se
                          , 'nextpc_1_se'  : nextpc_1_se
                          , 'nextpc_0_se'  : nextpc_0_se
                          , 'nextpc_31_se' : nextpc_31_se
                            
                          , 'res_sm'       : res_sm
                            
                          , 's_31_sd'      : s_31_sd
                          , 's_eq_t_sd'    : s_eq_t_sd
                          , 's_eq_z_sd'    : s_eq_z_sd
                            
                          , 's_4_0_se'     : s_4_0_se
                            
                          , 'rsdnbr_sd'    : rsdnbr_sd
                          , 'rtdnbr_sd'    : rtdnbr_sd
                            
                          , 'hz_sdm_sd'    : hz_sdm_sd
                          , 'hz_sdmw_sd'   : hz_sdmw_sd
                          , 'hz_tdm_sd'    : hz_tdm_sd
                          , 'hz_tdmw_sd'   : hz_tdmw_sd
                            
                          , 'hz_sdm_se'    : hz_sdm_se
                          , 'hz_sdmw_se'   : hz_sdmw_se
                          , 'hz_tdm_se'    : hz_tdm_se
                          , 'hz_tdmw_se'   : hz_tdmw_se
                            
                          , 'i_jr_sd'      : i_jr_sd
                          , 'btaken_sd'    : btaken_sd
                          , 'i_allj_sd'    : i_allj_sd
                          , 'i_link_sd'    : i_link_sd
                            
                          , 'iopsel_sd'    : iopsel_sd
                            
                          , 'imdsgn_sd'    : imdsgn_sd
                          , 'i_rsgnd_se'   : i_rsgnd_se
                            
                          , 'i_ifmt_se'    : i_ifmt_se
                          , 'i_oper_se'    : i_oper_se
                          , 'i_logic_se'   : i_logic_se
                          , 'i_sub_se'     : i_sub_se
                          , 'i_right_se'   : i_right_se
                            
                          , 'setbit_se'    : setbit_se
                            
                          , 'datext_sm'    : datext_sm
                          , 'bytsub_sm'    : bytsub_sm
                          , 'read_sm'      : read_sm
                            
                          , 'bubble_si'    : bubble_si
                          , 'hold_si'      : hold_si
                          , 'nothold_si'   : nothold_si
                          , 'shift_si'     : shift_si
                          , 'keep_si'      : keep_si
                          , 'load_si'      : load_si
                            
                          , 'notstall_sd'  : notstall_sd
                          , 'bubble_sd'    : bubble_sd
                          , 'hold_sd'      : hold_sd
                          , 'nothold_sd'   : nothold_sd
                          , 'shift_sd'     : shift_sd
                          , 'keep_sd'      : keep_sd
                          , 'load_sd'      : load_sd
                            
                          , 'bubble_se'    : bubble_se
                          , 'hold_se'      : hold_se
                          , 'nothold_se'   : nothold_se
                          , 'shift_se'     : shift_se
                          , 'keep_se'      : keep_se
                          , 'load_se'      : load_se
                            
                          , 'bubble_sm'    : bubble_sm
                          , 'hold_sm'      : hold_sm
                          , 'nothold_sm'   : nothold_sm
                          , 'shift_sm'     : shift_sm
                          , 'keep_sm'      : keep_sm
                          , 'load_sm'      : load_sm
                            
                          , 'wreg_sw'      : wreg_sw
                          , 'wredopc_se'   : wredopc_se
                            
                          , 'wlo_sw'       : wlo_sw
                          , 'whi_sw'       : whi_sw
                            
                          , 'wepc_xx'      : wepc_xx
                          , 'wepc_xm'      : wepc_xm
                            
                          , 'bootev_xx'    : bootev_xx
                            
                          , 'badia_xm'     : badia_xm
                          , 'badda_xm'     : badda_xm
                            
                          , 'lui_sd'       : lui_sd
                            
                          , 'shamt_se'     : shamt_se
                            
                          , 'reset_xx'     : reset_xx
                          , 'wnxtpc_xx'    : wnxtpc_xx
                            
                          , 'sr_cr_sd'     : sr_cr_sd
                          , 'be_sd'        : be_sd
                          , 'scbe_sd'      : scbe_sd
                            
                          , 'bdslot_se'    : bdslot_se
                          , 'bdslot_sm'    : bdslot_sm
                            
                          , 'test'         : self.test
                          , 'scin'         : self.scin
                          , 'scout'        : scout_xx
                            
                          , 'vdd'          : self.vdd
                          , 'vss'          : self.vss
                          } )
           
    
    self.dp = Inst( "mips_r3000_1m_dp"
                  , "mips_r3000_1m_dp"
                  , map = { 'ck'          : self.ck
                         #, 'i_a'         : self.i_a
                          , 'i'           : self.i
    
                         #, 'd_a'         : self.d_a
                          , 'addr'        : self.addr
                          , 'daccess_sm'  : daccess_sm
                          , 'd_in'        : self.d_in
                          , 'd_out'       : self.d_out
                            
                          , 'rsdnbr_sd'   : rsdnbr_sd
                          , 'rtdnbr_sd'   : rtdnbr_sd
                            
                          , 'hz_sdm_sd'   : hz_sdm_sd
                          , 'hz_sdmw_sd'  : hz_sdmw_sd
                          , 'hz_tdm_sd'   : hz_tdm_sd
                          , 'hz_tdmw_sd'  : hz_tdmw_sd
                            
                          , 'hz_sdm_se'   : hz_sdm_se
                          , 'hz_sdmw_se'  : hz_sdmw_se
                          , 'hz_tdm_se'   : hz_tdm_se
                          , 'hz_tdmw_se'  : hz_tdmw_se
                            
                          , 'i_jr_sd'     : i_jr_sd
                          , 'btaken_sd'   : btaken_sd
                          , 'i_allj_sd'   : i_allj_sd
                          , 'i_link_sd'   : i_link_sd
                            
                          , 'iopsel_sd'   : iopsel_sd
                            
                          , 'imdsgn_sd'   : imdsgn_sd
                          , 'i_rsgnd_se'  : i_rsgnd_se
                            
                          , 'i_ifmt_se'   : i_ifmt_se
                          , 'i_oper_se'   : i_oper_se
                          , 'i_logic_se'  : i_logic_se
                          , 'i_sub_se'    : i_sub_se
                          , 'i_right_se'  : i_right_se
                            
                          , 'setbit_se'   : setbit_se
                            
                          , 'datext_sm'   : datext_sm
                          , 'bytsub_sm'   : bytsub_sm
                          , 'read_sm'     : read_sm
                            
                          , 'bubble_si'   : bubble_si
                          , 'hold_si'     : hold_si
                          , 'nothold_si'  : nothold_si
                          , 'shift_si'    : shift_si
                          , 'keep_si'     : keep_si
                          , 'load_si'     : load_si
                            
                          , 'notstall_sd' : notstall_sd
                          , 'bubble_sd'   : bubble_sd
                          , 'hold_sd'     : hold_sd
                          , 'nothold_sd'  : nothold_sd
                          , 'shift_sd'    : shift_sd
                          , 'keep_sd'     : keep_sd
                          , 'load_sd'     : load_sd
                            
                          , 'bubble_se'   : bubble_se
                          , 'hold_se'     : hold_se
                          , 'nothold_se'  : nothold_se
                          , 'shift_se'    : shift_se
                          , 'keep_se'     : keep_se
                          , 'load_se'     : load_se
                            
                          , 'bubble_sm'   : bubble_sm
                          , 'hold_sm'     : hold_sm
                          , 'nothold_sm'  : nothold_sm
                          , 'shift_sm'    : shift_sm
                          , 'keep_sm'     : keep_sm
                          , 'load_sm'     : load_sm
                            
                          , 'wreg_sw'     : wreg_sw
                          , 'wredopc_se'  : wredopc_se
                            
                          , 'wlo_sw'      : wlo_sw
                          , 'whi_sw'      : whi_sw
                            
                          , 'wepc_xx'     : wepc_xx
                          , 'wepc_xm'     : wepc_xm
                            
                          , 'bootev_xx'   : bootev_xx
                            
                          , 'badia_xm'    : badia_xm
                          , 'badda_xm'    : badda_xm
                            
                          , 'lui_sd'      : lui_sd
                            
                          , 'shamt_se'    : shamt_se
                            
                          , 'reset_xx'    : reset_xx
                          , 'wnxtpc_xx'   : wnxtpc_xx
                            
                          , 'sr_cr_sd'    : sr_cr_sd
                          , 'be_sd'       : be_sd
                          , 'scbe_sd'     : scbe_sd
                            
                          , 'bdslot_se'   : bdslot_se
                          , 'bdslot_sm'   : bdslot_sm
                            
                          , 'carith_32_se': carith_32_se
                          , 'carith_31_se': carith_31_se
                          , 'rarith_31_se': rarith_31_se
                          , 'nextpc_1_se' : nextpc_1_se
                          , 'nextpc_0_se' : nextpc_0_se
                          , 'nextpc_31_se': nextpc_31_se
                            
                          , 'res_sm'      : res_sm
                            
                          , 's_31_sd'     : s_31_sd
                          , 's_eq_t_sd'   : s_eq_t_sd
                          , 's_eq_z_sd'   : s_eq_z_sd
                            
                          , 's_4_0_se'    : s_4_0_se
                            
                          , 'test'        : self.test
                          , 'scin'        : scout_xx
                          , 'scout'       : self.scout
                            
                          , 'vdd'         : self.vdd
                          , 'vss'         : self.vss
                          } )
    
           
    ctlModel = SetCurrentModel( self.ct )
    ckbuff   = ClockBuffer ( 'ck' )
    for i in range(32): 
      ckbuff.AddFF( 'cause_rx(%d)'%i )
    
    ckbuff = ClockBuffer( 'ck' )
    for i in range (5): 
      ckbuff.AddFF( 'cop0d_rd(%d)'%i )
      ckbuff.AddFF( 'cop0d_re(%d)'%i )
      
    ctlModel.Save( LOGICAL )
    return

         
  def Layout (self):
    Place (self.dp, NOSYM, XY(0,0))
    ResizeAb(0, 0, 0, 450 )
   # Obsoleted.
   #self.View()
   #AlimVerticalRail ( 254 )
   #AlimVerticalRail ( 381 )
   #AlimVerticalRail ( 677 )
   #AlimVerticalRail ( 921 )
   #AlimVerticalRail ( 1128 )
   #AlimVerticalRail ( 1301 )
   #self.View()
   #for i in range ( 6 ) :
   #  AlimHorizontalRail ( 1 + i * 10 )
   #  AlimHorizontalRail ( 4 + i * 10 )
   #AlimConnectors()
    return
