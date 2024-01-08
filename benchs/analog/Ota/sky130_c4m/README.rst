README.rst
----------------

Marie-Minerve Louerat
10 january 2023
23 February 2023
24 February 2023
18 Deecember 2023

--------------------

coriolis-2.x/src/alliance-check-toolkit/benchs/analog/Ota/sky130_c4m



Required files
----------------

dodo.py         : python script to setup the technology and dependencies 
                 (you have to choose to call ota or ota_oceane script within dodo.py)
ota.py :         python script to describe the devices, the netlist and the silicing tree for layout generation
ota_oceane.py :  python script to describe the devices, the netlist and the silicing tree for layout generation
                 reading the transistor sizes from oceane_ota.txt
         
Running layout generation
-------------------------
 ./../../../../bin/crlenv.py -- doit list
shows the possible actions

 ./../../../../bin/crlenv.py -- doit cgt
launches coriolis graphical interface (cgt)

cgt window, select:

Tools/Python Script
ota_oceane (python script without extension)

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

trials
otasimple (5 transistors, non-differential output)

ota.py with VDD and VSS (non routed)

otaA.py without VDD, nor VSS as special signals

ota_oceane.py taking sizes from Oceane result of sizing process 
              oceane_ota_diff.txt


Makefile
mk (symbolic link)

make cgt

Additional Information
-------------------------

*netlist*
Check sizes provided by Oceane
spice netlist is netlist_OTACSTND1

*Reading W,L, M* from the oceane result file
coriolis/karakaze/python/oceane.py
NB. the *M* parameter in this file and in the oceane_ota.txt file results from 
the number of transistor fingers (NF) multiplied by the number of transistor layout stacks (MULT),
written in oceane_ota.txt or in the netlist provided by oceane.


