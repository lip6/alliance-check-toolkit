import sys
import os
import socket
from   pathlib import Path
from   coriolis.designflow.task    import ShellEnv, Tasks
from   coriolis.designflow.technos import Where

def setupSky130nsx ( useNsxlib=False, checkToolkit=None, cellsTop=None ):
    from   coriolis        import Cfg 
    from   coriolis        import Viewer
    from   coriolis        import CRL 
    from   coriolis.helpers import overlay, l, u, n
    from   coriolis.designflow.yosys    import Yosys
    from   techno.symbolic.sky130nsx import technology

    Where( checkToolkit )
    if cellsTop is None:
        cellsTop = Where.cellsTop
    else:
        if isinstance(cellsTop,str):
            cellsTop = Path( cellsTop )
    
    with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
        cfg.misc.catchCore               = False
        cfg.misc.info                    = False
        cfg.misc.paranoid                = False
        cfg.misc.bug                     = False
        cfg.misc.logMode                 = True
        cfg.misc.verboseLevel1           = True
        cfg.misc.verboseLevel2           = True
        cfg.misc.minTraceLevel           = 1900
        cfg.misc.maxTraceLevel           = 3000
        cfg.katana.eventsLimit           = 1000000
        cfg.etesian.graphics             = 3
        cfg.etesian.spaceMargin          = 0.05
        cfg.etesian.aspectRatio          = 1.0 
        cfg.anabatic.edgeLenght          = 24
        cfg.anabatic.edgeWidth           = 8
        if useNsxlib:
            cfg.anabatic.routingGauge    = 'nsxlib2'
            cfg.anabatic.topRoutingLayer = 'METAL4'
        cfg.katana.termSatReservedLocal  = 6 
        cfg.katana.termSatThreshold      = 9 

        Viewer.Graphics.setStyle( 'Alliance.Classic [black]' )
        af  = CRL.AllianceFramework.get()
        env = af.getEnvironment()
        env.setCLOCK( '^ck$|m_clock|^clk$' )

        sxlib   = cellsTop / 'nsxlib2'
        iolib   = cellsTop / 'niolib'
        liberty = sxlib    / 'nsxlib2.lib'
        env.addSYSTEM_LIBRARY( library=iolib.as_posix(), mode=CRL.Environment.Prepend )
        env.addSYSTEM_LIBRARY( library=sxlib.as_posix(), mode=CRL.Environment.Prepend )
        if not sxlib.is_dir():
            print( '[ERROR] technos.setupCMOS45(): sxlib directory do *not* exists:' )
            print( '        "{}"'.format(sxlib.as_posix()) )

    Yosys.setLiberty( liberty )
    ShellEnv.RDS_TECHNO_NAME = (sxlib / 'techno' / 'sky130_nsx3.rds').as_posix()

    path = None
    for pathVar in [ 'PATH', 'path' ]:
        if pathVar in os.environ:
            path = os.environ[ pathVar ]
            os.environ[ pathVar ] = path + ':' + (Where.allianceTop / 'bin').as_posix()
            break




setupSky130nsx( checkToolkit='../..' )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow import pnrcheck

pnrcheck.mkRuleSet( globals(), 'my80core', pnrcheck.UseClockTree|pnrcheck.NoGDS )
