#!/usr/bin/env avt_shell

#############################################################
# Timing Database Generation                                #
#############################################################

# General config
avt_config avtLibraryDirs .

avt_config tasGenerateConeFile yes
avt_config avtVerboseConeFile yes 

avt_config simVthHigh 0.8
avt_config simVthLow 0.2
avt_config simSlope 8e-12 

avt_config simToolModel spice
avt_config tasGenerateDetailTimingFile yes

# Files of transistor model of the technology, that may require modifications
#
# nfet_01v8 pfet_01v8
#
#
# beware of local path
# file modified to use level = 14 in transistor model
avt_LoadFile /users/cao/mariem/coriolis-2.x/src/alliance-check-toolkit/pdkmaster/C4M.Sky130/libs.tech/ngspice_hitas/C4M.Sky130_tt_model_hitas.spice spice

# File decribing the netlist with power supply and temperature
# avt_LoadFile /users/cao/mariem/coriolis-2.x/src/alliance-check-toolkit/benchs/picorv32/skyWater130/timing/sta/picorv32_m_hitas.spi spice
avt_LoadFile picorv32_cts_r_hitas.spi spice

# Database generation
set fig [hitas picorv32_cts_r]

set temp   [ttv_GetTimingFigureProperty $fig TEMP]
set supply [ttv_GetTimingFigureProperty $fig DEF_SUPPLY]

set slope  [ttv_GetTimingFigureProperty $fig DEF_SLOPE]
set cload   [ttv_GetTimingFigureProperty $fig DEF_LOAD]
set date   [ttv_GetTimingFigureProperty $fig DATE]

puts ""
puts "Power supply: [ttv_GetTimingFigureProperty $fig DEF_SUPPLY]V"
puts "Temperature: [ttv_GetTimingFigureProperty $fig TEMP] deg C"
set sig [ttv_GetTimingSignal $fig clk]
set sig1 [ttv_GetTimingSignal $fig eoi[0]]
set sig2 [ttv_GetTimingSignal $fig trace_data[0]]

puts ""
puts "clk capacitance: [ttv_GetTimingSignalProperty $sig CAPA]F"
puts "eoi[0] signal capacitance: [ttv_GetTimingSignalProperty $sig1 CAPA]F"
puts "trace_data[0] signal capacitance: [ttv_GetTimingSignalProperty $sig2 CAPA]F"


puts "input slope     : $slope s"
puts "generation date : $date"

puts "output load     : $cload"
