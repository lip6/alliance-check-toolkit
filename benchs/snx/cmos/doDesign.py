
import sys
import traceback
import collections
from   coriolis            import CRL
from   coriolis.Hurricane  import DbU, Breakpoint
from   coriolis.helpers    import loadUserSettings, trace, l, u, n
from   coriolis.helpers.io import ErrorMessage, WarningMessage, catch
loadUserSettings()
from   coriolis            import plugins
from   coriolis.plugins.block.block         import Block
from   coriolis.plugins.block.configuration import IoPin, GaugeConf
from   coriolis.plugins.block.spares        import Spares
from   coriolis.plugins.core2chip.cmos      import CoreToChip
from   coriolis.plugins.chip.configuration  import ChipConf
from   coriolis.plugins.chip.chip           import Chip


def isiterable ( pyobj ):
    if isinstance(pyobj,collections.Iterable): return True
    return False


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


af = CRL.AllianceFramework.get()


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af
    rvalue = True
    try:
       #setTraceLevel( 540 )
       #Breakpoint.setStopLevel( 100 )
        buildChip = True
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'snx', CRL.Catalog.State.Logical )
        if editor:
            editor.setCell( cell ) 
            editor.setDbuMode( DbU.StringModePhysical )

        ioPadsSpec  = doIoPinVector( (IoPin.SOUTH, None, 'n_adrs_{}', 'n_adrs({})', 'n_adrs({})'), range( 0, 8) )
        ioPadsSpec += doIoPinVector( (IoPin.SOUTH, None, 'n_inst_{}', 'n_inst({})', 'n_inst({})'), range(12,16) )
        ioPadsSpec += [ (IoPin.SOUTH, None, 'allground_0', 'vsspad' , 'vss'     )
                      , (IoPin.SOUTH, None, 'n_hlt'      , 'n_hlt'  , 'n_hlt'   )
                      , (IoPin.SOUTH, None, 'n_wb'       , 'n_wb'   , 'n_wb'    )
                      , (IoPin.SOUTH, None, 'n_start'    , 'n_start', 'n_start' )
                      ]
        ioPadsSpec += doIoPinVector( (IoPin.SOUTH, None, 'n_adrs_{}', 'n_adrs({})', 'n_adrs({})'), range( 8,16) )

        ioPadsSpec += doIoPinVector( (IoPin.EAST, None, 'n_iadrs_{}', 'n_iadrs({})', 'n_iadrs({})'), range( 0, 8) )
        ioPadsSpec += doIoPinVector( (IoPin.EAST, None, 'n_inst_{}' , 'n_inst({})' , 'n_inst({})' ), range( 8,12) )
        ioPadsSpec += [ (IoPin.EAST, None, 'allpower_0' , 'vddpad'     , 'vdd'         )
                      , (IoPin.EAST, None, 'n_inst_read', 'n_inst_read', 'n_inst_read' )
                      , (IoPin.EAST, None, 'n_inst_adr' , 'n_inst_adr' , 'n_inst_adr'  )
                      , (IoPin.EAST, None, 'n_inst_ok'  , 'n_inst_ok'  , 'n_inst_ok'   )
                      ]
        ioPadsSpec += doIoPinVector( (IoPin.EAST, None, 'n_iadrs_{}', 'n_iadrs({})', 'n_iadrs({})'), range( 8,16) )

        ioPadsSpec += doIoPinVector( (IoPin.NORTH, None, 'n_datao_{}', 'n_datao({})', 'n_datao({})'), range( 0, 8) )
        ioPadsSpec += doIoPinVector( (IoPin.NORTH, None, 'n_inst_{}' , 'n_inst({})' , 'n_inst({})' ), range( 4, 8) )
        ioPadsSpec += [ (IoPin.NORTH, None, 'clock_0'    , 'm_clock' , 'm_clock'  )
                      , (IoPin.NORTH, None, 'allground_1', 'vsspad'  , 'vss'      )
                      , (IoPin.NORTH, None, 'p_reset'    , 'p_reset' , 'p_reset'  )
                      , (IoPin.NORTH, None, 'n_intack'   , 'n_intack', 'n_intack' )
                      , (IoPin.NORTH, None, 'n_intreq'   , 'n_intreq', 'n_intreq' )
                      ]
        ioPadsSpec += doIoPinVector( (IoPin.NORTH, None, 'n_datao_{}', 'n_datao({})', 'n_datao({})'), range( 8,16) )

        ioPadsSpec += doIoPinVector( (IoPin.WEST, None, 'n_datai_{}', 'n_datai({})', 'n_datai({})'), range( 0, 8) )
        ioPadsSpec += doIoPinVector( (IoPin.WEST, None, 'n_inst_{}' , 'n_inst({})' , 'n_inst({})' ), range( 0, 4) )
        ioPadsSpec += [ (IoPin.WEST, None, 'allpower_1'    , 'vddpad'        , 'vdd'            )
                      , (IoPin.WEST, None, 'n_memory_read' , 'n_memory_read' , 'n_memory_read'  )
                      , (IoPin.WEST, None, 'n_memory_write', 'n_memory_write', 'n_memory_write' )
                      , (IoPin.WEST, None, 'n_memory_adr'  , 'n_memory_adr'  , 'n_memory_adr'   )
                      , (IoPin.WEST, None, 'n_mem_ok'      , 'n_mem_ok'      , 'n_mem_ok'       )
                      ]
        ioPadsSpec += doIoPinVector( (IoPin.WEST, None, 'n_datai_{}', 'n_datai({})', 'n_datai({})'), range( 8,16) )

        ioPinsSpec = []
        snxConf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        snxConf.cfg.viewer.pixelThreshold       = 5
        snxConf.cfg.etesian.bloat               = 'disabled'
        snxConf.cfg.etesian.aspectRatio         = 1.0
       # etesian.spaceMargin is ignored if the coreSize is directly set.
        snxConf.cfg.etesian.spaceMargin         = 0.10
        snxConf.cfg.anabatic.searchHalo         = 2
        snxConf.cfg.anabatic.globalIterations   = 20
        snxConf.cfg.anabatic.topRoutingLayer    = 'METAL5'
        snxConf.cfg.katana.hTracksReservedLocal = 6
        snxConf.cfg.katana.vTracksReservedLocal = 3
        snxConf.cfg.katana.hTracksReservedMin   = 3
        snxConf.cfg.katana.vTracksReservedMin   = 1
        snxConf.cfg.katana.trackFill            = 0
        snxConf.cfg.katana.runRealignStage      = True
        snxConf.cfg.block.spareSide             = l(600.0)
       #snxConf.cfg.chip.padCoreSide            = 'North'
       #snxConf.cfg.chip.use45corners           = False
        snxConf.cfg.chip.useAbstractPads        = False
       #snxConf.cfg.chip.minPadSpacing          = u(1.46)
       #snxConf.cfg.chip.supplyRailWidth        = u(35)
       #snxConf.cfg.chip.supplyRailPitch        = u(90)
        snxConf.editor              = editor
        snxConf.useSpares           = True
        snxConf.useClockTree        = True
        snxConf.useHFNS             = False
        snxConf.bColumns            = 1
        snxConf.bRows               = 1
        snxConf.chipName            = 'chip'
        snxConf.chipConf.ioPadGauge = 'pxlib'
        snxConf.coreSize            = ( l( 48*50.0), l( 54*50.0) )
        snxConf.chipSize            = ( l(120*50.0), l(120*50.0) )
        snxConf.useHTree( 'm_clock' )
        if buildChip:
            snxToChip = CoreToChip( snxConf )
            snxToChip.buildChip()
            chipBuilder = Chip( snxConf )
            chipBuilder.doChipFloorplan()
            rvalue = chipBuilder.doPnR()
            chipBuilder.save()
        else:
            blockBuilder = Block( snxConf )
            rvalue = blockBuilder.doPnR()
            blockBuilder.save()
    except Exception as e:
        catch( e )
        rvalue = False
    sys.stdout.flush()
    sys.stderr.flush()
    return rvalue
