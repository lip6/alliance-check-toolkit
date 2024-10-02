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

avt_config simToolModel hspice
avt_config tasGenerateDetailTimingFile yes

# Files of transistor model of the technology, that may require modifications
#
# nfet_01v8
avt_LoadFile   ./techno/sky130_fd_pr__nfet_01v8__mismatch.corner.spice spice
avt_LoadFile   ./techno/sky130_fd_pr__nfet_01v8__tt.corner.spice spice
avt_LoadFile   ./techno/sky130_fd_pr__nfet_01v8__tt.pm3.spice spice
# modified to include the model file sky130_fd_pr__nfet_01v8__tt.pm3.spice with full path
# modified sky130_fd_pr__nfet_01v8__tt.pm3.spice to use level = 14
# have to use local files

# pfet_01v8_hvt
avt_LoadFile   ./techno/sky130_fd_pr__pfet_01v8_hvt__mismatch.corner.spice spice
avt_LoadFile   ./techno/sky130_fd_pr__pfet_01v8_hvt__tt.pm3.spice spice
avt_LoadFile   ./techno/sky130_fd_pr__pfet_01v8_hvt__tt.corner.spice spice
# modified to include the model file sky130_fd_pr__pfet_01v8_hvt__tt.pm3.spice with full path 
# modified sky130_fd_pr__pfet_01v8_hvt__tt.pm3.spice to use level = 14
# have to use local files

# File decribing the netlist with power supply and temperature
avt_LoadFile ./inv_4_chain_load_hitas.spi spice

set fig [hitas inv_4_chain_load]

set temp   [ttv_GetTimingFigureProperty $fig TEMP]
set supply [ttv_GetTimingFigureProperty $fig DEF_SUPPLY]

set slope  [ttv_GetTimingFigureProperty $fig DEF_SLOPE]
set cload   [ttv_GetTimingFigureProperty $fig DEF_LOAD]
set date   [ttv_GetTimingFigureProperty $fig DATE]

puts ""
puts "Power supply: [ttv_GetTimingFigureProperty $fig DEF_SUPPLY]V"
puts "Temperature: [ttv_GetTimingFigureProperty $fig TEMP]deg C"
set sig [ttv_GetTimingSignal $fig out]
puts ""
puts "out signal capacitance: [ttv_GetTimingSignalProperty $sig CAPA]F"

puts "input slope     : $slope"
puts "generation date : $date"

puts "output load     : $cload"


