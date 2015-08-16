#!/usr/bin/env python


chip = { 'pads.east'      : [ 'p_iot_data8' , 'p_iot_data9' , 'p_iot_data10', 'p_iot_data11', 'p_iot_data12'
                            , 'p_iot_data13', 'p_vddeck0'   , 'p_iot_data14', 'p_iot_data15', 'p_iot_data16'
                            , 'p_iot_data17', 'p_vsseck0'   , 'p_iot_data18', 'p_iot_data19', 'p_iot_data20'
                            , 'p_iot_data21', 'p_iot_data22', 'p_iot_data23'
                            ]
       , 'pads.west'      : [ 'p_i_addr8'   , 'p_i_addr9'   , 'p_i_addr10'  , 'p_i_addr11'  , 'p_i_addr12'
                            , 'p_i_addr13'  , 'p_vsseck1'   , 'p_i_addr14'  , 'p_i_addr15'  , 'p_i_addr16'
                            , 'p_i_addr17'  , 'p_vddeck1'   , 'p_i_addr18'  , 'p_i_addr19'  , 'p_i_addr20'
                            , 'p_i_addr21'  , 'p_i_addr22'  , 'p_i_addr23'                  
                            ]                                                               
       , 'pads.north'     : [ 'p_i_addr24'  , 'p_i_addr25'  , 'p_i_addr26'  , 'p_i_addr27'  , 'p_i_addr28'
                            , 'p_vddick1'   , 'p_i_addr29'  , 'p_i_addr30'  , 'p_i_addr31'  , 'p_reset_n'
                            , 'p_it_n5'     , 'p_it_n4'     , 'p_it_n3'     , 'p_it_n2'     , 'p_it_n1'
                            , 'p_it_n0'     , 'p_i_ack'     , 'p_i_berr_n'
                            , 'p_ck'        , 'p_iot_data31', 'p_iot_data30', 'p_iot_data29', 'p_iot_data28'
                            , 'p_vssick1'   , 'p_iot_data27', 'p_iot_data26', 'p_iot_data25', 'p_iot_data24'
                            ] 
       , 'pads.south'     : [ 'p_i_addr7'   , 'p_i_addr6'   , 'p_i_addr5'   , 'p_i_addr4'   , 'p_i_addr3'
                            , 'p_vddick0'   , 'p_i_addr2'   , 'p_i_addr1'   , 'p_i_addr0'   , 'p_test'
                            , 'p_d_rq'      , 'p_d_lock'    , 'p_d_atype1'  , 'p_d_atype0'  , 'p_i_frz'
                            , 'p_i_ftch'    , 'p_scin'      , 'p_scout'
                            , 'p_d_ack'     , 'p_d_berr_n'  , 'p_d_frz'     , 'p_iot_data0' , 'p_iot_data1'
                            , 'p_vssick0'   , 'p_iot_data2' , 'p_iot_data3' , 'p_iot_data4' , 'p_iot_data5'
                            , 'p_iot_data6' , 'p_iot_data7'
                            ]    
       , 'core.size'      : ( 6905, 2800 )
       , 'chip.size'      : ( 8200, 6000 )
       , 'chip.clockTree' : False
       }
