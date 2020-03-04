# -*- explicit-buffer-name: "Makefile<6502/cmos45>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib

#           YOSYS_FLATTEN = Yes
            USE_CLOCKTREE = No
                USE_DEBUG = No
                 USE_KITE = No

                 NETLISTS = alu16 \
                            add   \
                            sub
                 PATTERNS = alu16_r


 include ./mk/design-flow.mk


blif:      alu16.blif
vst:       alu16.vst
layout:    alu16_r.ap
gds:       alu16_r.gds

lvx:       lvx-alu16_r
druc:      druc-alu16_r
view:      cgt-alu16_r
sim:       asimut-alu16_r
