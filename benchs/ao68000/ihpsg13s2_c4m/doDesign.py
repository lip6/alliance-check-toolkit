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
buildChip  = False
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
    global af, buildChip

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

    rvalue = True
    try:
       #setTraceLevel( 550 )
       #Breakpoint.setStopLevel( 100 )
        cell, editor = plugins.kwParseMain( **kw )
        cell = CRL.Blif.load( 'ao68000' )
       #toVhdlInterface( cell )
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
        
        vspace     = 10
        hspace     = 8
        # ioPinsSpec, for peripheral pin placement as a standalone block.
        ioPinsSpec = [ (IoPin.WEST |IoPin.A_BEGIN, 'ACK_I'    ,  1*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'CLK_I'    ,  2*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'ERR_I'    ,  3*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'reset_n'  ,  4*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'RTY_I'    ,  5*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'BLK_O'    ,  6*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'blocked_o',  7*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'CYC_O'    ,  8*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'reset_o'  ,  9*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'RMW_O'    , 10*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'SGL_O'    , 11*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'STB_O'    , 12*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'WE_O'     , 13*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'ipl_i({})', 14*vspace, vspace, 3 )
                     , (IoPin.WEST |IoPin.A_BEGIN, 'BTE_O({})', 17*vspace, vspace, 2 )
                     , (IoPin.WEST |IoPin.A_BEGIN, 'CTI_O({})', 19*vspace, vspace, 3 )
                     , (IoPin.WEST |IoPin.A_BEGIN,  'fc_o({})', 22*vspace, vspace, 3 )
                     , (IoPin.WEST |IoPin.A_BEGIN, 'SEL_O({})', 26*vspace, vspace, 4 )
                     , (IoPin.SOUTH|IoPin.A_BEGIN, 'DAT_I({})',    hspace, hspace, 32 )
                     , (IoPin.EAST |IoPin.A_BEGIN, 'ADR_O({})',    vspace,  3*vspace, range(2,32) )
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'DAT_O({})',    hspace,  4*hspace, 32 )
                     ]
        conf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        conf.cfg.tramontana.mergeSupplies    = True
       #conf.cfg.etesian.bloat               = 'Flexlib'
        conf.cfg.etesian.densityVariation    = 0.05
        conf.cfg.etesian.aspectRatio         = 1.0
       # etesian.spaceMargin is ignored if the coreSize is directly set.
        conf.cfg.etesian.spaceMargin         = 0.80
        conf.cfg.anabatic.searchHalo         = 2
        conf.cfg.anabatic.gcellAspectRatio   = 1.5
        conf.cfg.anabatic.globalIterations   = 20
        conf.cfg.katana.maxFlatEdgeOverflow  = 300
       #conf.cfg.anabatic.topRoutingLayer    = 'm5'
        conf.cfg.katana.hTracksReservedLocal = 15
        conf.cfg.katana.vTracksReservedLocal = 23
        conf.cfg.katana.hTracksReservedMin   = 8
        conf.cfg.katana.vTracksReservedMin   = 9
       #conf.cfg.katana.trackFill            = 0
        conf.cfg.katana.runRealignStage      = False
        conf.cfg.katana.dumpMeasures         = False
        conf.cfg.block.spareSide             = 8*conf.sliceHeight
        conf.cfg.chip.useAbstractPads        = False
        conf.editor              = editor
        conf.ioPinsInTracks      = True
        conf.useSpares           = True
        conf.useClockTree        = True
        conf.useHFNS             = True
        conf.bColumns            = 2
        conf.bRows               = 2
        conf.chipName            = 'chip'
        conf.coreToChipClass     = CoreToChip
        conf.coreSize            = conf.computeCoreSize( 151*conf.sliceHeight, 1.0 )
        conf.chipSize            = ( u( 40*90.0+5.0 + 2*214.0), u( 40*90.0+5.0 + 2*214.0) )
        conf.useHTree( 'CLK_I', Spares.HEAVY_LEAF_LOAD )
        conf.useHTree( 'reset_n' )
        if buildChip:
            chipBuilder = Chip( conf )
            chipBuilder.doChipNetlist()
            chipBuilder.doChipFloorplan()
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
