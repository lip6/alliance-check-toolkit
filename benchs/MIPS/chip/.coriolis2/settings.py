
# -*- Mode:Python -*-


defaultStyle = 'Alliance.Classic [black]'

allianceConfig = \
    ( ( 'CLOCK'              , '^ck.*')
    ,
    )
 
parametersTable = \
    ( ('misc.catchCore'           , TypeBool      , False )
    , ('misc.info'                , TypeBool      , False )
    , ('misc.bug'                 , TypeBool      , False )
    , ('misc.paranoid'            , TypeBool      , False )
    , ('misc.logMode'             , TypeBool      , True  )
    , ('misc.verboseLevel2'       , TypeBool      , True  )
    , ('misc.verboseLevel1'       , TypeBool      , True  )
    , ('misc.minTraceLevel'       , TypeInt       , 0     )
    , ('misc.maxTraceLevel'       , TypeInt       , 0     )
    # Kite parameters.
#   , ("kite.eventsLimit"         , TypeInt       , 1     )
    , ("kite.eventsLimit"         , TypeInt       , 500000)
    , ("katabatic.saturateRatio"  , TypePercentage, 85    )
    , ("katabatic.saturateRp"     , TypeInt       , 10    )
    , ("kite.hTracksReservedLocal", TypeInt       , 4     )
    , ("kite.vTracksReservedLocal", TypeInt       , 4     )
    #
    )
