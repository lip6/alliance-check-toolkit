# -*- explicit-buffer-name: "Makefile<MIPS/microprogrammed>" -*-


       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib

                   PLACED = Yes
            USE_CLOCKTREE = No
                USE_DEBUG = No
                 USE_KITE = No

 include ./mk/design-flow.mk


mips_core_flat_r.vst: mips_core_flat.vst mips_core_flat.ap
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

mips_core_flat_r.ap: mips_core_flat_r.vst
	@echo "[INFO] Dummy rule to fool GNU Make (mips_core_flat_r.ap <- mips_core_flat_r.vst)..."



layout:  mips_core_flat_r.ap
gds:     mips_core_flat_r.gds

lvx:     lvx-mips_core_flat_r
druc:    druc-mips_core_flat_r
view:    cgt-mips_core_flat_r
