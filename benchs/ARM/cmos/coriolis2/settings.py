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
    cfg.misc.logMode                 = True
    cfg.misc.verboseLevel1           = True
    cfg.misc.verboseLevel2           = True
    cfg.misc.minTraceLevel           = 1590
    cfg.misc.maxTraceLevel           = 1600
    cfg.etesian.graphics             = 3

    Viewer.Graphics.setStyle( 'Alliance.Classic [black]' )

