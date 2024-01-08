README.rst
-------------

MML, 1 June 2023
MML, 25 October 2023
MML, 18 Deecember 2023

ota 5 transistors in 350nm node

coriolis in analog-fixes branch
https://github.com/lip6/coriolis/commit/83d02759490c5235f0020b003a03c6c250256171

XXX/coriolis-2.x/src/alliance-check-toolkit/benchs/analog/Ota/350


Required files
----------------

dodo.py : python script to setup the technology and dependencies
ota.py  : python script to describe the devices, the netlist and the silicing tree for layout generation

Running layout generation
-------------------------
 ./../../../../bin/crlenv.py -- doit list
shows the possible actions

 ./../../../../bin/crlenv.py -- doit cgt
launches coriolis graphical interface (cgt)

cgt window, select:

Tools/Python Script
ota (python script without extension)

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
