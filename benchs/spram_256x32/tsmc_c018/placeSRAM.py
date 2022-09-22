
import sys
import traceback
from   pathlib    import Path
import Cfg
import CRL
import helpers
helpers.loadUserSettings()
from   helpers.io import ErrorMessage, WarningMessage
from   helpers    import overlay, trace, l, u, n
import plugins
from   Hurricane  import DebugSession, DbU, Breakpoint
from   plugins.alpha.block.block          import Block
from   plugins.alpha.block.configuration  import IoPin, GaugeConf
from   plugins.alpha.block.spares         import Spares
from   plugins.alpha.core2chip.libresocio import CoreToChip
from   plugins.alpha.chip.configuration   import ChipConf
from   plugins.alpha.chip.chip            import Chip
#from   plugins.sramplacer1                import SRAMPlacer
from   plugins.sramplacer2                import SRAMPlacer


af = CRL.AllianceFramework.get()


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    helpers.setTraceLevel( 610 )
    global af
    rvalue = True
    try:
        with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
            cfg.misc.catchCore            = False
            cfg.misc.minTraceLevel        = 13000
            cfg.misc.maxTraceLevel        = 13100 
            cfg.anabatic.globalIterations = 3
            cfg.katana.eventsLimit        = 800000
        
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'eth_spram_256x32', CRL.Catalog.State.Logical )
        if editor:
            editor.setCell( cell ) 
            editor.setDbuMode( DbU.StringModePhysical )
        placer = SRAMPlacer( cell )
        placer.findMemBits()
        placer.findHighFanout()
        placer.findDecodDff()
        placer.findDecod()
        placer.findInputMuxes()
        placer.findOutputMuxes()
        placer.placeAt()
        placer.show()
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
