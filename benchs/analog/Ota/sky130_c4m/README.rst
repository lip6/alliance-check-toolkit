README.rst
----------------

Marie-Minerve Louerat
10 january 2023
23 February 2023
24 February 2023
18 December 2023
16 January 2024
31 January 2024

--------------------

ota 5 transistors in Sky130nm node

coriolis-2.x/src/alliance-check-toolkit/benchs/analog/Ota/sky130_c4m
main branch

coriolis in main branch
bulk of PMOS is NWELL


Required files
----------------

dodo.py           : python script to setup the technology sky130 and dependencies 
doOta.py :        : python script to describe the devices, the netlist and the silicing tree for layout generation
                    reading sizes from oceane_sizes.txt
oceane_sizes.txt  : file in csv format to describe the sizes of transistors (WF and L), **in microns**, M
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

Additional Information (deprecated)
----------------------------------------

*netlist*
Check sizes provided by Oceane
spice netlist is netlist_OTACSTND1

*Reading W,L, M* from the oceane result file
coriolis/karakaze/python/oceane.py
NB. the *M* parameter in this file and in the oceane_ota.txt file results from 
the number of transistor fingers (NF) multiplied by the number of transistor layout stacks (MULT),
written in oceane_ota.txt or in the netlist provided by oceane.


