
# -*- Mode:Python -*-


defaultStyle = 'Alliance.Classic [black]'

allianceConfig = \
    ( ( 'CLOCK'              , 'do_not_recognize_ck')
    ,
    )
 
parametersTable = \
    ( ('misc.catchCore'             , TypeBool      , False )
    , ('misc.info'                  , TypeBool      , False )
    , ('misc.bug'                   , TypeBool      , False )
    , ('misc.paranoid'              , TypeBool      , False )
    , ('misc.logMode'               , TypeBool      , False )
    , ('misc.verboseLevel2'         , TypeBool      , True  )
    , ('misc.verboseLevel1'         , TypeBool      , True  )
    , ('misc.minTraceLevel'         , TypeInt       , 1590  )
    , ('misc.maxTraceLevel'         , TypeInt       , 1600  )
    , ('anabatic.edgeLength'        , TypeInt       , 24    )
    , ('anabatic.edgeWidth'         , TypeInt       , 16    )
    # Kite parameters.
#   , ("kite.eventsLimit"           , TypeInt       , 1     )
    , ("kite.eventsLimit"           , TypeInt       , 500000)
    , ("katabatic.saturateRatio"    , TypePercentage, 85    )
    , ("katabatic.saturateRp"       , TypeInt       , 10    )
    , ("kite.hTracksReservedLocal"  , TypeInt       , 4     )
    , ("kite.vTracksReservedLocal"  , TypeInt       , 5     )
    , ("katana.hTracksReservedLocal", TypeInt       , 3     )
    , ("katana.vTracksReservedLocal", TypeInt       , 3     )
    , ("katana.profileEventCosts"   , TypeBool      , True  )
    #
    )


#designTop = '/dsk/l1/jpc/coriolis-2.x/work/benchs/AES/AES_VHDL'
#
#allianceConfig = \
#    ( ( 'SYSTEM_LIBRARY'     , ( (designTop+'/sb_swap_combina/mux_registers/module'                 , Environment.Append)
#                               , (designTop+'/sb_swap_combina/ctrl_unit/module'                     , Environment.Append)
#                               , (designTop+'/sb_swap_combina/module'                               , Environment.Append)
#                               , (designTop+'/subbytes_combina'                                     , Environment.Append)
#                               , (designTop+'/AES_CIPHER_V2/expandkey/module'                       , Environment.Append)
#                               , (designTop+'/AES_CIPHER_V2/expandkey/mux_registers/register/module', Environment.Append)
#                               , (designTop+'/AES_CIPHER_V2/expandkey/ctrl_unit/module'             , Environment.Append)
#                               , (designTop+'/AES_CIPHER_V2/expandkey/mux_registers/module'         , Environment.Append)
#                               , (designTop+'/AES_CIPHER_V2/encrypt/module'                         , Environment.Append)
#                               , (designTop+'/AES_CIPHER_V2/encrypt/ctrl_unit/module'               , Environment.Append)
#                               , (designTop+'/AES_CIPHER_V2/encrypt/mux_registers/module'           , Environment.Append)
#                               , (designTop+'/subbytes_combina'                                     , Environment.Append)
#                               , (designTop+'/sb_swap_combina'                                      , Environment.Append)
#                               , (designTop+'/sb_swap_combina/mux_registers/module'                 , Environment.Append)
#                               , (designTop+'/sb_swap_combina/ctrl_unit/module'                     , Environment.Append)
#                               , (designTop+'/mixcolumms'                                           , Environment.Append)
#                               , (designTop+'/shiftrows'                                            , Environment.Append)
#                               , (designTop+'/addroundkey'                                          , Environment.Append)
#                               , (designTop+'/AES_CIPHER_V2/decrypt/module'                         , Environment.Append)
#                               , (designTop+'/AES_CIPHER_V2/decrypt/ctrl_unit/module'               , Environment.Append)
#                               , (designTop+'/AES_CIPHER_V2/decrypt/mux_registers/module'           , Environment.Append)
#                               , (designTop+'/invmixcolumms'                                        , Environment.Append)
#                               , (designTop+'/invshiftrows'                                         , Environment.Append)
#                               ) )
#   #, ( 'POWER'              , 'vdd')
#   #, ( 'GROUND'             , 'vss')
#    , ( 'CLOCK'              , '^ck.*')
#    , ( 'BLOCKAGE'           , '^blockageNet*')
#    )
#
#
