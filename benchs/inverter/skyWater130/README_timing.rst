README_timing.rst
=================

Marie-Minerve Louerat

Update 22 February, 2024
------------------------

coriolis-2.x/src/alliance-check-toolkit/benchs/inverter/skyWater130/README_timing.rst

Goal
--------
This directory contains the files to analyze the timing response of:
  * a single inverter, (sky_130_fd_sc_hd library) 
    sky130_fd_sc_hd__inv_1.spice updated with sizes provided using u for micro-meters
  * other inverters of the same library, using larger transistors
  * chain of inverters

LIP6 installation of standard cells from SkyWater130 PDK:
-----------------------------------------------------------
/users/soft/freepdks/src/skywater-pdk/libraries/sky130_fd_sc_hd/latest/cells/inv/sky130_fd_sc_hd__inv_1.spice

Standard cell spice model copied in this directory and modified in 

./simu/ngspice/sky130_fd_sc_hd__inv_1.spice

to be used for simulation (u as microns in cell spice description)


LIP6 installation of transistors models used for transistor level simulation with ngspice:
--------------------------------------------------------------------------------------------
* BSIM4 transistor model parameters for ngspice
*
* nfet_01v8
.include /users/soft/freepdks/src/skywater-pdk/libraries/sky130_fd_pr/latest/cells/nfet_01v8/sky130_fd_pr__nfet_01v8__mismatch.corner.spice
.include /users/soft/freepdks/src/skywater-pdk/libraries/sky130_fd_pr/latest/cells/nfet_01v8/sky130_fd_pr__nfet_01v8__tt.corner.spice

* pfet_01v8_hvt
.include /users/soft/freepdks/src/skywater-pdk/libraries/sky130_fd_pr/latest/cells/pfet_01v8_hvt/sky130_fd_pr__pfet_01v8_hvt__mismatch.corner.spice
.include /users/soft/freepdks/src/skywater-pdk/libraries/sky130_fd_pr/latest/cells/pfet_01v8_hvt/sky130_fd_pr__pfet_01v8_hvt__tt.corner.spice

LIP6 installation of transistors models used for static timing analysis with hitas:
--------------------------------------------------------------------------------------------
# nfet_01v8
avt_LoadFile  /users/soft/freepdks/src/skywater-pdk/libraries/sky130_fd_pr/latest/cells/nfet_01v8/sky130_fd_pr__nfet_01v8__mismatch.corner.spice spice

The file:  /users/soft/freepdks/src/skywater-pdk/libraries/sky130_fd_pr/latest/cells/nfet_01v8/sky130_fd_pr__nfet_01v8__tt.corner.spice spice
has to be modified to include the model file sky130_fd_pr__nfet_01v8__tt.pm3.spice with full path
also the file sky130_fd_pr__nfet_01v8__tt.pm3.spice  has to be modified to use level = 14
So today we have to use hierarchical local files:
avt_LoadFile  /users/cao/mariem/coriolis-2.x/src/alliance-check-toolkit/benchs/inverter/skyWater130/sta/techno/sky130_fd_pr__nfet_01v8__tt.corner.spice spice

# pfet_01v8_hvt
avt_LoadFile  /users/soft/freepdks/src/skywater-pdk/libraries/sky130_fd_pr/latest/cells/pfet_01v8_hvt/sky130_fd_pr__pfet_01v8_hvt__mismatch.corner.spice spice
The file   /users/soft/freepdks/src/skywater-pdk/libraries/sky130_fd_pr/latest/cells/pfet_01v8_hvt/sky130_fd_pr__pfet_01v8_hvt__tt.corner.spice spice
has to be modified to include the model file sky130_fd_pr__pfet_01v8_hvt__tt.pm3.spice with full path 
also the file sky130_fd_pr__pfet_01v8_hvt__tt.pm3.spice modified to use level = 14
So today we have to use hierachical local files:
avt_LoadFile  /users/cao/mariem/coriolis-2.x/src/alliance-check-toolkit/benchs/inverter/skyWater130/sta/techno/sky130_fd_pr__pfet_01v8_hvt__tt.corner.spice spice


A. Timing Analysis of Invertors with ngspice
-----------------------------------------------

XXX/coriolis-2.x/src/alliance-check-toolkit/benchs/inverter/skyWater130/simu/ngspice

1. inv_1 with load
++++++++++++++++++++++++++++++++++++++++++

