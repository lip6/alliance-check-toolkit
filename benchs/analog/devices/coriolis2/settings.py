# -*- Mode:Python -*-

import os
import os
import socket
import Cfg
import Viewer
import CRL
import helpers
from   helpers import overlay, l, u, n

NdaDirectory = None
if 'NDA_TOP' in os.environ:
    NdaDirectory = os.environ['NDA_TOP']
if not NdaDirectory:
    hostname = socket.gethostname()
    if hostname.startswith('lepka'):
        NdaDirectory = '/dsk/l1/jpc/crypted/soc/techno'
        if not os.path.isdir(NdaDirectory):
            print( '[ERROR] You forgot to mount the NDA encrypted directory, stupid!' )
    else:
        NdaDirectory = '/users/soft/techno/techno'
helpers.setNdaTopDir( NdaDirectory )

#cellsTop = os.path.abspath( os.getcwd()+'/../cells' )
if 'CELLS_TOP' in os.environ:
    cellsTop = os.environ['CELLS_TOP']
else:
    cellsTop = '../../../cells'

#import node180.scn6m_deep_09
import NDA.node350.c35b4

with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
    cfg.misc.catchCore           = False
    cfg.misc.minTraceLevel       = 10100
    cfg.misc.maxTraceLevel       = 10200
    cfg.misc.info                = False
    cfg.misc.paranoid            = False
    cfg.misc.bug                 = False
    cfg.misc.logMode             = True
    cfg.misc.verboseLevel1       = True
    cfg.misc.verboseLevel2       = True
    cfg.etesian.graphics         = 3
    cfg.etesian.uniformDensity   = True
    cfg.etesian.spaceMargin      = 0.04
    cfg.katana.eventsLimit       = 4000000
    af  = CRL.AllianceFramework.get()
    env = af.getEnvironment()
    env.setCLOCK( '^ck$|m_clock|^clk$' )
    env.addSYSTEM_LIBRARY( library=cellsTop+'/nsxlib', mode=CRL.Environment.Prepend )
    env.addSYSTEM_LIBRARY( library=cellsTop+'/mpxlib', mode=CRL.Environment.Prepend )
    Viewer.Graphics.setStyle( 'Alliance.Classic [black]' )
