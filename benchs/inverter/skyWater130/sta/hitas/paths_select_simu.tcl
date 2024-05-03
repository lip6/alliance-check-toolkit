#!/usr/bin/env avt_shell
 
#############################################################
# Timing Reporting for ngspice                                         #
#############################################################

set figname sky130_fd_sc_hd__inv_1_3

# Simulation Config
avt_config avtSpiceString     "ngspice -b $"
avt_config SimToolModel spice
avt_config SimTool ngspice
avt_config simTechnologyName /users/cao/mariem/coriolis-2.x/src/alliance-check-toolkit/pdkmaster/C4M.Sky130/libs.tech/ngspice_hitas/C4M.Sky130_tt_model_hitas.spice
avt_config avtSpiceOutFile $.log

ttv_DisplayActivateSimulation y
# Set clocks
inf_SetFigureName $figname
create_clock -period 6000 -waveform {0 3000} clk
#set_load 0.01 s\[0\]

# Load Timing Database
set fig [ttv_LoadSpecifiedTimingFigure $figname]

# Setup / Hold paths
#set file [fopen $figname.setuphold w]
#ttv_DisplayConnectorToLatchMargin $file $fig a\[0\] "split all"
#fclose $file

# Max access paths
#set file [fopen $figname.accessmax w]
#set pathlist [ttv_GetPaths $fig * s\[0\] ?f 1 critic access max]
#ttv_DisplayPathListDetail $file $pathlist
#fclose $file

# Min access paths
#set file [fopen $figname.accessmin w]
#set pathlist [ttv_GetPaths $fig * s\[0\] ?f 1 critic access min]
#ttv_DisplayPathListDetail $file $pathlist
#fclose $file

# Combinational paths
set file [fopen $figname.selectedPath w]
set pathlist [ttv_GetPaths $fig * * ?? 1 critic path max]
ttv_DisplayPathListDetail $file $pathlist
fclose $file
