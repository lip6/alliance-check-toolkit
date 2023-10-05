#!/usr/bin/env python3

import sys
import traceback
from   coriolis.Hurricane  import DbU, Breakpoint, PythonAttributes
from   coriolis            import CRL, Cfg
from   coriolis.helpers    import loadUserSettings, setTraceLevel, trace, overlay, l, u, n
from   coriolis.helpers.io import ErrorMessage, WarningMessage, catch
loadUserSettings()
from   coriolis            import plugins
from   coriolis.plugins.block.block         import Block
from   coriolis.plugins.block.configuration import IoPin, GaugeConf
from   coriolis.plugins.block.spares        import Spares
from   coriolis.plugins.core2chip.gf180mcu  import CoreToChip
from   coriolis.plugins.chip.configuration  import ChipConf
from   coriolis.plugins.chip.chip           import Chip


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
        cfg.misc.minTraceLevel          = 16000
        cfg.misc.maxTraceLevel          = 17000

    global af
    hpitch       = 0
    gaugeName    = Cfg.getParamString('anabatic.routingGauge').asString()
    routingGauge = af.getRoutingGauge( gaugeName )
    for layerGauge in routingGauge.getLayerGauges():
        if layerGauge.getType() in [ CRL.RoutingLayerGauge.PinOnly
                                   , CRL.RoutingLayerGauge.Unusable
                                   , CRL.RoutingLayerGauge.BottomPowerSupply ]:
            continue
        if layerGauge.getDirection() == CRL.RoutingLayerGauge.Horizontal:
            hpitch = layerGauge.getPitch()
            break
    sliceHeight = af.getCellGauge().getSliceHeight()

    rvalue = True
    try:
        #setTraceLevel( 550 )
        #for cell in af.getAllianceLibrary(1).getLibrary().getCells():
        #    print( '"{}" {}'.format(cell.getName(),cell) )
        #Breakpoint.setStopLevel( 100 )
        buildChip = True
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'Arlet6502', CRL.Catalog.State.Logical )
        if not cell:
            cell = CRL.Blif.load( 'Arlet6502' )
        if editor:
            editor.setCell( cell ) 
            editor.setDbuMode( DbU.StringModePhysical )
        ioPadsSpec = [ (IoPin.WEST , None, 'di_0'       , 'DI(0)'  , 'DI(0)'  )
                     , (IoPin.WEST , None, 'di_1'       , 'DI(1)'  , 'DI(1)'  )
                     , (IoPin.WEST , None, 'di_2'       , 'DI(2)'  , 'DI(2)'  )
                     , (IoPin.WEST , None, 'di_3'       , 'DI(3)'  , 'DI(3)'  )
                     , (IoPin.WEST , None, 'allpower_0' , 'DVDD'   , 'vdd'    )
                     , (IoPin.WEST , None, 'allground_0', 'DVSS'   , 'vss'    )
                     , (IoPin.WEST , None, 'di_4'       , 'DI(4)'  , 'DI(4)'  )
                     , (IoPin.WEST , None, 'di_5'       , 'DI(5)'  , 'DI(5)'  )
                     , (IoPin.WEST , None, 'di_6'       , 'DI(6)'  , 'DI(6)'  )
                     , (IoPin.WEST , None, 'di_7'       , 'DI(7)'  , 'DI(7)'  )

                     , (IoPin.SOUTH, None, 'do_0'       , 'DO(0)'  , 'DO(0)'  )
                     , (IoPin.SOUTH, None, 'do_1'       , 'DO(1)'  , 'DO(1)'  )
                     , (IoPin.SOUTH, None, 'do_2'       , 'DO(2)'  , 'DO(2)'  )
                     , (IoPin.SOUTH, None, 'do_3'       , 'DO(3)'  , 'DO(3)'  )
                     , (IoPin.SOUTH, None, 'allpower_1' , 'DVDD'   , 'vdd'    )
                     , (IoPin.SOUTH, None, 'allground_1', 'DVSS'   , 'vss'    )
                     , (IoPin.SOUTH, None, 'do_4'       , 'DO(4)'  , 'DO(4)'  )
                     , (IoPin.SOUTH, None, 'do_5'       , 'DO(5)'  , 'DO(5)'  )
                     , (IoPin.SOUTH, None, 'do_6'       , 'DO(6)'  , 'DO(6)'  )
                     , (IoPin.SOUTH, None, 'do_7'       , 'DO(7)'  , 'DO(7)'  )
                     , (IoPin.SOUTH, None, 'a_0'        , 'A(0)'   , 'A(0)'   )
                     , (IoPin.SOUTH, None, 'a_1'        , 'A(1)'   , 'A(1)'   )

                     , (IoPin.EAST , None, 'a_2'        , 'A(2)'   , 'A(2)'   )
                     , (IoPin.EAST , None, 'a_3'        , 'A(3)'   , 'A(3)'   )
                     , (IoPin.EAST , None, 'a_4'        , 'A(4)'   , 'A(4)'   )
                     , (IoPin.EAST , None, 'a_5'        , 'A(5)'   , 'A(5)'   )
                     , (IoPin.EAST , None, 'a_6'        , 'A(6)'   , 'A(6)'   )
                     , (IoPin.EAST , None, 'allpower_2' , 'DVDD'   , 'vdd'    )
                     , (IoPin.EAST , None, 'allground_2', 'DVSS'   , 'vss'    )
                     , (IoPin.EAST , None, 'a_7'        , 'A(7)'   , 'A(7)'   )
                     , (IoPin.EAST , None, 'a_8'        , 'A(8)'   , 'A(8)'   )
                     , (IoPin.EAST , None, 'a_9'        , 'A(9)'   , 'A(9)'   )
                     , (IoPin.EAST , None, 'a_10'       , 'A(10)'  , 'A(10)'  )
                     , (IoPin.EAST , None, 'a_11'       , 'A(11)'  , 'A(11)'  )
                     , (IoPin.EAST , None, 'a_12'       , 'A(12)'  , 'A(12)'  )
                     , (IoPin.EAST , None, 'a_13'       , 'A(13)'  , 'A(13)'  )

                     , (IoPin.NORTH, None, 'irq'        , 'IRQ'    , 'IRQ'    )
                     , (IoPin.NORTH, None, 'nmi'        , 'NMI'    , 'NMI'    )
                     , (IoPin.NORTH, None, 'rdy'        , 'RDY'    , 'RDY'    )
                     , (IoPin.NORTH, None, 'clk'        , 'clk'    , 'clk'    )
                     , (IoPin.NORTH, None, 'allpower_3' , 'DVDD'   , 'vdd'    )
                     , (IoPin.NORTH, None, 'allground_3', 'DVSS'   , 'vss'    )
                     , (IoPin.NORTH, None, 'reset'      , 'reset'  , 'reset'  )
                     , (IoPin.NORTH, None, 'we'         , 'WE'     , 'WE'     )
                     , (IoPin.NORTH, None, 'a_14'       , 'a(14)'  , 'A(14)'  )
                     , (IoPin.NORTH, None, 'a_15'       , 'a(15)'  , 'A(15)'  )
                     ]
        ioPinsSpec = [ (IoPin.WEST |IoPin.A_BEGIN, 'di({})'  ,    sliceHeight, sliceHeight,  8)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'do({})'  , 14*sliceHeight, sliceHeight,  8)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'a({})'   ,    sliceHeight, sliceHeight, 16)
                     
                    #, (IoPin.NORTH|IoPin.A_BEGIN, 'clk'     , 10*sliceHeight,      0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'irq'     , 11*sliceHeight,      0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'nmi'     , 12*sliceHeight,      0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'rdy'     , 13*sliceHeight,      0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'we'      , 14*sliceHeight,      0 ,  1)
                    #, (IoPin.NORTH|IoPin.A_BEGIN, 'reset'   , 15*sliceHeight,      0 ,  1)
                     ]
       #ioPinsSpec = []
        designConf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        designConf.cfg.etesian.bloat               = 'disabled'
       #designConf.cfg.etesian.bloat               = 'nsxlib'
        designConf.cfg.etesian.densityVariation    = 0.05
        designConf.cfg.etesian.aspectRatio         = 1.0
       # etesian.spaceMargin is ignored if the coreSize is directly set.
       #designConf.cfg.etesian.spaceMargin         = 0.10
       #designConf.cfg.anabatic.searchHalo         = 2
        designConf.cfg.anabatic.globalIterations   = 6
        designConf.cfg.katana.hTracksReservedLocal = 6
        designConf.cfg.katana.vTracksReservedLocal = 3
        designConf.cfg.katana.hTracksReservedMin   = 4
        designConf.cfg.katana.vTracksReservedMin   = 5
        designConf.cfg.katana.trackFill            = 0
        designConf.cfg.katana.runRealignStage      = True
        designConf.cfg.block.spareSide             = 16*sliceHeight
        designConf.cfg.chip.padCoreSide            = 'North'
       #designConf.cfg.chip.use45corners           = False
       #designConf.cfg.chip.useAbstractPads        = True
        designConf.cfg.chip.supplyRailWidth        = l(250.0)
        designConf.cfg.chip.supplyRailPitch        = l(450.0)
        designConf.editor              = editor
        designConf.useSpares           = True
        designConf.useHFNS             = False
        designConf.bColumns            = 2
        designConf.bRows               = 2
        designConf.chipName            = 'chip'
        designConf.chipConf.ioPadGauge = 'LEF.GF_IO_Site'
        designConf.coreToChipClass     = CoreToChip
        designConf.coreSize            = (  40*sliceHeight,  40*sliceHeight )
        designConf.chipSize            = ( 140*sliceHeight, 140*sliceHeight )
        if buildChip:
            designConf.useHTree( 'clk_from_pad', Spares.HEAVY_LEAF_LOAD )
            designConf.useHTree( 'reset_from_pad' )
            chipBuilder = Chip( designConf )
            chipBuilder.doChipNetlist()
            chipBuilder.doChipFloorplan()
            rvalue = chipBuilder.doPnR()
            chipBuilder.save()
        else:
            designConf.useHTree( 'clk', Spares.HEAVY_LEAF_LOAD )
            designConf.useHTree( 'reset' )
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
