README.rst
=============
alliance-check-toolkit/benchs/analog/sar_adc_wip/sky130/README.rst

24 April 2024, MMLouerat
14 october 2024, MML

-------------------------------------------------------------------------------------------

SAR ADC, wip version, techno skyWater130
----------------------------------------------------------

alliance-check-toolkit/benchs/analog/sar_adc_wip/sky130/

Intellectual Sharing
SAR ADC (DAC + comparator + Flip Flop) layout template
Transistor's names come from the FOSS tool Oceane used to size the transistors

Comparator architecture:
  * N-type differential dynamic amplifier
    DifferentialPair (WIP DP) used for MN1 and MN2 transistors
    CommonSourcePair (WIP CSP) used for MP7 and MP8 transistors
    Single Transistor (WIP Transistor) used for MN5 and MP9 transistors

  * Latch-type comparator (Song type P)

Goal: Work In Progress to generate the layout of a sar ADC.
      Technological node: SkyWater 130nm

Configuration is made with:
./../../../../bin/crlenv.py doit cgt
and dodo.py file

Available files in current directory:
--------------------------------------

dodo.py                        : python script to setup the technology and dependencies

doSar_wip_3.py                 : python script to describe netlist, and relative placement 
                                 using hard-coded sizes
                                 to generate layout of the preamplifier and the Latch-type comparator, 
                                 with buffer and RS Flip-Flop at the output


-------------------------
Running layout generation
-------------------------
 ./../../../../bin/crlenv.py  doit list
shows the possible actions

 ./../../../../bin/crlenv.py  doit cgt
launches coriolis graphical interface (cgt)

In cgt window, select:

Tools/Python Script

doSar_wip_3

The placement should appear.    
Analog/SlicingTree/Update possible dimensions

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



