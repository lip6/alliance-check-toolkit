README.rst
=============
alliance-check-toolkit/benchs/analog/comparator/sky130_c4m/README.rst

24 April 2024, MMLouerat
1 March 2024, MML
4 March 2024, MML

-------------------------------------------------------------------------------------------

Comparator : Synchronous Comparator, techno skyWater130
----------------------------------------------------------

alliance-check-toolkit/benchs/analog/comparator/sky130_c4m/

Intellectual Sharing
Synchchronous comparator layout template
Transistor's names come from the FOSS tool Oceane used to size the transistors

Comparator architecture:
  * Preamplifier (dynamic, type P)
  * Latch-type comparator (Song type N)
  * output buffer
  * RS flip-flop at the output to store the result on clock signal

Goal: Work In Progress to generate the layout of a comparator.
      Technological node: SkyWater 130nm
      Sizing is made with the FOSS tool Oceane, April 2023 version
      /users/outil/oceane/oceane_folk_april_2023/oceane

Configuration is made with:
./../../../../bin/crlenv.py -- doit cgt
and dodo.py file

Available files in current directory:
--------------------------------------

dodo.py                        : python script to setup the technology and dependencies

comparator_oceane.py           : python script to describe netlist, and relative placement 
                                 using the sizes of ./sizes/oceane_comparator.txt, 
                                 to generate layout of the preamplifier and the Latch-type comparator

comparator_buffer_oceane.py    : python script to describe netlist, and relative placement 
                                 using the sizes of ./sizes/oceane_comparator_buffer.txt,
                                 to generate layout of the preamplifier and the Latch-type comparator, 
                                 with buffer at the output

comparator_buffer_oceane_RS.py : python script to describe netlist, and relative placement 
                                 using the sizes of ./sizes/oceane_comparator_buffer_RS.txt,
                                 to generate layout of the preamplifier and the Latch-type comparator, 
                                 with buffer and RS Flip-Flop at the output

Available files in ./sizes/ subdirectory:
-----------------------------------------

oceane_comparator.txt           : transistors sizes (Wfinger,L,M) of 
                                  the preamplifier and the Latch-type comparator 

oceane_comparator_buffer.txt    : transistors sizes (Wfinger,L,M) of 
                                  the preamplifier and the Latch-type comparator
                                  with buffer at the output

oceane_comparator_buffer_RS.txt : transistors sizes (Wfinger,L,M) of 
                                  the preamplifier and the Latch-type comparator
                                  with buffer and RS Flip-Flop at the output

-------------------------
Running layout generation
-------------------------
 ./../../../../bin/crlenv.py -- doit list
shows the possible actions

 ./../../../../bin/crlenv.py -- doit cgt
launches coriolis graphical interface (cgt)

In cgt window, select:

Tools/Python Script
3 (exclusive) versions are available:

  * comparator_oceane.py, 
  * comparator_buffer_oceane.py  
  * comparator_buffer_oceane_RS.py  

The placement should appear.    
Analog/SlicingTree/Update possible dimensions

Analog/SlicingTree/Slicing tree curve
Only One point available in this version.

To route:
P&R/Step by Step/Detailed Route

View/Fit to Content to adjust the layout to the window

Tools Controller
      Filter / Process Terminal Cells
      Hierarchy: no hiearchy, the layout is flattened
      Netlist: Sync Netlist and Sync Selection allows to check the routed signals
      Selection: select "Show selection" to list the objects used to build the signal

File/ Exit to quit










Deprecated
--------------

To launch the layout generation:

  * make cgt
  * Tool/PythonScript: choose one above
  * The placement should appear in the window
  * To route: P&R/Step by Step/Detailed Route
  * to analyze the layout: Tools/Controller
  * CTRL Q to exit



