README.rst
----------------

Marie-Minerve Louerat
31 January 2024

--------------------

Chrge Pump, work in progress in Sky130nm node

coriolis-2.x/src/alliance-check-toolkit/benchs/analog/chargepump-wip/sky130
main branch

coriolis in main branch
bulk of PMOS is NWELL


Required files: 3 sets available
---------------------------------

dodo.py                                 : python script to setup the technology sky130 and dependencies 
doCp_wip1.py                            : python script to describe the devices, the netlist and the silicing tree for layout generation
                                          reading sizes from chargepump_size_wip.txt
                                          M1 (NMOS)  and M3 (PMOS) which are gate-drain connected transistor seem to have missing 
                                          wire between Gate and Drain
chargepump_size_wip.txt                 : file in csv format to describe the sizes of transistors (WF and L), **in microns**, M
                                          name and type (NMOS or PMOS) of transistors
                                          may be hand written, or computed with you favorite python notebook

or

dodo.py                                 : python script to setup the technology sky130 and dependencies 
doCp_wip2.py                            : python script to describe the devices, the netlist and the silicing tree for layout generation
                                          reading sizes from chargepump_size_wip.txt
                                          The slicing tree is using containers in lines (Vslice) to ease matching
                                          M1 (NMOS)  and M3 (PMOS) which are gate-drain connected transistor seem to have missing 
                                          wire between Gate and Drain
chargepump_size_wip.txt                 : file in csv format to describe the sizes of transistors (WF and L), **in microns**, M
                                          name and type (NMOS or PMOS) of transistors
                                          may be hand written, or computed with you favorite python notebook

or

dodo.py                                 : python script to setup the technology sky130 and dependencies 
doCp_wip3.py                            : python script to describe the devices, the netlist and the silicing tree for layout generation
                                          reading sizes from chargepump_size_wip3.txt
                                          Using BulkSource connected transistors
                                          Defining the side of the Bulk connectors transistors
                                          adjusting the bulk terminal, north/south side of the transistor
                                          The slicing tree is using containers in lines (Vslice) to ease matching
                                          PMOS on North, NMOS on Southside of the transistor cell
                                          M1 (NMOS)  and M3 (PMOS) which are gate-drain connected transistor seem to have missing 
                                          wire between Gate and Drain
chargepump_size_wip3.txt                : file in csv format to describe the sizes of transistors (WF and L), **in microns**, M
                                          name and type (NMOS or PMOS) of transistors
                                          as well as some useful layout style parameters (source connection to bulk, bulk)
                                          may be hand written, or computed with you favorite python notebook

         
Running layout generation
-------------------------
 ./../../../../bin/crlenv.py -- doit list
shows the possible actions

 ./../../../../bin/crlenv.py -- doit cgt
launches coriolis graphical interface (cgt)

cgt window, select:

Tools/Python Script
doCp_wip1 (python script without extension)
or
doCp_wip2 (python script without extension)
or
doCp_wip3 (python script without extension)

Analog/SlicingTree/Update possible dimensions

Analog/SlicingTree/Slicing tree curve
single point for placement in the Tab "SlicingTree's possible dimensions"

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
cp_wip.py this file is buggy to read the sizing file
chargepump_cell.cir_transistor_size.txt wrong units to read

Additional Information (deprecated)
----------------------------------------

*netlist*


