# -*- Mode:Python -*-

import os
import os.path
import helpers


defaultStyle = 'Alliance.Classic [black]'
 
parametersTable = \
    ( ('misc.catchCore'             , TypeBool      , False    )
    , ('misc.info'                  , TypeBool      , False    )
    , ('misc.paranoid'              , TypeBool      , False    )
    , ('misc.bug'                   , TypeBool      , False    )
    , ('misc.logMode'               , TypeBool      , True     )
    , ('misc.verboseLevel1'         , TypeBool      , True     )
    , ('misc.verboseLevel2'         , TypeBool      , True     )
    , ('misc.minTraceLevel'         , TypeInt       , 0        )
    , ('misc.maxTraceLevel'         , TypeInt       , 0        )
    , ('etesian.graphics'           , TypeEnumerate , 3        )
    , ("etesian.effort"             , TypeEnumerate , 2        )
    , ('etesian.uniformDensity'     , TypeBool      , True     )
    , ('etesian.spaceMargin'        , TypePercentage, 10.0     )
    , ('etesian.aspectRatio'        , TypePercentage, 100.0    )
   #, ('etesian.bloat'              , TypeString    , "3metals" )
   #, ('etesian.bloat'              , TypeString    , "disabled" )
    , ('etesian.bloat'              , TypeString    , "3metals" )
   # Kite parameters.
   #, ("kite.eventsLimit"           , TypeInt       , 1000000  )
    , ("anabatic.routingGauge"      , TypeString    , 'msxlib3')
   #, ('anabatic.topRoutingLayer'   , TypeString    , 'METAL3' )
   #, ("katana.hTracksReservedLocal", TypeInt       , 5        )
   #, ("katana.vTracksReservedLocal", TypeInt       , 3        )
   #, ("anabatic.edgeHScaling"      , TypeDouble    , 1.0      )
    )


if os.environ.has_key('CELLS_TOP'):
  cellsTop = os.environ['CELLS_TOP']
else:
  cellsTop = '../../../cells'
 
allianceConfig = \
    ( ( 'CLOCK'         , '^ck.*|m_clock')
    , ( 'SYSTEM_LIBRARY', ( (cellsTop+'/nsxlib'  , Environment.Prepend)
                          , (cellsTop+'/phlib80' , Environment.Prepend)) )
    ,
    )
