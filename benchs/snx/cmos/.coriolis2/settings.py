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
    , ('misc.minTraceLevel'         , TypeInt       , 0       )
    , ('misc.maxTraceLevel'         , TypeInt       , 0       )
    , ("etesian.effort"             , TypeEnumerate , 2       )
    , ('etesian.uniformDensity'     , TypeBool      , True    )
    , ('etesian.spaceMargin'        , TypePercentage, 20.0    )
    , ('etesian.aspectRatio'        , TypePercentage, 100.0   )
   # Kite parameters.
    , ("katana.hTracksReservedLocal", TypeInt       , 6       )
    , ("katana.vTracksReservedLocal", TypeInt       , 5       )
    , ('anabatic.topRoutingLayer'   , TypeString    , 'METAL4')
    )


allianceConfig = \
    ( ( 'CLOCK'         , '^ck$|m_clock')
    ,
    )

