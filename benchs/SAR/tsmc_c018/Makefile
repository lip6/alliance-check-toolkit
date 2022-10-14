
                USE_DEBUG = No
             USE_VALGRIND = No

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = FlexLib018

                 NETLISTS = SARlogic 

 include ./mk/design-flow.mk


sarlogic_r.vst: sarlogic.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

sarlogic_r.gds: sarlogic_r.vst
	@echo "[INFO] Dummy rule to fool GNU Make (sarlogic_cts_r.ap <- sarlogic_cts_r.vst)..."


blif:   SARlogic.blif
vst:    sarlogic.vst
gds:    sarlogic_r.gds


