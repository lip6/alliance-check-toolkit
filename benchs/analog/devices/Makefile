
#export     PDKMASTER_TOP = $(shell pwd)/../../../../C4M/open_pdk/C4M.Sky130
#export     PDKMASTER_TOP = $(shell pwd)/../../../../C4M.Sky130
#export     PDKMASTER_TOP = $(shell pwd)/../../../../mpw4/thirdparty/open_pdk/C4M.Sky130
 export     PDKMASTER_TOP = $(shell pwd)/../../../pdkmaster/C4M.Sky130
        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = Sky130_C4M_CF

             USE_VALGRIND = No
                USE_DEBUG = No

 include ./mk/design-flow.mk

 export CELLS_TOP = ./../../../cells
