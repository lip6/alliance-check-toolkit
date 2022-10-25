#!/usr/bin/env avt_shell
 
#############################################################
# Timing Reporting                                          #
#############################################################

set figname eth_spram_256x32 

inf_SetFigureName $figname

# Set clocks
#create_clock -period 3000 -waveform {0 1500} ck
#create_clock -name m_clock_from_pad -period 3000 -waveform {10 10} 1
create_clock -name clk -period 30000 -waveform {10 10} 46 

# Load Timing Database
set fig [ttv_LoadSpecifiedTimingFigure $figname]

# Setup / Hold paths
set file [fopen $figname.setuphold w]
ttv_DisplayConnectorToLatchMargin $file $fig addr\[\*] "split summary"
fclose $file

# Max access paths

# Min access paths

# Combinational paths


# Critical path
set clist [ttv_GetPaths $fig * * ?? 5 critic path max]

set f [fopen $figname.paths "w+"]
ttv_DisplayPathListDetail $f $clist
fclose $f
