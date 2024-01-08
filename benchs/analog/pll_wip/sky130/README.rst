README.rst
==========
alliance-check-toolkit/benchs/analog/pll_wip/sky130/README.rst

September 25, 2023, MML
December 18, 2023, MML

--------------------------

VCO (in PLL) Layout, techno SkyWater130
---------------------------------------

Rquired files:

vco_wip.py (Python script to describe netlist, and relative placement for lyout generation)
CMOS_VCO_cell.cir_transistor_size.txt (with the transistor sizes)

dodo.py : to set the technology and the software dependencies

---------------

Setup the environment and call Coriolis Graphical Tool:

/../../../../bin/crlenv.py -- doit cgt

launch coriolis graphical tool (cgt)

cgt window:
Tools/Python script

vco_wip (name of the Python script without extension)

Analog / Slicing Tree / Update possible dimensions

Analog / Slicing Tree / Slicing tree curve (here only one)

click on the selected aspect ratio and see the placement and global route 
(you should click in the SlicingTree's possible dimension Tab list rather than in the SlicingTree's Pareto Tab curve)


P&R / Step by Step / Detailed Route (detailed route)

P&R / Step by Step / Finalize Routing (updating contacts)


old (deprecated)
--------------------
eval `XXX/coriolis-2.x/Linux.el9/Release.Shared/install/etc/coriolis2/coriolisEnv.py`
./coriolis2/settings.py (to setup the technology)

