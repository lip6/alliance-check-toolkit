
import sys
import traceback
from   pathlib    import Path
from   coriolis   import Cfg, CRL, helpers
helpers.loadUserSettings()
from   coriolis.helpers.io import ErrorMessage, WarningMessage
from   coriolis.helpers    import overlay, trace, l, u, n
from   coriolis            import plugins
from   coriolis.Hurricane  import DebugSession, DbU, Breakpoint
from   coriolis.plugins.block.block          import Block
from   coriolis.plugins.block.configuration  import IoPin, GaugeConf
from   coriolis.plugins.block.spares         import Spares
from   coriolis.plugins.core2chip.libresocio import CoreToChip
from   coriolis.plugins.chip.configuration   import ChipConf
from   coriolis.plugins.chip.chip            import Chip
from   coriolis.plugins.sram.sram_256x32     import SRAM_256x32


af = CRL.AllianceFramework.get()


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af

    helpers.setTraceLevel( 610 )
    rvalue = True
    try:
        with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
            cfg.misc.catchCore            = False
            cfg.misc.info                 = False
            cfg.misc.paranoid             = False
            cfg.misc.bug                  = False
            cfg.misc.logMode              = False
            cfg.misc.verboseLevel1        = True
            cfg.misc.verboseLevel2        = True
            cfg.etesian.graphics          = 2
            cfg.anabatic.topRoutingLayer  = 'm4'
            cfg.misc.minTraceLevel        = 15900
            cfg.misc.maxTraceLevel        = 16000 
           #cfg.misc.minTraceLevel        = 13000
           #cfg.misc.maxTraceLevel        = 13100 
            cfg.anabatic.globalIterations = 3
            cfg.katana.eventsLimit        = 800000
            lg5 = af.getRoutingGauge('StdCellLib').getLayerGauge( 5 ) 
            lg5.setType( CRL.RoutingLayerGauge.PowerSupply )
            env = af.getEnvironment()
            env.setCLOCK( '^sys_clk$|^ck|^jtag_tck$' )
        
        sram = SRAM_256x32( 4 )
        sram.placeAt()
        CRL.Gds.save( sram.cell )
       #sram.showTree()
        cell, editor = plugins.kwParseMain( **kw )
        if editor:
            editor.setDbuMode( DbU.StringModePhysical )
            editor.setPixelThreshold( 5 )
            editor.setCell( sram.cell ) 
        if editor: editor.fit()
    except Exception as e:
        helpers.io.catch( e )
        rvalue = False
    return rvalue


if __name__ == '__main__':
    rvalue = scriptMain()
    sys.stdout.flush()
    sys.stderr.flush()
    shellRValue = 0 if rvalue else 1
    sys.exit( shellRValue )
