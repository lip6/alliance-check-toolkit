README_timing.rst
=================

Update October 26, 2022

/users/cao/mariem/coriolis-2.x/src/alliance-check-toolkit/benchs/SRAM/256x32/sky130_c4m

Goal : 
------
static timing analysis of spram_256x32, optmised version by JP Chaput
Process SkyWater130
Standard Cells : C4M-FlexCell library


Design
------
make cgt
Tools/PythonScripts doDesign

provides

-rw-r--r-- 1 mariem utmp   7886106 26 oct.  15:28 spram_256x32.vst
-rw-r--r-- 1 mariem utmp   3065286 26 oct.  15:28 spram_256x32.spi

STA
===

./hitas/db.tcl builds the data base

using
top_hitas_ngspice.spi setting TEMP, VDD, VSS and netlist as a SUBCKT, includind standard cells

spram_256x32.spi : netlist generated without standard cell include.

provides :
rw-r--r-- 1 mariem utmp      1504 26 oct.  15:55 spram_256x32.stat
-rw-r--r-- 1 mariem utmp   1497475 26 oct.  15:55 spram_256x32.rep
-rw-r--r-- 1 mariem utmp 140338101 26 oct.  15:55 spram_256x32.cnv
-rw-r--r-- 1 mariem utmp 100513522 26 oct.  15:55 spram_256x32.cns
-rw-r--r-- 1 mariem utmp  32749066 26 oct.  16:00 spram_256x32.rcx
-rw-r--r-- 1 mariem utmp 114698233 26 oct.  16:06 spram_256x32.dtx
-rw-r--r-- 1 mariem utmp 307777564 26 oct.  16:06 spram_256x32.stm

./hitas/report.tcl
provides :
-rw-r--r-- 1 mariem utmp  30090227 26 oct.  16:08 spram_256x32.addr.setuphold
-rw-r--r-- 1 mariem utmp   1862899 26 oct.  16:08 spram_256x32.di.setuphold
-rw-r--r-- 1 mariem utmp     27870 26 oct.  16:08 spram_256x32.accessmax
-rw-r--r-- 1 mariem utmp     24740 26 oct.  16:08 spram_256x32.accessmin
-rw-r--r-- 1 mariem utmp       666 26 oct.  16:08 spram_256x32.comb
-rw-r--r-- 1 mariem utmp     17878 26 oct.  16:08 spram_256x32.paths

where:
.setuphold: setup and hold information for connectors addr[] and di[]
.accessmax and .accessmin: timing access max and min of output
and
.paths: 10 longest paths

./hitas/sta.tcl
provides :
-rw-r--r-- 1 mariem utmp  22708331 26 oct.  16:11 spram_256x32.sto
-rw-r--r-- 1 mariem utmp   8291087 26 oct.  16:11 spram_256x32.str
-rw-r--r-- 1 mariem utmp     50905 26 oct.  16:11 spram_256x32.slack

where:
.sto: switching window for each signal
.str: setup and hold slack report computed for all reference points
.slack: reports slack for a selection of 10 signals
