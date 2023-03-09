# -*- Mode:Python -*-

from   coriolis import Cfg, Viewer
import coriolis.technos.symbolic.cmos
from   coriolis.helpers import overlay, l, u, n


with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
    cfg.misc.catchCore              = False
    cfg.misc.info                   = False
    cfg.misc.paranoid               = False
    cfg.misc.bug                    = False
    cfg.misc.logMode                = True
    cfg.misc.verboseLevel1          = True
    cfg.misc.verboseLevel2          = True
    #cfg.misc.minTraceLevel          = 159
    #cfg.misc.maxTraceLevel          = 160
    cfg.etesian.effort              = 2
    cfg.etesian.spaceMargin         = 0.10
    cfg.etesian.aspectRatio         = 1.0
    cfg.etesian.uniformDensity      = True
    cfg.anabatic.topRoutingLayer    = 'METAL5'
    cfg.katana.eventsLimit          = 1000000
    cfg.katana.hTracksReservedMin   = 3
    #cfg.katana.vTracksReservedMin   = 4
    cfg.katana.hTracksReservedLocal = 8
    cfg.katana.vTracksReservedLocal = 6
    cfg.katana.runRealignStage      = True
    #cfg.clockTree.minimumSide       = l(1000)
    cfg.block.spareSide             = l(1000)
    Viewer.Graphics.setStyle( 'Alliance.Classic [black]' )
