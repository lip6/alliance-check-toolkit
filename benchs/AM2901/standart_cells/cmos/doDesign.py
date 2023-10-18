
import sys
import traceback
from   coriolis            import CRL
from   coriolis.Hurricane  import DbU
from   coriolis.helpers.io import ErrorMessage, WarningMessage, catch
from   coriolis.helpers    import setTraceLevel, trace, l, u, n
from   coriolis            import plugins
from   coriolis.plugins.block.block         import Block
from   coriolis.plugins.block.configuration import IoPin
from   coriolis.plugins.block.configuration import GaugeConf
from   coriolis.plugins.core2chip.cmos      import CoreToChip
from   coriolis.plugins.chip.configuration  import ChipConf
from   coriolis.plugins.chip.chip           import Chip


af = CRL.AllianceFramework.get()


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af
    rvalue = True
    try:
       #setTraceLevel( 540 )
        buildChip = True
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'coeur', CRL.Catalog.State.Logical )
        if editor: editor.setCell( cell ) 

        #     | Side        | Pos | Instance     | Pad net | To core          | From core   | enable    |
        ioPadsSpec \
            = [ (IoPin.WEST , None, 'p_q0'       , 'q0'    , 'q0_from_pads'   , 'q0_to_pads', 'shift_r' )
              , (IoPin.SOUTH, None, 'p_r0'       , 'r0'    , 'r0_from_pads'   , 'r0_to_pads', 'shift_r' )
              , (IoPin.SOUTH, None, 'p_q3'       , 'q3'    , 'q3_from_pads'   , 'q3_to_pads', 'shift_l' )
              , (IoPin.EAST , None, 'p_r3'       , 'r3'    , 'r3_from_pads'   , 'r3_to_pads', 'shift_l' )
              , (IoPin.SOUTH, None, 'p_a0'       , 'a(0)'  , 'a_from_pads(0)' )
              , (IoPin.SOUTH, None, 'p_a1'       , 'a(1)'  , 'a_from_pads(1)' )
              , (IoPin.SOUTH, None, 'p_a2'       , 'a(2)'  , 'a_from_pads(2)' )
              , (IoPin.SOUTH, None, 'allpower_0' , 'vddpad', 'vdd'            )
              , (IoPin.SOUTH, None, 'allground_0', 'vsspad', 'vss'            )
              , (IoPin.SOUTH, None, 'p_a3'       , 'a(3)'  , 'a_from_pads(3)' )
              , (IoPin.EAST , None, 'p_b0'       , 'b(0)'  , 'b_from_pads(0)' )
              , (IoPin.EAST , None, 'p_b1'       , 'b(1)'  , 'b_from_pads(1)' )
              , (IoPin.EAST , None, 'p_b2'       , 'b(2)'  , 'b_from_pads(2)' )
              , (IoPin.EAST , None, 'p_b3'       , 'b(3)'  , 'b_from_pads(3)' )
              , (IoPin.WEST , None, 'p_d0'       , 'd(0)'  , 'd_from_pads(0)' )
              , (IoPin.WEST , None, 'p_d1'       , 'd(1)'  , 'd_from_pads(1)' )
              , (IoPin.WEST , None, 'p_d2'       , 'd(2)'  , 'd_from_pads(2)' )
              , (IoPin.WEST , None, 'p_d3'       , 'd(3)'  , 'd_from_pads(3)' )
              , (IoPin.NORTH, None, 'p_y0'       , 'y(0)'  , 'y_to_pads(0)'   , 'y_oe' )
              , (IoPin.NORTH, None, 'p_y1'       , 'y(1)'  , 'y_to_pads(1)'   , 'y_oe' )
              , (IoPin.NORTH, None, 'p_y2'       , 'y(2)'  , 'y_to_pads(2)'   , 'y_oe' )
              , (IoPin.NORTH, None, 'p_y3'       , 'y(3)'  , 'y_to_pads(3)'   , 'y_oe' )
              , (IoPin.EAST , None, 'p_i0'       , 'i(0)'  , 'i_from_pads(0)' )
              , (IoPin.EAST , None, 'p_i1'       , 'i(1)'  , 'i_from_pads(1)' )
              , (IoPin.EAST , None, 'p_i2'       , 'i(2)'  , 'i_from_pads(2)' )
              , (IoPin.WEST , None, 'p_i3'       , 'i(3)'  , 'i_from_pads(3)' )
              , (IoPin.WEST , None, 'clock_0'    , 'ck'    , 'ck'             )
              , (IoPin.WEST , None, 'p_i4'       , 'i(4)'  , 'i_from_pads(4)' )
              , (IoPin.WEST , None, 'p_i5'       , 'i(5)'  , 'i_from_pads(5)' )
              , (IoPin.SOUTH, None, 'p_i6'       , 'i(6)'  , 'i_from_pads(6)' )
              , (IoPin.SOUTH, None, 'p_i7'       , 'i(7)'  , 'i_from_pads(7)' )
              , (IoPin.SOUTH, None, 'p_i8'       , 'i(8)'  , 'i_from_pads(8)' )
              , (IoPin.NORTH, None, 'p_noe'      , 'noe'   , 'noe_from_pads'  )
              , (IoPin.WEST , None, 'p_cin'      , 'cin'   , 'cin_from_pads'  )
              , (IoPin.NORTH, None, 'p_cout'     , 'cout'  , 'cout_to_pads'   )
              , (IoPin.NORTH, None, 'p_np'       , 'np'    , 'np_to_pads'     )
              , (IoPin.NORTH, None, 'p_ng'       , 'ng'    , 'ng_to_pads'     )
              , (IoPin.NORTH, None, 'p_ovr'      , 'ovr'   , 'ovr_to_pads'    )
              , (IoPin.EAST , None, 'p_zero'     , 'zero'  , 'zero_to_pads'   )
              , (IoPin.WEST , None, 'p_f3'       , 'f3'    , 'f3_to_pads'     )
              ]
        am2901Conf = ChipConf( cell , ioPads=ioPadsSpec )
        am2901Conf.cfg.etesian.bloat          = 'nsxlib'
        am2901Conf.cfg.etesian.densityVariation = 0.05
        am2901Conf.cfg.etesian.aspectRatio    = 1.0
        am2901Conf.cfg.etesian.spaceMargin    = 0.05
        am2901Conf.cfg.block.spareSide        = l(600)
        am2901Conf.editor              = editor
        am2901Conf.useSpares           = True
        am2901Conf.bColumns            = 1
        am2901Conf.bRows               = 1
        am2901Conf.chipConf.name       = 'am2901'
        am2901Conf.chipConf.ioPadGauge = 'pxlib'
       #am2901Conf.coreSize            = ( l(1600), l(1500) )
        am2901Conf.chipSize            = ( l(3400), l(3400) )
        am2901Conf.coreToChipClass     = CoreToChip
        am2901Conf.useHTree( 'ck' )
        if buildChip:
            chipBuilder = Chip( am2901Conf )
            chipBuilder.doChipNetlist()
            chipBuilder.doChipFloorplan()
            rvalue = chipBuilder.doPnR()
            chipBuilder.save()
        else:
            blockBuilder = Block( am2901Conf )
            rvalue = blockBuilder.doPnR()
            blockBuilder.save()
    except Exception as e:
        catch( e )
        rvalue = False
    sys.stdout.flush()
    sys.stderr.flush()
    return rvalue
