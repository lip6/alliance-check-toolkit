#!/usr/bin/env python3

import sys
import traceback
import CRL
import helpers
helpers.loadUserSettings()
from   helpers.io import ErrorMessage, WarningMessage
from   helpers    import trace, l, u, n
import plugins
from   Hurricane  import DbU, Breakpoint, Cell
from   plugins.alpha.block.block          import Block
from   plugins.alpha.block.configuration  import IoPin, GaugeConf
from   plugins.alpha.block.spares         import Spares
from   plugins.alpha.core2chip.niolib     import CoreToChip
from   plugins.alpha.chip.configuration   import ChipConf
from   plugins.alpha.chip.chip            import Chip


af = CRL.AllianceFramework.get()


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af
    rvalue = True
    try:
       #helpers.setTraceLevel( 550 )
       #Breakpoint.setStopLevel( 100 )
        buildChip = False
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'operator_lvl0_flat', CRL.Catalog.State.Logical|CRL.Catalog.State.Physical )
        if editor:
            editor.setCell( cell ) 
        ioPadsSpec = []
        ioPinsSpec = []
        conf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        conf.cfg.anabatic.globalIterations   = 10
        conf.cfg.anabatic.topRoutingLayer    = 'METAL5'
        conf.cfg.katana.hTracksReservedLocal = 10
       #conf.cfg.katana.vTracksReservedLocal = 0
        conf.cfg.katana.hTracksReservedMin   = 7
        conf.cfg.katana.vTracksReservedMin   = 5
        conf.cfg.katana.trackFill            = 0
        conf.cfg.katana.runRealignStage      = True
        conf.cfg.katana.dumpMeasures         = True
        conf.editor = editor
        blockBuilder = Block( conf )
        cell.setTerminalNetlist( False )
        rvalue = blockBuilder.route()
        blockBuilder.save()
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
