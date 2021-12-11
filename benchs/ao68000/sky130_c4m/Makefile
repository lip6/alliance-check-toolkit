

                USE_DEBUG = No
             USE_VALGRIND = No

#export     PDKMASTER_TOP = $(shell pwd)/../../../../C4M/open_pdk/C4M.Sky130
 export     PDKMASTER_TOP = $(shell pwd)/../../../../C4M.Sky130

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = Sky130_C4M

            YOSYS_FLATTEN = ao68000
            YOSYS_SET_TOP = Yes
                  RM_CHIP = Yes
                VST_FLAGS = 

                     CHIP = chip
                 NETLISTS = ao68000

 include ./mk/design-flow.mk


ao68000_cts_r.vst: ao68000.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

ao68000_cts_r.gds: ao68000_cts_r.vst
	-@echo "[INFO] Overriden default GDS rule (for use with FlexLib)."

blif:   ao68000.blif
vst:    ao68000.vst
gds:    ao68000_cts_r.gds
