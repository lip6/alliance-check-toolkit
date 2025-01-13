#!/usr/bin/env python3

import sys
import os
import traceback
from   coriolis            import Cfg, CRL
from   coriolis.Hurricane  import DbU, Breakpoint
from   coriolis.helpers.io import ErrorMessage, WarningMessage, catch
from   coriolis.helpers    import loadUserSettings, setTraceLevel, overlay, trace, l, u, n
loadUserSettings()
from   coriolis            import plugins
from   coriolis.plugins.block.block          import Block
from   coriolis.plugins.block.configuration  import IoPin, GaugeConf
from   coriolis.plugins.block.spares         import Spares
from   coriolis.plugins.chip.configuration   import ChipConf
from   coriolis.plugins.chip.chip            import Chip
from   pdks.ihpsg13g2_c4m.core2chip.sg13g2io import CoreToChip
af = CRL.AllianceFramework.get()



def scriptMain ( **kw ):

    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af
    rvalue    = True
    gaugeName = None
    with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
        cfg.misc.catchCore              = False
        cfg.misc.info                   = False
        cfg.misc.paranoid               = False
        cfg.misc.bug                    = False
        cfg.misc.logMode                = True
        cfg.misc.verboseLevel1          = True
        cfg.misc.verboseLevel2          = True
        cfg.misc.minTraceLevel          = 16000
        cfg.misc.maxTraceLevel          = 17000
        cfg.anabatic.routingGauge       = None   # Trigger disk loading.
        gaugeName = cfg.anabatic.routingGauge
    try:
        #setTraceLevel( 540 )
        #Breakpoint.setStopLevel( 99 )
        buildChip = False
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
            hpitch       = 0
            vpitch       = 0
            routingGauge = af.getRoutingGauge( gaugeName )
            for layerGauge in routingGauge.getLayerGauges():
                if layerGauge.getType() in [ CRL.RoutingLayerGauge.PinOnly
                                           , CRL.RoutingLayerGauge.Unusable
                                           , CRL.RoutingLayerGauge.BottomPowerSupply ]:
                    continue
                if not hpitch and layerGauge.getDirection() == CRL.RoutingLayerGauge.Horizontal:
                    hpitch = layerGauge.getPitch()
                if not vpitch and layerGauge.getDirection() == CRL.RoutingLayerGauge.Vertical:
                    vpitch = layerGauge.getPitch()
            sliceHeight = af.getCellGauge().getSliceHeight()
            sliceStep   = af.getCellGauge().getSliceStep  ()
            print( '  o  Looked up gauge/pitch values.' )
            print( '     - hpitch: {:>20}.'     .format( DbU.getValueString( hpitch ) ))
            print( '     - vpitch: {:>20}.'     .format( DbU.getValueString( vpitch ) ))
            print( '     - sliceHeight: {:>15}.'.format( DbU.getValueString( sliceHeight ) ))
            print( '     - sliceStep: {:>17}.'  .format( DbU.getValueString( sliceStep ) ))
            vpitchedSliceHeight = sliceHeight - sliceHeight%hpitch
            hpitchedSliceHeight = sliceHeight - sliceHeight%vpitch
            vspace     = vpitch * 9
            hspace     = hpitch * 7
            ioPadsSpec = [ ]
            ioPinsSpec = [ (IoPin.NORTH|IoPin.A_BEGIN, 'trace_data({})'  ,     vspace, vspace, range(0, 36))
                         , (IoPin.NORTH|IoPin.A_BEGIN, 'mem_la_wdata({})',  38*vspace, vspace, range(0, 32))
                         , (IoPin.NORTH|IoPin.A_BEGIN, 'mem_la_addr({})' ,  70*vspace, vspace, range(0, 32))
                         , (IoPin.SOUTH|IoPin.A_BEGIN, 'eoi({})'         ,     vspace, vspace, range(0, 32))
                         , (IoPin.SOUTH|IoPin.A_BEGIN, 'mem_addr({})'    ,  33*vspace, vspace, range(0, 32))
                         , (IoPin.SOUTH|IoPin.A_BEGIN, 'mem_wdata({})'   ,  65*vspace, vspace, range(0, 32))
                         , (IoPin.SOUTH|IoPin.A_BEGIN, 'mem_rdata({})'   ,  97*vspace, vspace, range(0,  4))
                         , (IoPin.EAST |IoPin.A_BEGIN, 'mem_rdata({})'   ,     hspace+5*hpitch, hspace, range(4, 32))
                         , (IoPin.EAST |IoPin.A_BEGIN, 'irq({})'         ,  33*hspace, hspace, range(0, 32))
                         , (IoPin.EAST |IoPin.A_BEGIN, 'pcpi_insn({})'   ,  65*hspace, hspace, range(0, 32))
                         , (IoPin.EAST |IoPin.A_BEGIN, 'pcpi_rs1({})'    ,  97*hspace, hspace, range(0,  8))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'pcpi_rs1({})'    ,     hspace, hspace, range(8, 32))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'pcpi_rd({})'     ,  33*hspace, hspace, range(0, 32))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'pcpi_rs2({})'    ,  97*hspace, hspace, range(8, 32))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'mem_wstrb({})'   , 121*hspace, hspace, range(0,  4))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'mem_la_wstrb({})', 125*hspace, hspace, range(0,  4))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'mem_la_write'    , 129*hspace, 0, range(0, 1))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'trap'            , 130*hspace, 0, range(0, 1))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'resetn'          , 131*hspace, 0, range(0, 1))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'mem_instr'       , 132*hspace, 0, range(0, 1))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'mem_valid'       , 133*hspace, 0, range(0, 1))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'mem_la_read'     , 134*hspace, 0, range(0, 1))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'pcpi_wr'         , 135*hspace, 0, range(0, 1))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'pcpi_wait'       , 136*hspace, 0, range(0, 1))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'trace_valid'     , 137*hspace, 0, range(0, 1))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'mem_ready'       , 138*hspace, 0, range(0, 1))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'clk'             , 139*hspace, 0, range(0, 1))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'pcpi_valid'      , 140*hspace, 0, range(0, 1))
                         , (IoPin.WEST |IoPin.A_BEGIN, 'pcpi_ready'      , 141*hspace-6*hpitch, 0, range(0, 1))]
            #connectors placement in block design
        designConf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        designConf.cfg.tramontana.mergeSupplies    = True
        designConf.cfg.etesian.bloat               = 'disabled'
       #designConf.cfg.etesian.bloat               = 'nsxlib'
        designConf.cfg.etesian.densityVariation    = 0.05
        designConf.cfg.etesian.aspectRatio         = 1.0
       # etesian.spaceMargin is ignored if the coreSize is directly set.
       #designConf.cfg.etesian.spaceMargin         = 0.10
       #designConf.cfg.anabatic.searchHalo         = 2
        designConf.cfg.anabatic.globalIterations   = 15
        designConf.cfg.katana.hTracksReservedLocal = 15
        designConf.cfg.katana.vTracksReservedLocal = 15
        designConf.cfg.katana.hTracksReservedMin   = 7
        designConf.cfg.katana.vTracksReservedMin   = 5
        designConf.cfg.katana.trackFill            = 0
        designConf.cfg.katana.runRealignStage      = False
        designConf.cfg.block.spareSide             = 10*sliceHeight
        designConf.cfg.chip.padCoreSide            = 'North'
        designConf.editor              = editor
        designConf.useSpares           = True
        designConf.useHFNS             = True
        designConf.bColumns            = 2
        designConf.bRows               = 2
        designConf.chipName            = 'chip'
        designConf.chipConf.ioPadGauge = 'IOPadLib'
        designConf.coreToChipClass     = CoreToChip
        designConf.coreSize            = ( 620*sliceStep, 86*sliceHeight )
        designConf.chipSize            = ( u( 8*85 + 2*270.0), u( 8*85 + 2*300.0) )
        designConf.doLvx               = 'corona'
        designConf.useHTree( 'clk', Spares.HEAVY_LEAF_LOAD )
        designConf.useHTree( 'resetn' )
        if buildChip:
            chipBuilder = Chip( designConf )
            chipBuilder.doChipNetlist()
            chipBuilder.doChipFloorplan()
            if editor:
                editor.setCell( designConf.chip )
            rvalue = chipBuilder.doPnR()
            chipBuilder.save()
        else:
            blockBuilder = Block( designConf )
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
