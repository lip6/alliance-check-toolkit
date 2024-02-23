READMEsimu.rst
=================

5 February 2024, MMLouerat

/coriolis-2.x/src/alliance-check-toolkit/benchs/inverter/skyWater130/simu/ngspice

Goal: characterization of cells with transistor level simulator ngspice
machine : folk (AlmaLinux 9)

A. Inverters
============

Different trials are perpfrmed and compared

1. small inverter inv_x1 from SkyWater
------------------------------------------
From
/src/skywater-pdk/libraries/sky130_fd_sc_hd/latest/cells/inv/sky130_fd_sc_hd__inv_1.spice

1.1 inverter with load:
-----------------------
ngspice top_sky130_fd_sc_hd__inv_1_load.spi
using
sky130_fd_sc_hd__inv_1.spice (the original has to be modified, see sizes)

Simualtion result:
circuit: sky130_fd_sc_hd__inv_1_load

Doing analysis at TEMP = 25.000000 and TNOM = 27.000000


Initial Transient Solution
--------------------------

Node                                   Voltage
----                                   -------
evss                                         0
evdd                                       1.8
in                                           0
out                                        1.8
vin#branch                                   0
vsupply#branch                    -1.91182e-12
vground#branch                     1.91002e-12

 Reference value :  0.00000e+00
No. of Data Rows : 1038
inputrslope--       =  9.800000e-12 targ=  5.990000e-11 trig=  5.010000e-11
inputfslope--       =  9.800000e-12 targ=  2.599000e-10 trig=  2.501000e-10
outputrslope--      =  6.301073e-11 targ=  7.274023e-10 trig=  6.643916e-10
outputfslope--      =  2.045778e-11 targ=  8.132044e-11 trig=  6.086266e-11
proptimerf          =  1.232118e-11 targ=  6.732118e-11 trig=  5.500000e-11
proptimefr          =  2.426015e-11 targ=  2.792602e-10 trig=  2.550000e-10


1.2 a chain of 3 inverters with load:
--------------------------------------
ngspice top_sky130_fd_sc_hd__inv_1_3.spi
using :
sky130_fd_sc_hd__inv_1_3.spi a chain of 3 inverters with load

Cload out evss 0.0022pF

Simulation result:
Circuit: sky130_fd_sc_hd__inv_1_3 with slope

Doing analysis at TEMP = 25.000000 and TNOM = 27.000000


Initial Transient Solution
--------------------------

Node                                   Voltage
----                                   -------
evss                                         0
evdd                                       1.8
in                                           0
xinv_1_3.n1                                1.8
xinv_1_3.n2                        2.67658e-09
out                                        1.8
vin#branch                                   0
vsupply#branch                    -6.45706e-12
vground#branch                               0

 Reference value :  0.00000e+00
No. of Data Rows : 1038
inputrslope--       =  9.800000e-12 targ=  5.990000e-11 trig=  5.010000e-11
inputfslope--       =  9.800000e-12 targ=  2.599000e-10 trig=  2.501000e-10
outputrslope--      =  7.438659e-11 targ=  3.869617e-10 trig=  3.125751e-10
outputfslope--      =  3.267155e-11 targ=  1.366752e-10 trig=  1.040036e-10
proptimerf_inv2     =  2.002929e-11 targ=  2.999547e-10 trig=  2.799254e-10
proptimefr_inv2     =  2.798116e-11 targ=  9.502511e-11 trig=  6.704395e-11
proptimerr_in_inv2  =  4.002511e-11 targ=  9.502511e-11 trig=  5.500000e-11
proptimeff_in_inv2  =  4.495467e-11 targ=  2.999547e-10 trig=  2.550000e-10
proptimerf_inv2_out =  2.187264e-11 targ=  1.168977e-10 trig=  9.502511e-11
proptimefr_inv2_out =  3.119761e-11 targ=  3.311523e-10 trig=  2.999547e-10


1.3 a chain of 10 inverters with load:
--------------------------------------
ngspice top_sky130_fd_sc_hd__inv_1_chain_slope.spi
using
sky130_fd_sc_hd__inv_1_chain.spi, a chain of 10 inverters with load


Simulation result with Cload out evss 0.0020pF

Circuit: sky130_fd_sc_hd__inv_1_chain with slope and load

Doing analysis at TEMP = 25.000000 and TNOM = 27.000000


Initial Transient Solution
--------------------------

