# -*- explicit-buffer-name: "Makefile<SARlogic/cmos>" -*-

                USE_DEBUG = No

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib

                 NETLISTS = SARlogic 

 include ./mk/design-flow.mk


sarlogic_r.vst: sarlogic.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

sarlogic_r.ap: sarlogic_r.vst
	@echo "[INFO] Dummy rule to fool GNU Make (sarlogic_cts_r.ap <- sarlogic_cts_r.vst)..."


blif:   SARlogic.blif
vst:    sarlogic.vst
layout: sarlogic_r.ap

lvx:    lvx-sarlogic_r
druc:   druc-sarlogic_r
