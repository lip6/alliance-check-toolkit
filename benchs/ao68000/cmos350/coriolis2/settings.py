# -*- Mode:Python -*-

import sys
import os
import os.path
import Cfg
Cfg.Configuration.pushDefaultPriority( Cfg.Parameter.Priority.UserFile )
Cfg.getParamBool      ( 'misc.catchCore'              ).setBool      ( False      )
Cfg.getParamBool      ( 'misc.info'                   ).setBool      ( False      )
Cfg.getParamBool      ( 'misc.paranoid'               ).setBool      ( False      )
Cfg.getParamBool      ( 'misc.bug'                    ).setBool      ( False      )
Cfg.getParamBool      ( 'misc.logMode'                ).setBool      ( False      )
Cfg.getParamBool      ( 'misc.verboseLevel1'          ).setBool      ( True       )
Cfg.getParamBool      ( 'misc.verboseLevel2'          ).setBool      ( True       )
#Cfg.getParamInt       ( 'misc.minTraceLevel'          ).setInt       ( 159        )
#Cfg.getParamInt       ( 'misc.maxTraceLevel'          ).setInt       ( 160        )

import Viewer
import CRL
from   helpers       import l, u, n
import symbolic.cmos45


Viewer.Graphics.setStyle( 'Alliance.Classic [black]' )
 
Cfg.getParamPercentage( 'etesian.spaceMargin'               ).setPercentage( 1.0        )
Cfg.getParamPercentage( 'etesian.aspectRatio'               ).setPercentage( 100.0      )
Cfg.getParamString    ( 'etesian.bloat'                     ).setString    ( 'disabled' )
Cfg.getParamInt       ( 'anabatic.edgeLenght'               ).setInt       ( 40         )
Cfg.getParamInt       ( 'anabatic.edgeWidth'                ).setInt       ( 16         )
Cfg.getParamInt       ( 'anabatic.globalIterationsEstimate' ).setInt       ( 10         )
Cfg.getParamInt       ( 'anabatic.globalIterations'         ).setInt       ( 16         )
Cfg.getParamInt       ( 'katana.eventsLimit'                ).setInt       ( 1000000    )
Cfg.getParamString    ( 'anabatic.routingGauge'             ).setString    ( 'msxlib4'  )
Cfg.getParamString    ( 'anabatic.topRoutingLayer'          ).setString    ( 'METAL4'   )
Cfg.getParamInt       ( 'katana.hTracksReservedLocal'       ).setInt       ( 6          )
Cfg.getParamInt       ( 'katana.vTracksReservedLocal'       ).setInt       ( 4          )
Cfg.getParamInt       ( 'katana.searchHalo'                 ).setInt       ( 3          )
Cfg.getParamBool      ( 'katana.useGlobalEstimate'          ).setBool      ( True       )
#Cfg.getParamInt       ( 'clockTree.minimumSide'             ).setInt       ( l(1000)    )
Cfg.getParamInt       ( 'conductor.stopLevel'               ).setInt       ( 0          )
Cfg.getParamInt       ( 'conductor.maxPlaceIterations'      ).setInt       ( 4          )
Cfg.getParamBool      ( 'conductor.useFixedAbHeight'        ).setBool      ( True       )


if os.environ.has_key('CELLS_TOP'):
  cellsTop = os.environ['CELLS_TOP']
else:
  cellsTop = '../../../cells'

af  = CRL.AllianceFramework.get()
env = af.getEnvironment()
env.setCLOCK ( 'clk_i' )
env.setPOWER ( 'vdd'   )
env.setGROUND( 'vss'   )
env.addSYSTEM_LIBRARY( library=cellsTop+'/nsxlib', mode=CRL.Environment.Prepend )
env.addSYSTEM_LIBRARY( library=cellsTop+'/mpxlib', mode=CRL.Environment.Prepend )

Cfg.Configuration.popDefaultPriority()


