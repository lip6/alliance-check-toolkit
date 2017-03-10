
# -*- Mode:Python -*-


defaultStyle = 'Alliance.Classic [black]'

allianceConfig = \
    ( ( 'CLOCK'              , 'do_not_recognize_ck')
    ,
    )
 
parametersTable = \
    ( ('misc.catchCore'           , TypeBool      , False   )
    , ('misc.info'                , TypeBool      , False   )
    , ('misc.bug'                 , TypeBool      , False   )
    , ('misc.logMode'             , TypeBool      , True    )
    , ('misc.verboseLevel2'       , TypeBool      , False   )
    , ('misc.verboseLevel1'       , TypeBool      , False   )
    , ('misc.minTraceLevel'       , TypeInt       , 11000   )
    , ('misc.maxTraceLevel'       , TypeInt       , 12000   )
    # Kite parameters.
#   , ("kite.eventsLimit"         , TypeInt       , 1       )
    , ("kite.eventsLimit"         , TypeInt       , 400000  )
    , ("katabatic.saturateRatio"  , TypePercentage, 85      )
    , ("katabatic.saturateRp"     , TypeInt       , 10      )
    , ('katabatic.topRoutingLayer', TypeString    , 'METAL5')
    , ("kite.hTracksReservedLocal", TypeInt       , 6       )
    , ("kite.vTracksReservedLocal", TypeInt       , 6       )
    #
    )
