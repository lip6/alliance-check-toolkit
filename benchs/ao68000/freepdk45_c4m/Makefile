
            PDKMASTER_TOP = $(shell pwd)/../../../../libre-soc/c4m-pdk-freepdk45
        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = FreePDK_C4M45

            YOSYS_FLATTEN = ao68000
            YOSYS_SET_TOP = Yes
            USE_CLOCKTREE = Yes
                USE_DEBUG = No
                  RM_CHIP = Yes
                VST_FLAGS = 

                     CHIP = chip
                 NETLISTS = ao68000

 include ./mk/design-flow.mk

ao68000_cts_r.vst: ao68000.vst
	$(call scl_cols,$(call c2env, cgt -tV --script=doDesign))

ao68000_cts_r.gds: ao68000_cts_r.vst
	-@echo "[INFO] Overriden default GDS rule (for use with FlexLib)."

gds:    ao68000_cts_r.gds
blif:   ao68000.blif
vst:    ao68000.vst
