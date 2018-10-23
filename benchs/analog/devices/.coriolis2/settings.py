# -*- Mode:Python -*-

import sys
import os
import os.path

#defaultStyle = 'Layout Design White'
defaultStyle = 'Alliance.Classic [black]'

if helpers.techno == '180/scn6m_deep_09':
  cwd            = os.path.abspath( os.getcwd() )
  cellsTop       = os.path.abspath( os.environ['HOME']+'/coriolis-2.x/src/alliance-check-toolkit/benchs/cells' )
  allianceConfig = \
      ( ( 'WORKING_LIBRARY', ( (cwd) ) )
      , ( 'SYSTEM_LIBRARY' , ( (cellsTop+'/nsxlib'  , Environment.Prepend)
                             , (cellsTop+'/mpxlib'  , Environment.Prepend)) )
      ,
      )
 
parametersTable = \
    ( ('misc.catchCore'    , TypeBool  , False    )
    , ('misc.info'         , TypeBool  , False    )
    , ('misc.paranoid'     , TypeBool  , False    )
    , ('misc.bug'          , TypeBool  , False    )
    , ('misc.logMode'      , TypeBool  , False    )
    , ('misc.verboseLevel1', TypeBool  , True     )
    , ('misc.verboseLevel2', TypeBool  , True     )
    )
