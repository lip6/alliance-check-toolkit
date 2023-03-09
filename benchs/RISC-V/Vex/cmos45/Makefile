# -*- explicit-buffer-name: "Makefile<VexRiscv/cmos45>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = cmos45

            USE_CLOCKTREE = Yes
                USE_DEBUG = No
                 USE_KITE = No

                 NETLISTS = VexRiscv

 include ./mk/design-flow.mk

vexriscv_r.vst: VexRiscv.blif
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

vexriscv_r.ap: vexriscv_r.vst
	@echo "[INFO] Dummy rule to fool GNU Make (vexriscv_r.ap <- vexriscv_r.vst"


blif:   VexRiscv.blif
vst:    vexriscv.vst
layout: vexriscv_r.ap
gds:    vexriscv_r.gds

lvx:    lvx-vst-vexriscv
drc:    druc-vexriscv_r
