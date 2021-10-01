
import sys
import traceback
import CRL
import helpers
helpers.loadUserSettings()
from   helpers.io import ErrorMessage, WarningMessage
from   helpers    import trace, l, u, n
import plugins
from   Hurricane  import DbU, Breakpoint
from   plugins.alpha.block.block          import Block
from   plugins.alpha.block.configuration  import IoPin, GaugeConf
from   plugins.alpha.block.spares         import Spares
from   plugins.alpha.core2chip.libresocio import CoreToChip
from   plugins.alpha.chip.configuration   import ChipConf
from   plugins.alpha.chip.chip            import Chip


af = CRL.AllianceFramework.get()


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af
    rvalue = True
    try:
       #helpers.setTraceLevel( 540 )
       #Breakpoint.setStopLevel( 100 )
        buildChip = True
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'arlet6502', CRL.Catalog.State.Logical )
        if editor:
            editor.setCell( cell ) 
            editor.setDbuMode( DbU.StringModePhysical )
        ioPadsSpec = [ (IoPin.WEST , None, 'iopower_0'  , 'iovdd'  )
                     , (IoPin.WEST , None, 'ioground_0' , 'vss'    )
                     , (IoPin.WEST , None, 'di_0'       , 'di(0)'  , 'di(0)'  )
                     , (IoPin.WEST , None, 'di_1'       , 'di(1)'  , 'di(1)'  )
                     , (IoPin.WEST , None, 'di_2'       , 'di(2)'  , 'di(2)'  )
                     , (IoPin.WEST , None, 'di_3'       , 'di(3)'  , 'di(3)'  )
                     , (IoPin.WEST , None, 'power_0'    , 'vdd'    )
                     , (IoPin.WEST , None, 'ground_0'   , 'vss'    )
                     , (IoPin.WEST , None, 'di_4'       , 'di(4)'  , 'di(4)'  )
                     , (IoPin.WEST , None, 'di_5'       , 'di(5)'  , 'di(5)'  )
                     , (IoPin.WEST , None, 'di_6'       , 'di(6)'  , 'di(6)'  )
                     , (IoPin.WEST , None, 'di_7'       , 'di(7)'  , 'di(7)'  )
                     , (IoPin.WEST , None, 'ioground_1' , 'vss'    )
                     , (IoPin.WEST , None, 'iopower_1'  , 'iovdd'  )

                     , (IoPin.SOUTH, None, 'iopower_2'  , 'iovdd'  )
                     , (IoPin.SOUTH, None, 'ioground_2' , 'vss'    )
                     , (IoPin.SOUTH, None, 'do_0'       , 'do(0)'  , 'do(0)'  )
                     , (IoPin.SOUTH, None, 'do_1'       , 'do(1)'  , 'do(1)'  )
                     , (IoPin.SOUTH, None, 'do_2'       , 'do(2)'  , 'do(2)'  )
                     , (IoPin.SOUTH, None, 'do_3'       , 'do(3)'  , 'do(3)'  )
                     , (IoPin.SOUTH, None, 'do_4'       , 'do(4)'  , 'do(4)'  )
                     , (IoPin.SOUTH, None, 'do_5'       , 'do(5)'  , 'do(5)'  )
                     , (IoPin.SOUTH, None, 'do_6'       , 'do(6)'  , 'do(6)'  )
                     , (IoPin.SOUTH, None, 'do_7'       , 'do(7)'  , 'do(7)'  )
                     , (IoPin.SOUTH, None, 'a_0'        , 'a(0)'   , 'a(0)'   )
                     , (IoPin.SOUTH, None, 'a_1'        , 'a(1)'   , 'a(1)'   )
                     , (IoPin.SOUTH, None, 'iopower_3'  , 'iovdd'  )
                     , (IoPin.SOUTH, None, 'ioground_3' , 'vss'    )

                     , (IoPin.EAST , None, 'iopower_4'  , 'iovdd'  )
                     , (IoPin.EAST , None, 'ioground_4' , 'vss'    )
                     , (IoPin.EAST , None, 'a_2'        , 'a(2)'   , 'a(2)'   )
                     , (IoPin.EAST , None, 'a_3'        , 'a(3)'   , 'a(3)'   )
                     , (IoPin.EAST , None, 'a_4'        , 'a(4)'   , 'a(4)'   )
                     , (IoPin.EAST , None, 'a_5'        , 'a(5)'   , 'a(5)'   )
                     , (IoPin.EAST , None, 'a_6'        , 'a(6)'   , 'a(6)'   )
                     , (IoPin.EAST , None, 'a_7'        , 'a(7)'   , 'a(7)'   )
                     , (IoPin.EAST , None, 'power_1'    , 'vdd'    )
                     , (IoPin.EAST , None, 'ground_1'   , 'vss'    )
                     , (IoPin.EAST , None, 'a_8'        , 'a(8)'   , 'a(8)'   )
                     , (IoPin.EAST , None, 'a_9'        , 'a(9)'   , 'a(9)'   )
                     , (IoPin.EAST , None, 'a_10'       , 'a(10)'  , 'a(10)'  )
                     , (IoPin.EAST , None, 'a_11'       , 'a(11)'  , 'a(11)'  )
                     , (IoPin.EAST , None, 'a_12'       , 'a(12)'  , 'a(12)'  )
                     , (IoPin.EAST , None, 'a_13'       , 'a(13)'  , 'a(13)'  )
                     , (IoPin.EAST , None, 'ioground_5' , 'vss'    )
                     , (IoPin.EAST , None, 'iopower_5'  , 'iovdd'  )

                     , (IoPin.NORTH, None, 'iopower_6'  , 'iovdd'  )
                     , (IoPin.NORTH, None, 'ioground_6' , 'vss'    )
                     , (IoPin.NORTH, None, 'irq'        , 'irq'    , 'irq'    )
                     , (IoPin.NORTH, None, 'nmi'        , 'nmi'    , 'nmi'    )
                     , (IoPin.NORTH, None, 'rdy'        , 'rdy'    , 'rdy'    )
                     , (IoPin.NORTH, None, 'power_2'    , 'vdd'    )
                     , (IoPin.NORTH, None, 'ground_2'   , 'vss'    )
                     , (IoPin.NORTH, None, 'clk'        , 'clk'    , 'clk'    )
                     , (IoPin.NORTH, None, 'reset'      , 'reset'  , 'reset'  )
                     , (IoPin.NORTH, None, 'we'         , 'we'     , 'we'     )
                     , (IoPin.NORTH, None, 'a_14'       , 'a(14)'  , 'a(14)'  )
                     , (IoPin.NORTH, None, 'a_15'       , 'a(15)'  , 'a(15)'  )
                     , (IoPin.NORTH, None, 'ioground_7' , 'vss'    )
                     , (IoPin.NORTH, None, 'iopower_7'  , 'iovdd'  )
                     ]
        ioPinsSpec = [ (IoPin.WEST |IoPin.A_BEGIN, 'di({})'  , u(  13.0), u(13.0),  8)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'do({})'  , u( 117.0), u(13.0),  8)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'a({})'   , u(  13.0), u(13.0), 16)
                     
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'clk'     , u(130.0),       0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'irq'     , u(143.0),       0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'nmi'     , u(156.0),       0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'rdy'     , u(169.0),       0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'we'      , u(182.0),       0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'reset'   , u(195.0),       0 ,  1)
                     ]
       #ioPinsSpec = []
        arlet6502Conf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        arlet6502Conf.cfg.viewer.pixelThreshold       = 5
        arlet6502Conf.cfg.etesian.bloat               = 'Flexlib'
        arlet6502Conf.cfg.etesian.uniformDensity      = True
        arlet6502Conf.cfg.etesian.aspectRatio         = 1.0
       # etesian.spaceMargin is ignored if the coreSize is directly set.
        arlet6502Conf.cfg.etesian.spaceMargin         = 0.10
        arlet6502Conf.cfg.anabatic.searchHalo         = 2
        arlet6502Conf.cfg.anabatic.globalIterations   = 20
        arlet6502Conf.cfg.anabatic.topRoutingLayer    = 'metal5'
        arlet6502Conf.cfg.katana.hTracksReservedLocal = 6
        arlet6502Conf.cfg.katana.vTracksReservedLocal = 3
        arlet6502Conf.cfg.katana.hTracksReservedMin   = 3
        arlet6502Conf.cfg.katana.vTracksReservedMin   = 1
        arlet6502Conf.cfg.katana.trackFill            = 0
        arlet6502Conf.cfg.katana.runRealignStage      = True
        arlet6502Conf.cfg.block.spareSide             = u(7*4)
       #arlet6502Conf.cfg.chip.padCoreSide            = 'North'
       #arlet6502Conf.cfg.chip.use45corners           = False
        arlet6502Conf.cfg.chip.useAbstractPads        = True
        arlet6502Conf.cfg.chip.minPadSpacing          = u(1.46)
        arlet6502Conf.cfg.chip.supplyRailWidth        = u(8.0)
        arlet6502Conf.cfg.chip.supplyRailPitch        = u(8.0)
        arlet6502Conf.editor              = editor
        arlet6502Conf.useSpares           = True
        arlet6502Conf.useClockTree        = True
        arlet6502Conf.useHFNS             = True
        arlet6502Conf.bColumns            = 3
        arlet6502Conf.bRows               = 3
        arlet6502Conf.chipName            = 'chip'
        arlet6502Conf.chipConf.ioPadGauge = 'LibreSOCIO'
        # 29 is minimum with everything disabled       -> ~  6% free space.
        # Can really be reached when running the P&R on the sole block.
        # This is very suspicious.
        # 33 is minimum for obstacle density           -> ~ 25% free space.
        # 34 is minimum for cell packing near obstacle -> ~ 30% free space.
        arlet6502Conf.coreSize            = ( u( 40*4.0), u( 40*4.0) )
        arlet6502Conf.chipSize            = ( u( 2020.0), u( 2060.0) )
        arlet6502Conf.useHTree( 'clk_from_pad', Spares.HEAVY_LEAF_LOAD )
        arlet6502Conf.useHTree( 'reset_from_pad' )
        #arlet6502Conf.useHTree( 'core.subckt_0_cpu.abc_11829_new_n340' )
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
        helpers.io.catch( e )
        rvalue = False
    sys.stdout.flush()
    sys.stderr.flush()
    return rvalue


if __name__ == '__main__':
    rvalue = scriptMain()
    shellRValue = 0 if rvalue else 1
    sys.exit( shellRValue )
