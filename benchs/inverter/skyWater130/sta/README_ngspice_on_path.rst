README_sta.rst
=================

ALI OUDRHIRI 

Update 23 September, 2024 : generation of a timing path (transistor level) for simualtion with ngspice
---------------------------------------------------------------------------------------------------
firt generate the .cns with hitas. For that refer to:
./README_sta_with_hitas_db.rst (to summurize, you launch ./hitas/db_ng.tcl for example)
or
<alliance-check-toolkits>/bin/calcCPath.tcl

Then :

./paths_select_simu.tcl
Launch ngspice on a specific path (here the critical path):
You can change 
Sky130_logic_tt_model
with :
Sky130_logic_ff_model
or 
Sky130_logic_ss_model
to use other corners
