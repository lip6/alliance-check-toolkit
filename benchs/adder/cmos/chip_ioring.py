#!/usr/bin/env python

from helpers import l, u, n


chip = { 'pads.ioPadGauge' : 'pxlib'
       , 'pads.south'      : [ 'a_1', 'vdd_i_0', 'vss_i_0'  , 'a_0'      ]
       , 'pads.east'       : [ 'a_2', 'a_3'    , 'b_3'      , 'b_2'      ]
       , 'pads.north'      : [ 'b_1', 'vdd_o_0', 'b_0'      , 'vss_o_0'  , 'p_reset' ]
       , 'pads.west'       : [ 'f_3', 'f_2'    , 'm_clock_0', 'f_1'      , 'f_0'     ]
       , 'core.size'       : ( l( 800), l( 800) )
       , 'chip.size'       : ( l(2000), l(2000) )
       , 'chip.clockTree'  : True
       }
