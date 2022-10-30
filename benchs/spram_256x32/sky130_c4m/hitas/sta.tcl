#!/usr/bin/env avt_shell
 
#############################################################
# Timing Reporting                                          #
#############################################################

set figname eth_spram_256x32 

inf_SetFigureName $figname

# Set clocks
create_clock -name clk -period 50000 -waveform {20 20} clk 

# input timing info for sta
set_input_delay -min 2000 -clock clk -clock_fall [all_inputs]
set_input_delay -max 3000 -clock clk -clock_fall [all_inputs]


# Load Timing Database
set fig [ttv_LoadSpecifiedTimingFigure $figname]

# STA
set stbfig [stb $fig]

stb_DisplaySlackReport [fopen $figname.slack w] $stbfig * * ?? 10  all 10000
