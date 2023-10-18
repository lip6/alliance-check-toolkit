# -*- Mode:Python -*-

import Cfg
import Viewer
import CRL
import node45.freepdk45
from   helpers       import l, u, n


Cfg.Configuration.pushDefaultPriority( Cfg.Parameter.Priority.UserFile )

Viewer.Graphics.setStyle( 'Alliance.Classic [black]' )

af  = CRL.AllianceFramework.get()
env = af.getEnvironment()
env.setCLOCK( '^clk$|^ck$' )
 
Cfg.getParamBool      ( 'misc.catchCore'              ).setBool      ( False   )
Cfg.getParamBool      ( 'misc.info'                   ).setBool      ( False   )
Cfg.getParamBool      ( 'misc.paranoid'               ).setBool      ( False   )
Cfg.getParamBool      ( 'misc.bug'                    ).setBool      ( False   )
Cfg.getParamBool      ( 'misc.logMode'                ).setBool      ( False   )
Cfg.getParamBool      ( 'misc.verboseLevel1'          ).setBool      ( True    )
Cfg.getParamBool      ( 'misc.verboseLevel2'          ).setBool      ( True    )
#Cfg.getParamInt       ( 'misc.minTraceLevel'          ).setInt       ( 150     )
#Cfg.getParamInt       ( 'misc.maxTraceLevel'          ).setInt       ( 160     )
Cfg.getParamPercentage( 'etesian.densityVariation' ).setPercentage( 5.0    )
Cfg.getParamEnumerate ( 'etesian.effort'              ).setInt       ( 2       )
Cfg.getParamPercentage( 'etesian.spaceMargin'         ).setPercentage( 7       )
Cfg.getParamInt       ( 'katana.eventsLimit'          ).setInt       ( 1000000 )
Cfg.getParamString    ( 'anabatic.topRoutingLayer'    ).setString    ( 'metal5')
#Cfg.getParamInt       ( 'katana.hTracksReservedLocal' ).setInt       ( 5       )
#Cfg.getParamInt       ( 'katana.vTracksReservedLocal' ).setInt       ( 5       )

Cfg.Configuration.popDefaultPriority()
