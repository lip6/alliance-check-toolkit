
import sys
import traceback
from   pathlib    import Path
from   coriolis   import Cfg, CRL, Viewer, Katana, Anabatic, helpers, plugins
helpers.loadUserSettings()
from   coriolis.helpers.io               import ErrorMessage, WarningMessage
from   coriolis.helpers                  import overlay, trace, l, u, n
from   coriolis.Hurricane                import DebugSession, DbU, Breakpoint
from   coriolis.plugins.rsave            import rsave
from   coriolis.plugins.sram.sram_256x32 import SRAM_256x32


af = CRL.AllianceFramework.get()


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    helpers.setTraceLevel( 610 )
    Breakpoint.setStopLevel( 100 )
    global af
    rvalue = True
    try:
        with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
            cfg.misc.catchCore              = False
            cfg.misc.info                   = False
            cfg.misc.paranoid               = False
            cfg.misc.bug                    = False
            cfg.misc.logMode                = False
            cfg.misc.verboseLevel1          = True
            cfg.misc.verboseLevel2          = True
           #cfg.misc.minTraceLevel          = 15900
           #cfg.misc.maxTraceLevel          = 16000 
            cfg.anabatic.globalIterations   = 3
            cfg.katana.eventsLimit          = 800000
            cfg.katana.hTracksReservedLocal = 3
            cfg.katana.vTracksReservedLocal = 5
            cfg.katana.hTracksReservedMin   = 3
            cfg.katana.vTracksReservedMin   = 5
            Viewer.Graphics.setStyle( 'Alliance.Classic [black]' )
            env = af.getEnvironment()
            env.setCLOCK( '^ck$|m_clock|^clk$' )
        
        sram = SRAM_256x32( 4 )
        sram.placeAt()
       #sram.showTree()
        for netName in ( 'oe', ):
            net = sram.cell.getNet( netName )
            if net:
                print( 'Destroying unconnected net "oe".' )
                net.destroy()

        cell, editor = plugins.kwParseMain( **kw )
        if editor:
            editor.setPixelThreshold( 3 )
            editor.setCell( sram.cell ) 
            editor.fit()
        Breakpoint.stop( 100, 'SRAM 256x32 generated.' )

        katana = Katana.KatanaEngine.create( sram.cell )
        katana.digitalInit       ()
        katana.runGlobalRouter  ( Katana.Flags.NoFlags )
        Breakpoint.stop( 100, 'Global routing done.' )
        katana.loadGlobalRouting( Anabatic.EngineLoadGrByNet )
        katana.layerAssign      ( Anabatic.EngineNoNetLayerAssign )
        katana.runNegociate     ( Katana.Flags.NoFlags )
        success = katana.isDetailedRoutingSuccess()
        Breakpoint.stop( 100, 'Detailed routing done, success:{}.'.format(success) )
        katana.finalizeLayout()
        katana.destroy()
        rsave( sram.cell, CRL.Catalog.State.Views )
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
