# -*- explicit-buffer-name: "Makefile<nMigen/alu_hier/cmos>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = nsxlib

            YOSYS_FLATTEN = No
                VST_FLAGS = --vst-use-concat
            USE_CLOCKTREE = No
                USE_DEBUG = No
                 USE_KITE = No

                 NETLISTS = alu_hier \
                            add      \
                            sub


 include ./mk/design-flow.mk


blif:      alu_hier.blif
vst:       alu_hier.vst
layout:    alu_hier_r.ap
gds:       alu_hier_r.gds

lvx:       lvx-alu_hier_r
druc:      druc-alu_hier_r
view:      cgt-alu_hier_r
graal:     graal-alu_hier_r
