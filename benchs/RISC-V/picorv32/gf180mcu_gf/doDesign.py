#!/usr/bin/env python3

import sys
import os
import traceback
from   coriolis            import Cfg, CRL
from   coriolis.Hurricane  import DbU, Breakpoint, DataBase, Library
from   coriolis.helpers.io import ErrorMessage, WarningMessage, catch
from   coriolis.helpers    import loadUserSettings, setTraceLevel, overlay, trace, l, u, n
loadUserSettings()
from   coriolis            import plugins
from   coriolis.plugins.block.block          import Block
from   coriolis.plugins.block.configuration  import IoPin, GaugeConf
from   coriolis.plugins.block.spares         import Spares
from   coriolis.plugins.chip.configuration   import ChipConf
from   coriolis.plugins.chip.chip            import Chip
from   pdks.gf180mcu.core2chip.gf180mcu      import CoreToChip

buildChip = False
af        = CRL.AllianceFramework.get()


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""

    global af, buildChip
    loadOpenROAD = False
    rvalue       = True
    gaugeName    = None
    with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
        cfg.misc.verboseLevel1    = True
        cfg.misc.verboseLevel2    = True
        cfg.misc.logMode          = True
        cfg.anabatic.routingGauge = None   # Trigger disk loading.
        gaugeName = cfg.anabatic.routingGauge
    try:
        #setTraceLevel( 540 )
        #Breakpoint.setStopLevel( 99 )

        if loadOpenROAD:
            db      = DataBase.getDB()
            tech    = db.getTechnology()
            rootlib = db.getRootLibrary()
            orLib   = Library.create(rootlib, 'OpenROAD')
            gdsPath = '../OpenROAD/picorv32_gf180mcu.gds'
            print( '  o  Loading OpenROAD layout "{}"'.format( gdsPath ))
            CRL.Gds.load( orLib, gdsPath, CRL.Gds.Layer_0_IsBoundary|CRL.Gds.NoBlockages )
            af.wrapLibrary( orLib, 1 ) 
            cell, editor = plugins.kwParseMain( **kw )
            cell = af.getCell( 'picorv32', CRL.Catalog.State.Logical )
            if editor:
                editor.setCell( cell ) 
                editor.setDbuMode( DbU.StringModePhysical )
            return True

        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'picorv32', CRL.Catalog.State.Logical )
        if not cell:
            cell = CRL.Blif.load( 'picorv32' )
        if editor:
            editor.setCell( cell ) 
            editor.setDbuMode( DbU.StringModePhysical )
        if buildChip:
            ioPinsSpec = [ ]
            ioPadsSpec = [ ]
        else:
            vspace     = 6
            hspace     = 5
            ioPadsSpec = [ ]
            ioPinsSpec = [ (IoPin.NORTH|IoPin.A_BEGIN, 'trace_data({})'  ,     vspace, vspace, range(0, 36))
                         , (IoPin.NORTH|IoPin.A_BEGIN, 'mem_la_wdata({})',  38*vspace, vspace, range(0, 32))
                         , (IoPin.NORTH|IoPin.A_BEGIN, 'mem_la_addr({})' ,  70*vspace, vspace, range(0, 32))
                         , (IoPin.SOUTH|IoPin.A_BEGIN, 'eoi({})'         ,     vspace, vspace, range(0, 32))
                         , (IoPin.SOUTH|IoPin.A_BEGIN, 'mem_addr({})'    ,  33*vspace, vspace, range(0, 32))
                         , (IoPin.SOUTH|IoPin.A_BEGIN, 'mem_wdata({})'   ,  65*vspace, vspace, range(0, 32))
                         , (IoPin.SOUTH|IoPin.A_BEGIN, 'mem_rdata({})'   ,  97*vspace, vspace, range(0,  4))
                         , (IoPin.EAST |IoPin.A_BEGIN, 'mem_rdata({})'   ,     hspace+5, hspace, range(4, 32))
                         , (IoPin.EAST |IoPin.A_BEGIN, 'irq({})'         ,  33*hspace, hspace, range(0, 32))
                         , (IoPin.EAST |IoPin.A_BEGIN, 'pcpi_insn({})'   ,  65*hspace, hspace, range(0, 32))
                         , (IoPin.EAST |IoPin.A_BEGIN, 'pcpi_rs1({})'    ,  97*hspace, hspace, range(0,  8))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'pcpi_rs1({})'    ,     hspace, hspace, range(8, 32))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'pcpi_rd({})'     ,  33*hspace, hspace, range(0, 32))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'pcpi_rs2({})'    ,  97*hspace, hspace, range(8, 32))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'mem_wstrb({})'   , 121*hspace, hspace, range(0,  4))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'mem_la_wstrb({})', 125*hspace, hspace, range(0,  4))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'mem_la_write'    , 129*hspace, 0, 1)
                         , (IoPin.WEST |IoPin.A_BEGIN, 'trap'            , 130*hspace, 0, 1)
                         , (IoPin.WEST |IoPin.A_BEGIN, 'resetn'          , 131*hspace, 0, 1)
                         , (IoPin.WEST |IoPin.A_BEGIN, 'mem_instr'       , 132*hspace, 0, 1)
                         , (IoPin.WEST |IoPin.A_BEGIN, 'mem_valid'       , 133*hspace, 0, 1)
                         , (IoPin.WEST |IoPin.A_BEGIN, 'mem_la_read'     , 134*hspace, 0, 1)
                         , (IoPin.WEST |IoPin.A_BEGIN, 'pcpi_wr'         , 135*hspace, 0, 1)
                         , (IoPin.WEST |IoPin.A_BEGIN, 'pcpi_wait'       , 136*hspace, 0, 1)
                         , (IoPin.WEST |IoPin.A_BEGIN, 'trace_valid'     , 137*hspace, 0, 1)
                         , (IoPin.WEST |IoPin.A_BEGIN, 'mem_ready'       , 138*hspace, 0, 1)
                         , (IoPin.WEST |IoPin.A_BEGIN, 'clk'             , 139*hspace, 0, 1)
                         , (IoPin.WEST |IoPin.A_BEGIN, 'pcpi_valid'      , 140*hspace, 0, 1)
                         , (IoPin.WEST |IoPin.A_BEGIN, 'pcpi_ready'      , 141*hspace-6, 0, 1)]
            #connectors placement in block design
        conf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        conf.cfg.tramontana.mergeSupplies    = True
        conf.cfg.etesian.bloat               = 'disabled'
        conf.cfg.etesian.densityVariation    = 0.05
        conf.cfg.etesian.aspectRatio         = 1.1
       # etesian.spaceMargin is ignored if the coreSize is directly set.
       #conf.cfg.etesian.spaceMargin         = 0.10
       #conf.cfg.anabatic.searchHalo         = 2
        conf.cfg.anabatic.globalIterations   = 15
        conf.cfg.katana.hTracksReservedLocal = 11
        conf.cfg.katana.vTracksReservedLocal = 10
        conf.cfg.katana.hTracksReservedMin   = 9
        conf.cfg.katana.vTracksReservedMin   = 7
        conf.cfg.katana.trackFill            = 0
        conf.cfg.katana.runRealignStage      = False
        conf.cfg.block.spareSide             = 8*conf.sliceHeight
        #conf.cfg.block.upperEastWestPins     = True
        conf.cfg.chip.padCoreSide            = 'North'
        conf.editor              = editor
        conf.ioPinsInTracks      = True
        conf.useSpares           = True
        conf.useHFNS             = True
        conf.bColumns            = 2
        conf.bRows               = 2
        conf.chipName            = 'chip'
        conf.coreToChipClass     = CoreToChip
        conf.coreSize            = conf.computeCoreSize( 122*conf.sliceHeight, 1.0 )
        conf.chipSize            = ( u( 8*85 + 2*270.0), u( 8*85 + 2*300.0) )
        conf.doLvx               = 'corona'
        conf.useHTree( 'clk', Spares.HEAVY_LEAF_LOAD )
        conf.useHTree( 'resetn' )
        if buildChip:
            chipBuilder = Chip( conf )
            chipBuilder.doChipNetlist()
            chipBuilder.doChipFloorplan()
            if editor:
                editor.setCell( conf.chip )
            rvalue = chipBuilder.doPnR()
            chipBuilder.save()
        else:
            blockBuilder = Block( conf )
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
