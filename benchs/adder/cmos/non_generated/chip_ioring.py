#!/usr/bin/env python

from helpers import l, u, n


chip = { 'pads.ioPadGauge' : 'pxlib'
       , 'pads.south'      : [ 'p_a1', 'p_vddi', 'p_vssi', 'p_a0' ]
       , 'pads.east'       : [ 'p_a2', 'p_a3'  , 'p_b3'  , 'p_b2' ]
       , 'pads.north'      : [ 'p_b1', 'p_vdde', 'p_vsse', 'p_b0' ]
       , 'pads.west'       : [ 'p_f3', 'p_f2'  , 'p_ck'  , 'p_f1' , 'p_f0'  ]
       , 'core.size'       : ( l( 800), l( 800) )
       , 'chip.size'       : ( l(2000), l(2000) )
       , 'chip.clockTree'  : True
       }
