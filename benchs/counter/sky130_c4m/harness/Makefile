
 export     PDKMASTER_TOP = $(shell pwd)/../../../../pdkmaster/C4M.Sky130

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = Sky130_C4M

 export          TOP_CELL = counter_harness

            YOSYS_FLATTEN = $(TOP_CELL)
            YOSYS_SET_TOP = Yes
                USE_DEBUG = No
                  RM_CHIP = Yes
                VST_FLAGS = 

                 NETLISTS = $(TOP_CELL)

 include ./mk/design-flow.mk


$(TOP_CELL)_cts_r.vst: $(TOP_CELL).vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

$(TOP_CELL)_cts_r.gds: $(TOP_CELL)_cts_r.vst
	-@echo "[INFO] Overriden default GDS rule (for use with $(DESIGN_KIT))."

blif:   $(TOP_CELL).blif
vst:    $(TOP_CELL).vst
gds:    $(TOP_CELL)_cts_r.gds
