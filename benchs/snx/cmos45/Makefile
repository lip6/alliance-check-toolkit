# -*- explicit-buffer-name: "Makefile<snx/cmos45>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = nsxlib45

            USE_CLOCKTREE = Yes
                USE_DEBUG = No
                 USE_KITE = No

                 NETLISTS = snx      \
                            alu16    \
                            cla16    \
                            inc16    \
                            reg4     \
                            type_dec

 include ./mk/design-flow.mk


snx_cts_r.vst: snx.vst
	-$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

snx_cts_r.ap: snx_cts_r.vst
	@echo "Fake rule to avoid making the P&R twice..."

vst:       snx.vst
layout:    snx_cts_r.ap
gds:       snx_cts_r.gds

lvx:       lvx-snx_cts_r
druc:      druc-snx_cts_r
view:      cgt-snx_cts_r
