README.rst
==========
alliance-check-toolkit/benchs/analog/OtaMiller/sky130/README.rst

September 25, 2023, MML
Descember 18, 2023, MML
January 26, 2024, MML

--------------------------

Miller OTA Layout, techno SkyWater130
---------------------------------------

Rquired files:

dodo.py           : python script to setup the technology and dependencies
doMillerMos_v2.py : Python script to describe netlist, and relative placement for layout generation
                    with only transistors
oceane_sizes.txt  : table (CSV format), input for coriolis placement and routing

---------------
Running layout generation
-------------------------
 ./../../../../bin/crlenv.py -- doit list
shows the possible actions

 ./../../../../bin/crlenv.py -- doit cgt
launches coriolis graphical interface (cgt)

cgt window, select:

Tools/Python Script
doMillerMos_v2 (python script without extension)

Analog/SlicingTree/Update possible dimensions

Analog/SlicingTree/Slicing tree curve
select a point for placement in the Tab "SlicingTree's possible dimensions" list

P&R/Step by Step/Detailed Route

View Fit to Content
Tools Controller
      Filter / Process Terminal Cells
      Hierarchy does not work
      Netlist
      Selection does not work


File/ Exit to quit

NB
----
There are code snippets to access/modify transistor and device parameters 
for layout generation.
Yet some parameters do not have an impact (C++/Pyton interaction to be investigated)

Deprecated files
----------------
./coriolis2/settings.py (to setup the technology)

Setup the environment :
eval `XXX/coriolis-2.x/Linux.el9/Release.Shared/install/etc/coriolis2/coriolisEnv.py`

miller.py    : Python script to describe netlist, and relative placement for layout generation
               with transistors and capacitors
               the capacitors are not up to date

eval `XXX/coriolis-2.x/Linux.el9/Release.Shared/install/etc/coriolis2/coriolisEnv.py`



