#!/usr/bin/env python


chip = { 'pads.south'     : [  'p_d2', 'p_d3', 'p_vddi', 'p_vssi', 'p_d4', 'p_d5']
       , 'pads.east'      : [ 'p_d0', 'p_d1', 'p_a0', 'p_a1'  , 'p_a2'  , 'p_a3' ]
       , 'pads.north'     : [ 'p_a4' , 'p_a5' ,'p_a6', 'p_vdde', 'p_vsse', 'p_a7' ]
       , 'pads.west'      : [ 'p_w', 'p_rs'  , 'p_ck'  ,  'p_d6', 'p_d7'  ]
       , 'core.size'      : ( 2500, 2500 )
       , 'chip.size'      : ( 4900, 4900 )
       , 'chip.clockTree' : True
       }
