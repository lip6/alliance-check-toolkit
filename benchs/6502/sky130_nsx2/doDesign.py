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

CoreName = 'm65'

def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af
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
        m1pitch=l(10)
        m2pitch=l(20)
        ioPinsSpec = [ (IoPin.WEST |IoPin.A_BEGIN, 'data({})'    ,  70*m1pitch, 25*m1pitch,  8)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'datao({})'   ,  80*m1pitch, 25*m1pitch,  8)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'adrs({})'    ,  30*m1pitch, 20*m1pitch, 16)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'm_clock'     , 80*m2pitch,          0 , 1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'p_reset'     , 90*m2pitch,          0 , 1)
                         , (IoPin.NORTH|IoPin.A_BEGIN, 'nmi'    , 100*m2pitch,       0 ,  1)
                         , (IoPin.NORTH|IoPin.A_BEGIN, 'irq'    , 110*m2pitch,       0 ,  1)
                         , (IoPin.SOUTH|IoPin.A_BEGIN, 'rd'     , 20*m2pitch,       0 ,  1)
                         , (IoPin.SOUTH|IoPin.A_BEGIN, 'wt'     , 40*m2pitch,       0 ,  1)
                         , (IoPin.SOUTH|IoPin.A_BEGIN, 'start'  , 80*m2pitch,       0 ,  1)
                         , (IoPin.SOUTH|IoPin.A_BEGIN, 'sync'   , 100*m2pitch,       0 ,  1)
                         , (IoPin.SOUTH|IoPin.A_BEGIN, 'rdy'    , 120*m2pitch,       0 ,  1)
                     ]
        conf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        #conf.cfg.etesian.aspectRatio         = 1.0
        conf.cfg.etesian.spaceMargin         = 0.10
        #conf.cfg.etesian.densityVariation    = 0.05
        #conf.cfg.anabatic.searchHalo         = 2
        conf.cfg.anabatic.globalIterations   = 10
        conf.cfg.anabatic.topRoutingLayer    = 'METAL5'
        conf.cfg.block.spareSide             = l(1000)
        conf.cfg.katana.hTracksReservedMin   = 6
        conf.cfg.katana.vTracksReservedMin   = 5
        conf.cfg.katana.hTracksReservedLocal = 10
        conf.cfg.katana.vTracksReservedLocal = 7 
        conf.cfg.katana.termSatReservedLocal = 6 
        conf.cfg.katana.termSatThreshold     = 9 
        conf.cfg.katana.trackFill            = 0
        conf.cfg.katana.runRealignStage      = True
        conf.cfg.katana.dumpMeasures         = False
        conf.useSpares = True
        conf.useHFNS   = False
        conf.useHTree( 'm_clock', Spares.HEAVY_LEAF_LOAD )
        conf.coreSize =  ( l( 3600.0), l( 3600.0) )
        conf.editor = editor
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
