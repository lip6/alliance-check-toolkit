#!/usr/bin/env python

from helpers import l, u, n


chip = { 'pads.ioPadGauge' : 'pxlib'
                          #   | Instance  | Pad   | To Core          | From Core     | Enable    |
       , 'pads.instances' : [ [ 'p_q0'    , 'q0'  , 'q0_from_pads'   , 'q0_to_pads'  , 'shift_r' ]
                            , [ 'p_r0'    , 'r0'  , 'r0_from_pads'   , 'r0_to_pads'  , 'shift_r' ]
                            , [ 'p_q3'    , 'q3'  , 'q3_from_pads'   , 'q3_to_pads'  , 'shift_l' ]
                            , [ 'p_r3'    , 'r3'  , 'r3_from_pads'   , 'r3_to_pads'  , 'shift_l' ]
                            # "a" input.
                            , [ 'p_a0'    , 'a(0)', 'a_from_pads(0)' ]
                            , [ 'p_a1'    , 'a(1)', 'a_from_pads(1)' ]
                            , [ 'p_a2'    , 'a(2)', 'a_from_pads(2)' ]
                            , [ 'p_a3'    , 'a(3)', 'a_from_pads(3)' ]
                            # "b" input.
                            , [ 'p_b0'    , 'b(0)', 'b_from_pads(0)' ]
                            , [ 'p_b1'    , 'b(1)', 'b_from_pads(1)' ]
                            , [ 'p_b2'    , 'b(2)', 'b_from_pads(2)' ]
                            , [ 'p_b3'    , 'b(3)', 'b_from_pads(3)' ]
                            # "d" input.
                            , [ 'p_d0'    , 'd(0)', 'd_from_pads(0)' ]
                            , [ 'p_d1'    , 'd(1)', 'd_from_pads(1)' ]
                            , [ 'p_d2'    , 'd(2)', 'd_from_pads(2)' ]
                            , [ 'p_d3'    , 'd(3)', 'd_from_pads(3)' ]
                            # "y" output.
                            , [ 'p_y0'    , 'y(0)',   'y_to_pads(0)' , 'y_oe' ]
                            , [ 'p_y1'    , 'y(1)',   'y_to_pads(1)' , 'y_oe' ]
                            , [ 'p_y2'    , 'y(2)',   'y_to_pads(2)' , 'y_oe' ]
                            , [ 'p_y3'    , 'y(3)',   'y_to_pads(3)' , 'y_oe' ]
                            # "i" (instruction) input.
                            , [ 'p_i0'    , 'i(0)', 'i_from_pads(0)' ]
                            , [ 'p_i1'    , 'i(1)', 'i_from_pads(1)' ]
                            , [ 'p_i2'    , 'i(2)', 'i_from_pads(2)' ]
                            , [ 'p_i3'    , 'i(3)', 'i_from_pads(3)' ]
                            , [ 'p_i4'    , 'i(4)', 'i_from_pads(4)' ]
                            , [ 'p_i5'    , 'i(5)', 'i_from_pads(5)' ]
                            , [ 'p_i6'    , 'i(6)', 'i_from_pads(6)' ]
                            , [ 'p_i7'    , 'i(7)', 'i_from_pads(7)' ]
                            , [ 'p_i8'    , 'i(8)', 'i_from_pads(8)' ]
                            # Flags I/O.
                            , [ 'p_noe'   , 'noe' ,  'noe_from_pads' ]
                            , [ 'p_cin'   , 'cin' ,  'cin_from_pads' ]
                            , [ 'p_cout'  , 'cout',   'cout_to_pads' ]
                            , [ 'p_np'    , 'np'  ,     'np_to_pads' ]
                            , [ 'p_ng'    , 'ng'  ,     'ng_to_pads' ]
                            , [ 'p_ovr'   , 'ovr' ,    'ovr_to_pads' ]
                            , [ 'p_zero'  , 'zero',   'zero_to_pads' ]
                            , [ 'p_f3'    , 'f3'  ,     'f3_to_pads' ]
                            ]
       , 'pads.south'     : [ 'p_a3'  , 'p_a2', 'p_a1', 'p_r0', 'p_vddick_0', 'p_vssick_0', 'p_a0'     , 'p_i6', 'p_i8' , 'p_i7'  , 'p_r3' ]
       , 'pads.east'      : [ 'p_zero', 'p_i0', 'p_i1', 'p_i2', 'p_vddeck_0', 'p_vsseck_0', 'p_q3'     , 'p_b0', 'p_b1' , 'p_b2'  , 'p_b3' ]
       , 'pads.north'     : [ 'p_noe' , 'p_y3', 'p_y2', 'p_y1',                             'p_y0'     , 'p_np', 'p_ovr', 'p_cout', 'p_ng' ]
       , 'pads.west'      : [ 'p_cin' , 'p_i4', 'p_i5', 'p_i3', 'p_ck_0'    , 'p_d0'      , 'p_d1'     , 'p_d2', 'p_d3' , 'p_q0'  , 'p_f3' ]
       , 'core.size'      : ( l(1300), l(1400) )
       , 'chip.size'      : ( l(3000), l(3000) )
       , 'chip.clockTree' : True
       , 'chip.name'      : 'am2901'
       }
