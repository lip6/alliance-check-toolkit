#!/usr/bin/env avt_shell
 
#############################################################
# Timing Reporting                                          #
#############################################################
avt_config simToolModel spice

set fig [ttv_LoadSpecifiedTimingFigure picorv32_cts_r]
set clist [ttv_GetPaths $fig * * ?? 10 critic path max]

set f [fopen picorv32_cts_r.paths "w+"]
ttv_DisplayPathListDetail $f $clist
fclose $f
