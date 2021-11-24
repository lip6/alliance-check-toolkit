# -*- explicit-buffer-name: "Makefile<Arlet6502/cmos>" -*-

                USE_DEBUG = No

        LOGICAL_SYNTHESIS = disabled
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib
                   PLACED = Yes

               CUSTOM_LIB = ../efpgalib
                 NETLISTS = vld_flat

 include ./mk/design-flow.mk


vld_flat_r.vst: vld_flat.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

vld_flat_r.ap: vld_flat_r.vst
	@echo "[INFO] Dummy rule to fool GNU Make (vld_flat_r.ap <- vld_flat_r.vst)..."


layout: vld_flat_r.ap

lvx:    lvx-vld_flat_r
druc:   druc-vld_flat_r
