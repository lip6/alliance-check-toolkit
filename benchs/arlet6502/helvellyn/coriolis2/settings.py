
import sys
import os
import os.path
import socket
import re
import Cfg
import helpers
from   helpers import overlay


NdaDirectory = None
if 'NDA_TOP' in os.environ:
    NdaDirectory = os.environ['NDA_TOP']
if 'PDKMASTER_TOP' in os.environ:
    PdkMasterTop = os.environ['PDKMASTER_TOP']
    NdaDirectory = PdkMasterTop + '/libs.tech/coriolis/techno'
if not NdaDirectory:
    hostname = socket.gethostname()
    if hostname.startswith('lepka'):
        NdaDirectory = '/dsk/l1/jpc/crypted/soc/techno'
        if not os.path.isdir(NdaDirectory):
            print ('[ERROR] You forgot to mount the NDA '
                   'encrypted directory, stupid!')
    else:
        NdaDirectory = '/users/soft/techno/techno'
helpers.setNdaTopDir( NdaDirectory )

with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
    cfg.misc.catchCore            = False
    cfg.misc.info                 = False
    cfg.misc.paranoid             = False
    cfg.misc.bug                  = False
    cfg.misc.logMode              = True
    cfg.misc.verboseLevel1        = True
    cfg.misc.verboseLevel2        = True

import Cfg 
import CRL        
from   CRL               import AllianceFramework, RoutingLayerGauge
from   helpers           import overlay, l, u, n
from   node800.helvellyn import techno, StdCellLib, IoLib

techno.setup()
StdCellLib.setup()
IoLib.setup()
