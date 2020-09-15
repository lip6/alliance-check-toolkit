# -*- explicit-buffer-name: "Makefile<nmigen/ALU16>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib

            USE_CLOCKTREE = No
                USE_DEBUG = No
                 USE_KITE = No

                 NETLISTS = alu16 \
                            add   \
                            sub
                 PATTERNS = alu16_r


 include ./mk/design-flow.mk


alu16_r.ap alu16_r.vst: alu16.vst
	-@echo "Overriding rules to generate layout by doAlu16.py custom script."
	-$(call scl_cols,$(call c2env, ./doAlu16.py))


blif:      alu16.blif
vst:       alu16.vst
layout:    alu16_r.ap
gds:       alu16_r.gds

lvx:       lvx-alu16_r
druc:      druc-alu16_r
view:      cgt-alu16_r
sim:       asimut-alu16_r
