#!/usr/bin/env avt_shell

#############################################################
# Timing Database Generation                                #
#############################################################

avt_config avtLibraryDirs .

# Database Construction Options
avt_config tasGenerateConeFile yes
avt_config avtVerboseConeFile yes

avt_config tasGenerateDetailTimingFile yes


# Global Configuration
avt_config simVthHigh 0.8
avt_config simVthLow 0.2

avt_config simToolModel spice
avt_config simSlope 20e-12

# Technology Parameters
avt_LoadFile /users/cao/mariem/coriolis-2.x/src/alliance-check-toolkit/pdkmaster/C4M.Sky130/libs.tech/ngspice_hitas/C4M.Sky130_tt_model_hitas.spice spice

# Files
avt_LoadFile top_hitas_ngspice.spi spice

# Generate Database
set fig [hitas spram_256x32]

set temp   [ttv_GetTimingFigureProperty $fig TEMP]
set supply [ttv_GetTimingFigureProperty $fig DEF_SUPPLY]

set slope  [ttv_GetTimingFigureProperty $fig DEF_SLOPE]
set load   [ttv_GetTimingFigureProperty $fig DEF_LOAD]
set date   [ttv_GetTimingFigureProperty $fig DATE]


puts ""
puts "Power supply: [ttv_GetTimingFigureProperty $fig DEF_SUPPLY]V"
puts "Temperature: [ttv_GetTimingFigureProperty $fig TEMP]°C"
puts ""
#puts "DAC_control signal capacitance: [ttv_GetTimingSignalProperty $sig CAPA]F"

puts "input slope     : $slope"
puts "generation date : $date"

puts "output load     : $load"