Node                                   Voltage
----                                   -------
evss                                         0
evdd                                       1.8
in                                           0
xinv_1_chain.n1                            1.8
xinv_1_chain.n2                    2.67658e-09
xinv_1_chain.n3                            1.8
xinv_1_chain.n4                    2.67658e-09
xinv_1_chain.n5                            1.8
xinv_1_chain.n6                    2.67658e-09
xinv_1_chain.n7                            1.8
xinv_1_chain.n8                    2.67658e-09
xinv_1_chain.n9                            1.8
out                                2.67658e-09
vin#branch                                   0
vsupply#branch                    -2.27278e-11
vground#branch                               0

 Reference value :  7.65500e-10
No. of Data Rows : 1232
inputrslope--       =  9.800000e-12 targ=  1.099000e-10 trig=  1.001000e-10
inputfslope--       =  9.800000e-12 targ=  3.999000e-10 trig=  3.901000e-10
outputrslope--      =  6.986383e-11 targ=  3.947943e-10 trig=  3.249305e-10
outputfslope--      =  6.913545e-11 targ=  6.565039e-10 trig=  5.873685e-10
proptimerr_in_out   =  2.372603e-10 targ=  3.422603e-10 trig=  1.050000e-10
proptimeff_in_out   =  2.426808e-10 targ=  6.376808e-10 trig=  3.950000e-10
proptimerr_in_inv8  =  1.874016e-10 targ=  2.924016e-10 trig=  1.050000e-10
proptimeff_in_inv8  =  1.924067e-10 targ=  5.874067e-10 trig=  3.950000e-10
proptimerr_inv6_inv8=  4.916126e-11 targ=  2.924016e-10 trig=  2.432403e-10
proptimeff_inv6_inv8=  4.916366e-11 targ=  5.874067e-10 trig=  5.382430e-10
proptimerf_inv7     =  2.005728e-11 targ=  2.632976e-10 trig=  2.432403e-10
proptimefr_inv7     =  2.910510e-11 targ=  5.673481e-10 trig=  5.382430e-1




2. inverter inv_x2 from SkyWater
------------------------------------------


2.1 a chain of 3 inverters with load:
--------------------------------------
ngspice top_sky130_fd_sc_hd__inv_2_3.spi
using :
sky130_fd_sc_hd__inv_2_3.spi a chain of 3 inverters inv_2 with load

Simulation result:
Circuit: sky130_fd_sc_hd__inv_2_3 3 inverters inv_2 with slope and load

Doing analysis at TEMP = 25.000000 and TNOM = 27.000000


Initial Transient Solution
--------------------------

Node                                   Voltage
----                                   -------
evss                                         0
evdd                                       1.8
xinv_2_3.n1                                1.8
in                                           0
xinv_2_3.n2                        2.67658e-09
out                                        1.8
vin#branch                                   0
vsupply#branch                    -1.29121e-11
vground#branch                               0

 Reference value :  0.00000e+00
No. of Data Rows : 1038
inputrslope--       =  9.800000e-12 targ=  5.990000e-11 trig=  5.010000e-11
inputfslope--       =  9.800000e-12 targ=  2.599000e-10 trig=  2.501000e-10
outputrslope--      =  4.955940e-11 targ=  3.609960e-10 trig=  3.114365e-10
outputfslope--      =  2.413005e-11 targ=  1.268391e-10 trig=  1.027091e-10
proptimerf_inv2     =  1.997770e-11 targ=  2.999045e-10 trig=  2.799268e-10
proptimefr_inv2     =  2.767203e-11 targ=  9.471506e-11 trig=  6.704303e-11
proptimerr_in_inv2  =  3.971506e-11 targ=  9.471506e-11 trig=  5.500000e-11
proptimeff_in_inv2  =  4.490453e-11 targ=  2.999045e-10 trig=  2.550000e-10
proptimerf_inv2_out =  1.738152e-11 targ=  1.120966e-10 trig=  9.471506e-11
proptimefr_inv2_out =  2.319289e-11 targ=  3.230974e-10 trig=  2.999045e-10


3.inverter inv_x4 from SkyWater
------------------------------------------

3.1 a chain of 3 inverters inv_4 with load:
------------------------------------------------
ngspice top_sky130_fd_sc_hd__inv_4_3.spi
using :
sky130_fd_sc_hd__inv_4_3.spi a chain of 3 inverters inv_4 with load

Simulation result:
Circuit: sky130_fd_sc_hd__inv_4_3 with slope and load

