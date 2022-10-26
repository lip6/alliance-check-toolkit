#!/usr/bin/env avt_shell
 
#############################################################
# Timing Reporting                                          #
#############################################################

set figname SARlogic 
inf_SetFigureName $figname

# Set clocks
create_clock -name clk -period 30000 -waveform {10 10} clk 

# Load Timing Database
set fig [ttv_LoadSpecifiedTimingFigure $figname]

# Setup / Hold paths
set file [fopen $figname.setuphold w]
ttv_DisplayConnectorToLatchMargin $file $fig * "split all"
fclose $file

# Max access paths
set file [fopen $figname.accessmax w]
set pathlist [ttv_GetPaths $fig * res\[*\] ?? 10 critic access max]
ttv_DisplayPathListDetail $file $pathlist
fclose $file

# Min access paths
set file [fopen $figname.accessmin w]
set pathlist [ttv_GetPaths $fig * res\[*\] ?? 10 critic access min]
ttv_DisplayPathListDetail $file $pathlist
fclose $file

# Combinational paths
set file [fopen $figname.comb w]
set pathlist [ttv_GetPaths $fig cmp res\[*\] ?? 10 critic path max]
ttv_DisplayPathListDetail $file $pathlist
set pathlist [ttv_GetPaths $fig soc res\[*\] ?? 10 critic path max]
ttv_DisplayPathListDetail $file $pathlist
set pathlist [ttv_GetPaths $fig rst res\[*\] ?? 10 critic path max]
ttv_DisplayPathListDetail $file $pathlist
set pathlist [ttv_GetPaths $fig clk res\[*\] ?? 10 critic path max]
ttv_DisplayPathListDetail $file $pathlist
fclose $file


#avt_config simToolModel spice

set clist [ttv_GetPaths $fig * * ?? 10 critic path max]

set f [fopen $figname.paths "w+"]
ttv_DisplayPathListDetail $f $clist
puts "Hi my fig name is $fig"
puts "Ho my figname is $figname"
fclose $f
