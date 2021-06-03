
                USE_DEBUG = No
             USE_VALGRIND = No

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = FlexLib018

            USE_CLOCKTREE = Yes
            YOSYS_FLATTEN = ao68000
                     CHIP = chip
                  RM_CHIP = Yes
                 NETLISTS = ao68000

 include ./mk/design-flow.mk

ao68000_cts_r.vst: ao68000.vst
	-$(call scl_cols,$(call c2env, cgt -tV --script=doDesign))

ao68000_cts_r.gds: ao68000_cts_r.vst
	-@echo "[INFO] Overriden default GDS rule (for use with FlexLib)."

gds:    ao68000_cts_r.gds
view:   cgt-ao68000_r

#chip_cts_r.vst: arlet6502.vst
#	-$(call scl_cols,$(call c2env, cgt -tV --script=doDesign))
#
#chip_cts_r.gds: chip_cts_r.vst
#	-@echo "[INFO] Overriden default GDS rule (for use with FlexLib)."
#
#gds:    chip_cts_r.gds
#view:   cgt-chip_r

blif:   ao68000.blif
vst:    ao68000.vst

view:   cgt-arlet6502
