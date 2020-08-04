# -*- Mode:Python -*-

import Cfg
import Viewer
import symbolic.cmos
from   helpers       import l, u, n
from   helpers       import overlay

with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
    cfg.misc.catchCore               = False
    cfg.misc.info                    = False
    cfg.misc.paranoid                = False
    cfg.misc.bug                     = False
    cfg.misc.logMode                 = False
    cfg.misc.verboseLevel1           = True
    cfg.misc.verboseLevel2           = True
    cfg.misc.minTraceLevel           = 1590
    cfg.misc.maxTraceLevel           = 1600
    cfg.etesian.graphics             = 3
    cfg.etesian.uniformDensity       = True
    cfg.etesian.effort               = 2
    cfg.etesian.spaceMargin          = 15.0
    cfg.etesian.bloat                = 'nsxlib'
    cfg.anabatic.topRoutingLayer     = 'METAL5'
    cfg.katana.eventsLimit           = 1000000
    cfg.katana.hTracksReservedLocal  = 8
    cfg.katana.vTracksReservedLocal  = 8
    cfg.katana.terminalReservedLocal = 8
    cfg.katana.termSatThreshold      = 9
    cfg.katana.hTracksReservedMin    = 2
    cfg.katana.vTracksReservedMin    = 1
    cfg.clocktree.minimumSide        = l(1000)

    Viewer.Graphics.setStyle( 'Alliance.Classic [black]' )

