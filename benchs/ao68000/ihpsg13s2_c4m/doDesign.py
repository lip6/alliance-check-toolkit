#!/usr/bin/env python3

import sys
import traceback
import collections
from   coriolis.Hurricane  import DbU, Breakpoint
from   coriolis            import Cfg, CRL
from   coriolis.helpers.io import ErrorMessage, WarningMessage, catch
from   coriolis.helpers    import loadUserSettings, setTraceLevel, overlay, trace, l, u, n
from   coriolis            import plugins
from   coriolis.plugins.block.block          import Block
from   coriolis.plugins.block.configuration  import IoPin, GaugeConf
from   coriolis.plugins.block.spares         import Spares
from   coriolis.plugins.core2chip.sky130     import CoreToChip
from   coriolis.plugins.chip.configuration   import ChipConf
from   coriolis.plugins.chip.chip            import Chip


af         = CRL.AllianceFramework.get()
powerCount = 0


def isiterable ( pyobj ):
    if isinstance(pyobj,collections.abc.Iterable): return True
    return False


def doIoPowerCap ( flags ):
    global powerCount
    side = flags & IoPin.SIDE_MASK
    if flags & IoPin.A_BEGIN:
        ioPadPower = [ (side , None,    'power_{}'.format(powerCount),   'vdd' )
                     , (side , None,   'ground_{}'.format(powerCount),   'vss' )
                     , (side , None, 'ioground_{}'.format(powerCount),   'vss' )
                     , (side , None,  'iopower_{}'.format(powerCount), 'iovdd' )
                     ]
    else:
        ioPadPower = [ (side , None,  'iopower_{}'.format(powerCount), 'iovdd' )
                     , (side , None, 'ioground_{}'.format(powerCount),   'vss' )
                     , (side , None,   'ground_{}'.format(powerCount),   'vss' )
                     , (side , None,    'power_{}'.format(powerCount),   'vdd' )
                     ]
    powerCount += 1
    return ioPadPower


def doIoPinVector ( ioSpec, bits ):
    v = []
    if not isiterable(bits): bits = range(bits)
    if not bits:
        raise ErrorMessage( 1, [ 'doIoPinVector(): Argument "bits" is neither a width nor an iterable.'
                               , '(bits={})'.format(bits)
                               ] )
    if len(ioSpec) == 5:
        for bit in bits:
            v.append(( ioSpec[0]
                     , ioSpec[1]
                     , ioSpec[2].format(bit)
                     , ioSpec[3].format(bit)
                     , ioSpec[4].format(bit) ))
    elif len(ioSpec) == 6:
        for bit in bits:
            v.append(( ioSpec[0]
                     , ioSpec[1]
                     , ioSpec[2].format(bit)
                     , ioSpec[3].format(bit)
                     , ioSpec[4].format(bit)
                     , ioSpec[5].format(bit) ))
    elif len(ioSpec) == 7:
        for bit in bits:
            v.append(( ioSpec[0]
                     , ioSpec[1]
                     , ioSpec[2].format(bit)
                     , ioSpec[3].format(bit)
                     , ioSpec[4].format(bit)
                     , ioSpec[5].format(bit)
                     , ioSpec[6].format(bit) ))
    else:
        raise ErrorMessage( 1, [ 'doIoPinVector(): Argument "ioSpec" must have between 5 and 7 fields ({})'.format(len(ioSpec))
                               , '(ioSpec={})'.format(ioSpec)
                               ] )
    return v



