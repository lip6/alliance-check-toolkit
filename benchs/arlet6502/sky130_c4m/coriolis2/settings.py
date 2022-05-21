# -*- Mode:Python -*-

import os
import socket
import helpers

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

import Cfg
from   CRL       import AllianceFramework, RoutingLayerGauge
from   helpers   import overlay, l, u, n
from   node130.sky130 import techno, StdCellLib #, LibreSOCIO

techno.setup()
StdCellLib.setup()
#LibreSOCIO.setup()

af = AllianceFramework.get()

with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
    cfg.misc.catchCore           = False
    cfg.misc.minTraceLevel       = 12300
    cfg.misc.maxTraceLevel       = 12400
    cfg.misc.info                = False
    cfg.misc.paranoid            = False
    cfg.misc.bug                 = False
    cfg.misc.logMode             = True
    cfg.misc.verboseLevel1       = True
    cfg.misc.verboseLevel2       = True
    cfg.etesian.graphics         = 2
    cfg.anabatic.topRoutingLayer = 'm4'
    cfg.katana.eventsLimit       = 4000000
    af  = AllianceFramework.get()
    lg5 = af.getRoutingGauge('StdCellLib').getLayerGauge( 5 )
    lg5.setType( RoutingLayerGauge.PowerSupply )
    env = af.getEnvironment()
    env.setCLOCK( '^sys_clk$|^ck|^jtag_tck$' )
