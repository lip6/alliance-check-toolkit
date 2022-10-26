README_timing.rst
=================

Update October 26, 2022

/users/cao/mariem/coriolis-2.x/src/alliance-check-toolkit/benchs/SRAM/256x32/tsmc_c018

Goal : 
------
static timing analysis of spram_256x32, optimised version P&R by JP Chaput
taking account regularity in the architecture
Process tsmc_c018 (NDA)
Standard Cells : C4M-FlexCell library


Design
------
make cgt
Tools/PythonScripts doDesign

provides

-rw-r--r-- 1 mariem utmp   7854486 26 oct.  17:13 spram_256x32.vst
-rw-r--r-- 1 mariem utmp   3033670 26 oct.  17:13 spram_256x32.spi

STA
===

./hitas/db.tcl builds the timing data base

using
top_hitas_eldo.cir setting TEMP, VDD, VSS and netlist as a SUBCKT, including standard cells

spram_256x32.spi : netlist generated without standard cell include.

provides :
-rw-r--r-- 1 mariem utmp      1378 26 oct.  17:36 spram_256x32.stat
-rw-r--r-- 1 mariem utmp   1497475 26 oct.  17:36 spram_256x32.rep
-rw-r--r-- 1 mariem utmp 130404276 26 oct.  17:36 spram_256x32.cnv
-rw-r--r-- 1 mariem utmp  90306328 26 oct.  17:36 spram_256x32.cns
-rw-r--r-- 1 mariem utmp  32398420 26 oct.  17:36 spram_256x32.rcx
-rw-r--r-- 1 mariem utmp 114772181 26 oct.  17:37 spram_256x32.dtx
-rw-r--r-- 1 mariem utmp 306618972 26 oct.  17:38 spram_256x32.stm

./hitas/report.tcl
provides :
-rw-r--r-- 1 mariem utmp  30090227 26 oct.  17:39 spram_256x32.addr.setuphold
-rw-r--r-- 1 mariem utmp   1862899 26 oct.  17:39 spram_256x32.di.setuphold
-rw-r--r-- 1 mariem utmp     27870 26 oct.  17:39 spram_256x32.accessmax
-rw-r--r-- 1 mariem utmp     24740 26 oct.  17:39 spram_256x32.accessmin
-rw-r--r-- 1 mariem utmp       666 26 oct.  17:39 spram_256x32.comb
-rw-r--r-- 1 mariem utmp     18008 26 oct.  17:39 spram_256x32.paths


where:
.setuphold: setup and hold information for connectors addr[] and di[]
.accessmax and .accessmin: timing access max and min of output
and
.paths: 10 longest paths

./hitas/sta.tcl
provides :
-rw-r--r-- 1 mariem utmp  22782557 26 oct.  17:40 spram_256x32.sto
-rw-r--r-- 1 mariem utmp   8273647 26 oct.  17:40 spram_256x32.str
-rw-r--r-- 1 mariem utmp     49693 26 oct.  17:40 spram_256x32.slack

where:
.sto: switching window for each signal
.str: setup and hold slack report computed for all reference points
.slack: reports slack for a selection of 10 signals
