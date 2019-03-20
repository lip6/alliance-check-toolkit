# -*- Mode:Python -*-

import os
import os.path
import helpers


defaultStyle = 'Alliance.Classic [black]'
 
parametersTable = \
    ( ('misc.catchCore'             , TypeBool      , False   )
    , ('misc.info'                  , TypeBool      , False   )
    , ('misc.paranoid'              , TypeBool      , False   )
    , ('misc.bug'                   , TypeBool      , False   )
    , ('misc.logMode'               , TypeBool      , False   )
    , ('misc.verboseLevel1'         , TypeBool      , True    )
    , ('misc.verboseLevel2'         , TypeBool      , True    )
   #, ('misc.minTraceLevel'         , TypeInt       , 112     )
   #, ('misc.maxTraceLevel'         , TypeInt       , 1000    )
    , ("etesian.effort"             , TypeEnumerate , 2       )
    , ('etesian.uniformDensity'     , TypeBool      , True    )
    , ('etesian.spaceMargin'        , TypePercentage, 8.0     )
    , ('etesian.aspectRatio'        , TypePercentage, 410.0   )
   # Kite parameters.
    , ('anabatic.routingGauge'      , TypeString    , 'sxlib-2M' )
    , ("kite.eventsLimit"           , TypeInt       , 1000000 )
    , ('katabatic.topRoutingLayer'  , TypeString    , 'METAL2')
    , ("katana.hTracksReservedLocal", TypeInt       , 0       )
    , ("katana.vTracksReservedLocal", TypeInt       , 0       )
    )
