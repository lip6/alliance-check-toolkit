#!/usr/bin/env python3

import sys
import os
import traceback
import Cfg
import helpers
helpers.loadUserSettings()
from   helpers.io import ErrorMessage, WarningMessage
from   helpers    import trace, overlay, l, u, n
import plugins
from   Hurricane  import DbU, Breakpoint
import Viewer
import CRL
import Etesian
import Anabatic
import Katana


af = CRL.AllianceFramework.get()


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af
    rvalue = True
    try:
       #helpers.setTraceLevel( 540 )
       #Breakpoint.setStopLevel( 100 )
        with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
            cfg.misc.catchCore              = False
            cfg.misc.info                   = False
            cfg.misc.paranoid               = False
            cfg.misc.bug                    = False
            cfg.misc.logMode                = True
            cfg.misc.verboseLevel1          = True
            cfg.misc.verboseLevel2          = True
            cfg.misc.minTraceLevel          = 15900
            cfg.misc.maxTraceLevel          = 16000
            cfg.etesian.uniformDensity      = True
            cfg.etesian.effort              = 2
            cfg.etesian.aspectRatio         = 2.0
            cfg.anabatic.routingGauge       = 'nsxlib-2M'
            cfg.anabatic.netBuilderStyle    = '2RL-'
            cfg.anabatic.topRoutingLayer    = 'METAL2'
            cfg.katana.eventsLimit          = 1000000
            Viewer.Graphics.setStyle( 'Alliance.Classic [black]' )
            af  = CRL.AllianceFramework.get()
            env = af.getEnvironment()
            env.setCLOCK( '^ck$|m_clock|^clk$' )
           #env.addSYSTEM_LIBRARY( library=cellsTop+'/nsxlib', mode=CRL.Environment.Prepend )
           #env.addSYSTEM_LIBRARY( library=cellsTop+'/niolib', mode=CRL.Environment.Prepend )

        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'snx', CRL.Catalog.State.Logical )
        if editor:
            editor.setCell( cell ) 
        etesian = Etesian.EtesianEngine.create( cell )
        etesian.place()
        etesian.toHurricane()
       #etesian.flattenPower()
        etesian.destroy()
        if editor: editor.fit()
        katana = Katana.KatanaEngine.create( cell )
       #katana.printConfiguration   ()
        katana.digitalInit          ()
        katana.runGlobalRouter( Katana.Flags.NoFlags )
        if editor: editor.fit()
        katana.loadGlobalRouting( Anabatic.EngineLoadGrByNet )
        katana.runNegociate     ( Katana.Flags.NoFlags )
        success = katana.isDetailedRoutingSuccess()
        Breakpoint.stop( 0, 'P&R done (success={}). About to destroy Katana.'.format(success) )
        katana.finalizeLayout()
        katana.destroy()
    except Exception as e:
        helpers.io.catch( e )
        rvalue = False
    sys.stdout.flush()
    sys.stderr.flush()
    return rvalue


if __name__ == '__main__':
    rvalue = scriptMain()
    shellRValue = 0 if rvalue else 1
    sys.exit( shellRValue )
