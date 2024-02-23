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
avt_config simSlope 10e-12 

avt_config simToolModel spice
avt_config tasGenerateDetailTimingFile yes


# Files of transistor model of the technology, that may require modifications
#
# nfet_01v8
avt_LoadFile  /users/soft/freepdks/src/skywater-pdk/libraries/sky130_fd_pr/latest/cells/nfet_01v8/sky130_fd_pr__nfet_01v8__mismatch.corner.spice spice
#avt_LoadFile  /users/soft/freepdks/src/skywater-pdk/libraries/sky130_fd_pr/latest/cells/nfet_01v8/sky130_fd_pr__nfet_01v8__tt.corner.spice spice
# modified to include the model file sky130_fd_pr__nfet_01v8__tt.pm3.spice with full path
# modified sky130_fd_pr__nfet_01v8__tt.pm3.spice to use level = 14
# have to use local files (hiererchical)
avt_LoadFile  /users/cao/mariem/coriolis-2.x/src/alliance-check-toolkit/benchs/inverter/skyWater130/sta/techno/sky130_fd_pr__nfet_01v8__tt.corner.spice spice

# pfet_01v8_hvt
avt_LoadFile  /users/soft/freepdks/src/skywater-pdk/libraries/sky130_fd_pr/latest/cells/pfet_01v8_hvt/sky130_fd_pr__pfet_01v8_hvt__mismatch.corner.spice spice
#avt_LoadFile  /users/soft/freepdks/src/skywater-pdk/libraries/sky130_fd_pr/latest/cells/pfet_01v8_hvt/sky130_fd_pr__pfet_01v8_hvt__tt.corner.spice spice
# modified to include the model file sky130_fd_pr__pfet_01v8_hvt__tt.pm3.spice with full path 
#  modified sky130_fd_pr__pfet_01v8_hvt__tt.pm3.spice to use level = 14
# have to use local files (hiererchical)
avt_LoadFile  /users/cao/mariem/coriolis-2.x/src/alliance-check-toolkit/benchs/inverter/skyWater130/sta/techno/sky130_fd_pr__pfet_01v8_hvt__tt.corner.spice spice

# File decribing the netlist with power supply and temperature
avt_LoadFile /users/cao/mariem/coriolis-2.x/src/alliance-check-toolkit/benchs/inverter/skyWater130/sta/inv_1_3_hitas.spi spice

# Database generation
set fig [hitas sky130_fd_sc_hd__inv_1_3]

set temp   [ttv_GetTimingFigureProperty $fig TEMP]
set supply [ttv_GetTimingFigureProperty $fig DEF_SUPPLY]

set slope  [ttv_GetTimingFigureProperty $fig DEF_SLOPE]
set cload   [ttv_GetTimingFigureProperty $fig DEF_LOAD]
set date   [ttv_GetTimingFigureProperty $fig DATE]

puts ""
puts "Power supply: [ttv_GetTimingFigureProperty $fig DEF_SUPPLY]V"
puts "Temperature: [ttv_GetTimingFigureProperty $fig TEMP] deg C"
set sig [ttv_GetTimingSignal $fig out]
set sign2 [ttv_GetTimingSignal $fig n2]
set sign1 [ttv_GetTimingSignal $fig n1]

puts ""
puts "out signal capacitance: [ttv_GetTimingSignalProperty $sig CAPA]F"
puts "n2 signal capacitance: [ttv_GetTimingSignalProperty $sign2 CAPA]F"
puts "n1 signal capacitance: [ttv_GetTimingSignalProperty $sign1 CAPA]F"


puts "input slope     : $slope s"
puts "generation date : $date"

puts "output load     : $cload"
