# -*- explicit-buffer-name: "Makefile<Arlet6502/cmos>" -*-

                USE_DEBUG = No

        LOGICAL_SYNTHESIS = disabled
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib
                   PLACED = Yes

               CUSTOM_LIB = ../efpgalib
                 NETLISTS = matrix_8_8_flat

 include ./mk/design-flow.mk


matrix_8_8_flat_r.vst: matrix_8_8_flat.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

matrix_8_8_flat_r.ap: matrix_8_8_flat_r.vst
	@echo "[INFO] Dummy rule to fool GNU Make (matrix_8_8_flat_r.ap <- matrix_8_8_flat_r.vst)..."


layout: matrix_8_8_flat_r.ap

lvx:    lvx-matrix_8_8_flat_r
druc:   druc-matrix_8_8_flat_r
