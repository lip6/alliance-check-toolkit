# -*- explicit-buffer-name: "Makefile<Arlet6502/cmos>" -*-

                USE_DEBUG = No

        LOGICAL_SYNTHESIS = disabled
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib
                   PLACED = Yes

               CUSTOM_LIB = ../efpgalib
                 NETLISTS = fft_flat

 include ./mk/design-flow.mk


fft_flat_r.vst: fft_flat.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

fft_flat_r.ap: fft_flat_r.vst
	@echo "[INFO] Dummy rule to fool GNU Make (fft_flat_r.ap <- fft_flat_r.vst)..."


layout: fft_flat_r.ap

lvx:    lvx-fft_flat_r
druc:   druc-fft_flat_r
