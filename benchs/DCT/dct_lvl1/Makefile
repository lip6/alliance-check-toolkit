# -*- explicit-buffer-name: "Makefile<Arlet6502/cmos>" -*-

                USE_DEBUG = No

        LOGICAL_SYNTHESIS = disabled
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib
                   PLACED = Yes

                 NETLISTS = dct_lvl1_flat

 include ./mk/design-flow.mk


dct_lvl1_flat_r.vst: dct_lvl1_flat.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

dct_lvl1_flat_r.ap: dct_lvl1_flat_r.vst
	@echo "[INFO] Dummy rule to fool GNU Make (dct_lvl1_flat_r.ap <- dct_lvl1_flat_r.vst)..."


layout: dct_lvl1_flat_r.ap

lvx:    lvx-dct_lvl1_flat_r
druc:   druc-dct_lvl1_flat_r
