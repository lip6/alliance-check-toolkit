#!/usr/bin/env avt_shell
 
#############################################################
# Timing Reporting                                          #
#############################################################
avt_config simToolModel hspice

set fig [ttv_LoadSpecifiedTimingFigure inv_5]
set clist [ttv_GetPaths $fig * * ?? 2 critic path max]

set f [fopen inv_5.paths "w+"]
ttv_DisplayPathListDetail $f $clist
fclose $f
