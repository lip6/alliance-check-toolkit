# -*- explicit-buffer-name: "Makefile<Arlet6502/cmos>" -*-

                USE_DEBUG = No
             USE_VALGRIND = No

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib

                 NETLISTS = Arlet6502 \
                            alu       \
                            cpu

 include ./mk/design-flow.mk


arlet6502_cts_r.vst: arlet6502.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

arlet6502_cts_r.ap: arlet6502_cts_r.vst
	@echo "[INFO] Dummy rule to fool GNU Make (arlet6502_cts_r.ap <- arlet6502_cts_r.vst)..."


blif:   Arlet6502.blif
vst:    arlet6502.vst
layout: arlet6502_cts_r.ap

lvx:    lvx-arlet6502_cts_r
druc:   druc-arlet6502_cts_r
