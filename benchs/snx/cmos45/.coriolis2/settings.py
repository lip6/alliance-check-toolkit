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
    , ('etesian.spaceMargin'        , TypePercentage, 5.0     )
    , ('etesian.aspectRatio'        , TypePercentage, 100.0   )
   # Kite parameters.
   #, ('anabatic.routingGauge'      , TypeString    , 'msxlib' )
    , ("kite.eventsLimit"           , TypeInt       , 1000000 )
    , ('katabatic.topRoutingLayer'  , TypeString    , 'METAL5')
    , ("katana.hTracksReservedLocal", TypeInt       , 3       )
    , ("katana.vTracksReservedLocal", TypeInt       , 3       )
    )


cellsTop = os.environ['CELLS_TOP']
 
allianceConfig = \
    ( ( 'CLOCK'         , '^ck.*|m_clock')
    , ( 'SYSTEM_LIBRARY', ( (cellsTop+'/nsxlib'  , Environment.Prepend)
                          , (cellsTop+'/mpxlib'  , Environment.Prepend)) )
    ,
    )
