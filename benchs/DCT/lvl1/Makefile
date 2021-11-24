# -*- explicit-buffer-name: "Makefile<Arlet6502/cmos>" -*-

                USE_DEBUG = No

        LOGICAL_SYNTHESIS = disabled
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib
                   PLACED = Yes

                 NETLISTS = operator_lvl1_flat

 include ./mk/design-flow.mk


operator_lvl1_flat_r.vst: operator_lvl1_flat.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

operator_lvl1_flat_r.ap: operator_lvl1_flat_r.vst
	@echo "[INFO] Dummy rule to fool GNU Make (operator_lvl1_flat_r.ap <- operator_lvl1_flat_r.vst)..."


layout: operator_lvl1_flat_r.ap

lvx:    lvx-operator_lvl1_flat_r
druc:   druc-operator_lvl1_flat_r
