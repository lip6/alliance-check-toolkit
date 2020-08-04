# -*- Mode:Python -*-

import os
import Cfg
import Viewer
import CRL
import symbolic.cmos45
from   helpers       import l, u, n


#cellsTop = os.path.abspath( os.getcwd()+'/../cells' )
if os.environ.has_key('CELLS_TOP'):
  cellsTop = os.environ['CELLS_TOP']
else:
  cellsTop = '../../../cells'


Cfg.Configuration.pushDefaultPriority( Cfg.Parameter.Priority.UserFile )

Viewer.Graphics.setStyle( 'Alliance.Classic [black]' )

af  = CRL.AllianceFramework.get()
env = af.getEnvironment()
env.setCLOCK( '^ck$|m_clock|^clk$' )
env.addSYSTEM_LIBRARY( library=cellsTop+'/nsxlib', mode=CRL.Environment.Prepend )
env.addSYSTEM_LIBRARY( library=cellsTop+'/mpxlib', mode=CRL.Environment.Prepend )

 
Cfg.getParamBool      ( 'misc.catchCore'              ).setBool      ( False     )
Cfg.getParamBool      ( 'misc.info'                   ).setBool      ( False     )
Cfg.getParamBool      ( 'misc.paranoid'               ).setBool      ( False     )
Cfg.getParamBool      ( 'misc.bug'                    ).setBool      ( False     )
Cfg.getParamBool      ( 'misc.logMode'                ).setBool      ( True      )
Cfg.getParamBool      ( 'misc.verboseLevel1'          ).setBool      ( True      )
Cfg.getParamBool      ( 'misc.verboseLevel2'          ).setBool      ( True      )
#Cfg.getParamInt       ( 'misc.minTraceLevel'          ).setInt       ( 159       )
#Cfg.getParamInt       ( 'misc.maxTraceLevel'          ).setInt       ( 160       )
Cfg.getParamBool      ( 'etesian.uniformDensity'      ).setBool      ( True      )
Cfg.getParamEnumerate ( 'etesian.effort'              ).setInt       ( 2         )
Cfg.getParamPercentage( 'etesian.spaceMargin'         ).setPercentage( 10.0      )
Cfg.getParamPercentage( 'etesian.aspectRatio'         ).setPercentage( 100.0     )
Cfg.getParamString    ( 'etesian.bloat'               ).setString    ( 'nsxlib'  )
#Cfg.getParamString    ( 'etesian.bloat'               ).setString    ( 'disabled' )
Cfg.getParamInt       ( 'anabatic.edgeLenght'         ).setInt       ( 24        )
Cfg.getParamInt       ( 'anabatic.edgeWidth'          ).setInt       ( 8         )
Cfg.getParamString    ( 'anabatic.routingGauge'       ).setString    ( 'msxlib4' )
Cfg.getParamString    ( 'anabatic.topRoutingLayer'    ).setString    ( 'METAL4'  )
Cfg.getParamInt       ( 'katana.eventsLimit'          ).setInt       ( 1000000   )
Cfg.getParamInt       ( 'katana.hTracksReservedLocal' ).setInt       ( 6         )
Cfg.getParamInt       ( 'katana.vTracksReservedLocal' ).setInt       ( 3         )
#Cfg.getParamInt       ( 'clockTree.minimumSide'       ).setInt       ( l(1000)   )

Cfg.Configuration.popDefaultPriority()

