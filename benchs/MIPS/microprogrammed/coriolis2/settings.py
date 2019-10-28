# -*- Mode:Python -*-

import Cfg
import Viewer
import CRL
import symbolic.cmos
from   helpers       import l, u, n


Cfg.Configuration.pushDefaultPriority( Cfg.Parameter.Priority.UserFile )

af  = CRL.AllianceFramework.get()
env = af.getEnvironment()

env.setCLOCK( 'do_not_recognize_ck' )


Viewer.Graphics.setStyle( 'Alliance.Classic [black]' )
 
Cfg.getParamBool      ( 'misc.catchCore'              ).setBool      ( False   )
Cfg.getParamBool      ( 'misc.info'                   ).setBool      ( False   )
Cfg.getParamBool      ( 'misc.paranoid'               ).setBool      ( False   )
Cfg.getParamBool      ( 'misc.bug'                    ).setBool      ( False   )
Cfg.getParamBool      ( 'misc.logMode'                ).setBool      ( False   )
Cfg.getParamBool      ( 'misc.verboseLevel1'          ).setBool      ( True    )
Cfg.getParamBool      ( 'misc.verboseLevel2'          ).setBool      ( True    )
#Cfg.getParamInt       ( 'misc.minTraceLevel'          ).setInt       ( 110     )
#Cfg.getParamInt       ( 'misc.maxTraceLevel'          ).setInt       ( 120     )
Cfg.getParamInt       ( 'katana.eventsLimit'          ).setInt       ( 1000000 )
Cfg.getParamString    ( 'anabatic.topRoutingLayer'    ).setString    ( 'METAL5')
Cfg.getParamInt       ( 'katana.hTracksReservedLocal' ).setInt       ( 6       )
Cfg.getParamInt       ( 'katana.vTracksReservedLocal' ).setInt       ( 6       )

Cfg.Configuration.popDefaultPriority()