ngpsice top_sky130_fd_sc_hd__inv_1.spi
displays timing plots with information of input slope and propagation delay :

+-------+--------+--------------+-----------------------+
| input | output | input slope  |  propagation delay
+=======+========+==============+=======================+
| F     | R      | 10           |  24.2
+-------+--------+--------------+-----------------------+
| R     | F      | 10           |  12.3
+-------+--------+--------------+-----------------------+

where F: falling, R: rising, timing results in ps.
there is a load Cload = 0.002 pF

2. 3 inv_1 with load
++++++++++++++++++++++++++++++++++++++++++

ngpsice top_sky130_fd_sc_hd__inv_1_3.spi
displays timing plots with information of input slope and propagation delay :

+-------+--------+--------------+----------------------------------------+
| input | output | input slope  |  propagation delay of middle inverter
+=======+========+==============+========================================+
| F     | R      | 10           |  28.0
+-------+--------+--------------+----------------------------------------+
| R     | F      | 10           |  20.0
+-------+--------+--------------+-----------------------------------------+

where F: falling, R: rising, timing results in ps.
there is a load Cload = 0.002 pF


3. a Chain consisting of 10 invertors inv_1
---------------------------------------------------------------

ngspice top_sky130_fd_sc_hd__inv_1_chain_slope.spi
displays timing plots with information of input slope and propagation delay :

+-------+--------+--------------+-----------------------+
| input | output | input slope  |  propagation delay (10)
+=======+========+==============+=======================+
| R     | R      | 10           |  237
+-------+--------+--------------+-----------------------+
| F     | F      | 10           |  243
+-------+--------+--------------+-----------------------+

where F: falling, R: rising, timing results in ps.
there is a load Cload = 0.002 pF

4. 3 inv_4 with load
++++++++++++++++++++++++++++++++++++++++++

ngspice top_sky130_fd_sc_hd__inv_4_3.spi
displays timing plots with information of input slope and propagation delay :

+-------+--------+--------------+---------------------------------------+
| input | output | input slope  |  propagation delay of middle inverter
+=======+========+==============+=======================================+
| F     | R      | 10           |  27.5
+-------+--------+--------------+---------------------------------------+
| R     | F      | 10           |  19.9
+-------+--------+--------------+---------------------------------------+

where F: falling, R: rising, timing results in ps.
there is a load Cload = 0.0022 pF

5. Chain consisting of 10 invertors inv_4
---------------------------------------------------------------

ngpsice top_sky130_fd_sc_hd__inv_4_chain_slope.spi
displays timing plots with information of input slope and propagation delay :

+-------+--------+--------------+-----------------------+
| input | output | input slope  |  propagation delay (10)
+=======+========+==============+=======================+
| R     | R      | 10           |  226
+-------+--------+--------------+-----------------------+
| F     | F      | 10           |  236
+-------+--------+--------------+-----------------------+

where F: falling, R: rising, timing results in ps.
there is a load Cload = 0.002 pF

ngpsice top_sky130_fd_sc_hd__inv_4_chain_slope.spi
displays timing plots with information of input slope and propagation delay :

+-------+--------+--------------+-----------------------+
| input | output | input slope  |  propagation delay (10)
+=======+========+==============+=======================+
| R     | R      | 10           |  237
+-------+--------+--------------+-----------------------+
| F     | F      | 10           |  243
+-------+--------+--------------+-----------------------+

where F: falling, R: rising, timing results in ps.
there is a load Cload = 0.008 pF

ngpsice top_sky130_fd_sc_hd__inv_4_chain_slope_nolaod.spi
displays timing plots with information of input slope and propagation delay :

+-------+--------+--------------+-----------------------+
| input | output | input slope  |  propagation delay (10)
+=======+========+==============+=======================+
| R     | R      | 10           |  222
+-------+--------+--------------+-----------------------+
| F     | F      | 10           |  232
+-------+--------+--------------+-----------------------+

where F: falling, R: rising, timing results in ps.
there is a load Cload = 0.008 pF

B. timing analysis of invertors with static timing analyzerHiTas
------------------------------------------------------------------------


Environment configuration for hitas
--------------------------------------
Launch:
  bash
  source ./hitas/avt_env.sh

Invertor inv_1 timing analysis, using the 3 inverter chain
-----------------------------------------------------------------

Running:

1. Building the timing database
   ./hitas/db_ng.tcl

creates sky130_fd_sc_hd__inv_1_3.dtx and other files

