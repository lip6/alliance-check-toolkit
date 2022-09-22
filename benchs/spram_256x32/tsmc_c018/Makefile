
                USE_DEBUG = No
             USE_VALGRIND = No

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = FlexLib018

            USE_CLOCKTREE = Yes
                     CHIP = chip
                  RM_CHIP = Yes
                 NETLISTS = eth_spram_256x32

 include ./mk/design-flow.mk

eth_spram_256x32_r.vst: eth_spram_256x32.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=placeSRAM))

eth_spram_256x32_r.gds: eth_spram_256x32_r.vst
	-@echo "[INFO] Overriden default GDS rule (for use with FlexLib)."

blif:   eth_spram_256x32.blif
vst:    eth_spram_256x32.vst
gds:    eth_spram_256x32_r.gds

