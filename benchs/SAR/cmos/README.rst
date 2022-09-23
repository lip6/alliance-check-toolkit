README.rst
==========

14 September 2022
23 September 2022
++++++++++++++++++

Tiny example of the flow from Python script for nmigen, to layout Coriolis
and some verification by Alliance

Behavioral description to RTL code by nmigen:
-----------------------------------------------

python3 SARlogic_step1.py

gives SARlogic_Step1.v
today (to be changed) it has to be modified by hand "top" module name ==> "SARlogic"
and rename in SARlogic.v
it is already done in ./../rtl/SARlogic.v

logical synthesis with YOSYS:
-----------------------------

using SARlogic.v
make vst 
provides (beware of letter case):
-rw-r--r-- 1 mariem utmp   288 14 sept. 17:53 SARlogic.tcl
-rw-r--r-- 1 mariem utmp 12161 14 sept. 17:53 SARlogic.blif
-rw-r--r-- 1 mariem utmp 36068 14 sept. 17:53 sarlogic.vst
-rw-r--r-- 1 mariem utmp 10943 14 sept. 17:53 SARlogic.spi


Place and Route with Coriolis:
-----------------------------------

make cgt
Tools/python script/doDesign

Click on the bird to follow the steps (see doDesign control)

provides layout
CTRL + RIGHT click allows to get the description of what is under the point.

Remarks:

- stop points to show the placement and routing steps

- no Clock Tree synthesis here, too small example



Layout versus Schematic with Alliance LVX:
---------------------------------------------
make lvx

***** Loading and flattening sarlogic_r (vst)...

***** Loading and flattening sarlogic_r_ext (al)...


***** Compare Terminals ................
***** O.K.	(0 sec)

***** Compare Instances ............
***** O.K.	(0 sec)

***** Compare Connections .....................
***** O.K.	(0 sec)

===== Terminals .......... 24    
===== Instances .......... 132   
===== Connectors ......... 766   


***** Netlists are Identical. *****	(0 sec)


DRC with Alliance DRUC
----------------------------
make druc
Flatten DRC on: sarlogic_r
Delete MBK figure : sarlogic_r
Load Flatten Rules : /soc/alliance/etc/cmos.rds

Unify : sarlogic_r

Create Ring : sarlogic_r_rng
Merge Errorfiles: 

Merge Error Instances:
instructionCourante :  56
End DRC on: sarlogic_r
Saving the Error file figure
Done
  0

File: sarlogic_r.drc is empty: no errors detected.

