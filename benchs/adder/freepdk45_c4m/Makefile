
            PDKMASTER_TOP = $(shell pwd)/../../../../libre-soc/c4m-pdk-freepdk45
        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = FreePDK_C4M45

            YOSYS_FLATTEN = No
            YOSYS_SET_TOP = Yes
            USE_CLOCKTREE = Yes
                USE_DEBUG = No
                  RM_CHIP = Yes
                VST_FLAGS = --vst-uniquify-uppercase

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
