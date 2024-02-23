#!/usr/bin/env avt_shell
 
#############################################################
# Timing Reporting                                          #
#############################################################
avt_config simToolModel spice

set fig [ttv_LoadSpecifiedTimingFigure sky130_fd_sc_hd__inv_4_chain]
set clist [ttv_GetPaths $fig * * ?? 5 critic path max]

set f [fopen sky130_fd_sc_hd__inv_4_chain.paths "w+"]
ttv_DisplayPathListDetail $f $clist
fclose $f
