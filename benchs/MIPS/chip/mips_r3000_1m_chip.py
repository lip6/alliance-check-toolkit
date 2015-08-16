#!/usr/bin/env python

from stratus import *

class mips_r3000_1m_chip ( Model ) :

 def Interface ( self ) :

  self.ck       = SignalCk  ( "ck"          ) #bit                          ;-- external clock
  self.reset_n  = SignalIn  ( "reset_n" , 1 ) #bit                          ;-- external reset
  self.it_n     = SignalIn  ( "it_n"    , 6 ) #bit_vector (  5 downto 0)    ;-- hw interrupts
                                      
  self.i_ftch   = SignalOut ( "i_ftch"  , 1 ) #bit                          ;-- inst fetch
  self.i_ack    = SignalOut ( "i_ack"   , 1 ) #bit                          ;-- inst fetch ack
  self.i_berr_n = SignalIn  ( "i_berr_n", 1 ) #bit                          ;-- inst bus error
  self.i_frz    = SignalIn  ( "i_frz"   , 1 ) #bit                          ;-- inst cache busy
                                      
  self.d_rq     = SignalOut ( "d_rq"    , 1 ) #bit                          ;-- data request
  self.d_lock   = SignalOut ( "d_lock"  , 1 ) #bit                          ;-- locked access
  self.d_atype  = SignalOut ( "d_atype" , 2 ) #bit_vector (  1 downto 0)    ;-- access type
  self.d_ack    = SignalOut ( "d_ack"   , 1 ) #bit                          ;-- data fetch ack
  self.d_berr_n = SignalIn  ( "d_berr_n", 1 ) #bit                          ;-- data bus error
  self.d_frz    = SignalIn  ( "d_frz"   , 1 ) #bit                          ;-- data cache busy

  self.addr     = SignalOut ( "addr"    , 32) #bit_vector ( 31 downto 0)    ;-- 
  self.data     = SignalInOut ( "data"  , 32) #bit_vector ( 31 downto 0)    ;-- 
                                      
  self.test     = SignalIn  ( "test"    , 1 ) #bit                          ;-- test mode
  self.scin     = SignalIn  ( "scin"    , 1 ) #bit                          ;-- scan in
  self.scout    = SignalOut ( "scout"   , 1 ) #bit                          ;-- scan out
                                      
  self.vdd      = VddIn     ( "vdd"         ) #bit                          ;--
  self.vss      = VssIn     ( "vss"         ) #bit                          ;--
  self.vdde     = VddIn     ( "vdde"        ) #bit                          ;--
  self.vsse     = VssIn     ( "vsse"        ) #bit
  

 def Netlist ( self ) :

  cki          = SignalCk ( "cki"         ) #bit                          ;-- external clock
  self.ckc     = SignalCk ( "cko"         ) #bit                          ;-- core clock
  reset_n_i    = Signal ( "reset_n_i" , 1 ) #bit                          ;-- external reset
  it_n_i       = Signal ( "it_n_i"    , 6 ) #bit_vector (  5 downto 0)    ;-- hw interrupts
  i_ftch_i     = Signal ( "i_ftch_i"  , 1 ) #bit                          ;-- inst fetch
  i_ack_i      = Signal ( "i_ack_i"   , 1 ) #bit                          ;-- inst fetch ack
  i_berr_n_i   = Signal ( "i_berr_n_i", 1 ) #bit                          ;-- inst bus error
  i_frz_i      = Signal ( "i_frz_i"   , 1 ) #bit                          ;-- inst cache busy
  i_i          = Signal ( "i_i"       , 32) #bit_vector ( 31 downto 0)    ;-- instruction
  d_rq_i       = Signal ( "d_rq_i"    , 1 ) #bit                          ;-- data request
  d_lock_i     = Signal ( "d_lock_i"  , 1 ) #bit                          ;-- locked access
  d_atype_i    = Signal ( "d_atype_i" , 2 ) #bit_vector (  1 downto 0)    ;-- access type
  d_ack_i      = Signal ( "d_ack_i"   , 1 ) #bit                          ;-- data fetch ack
  d_berr_n_i   = Signal ( "d_berr_n_i", 1 ) #bit                          ;-- data bus error
  d_frz_i      = Signal ( "d_frz_i"   , 1 ) #bit                          ;-- data cache busy
  C_DTOCORE_i  = Signal ( "d_in_i"    , 32) #bit_vector ( 31 downto 0)    ;-- data (input )
  C_DFRCORE_i  = Signal ( "d_out_i"   , 32) #bit_vector ( 31 downto 0)    ;-- data (output)
  C_DOUT_E_i   = Signal ( "dout_e_i"   , 4) #bit_vector ( 3 downto 0)     ;-- 
  C_ADDR_i     = Signal ( "addr_i"    , 32) #bit_vector ( 31 downto 0)    ;-- 
  C_TEST_i     = Signal ( "test_i"    , 1 ) #bit                          ;-- test mode
  C_SCIN_i     = Signal ( "scin_i"    , 1 ) #bit                          ;-- scan in
  C_SCOUT_i    = Signal ( "scout_i"   , 1 ) #bit                          ;-- scan out
                                
  self.mips_r3000_core = Inst ( "mips_r3000_1m_core"
                              , "mips_r3000_core"
                              , map = { 'ck'       : self.ckc       
                                      , 'reset_n'  : reset_n_i  
                                      , 'it_n'     : it_n_i     
                                      , 'i_ftch'   : i_ftch_i   
                                      , 'i_ack'    : i_ack_i    
                                      , 'i_berr_n' : i_berr_n_i 
                                      , 'i_frz'    : i_frz_i    
                                      , 'i'        : i_i        
                                      , 'd_rq'     : d_rq_i     
                                      , 'd_lock'   : d_lock_i   
                                      , 'd_atype'  : d_atype_i  
                                      , 'd_ack'    : d_ack_i    
                                      , 'd_berr_n' : d_berr_n_i 
                                      , 'd_frz'    : d_frz_i    
                                      , 'd_in'     : C_DTOCORE_i     
                                      , 'd_out'    : C_DFRCORE_i     
                                      , 'dout_e'   : C_DOUT_E_i
                                      , 'addr'     : C_ADDR_i
                                      , 'test'     : C_TEST_i     
                                      , 'scin'     : C_SCIN_i     
                                      , 'scout'    : C_SCOUT_i    
                                      , 'vdd'      : self.vdd
                                      , 'vss'      : self.vss
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
  self.p_reset_n = Inst ( "pi_px", "p_reset_n"
                        , map = { 'pad'  : self.reset_n
                                , 't'    : reset_n_i
                                , 'ck'   : cki
                                , 'vddi' : self.vdd
                                , 'vssi' : self.vss
                                , 'vdde' : self.vdde
                                , 'vsse' : self.vsse
                                }
                        )

  self.p_it_n = {} ## initialisation d'un dictionnaire
  for i in range ( 0,6 ) : ## Pour i allant de 0 (inclu) a 6 (exclu) : 0,1,2,3,4,5
    self.p_it_n[i] = Inst ( "pi_px", "p_it_n%d"%i
                          , map = { 'pad'  : self.it_n[i]
                                  , 't'    : it_n_i[i]
                                  , 'ck'   : cki
                                  , 'vddi' : self.vdd
                                  , 'vssi' : self.vss
                                  , 'vdde' : self.vdde
                                  , 'vsse' : self.vsse
                                  }
                          )

  self.p_i_ftch = Inst ( "po_px", "p_i_ftch"
                       , map = { 'pad'  : self.i_ftch
                               , 'i'    : i_ftch_i
                               , 'ck'   : cki
                               , 'vddi' : self.vdd
                               , 'vssi' : self.vss
                               , 'vdde' : self.vdde
                               , 'vsse' : self.vsse
                               }
                       )
  
  self.p_i_ack = Inst ( "po_px", "p_i_ack"
                      , map = { 'pad'  : self.i_ack
                              , 'i'    : i_ack_i
                              , 'ck'   : cki
                              , 'vddi' : self.vdd
                              , 'vssi' : self.vss
                              , 'vdde' : self.vdde
                              , 'vsse' : self.vsse
                              }
                      )

  self.p_i_berr_n = Inst ( "pi_px", "p_i_berr_n"
                         , map = { 'pad'  : self.i_berr_n
                                 , 't'    : i_berr_n_i
                                 , 'ck'   : cki
                                 , 'vddi' : self.vdd
                                 , 'vssi' : self.vss
                                 , 'vdde' : self.vdde
                                 , 'vsse' : self.vsse
                                 }
                         )
  
  self.p_i_frz = Inst ( "pi_px", "p_i_frz"
                      , map = { 'pad'  : self.i_frz
                              , 't'    : i_frz_i
                              , 'ck'   : cki
                              , 'vddi' : self.vdd
                              , 'vssi' : self.vss
                              , 'vdde' : self.vdde
                              , 'vsse' : self.vsse
                              }
                      )



  self.p_d_rq = Inst ( "po_px", "p_d_rq"
                     , map = { 'pad'  : self.d_rq
                             , 'i'    : d_rq_i
                             , 'ck'   : cki
                             , 'vddi' : self.vdd
                             , 'vssi' : self.vss
                             , 'vdde' : self.vdde
                             , 'vsse' : self.vsse
                             }
                     )
  self.p_d_lock = Inst ( "po_px", "p_d_lock"
                       , map = { 'pad'  : self.d_lock
                               , 'i'    : d_lock_i
                               , 'ck'   : cki
                               , 'vddi' : self.vdd
                               , 'vssi' : self.vss
                               , 'vdde' : self.vdde
                               , 'vsse' : self.vsse
                               }
                       )
  self.p_d_atype1 = Inst ( "po_px", "p_d_atype1"
                         , map = { 'pad'  : self.d_atype[1]
                                 , 'i'    : d_atype_i[1]
                                 , 'ck'   : cki
                                 , 'vddi' : self.vdd
                                 , 'vssi' : self.vss
                                 , 'vdde' : self.vdde
                                 , 'vsse' : self.vsse
                                 }
                         )
  self.p_d_atype0 = Inst ( "po_px", "p_d_atype0"
                         , map = { 'pad'  : self.d_atype[0]
                                 , 'i'    : d_atype_i[0]
                                 , 'ck'   : cki
                                 , 'vddi' : self.vdd
                                 , 'vssi' : self.vss
                                 , 'vdde' : self.vdde
                                 , 'vsse' : self.vsse
                                 }
                         )
  self.p_d_ack = Inst ( "po_px", "p_d_ack"
                      , map = { 'pad'  : self.d_ack
                              , 'i'    : d_ack_i
                              , 'ck'   : cki
                              , 'vddi' : self.vdd
                              , 'vssi' : self.vss
                              , 'vdde' : self.vdde
                              , 'vsse' : self.vsse
                              }
                      )
  self.p_d_berr_n = Inst ( "pi_px", "p_d_berr_n"
                         , map = { 'pad'  : self.d_berr_n
                                 , 't'    : d_berr_n_i
                                 , 'ck'   : cki
                                 , 'vddi' : self.vdd
                                 , 'vssi' : self.vss
                                 , 'vdde' : self.vdde
                                 , 'vsse' : self.vsse
                                 }
                          )
  self.p_d_frz = Inst ( "pi_px", "p_d_frz"
                      , map = { 'pad'  : self.d_frz
                              , 't'    : d_frz_i
                              , 'ck'   : cki
                              , 'vddi' : self.vdd
                              , 'vssi' : self.vss
                              , 'vdde' : self.vdde
                              , 'vsse' : self.vsse
                              }
                      )

  self.p_test = Inst ( "pi_px", "p_test"
                     , map = { 'pad'  : self.test
                             , 't'    : C_TEST_i
                             , 'ck'   : cki
                             , 'vddi' : self.vdd
                             , 'vssi' : self.vss
                             , 'vdde' : self.vdde
                             , 'vsse' : self.vsse
                             }
                     )
  self.p_scin = Inst ( "pi_px", "p_scin"
                     , map = { 'pad'  : self.scin
                             , 't'    : C_SCIN_i
                             , 'ck'   : cki
                             , 'vddi' : self.vdd
                             , 'vssi' : self.vss
                             , 'vdde' : self.vdde
                             , 'vsse' : self.vsse
                             }
                     )
  self.p_scout = Inst ( "po_px", "p_scout"
                      , map = { 'pad'  : self.scout
                              , 'i'    : C_SCOUT_i
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
  self.p_vsseck0 = Inst ( "pvsseck_px", "p_vsseck0"
                        , map = { 'cko' : self.ckc
                                , 'ck'   : cki
                                , 'vddi' : self.vdd
                                , 'vssi' : self.vss
                                , 'vdde' : self.vdde
                                , 'vsse' : self.vsse
                                }
                        )

  self.p_vddick1 = Inst ( "pvddick_px", "p_vddick1"
                        , map = { 'cko'  : self.ckc
                                , 'ck'   : cki
                                , 'vddi' : self.vdd
                                , 'vssi' : self.vss
                                , 'vdde' : self.vdde
                                , 'vsse' : self.vsse
                                }
                        )
  self.p_vssick1 = Inst ( "pvssick_px", "p_vssick1"
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
  self.p_vsseck1 = Inst ( "pvsseck_px", "p_vsseck1"
                        , map = { 'cko' : self.ckc
                                , 'ck'   : cki
                                , 'vddi' : self.vdd
                                , 'vssi' : self.vss
                                , 'vdde' : self.vdde
                                , 'vsse' : self.vsse
                                }
                        )

  self.p_i_addr = {}
  for i in range ( 0,32 ) :
    self.p_i_addr[i] = Inst ( "po_px", "p_i_addr%d"%i
                         , map = { 'pad'  : self.addr[i]
                                 , 'i'    : C_ADDR_i[i]
                                 , 'ck'   : cki
                                 , 'vddi' : self.vdd
                                 , 'vssi' : self.vss
                                 , 'vdde' : self.vdde
                                 , 'vsse' : self.vsse
                                 }
                         )

  self.p_i_data = {}
  j = 0
  for i in range ( 0,32 ) :
    self.p_i_data[i] = Inst ( "piot_px", "p_iot_data%d" %i
                            , map = { "i"   : C_DFRCORE_i[i]
                                    , "b"   : C_DOUT_E_i[j]
                                    , "t"   : C_DTOCORE_i[i]
                                    , "pad" : self.data[i]
                                    , "ck"  : cki	
                                    , 'vddi' : self.vdd
                                    , 'vssi' : self.vss
                                    , 'vdde' : self.vdde
                                    , 'vsse' : self.vsse
                                    }
                            )
    if (i % 8) == 7 : j+=1

#def Layout ( self ) :
#
# DefAb ( XY(0, 0), XY(8200, 4850) )
#   
# PlaceCentric (self.mips_r3000_core )
# self.View()
#
# PadEast  ( self.p_i_data[8] , self.p_i_data[9] , self.p_i_data[10], self.p_i_data[11], self.p_i_data[12], self.p_i_data[13]
#          , self.p_i_data[14], self.p_i_data[15], self.p_i_data[16], self.p_i_data[17], self.p_i_data[18], self.p_i_data[19]
#          , self.p_i_data[20], self.p_i_data[21], self.p_vddeck0   , self.p_vsseck0   , self.p_i_data[22], self.p_i_data[23]
#          )
#                            
# PadWest  ( self.p_i_addr[8] , self.p_i_addr[9] , self.p_i_addr[10], self.p_i_addr[11], self.p_i_addr[12], self.p_i_addr[13]
#          , self.p_i_addr[14], self.p_i_addr[15], self.p_i_addr[16], self.p_i_addr[17], self.p_i_addr[18], self.p_i_addr[19]
#          , self.p_i_addr[20], self.p_i_addr[21], self.p_vsseck1   , self.p_vddeck1   , self.p_i_addr[22], self.p_i_addr[23]
#          )
#
# PadNorth ( self.p_i_addr[24], self.p_i_addr[25], self.p_i_addr[26], self.p_vddick1   , self.p_i_addr[27], self.p_i_addr[28]
#          , self.p_i_addr[29], self.p_i_addr[30], self.p_i_addr[31], self.p_reset_n   , self.p_it_n[5]   , self.p_it_n[4]   
#          , self.p_it_n[3]   , self.p_it_n[2]   , self.p_it_n[1]   , self.p_it_n[0]   , self.p_i_ack     , self.p_i_berr_n  
#          , self.p_ck        , self.p_i_data[31], self.p_i_data[30], self.p_i_data[29], self.p_i_data[28], self.p_i_data[27]
#          , self.p_vssick1   , self.p_i_data[26], self.p_i_data[25], self.p_i_data[24]
#          ) 
#
#
# PadSouth ( self.p_i_addr[7] , self.p_i_addr[6] , self.p_i_addr[5] , self.p_vddick0   , self.p_i_addr[4] , self.p_i_addr[3] 
#          , self.p_i_addr[2] , self.p_i_addr[1] , self.p_i_addr[0] , self.p_test      , self.p_d_rq      , self.p_d_lock    
#          , self.p_d_atype1  , self.p_d_atype0  , self.p_i_frz     , self.p_i_ftch    , self.p_scin      , self.p_scout     
#          , self.p_d_ack     , self.p_d_berr_n  , self.p_d_frz     , self.p_i_data[0] , self.p_i_data[1] , self.p_i_data[2] 
#          , self.p_i_data[3] , self.p_i_data[4] , self.p_vssick0   , self.p_i_data[5] , self.p_i_data[6] , self.p_i_data[7]
#          )    
# 
# self.View()
# 
# PowerRing ( 3 )
# self.View()
#
# PlaceGlue ( self.mips_r3000_core, greedy = True )
# self.View()
#   
##FillCell ( self.mips_r3000_core)
# self.View()
#   
# RouteCk ( self.ckc )
# self.View()
# 
##GlobalRoute ()
##self.View()
# 
##DetailRoute ()
