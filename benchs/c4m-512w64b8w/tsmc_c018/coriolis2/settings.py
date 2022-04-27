# -*- Mode:Python -*-

import os
import socket
import helpers

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

import Cfg
from   CRL     import AllianceFramework
from   helpers import overlay, l, u, n
from   NDA.node180.tsmc_c018 import techno, FlexLib, LibreSOCIO, LibreSOCMem

techno.setup()
FlexLib.setup()
LibreSOCIO.setup()
LibreSOCMem.setup()

with overlay.CfgCache('', priority=Cfg.Parameter.Priority.UserFile) as cfg:
    cfg.misc.catchCore               = False
    cfg.misc.minTraceLevel           = 15900
    cfg.misc.maxTraceLevel           = 16000
    cfg.misc.info                    = False
    cfg.misc.paranoid                = False
    cfg.misc.bug                     = False
    cfg.misc.logMode                 = True
    cfg.misc.verboseLevel1           = True
    cfg.misc.verboseLevel2           = True
    cfg.etesian.graphics             = 3
    cfg.conductor.stopLevel          = 0
    cfg.conductor.maxPlaceIterations = 2
    cfg.conductor.useFixedAbHeight   = False
    env = AllianceFramework.get().getEnvironment()
    env.setCLOCK( '^clk$|^ck|^jtag_tck$' )
    env.setPOWER ('vdd')
    env.setGROUND('vss')

print( '  o  Successfully run "<>/coriolis2/settings.py".' )
