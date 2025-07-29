# -*- explicit-buffer-name: "Makefile<6502/cmos45>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = cmos45
                USE_DEBUG = No

                 NETLISTS = Arlet6502 \
                            cmpt_alu  \
                            cmpt_cpu

 include ./mk/design-flow.mk


chip_r.vst: arlet6502.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

chip_r.ap: chip_r.vst
	@echo "[INFO] Dummy rule to fool GNU Make (chip_r.ap <- chip_r.vst)..."

blif:      Arlet6502.blif
vst:       arlet6502.vst
layout:    chip_r.ap
lvx:       lvx-chip_r
druc:      druc-chip_r
view:      cgt-chip_r
