README.rst
==========
alliance-check-toolkit/benchs/analog/OtaMiller/sky130/README.rst

September 25, 2023, MML
Descember 18, 2023, MML
January 26, 2024, MML
1 March 2024, MML

--------------------------

Miller OTA Layout, techno SkyWater130
---------------------------------------

Intellectual Sharing
Miller OTA layout template
Transistor's names come from the FOSS tool Oceane used to size the transistors

Goal:  Work In Progress to generate the layout of the Miller OTA
       Transistor part only
       Technological node: SkyWater 130nm
       Sizing is made with the FOSS tool Oceane
       Folding of transitors is used a lot

Rquired files:

dodo.py           : python script to setup the technology and dependencies

doMillerMos_v2.py : Python script to describe netlist, and relative placement for layout generation
                    with only transistors

oceane_sizes.txt  : table (CSV format), input for coriolis placement and routing

-------------------------
Running layout generation
-------------------------
 ./../../../../bin/crlenv.py -- doit list
shows the possible actions

 ./../../../../bin/crlenv.py -- doit cgt
launches coriolis graphical interface (cgt)

In cgt window, select:

Tools/Python Script
doMillerMos_v2 (python script without extension)

The placement should appear. 
Analog/SlicingTree/Update possible dimensions

Analog/SlicingTree/Slicing tree curve
select a point for placement in the Tab "SlicingTree's possible dimensions" list
You can order the list function to maximize the area occupation
The new placement should appear. 

P&R/Step by Step/Detailed Route

View/Fit to Content to adjust the layout to the window

Tools Controller
      Filter / Process Terminal Cells
      Hierarchy: no hiearchy, the layout is flattened
      Netlist: Sync Netlist and Sync Selection allows to check the routed signals
      Selection: select "Show selection" to list the objects used to build the signal

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



