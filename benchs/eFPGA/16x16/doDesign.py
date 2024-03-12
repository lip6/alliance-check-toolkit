#!/usr/bin/env python3

import sys
import traceback
from   coriolis.Hurricane  import DbU, Breakpoint, Cell
from   coriolis            import CRL
from   coriolis.helpers    import loadUserSettings, setTraceLevel, trace, l, u, n
from   coriolis.helpers.io import ErrorMessage, WarningMessage
loadUserSettings()
from   coriolis            import plugins
from   coriolis.plugins.block.block          import Block
from   coriolis.plugins.block.configuration  import IoPin, GaugeConf
from   coriolis.plugins.block.spares         import Spares
from   coriolis.plugins.core2chip.niolib     import CoreToChip
from   coriolis.plugins.chip.configuration   import ChipConf
from   coriolis.plugins.chip.chip            import Chip


af  = CRL.AllianceFramework.get()
env = af.getEnvironment()
env.addSYSTEM_LIBRARY( library='../efpgalib', mode=CRL.Environment.Prepend )


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af
    rvalue = True
    try:
       #setTraceLevel( 550 )
       #Breakpoint.setStopLevel( 100 )
        buildChip = False
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'matrix_16_16_flat', CRL.Catalog.State.Logical|CRL.Catalog.State.Physical )
        if editor:
            editor.setCell( cell ) 
        ioPadsSpec = []
        ioPinsSpec = []
        conf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        conf.cfg.etesian.densityVariation    = 0.01
        conf.cfg.etesian.aspectRatio         = 1.0
        conf.cfg.etesian.spaceMargin         = 0.20
        conf.cfg.anabatic.globalIterations   = 10
        conf.cfg.anabatic.topRoutingLayer    = 'METAL5'
        conf.cfg.katana.eventsLimit          = 10000000
        conf.cfg.katana.hTracksReservedLocal = 10
        conf.cfg.katana.vTracksReservedLocal = 10
        conf.cfg.katana.hTracksReservedMin   = 5
        conf.cfg.katana.vTracksReservedMin   = 5
        conf.cfg.katana.trackFill            = 0
        conf.cfg.katana.runRealignStage      = True
        conf.cfg.katana.dumpMeasures         = True
        conf.useSpares = False
        conf.editor    = editor
        blockBuilder = Block( conf )
        cell.setTerminalNetlist( False )
        rvalue = blockBuilder.doPnR()
        blockBuilder.save()
    except Exception as e:
        catch( e )
        rvalue = False
    sys.stdout.flush()
    sys.stderr.flush()
    return rvalue


if __name__ == '__main__':
    rvalue = scriptMain()
    shellRValue = 0 if rvalue else 1
    sys.exit( shellRValue )
