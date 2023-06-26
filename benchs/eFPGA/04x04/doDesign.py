#!/usr/bin/env python3

import sys
import traceback
from   coriolis import CRL
from   coriolis import helpers
helpers.loadUserSettings()
from   coriolis.helpers.io import ErrorMessage, WarningMessage
from   coriolis.helpers    import trace, l, u, n
from   coriolis            import plugins
from   coriolis.Hurricane  import DbU, Breakpoint, Cell
from   coriolis.plugins.block.block          import Block
from   coriolis.plugins.block.configuration  import IoPin, GaugeConf
from   coriolis.plugins.block.spares         import Spares
from   coriolis.plugins.core2chip.niolib     import CoreToChip
from   coriolis.plugins.chip.configuration   import ChipConf
from   coriolis.plugins.chip.chip            import Chip


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
        cell = af.getCell( 'matrix_4_4_flat', CRL.Catalog.State.Logical|CRL.Catalog.State.Physical )
        if editor:
            editor.setCell( cell ) 
        ioPadsSpec = []
        ioPinsSpec = []
        conf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        conf.cfg.anabatic.globalIterations   = 10
        conf.cfg.anabatic.topRoutingLayer    = 'METAL5'
       #conf.cfg.katana.hTracksReservedLocal = 0
       #conf.cfg.katana.vTracksReservedLocal = 0
        conf.cfg.katana.hTracksReservedMin   = 7
        conf.cfg.katana.vTracksReservedMin   = 5
        conf.cfg.katana.trackFill            = 0
        conf.cfg.katana.runRealignStage      = True
        conf.cfg.katana.dumpMeasures         = True
        conf.useSpares = False
        conf.useHFNS   = False
        conf.editor = editor
        blockBuilder = Block( conf )
        cell.setTerminalNetlist( False )
        rvalue = blockBuilder.doPnR()
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
