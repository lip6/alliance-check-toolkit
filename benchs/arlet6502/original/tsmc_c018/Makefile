
                USE_DEBUG = No
             USE_VALGRIND = No

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = FlexLib018

            USE_CLOCKTREE = Yes
                     CHIP = chip
                  RM_CHIP = Yes
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
