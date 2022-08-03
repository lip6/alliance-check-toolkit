# -*- Mode:Python -*-

import os
import os
import socket
import Cfg
import Viewer
import CRL
import helpers
from   helpers   import overlay, l, u, n
from   Hurricane import DbU

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

import NDA.nodeMEMS

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
    Viewer.Graphics.setStyle( 'Alliance.Classic [black]' )
    DbU.setStringMode( DbU.StringModePhysical )
