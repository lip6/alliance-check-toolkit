# -*- explicit-buffer-name: "Makefile<SARlogic/cmos>" -*-
 export     PDKMASTER_TOP = $(shell pwd)/../../../pdkmaster/C4M.Sky130

                USE_DEBUG = No

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = Sky130_C4M_CF

                 NETLISTS = SARlogic 

 include ./mk/design-flow.mk


sarlogic_r.vst: sarlogic.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

sarlogic_r.gds: sarlogic_r.vst
	@echo "[INFO] Dummy rule to fool GNU Make (sarlogic_cts_r.ap <- sarlogic_cts_r.vst)..."


blif:   SARlogic.blif
vst:    sarlogic.vst
gds:    sarlogic_r.gds

