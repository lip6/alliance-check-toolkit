#!/usr/bin/env avt_shell
 
#############################################################
# Timing Reporting                                          #
#############################################################
avt_config simToolModel spice

set fig [ttv_LoadSpecifiedTimingFigure sky130_fd_sc_hd__inv_1_3]
set clist [ttv_GetPaths $fig * * ?? 2 critic path max]

set f [fopen sky130_fd_sc_hd__inv_1_3.paths "w+"]
ttv_DisplayPathListDetail $f $clist
fclose $f
