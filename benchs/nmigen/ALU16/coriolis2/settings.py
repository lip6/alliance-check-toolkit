# -*- Mode:Python -*-

import os
import Cfg
import CRL
import Viewer
import symbolic.cmos
from   helpers       import l, u, n


Cfg.Configuration.pushDefaultPriority( Cfg.Parameter.Priority.UserFile )


Viewer.Graphics.setStyle( 'Alliance.Classic [black]' )
 
Cfg.getParamBool      ( 'misc.catchCore'              ).setBool      ( False   )
Cfg.getParamBool      ( 'misc.info'                   ).setBool      ( False   )
Cfg.getParamBool      ( 'misc.paranoid'               ).setBool      ( False   )
Cfg.getParamBool      ( 'misc.bug'                    ).setBool      ( False   )
Cfg.getParamBool      ( 'misc.logMode'                ).setBool      ( True   )
Cfg.getParamBool      ( 'misc.verboseLevel1'          ).setBool      ( True    )
Cfg.getParamBool      ( 'misc.verboseLevel2'          ).setBool      ( True    )
#Cfg.getParamInt       ( 'misc.minTraceLevel'          ).setInt       ( 159     )
#Cfg.getParamInt       ( 'misc.maxTraceLevel'          ).setInt       ( 160     )
Cfg.getParamEnumerate ( 'etesian.effort'              ).setInt       ( 2       )
Cfg.getParamPercentage( 'etesian.spaceMargin'         ).setPercentage( 20.0    )
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

af  = CRL.AllianceFramework.get()
env = af.getEnvironment()
env.setCLOCK( '^clk$|m_clock' )
env.setPOWER( 'vdd' )
env.setGROUND( 'vss' )
