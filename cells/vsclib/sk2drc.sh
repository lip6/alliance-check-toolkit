#!/bin/sh
klayout -b -r ../../dks/sky130_nsx2/libs.tech/klayout/drc_sky130.lydrc -rd input=$1.gds -rd report=$1.report
if [ "x$2" = "xview" ]; then
	klayout $1.gds -m $1.report
fi
