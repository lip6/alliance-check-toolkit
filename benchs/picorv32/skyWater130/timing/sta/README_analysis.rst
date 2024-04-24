********************************
README_analysis.rst
******************************
alliance-check-toolkit/benchs/picorv32/skyWater130/timing/sta

************************************
Ali Oudrhiri, April 2024
Mazher Iqbal, April 2024
Roselyne Chotin, April 2024
Marie-Minerve Louerat, April 2024
Naohiko Shimzu, April 2024

update 24 April 2024, selected timing path generation
                      using C4M transistor models

*************************************

Modifications performed in ./skylibm/library.spice
 
  * creation of the library.spice file containing 
    the models (transistor level) of the standard cells
    of a target library of standard cells.
  * Here we have used sky130_fd_sc_hd
  * modify "ef" standard cells with "fd" ones,
    beacuse we do not have the "ef" standard cells.
  * create a model (transistor level) for sky130_fd_sc_hd__conb_1
  * remove # in terminal names (transistor model in the standard cells)
  * modify the order of terminals in the cell sky130_fd_sc_hd__decap_12
    since the cell used in the chip (after Yosys) was sky130_ef_sc_hd__decap_12,
    which we do not have,
    but it is clear that both sky130_fd_sc_hd__decap_12 and sky130_ef_sc_hd__decap_1
    have different order of terminals


Sta with Hitas
***************
using the files:
------------------

**subdirectory /hitas/**
files to run Hitas: 
       avt_env.sh  
       db_ng.tcl  
       report_picorv32_m.tcl
       paths_simu.tcl

**subdirectory : /skykibm/**
homemade file containing the Open Source PDK SkyWater130 standard cell library models, 
at transistor level, **ngspice** format, updated: 
       library.spice

**subdirectory : /alliance-check-toolkit/benchs/inverter/skyWater130/sta/techno/**
transistor models updated to take into account the level of the BSIM4 model compatible with Hitas and the absolute path in files:
NFET
        sky130_fd_pr__nfet_01v8__tt.corner.spice
        sky130_fd_pr__nfet_01v8__tt.pm3.spice
PFET
        sky130_fd_pr__pfet_01v8_hvt__tt.corner.spice
        sky130_fd_pr__pfet_01v8_hvt__tt.pm3.spice

**subdirectory : XXXXXXXX/skywater-pdk/libraries/sky130_fd_pr/latest/cells/**

transistor models coming from the PDK
NFET
nfet_01v8/sky130_fd_pr__nfet_01v8__mismatch.corner.spice 
PFET
/pfet_01v8_hvt/sky130_fd_pr__pfet_01v8_hvt__mismatch.corner.spice 

run Hitas sta:
----------------
* setup the shell:
  bash

* setup the environment:
  source ./hitas/avt_env.sh

* run hitas to build the timiming data base:
  ./hitas/db_ng.tcl 

* run hitas to extract longest paths:
  ./hitas/report_picorv32_m.tcl

* run hitas to generate the netlist of a selected timing path at tansistor level.
  ./hitas/paths_simu.tcl
  beware that in the used standard cells nfet uses the standard transistor nfet_01v8__tt
  and pfet the hvt transistor pfet_01v8_hvt__tt
  both included in alliance-check-toolkit/pdkmaster/C4M.Sky130/libs.tech/ngspice_hitas/C4M.Sky130_tt_model.spice
  which has been flatten at model MOS level
  and required for this analysis at transistor level

Note
--------
NB. The files used either in the transistor model:
the ones coming from the PDK
NFET
XXXXXXXX/skywater-pdk/libraries/sky130_fd_pr/latest/cells/nfet_01v8/sky130_fd_pr__nfet_01v8__mismatch.corner.spice spice
PFET
XXXXXXXXX/skywater-pdk/libraries/sky130_fd_pr/latest/cells/pfet_01v8_hvt/sky130_fd_pr__pfet_01v8_hvt__mismatch.corner.spice spice

the ones that had and have to be updated:
NFET
YYYYYYYYYY/alliance-check-toolkit/benchs/inverter/skyWater130/sta/techno/sky130_fd_pr__nfet_01v8__tt.corner.spice

PFET
YYYYYYYYYY/alliance-check-toolkit/benchs/inverter/skyWater130/sta/techno/sky130_fd_pr__pfet_01v8_hvt__tt.corner.spice

or the netlist to be analysed:
ZZZZZZZZZZZZZ/alliance-check-toolkit/benchs/picorv32/skyWater130/timing/sta/picorv32_m_hitas.spi spice

are set with absolute paths.

You SHOULD update the paths according to your local environment

The absolute path problem of HiTas,
comes from the library which is used in HiTas.
You may try to set environment variables to designate where your designs are.
The variables are MBK_WORK_LIB and MBK_CATA_LIB.

You may set in your .profile
export MBK_WORK_LIB=.
Usually one of the variable is enough to use for local evaluation.
MBK_CATA_LIB is usually used to designate libraries with colon separated paths.

