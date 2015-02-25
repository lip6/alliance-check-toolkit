#!/usr/bin/env python

from placeandroute import *
from stratus       import *


class amd2901_chip ( Model ) :

  def Interface ( self ) :
    self.ck      = CkIn           ( "ck"   )
    self.cin     = SignalUnknown  ( "cin"  , 1 )
    self.cout    = SignalUnknown  ( "cout" , 1 )
    self.np      = SignalOut      ( "np"   , 1 )
    self.ng      = SignalOut      ( "ng"   , 1 )
    self.ovr     = SignalOut      ( "ovr"  , 1 )
    self.zero    = SignalOut      ( "zero" , 1 )
    self.signe   = SignalUnknown  ( "signe", 1 )
    self.r0      = SignalUnknown  ( "r0"   , 1 )
    self.r3      = SignalUnknown  ( "r3"   , 1 )
    self.q0      = SignalUnknown  ( "q0"   , 1 )
    self.q3      = SignalUnknown  ( "q3"   , 1 )
    self.a       = SignalIn       ( "a"    , 4 )
    self.b       = SignalIn       ( "b"    , 4 )
    self.d       = SignalIn       ( "d"    , 4 )
    self.i       = SignalIn       ( "i"    , 9 )
    self.noe     = SignalIn       ( "noe"  , 1 )
    self.y       = SignalUnknown  ( "y"    , 4 )
    
    self.vdde    = VddIn          ( "vdde" )
    self.vsse    = VssIn          ( "vsse" )
    self.vdd     = SignalVdd      ( "vddi" )
    self.vss     = SignalVss      ( "vssi" )
    return


  def Netlist ( self ) :
    cin_i      = Signal   ( "cin_i"     , 1 )
    cout_i     = Signal   ( "cout_i"    , 1 )
    np_i       = Signal   ( "np_i"      , 1 )
    ng_i       = Signal   ( "ng_i"      , 1 )
    ovr_i      = Signal   ( "ovr_i"     , 1 )
    zero_i     = Signal   ( "zero_i"    , 1 )
    sh_right   = Signal   ( "sh_right"  , 1 )
    sh_left    = Signal   ( "sh_left"   , 1 )
    ram_o_down = Signal   ( "ram_o_down", 1 )
    ram_o_up   = Signal   ( "ram_o_up"  , 1 )
    ram_i_down = Signal   ( "ram_i_down", 1 )
    ram_i_up   = Signal   ( "ram_i_up"  , 1 )
    acc_o_down = Signal   ( "acc_o_down", 1 )
    acc_o_up   = Signal   ( "acc_o_up"  , 1 )
    acc_i_down = Signal   ( "acc_i_down", 1 )
    acc_i_up   = Signal   ( "acc_i_up"  , 1 )
    a_i        = Signal   ( "a_i"       , 4 )
    b_i        = Signal   ( "b_i"       , 4 )
    d_i        = Signal   ( "d_i"       , 4 )
    i_i        = Signal   ( "i_i"       , 9 )
    y_i        = Signal   ( "y_i"       , 4 )
    noe_i      = Signal   ( "noe_i"     , 1 )
    oe         = Signal   ( "oe"        , 1 )
    cki        = SignalCk ( "cki" )
    self.ckc   = SignalCk ( "ckc" )

    
    self.core = Inst ( "amd2901_core"
                     , "core"
                     , map = { 'cin'        : cin_i
                             , 'cout'       : cout_i
                             , 'np'         : np_i
                             , 'ng'         : ng_i
                             , 'over'       : ovr_i
                             , 'zero'       : zero_i
                             , 'sh_right'   : sh_right
                             , 'sh_left'    : sh_left
                             , 'ram_o_down' : ram_o_down
                             , 'ram_o_up'   : ram_o_up
                             , 'ram_i_down' : ram_i_down
                             , 'ram_i_up'   : ram_i_up
                             , 'acc_o_down' : acc_o_down
                             , 'acc_o_up'   : acc_o_up
                             , 'acc_i_down' : acc_i_down
                             , 'acc_i_up'   : acc_i_up
                             , 'ck'         : self.ckc
                             , 'a'          : a_i
                             , 'b'          : b_i
                             , 'd'          : d_i
                             , 'i'          : i_i
                             , 'y'          : y_i
                             , 'noe'        : noe_i
                             , 'oe'         : oe
                             , 'vdd'        : self.vdd
                             , 'vss'        : self.vss
                             }
                     )
    
    self.p_ck = Inst ( "pck_px", "p_ck"
                     , map = { 'pad'  : self.ck
                             , 'ck'   : cki
                             , 'vddi' : self.vdd
                             , 'vssi' : self.vss
                             , 'vdde' : self.vdde
                             , 'vsse' : self.vsse
                             }
                     )
    
    self.p_cin = Inst ( "pi_px", "p_cin"
                      , map = { 'pad'  : self.cin
                              , 't'    : cin_i
                              , 'ck'   : cki
                              , 'vddi' : self.vdd
                              , 'vssi' : self.vss
                              , 'vdde' : self.vdde
                              , 'vsse' : self.vsse
                              }
                      )
    
    self.p_noe = Inst ( "pi_px", "p_noe"
                      , map = { 'pad'  : self.noe
                              , 't'    : noe_i
                              , 'ck'   : cki
                              , 'vddi' : self.vdd
                              , 'vssi' : self.vss
                              , 'vdde' : self.vdde
                              , 'vsse' : self.vsse
                              }
                      )
   
    self.p_a = {} 
    self.p_b = {} 
    self.p_d = {} 
    for i in range ( 4 ) :
      self.p_a[i] = Inst ( "pi_px", "p_a%d" % i
                         , map = { 'pad'  : self.a[i]
                                 , 't'    : a_i[i]
                                 , 'ck'   : cki
                                 , 'vddi' : self.vdd
                                 , 'vssi' : self.vss
                                 , 'vdde' : self.vdde
                                 , 'vsse' : self.vsse
                                 }
                         )
      self.p_b[i] = Inst ( "pi_px", "p_b%d" % i
                         , map = { 'pad'  : self.b[i]
                                 , 't'    : b_i[i]
                                 , 'ck'   : cki
                                 , 'vddi' : self.vdd
                                 , 'vssi' : self.vss
                                 , 'vdde' : self.vdde
                                 , 'vsse' : self.vsse
                                 }
                         )
      self.p_d[i] = Inst ( "pi_px", "p_d%d" % i
                         , map = { 'pad'  : self.d[i]
                                 , 't'    : d_i[i]
                                 , 'ck'   : cki
                                 , 'vddi' : self.vdd
                                 , 'vssi' : self.vss
                                 , 'vdde' : self.vdde
                                 , 'vsse' : self.vsse
                                 }
                         )
    
    self.p_i = {}
    for i in range ( 9 ) :
      self.p_i[i] = Inst ( "pi_px", "p_i%d" % i
                         , map = { 'pad'  : self.i[i]
                                 , 't'    : i_i[i]
                                 , 'ck'   : cki
                                 , 'vddi' : self.vdd
                                 , 'vssi' : self.vss
                                 , 'vdde' : self.vdde
                                 , 'vsse' : self.vsse
                                 }
                         )
    
    self.p_cout = Inst ( "po_px", "p_cout"
                       , map = { 'i'    : cout_i
                               , 'pad'  : self.cout
                               , 'ck'   : cki
                               , 'vddi' : self.vdd
                               , 'vssi' : self.vss
                               , 'vdde' : self.vdde
                               , 'vsse' : self.vsse
                               }
                       )
    
    self.p_np = Inst ( "po_px", "p_np"
                     , map = { 'i'    : np_i
                             , 'pad'  : self.np
                             , 'ck'   : cki
                             , 'vddi' : self.vdd
                             , 'vssi' : self.vss
                             , 'vdde' : self.vdde
                             , 'vsse' : self.vsse
                             }
                     )
    
    self.p_ng = Inst ( "po_px", "p_ng"
                     , map = { 'i'    : ng_i
                             , 'pad'  : self.ng
                             , 'ck'   : cki
                             , 'vddi' : self.vdd
                             , 'vssi' : self.vss
                             , 'vdde' : self.vdde
                             , 'vsse' : self.vsse
                             }
                     )
    
    self.p_ovr = Inst ( "po_px", "p_ovr"
                      , map = { 'i'    : ovr_i
                              , 'pad'  : self.ovr
                              , 'ck'   : cki
                              , 'vddi' : self.vdd
                              , 'vssi' : self.vss
                              , 'vdde' : self.vdde
                              , 'vsse' : self.vsse
                              }
                      )
    
    self.p_zero = Inst ( "po_px", "p_zero"
                       , map = { 'i'    : zero_i
                               , 'pad'  : self.zero
                               , 'ck'   : cki
                               , 'vddi' : self.vdd
                               , 'vssi' : self.vss
                               , 'vdde' : self.vdde
                               , 'vsse' : self.vsse
                               }
                       )
    
    self.p_signe = Inst ( "po_px", "p_signe"
                        , map = { 'i'    : ram_o_up
                                , 'pad'  : self.signe
                                , 'ck'   : cki
                                , 'vddi' : self.vdd
                                , 'vssi' : self.vss
                                 , 'vdde' : self.vdde
                                 , 'vsse' : self.vsse
                                 }
                        )
    
    self.p_y = {}
    for i in range ( 4 ) :
      self.p_y[i] = Inst ( "pot_px", "p_y%d" % i
                         , map = { 'i'    : y_i[i]
                                 , 'b'    : oe
                                 , 'pad'  : self.y[i]
                                 , 'ck'   : cki
                                 , 'vddi' : self.vdd
                                 , 'vssi' : self.vss
                                 , 'vdde' : self.vdde
                                 , 'vsse' : self.vsse
                                 }
                         )
    
    self.p_q0 = Inst ( "piot_px", "p_q0"
                     , map = { 'i'    : acc_o_down
                             , 'b'    : sh_right
                             , 't'    : acc_i_down
                             , 'pad'  : self.q0
                             , 'ck'   : cki
                             , 'vddi' : self.vdd
                             , 'vssi' : self.vss
                             , 'vdde' : self.vdde
                             , 'vsse' : self.vsse
                             }
                     )
    
    self.p_q3 = Inst ( "piot_px", "p_q3"
                     , map = { 'i'    : acc_o_up
                             , 'b'    : sh_left
                             , 't'    : acc_i_up
                             , 'pad'  : self.q3
                             , 'ck'   : cki
                             , 'vddi' : self.vdd
                             , 'vssi' : self.vss
                             , 'vdde' : self.vdde
                             , 'vsse' : self.vsse
                             }
                     )
    
    self.p_r0 = Inst ( "piot_px", "p_r0"
                     , map = { 'i'    : ram_o_down
                             , 'b'    : sh_right
                             , 't'    : ram_i_down
                             , 'pad'  : self.r0
                             , 'ck'   : cki
                             , 'vddi' : self.vdd
                             , 'vssi' : self.vss
                             , 'vdde' : self.vdde
                             , 'vsse' : self.vsse 
                             }
                     )
    
    self.p_r3 = Inst ( "piot_px", "p_r3"
                     , map = { 'i'    : ram_o_up
                             , 'b'    : sh_left
                             , 't'    : ram_i_up
                             , 'pad'  : self.r3
                             , 'ck'   : cki
                             , 'vddi' : self.vdd
                             , 'vssi' : self.vss
                             , 'vdde' : self.vdde
                             , 'vsse' : self.vsse
                             }
                     )
    
    self.p_vddick0 = Inst ( "pvddick_px", "p_vddick0"
                          , map = { 'cko'  : self.ckc
                                  , 'ck'   : cki
                                  , 'vddi' : self.vdd
                                  , 'vssi' : self.vss
                                  , 'vdde' : self.vdde
                                  , 'vsse' : self.vsse
                                  }
                          )
    
    self.p_vssick0 = Inst ( "pvssick_px", "p_vssick0"
                          , map = { 'cko'  : self.ckc
                                  , 'ck'   : cki
                                  , 'vddi' : self.vdd
                                  , 'vssi' : self.vss
                                  , 'vdde' : self.vdde
                                  , 'vsse' : self.vsse 
                                  }
                          )
    
    self.p_vddeck0 = Inst ( "pvddeck_px", "p_vddeck0"
                          , map = { 'cko'  : self.ckc
                                  , 'ck'   : cki
                                  , 'vddi' : self.vdd
                                  , 'vssi' : self.vss
                                  , 'vdde' : self.vdde
                                  , 'vsse' : self.vsse
                                  }
                          )
    
    self.p_vddeck1 = Inst ( "pvddeck_px", "p_vddeck1"
                          , map = { 'cko'  : self.ckc
                                  , 'ck'   : cki
                                  , 'vddi' : self.vdd
                                  , 'vssi' : self.vss
                                  , 'vdde' : self.vdde
                                  , 'vsse' : self.vsse 
                                  }
                          )
    
    self.p_vsseck0 = Inst ( "pvsseck_px", "p_vsseck0"
                          , map = { 'cko'  : self.ckc
                                  , 'ck'   : cki
                                  , 'vddi' : self.vdd
                                  , 'vssi' : self.vss
                                   , 'vdde' : self.vdde
                                   , 'vsse' : self.vsse 
                                   }
                          )
    
    self.p_vsseck1 = Inst ( "pvsseck_px", "p_vsseck1"
                          , map = { 'cko'  : self.ckc
                                  , 'ck'   : cki
                                  , 'vddi' : self.vdd
                                  , 'vssi' : self.vss
                                  , 'vdde' : self.vdde
                                  , 'vsse' : self.vsse 
                                  }
                          )
    return
