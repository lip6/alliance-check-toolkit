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
#from   coriolis.plugins.core2chip.niolib    import CoreToChip
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
        cfg.misc.minTraceLevel          = 15900
        cfg.misc.maxTraceLevel          = 16000

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
        Breakpoint.setStopLevel( 100 )
        buildChip = False
        cell, editor = plugins.kwParseMain( **kw )
        cell = CRL.Blif.load( 'Arlet6502' )
        if editor:
            editor.setCell( cell ) 
            editor.setDbuMode( DbU.StringModePhysical )
        ioPadsSpec = [ (IoPin.WEST , None, 'iopower_0'  , 'iovdd'  )
                     , (IoPin.WEST , None, 'ioground_0' , 'vss'    )
                     , (IoPin.WEST , None, 'di_0'       , 'di(0)'  , 'DI(0)'  )
                     , (IoPin.WEST , None, 'di_1'       , 'di(1)'  , 'DI(1)'  )
                     , (IoPin.WEST , None, 'di_2'       , 'di(2)'  , 'DI(2)'  )
                     , (IoPin.WEST , None, 'di_3'       , 'di(3)'  , 'DI(3)'  )
                     , (IoPin.WEST , None, 'power_0'    , 'vdd'    )
                     , (IoPin.WEST , None, 'ground_0'   , 'vss'    )
                     , (IoPin.WEST , None, 'di_4'       , 'di(4)'  , 'DI(4)'  )
                     , (IoPin.WEST , None, 'di_5'       , 'di(5)'  , 'DI(5)'  )
                     , (IoPin.WEST , None, 'di_6'       , 'di(6)'  , 'DI(6)'  )
                     , (IoPin.WEST , None, 'di_7'       , 'di(7)'  , 'DI(7)'  )
                     , (IoPin.WEST , None, 'ioground_1' , 'vss'    )
                     , (IoPin.WEST , None, 'iopower_1'  , 'iovdd'  )

                     , (IoPin.SOUTH, None, 'iopower_2'  , 'iovdd'  )
                     , (IoPin.SOUTH, None, 'ioground_2' , 'vss'    )
                     , (IoPin.SOUTH, None, 'do_0'       , 'do(0)'  , 'DO(0)'  )
                     , (IoPin.SOUTH, None, 'do_1'       , 'do(1)'  , 'DO(1)'  )
                     , (IoPin.SOUTH, None, 'do_2'       , 'do(2)'  , 'DO(2)'  )
                     , (IoPin.SOUTH, None, 'do_3'       , 'do(3)'  , 'DO(3)'  )
                     , (IoPin.SOUTH, None, 'do_4'       , 'do(4)'  , 'DO(4)'  )
                     , (IoPin.SOUTH, None, 'do_5'       , 'do(5)'  , 'DO(5)'  )
                     , (IoPin.SOUTH, None, 'do_6'       , 'do(6)'  , 'DO(6)'  )
                     , (IoPin.SOUTH, None, 'do_7'       , 'do(7)'  , 'DO(7)'  )
                     , (IoPin.SOUTH, None, 'a_0'        , 'a(0)'   , 'A(0)'   )
                     , (IoPin.SOUTH, None, 'a_1'        , 'a(1)'   , 'A(1)'   )
                     , (IoPin.SOUTH, None, 'iopower_3'  , 'iovdd'  )
                     , (IoPin.SOUTH, None, 'ioground_3' , 'vss'    )

                     , (IoPin.EAST , None, 'iopower_4'  , 'iovdd'  )
                     , (IoPin.EAST , None, 'ioground_4' , 'vss'    )
                     , (IoPin.EAST , None, 'a_2'        , 'a(2)'   , 'A(2)'   )
                     , (IoPin.EAST , None, 'a_3'        , 'a(3)'   , 'A(3)'   )
                     , (IoPin.EAST , None, 'a_4'        , 'a(4)'   , 'A(4)'   )
                     , (IoPin.EAST , None, 'a_5'        , 'a(5)'   , 'A(5)'   )
                     , (IoPin.EAST , None, 'a_6'        , 'a(6)'   , 'A(6)'   )
                     , (IoPin.EAST , None, 'a_7'        , 'a(7)'   , 'A(7)'   )
                     , (IoPin.EAST , None, 'power_1'    , 'vdd'    )
                     , (IoPin.EAST , None, 'ground_1'   , 'vss'    )
                     , (IoPin.EAST , None, 'a_8'        , 'a(8)'   , 'A(8)'   )
                     , (IoPin.EAST , None, 'a_9'        , 'a(9)'   , 'A(9)'   )
                     , (IoPin.EAST , None, 'a_10'       , 'a(10)'  , 'A(10)'  )
                     , (IoPin.EAST , None, 'a_11'       , 'a(11)'  , 'A(11)'  )
                     , (IoPin.EAST , None, 'a_12'       , 'a(12)'  , 'A(12)'  )
                     , (IoPin.EAST , None, 'a_13'       , 'a(13)'  , 'A(13)'  )
                     , (IoPin.EAST , None, 'ioground_5' , 'vss'    )
                     , (IoPin.EAST , None, 'iopower_5'  , 'iovdd'  )

                     , (IoPin.NORTH, None, 'iopower_6'  , 'iovdd'  )
                     , (IoPin.NORTH, None, 'ioground_6' , 'vss'    )
                     , (IoPin.NORTH, None, 'irq'        , 'irq'    , 'IRQ'    )
                     , (IoPin.NORTH, None, 'nmi'        , 'nmi'    , 'NMI'    )
                     , (IoPin.NORTH, None, 'rdy'        , 'rdy'    , 'RDY'    )
                     , (IoPin.NORTH, None, 'power_2'    , 'vdd'    )
                     , (IoPin.NORTH, None, 'ground_2'   , 'vss'    )
                     , (IoPin.NORTH, None, 'clk'        , 'clk'    , 'clk'    )
                     , (IoPin.NORTH, None, 'reset'      , 'reset'  , 'RESET'  )
                     , (IoPin.NORTH, None, 'we'         , 'we'     , 'WE'     )
                     , (IoPin.NORTH, None, 'a_14'       , 'a(14)'  , 'A(14)'  )
                     , (IoPin.NORTH, None, 'a_15'       , 'a(15)'  , 'A(15)'  )
                     , (IoPin.NORTH, None, 'ioground_7' , 'vss'    )
                     , (IoPin.NORTH, None, 'iopower_7'  , 'iovdd'  )
                     ]
        ioPinsSpec = [ (IoPin.WEST |IoPin.A_BEGIN, 'DI({})'  ,    sliceHeight, sliceHeight,  8)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'DO({})'  , 14*sliceHeight, sliceHeight,  8)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'A({})'   ,    sliceHeight, sliceHeight, 16)
                     
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'clk'     , 10*sliceHeight,      0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'IRQ'     , 11*sliceHeight,      0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'NMI'     , 12*sliceHeight,      0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'RDY'     , 13*sliceHeight,      0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'WE'      , 14*sliceHeight,      0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'reset'   , 15*sliceHeight,      0 ,  1)
                     ]
       #ioPinsSpec = []
        arlet6502Conf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        arlet6502Conf.cfg.etesian.bloat               = 'disabled'
       #arlet6502Conf.cfg.etesian.bloat               = 'nsxlib'
        arlet6502Conf.cfg.etesian.densityVariation    = 0.05
        arlet6502Conf.cfg.etesian.aspectRatio         = 1.0
       # etesian.spaceMargin is ignored if the coreSize is directly set.
       #arlet6502Conf.cfg.etesian.spaceMargin         = 0.10
       #arlet6502Conf.cfg.anabatic.searchHalo         = 2
        arlet6502Conf.cfg.anabatic.globalIterations   = 6
        arlet6502Conf.cfg.katana.hTracksReservedLocal = 6
        arlet6502Conf.cfg.katana.vTracksReservedLocal = 5
        arlet6502Conf.cfg.katana.hTracksReservedMin   = 5
        arlet6502Conf.cfg.katana.vTracksReservedMin   = 6
        arlet6502Conf.cfg.katana.trackFill            = 0
        arlet6502Conf.cfg.katana.runRealignStage      = True
        arlet6502Conf.cfg.block.spareSide             = 16*sliceHeight
        arlet6502Conf.cfg.chip.padCoreSide            = 'North'
       #arlet6502Conf.cfg.chip.use45corners           = False
        arlet6502Conf.cfg.chip.useAbstractPads        = True
        arlet6502Conf.cfg.chip.supplyRailWidth        = l(250.0)
        arlet6502Conf.cfg.chip.supplyRailPitch        = l(150.0)
        arlet6502Conf.editor              = editor
        arlet6502Conf.useSpares           = True
        arlet6502Conf.useHFNS             = False
        arlet6502Conf.bColumns            = 2
        arlet6502Conf.bRows               = 2
        arlet6502Conf.chipName            = 'chip'
        arlet6502Conf.chipConf.ioPadGauge = 'niolib'
        arlet6502Conf.coreSize            = (  40*sliceHeight,  40*sliceHeight )
        arlet6502Conf.chipSize            = ( 100*sliceHeight, 100*sliceHeight )
        arlet6502Conf.useHTree( 'clk', Spares.HEAVY_LEAF_LOAD )
        arlet6502Conf.useHTree( 'reset' )
        if buildChip:
            arlet6502ToChip = CoreToChip( arlet6502Conf )
            arlet6502ToChip.buildChip()
            chipBuilder = Chip( arlet6502Conf )
            chipBuilder.doChipFloorplan()
            rvalue = chipBuilder.doPnR()
            chipBuilder.save()
        else:
            blockBuilder = Block( arlet6502Conf )
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
