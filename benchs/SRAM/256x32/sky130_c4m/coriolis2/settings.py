# -*- Mode:Python -*-

import os
import socket
from coriolis import helpers

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

from coriolis         import Cfg
from coriolis.CRL     import AllianceFramework, RoutingLayerGauge
from coriolis.helpers import overlay, l, u, n
from node130.sky130   import techno, StdCellLib #, LibreSOCIO

techno.setup()
StdCellLib.setup()
#LibreSOCIO.setup()

