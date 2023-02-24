README.rst
----------------

Marie-Minerve Louerat
10 january 2023
23 February 2023

--------------------

coriolis-2.x/src/alliance-check-toolkit/benchs/analog/Ota/sky130_c4m

trials
otasimple (5 transistors, non-differential output)

ota.py with VDD and VSS (non routed)

otaA.py without VDD, nor VSS as special signals

ota_oceane.py taking sizes from Oceane result of sizing process 
              oceane_ota_diff.txt


use the following files
Makefile
coriolis2 directory (for setting techno)
mk (symbolic link)
oceane_ota.txt when ota_oceane.py is used

make cgt

Tools/Python script (ota or otaA or ota_oceane)
Analog/SlicingTree/update possible dimensions
Analog/SlicingTree/slicing Tree Curve

select a point 

P&R/Step By Step/Detailed route

Check sizes provided by Oceane
nelist is netlist_OTACSTND1
