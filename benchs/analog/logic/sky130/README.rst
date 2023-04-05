README.rst
-----------
5 April 2023, MM Louerat

coriolis-2.x/src/alliance-check-toolkit/benchs/analog/logic/sky130


In this directory, there are some tiny examples to handle:

* splitting of the descripion of the python script to genrate the layout into functions
  to ease the reuse of sub-blocks, and iteration if identical sub-blocks
  the python script uses 2 functions:
  
  - def buildDevAndNets ( self, design )
    creation of devices
    creation of external nets
    description of nets (netlist)

  - def buildSlicingTree ( self, design )
    part of the slicing tree

* use case: simple nand2 logical cell, with sizing provided by Oceane
            described as an analog circuit, so quite large
            sky130 target

* reuse case: using the nand2 cell, 2 cases are provided:

  - nand2group.py : 2 nand2 cells are connected
    description:
    +  netlist description is splitted, and used in the circuit under design.
    +  layout is flatten, taking advantage of index iteration, and 
       easy to place and route

  - nand2cells.py the same 2 nand2 cells are connected as above, but:
    description:
    +  netlist description is splitted
    +  layout description is splitted,
    both functions are used in the circuit under design,
    the resulting slicing tree has more nodes. The routing seems less straightful.

 


