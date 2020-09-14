# -*- Mode:Python -*-

import os
import Cfg
import Viewer
import CRL
import symbolic.cmos45
from   helpers       import overlay
from   helpers       import l, u, n

#cellsTop = os.path.abspath( os.getcwd()+'/../cells' )
if os.environ.has_key('CELLS_TOP'):
    cellsTop = os.environ['CELLS_TOP']
else:
    cellsTop = '../../../cells'

with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
    cfg.misc.catchCore           = False
    cfg.misc.info                = False
    cfg.misc.paranoid            = False
    cfg.misc.bug                 = False
    cfg.misc.logMode             = True
    cfg.misc.verboseLevel1       = True
    cfg.misc.verboseLevel2       = True
    cfg.etesian.graphics         = 3
    cfg.etesian.spaceMargin      = 0.10
    cfg.anabatic.edgeLenght      = 24
    cfg.anabatic.edgeWidth       = 8
    cfg.anabatic.routingGauge    = 'msxlib4'
    cfg.anabatic.topRoutingLayer = 'METAL4'
    cfg.katana.eventsLimit       = 4000000

    Viewer.Graphics.setStyle( 'Alliance.Classic [black]' )

    af  = CRL.AllianceFramework.get()
    env = af.getEnvironment()
    env.setCLOCK( '^clk|^reset' )
    env.addSYSTEM_LIBRARY( library=cellsTop+'/nsxlib', mode=CRL.Environment.Prepend )
    env.addSYSTEM_LIBRARY( library=cellsTop+'/mpxlib', mode=CRL.Environment.Prepend )
