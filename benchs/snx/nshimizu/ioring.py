#!/usr/bin/env python

from helpers import l, u, n

usePosition = True

chip = { 'pads.ioPadGauge' : 'phlib80'
       # 20 I/O pads
       , 'pads.south'     : [ 
                              [l(515.0), 'datao_15']
                            , [l(761.0), 'datao_14']
                            , [l(1007.0), 'datao_13']
                            , [l(1253.0), 'datao_12']
                            , [l(1499.0), 'datao_11']
                            , [l(1745.0), 'datao_10' ]
                            , [l(1991.0), 'datao_9' ]
                            , [l(2237.0), 'datao_8']
                            , [l(2483.0), 'datao_7' ]
                            , [l(2729.0), 'datao_6' ]
                            , [l(2975.0), 'datao_5' ]
                            , [l(3221.0), 'datao_4']
                            , [l(3467.0), 'datao_3' ]
                            , [l(3713.0), 'datao_2' ]

                            ]
       # 20 I/O pads
       , 'pads.east'      : [ 
                              [l(515.0), 'adrs_0' ]
                            , [l(761.0), 'adrs_1' ]
                            , [l(1007.0), 'adrs_2'  ]
                            , [l(1253.0), 'adrs_3'   ]
                            , [l(1499.0), 'adrs_4'   ]
                            , [l(1745.0), 'adrs_5'   ]
                            , [l(1991.0), 'adrs_6' ]
                            , [l(2237.0), 'p_vssck_0' ]
                            , [l(2483.0), 'p_vddck_0' ]
                            , [l(2729.0), 'adrs_7'   ]
                            , [l(2975.0), 'adrs_8'   ]
                            , [l(3221.0), 'adrs_9'   ]
#                            , 'adrs_10' 
#                            , 'adrs_11'
#                            , 'adrs_12'
#                            , 'adrs_13'
#                            , 'adrs_14'
#                            , 'adrs_15'
                            , [l(3467.0), 'datao_1'  ]
                            , [l(3713.0), 'datao_0'  ]
                            , [l(3959.0), 'datai_14' ]
                            , [l(4205.0), 'datai_15' ]
                            ]
       # 20 I/O pads
       , 'pads.north'     : [
                              [l(515), 'datai_0' ]
                            , [l(761), 'datai_1']
                            , [l(1007), 'datai_2']
                            , [l(1253), 'datai_3' ]
                            , [l(1499), 'datai_4' ]
                            , [l(1745), 'datai_5']
                            , [l(1991), 'datai_6']
                            , [l(2237), 'datai_7' ]
                            , [l(2483), 'datai_8' ]
                            , [l(2729), 'datai_9']
                            , [l(2975), 'datai_10']
                            , [l(3221), 'datai_11' ]
                            , [l(3467), 'datai_12']
                            , [l(3713), 'datai_13' ]
                            ]
       # 20 I/O pads
       , 'pads.west'      : [ 
                             
                              [l(515), 'p_reset']
                            , [l(761), 'stgi']
                            , [l(1007), 'stge']
                            , [l(1253), 'stgl']
#                            , 'stgs']
                            , [l(1499), 'stgs2' ]
                            , [l(1745), 'wb']
                            , [l(1991), 'hlt']
                            , [l(2237), 'start']
                            , [l(2483), 'mem_ok']
                            , [l(2729), 'memory_adr']
                            , [l(2975), 'memory_read']
                            , [l(3221), 'memory_write']
                            , [l(3467), 'sctest']
                            , [l(3713), 'scout']
                            , [l(3959), 'scin']
                            , [l(4205), 'p_m_clock_0']
                            ]
       , 'core.size'      : ( l(3000), l(3000) )
       , 'chip.size'      : ( l(4800), l(4800) )
       , 'chip.clockTree' : True
       , 'chip.name'      : 'snx2_chip'
       }
