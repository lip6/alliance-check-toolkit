# -*- Mode:Python -*-

import os
import os.path


defaultStyle = 'Alliance.Classic [black]'
 
parametersTable = \
    ( ('misc.catchCore'             , TypeBool      , False   )
    , ('misc.info'                  , TypeBool      , False   )
    , ('misc.paranoid'              , TypeBool      , False   )
    , ('misc.bug'                   , TypeBool      , False   )
    , ('misc.logMode'               , TypeBool      , False   )
    , ('misc.verboseLevel1'         , TypeBool      , True    )
    , ('misc.verboseLevel2'         , TypeBool      , True    )
   #, ('misc.minTraceLevel'         , TypeInt       , 150     )
   #, ('misc.maxTraceLevel'         , TypeInt       , 160     )
    , ("etesian.effort"             , TypeEnumerate , 2       )
    , ('etesian.uniformDensity'     , TypeBool      , True    )
    , ('etesian.spaceMargin'        , TypePercentage, 5.0     )
    , ('etesian.aspectRatio'        , TypePercentage, 100.0   )
   # Kite parameters.
    , ("anabatic.gcell.displayMode" , TypeEnumerate , 1       )
    , ("anabatic.topRoutingLayer"   , TypeString    , 'METAL4')
    , ("katana.eventsLimit"         , TypeInt       , 1000000 )
   #, ("katana.hTracksReservedLocal", TypeInt       , 4       )
   #, ("katana.vTracksReservedLocal", TypeInt       , 9       )
    )


allianceConfig = \
    ( ( 'CLOCK'         , '^clk$|^ck$')
    ,
    )

