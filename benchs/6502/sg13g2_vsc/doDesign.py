#!/usr/bin/env python3

import sys
import traceback
from   coriolis.Hurricane  import DbU, Breakpoint, Cell
from   coriolis            import CRL
from   coriolis.helpers.io import ErrorMessage, WarningMessage, catch
from   coriolis.helpers    import loadUserSettings, setTraceLevel, trace, l, u, n
loadUserSettings()
from   coriolis            import plugins
from   coriolis.plugins.block.block         import Block
from   coriolis.plugins.block.configuration import IoPin, GaugeConf
from   coriolis.plugins.block.spares        import Spares
from   coriolis.plugins.core2chip.niolib    import CoreToChip
from   coriolis.plugins.chip.configuration  import ChipConf
from   coriolis.plugins.chip.chip           import Chip


af = CRL.AllianceFramework.get()

CoreName='m65s'

def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af, CoreName
    DbU.setStringMode( DbU.StringModeSymbolic )
    rvalue = True
    try:
        #setTraceLevel( 550 )
        #Breakpoint.setStopLevel( 100 )
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( CoreName, CRL.Catalog.State.Logical )
        af.saveCell( cell, CRL.Catalog.State.Logical )
        if editor:
            editor.setCell( cell ) 
        ioPadsSpec = []
        m1pitch = l(8.0)
        m2pitch = l(8.0)
        ioPinsSpec = [ (IoPin.WEST |IoPin.A_BEGIN, 'data({})'    ,  110*m1pitch, 20*m1pitch,  8)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'datao({})'   ,  120*m1pitch, 20*m1pitch,  8)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'adrs({})'    ,  100*m1pitch, 20*m1pitch, 16)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'm_clock'     , l(2004),       0 , 1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'p_reset'     , l(2084),       0 , 1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'nmi'         , l(2204),       0 , 1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'irq'         , l(2284),       0 , 1)
                     , (IoPin.SOUTH|IoPin.A_BEGIN, 'rd'          , l(2004),       0 , 1)
                     , (IoPin.SOUTH|IoPin.A_BEGIN, 'wt'          , l(2084),       0 , 1)
                     , (IoPin.SOUTH|IoPin.A_BEGIN, 'start'       , l(2204),       0 , 1)
                     , (IoPin.SOUTH|IoPin.A_BEGIN, 'sync'        , l(2284),       0 , 1)
                     , (IoPin.SOUTH|IoPin.A_BEGIN, 'rdy'         , l(2404),       0 , 1)
                     ]
        conf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        conf.cfg.anabatic.globalIterations   = 100
        conf.cfg.anabatic.topRoutingLayer    = 'METAL5'
        conf.cfg.block.spareSide             = l(800)
        conf.cfg.katana.hTracksReservedMin   = 4
        conf.cfg.katana.vTracksReservedMin   = 4
        conf.cfg.katana.hTracksReservedLocal = 4
        conf.cfg.katana.vTracksReservedLocal = 4 
        conf.cfg.katana.termSatReservedLocal = 6 
        conf.cfg.katana.termSatThreshold     = 9 
        conf.cfg.katana.trackFill            = False
        conf.cfg.katana.runRealignStage      = True
        conf.cfg.katana.dumpMeasures         = False
        conf.useSpares = True
        conf.useHFNS   = False
        conf.useHTree( 'm_clock', Spares.HEAVY_LEAF_LOAD )
        conf.coreSize  = ( l( 5800.0), l( 5800.0) )
        conf.editor    = editor
        blockBuilder   = Block( conf )
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
