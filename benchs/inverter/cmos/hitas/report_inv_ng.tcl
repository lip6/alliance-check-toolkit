#!/usr/bin/env avt_shell
 
#############################################################
# Timing Reporting                                          #
#############################################################
avt_config simToolModel spice

set fig [ttv_LoadSpecifiedTimingFigure inv]
set clist [ttv_GetPaths $fig * * ?? 2 critic path max]

set f [fopen inv.paths "w+"]
ttv_DisplayPathListDetail $f $clist
fclose $f
