# -*- explicit-buffer-name: "Makefile<6502/cmos45>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = cmos45

            USE_CLOCKTREE = Yes
                USE_DEBUG = No
                 USE_KITE = No

                 NETLISTS = m65s   \
                            alu65  \
                            cpa8   \
                            decadj \
                            inc16


 include ./mk/design-flow.mk


m65s_cts_r.vst: m65s.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

m65s_cts_r.ap: m65s_cts_r.vst
	@echo "[INFO] Dummy rule to fool GNU Make (m65s_cts_r.ap <- m65s_cts_r.vst)..."


blif:      m65s.blif
vst:       m65s.vst
layout:    m65s_cts_r.ap
gds:       m65s_cts_r.gds

lvx:       lvx-m65s_cts_r
druc:      druc-m65s_cts_r
view:      cgt-m65s_cts_r