Doing analysis at TEMP = 25.000000 and TNOM = 27.000000


Initial Transient Solution
--------------------------

Node                                   Voltage
----                                   -------
evss                                         0
evdd                                       1.8
xinv_4_3.n1                                1.8
in                                           0
xinv_4_3.n2                        2.67658e-09
out                                        1.8
vin#branch                                   0
vsupply#branch                    -2.58225e-11
vground#branch                               0

 Reference value :  6.94500e-10
No. of Data Rows : 1038
inputrslope--       =  9.800000e-12 targ=  5.990000e-11 trig=  5.010000e-11
inputfslope--       =  9.800000e-12 targ=  2.599000e-10 trig=  2.501000e-10
outputrslope--      =  3.747254e-11 targ=  3.480417e-10 trig=  3.105691e-10
outputfslope--      =  2.012064e-11 targ=  1.218059e-10 trig=  1.016852e-10
proptimerf_inv2     =  1.993849e-11 targ=  2.998663e-10 trig=  2.799278e-10
proptimefr_inv2     =  2.750897e-11 targ=  9.455180e-11 trig=  6.704284e-11
proptimerr_in_inv2  =  3.955180e-11 targ=  9.455180e-11 trig=  5.500000e-11
proptimeff_in_inv2  =  4.486630e-11 targ=  2.998663e-10 trig=  2.550000e-10
proptimerf_inv2_out =  1.464070e-11 targ=  1.091925e-10 trig=  9.455180e-11
proptimefr_inv2_out =  1.894791e-11 targ=  3.188142e-10 trig=  2.998663e-10


3.2 a chain of 10 inverters with load:
--------------------------------------

ngspice top_sky130_fd_sc_hd__inv_4_chain_slope.spi
using
sky130_fd_sc_hd__inv_4_chain.spi, a chain of 10 inverters inv_4 with load


Simulation result with Cload out evss 0.0020pF

Circuit: sky130_fd_sc_hd__inv_4_chain 10 inv_4 with slope and load

Doing analysis at TEMP = 25.000000 and TNOM = 27.000000


Initial Transient Solution
--------------------------

Node                                   Voltage
----                                   -------
evss                                         0
evdd                                       1.8
xinv_4_chain.n1                            1.8
in                                           0
xinv_4_chain.n2                    2.67658e-09
xinv_4_chain.n3                            1.8
xinv_4_chain.n4                    2.67658e-09
xinv_4_chain.n5                            1.8
xinv_4_chain.n6                    2.67658e-09
xinv_4_chain.n7                            1.8
xinv_4_chain.n8                    2.67658e-09
xinv_4_chain.n9                            1.8
out                                2.67658e-09
vin#branch                                   0
vsupply#branch                    -9.09108e-11
vground#branch                               0

 Reference value :  1.01750e-09
No. of Data Rows : 1232
inputrslope--       =  9.800000e-12 targ=  1.099000e-10 trig=  1.001000e-10
inputfslope--       =  9.800000e-12 targ=  3.999000e-10 trig=  3.901000e-10
outputrslope--      =  3.641897e-11 targ=  3.594166e-10 trig=  3.229976e-10
outputfslope--      =  5.814987e-11 targ=  6.430090e-10 trig=  5.848591e-10
proptimerr_in_out   =  2.259547e-10 targ=  3.309547e-10 trig=  1.050000e-10
proptimeff_in_out   =  2.355250e-10 targ=  6.305250e-10 trig=  3.950000e-10
proptimerr_in_inv8  =  1.874041e-10 targ=  2.924041e-10 trig=  1.050000e-10
proptimeff_in_inv8  =  1.924049e-10 targ=  5.874049e-10 trig=  3.950000e-10
proptimerr_inv6_inv8=  4.916379e-11 targ=  2.924041e-10 trig=  2.432403e-10
proptimeff_inv6_inv8=  4.916187e-11 targ=  5.874049e-10 trig=  5.382430e-10
proptimerf_inv7     =  2.005728e-11 targ=  2.632976e-10 trig=  2.432403e-10
proptimefr_inv7     =  2.910519e-11 targ=  5.673482e-10 trig=  5.382430e-10

**Cload out evss 0.0080pF**
Circuit: sky130_fd_sc_hd__inv_4_chain 10 inv_4 with slope and load

Doing analysis at TEMP = 25.000000 and TNOM = 27.000000


Initial Transient Solution
--------------------------

