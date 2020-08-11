# -*- explicit-buffer-name: "Makefile<6502/cmos45>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib

#           YOSYS_FLATTEN = Yes
            USE_CLOCKTREE = Yes
                USE_DEBUG = No
                 USE_KITE = No
#               VST_FLAGS = --vst-no-linkage

                 NETLISTS = m65s   \
                            alu65  \
                            cpa8   \
                            decadj \
                            inc16


 include ./mk/design-flow.mk


blif:      m65s.blif
vst:       m65s.vst
layout:    m65s_cts_r.ap
gds:       m65s_cts_r.gds

lvx:       lvx-m65s_cts_r
druc:      druc-m65s_cts_r
view:      cgt-m65s_cts_r
viewn:     cgt-m65s
