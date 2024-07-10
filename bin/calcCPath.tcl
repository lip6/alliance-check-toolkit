#!avt_shell

#############################################################
# Timing Database Generation                                #
#############################################################

# target cell name
set target      [lindex $argv 0]  
# model SPI file
set spimodel    [lindex $argv 1]  
# spice type
set spitype     [lindex $argv 2]  
# vdd voltage
set vddvolt     [lindex $argv 3]  
# Clock signal
set clksig      [lindex $argv 4]  

# General config
avt_config avtLibraryDirs .

avt_config tasGenerateConeFile yes
avt_config avtVerboseConeFile yes 
avt_config yagSetResetDetection yes 

avt_config simVthHigh 0.8
avt_config simVthLow 0.2
avt_config simSlope 10e-12 
avt_config simTemperature 25.0

avt_config simToolModel $spitype
avt_config tasGenerateDetailTimingFile yes
avt_config avtVddName vdd
avt_config avtVssName vss
avt_config simPowerSupply $vddvolt

# Files of transistor model of the technology, that may require modifications
#
# nfet_01v8
avt_LoadFile $spimodel spice
avt_LoadFile $target.spi spice

# File decribing the netlist with power supply and temperature

# Database generation
set fig [hitas $target]

set temp   [ttv_GetTimingFigureProperty $fig TEMP]
set supply [ttv_GetTimingFigureProperty $fig DEF_SUPPLY]

set slope  [ttv_GetTimingFigureProperty $fig DEF_SLOPE]
set cload   [ttv_GetTimingFigureProperty $fig DEF_LOAD]
set date   [ttv_GetTimingFigureProperty $fig DATE]

puts ""
puts "Power supply: [ttv_GetTimingFigureProperty $fig DEF_SUPPLY]V"
puts "Temperature: [ttv_GetTimingFigureProperty $fig TEMP] deg C"
#set sig [ttv_GetTimingSignal $fig out]
#set sign2 [ttv_GetTimingSignal $fig n2]
#set sign1 [ttv_GetTimingSignal $fig n1]

puts ""
#puts "out signal capacitance: [ttv_GetTimingSignalProperty $sig CAPA]F"
#puts "n2 signal capacitance: [ttv_GetTimingSignalProperty $sign2 CAPA]F"
#puts "n1 signal capacitance: [ttv_GetTimingSignalProperty $sign1 CAPA]F"


puts "input slope     : $slope s"
puts "generation date : $date"

puts "output load     : $cload"

#############################################################
# Stability Analysis                                        #
#############################################################

inf_SetFigureName $target

create_clock -name ck -period 10000 -waveform {5000 0} $clksig

set_input_delay -min 2000 -clock ck -clock_fall [all_inputs]
set_input_delay -max 3000 -clock ck -clock_fall [all_inputs]

# OCV
#inf_DefinePathDelayMargin any "*" 1 1e-9 datapath

set fig [ttv_LoadSpecifiedTimingFigure $target]
set clist [ttv_GetPaths $fig * * uu 5 critic path max]

ttv_DisplayPathListDetail [fopen $target.cpath.rep w]  $clist

set stbfig [stb $fig]

stb_DisplaySlackReport [fopen $target.slack.rep w] $stbfig * * ?? 10  all 10000
