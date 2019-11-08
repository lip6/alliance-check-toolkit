# -*- Mode:Python -*-

import os
import os
import socket
import helpers

NdaDirectory = None
if os.environ.has_key('NDA_TOP'):
  NdaDirectory = os.environ['NDA_TOP']

if not NdaDirectory:
  hostname = socket.gethostname()
  if hostname.startswith('lepka'):
    NdaDirectory = '/dsk/l1/jpc/crypted/soc/techno'
    if not os.path.isdir(NdaDirectory):
      print '[ERROR] You forgot to mount the NDA encrypted directory, stupid!'
  else:
    NdaDirectory = '/users/soft/techno/techno'

helpers.setNdaTopDir( NdaDirectory )

import Cfg
import Viewer
import CRL
#import node180.scn6m_deep_09
import NDA.node350.c35b4
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
Cfg.getParamBool      ( 'misc.logMode'                ).setBool      ( False     )
Cfg.getParamBool      ( 'misc.verboseLevel1'          ).setBool      ( True      )
Cfg.getParamBool      ( 'misc.verboseLevel2'          ).setBool      ( True      )
#Cfg.getParamInt       ( 'misc.minTraceLevel'          ).setInt       ( 159       )
#Cfg.getParamInt       ( 'misc.maxTraceLevel'          ).setInt       ( 160       )
#Cfg.getParamBool      ( 'etesian.uniformDensity'      ).setBool      ( True      )
#Cfg.getParamEnumerate ( 'etesian.effort'              ).setInt       ( 2         )
#Cfg.getParamPercentage( 'etesian.spaceMargin'         ).setPercentage( 5.0       )
#Cfg.getParamPercentage( 'etesian.aspectRatio'         ).setPercentage( 100.0     )
#Cfg.getParamString    ( 'etesian.bloat'               ).setString    ( '3metals' )
#Cfg.getParamPercentage( 'anabatic.saturateRatio'      ).setPercentage( 75.0      )
#Cfg.getParamInt       ( 'anabatic.edgeLenght'         ).setInt       ( 24        )
#Cfg.getParamInt       ( 'anabatic.edgeWidth'          ).setInt       ( 8         )
#Cfg.getParamString    ( 'anabatic.routingGauge'       ).setString    ( 'msxlib'  )
#Cfg.getParamString    ( 'anabatic.topRoutingLayer'    ).setString    ( 'METAL5'  )
#Cfg.getParamInt       ( 'katana.eventsLimit'          ).setInt       ( 1000000   )
#Cfg.getParamInt       ( 'katana.hTracksReservedLocal' ).setInt       ( 8         )
#Cfg.getParamInt       ( 'katana.vTracksReservedLocal' ).setInt       ( 8         )
#Cfg.getParamInt       ( 'katana.termSatReservedLocal' ).setInt       ( 6         )
#Cfg.getParamInt       ( 'katana.termSatThreshold'     ).setInt       ( 9         )
#Cfg.getParamInt       ( 'clockTree.minimumSide'       ).setInt       ( l(1000)   )

Cfg.Configuration.popDefaultPriority()

