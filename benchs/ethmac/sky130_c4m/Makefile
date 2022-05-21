
#export     PDKMASTER_TOP = $(shell pwd)/../../../../C4M/open_pdk/C4M.Sky130
#export     PDKMASTER_TOP = $(shell pwd)/../../../../C4M.Sky130
 export     PDKMASTER_TOP = $(shell pwd)/../../../pdkmaster/C4M.Sky130
        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = Sky130_C4M_CF

            YOSYS_FLATTEN = 
            YOSYS_SET_TOP = Yes
             USE_VALGRIND = No
                USE_DEBUG = No
                  RM_CHIP = Yes
                VST_FLAGS = 

                     CHIP = chip
                 NETLISTS = ethmac

 include ./mk/design-flow.mk

ethmac_r.vst: ethmac.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

ethmac_r.gds: ethmac_r.vst
	-@echo "[INFO] Overriden default GDS rule (for use with FlexLib)."

blif:   ethmac.blif
vst:    ethmac.vst
gds:    ethmac_r.gds