Node                                   Voltage
----                                   -------
evss                                         0
evdd                                       1.8
xinv_4_chain.n1                            1.8
in                                           0
xinv_4_chain.n2                    2.67658e-09
xinv_4_chain.n3                            1.8
xinv_4_chain.n4                    2.67658e-09
xinv_4_chain.n5                            1.8
xinv_4_chain.n6                    2.67658e-09
xinv_4_chain.n7                            1.8
xinv_4_chain.n8                    2.67658e-09
xinv_4_chain.n9                            1.8
out                                2.67658e-09
vin#branch                                   0
vsupply#branch                    -9.09108e-11
vground#branch                               0

 Reference value :  1.19250e-09
No. of Data Rows : 1232
inputrslope--       =  9.800000e-12 targ=  1.099000e-10 trig=  1.001000e-10
inputfslope--       =  9.800000e-12 targ=  3.999000e-10 trig=  3.901000e-10
outputrslope--      =  6.986383e-11 targ=  3.947943e-10 trig=  3.249305e-10
outputfslope--      =  6.913545e-11 targ=  6.565039e-10 trig=  5.873685e-10
proptimerr_in_out   =  2.372603e-10 targ=  3.422603e-10 trig=  1.050000e-10
proptimeff_in_out   =  2.426808e-10 targ=  6.376808e-10 trig=  3.950000e-10
proptimerr_in_inv8  =  1.874016e-10 targ=  2.924016e-10 trig=  1.050000e-10
proptimeff_in_inv8  =  1.924067e-10 targ=  5.874067e-10 trig=  3.950000e-10
proptimerr_inv6_inv8=  4.916126e-11 targ=  2.924016e-10 trig=  2.432403e-10
proptimeff_inv6_inv8=  4.916366e-11 targ=  5.874067e-10 trig=  5.382430e-10
proptimerf_inv7     =  2.005728e-11 targ=  2.632976e-10 trig=  2.432403e-10
proptimefr_inv7     =  2.910510e-11 targ=  5.673481e-10 trig=  5.382430e-10

3.3 a chain of 10 inverters without load:
----------------------------------------------

Circuit: sky130_fd_sc_hd__inv_4_chain 10 inv_4 with slope and no load

Doing analysis at TEMP = 25.000000 and TNOM = 27.000000


Initial Transient Solution
--------------------------

Node                                   Voltage
----                                   -------
evss                                         0
evdd                                       1.8
xinv_4_chain.n1                            1.8
in                                           0
xinv_4_chain.n2                    2.67658e-09
xinv_4_chain.n3                            1.8
xinv_4_chain.n4                    2.67658e-09
xinv_4_chain.n5                            1.8
xinv_4_chain.n6                    2.67658e-09
xinv_4_chain.n7                            1.8
xinv_4_chain.n8                    2.67658e-09
xinv_4_chain.n9                            1.8
out                                2.67658e-09
vin#branch                                   0
vsupply#branch                    -9.09108e-11
vground#branch                               0

 Reference value :  9.17500e-10
No. of Data Rows : 1232
inputrslope--       =  9.800000e-12 targ=  1.099000e-10 trig=  1.001000e-10
inputfslope--       =  9.800000e-12 targ=  3.999000e-10 trig=  3.901000e-10
outputrslope--      =  2.614853e-11 targ=  3.478840e-10 trig=  3.217354e-10
outputfslope--      =  5.561726e-11 targ=  6.395177e-10 trig=  5.839005e-10
proptimerr_in_out   =  2.215348e-10 targ=  3.265348e-10 trig=  1.050000e-10
proptimeff_in_out   =  2.321281e-10 targ=  6.271281e-10 trig=  3.950000e-10
proptimerr_in_inv8  =  1.874053e-10 targ=  2.924053e-10 trig=  1.050000e-10
proptimeff_in_inv8  =  1.924046e-10 targ=  5.874046e-10 trig=  3.950000e-10
proptimerr_inv6_inv8=  4.916494e-11 targ=  2.924053e-10 trig=  2.432403e-10
proptimeff_inv6_inv8=  4.916154e-11 targ=  5.874046e-10 trig=  5.382430e-10
proptimerf_inv7     =  2.005728e-11 targ=  2.632976e-10 trig=  2.432403e-10
proptimefr_inv7     =  2.910525e-11 targ=  5.673483e-10 trig=  5.382430e-10
ngspice 55 -> exit


