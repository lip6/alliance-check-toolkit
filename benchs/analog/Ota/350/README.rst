README.rst
-------------

MML, 1 June 2023
MML, 25 October 2023
MML, 18 December 2023
MML, 15 January 2024
MML, 16 January 2024

ota 5 transistors in 350nm node

coriolis in analog-fixes branch
bulk of PMOS is NWELL

XXX/coriolis-2.x/src/alliance-check-toolkit/benchs/analog/Ota/350


Required files
----------------

dodo.py          : python script to setup the technology and dependencies
doOta.py         : python script to describe the devices, the netlist and the silicing tree for layout generation
oceane_sizes.txt : file in csv format to describe the sizes of transistors (WF and L), **in microns**, M
                   as well as some useful layout style parameters (source connection to bulk)
                   may be provided by oceane, or hand written, or computed with you favorite python notebook

Running layout generation
-------------------------
 ./../../../../bin/crlenv.py -- doit list
shows the possible actions

 ./../../../../bin/crlenv.py -- doit cgt
launches coriolis graphical interface (cgt)

cgt window, select:

Tools/Python Script
doOta (python script without extension)

Analog/SlicingTree/Update possible dimensions

Analog/SlicingTree/Slicing tree curve
select a point for placement in the Tab "SlicingTree's possible dimensions"

P&R/Step by Step/Detailed Route

View Fit to Content
Tools Controller
      Filter / Process Terminal Cells
      Hierarchy does not work
      Netlist
      Selection does not work


File/ Exit to quit

Deprecated files
-----------------
coriolis2 directory to setup the technology
ota.py is not parametrized with csv file
