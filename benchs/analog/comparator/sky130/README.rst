README.rst
=============
alliance-check-toolkit/benchs/analog/comparator/sky130/README.rst

5 March 2024, MML

-------------------------------------------------------------------------------------------

Comparator : simple architecture techno skyWater130
----------------------------------------------------------

alliance-check-toolkit/benchs/analog/comparator/sky130/

Intellectual Sharing
Compact semi-dynamical comparator layout template
Transistor's names come from the FOSS tool Oceane used to size the transistors

Comparator architecture:
  *  Compact
  *  Semi-dynamical

Goal: Work In Progress to generate the layout of a comparator.
      Technological node: SkyWater 130nm
      Sizing is made with the FOSS tool Oceane, January 2024 version
      /users/outil/oceane/oceane_folk_jan2024/oceane
      parameters (sizes and layout info) are provided in a Table (CSV format but comm replaced with ' ').

Configuration is made with:
./../../../../bin/crlenv.py -- doit cgt
and dodo.py file

Available files in current directory:
--------------------------------------

dodo.py            : python script to setup the technology and dependencies

doCmpv.py          : python script to describe netlist, and relative placement 
                     using the sizes of ./sizes/oceane_cmpvXX.txt, 
                     to generate layout of the comparator

oceane_cmpv10.txt  : Table of sizes, provided by Oceane, with 10MHz spec
oceane_cmpv50.txt  : Table of sizes, provided by Oceane, with 50MHz spec
oceane_cmpv100.txt : Table of sizes, provided by Oceane, with 100MHz spec

inputfile.txt      : to choose which Table of sizes will be used
                     together with the number of slices for the transistors
                     choose 3 slices for low frequency (10 MHz), since mn1 and mn2 have large Ls
                     choose 2 slices for low frequency (50 or 100 MHz), since NMOS have smaller Ls
                     the goal is to generate a roughly square layout

Available files in ./sizes/ subdirectory:
-----------------------------------------

Result of Oceane sizing is provided here for different clock frequency specifications:

sizes_cmpv_10MHz.txt          : transistors sizes (Wfinger,L,M) of transistors with 10MHz  spec
sizes_cmpv_50MHz.txt          : transistors sizes (Wfinger,L,M) of transistors with 50MHz  spec
sizes_cmpv_100MHz.txt         : transistors sizes (Wfinger,L,M) of transistors with 100MHz spec
                                


-------------------------
Running layout generation
-------------------------
 ./../../../../bin/crlenv.py -- doit list
shows the possible actions

 ./../../../../bin/crlenv.py -- doit cgt
launches coriolis graphical interface (cgt)

In cgt window, select:

Tools/Python Script

  * doCmpv.py 

The placement should appear.    
Analog/SlicingTree/Update possible dimensions

Analog/SlicingTree/Slicing tree curve
Only One point available in this version.
The area efficiency is provided.

To route:
P&R/Step by Step/Detailed Route

View/Fit to Content to adjust the layout to the window

Tools Controller
      Filter / Process Terminal Cells
      Hierarchy: no hiearchy, the layout is flattened
      Netlist: Sync Netlist and Sync Selection allows to check the routed signals
      Selection: select "Show selection" to list the objects used to build the signal

File/ Exit to quit








