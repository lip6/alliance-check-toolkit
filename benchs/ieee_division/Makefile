# -*- explicit-buffer-name: "Makefile<Arlet6502/cmos>" -*-

                USE_DEBUG = No

        LOGICAL_SYNTHESIS = disabled
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib
                   PLACED = Yes

               CUSTOM_LIB = ../efpgalib
                 NETLISTS = ieee_division_flat

 include ./mk/design-flow.mk


ieee_division_flat_r.vst: ieee_division_flat.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

ieee_division_flat_r.ap: ieee_division_flat_r.vst
	@echo "[INFO] Dummy rule to fool GNU Make (ieee_division_flat_r.ap <- ieee_division_flat_r.vst)..."


layout: ieee_division_flat_r.ap

lvx:    lvx-ieee_division_flat_r
druc:   druc-ieee_division_flat_r
