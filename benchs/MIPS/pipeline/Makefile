# -*- explicit-buffer-name: "Makefile<MIPS/pipeline>" -*-

       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib

                   PLACED = Yes
            USE_CLOCKTREE = No
                USE_DEBUG = No
                 USE_KITE = No


 include ./mk/design-flow.mk



mips_r3000_1m_core_flat_r.vst: mips_r3000_1m_core_flat.vst mips_r3000_1m_core_flat.ap
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

mips_r3000_1m_core_flat_r.ap: mips_r3000_1m_core_flat_r.vst
	@echo "[INFO] Dummy rule to fool GNU Make (mips_r3000_1m_core_flat_r.ap <- mips_r3000_1m_core_flat_r.vst)..."


layout:  mips_r3000_1m_core_flat_r.ap
gds:     mips_r3000_1m_core_flat_r.gds

lvx:     lvx-mips_r3000_1m_core_flat_r
druc:    druc-mips_r3000_1m_core_flat_r
view:    cgt-mips_r3000_1m_core_flat_r

