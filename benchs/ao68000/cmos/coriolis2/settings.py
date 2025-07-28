# -*- Mode:Python -*-

import os
import Cfg
import Viewer
import CRL
import symbolic.cmos45
from   helpers       import overlay, l, u, n


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
    cfg.misc.logMode                = False
    cfg.misc.verboseLevel1          = True
    cfg.misc.verboseLevel2          = True
    #cfg.misc.minTraceLevel          = 159
    #cfg.misc.maxTraceLevel          = 160
    cfg.etesian.effort              = 2
    cfg.etesian.densityVariation    = 0.05
    cfg.anabatic.searchHalo         = 4
    cfg.anabatic.topRoutingLayer    = 'METAL5'
    cfg.katana.eventsLimit          = 1000000
    cfg.katana.termSatReservedLocal = 6
    cfg.katana.termSatThreshold     = 9
    Viewer.Graphics.setStyle( 'Alliance.Classic [black]' )
    af  = CRL.AllianceFramework.get()
    env = af.getEnvironment()
    env.setCLOCK( '^ck$|^clk_i$' )
    env.addSYSTEM_LIBRARY( library=cellsTop+'/nsxlib', mode=CRL.Environment.Prepend )
    env.addSYSTEM_LIBRARY( library=cellsTop+'/mpxlib', mode=CRL.Environment.Prepend )
