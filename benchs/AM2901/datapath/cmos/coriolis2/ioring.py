
from helpers import l, u, n

chip = { 'pads.ioPadGauge' : 'pxlib'
       , 'pads.south'      : [ 'p_cin'    , 'p_np'   , 'p_ng' , 'p_vssick0', 'p_vddeck0', 'p_vsseck1'
                             , 'p_vddeck1', 'p_cout' , 'p_y0' , 'p_y1'     , 'p_y2'
                             ]
       , 'pads.east'       : [ 'p_signe'  , 'p_y3'   , 'p_noe', 'p_a0'     , 'p_a1'     , 'p_vddick0'
                             , 'p_a2'     , 'p_a3'   , 'p_r0' , 'p_r3'     , 'p_i8'
                             ]
       , 'pads.north'      : [ 'p_i3'     , 'p_i4'   , 'p_i5' , 'p_b0'     , 'p_b1'     , 'p_b2'
                             , 'p_b3'     , 'p_q0'   , 'p_q3' , 'p_i6'     , 'p_i7'
                             ]
       , 'pads.west'       : [ 'p_ck'     , 'p_d0'   , 'p_d1' , 'p_d2'     , 'p_zero'   , 'p_vsseck0'
                             , 'p_ovr'    , 'p_d3'   , 'p_i0' , 'p_i1'     , 'p_i2'
                             ]
       , 'core.size'       : ( l(1500), l(1500) )
       , 'chip.size'       : ( l(3000), l(3000) )
       , 'chip.clockTree'  : False
       }
