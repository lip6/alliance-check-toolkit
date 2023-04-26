
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
    helpers.setTraceLevel( 610 )
    global af
    rvalue = True
    try:
        with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
            cfg.misc.catchCore            = False
            cfg.misc.minTraceLevel        = 15900
            cfg.misc.maxTraceLevel        = 16000 
           #cfg.misc.minTraceLevel        = 13000
           #cfg.misc.maxTraceLevel        = 13100 
            cfg.anabatic.globalIterations = 3
            cfg.katana.eventsLimit        = 800000
        
        sram = SRAM_256x32( 1 )
        sram.placeAt()
       #sram.showTree()
        cell, editor = plugins.kwParseMain( **kw )
        if editor:
            editor.setCell( sram.cell ) 
            editor.setDbuMode( DbU.StringModePhysical )
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
