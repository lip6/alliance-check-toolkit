#!/usr/bin/env avt_shell
 
#############################################################
# Timing Reporting                                          #
#############################################################
avt_config simToolModel spice

set fig [ttv_LoadSpecifiedTimingFigure inv_4_chain_load]
set clist [ttv_GetPaths $fig * * ?? 5 critic path max]

set f [fopen inv_4_chain_load.paths "w+"]
ttv_DisplayPathListDetail $f $clist
fclose $f
