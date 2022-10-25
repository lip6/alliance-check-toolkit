#!/usr/bin/env avt_shell
 
#############################################################
# Timing Reporting                                          #
#############################################################

set figname eth_spram_256x32 

inf_SetFigureName $figname

# Set clocks
#create_clock -period 3000 -waveform {0 1500} ck
#create_clock -name m_clock_from_pad -period 3000 -waveform {10 10} 1
create_clock -name clk -period 50000 -waveform {10 10} 46 

# Load Timing Database
set fig [ttv_LoadSpecifiedTimingFigure $figname]

# Setup / Hold paths addr
set file [fopen $figname.addr.setuphold w]
ttv_DisplayConnectorToLatchMargin $file $fig addr\[\*] "split summary"
fclose $file

# Setup / Hold paths di
set file [fopen $figname.di.setuphold w]
ttv_DisplayConnectorToLatchMargin $file $fig di\[\*] "split summary"
fclose $file

# Max access paths
set file [fopen $figname.accessmax w]
set pathlist [ttv_GetPaths $fig * dato\[*\] ?? 10 critic access max]
ttv_DisplayPathListDetail $file $pathlist
fclose $file

# Min access paths
set file [fopen $figname.accessmin w]
set pathlist [ttv_GetPaths $fig * dato\[*\] ?? 10 critic access min]
ttv_DisplayPathListDetail $file $pathlist
fclose $file


# Combinational paths
set file [fopen $figname.comb w]
set pathlist [ttv_GetPaths $fig clk dato\[*\] ?? 10 critic path max]
ttv_DisplayPathListDetail $file $pathlist
fclose $file


# Critical path
set clist [ttv_GetPaths $fig * * ?? 5 critic path max]

set f [fopen $figname.paths "w+"]
ttv_DisplayPathListDetail $f $clist
fclose $f
