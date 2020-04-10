#!/usr/bin/env python

from helpers import l, u, n

usePosition = True

position={0:0}
for i in range(20):
    position[i+1]=246*(i+1)+114

chip = { 'pads.ioPadGauge' : 'phlib80'
       # 20 I/O pads
       , 'pads.south'     : [ 
                              [l(position[2]), 'datao_15']
                            , [l(position[3]), 'datao_14']
                            , [l(position[4]), 'datao_13']
                            , [l(position[5]), 'datao_12']
                            , [l(position[6]), 'datao_11']
                            , [l(position[7]), 'datao_10' ]
                            , [l(position[8]), 'datao_9' ]
                            , [l(position[9]), 'datao_8']
                            , [l(position[10]), 'datao_7' ]
                            , [l(position[11]), 'datao_6' ]
                            , [l(position[12]), 'datao_5' ]
                            , [l(position[13]), 'datao_4']
                            , [l(position[14]), 'datao_3' ]
                            , [l(position[15]), 'datao_2' ]

                            ]
       # 20 I/O pads
       , 'pads.east'      : [ 
                              [l(position[2]), 'adrs_0' ]
                            , [l(position[3]), 'adrs_1' ]
                            , [l(position[4]), 'adrs_2'  ]
                            , [l(position[5]), 'adrs_3'   ]
                            , [l(position[6]), 'adrs_4'   ]
                            , [l(position[7]), 'adrs_5'   ]
                            , [l(position[8]), 'adrs_6' ]
                            , [l(position[9]), 'p_vssck_0' ]
                            , [l(position[10]), 'p_vddck_0' ]
                            , [l(position[11]), 'adrs_7'   ]
                            , [l(position[12]), 'adrs_8'   ]
                            , [l(position[13]), 'adrs_9'   ]
#                            , 'adrs_10' 
#                            , 'adrs_11'
#                            , 'adrs_12'
#                            , 'adrs_13'
#                            , 'adrs_14'
#                            , 'adrs_15'
                            , [l(position[14]), 'datao_1'  ]
                            , [l(position[15]), 'datao_0'  ]
                            , [l(position[16]), 'datai_14' ]
                            , [l(position[17]), 'datai_15' ]
                            ]
       # 20 I/O pads
       , 'pads.north'     : [
                              [l(position[2]), 'datai_0' ]
                            , [l(position[3]), 'datai_1']
                            , [l(position[4]), 'datai_2']
                            , [l(position[5]), 'datai_3' ]
                            , [l(position[6]), 'datai_4' ]
                            , [l(position[7]), 'datai_5']
                            , [l(position[8]), 'datai_6']
                            , [l(position[9]), 'datai_7' ]
                            , [l(position[10]), 'datai_8' ]
                            , [l(position[11]), 'datai_9']
                            , [l(position[12]), 'datai_10']
                            , [l(position[13]), 'datai_11' ]
                            , [l(position[14]), 'datai_12']
                            , [l(position[15]), 'datai_13' ]
                            ]
       # 20 I/O pads
       , 'pads.west'      : [ 
                             
                              [l(position[2]), 'p_reset']
                            , [l(position[3]), 'stgi']
                            , [l(position[4]), 'stge']
                            , [l(position[5]), 'stgl']
#                            , 'stgs']
                            , [l(position[6]), 'stgs2' ]
                            , [l(position[7]), 'wb']
                            , [l(position[8]), 'hlt']
                            , [l(position[9]), 'start']
                            , [l(position[10]), 'mem_ok']
                            , [l(position[11]), 'memory_adr']
                            , [l(position[12]), 'memory_read']
                            , [l(position[13]), 'memory_write']
                            , [l(position[14]), 'sctest']
                            , [l(position[15]), 'scout']
                            , [l(position[16]), 'scin']
                            , [l(position[17]), 'p_m_clock_0']
                            ]
       , 'core.size'      : ( l(3200), l(3200) )
       , 'chip.size'      : ( l(5150), l(5150) )
       , 'chip.clockTree' : True
       , 'chip.name'      : 'snx2_chip'
       }
