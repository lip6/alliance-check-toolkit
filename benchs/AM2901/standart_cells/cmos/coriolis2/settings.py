# -*- Mode:Python -*-

import Cfg
import Viewer
import symbolic.cmos
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
Cfg.getParamPercentage( 'etesian.spaceMargin'         ).setPercentage( 5.0     )
Cfg.getParamPercentage( 'etesian.aspectRatio'         ).setPercentage( 100.0   )
Cfg.getParamInt       ( 'anabatic.edgeLenght'         ).setInt       ( 24      )
Cfg.getParamInt       ( 'anabatic.edgeWidth'          ).setInt       ( 8       )
Cfg.getParamInt       ( 'katana.eventsLimit'          ).setInt       ( 1000000 )
#Cfg.getParamString    ( 'anabatic.topRoutingLayer'    ).setString    ( 'METAL5')
Cfg.getParamInt       ( 'katana.hTracksReservedLocal' ).setInt       ( 4       )
Cfg.getParamInt       ( 'katana.vTracksReservedLocal' ).setInt       ( 5       )
Cfg.getParamInt       ( 'clockTree.minimumSide'       ).setInt       ( l(1000) )

Cfg.Configuration.popDefaultPriority()

print 'Successfully read user configuration'
