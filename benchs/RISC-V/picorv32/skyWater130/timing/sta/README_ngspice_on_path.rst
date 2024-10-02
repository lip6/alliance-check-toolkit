README_sta.rst
=================

ALI OUDRHIRI 

Update 23 September, 2024 : generation of a timing path (transistor level) for simualtion with ngspice
---------------------------------------------------------------------------------------------------
firt generate the .cns with hitas. For that refer to:
./README_sta_with_hitas_db.rst (to summurize, you launch ./hitas/db_picorv32_m.tcl for example)
or
<alliance-check-toolkits>/bin/calcCPath.tcl

Then :
launch the script:
script_to_modify_spi.py

--> this script is used to modify the characteres \[ and \] that are not parsed correctly by hitas/ngspice
The \ is  removed 

Then launch:

./paths_select_simu.tcl
Launch ngspice on a specific path (here the critical path):
You can change 
Sky130_logic_tt_model
with :
Sky130_logic_ff_model
or 
Sky130_logic_ss_model
to use other corners



--> the extracted file is picorv32_m_ext.spi: It contains the netlist of the path selected (here the critical) with only transistors.
 The simulations commands are given in : cmd_picorv32_m_ext.spi
 The results is given in : cmd_picorv32_m_ext.out
