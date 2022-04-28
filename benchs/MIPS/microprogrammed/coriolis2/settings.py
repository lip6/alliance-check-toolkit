# -*- Mode:Python -*-

import Cfg
import Viewer
import CRL
import symbolic.cmos
from   helpers       import l, u, n
from   helpers       import overlay

with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
    # Common settings for all runs.
    cfg.misc.catchCore              = False
    cfg.misc.info                   = False
    cfg.misc.paranoid               = False
    cfg.misc.bug                    = False
    cfg.misc.logMode                = True
    cfg.misc.verboseLevel1          = True
    cfg.misc.verboseLevel2          = True
    #cfg.misc.minTraceLevel          = 110
    #cfg.misc.maxTraceLevel          = 120
    cfg.katana.eventsLimit          = 1000000
    cfg.anabatic.topRoutingLayer    = 'METAL5'
    cfg.katana.hTracksReservedLocal = 6
    cfg.katana.vTracksReservedLocal = 7
    cfg.katana.hTracksReservedMin   = 1
    cfg.katana.vTracksReservedMin   = 5

    Viewer.Graphics.setStyle( 'Alliance.Classic [black]' )

    af  = CRL.AllianceFramework.get()
    env = af.getEnvironment()
    env.setCLOCK( 'do_not_recognize_ck' )
