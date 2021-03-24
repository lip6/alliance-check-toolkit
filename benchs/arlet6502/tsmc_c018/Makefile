
        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = FlexLib018

            USE_CLOCKTREE = Yes
                USE_DEBUG = No
             USE_VALGRIND = No

                     CHIP = chip
                  RM_CHIP = Yes
                 NETLISTS = Arlet6502 \
                            alu       \
                            cpu

 include ./mk/design-flow.mk

chip_cts_r.vst: arlet6502.vst
	-$(call scl_cols,$(call c2env, cgt -tV --script=doDesign))

chip_cts_r.gds: chip_cts_r.vst
	-@echo "[INFO] Overriden default GDS rule (for use with FlexLib)."

blif:   Arlet6502.blif
vst:    arlet6502.vst
gds:    chip_cts_r.gds
view:   cgt-chip_r

view:   cgt-arlet6502
