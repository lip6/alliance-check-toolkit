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
    , ('misc.logMode'               , TypeBool      , True    )
    , ('misc.verboseLevel1'         , TypeBool      , True    )
    , ('misc.verboseLevel2'         , TypeBool      , True    )
    , ('misc.minTraceLevel'         , TypeInt       , 0       )
    , ('misc.maxTraceLevel'         , TypeInt       , 0       )
    , ("etesian.effort"             , TypeEnumerate , 2       )
    , ('etesian.uniformDensity'     , TypeBool      , True    )
    , ('etesian.spaceMargin'        , TypePercentage, 15.0    )
    , ('etesian.aspectRatio'        , TypePercentage, 100.0   )
   # Kite parameters.
    , ("katana.hTracksReservedLocal", TypeInt       , 7       )
    , ("katana.vTracksReservedLocal", TypeInt       , 6       )
    , ('anabatic.topRoutingLayer'   , TypeString    , 'METAL5')
    )


allianceConfig = \
    ( ( 'CLOCK'         , '^ck$|m_clock')
    ,
    )

