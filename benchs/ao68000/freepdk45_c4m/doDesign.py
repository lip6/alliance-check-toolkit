
import sys
import traceback
import collections
from   coriolis.Hurricane  import DbU, Breakpoint
from   coriolis            import CRL
from   coriolis.helpers    import loadUserSettings, setTraceLevel, trace, l, u, n
from   coriolis.helpers.io import ErrorMessage, WarningMessage
loadUserSettings()
from   coriolis            import plugins
from   coriolis.plugins.block.block          import Block
from   coriolis.plugins.block.configuration  import IoPin, GaugeConf
from   coriolis.plugins.block.spares         import Spares
from   coriolis.plugins.core2chip.libresocio import CoreToChip
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
    rvalue = True
    try:
       #setTraceLevel( 550 )
       #Breakpoint.setStopLevel( 100 )
        buildChip = True
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
        
        # ioPinsSpec, for peripheral pin placement as a standalone block.
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
        ao68000Conf = ChipConf( cell, ioPins=[], ioPads=ioPadsSpec ) 
        ao68000Conf.cfg.viewer.pixelThreshold       = 5
       #ao68000Conf.cfg.etesian.bloat               = 'Flexlib'
        ao68000Conf.cfg.etesian.densityVariation    = 0.05
        ao68000Conf.cfg.etesian.aspectRatio         = 1.0
       # etesian.spaceMargin is ignored if the coreSize is directly set.
        ao68000Conf.cfg.etesian.spaceMargin         = 0.10
        ao68000Conf.cfg.anabatic.searchHalo         = 2
        ao68000Conf.cfg.anabatic.globalIterations   = 20
        ao68000Conf.cfg.anabatic.topRoutingLayer    = 'metal5'
        ao68000Conf.cfg.katana.hTracksReservedLocal = 6
        ao68000Conf.cfg.katana.vTracksReservedLocal = 3
        ao68000Conf.cfg.katana.hTracksReservedMin   = 3
        ao68000Conf.cfg.katana.vTracksReservedMin   = 1
        ao68000Conf.cfg.katana.runRealignStage      = True
        ao68000Conf.cfg.block.spareSide             = u(7*4)
       #ao68000Conf.cfg.chip.padCoreSide            = 'North'
       #ao68000Conf.cfg.chip.use45corners           = False
        ao68000Conf.cfg.chip.useAbstractPads        = False
        ao68000Conf.cfg.chip.minPadSpacing          = u(1.46)
        ao68000Conf.cfg.chip.supplyRailWidth        = u(5.5)
        ao68000Conf.cfg.chip.supplyRailPitch        = u(9.0)
        ao68000Conf.editor              = editor
        ao68000Conf.useSpares           = True
        ao68000Conf.useClockTree        = True
        ao68000Conf.useHFNS             = True
        ao68000Conf.bColumns            = 3
        ao68000Conf.bRows               = 3
        ao68000Conf.chipName            = 'chip'
        ao68000Conf.chipConf.ioPadGauge = 'LibreSOCIO'
        ao68000Conf.coreToChipClass     = CoreToChip
        ao68000Conf.useHTree( 'clk_i_from_pad', Spares.HEAVY_LEAF_LOAD )
        ao68000Conf.useHTree( 'reset_n_from_pad' )
        # 29 is minimum with everything disabled       -> ~  6% free space.
        # Can really be reached when running the P&R on the sole block.
        # This is very suspicious.
        # 33 is minimum for obstacle density           -> ~ 25% free space.
        # 34 is minimum for cell packing near obstacle -> ~ 30% free space.
        if buildChip:
            ao68000Conf.coreSize = ( u(140*4.0               ), u(140*4.0               ) )
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
