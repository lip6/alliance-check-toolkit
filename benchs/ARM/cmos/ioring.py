#!/usr/bin/env python

from helpers import l, u, n

# 118 pads
# 46 pads / faces
chip = { 'pads.ioPadGauge' : 'pxlib'
       , 'pads.south'     : [ 'if_adr_0',  'if_adr_1',  'if_adr_2',  'if_adr_3',  'if_adr_4',  'if_adr_5',  'if_adr_6',  'if_adr_7',
                              'if_adr_8',  'if_adr_9',  'if_adr_10', 'if_adr_11', 'if_adr_12', 'if_adr_13', 'if_adr_14', 'if_adr_15',
                              'pvsse_0' ,  'pvdde_0' ,  'pvddi_0'  , 'pvssi_0'  ,
                              'if_adr_16', 'if_adr_17', 'if_adr_18', 'if_adr_19', 'if_adr_20', 'if_adr_21', 'if_adr_22', 'if_adr_23',
                              'if_adr_24', 'if_adr_25', 'if_adr_26', 'if_adr_27', 'if_adr_28', 'if_adr_29', 'if_adr_30', 'if_adr_31',
                              'if_adr_valid_pad', 'ic_stall_pad', 'mem_stw_pad', 'mem_stb_pad', 'mem_load_pad', 'dc_stall_pad', 'pck', 'preset',
                              'ic_inst_0',  'ic_inst_1' ]
       , 'pads.east'      : [ 'ic_inst_2',  'ic_inst_3',  'ic_inst_4',  'ic_inst_5',  'ic_inst_6',  'ic_inst_7',  'ic_inst_8',  'ic_inst_9',
                              'ic_inst_10', 'ic_inst_11', 'ic_inst_12', 'ic_inst_13', 'ic_inst_14', 'ic_inst_15', 'ic_inst_16', 'ic_inst_17',
                              'pvsse_1'   , 'pvdde_1'   , 'pvddi_1'   , 'pvssi_1'   ,
                              'ic_inst_18', 'ic_inst_19', 'ic_inst_20', 'ic_inst_21', 'ic_inst_22', 'ic_inst_23', 'ic_inst_24', 'ic_inst_25',
                              'ic_inst_26', 'ic_inst_27', 'ic_inst_28', 'ic_inst_29', 'ic_inst_30', 'ic_inst_31', 'dc_data_31', 'dc_data_30',
                              'dc_data_29', 'dc_data_28', 'dc_data_27', 'dc_data_26', 'dc_data_25', 'dc_data_24', 'dc_data_23', 'dc_data_22',
                              'dc_data_21', 'dc_data_20' ]
       , 'pads.north'     : [ 'mem_data_10', 'mem_data_11', 'mem_data_12', 'mem_data_13', 'mem_data_14', 'mem_data_15', 'mem_data_16', 'mem_data_17',
                              'mem_data_18', 'mem_data_19', 'mem_data_20', 'mem_data_21', 'mem_data_22', 'mem_data_23', 'mem_data_24', 'mem_data_25',
                              'mem_data_26', 'mem_data_27', 'mem_data_28', 'mem_data_29', 'mem_data_30', 'mem_data_31', 'dc_data_0',   'dc_data_1',
                              'pvsse_2'    , 'pvdde_2'    , 'pvddi_2'    , 'pvssi_2'    ,
                              'dc_data_2',   'dc_data_3',   'dc_data_4',   'dc_data_5',   'dc_data_6',   'dc_data_7',   'dc_data_8',   'dc_data_9',
                              'dc_data_10',  'dc_data_11',  'dc_data_12',  'dc_data_13',  'dc_data_14',  'dc_data_15',  'dc_data_16',  'dc_data_17',
                              'dc_data_18',  'dc_data_19' ]
       , 'pads.west'      : [ 'mem_adr_0',  'mem_adr_1',  'mem_adr_2' , 'mem_adr_3' , 'mem_adr_4',  'mem_adr_5',  'mem_adr_6',  'mem_adr_7',
                              'mem_adr_8',  'mem_adr_9',  'mem_adr_10', 'mem_adr_11', 'mem_adr_12', 'mem_adr_13', 'mem_adr_14', 'mem_adr_15',
                              'pvsse_3'  ,  'pvdde_3'  ,  'pvddi_3'   , 'pvssi_3'   ,
                              'mem_adr_16', 'mem_adr_17', 'mem_adr_18', 'mem_adr_19', 'mem_adr_20', 'mem_adr_21', 'mem_adr_22', 'mem_adr_23',
                              'mem_adr_24', 'mem_adr_25', 'mem_adr_26', 'mem_adr_27', 'mem_adr_28', 'mem_adr_29', 'mem_adr_30', 'mem_adr_31',
                              'mem_data_0', 'mem_data_1', 'mem_data_2', 'mem_data_3', 'mem_data_4', 'mem_data_5', 'mem_data_6', 'mem_data_7',
                              'mem_data_8', 'mem_data_9' ]
       , 'core.size'      : ( l( 6300), l( 6300) )
       , 'chip.size'      : ( l(10000), l(10000) )
       , 'chip.clockTree' : True
       }
