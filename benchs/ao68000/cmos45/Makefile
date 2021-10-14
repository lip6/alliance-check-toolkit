# -*- explicit-buffer-name: "Makefile<6502/cmos45>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = cmos45

            YOSYS_FLATTEN = ao68000
            YOSYS_SET_TOP = Yes
            USE_CLOCKTREE = Yes
                USE_DEBUG = No
                 USE_KITE = No

                 NETLISTS = ao68000


 include ./mk/design-flow.mk

ao68000_cts_r.vst: ao68000.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

ao68000_cts_r.ap: ao68000_cts_r.vst
	@echo "[INFO] Dummy rule to fool GNU Make (ao68000_cts_r.ap <- ao68000_cts_r.vst)..."


blif:   ao68000.blif
vst:    ao68000.vst
layout: ao68000_cts_r.ap
gds:    ao68000_cts_r.gds

lvx:    lvx-ao68000_cts_r
druc:   druc-ao68000_cts_r
view:   cgt-ao68000_cts_r
