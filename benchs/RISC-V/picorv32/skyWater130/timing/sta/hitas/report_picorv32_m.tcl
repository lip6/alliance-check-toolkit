#!/usr/bin/env avt_shell
 
#############################################################
# Timing Reporting                                          #
#############################################################
avt_config simToolModel spice

set fig [ttv_LoadSpecifiedTimingFigure picorv32_m]
set clist [ttv_GetPaths $fig * * ?? 2 critic path max]

set f [fopen picorv32_m.paths "w+"]
ttv_DisplayPathListDetail $f $clist
fclose $f
