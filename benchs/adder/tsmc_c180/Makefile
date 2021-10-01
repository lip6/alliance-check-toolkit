
        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = FlexLib018

            USE_CLOCKTREE = Yes
                USE_DEBUG = No
             USE_VALGRIND = No
                 USE_KITE = No
                  RM_CHIP = Yes

                     CHIP = chip
                 NETLISTS = adder

 include ./mk/design-flow.mk

chip_cts_r.vst: adder.vst
	$(call scl_cols,$(call c2env, cgt -tV --script=doDesign))

chip_cts_r.gds: chip_cts_r.vst
	@echo "[INFO] Overriden default GDS rule (for use with FlexLib)."

blif:   adder.blif
vst:    adder.vst
gds:    chip_cts_r.gds
view:   cgt-chip_r
