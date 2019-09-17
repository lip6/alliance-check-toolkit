#!/usr/bin/env python

from helpers import l, u, n


chip = { 'pads.ioPadGauge' : 'phlib80'
       # 24 I/O pads
       , 'pads.south'     : [ 'datai_0' , 'datai_1' , 'datai_2' , 'datai_3'
                            , 'datai_4' , 'datai_5' , 'datai_6' , 'datai_7'
                            , 'datai_8' , 'datai_9' , 'datai_10', 'datai_11'
                            , 'datai_12', 'datai_13', 'datai_14', 'datai_15'
                            , 'inst_0'  , 'inst_1'  , 'inst_2'  , 'inst_3'
                            , 'inst_4'  , 'inst_5'  , 'inst_6'  , 'inst_7'
                            ]
       # 25 I/O pads
       , 'pads.east'      : [ 'inst_8'  , 'inst_9'  , 'inst_10' , 'inst_11'
                            , 'inst_12' , 'inst_13' , 'inst_14' , 'inst_15'
                            , 'adrs_0'  , 'adrs_1'  , 'adrs_2'  , 'adrs_3'
                            , 'p_vssck_0'
                            , 'p_vddck_0'
                            , 'adrs_4'  , 'adrs_5'  , 'adrs_6'  , 'adrs_7'
                            , 'adrs_8'  , 'adrs_9'  , 'adrs_10' , 'adrs_11'
                            , 'adrs_12' , 'adrs_13' , 'adrs_14'
                            ]
       # 25 I/O pads
       , 'pads.north'     : [ 'adrs_15'
                            , 'datao_0' , 'datao_1' , 'datao_2' , 'datao_3'
                            , 'datao_4' , 'datao_5' , 'datao_6' , 'datao_7'
                            , 'datao_8' , 'datao_9' , 'datao_10', 'datao_11'
                            , 'datao_12', 'datao_13', 'datao_14', 'datao_15'
                            , 'iadrs_0' , 'iadrs_1' , 'iadrs_2' , 'iadrs_3'
                            , 'iadrs_4' , 'iadrs_5' , 'iadrs_6' , 'iadrs_7'
                            ]
       # 25 I/O pads
       , 'pads.west'      : [ 'iadrs_8' , 'iadrs_9' , 'iadrs_10', 'iadrs_11'
                            , 'iadrs_12', 'iadrs_13', 'iadrs_14', 'iadrs_15'
                            , 'inst_ok'
                            , 'intreq'
                            , 'p_m_clock_0'
                            , 'mem_ok'
                            , 'p_reset'
                            , 'start'
                            , 'hlt'
                            , 'inst_adr'
                            , 'inst_read'
                            , 'intack'
                            , 'memory_adr'
                            , 'memory_read'
                            , 'memory_write'
                            , 'wb'
                            , 'scin'
                            , 'scout'
                            , 'sctest'
                            ]
       , 'core.size'      : ( l(4100), l(4100) )
       , 'chip.size'      : ( l(6774), l(6774) )
       , 'chip.clockTree' : True
       , 'chip.name'      : 'snx_chip'
       }
