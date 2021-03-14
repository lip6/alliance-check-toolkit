
from   __future__ import print_function
import sys
import traceback
import CRL
import helpers
from   helpers.io import ErrorMessage, WarningMessage
from   helpers    import trace, l, u, n
import plugins
from   Hurricane  import DbU, Breakpoint
from   plugins.alpha.block.block         import Block
from   plugins.alpha.block.configuration import IoPin, GaugeConf
from   plugins.alpha.core2chip.niolib    import CoreToChip
from   plugins.alpha.chip.configuration  import ChipConf
from   plugins.alpha.chip.chip           import Chip


af = CRL.AllianceFramework.get()


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af
    rvalue = True
    try:
        #helpers.setTraceLevel( 550 )
        #Breakpoint.setStopLevel( 100 )
        buildChip       = True
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'adder', CRL.Catalog.State.Logical )
        if cell is None:
            print( ErrorMessage( 2, 'doDesign.scriptMain(): Unable to load cell "{}".'.format('adder') ))
            sys.exit( 1 )
        if editor: editor.setCell( cell ) 
        #     Spec:  | Side        | Pos | Instance     | Pad net  | Core net | Direction |
        ioPadsSpec = [ (IoPin.SOUTH, None, 'a_1'        , 'a(1)'   , 'a(1)'   )
                     , (IoPin.SOUTH, None, 'iopower_0'  , 'iovdd'  )
                     , (IoPin.SOUTH, None, 'power_0'    , 'vdd'    )
                     , (IoPin.SOUTH, None, 'a_0'        , 'a(0)'   , 'a(0)'   )
                     , (IoPin.EAST , None, 'a_2'        , 'a(2)'   , 'a(2)'   )
                     , (IoPin.EAST , None, 'a_3'        , 'a(3)'   , 'a(3)'   )
                     , (IoPin.EAST , None, 'ioground_0' , 'iovss'  )
                     , (IoPin.EAST , None, 'ground_0'   , 'vss'    )
                     , (IoPin.EAST , None, 'b_3'        , 'b(3)'   , 'b(3)'   )
                     , (IoPin.EAST , None, 'b_2'        , 'b(2)'   , 'b(2)'   )
                     , (IoPin.NORTH, None, 'ioground_1' , 'iovss'  , 'vss'    )
                     , (IoPin.NORTH, None, 'b_1'        , 'b(1)'   , 'b(1)'   )
                     , (IoPin.NORTH, None, 'b_0'        , 'b(0)'   , 'b(0)'   )
                    #, (IoPin.NORTH, None, 'ground_1'   , 'iovss'  , 'vss'    )
                     , (IoPin.NORTH, None, 'p_clock'    , 'm_clock', 'm_clock')
                     , (IoPin.NORTH, None, 'p_reset'    , 'p_reset', 'p_reset')
                     , (IoPin.NORTH, None, 'ioground_2' , 'iovss'  )
                     , (IoPin.WEST , None, 'f_3'        , 'f(3)'   , 'f(3)'   )
                     , (IoPin.WEST , None, 'f_2'        , 'f(2)'   , 'f(2)'   )
                     , (IoPin.WEST , None, 'f_1'        , 'f(1)'   , 'f(1)'   )
                     , (IoPin.WEST , None, 'f_0'        , 'f(0)'   , 'f(0)'   )
                     ]
        adderConf = ChipConf( cell, ioPads=ioPadsSpec )
        adderConf.cfg.etesian.bloat          = 'nsxlib'
        adderConf.cfg.etesian.uniformDensity = True
        adderConf.cfg.etesian.aspectRatio    = 1.0
        adderConf.cfg.etesian.spaceMargin    = 0.05
        adderConf.cfg.block.spareSide        = l(700)
        adderConf.cfg.chip.padCoreSide       = 'North'
        adderConf.editor              = editor
        adderConf.useSpares           = True
        adderConf.useClockTree        = True
        adderConf.padsHavePosition    = False
        adderConf.bColumns            = 2
        adderConf.bRows               = 2
        adderConf.chipConf.name       = 'chip'
        adderConf.chipConf.ioPadGauge = 'niolib'
        adderConf.coreSize            = ( l(1500), l(1500) )
        adderConf.chipSize            = ( l(5400), l(5400) )
        adderToChip = CoreToChip( adderConf )
        adderToChip.buildChip()
        chipBuilder = Chip( adderConf )
        chipBuilder.doChipFloorplan()
        rvalue = chipBuilder.doPnR()
        chipBuilder.save()
    except Exception, e:
        helpers.io.catch( e )
        rvalue = False
    sys.stdout.flush()
    sys.stderr.flush()
    return rvalue
