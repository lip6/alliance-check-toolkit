# -*- explicit-buffer-name: "Makefile<nMigen/alu/cmos>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = nsxlib

#           YOSYS_FLATTEN = Yes
            USE_CLOCKTREE = No
                USE_DEBUG = No
                 USE_KITE = No

                 NETLISTS = alu


 include ./mk/design-flow.mk


blif:      alu.blif
vst:       alu.vst
layout:    alu_r.ap
gds:       alu_r.gds

lvx:       lvx-alu_r
druc:      druc-alu_r
view:      cgt-alu_r
graal:     graal-alu_r
