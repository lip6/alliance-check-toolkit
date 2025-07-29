# -*- Mode:Python -*-

import os
import socket
from   coriolis import helpers

NdaDirectory = None
if 'NDA_TOP' in os.environ:
    NdaDirectory = os.environ['NDA_TOP']
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

from   coriolis                 import Cfg
from   coriolis.CRL             import AllianceFramework, RoutingLayerGauge
from   coriolis.helpers         import overlay, l, u, n
from   NDA.node45.freepdk45_c4m import techno, FlexLib, LibreSOCIO

techno.setup()
FlexLib.setup()
LibreSOCIO.setup()

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
    cfg.etesian.graphics         = 3
    cfg.etesian.spaceMargin      = 0.10
    cfg.anabatic.topRoutingLayer = 'metal6'
    cfg.katana.eventsLimit       = 4000000
    af  = AllianceFramework.get()
    lg5 = af.getRoutingGauge('FlexLib').getLayerGauge( 5 )
    lg5.setType( RoutingLayerGauge.PowerSupply )
    env = af.getEnvironment()
    env.setCLOCK( '^sys_clk$|^ck|^jtag_tck$' )