def toVhdlInterface ( cell ):
    for net in cell.getNets():
        if not net.isExternal(): continue
        vhdlName = net.getName().lower()
        net.setName( vhdlName )


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af
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
    vpitchedSliceHeight = sliceHeight - sliceHeight%hpitch
    hpitchedSliceHeight = sliceHeight - sliceHeight%vpitch

    rvalue = True
    try:
       #setTraceLevel( 550 )
       #Breakpoint.setStopLevel( 100 )
        buildChip = False
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'ao68000', CRL.Catalog.State.Logical )
        toVhdlInterface( cell )
        if editor:
            editor.setCell( cell ) 
            editor.setDbuMode( DbU.StringModePhysical )
        # ioPadsSpec, for I/O pad placement on a full chip.
        ioPadsSpec  = []
        # West side (story).
        ioPadsSpec += doIoPowerCap( IoPin.WEST|IoPin.A_BEGIN )
        ioPadsSpec += [ (IoPin.WEST , None, 'ack_i'    , 'ack_i'    , 'ack_i'     )
                      , (IoPin.WEST , None, 'clk_i'    , 'clk_i'    , 'clk_i'     )
                      , (IoPin.WEST , None, 'err_i'    , 'err_i'    , 'err_i'     )
                      , (IoPin.WEST , None, 'reset_n'  , 'reset_n'  , 'reset_n'   )
                      , (IoPin.WEST , None, 'rty_i'    , 'rty_i'    , 'rty_i'     )
                      , (IoPin.WEST , None, 'blk_o'    , 'blk_o'    , 'blk_o'     )
                      , (IoPin.WEST , None, 'blocked_o', 'blocked_o', 'blocked_o' )
                      , (IoPin.WEST , None, 'cyc_o'    , 'cyc_o'    , 'cyc_o'     )
                      , (IoPin.WEST , None, 'reset_o'  , 'reset_o'  , 'reset_o'   )
                      , (IoPin.WEST , None, 'rmw_o'    , 'rmw_o'    , 'rmw_o'     )
                      , (IoPin.WEST , None, 'sgl_o'    , 'sgl_o'    , 'sgl_o'     )
                      , (IoPin.WEST , None, 'stb_o'    , 'stb_o'    , 'stb_o'     )
                      , (IoPin.WEST , None, 'we_o'     , 'we_o'     , 'we_o'      )
                      ]
        ioPadsSpec += doIoPinVector( (IoPin.WEST , None, 'ipl_i_{}', 'ipl_i({})', 'ipl_i({})'), range(3) )
        ioPadsSpec += doIoPinVector( (IoPin.WEST , None, 'bte_o_{}', 'bte_o({})', 'bte_o({})'), range(2) )
        ioPadsSpec += doIoPinVector( (IoPin.WEST , None, 'cti_o_{}', 'cti_o({})', 'cti_o({})'), range(3) )
        ioPadsSpec += doIoPinVector( (IoPin.WEST , None,  'fc_o_{}',  'fc_o({})',  'fc_o({})'), range(3) )
        ioPadsSpec += doIoPinVector( (IoPin.WEST , None, 'sel_o_{}', 'sel_o({})', 'sel_o({})'), range(4) )
        ioPadsSpec += doIoPowerCap( IoPin.WEST|IoPin.A_END )
        # South side.
        ioPadsSpec += doIoPowerCap( IoPin.SOUTH|IoPin.A_BEGIN )
        ioPadsSpec += doIoPinVector( (IoPin.SOUTH, None, 'dat_i_{}', 'dat_i({})', 'dat_i({})'), range(32) )
        ioPadsSpec += doIoPowerCap( IoPin.SOUTH|IoPin.A_END )
        # East side.
        ioPadsSpec += doIoPowerCap( IoPin.EAST|IoPin.A_BEGIN )
        ioPadsSpec += doIoPinVector( (IoPin.EAST, None, 'adr_o_{}', 'adr_o({})', 'adr_o({})'), range(2,32) )
        ioPadsSpec += doIoPowerCap( IoPin.EAST|IoPin.A_END )
        # North side.
        ioPadsSpec += doIoPowerCap( IoPin.NORTH|IoPin.A_BEGIN )
        ioPadsSpec += doIoPinVector( (IoPin.NORTH, None, 'dat_o_{}', 'dat_o({})', 'dat_o({})'), range(32) )
        ioPadsSpec += doIoPowerCap( IoPin.NORTH|IoPin.A_END )
        
        vspace     = hpitch * 10
        hspace     = vpitch * 8
        # ioPinsSpec, for peripheral pin placement as a standalone block.
        ioPinsSpec = [ (IoPin.WEST |IoPin.A_BEGIN, 'ack_i'    ,  1*vspace, 0, 1)
                    #, (IoPin.WEST |IoPin.A_BEGIN, 'clk_i'    ,  2*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'err_i'    ,  3*vspace, 0, 1)
                    #, (IoPin.WEST |IoPin.A_BEGIN, 'reset_n'  ,  4*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'rty_i'    ,  5*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'blk_o'    ,  6*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'blocked_o',  7*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'cyc_o'    ,  8*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'reset_o'  ,  9*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'rmw_o'    , 10*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'sgl_o'    , 11*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'stb_o'    , 12*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'we_o'     , 13*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'ipl_i({})', 14*vspace, vspace, 3 )
                     , (IoPin.WEST |IoPin.A_BEGIN, 'bte_o({})', 17*vspace, vspace, 2 )
                     , (IoPin.WEST |IoPin.A_BEGIN, 'cti_o({})', 19*vspace, vspace, 3 )
                     , (IoPin.WEST |IoPin.A_BEGIN,  'fc_o({})', 22*vspace, vspace, 3 )
                     , (IoPin.WEST |IoPin.A_BEGIN, 'sel_o({})', 26*vspace, vspace, 4 )
                     , (IoPin.SOUTH|IoPin.A_BEGIN, 'dat_i({})',    hspace, hspace, 32 )
                     , (IoPin.EAST |IoPin.A_BEGIN, 'adr_o({})',    vspace,  5*vspace, 32 )
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'dat_o({})',    hspace,  5*hspace, 32 )
                     ]
        ao68000Conf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        ao68000Conf.cfg.tramontana.mergeSupplies    = True
       #ao68000Conf.cfg.etesian.bloat               = 'Flexlib'
        ao68000Conf.cfg.etesian.densityVariation    = 0.05
        ao68000Conf.cfg.etesian.aspectRatio         = 1.0
       # etesian.spaceMargin is ignored if the coreSize is directly set.
        ao68000Conf.cfg.etesian.spaceMargin         = 0.80
        ao68000Conf.cfg.anabatic.searchHalo         = 2
        ao68000Conf.cfg.anabatic.globalIterations   = 20
       #ao68000Conf.cfg.anabatic.topRoutingLayer    = 'm5'
        ao68000Conf.cfg.katana.hTracksReservedLocal = 20
        ao68000Conf.cfg.katana.vTracksReservedLocal = 20
        ao68000Conf.cfg.katana.hTracksReservedMin   = 8
        ao68000Conf.cfg.katana.vTracksReservedMin   = 8
       #ao68000Conf.cfg.katana.trackFill            = 0
        ao68000Conf.cfg.katana.runRealignStage      = False
        ao68000Conf.cfg.katana.dumpMeasures         = False
        ao68000Conf.cfg.block.spareSide             = u(8*10)
        ao68000Conf.cfg.chip.useAbstractPads        = False
        ao68000Conf.editor              = editor
        ao68000Conf.useSpares           = True
        ao68000Conf.useClockTree        = True
        ao68000Conf.useHFNS             = True
        ao68000Conf.bColumns            = 2
        ao68000Conf.bRows               = 2
        ao68000Conf.chipName            = 'chip'
        ao68000Conf.chipConf.ioPadGauge = 'LibreSOCIO'
        ao68000Conf.coreToChipClass     = CoreToChip
        ao68000Conf.useHTree( 'clk_i', Spares.HEAVY_LEAF_LOAD )
        ao68000Conf.useHTree( 'reset_n' )
        if buildChip:
            ao68000Conf.coreSize = ( u(110*10.0          ), u(100*10.0          ) )
            ao68000Conf.chipSize = ( u( 40*90.0+5.0 + 2*214.0), u( 40*90.0+5.0 + 2*214.0) )
            chipBuilder = Chip( ao68000Conf )
            chipBuilder.doChipNetlist()
            chipBuilder.doChipFloorplan()
            rvalue = chipBuilder.doPnR()
            chipBuilder.save()
        else:
            blockBuilder = Block( ao68000Conf )
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
