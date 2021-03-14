
from   __future__ import print_function
import sys
import traceback
import CRL
import helpers
from   helpers.io import ErrorMessage, WarningMessage
from   helpers    import trace, l, u, n
import plugins
from   Hurricane  import Breakpoint, DbU
from   plugins.alpha.block.block         import Block
from   plugins.alpha.block.configuration import IoPin, GaugeConf
from   plugins.alpha.core2chip.cmos      import CoreToChip
from   plugins.alpha.chip.configuration  import ChipConf
from   plugins.alpha.chip.chip           import Chip


af = CRL.AllianceFramework.get()


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af
    rvalue = True
    try:
        #helpers.setTraceLevel( 540 )
        #Breakpoint.setStopLevel( 100 )
        usePadsPosition = True
        buildChip       = True
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'adder', CRL.Catalog.State.Logical )
        if cell is None:
            print( ErrorMessage( 2, 'doDesign.scriptMain(): Unable to load cell "{}".'.format('adder') ))
            sys.exit( 1 )
        if editor: editor.setCell( cell ) 

        if usePadsPosition:
            ioPadsSpec = [ (IoPin.SOUTH, l( 400.0), 'a_1'        , 'a(1)'   , 'a(1)'   )
                         , (IoPin.SOUTH, l( 600.0), 'allpower_0' , 'vddpad' , 'vdd'    )
                         , (IoPin.SOUTH, l(1000.0), 'a_0'        , 'a(0)'   , 'a(0)'   )
                         , (IoPin.EAST , l( 400.0), 'a_2'        , 'a(2)'   , 'a(2)'   )
                         , (IoPin.EAST , l( 600.0), 'a_3'        , 'a(3)'   , 'a(3)'   )
                         , (IoPin.EAST , l( 800.0), 'allground_0', 'vsspad' , 'vss'    )
                         , (IoPin.EAST , l(1000.0), 'b_3'        , 'b(3)'   , 'b(3)'   )
                         , (IoPin.EAST , l(1200.0), 'b_2'        , 'b(2)'   , 'b(2)'   )
                         , (IoPin.NORTH, l( 400.0), 'b_1'        , 'b(1)'   , 'b(1)'   )
                         , (IoPin.NORTH, l( 600.0), 'b_0'        , 'b(0)'   , 'b(0)'   )
                         , (IoPin.NORTH, l( 800.0), 'allground_1', 'vsspad' , 'vss'    )
                         , (IoPin.NORTH, l(1200.0), 'p_reset'    , 'p_reset', 'p_reset')
                         , (IoPin.NORTH, l( 400.0), 'clock_0'    , 'm_clock', 'm_clock')
                         , (IoPin.WEST , l( 600.0), 'f_3'        , 'f(3)'   , 'f(3)'   )
                         , (IoPin.WEST , l( 800.0), 'f_2'        , 'f(2)'   , 'f(2)'   )
                         , (IoPin.WEST , l(1000.0), 'f_1'        , 'f(1)'   , 'f(1)'   )
                         , (IoPin.WEST , l(1200.0), 'f_0'        , 'f(0)'   , 'f(0)'   )
                         ]
        else:
            #     Spec:  | Side        | Pos | Instance     | Pad net   |Core net |
            ioPadsSpec = [ (IoPin.SOUTH, None, 'a_1'        , 'a(1)'   , 'a(1)'   )
                         , (IoPin.SOUTH, None, 'power_0'    , 'vddpad' , 'vdd'    )
                         , (IoPin.SOUTH, None, 'a_0'        , 'a(0)'   , 'a(0)'   )
                         , (IoPin.EAST , None, 'a_2'        , 'a(2)'   , 'a(2)'   )
                         , (IoPin.EAST , None, 'a_3'        , 'a(3)'   , 'a(3)'   )
                         , (IoPin.EAST , None, 'ground_0'   , 'vsspad' , 'vss'    )
                         , (IoPin.EAST , None, 'b_3'        , 'b(3)'   , 'b(3)'   )
                         , (IoPin.EAST , None, 'b_2'        , 'b(2)'   , 'b(2)'   )
                         , (IoPin.NORTH, None, 'b_1'        , 'b(1)'   , 'b(1)'   )
                         , (IoPin.NORTH, None, 'b_0'        , 'b(0)'   , 'b(0)'   )
                         , (IoPin.NORTH, None, 'ground_1'   , 'vsspad' , 'vss'    )
                         , (IoPin.NORTH, None, 'p_reset'    , 'p_reset', 'p_reset')
                         , (IoPin.NORTH, None, 'clock_0'    , 'm_clock', 'm_clock')
                         , (IoPin.WEST , None, 'f_3'        , 'f(3)'   , 'f(3)'   )
                         , (IoPin.WEST , None, 'f_2'        , 'f(2)'   , 'f(2)'   )
                         , (IoPin.WEST , None, 'f_1'        , 'f(1)'   , 'f(1)'   )
                         , (IoPin.WEST , None, 'f_0'        , 'f(0)'   , 'f(0)'   )
                         ]
        adderConf = ChipConf \
            ( cell
            , ioPins=[ (IoPin.SOUTH|IoPin.A_BEGIN, 'a({})'  , l(  50.0), l( 50.0),  4)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'b({})'  , l(  50.0), l( 50.0),  4)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'f({})'  , l(  50.0), l( 50.0),  4)

                     , (IoPin.NORTH|IoPin.A_BEGIN, 'm_clock', l(300.0), 0, 1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'p_reset', l(500.0), 0, 1)
                     ]
            , ioPads=ioPadsSpec
            )
        adderConf.cfg.etesian.bloat          = 'nsxlib'
        adderConf.cfg.etesian.uniformDensity = True
        adderConf.cfg.etesian.aspectRatio    = 1.0
        adderConf.cfg.etesian.spaceMargin    = 0.05
        adderConf.cfg.block.spareSide        = l(350)
        adderConf.editor              = editor
        adderConf.useSpares           = True
        adderConf.useClockTree        = True
        adderConf.padsHavePosition    = True
        adderConf.bColumns            = 2
        adderConf.bRows               = 2
        adderConf.chipConf.name       = 'chip'
        adderConf.chipConf.ioPadGauge = 'pxlib'
        adderConf.coreSize            = ( l( 800), l( 800) )
        adderConf.chipSize            = ( l(2116), l(2066) )
        if buildChip:
            adderToChip = CoreToChip( adderConf )
            adderToChip.buildChip()
            chipBuilder = Chip( adderConf )
            chipBuilder.doChipFloorplan()
            rvalue = chipBuilder.doPnR()
            chipBuilder.save()
        else:
            blockBuilder = Block( adderConf )
            rvalue = blockBuilder.doPnR()
            blockBuilder.save()
    except Exception, e:
        helpers.io.catch( e )
        rvalue = False
    sys.stdout.flush()
    sys.stderr.flush()
    return rvalue
