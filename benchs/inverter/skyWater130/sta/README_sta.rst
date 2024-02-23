README_sta.rst
=================

Marie-Minerve Louerat

Update 23 February, 2024
------------------------

coriolis-2.x/src/alliance-check-toolkit/benchs/inverter/skyWater130/sta/README_sta.rst

Goal
--------
This directory contains the files to analyze the timing response of:
  * a single inverter, (sky_130_fd_sc_hd library) 
    sky130_fd_sc_hd__inv_1.spice updated with sizes provided using u for micro-meters
  * other inverters of the same library, using larger transistors
  * chain of inverters inv_4

by static timing analysis with Hitas
to be compared with ngspice simulation

Note
----
Transistor model files have to be tuned, compared to those used by ngspice, as they require :
  * full path of the file in a hirerachical description
  * level = 14 for analysis BSIM4 model, if the reference simulator (parameters provided by the foundry) is ngspice

Subdirectories
---------------
hitas:  contains the tcl command to launch HiTas
techno: contains the required updated files of the PDK transistor models 
        to be compliant with HiTas in SkyWater130

Environment
-----------
Launch:
  bash
  source ./hitas/avt_env.sh

Runing HiTas
----------------
example:
1. Building the timing database
   ./hitas/db_ng.tcl

creates sky130_fd_sc_hd__inv_1_3.dtx and other files

(see sky130_fd_sc_hd__inv_1_3.rep)

2. Report critical paths
   ./hitas/report_inv_ng.tcl

provides the sky130_fd_sc_hd__inv_1_3.paths file that shows the 2 paths of the invertor.


Runing the graphical interface Xtas
--------------------------------------
run   xtas
In the memnèu, select:
   file/open sky130_fd_sc_hd__inv_4_chain.dtx

Then: 
   Tools/Get Paths

Then click on a path and shoose in the menu:
   path Detail


