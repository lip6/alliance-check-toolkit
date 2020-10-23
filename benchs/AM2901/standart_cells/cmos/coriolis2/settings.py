# -*- Mode:Python -*-

import os
import Cfg
import CRL
import Viewer
from   helpers import overlay, l, u, n
import symbolic.cmos

with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
    cfg.misc.catchCore              = False
    cfg.misc.info                   = False
    cfg.misc.paranoid               = False
    cfg.misc.bug                    = False
    cfg.misc.logMode                = True
    cfg.misc.verboseLevel1          = True
    cfg.misc.verboseLevel2          = True
    cfg.etesian.graphics            = 3
    cfg.etesian.spaceMargin         = 0.05
    cfg.etesian.aspectRatio         = 1.0
    cfg.katana.hTracksReservedLocal = 4
    cfg.katana.vTracksReservedLocal = 5
    cfg.clockTree.minimumSide       = l(1000)
    Viewer.Graphics.setStyle( 'Alliance.Classic [black]' )
