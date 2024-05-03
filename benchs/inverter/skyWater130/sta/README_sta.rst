README_sta.rst
=================

Marie-Minerve Louerat

Update 23 February, 2024
Update 24 April, 2024 : generation of a timing path (transistor level) for simualtion with ngspice
---------------------------------------------------------------------------------------------------

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
  * level = 14 for analysis BSIM4 model, if the reference simulator (parameters provided by the foundry)
    is ngspice
  * for simulation with ngspice of a generated netlist of a slected timing path by HiTas,
    at transistor level,
    models of transistors have to instantiate the model directly MWWW (not the .SUBCKT wrapper).


Subdirectories
---------------
hitas:  contains the tcl commands to launch HiTas
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

Generating the transistor level netlist of a selected timing path and performing ngspice simulation
---------------------------------------------------------------------------------------------------
When the timing data base is generated (.dtx file), you may run:

    ./hitas/paths_select_simu.tcl

it uses 
    sky130_fd_sc_hd__inv_1_3.dtx

it generates:
    sky130_fd_sc_hd__inv_1_3_ext.spi     : transistor-level netlist of the select timing path
                                           compliant with ngspice
    cmd_sky130_fd_sc_hd__inv_1_3_ext.spi : input file for ngspice, including 
                                           sky130_fd_sc_hd__inv_1_3_ext.spi netlist model 
                                           and commands to compute gate delays
                                           compliant with ngspice

it automatically launches the command:
    ngspice -b cmd_sky130_fd_sc_hd__inv_1_3_ext.spi

which generates:
    cmd_sky130_fd_sc_hd__inv_1_3_ext.out : ngspice simulation result
                                           with delays estimation
    sky130_fd_sc_hd__inv_1_3.selectedPath: HiTas estimation of the same timing path
                                           that can be compared, in the case of the
                                           chain of 3 inverters to:   
                                           sky130_fd_sc_hd__inv_1_3.paths


Runing the graphical interface Xtas
--------------------------------------
run   xtas
In the menu, select:
   file/open sky130_fd_sc_hd__inv_4_chain.dtx

Then: 
   Tools/Get Paths

Then click on a path and choose in the menu:
   path Detail


