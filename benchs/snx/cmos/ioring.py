# -*- Mode:Python -*-

from helpers import l, u, n


chip = { 'pads.ioPadGauge' : 'pxlib'
       , 'pads.south'     : [ 'n_adrs_0' , 'n_adrs_1' , 'n_adrs_2' , 'n_adrs_3'
                            , 'n_adrs_4' , 'n_adrs_5' , 'n_adrs_6' , 'n_adrs_7'
                            , 'n_inst_12', 'n_inst_13', 'n_inst_14', 'n_inst_15'
                            , 'p_vsseck_0'
                            , 'n_hlt'    , 'n_wb'     , 'n_start'
                            , 'n_adrs_8' , 'n_adrs_9' , 'n_adrs_10', 'n_adrs_11'
                            , 'n_adrs_12', 'n_adrs_13', 'n_adrs_14', 'n_adrs_15'
                            ]
       , 'pads.east'      : [ 'n_iadrs_0' , 'n_iadrs_1' , 'n_iadrs_2', 'n_iadrs_3'
                            , 'n_iadrs_4' , 'n_iadrs_5' , 'n_iadrs_6', 'n_iadrs_7'
                            , 'n_inst_8'  , 'n_inst_9'  , 'n_inst_10', 'n_inst_11'
                            , 'p_vddeck_0'
                            , 'n_inst_read', 'n_inst_adr', 'n_inst_ok'
                            , 'n_iadrs_8'  , 'n_iadrs_9' , 'n_iadrs_10', 'n_iadrs_11'
                            , 'n_iadrs_12' , 'n_iadrs_13', 'n_iadrs_14', 'n_iadrs_15'
                            ]
       , 'pads.north'     : [ 'n_datao_0'  , 'n_datao_1', 'n_datao_2', 'n_datao_3'
                            , 'n_datao_4'  , 'n_datao_5', 'n_datao_6', 'n_datao_7'
                            , 'n_inst_4'   , 'n_inst_5' , 'n_inst_6' , 'n_inst_7'
                            , 'p_m_clock_0', 'p_vssick_0'
                            , 'p_reset'    , 'n_intack', 'n_intreq'
                            , 'n_datao_8'  , 'n_datao_9' , 'n_datao_10', 'n_datao_11'
                            , 'n_datao_12' , 'n_datao_13', 'n_datao_14', 'n_datao_15'
                            ]
       , 'pads.west'      : [ 'n_datai_0', 'n_datai_1', 'n_datai_2', 'n_datai_3'
                            , 'n_datai_4', 'n_datai_5', 'n_datai_6', 'n_datai_7'
                            , 'n_inst_0' , 'n_inst_1' , 'n_inst_2' , 'n_inst_3'
                            , 'p_vddick_0'
                            , 'n_memory_read', 'n_memory_write', 'n_memory_adr', 'n_mem_ok'
                            , 'n_datai_8' , 'n_datai_9' , 'n_datai_10', 'n_datai_11'
                            , 'n_datai_12', 'n_datai_13', 'n_datai_14', 'n_datai_15'
                            ]
       , 'core.size'      : (  l(2400),  l(2700) )
      #, 'core.size'      : ( l(15000), l(15000) )
       , 'chip.size'      : (  l(5800),  l(5800) )
      #, 'chip.size'      : (  l(5600),  l(5800) )
      #, 'chip.size'      : ( l(5124095576030431), l(11800) )
       , 'chip.clockTree' : True
       }
