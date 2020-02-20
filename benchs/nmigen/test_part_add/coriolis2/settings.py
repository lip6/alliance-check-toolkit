# -*- Mode:Python -*-

import os
import Cfg
import CRL
import Viewer
import node180.scn6m_deep_09
from   helpers       import l, u, n


Cfg.Configuration.pushDefaultPriority( Cfg.Parameter.Priority.UserFile )

Viewer.Graphics.setStyle( 'Alliance.Classic [black]' )
 
Cfg.getParamBool      ( 'misc.catchCore'              ).setBool      ( False   )
Cfg.getParamBool      ( 'misc.info'                   ).setBool      ( False   )
Cfg.getParamBool      ( 'misc.paranoid'               ).setBool      ( False   )
Cfg.getParamBool      ( 'misc.bug'                    ).setBool      ( False   )
Cfg.getParamBool      ( 'misc.logMode'                ).setBool      ( False   )
Cfg.getParamBool      ( 'misc.verboseLevel1'          ).setBool      ( True    )
Cfg.getParamBool      ( 'misc.verboseLevel2'          ).setBool      ( True    )
#Cfg.getParamInt       ( 'misc.minTraceLevel'          ).setInt       ( 159     )
#Cfg.getParamInt       ( 'misc.maxTraceLevel'          ).setInt       ( 160     )
Cfg.getParamEnumerate ( 'etesian.effort'              ).setInt       ( 2       )
Cfg.getParamPercentage( 'etesian.spaceMargin'         ).setPercentage( 30.0    )
Cfg.getParamPercentage( 'etesian.aspectRatio'         ).setPercentage( 100.0   )
Cfg.getParamBool      ( 'etesian.uniformDensity'      ).setBool      ( True    )
Cfg.getParamInt       ( 'anabatic.edgeLenght'         ).setInt       ( 24      )
Cfg.getParamInt       ( 'anabatic.edgeWidth'          ).setInt       ( 8       )
Cfg.getParamString    ( 'anabatic.topRoutingLayer'    ).setString    ( 'METAL5')
Cfg.getParamInt       ( 'katana.eventsLimit'          ).setInt       ( 1000000 )
Cfg.getParamInt       ( 'katana.hTracksReservedLocal' ).setInt       ( 7       )
Cfg.getParamInt       ( 'katana.vTracksReservedLocal' ).setInt       ( 6       )
#Cfg.getParamInt       ( 'clockTree.minimumSide'       ).setInt       ( l(1000) )

Cfg.Configuration.popDefaultPriority()


#cellsTop = os.path.abspath( os.getcwd()+'/../cells' )
if os.environ.has_key('CELLS_TOP'):
  cellsTop = os.environ['CELLS_TOP']
else:
  cellsTop = '../../../cells'

af  = CRL.AllianceFramework.get()
env = af.getEnvironment()
env.addSYSTEM_LIBRARY( library=cellsTop+'/nsxlib', mode=CRL.Environment.Prepend )
env.addSYSTEM_LIBRARY( library=cellsTop+'/mpxlib', mode=CRL.Environment.Prepend )

print 'Successfully read user configuration'
