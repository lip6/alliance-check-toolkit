# -*- Mode:Python -*-

import os
import os.path
import helpers


defaultStyle = 'Alliance.Classic [black]'
 
parametersTable = \
    ( ('misc.catchCore'             , TypeBool      , False     )
    , ('misc.info'                  , TypeBool      , False     )
    , ('misc.paranoid'              , TypeBool      , False     )
    , ('misc.bug'                   , TypeBool      , False     )
    , ('misc.logMode'               , TypeBool      , False     )
    , ('misc.verboseLevel1'         , TypeBool      , True      )
    , ('misc.verboseLevel2'         , TypeBool      , True      )
   #, ('misc.minTraceLevel'         , TypeInt       , 149       )
   #, ('misc.maxTraceLevel'         , TypeInt       , 161       )
    , ("etesian.effort"             , TypeEnumerate , 2         )
    , ('etesian.uniformDensity'     , TypeBool      , True      )
    , ('etesian.spaceMargin'        , TypePercentage, 5.0       )
    , ('etesian.aspectRatio'        , TypePercentage, 100.0     )
    , ('etesian.bloat'              , TypeString    , "nsxlib"  )
   # Kite parameters.
    , ("kite.eventsLimit"           , TypeInt       , 1000000   )
    , ("anabatic.routingGauge"      , TypeString    , 'msxlib4' )
    , ('anabatic.topRoutingLayer'   , TypeString    , 'METAL4'  )
    , ("katana.hTracksReservedLocal", TypeInt       , 6         )
    , ("katana.vTracksReservedLocal", TypeInt       , 3         )
    , ("anabatic.edgeHScaling"      , TypeDouble    , 1.0       )
    )

#cellsTop = os.path.abspath( os.getcwd()+'/../cells' )
if os.environ.has_key('CELLS_TOP'):
  cellsTop = os.environ['CELLS_TOP']
else:
  cellsTop = '../../../cells'
  
allianceConfig = \
    ( ( 'CLOCK'         , '^ck$|m_clock|^clk$')
    , ( 'SYSTEM_LIBRARY', ( (cellsTop+'/nsxlib'  , Environment.Prepend)
                          , (cellsTop+'/mpxlib'  , Environment.Prepend)) )
    ,
    )