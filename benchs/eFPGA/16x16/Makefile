# -*- explicit-buffer-name: "Makefile<Arlet6502/cmos>" -*-

                USE_DEBUG = No

        LOGICAL_SYNTHESIS = disabled
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib

               CUSTOM_LIB = ../efpgalib
                 NETLISTS = matrix_16_16_flat

 include ./mk/design-flow.mk


matrix_16_16_flat_r.vst: matrix_16_16_flat.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

matrix_16_16_flat_r.ap: matrix_16_16_flat_r.vst
	@echo "[INFO] Dummy rule to fool GNU Make (matrix_16_16_flat_r.ap <- matrix_16_16_flat_r.vst)..."


layout: matrix_16_16_flat_r.ap

lvx:    lvx-matrix_16_16_flat_r
druc:   druc-matrix_16_16_flat_r
