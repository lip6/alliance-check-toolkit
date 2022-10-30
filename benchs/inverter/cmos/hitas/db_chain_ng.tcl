#!/usr/bin/env avt_shell

#############################################################
# Timing Database Generation                                #
#############################################################

# General config
avt_config tasGenerateConeFile yes
avt_config avtVerboseConeFile yes

avt_config simVthHigh 0.8
avt_config simVthLow 0.2

avt_config simSlope 20e-12

avt_config simToolModel spice


# Files
avt_LoadFile /users/cao/mariem/coriolis-2.x/src/alliance-check-toolkit/benchs/inverter/cmos/techno/bsim4_dummy.ng spice

avt_LoadFile ./inv_chain.spi spice

set fig [hitas inv_chain]

set temp   [ttv_GetTimingFigureProperty $fig TEMP]
set supply [ttv_GetTimingFigureProperty $fig DEF_SUPPLY]
set slope  [ttv_GetTimingFigureProperty $fig DEF_SLOPE]
set load   [ttv_GetTimingFigureProperty $fig DEF_LOAD]
set date   [ttv_GetTimingFigureProperty $fig DATE]

puts "temperature     : $temp"
puts "power supply    : $supply"
puts "input slope     : $slope"
puts "output load     : $load"
puts "generation date : $date"
