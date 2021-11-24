# -*- explicit-buffer-name: "Makefile<Arlet6502/cmos>" -*-

                USE_DEBUG = No

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib

                 NETLISTS = matrix_4_8_flat

 include ./mk/design-flow.mk


matrix_4_8_flat_cts_r.vst: matrix_4_8_flat.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

matrix_4_8_flat_cts_r.ap: matrix_4_8_flat_cts_r.vst
	@echo "[INFO] Dummy rule to fool GNU Make (matrix_4_8_flat_cts_r.ap <- matrix_4_8_flat_cts_r.vst)..."


layout: matrix_4_8_flat_cts_r.ap

lvx:    lvx-matrix_4_8_flat_cts_r
druc:   druc-matrix_4_8_flat_cts_r
