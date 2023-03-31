# -*- explicit-buffer-name: "Makefile<SpinalRTL/layout>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib

            USE_CLOCKTREE = Yes
                USE_DEBUG = No
                 USE_KITE = No

                 NETLISTS = VexRiscv

 include ./mk/design-flow.mk

vexriscv_r.vst: vexriscv.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

vexriscv_r.ap: vexriscv_r.vst
	@echo "[INFO] Dummy rule to fool GNU Make (vexriscv_r.ap <- vexriscv_r.vst"


blif:   VexRiscv.blif
layout: vexriscv_r.ap

lvx:    lvx-vst-vexriscv
druc:   druc-vexriscv_r
