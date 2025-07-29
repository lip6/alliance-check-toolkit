# -*- Mode:Python -*-

import os
from   coriolis import Cfg, Viewer, CRL
import coriolis.technos.symbolic.cmos
from   coriolis.helpers import overlay, l, u, n

#cellsTop = os.path.abspath( os.getcwd()+'/../cells' )
if 'CELLS_TOP' in os.environ:
    cellsTop = os.environ['CELLS_TOP']
else:
    cellsTop = '../../../cells'

with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
    cfg.misc.catchCore              = False
    cfg.misc.info                   = False
    cfg.misc.paranoid               = False
    cfg.misc.bug                    = False
    cfg.misc.logMode                = True
    cfg.misc.verboseLevel1          = True
    cfg.misc.verboseLevel2          = True
    cfg.misc.minTraceLevel          = 1900
    cfg.misc.maxTraceLevel          = 3000
    cfg.katana.eventsLimit          = 1000000
    cfg.katana.termSatReservedLocal = 6
    cfg.katana.termSatThreshold     = 9
    Viewer.Graphics.setStyle( 'Alliance.Classic [black]' )
    af  = CRL.AllianceFramework.get()
    env = af.getEnvironment()
    env.setCLOCK( '^ck$|m_clock|^clk$' )
   #env.addSYSTEM_LIBRARY( library=cellsTop+'/nsxlib', mode=CRL.Environment.Prepend )
   #env.addSYSTEM_LIBRARY( library=cellsTop+'/niolib', mode=CRL.Environment.Prepend )
