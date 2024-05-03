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


# Files
# avt_LoadFile  /users/cao/franck/coriolis-2.x/src/alliance-check-toolkit/benchs/inverter/sky130_c4m/techno/C4M_LIP6_Sky130_hitas.spice spice
#avt_LoadFile  /users/cao/mariem/coriolis-2.x/src/alliance-check-toolkit/benchs/inverter/sky130_c4m/techno/C4M_LIP6_Sky130_hitas.spice spice
avt_LoadFile /users/cao/mariem/coriolis-2.x/src/alliance-check-toolkit/pdkmaster/C4M.Sky130/libs.tech/ngspice_hitas/C4M.Sky130_ss_model_hitas.spice spice

#netlist
avt_LoadFile ./inv_x2_hitas.spi spice

# Database generation
set fig [hitas inv_x2]

set temp   [ttv_GetTimingFigureProperty $fig TEMP]
set supply [ttv_GetTimingFigureProperty $fig DEF_SUPPLY]

set slope  [ttv_GetTimingFigureProperty $fig DEF_SLOPE]
set load   [ttv_GetTimingFigureProperty $fig DEF_LOAD]
set date   [ttv_GetTimingFigureProperty $fig DATE]

puts ""
puts "Power supply: [ttv_GetTimingFigureProperty $fig DEF_SUPPLY]V"
puts "Temperature: [ttv_GetTimingFigureProperty $fig TEMP]°C"
set sig [ttv_GetTimingSignal $fig nq]
puts ""
puts "nq signal capacitance: [ttv_GetTimingSignalProperty $sig CAPA]F"

puts "input slope     : $slope s"
puts "generation date : $date"

puts "output load     : $load"
