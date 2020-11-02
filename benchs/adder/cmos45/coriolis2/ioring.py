#!/usr/bin/env python

from helpers import l, u, n


chip = { 'pads.ioPadGauge' : 'pxlib'
       , 'pads.south'      : [ 'a_1', 'p_vddick_0', 'p_vssick_0' , 'a_0'       ]
       , 'pads.east'       : [ 'a_2', 'a_3'       , 'b_3'        , 'b_2'       ]
       , 'pads.north'      : [ 'b_1', 'p_vddeck_0', 'b_0'        , 'p_vsseck_0', 'p_reset' ]
       , 'pads.west'       : [ 'f_3', 'f_2'       , 'p_m_clock_0', 'f_1'       , 'f_0'     ]
       , 'core.size'       : ( l( 800), l( 800) )
       , 'chip.size'       : ( l(2250), l(2250) )
       , 'chip.clockTree'  : True
       }
