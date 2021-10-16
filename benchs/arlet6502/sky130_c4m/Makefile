
 export     PDKMASTER_TOP = $(shell pwd)/../../../../C4M/open_pdk/C4M.Sky130
        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = Sky130_C4M

            YOSYS_FLATTEN = 
            YOSYS_SET_TOP = Yes
                USE_DEBUG = No
                  RM_CHIP = Yes
                VST_FLAGS = 

                     CHIP = chip
                 NETLISTS = Arlet6502 \
                            cmpt_alu  \
                            cmpt_cpu

 include ./mk/design-flow.mk


chip_cts_r.vst: arlet6502.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

chip_cts_r.gds: chip_cts_r.vst
	-@echo "[INFO] Overriden default GDS rule (for use with FlexLib)."

blif:   Arlet6502.blif
vst:    arlet6502.vst
gds:    chip_cts_r.gds
view:   cgt-chip_r

view:   cgt-arlet6502
