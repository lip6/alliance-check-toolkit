
                USE_DEBUG = No
             USE_VALGRIND = No

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = FlexLib018

            USE_CLOCKTREE = Yes
                     CHIP = chip
                  RM_CHIP = Yes
                 NETLISTS = ethmac

 include ./mk/design-flow.mk

ethmac_r.vst: ethmac.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

ethmac_r.gds: ethmac_r.vst
	-@echo "[INFO] Overriden default GDS rule (for use with FlexLib)."

blif:   ethmac.blif
vst:    ethmac.vst
gds:    ethmac_r.gds

sram:
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=placeSRAM))

