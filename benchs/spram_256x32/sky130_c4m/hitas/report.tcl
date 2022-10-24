#!/usr/bin/env avt_shell
 
#############################################################
# Timing Reporting                                          #
#############################################################

set figname eth_spram_256x32 

inf_SetFigureName $figname

# Load Timing Database
set fig [ttv_LoadSpecifiedTimingFigure $figname]


set clist [ttv_GetPaths $fig * * ?? 5 critic path max]

#Critical path
set f [fopen $figname.paths "w+"]
ttv_DisplayPathListDetail $f $clist
fclose $f