NB. here, Hitas uses inv_1_3_hitas.spi description of the netlist 
to detect VDD and VSS
(see sky130_fd_sc_hd__inv_1_3.rep)

2. Report critical paths
   ./hitas/report_inv_ng.tcl

provides the sky130_fd_sc_hd__inv_1_3.paths file that shows the 2 paths of the invertor.

+-------+--------+--------------+------------------------------------------------------------+
| input | output | input slope  |  prop delay middle inv | propagation delay total (no load)
+=======+========+==============+============================================================+
| F     | R      | 10           |  27.9                  |          61.4
+-------+--------+--------------+------------------------------------------------------------+
| R     | F      | 10           |  19.2                  |          49.8
+-------+--------+--------------+------------------------------------------------------------+

where F: falling, R: rising, timing results in ps, same as provided by ngspice.


Invertor (10 inv_4) chain timing analysis
---------------------------------------------

Running:

1. Building the timing database
   ./hitas/db_chain_ng.tcl

creates sky130_fd_sc_hd__inv_4_chain.dtx and other files

NB. Here, Hitas uses sky130_fd_sc_hd__inv_4_chain_hitas.spi description of the netlist 
to detect VDD and VSS
(see sky130_fd_sc_hd__inv_4_chain.rep)

2. Report critical paths
   ./hitas/report_chain_ng.tcl

provides the sky130_fd_sc_hd__inv_4_chain.paths file that shows the 2 paths of the invertor chain.

+-------+--------+--------------+---------------------------+
| input | output | input slope  |  propagation delay total
+=======+========+==============+===========================+
| F     | F      | 10           |  233.8
+-------+--------+--------------+---------------------------+
| R     | R      | 10           |  223.1
+-------+--------+--------------+---------------------------+

Details of paths (units: ns):
Path (1) : 

        Delay                                                                                       
      Acc    Delta    R/F     Cap[pf]   Type   Node_Name              Net_Name               Line   
   _________________________________________________________________________________________________
     0.000   0.000 0.010 F      0.008          in                     in                            
     0.028   0.028 0.026 R      0.009          n1                     n1                      inv   
     0.048   0.019 0.012 F      0.009          n2                     n2                      inv   
     0.077   0.030 0.027 R      0.009          n3                     n3                      inv   
     0.097   0.019 0.012 F      0.009          n4                     n4                      inv   
     0.127   0.030 0.027 R      0.009          n5                     n5                      inv   
     0.146   0.019 0.012 F      0.009          n6                     n6                      inv   
     0.176   0.030 0.027 R      0.009          n7                     n7                      inv   
     0.196   0.019 0.012 F      0.009          n8                     n8                      inv   
     0.226   0.030 0.027 R      0.009          n9                     n9                      inv   
     0.234   0.008 0.004 F      0.002    (S)   out                    out                     inv   
   _________________________________________________________________________________________________
     0.234   0.234            (total)                                                               

Path (2) : 

        Delay                                                                                       
      Acc    Delta    R/F     Cap[pf]   Type   Node_Name              Net_Name               Line   
   _________________________________________________________________________________________________
     0.000   0.000 0.010 R      0.008          in                     in                            
     0.014   0.014 0.009 F      0.009          n1                     n1                      inv   
     0.042   0.028 0.027 R      0.009          n2                     n2                      inv   
     0.061   0.019 0.012 F      0.009          n3                     n3                      inv   
     0.091   0.030 0.027 R      0.009          n4                     n4                      inv   
     0.110   0.019 0.012 F      0.009          n5                     n5                      inv   
     0.141   0.030 0.027 R      0.009          n6                     n6                      inv   
     0.160   0.019 0.012 F      0.009          n7                     n7                      inv   
     0.190   0.030 0.027 R      0.009          n8                     n8                      inv   
     0.209   0.019 0.012 F      0.009          n9                     n9                      inv   
     0.223   0.014 0.007 R      0.002    (S)   out                    out                     inv   
   _________________________________________________________________________________________________
     0.223   0.223            (total)                                                               


where F: falling, R: rising, timing results in ps, same as ngspice result without output load.

3. Other analysis with the Hitas GUI: Xtas
   xtas
   file/open sky130_fd_sc_hd__inv_4_chain.dtx
   Tools/Get Paths
   Select path/path Detail


Clean
-----

./hitas/clean removes the timing files, except .paths files
./ngspice/clean_ngspice removes the files generated by the simulation
