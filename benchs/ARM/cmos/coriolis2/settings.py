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
Cfg.getParamInt       ( 'misc.minTraceLevel'          ).setInt       ( 1590    )
Cfg.getParamInt       ( 'misc.maxTraceLevel'          ).setInt       ( 1600    )
Cfg.getParamInt       ( 'clocktree.minimumSide'       ).setInt       ( l(1000) )
Cfg.getParamEnumerate ( 'etesian.graphics'            ).setInt       ( 3       )
Cfg.getParamBool      ( 'etesian.uniformDensity'      ).setBool      ( True    )
Cfg.getParamEnumerate ( 'etesian.effort'              ).setInt       ( 2       )
Cfg.getParamPercentage( 'etesian.spaceMargin'         ).setPercentage( 15.0    )
Cfg.getParamString    ( 'etesian.bloat'               ).setString    ( 'nsxlib')
Cfg.getParamInt       ( 'katana.eventsLimit'          ).setInt       ( 1000000 )
Cfg.getParamString    ( 'anabatic.topRoutingLayer'    ).setString    ( 'METAL5')
Cfg.getParamInt       ( 'katana.hTracksReservedLocal' ).setInt       ( 8       )
Cfg.getParamInt       ( 'katana.vTracksReservedLocal' ).setInt       ( 8       )
Cfg.getParamInt       ( 'katana.termSatReservedLocal' ).setInt       ( 8       )
Cfg.getParamInt       ( 'katana.termSatThreshold'     ).setInt       ( 9       )

Cfg.Configuration.popDefaultPriority()
