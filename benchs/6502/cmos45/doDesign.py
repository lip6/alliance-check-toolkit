
import sys
import traceback
from   coriolis            import CRL
from   coriolis.helpers    import setTraceLevel, trace, l
from   coriolis.helpers.io import ErrorMessage, WarningMessage, catch
from   coriolis            import plugins
from   coriolis.Hurricane  import Breakpoint, DbU, Pin
from   coriolis.plugins.block.block         import Block
from   coriolis.plugins.block.configuration import IoPin, GaugeConf
from   coriolis.plugins.core2chip.niolib    import CoreToChip
from   coriolis.plugins.chip.configuration  import ChipConf
from   coriolis.plugins.chip.chip           import Chip


af = CRL.AllianceFramework.get()


def scriptMain ( **kw ):
    """The mandatory function that Coriolis CGT/Unicorn will look for."""
    global af

    rvalue = True
    try:
        #setTraceLevel( 550 )
        #Breakpoint.setStopLevel( 100 )
        buildChip = False
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'm65s', CRL.Catalog.State.Logical )
        if editor: editor.setCell( cell ) 

        # ioPinsSpec, for peripheral pin placement as a standalone block.
        ioPinsSpec = [ (IoPin.SOUTH, 'adrs({})' , l(  20.0), l(100.0), 16)
                     , (IoPin.EAST , 'data({})' , l(  60.0), l(100.0),  8)
                     , (IoPin.EAST , 'datao({})', l(  80.0), l(100.0),  8)
                     , (IoPin.WEST , 'debug({})', l(  50.0), l(100.0), 16)
                     , (IoPin.EAST , 'debug(0)' , l(  50.0),       0 ,  1)
                     , (IoPin.NORTH, 'irq'      , l( 200.0),       0 ,  1)
                    #, (IoPin.NORTH, 'm_clock'  , l( 300.0),       0 ,  1)
                     , (IoPin.NORTH, 'nmi'      , l( 400.0),       0 ,  1)
                     , (IoPin.NORTH, 'p_reset'  , l( 500.0),       0 ,  1)
                     , (IoPin.NORTH, 'rdy'      , l( 600.0),       0 ,  1)
                     , (IoPin.NORTH, 'start'    , l( 700.0),       0 ,  1)
                     , (IoPin.NORTH, 'rd'       , l( 800.0),       0 ,  1)
                     , (IoPin.NORTH, 'sync'     , l( 900.0),       0 ,  1)
                     , (IoPin.NORTH, 'wt'       , l(1000.0),       0 ,  1)
                     ]

        # ioPadsSpec, for I/O pins placement as a complete chip.
        ioPadsSpec = [ (IoPin.SOUTH, None, 'adrs_0'    , 'adrs(0)'  , 'adrs(0)'  )
                     , (IoPin.SOUTH, None, 'adrs_1'    , 'adrs(1)'  , 'adrs(1)'  )
                     , (IoPin.SOUTH, None, 'adrs_2'    , 'adrs(2)'  , 'adrs(2)'  )
                     , (IoPin.SOUTH, None, 'adrs_3'    , 'adrs(3)'  , 'adrs(3)'  )
                     , (IoPin.SOUTH, None, 'adrs_4'    , 'adrs(4)'  , 'adrs(4)'  )
                     , (IoPin.SOUTH, None, 'adrs_5'    , 'adrs(5)'  , 'adrs(5)'  )
                     , (IoPin.SOUTH, None, 'adrs_6'    , 'adrs(6)'  , 'adrs(6)'  )
                     , (IoPin.SOUTH, None, 'adrs_7'    , 'adrs(7)'  , 'adrs(7)'  )
                     , (IoPin.SOUTH, None, 'iopower_0' , 'iovdd' )
                     , (IoPin.SOUTH, None, 'power_0'   , 'vdd' )
                     , (IoPin.SOUTH, None, 'ground_0'  , 'vss' )
                     , (IoPin.SOUTH, None, 'ioground_0', 'vss' )
                     , (IoPin.SOUTH, None, 'adrs_8'    , 'adrs(8)'  , 'adrs(8)'  )
                     , (IoPin.SOUTH, None, 'adrs_9'    , 'adrs(9)'  , 'adrs(9)'  )
                     , (IoPin.SOUTH, None, 'adrs_10'   , 'adrs(10)' , 'adrs(10)' )
                     , (IoPin.SOUTH, None, 'adrs_11'   , 'adrs(11)' , 'adrs(11)' )
                     , (IoPin.SOUTH, None, 'adrs_12'   , 'adrs(12)' , 'adrs(12)' )
                     , (IoPin.SOUTH, None, 'adrs_13'   , 'adrs(13)' , 'adrs(13)' )
                     , (IoPin.SOUTH, None, 'adrs_14'   , 'adrs(14)' , 'adrs(14)' )
                     , (IoPin.SOUTH, None, 'adrs_15'   , 'adrs(15)' , 'adrs(15)' )

                     , (IoPin.EAST , None, 'data_0'    , 'data(0)'  , 'data(0)'  )
                     , (IoPin.EAST , None, 'data_1'    , 'data(1)'  , 'data(1)'  )
                     , (IoPin.EAST , None, 'data_2'    , 'data(2)'  , 'data(2)'  )
                     , (IoPin.EAST , None, 'data_3'    , 'data(3)'  , 'data(3)'  )
                     , (IoPin.EAST , None, 'data_4'    , 'data(4)'  , 'data(4)'  )
                     , (IoPin.EAST , None, 'data_5'    , 'data(5)'  , 'data(5)'  )
                     , (IoPin.EAST , None, 'data_6'    , 'data(6)'  , 'data(6)'  )
                     , (IoPin.EAST , None, 'data_7'    , 'data(7)'  , 'data(7)'  )
                     , (IoPin.EAST , None, 'iopower_1' , 'iovdd' )
                     , (IoPin.EAST , None, 'power_1'   , 'vdd'   )
                     , (IoPin.EAST , None, 'ground_1'  , 'vss'   )
                     , (IoPin.EAST , None, 'ioground_1', 'vss'   )
                     , (IoPin.EAST , None, 'datao_0'   , 'datao(0)'  , 'datao(0)'  )
                     , (IoPin.EAST , None, 'datao_1'   , 'datao(1)'  , 'datao(1)'  )
                     , (IoPin.EAST , None, 'datao_2'   , 'datao(2)'  , 'datao(2)'  )
                     , (IoPin.EAST , None, 'datao_3'   , 'datao(3)'  , 'datao(3)'  )
                     , (IoPin.EAST , None, 'datao_4'   , 'datao(4)'  , 'datao(4)'  )
                     , (IoPin.EAST , None, 'datao_5'   , 'datao(5)'  , 'datao(5)'  )
                     , (IoPin.EAST , None, 'datao_6'   , 'datao(6)'  , 'datao(6)'  )
                     , (IoPin.EAST , None, 'datao_7'   , 'datao(7)'  , 'datao(7)'  )

                     , (IoPin.WEST , None, 'debug_0'   , 'debug(0)'  , 'debug(0)'  )
                     , (IoPin.WEST , None, 'debug_1'   , 'debug(1)'  , 'debug(1)'  )
                     , (IoPin.WEST , None, 'debug_2'   , 'debug(2)'  , 'debug(2)'  )
                     , (IoPin.WEST , None, 'debug_3'   , 'debug(3)'  , 'debug(3)'  )
                     , (IoPin.WEST , None, 'debug_4'   , 'debug(4)'  , 'debug(4)'  )
                     , (IoPin.WEST , None, 'debug_5'   , 'debug(5)'  , 'debug(5)'  )
                     , (IoPin.WEST , None, 'debug_6'   , 'debug(6)'  , 'debug(6)'  )
                     , (IoPin.WEST , None, 'debug_7'   , 'debug(7)'  , 'debug(7)'  )
                     , (IoPin.WEST , None, 'iopower_2' , 'iovdd' )
                     , (IoPin.WEST , None, 'power_2'   , 'vdd'   )
                     , (IoPin.WEST , None, 'ground_2'  , 'vss'   )
                     , (IoPin.WEST , None, 'ioground_2', 'vss'   )
                     , (IoPin.WEST , None, 'debug_8'   , 'debug(8)'  , 'debug(8)'  )
                     , (IoPin.WEST , None, 'debug_9'   , 'debug(9)'  , 'debug(9)'  )
                     , (IoPin.WEST , None, 'debug_10'  , 'debug(10)' , 'debug(10)' )
                     , (IoPin.WEST , None, 'debug_11'  , 'debug(11)' , 'debug(11)' )
                     , (IoPin.WEST , None, 'debug_12'  , 'debug(12)' , 'debug(12)' )
                     , (IoPin.WEST , None, 'debug_13'  , 'debug(13)' , 'debug(13)' )
                     , (IoPin.WEST , None, 'debug_14'  , 'debug(14)' , 'debug(14)' )
                     , (IoPin.WEST , None, 'debug_15'  , 'debug(15)' , 'debug(15)' )

                     , (IoPin.NORTH, None, 'irq'       , 'irq'      , 'irq'      )
                     , (IoPin.NORTH, None, 'm_clock'   , 'm_clock'  , 'm_clock'  )
                     , (IoPin.NORTH, None, 'nmi'       , 'nmi'      , 'nmi'      )
                     , (IoPin.NORTH, None, 'p_reset'   , 'p_reset'  , 'p_reset'  )
                     , (IoPin.NORTH, None, 'rdy'       , 'rdy'      , 'rdy'      )
                     , (IoPin.NORTH, None, 'iopower_3' , 'iovdd' )
                     , (IoPin.NORTH, None, 'power_3'   , 'vdd'   )
                     , (IoPin.NORTH, None, 'ground_3'  , 'vss'   )
                     , (IoPin.NORTH, None, 'ioground_3', 'vss'   )
                     , (IoPin.NORTH, None, 'start'     , 'start'    , 'start'    )
                     , (IoPin.NORTH, None, 'rd'        , 'rd'       , 'rd'       )
                     , (IoPin.NORTH, None, 'sync'      , 'sync'     , 'sync'     )
                     , (IoPin.NORTH, None, 'wt'        , 'wt'       , 'wt'       )
                     ]
        m65sConf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        m65sConf.cfg.misc.logMode                = True
       #m65sConf.cfg.etesian.bloat               = 'nsxlib'
        m65sConf.cfg.etesian.uniformDensity      = True
       #m65sConf.cfg.etesian.spaceMargin         = 0.20
       #m65sConf.cfg.etesian.aspectRatio         = 1.00
        m65sConf.cfg.katana.hTracksReservedMin   = 0 
        m65sConf.cfg.katana.vTracksReservedMin   = 0 
        m65sConf.cfg.katana.hTracksReservedLocal = 7 
        m65sConf.cfg.katana.vTracksReservedLocal = 7 
        m65sConf.cfg.block.spareSide             = l(700)
        m65sConf.cfg.chip.padCoreSide            = 'North'
        m65sConf.editor              = editor
        m65sConf.useSpares           = True
        m65sConf.padsHavePosition    = False
        m65sConf.bColumns            = 2
        m65sConf.bRows               = 2
        m65sConf.chipConf.name       = 'chip'
        m65sConf.chipConf.ioPadGauge = 'niolib'
        m65sConf.coreSize            = ( l( 4500), l( 4500) )
        m65sConf.chipSize            = ( l(12400), l(12400) )
        m65sConf.useHTree( 'm_clock' )
        if buildChip:
            m65sToChip = CoreToChip( m65sConf )
            m65sToChip.buildChip()
            chipBuilder = Chip( m65sConf )
            chipBuilder.doChipFloorplan()
            rvalue = chipBuilder.doPnR()
            chipBuilder.save()
        else:
            blockBuilder = Block( m65sConf )
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
