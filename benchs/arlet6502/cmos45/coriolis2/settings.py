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
    cfg.etesian.spaceMargin         = 0.30
    cfg.etesian.aspectRatio         = 1.0
    cfg.etesian.uniformDensity      = True
    cfg.etesian.bloat               = 'nsxlib'
    cfg.anabatic.searchHalo         = 4
    cfg.anabatic.topRoutingLayer    = 'METAL5'
    cfg.katana.eventsLimit          = 1000000
    #cfg.katana.hTracksReservedMin   = 4
    #cfg.katana.vTracksReservedMin   = 2
    #cfg.katana.hTracksReservedLocal = 7
    #cfg.katana.vTracksReservedLocal = 7
    cfg.katana.termSatReservedLocal = 6
    cfg.katana.termSatThreshold     = 9
    #cfg.clockTree.minimumSide       = l(1000)
    cfg.block.spareSide             = l(1000)
    Viewer.Graphics.setStyle( 'Alliance.Classic [black]' )
    af  = CRL.AllianceFramework.get()
    env = af.getEnvironment()
    env.setCLOCK( '^ck$|m_clock|^clk$' )
    env.addSYSTEM_LIBRARY( library=cellsTop+'/nsxlib', mode=CRL.Environment.Prepend )
    env.addSYSTEM_LIBRARY( library=cellsTop+'/niolib', mode=CRL.Environment.Prepend )
