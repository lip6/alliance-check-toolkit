#!/usr/bin/env avt_shell
 
#############################################################
# Timing Reporting                                          #
#############################################################

set figname SARlogic 

# Set clocks
inf_SetFigureName $figname
#create_clock -period 3000 -waveform {0 1500} ck
#create_clock -name m_clock_from_pad -period 3000 -waveform {10 10} 1
create_clock -name clk -period 3000 -waveform {10 10} 46 

# Load Timing Database
set fig [ttv_LoadSpecifiedTimingFigure $figname]

# Setup / Hold paths
set file [fopen $figname.setuphold w]
ttv_DisplayConnectorToLatchMargin $file $fig * "split all"
fclose $file

# Max access paths
set file [fopen $figname.accessmax w]
set pathlist [ttv_GetPaths $fig * res\[*\] ?? 0 critic access max]
ttv_DisplayPathListDetail $file $pathlist
fclose $file

# Min access paths
set file [fopen $figname.accessmin w]
set pathlist [ttv_GetPaths $fig * res\[*\] ?? 0 critic access min]
ttv_DisplayPathListDetail $file $pathlist
fclose $file

# Combinational paths
set file [fopen $figname.comb w]
set pathlist [ttv_GetPaths $fig cmp res\[*\] ?? 0 critic path max]
ttv_DisplayPathListDetail $file $pathlist
set pathlist [ttv_GetPaths $fig soc res\[*\] ?? 0 critic path max]
ttv_DisplayPathListDetail $file $pathlist
set pathlist [ttv_GetPaths $fig rst res\[*\] ?? 0 critic path max]
ttv_DisplayPathListDetail $file $pathlist
set pathlist [ttv_GetPaths $fig clk res\[*\] ?? 0 critic path max]
ttv_DisplayPathListDetail $file $pathlist
fclose $file


#avt_config simToolModel spice

set clist [ttv_GetPaths $fig * * ?? 5 critic path max]

set f [fopen $figname.paths "w+"]
ttv_DisplayPathListDetail $f $clist
fclose $f
