README_timing.rst
=================

Update October 24, 2022

/users/cao/mariem/coriolis-2.x/src/alliance-check-toolkit/benchs/spram_256x32/sky130_c4m

Goal : 
------
static timing analysis of spram_256x32


Design
------
make vst

provides


-rw-r--r-- 1 mariem utmp     580 24 oct.  16:30 eth_spram_256x32.tcl
-rw-r--r-- 1 mariem utmp 2648699 24 oct.  16:30 eth_spram_256x32.blif
drwxr-xr-x 3 mariem utmp     512 24 oct.  16:30 coriolis2
-rw-r--r-- 1 mariem utmp 7710003 24 oct.  16:30 eth_spram_256x32.vst
-rw-r--r-- 1 mariem utmp 2324861 24 oct.  16:30 eth_spram_256x32.spi

STA
===

./hitas/db.tcl builds the data base

using
top_hitas_ngspice.spi setting TEMP, VDD, VSS and netlist as a SUBCKT
eth_spram_256x32_netlist.spi : hierarchical top level, top is defined as .SUBCKT
eth_spram_256x32.spi : netlist generated with standard cell include. Standard cell paths have to be chnaged.

provides :
-rw-r--r-- 1 mariem utmp      1427 24 oct.  17:34 eth_spram_256x32.stat
-rw-r--r-- 1 mariem utmp   1453025 24 oct.  17:34 eth_spram_256x32.rep
-rw-r--r-- 1 mariem utmp 146451332 24 oct.  17:34 eth_spram_256x32.cnv
-rw-r--r-- 1 mariem utmp 105651204 24 oct.  17:34 eth_spram_256x32.cns
-rw-r--r-- 1 mariem utmp  35428870 24 oct.  17:39 eth_spram_256x32.rcx
-rw-r--r-- 1 mariem utmp 122270970 24 oct.  17:45 eth_spram_256x32.dtx
-rw-r--r-- 1 mariem utmp 329528536 24 oct.  17:45 eth_spram_256x32.stm

./hitas/report.tcl
provides :
setup and hold information for connectro addr[] 
and
5 longest paths
-rw-r--r-- 1 mariem utmp  29627386 25 oct.  10:15 eth_spram_256x32.setuphold
-rw-r--r-- 1 mariem utmp     15649 25 oct.  10:15 eth_spram_256x32.paths


