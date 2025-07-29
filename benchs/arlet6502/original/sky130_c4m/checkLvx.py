#!/usr/bin/env python3

import sys
import traceback
from   coriolis.Hurricane  import DbU, Breakpoint, PythonAttributes
from   coriolis            import Cfg, CRL
from   coriolis.helpers    import loadUserSettings, setTraceLevel, overlay, trace, l, u, n
from   coriolis.helpers.io import ErrorMessage, WarningMessage, catch
loadUserSettings()
from   coriolis            import plugins
from   coriolis.Tramontana import TramontanaEngine


af = CRL.AllianceFramework.get()


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
        cfg.misc.catchCore              = False
        cfg.misc.info                   = False
        cfg.misc.paranoid               = False
        cfg.misc.bug                    = False
        cfg.misc.logMode                = True
        cfg.misc.verboseLevel1          = True
        cfg.misc.verboseLevel2          = True
        cfg.misc.minTraceLevel          = 1900
        cfg.misc.maxTraceLevel          = 3000

    global af
    rvalue = True
   #try:
       #setTraceLevel( 550 )
       #Breakpoint.setStopLevel( 100 )
    cell, editor = plugins.kwParseMain( **kw )
    cell = af.getCell( 'buf_x4', CRL.Catalog.State.Views )
   #cell = af.getCell( 'sff1_x4', CRL.Catalog.State.Views )
   #cell = af.getCell( 'tie_x0', CRL.Catalog.State.Views )
    if editor:
        editor.setCell( cell ) 
        editor.setDbuMode( DbU.StringModePhysical )
    print( 'Running tramontana' )
    tramontana = TramontanaEngine.create( cell )
    tramontana.extract()
   #except Exception as e:
   #    catch( e )
   #    rvalue = False
    sys.stdout.flush()
    sys.stderr.flush()
    return rvalue


if __name__ == '__main__':
    rvalue = scriptMain()
    shellRValue = 0 if rvalue else 1
    sys.exit( shellRValue )
