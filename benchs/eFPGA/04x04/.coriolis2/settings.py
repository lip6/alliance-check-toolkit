
# -*- Mode:Python -*-


defaultStyle = 'Alliance.Classic [black]'
 
parametersTable = \
    ( ('misc.catchCore'      , TypeBool      , False  )
    , ('misc.info'           , TypeBool      , False  )
    , ('misc.bug'            , TypeBool      , False  )
    , ('misc.logMode'        , TypeBool      , False  )
    , ('misc.verboseLevel1'  , TypeBool      , True   )
    , ('misc.verboseLevel2'  , TypeBool      , True   )
    , ('misc.traceLevel'     , TypeInt       , 1000   )
   # Kite parameters.
    , ("kite.eventsLimit"    , TypeInt       , 1000000)
    , ("kite.edgeCapacity"   , TypePercentage, 70     )
    , ("katabatic.saturateRp", TypeInt        ,6      )
    )


designTop = '/dsk/l1/jpc/coriolis-2.x/work/benchs/routing/eFPGA'

allianceConfig = \
     ( ( 'SYSTEM_LIBRARY'     , ( (designTop+'/efpgalib', Environment.Append)
                                ,
                                ) ),
    #, ( 'POWER'              , 'vdd')
    #, ( 'GROUND'             , 'vss')
    #, ( 'CLOCK'              , '^ck.*')
    #, ( 'BLOCKAGE'           , '^blockageNet*')
     )
