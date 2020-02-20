# -*- explicit-buffer-name: "Makefile<nMigen/test_part_add/cmos>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = nsxlib

            YOSYS_FLATTEN = No
                VST_FLAGS = --vst-use-concat
            USE_CLOCKTREE = No
                USE_DEBUG = No
                 USE_KITE = No

                 NETLISTS = test_part_add \
                            ripple        \
                            add1


 include ./mk/design-flow.mk


blif:      test_part_add.blif
vst:       test_part_add.vst
layout:    test_part_add_r.ap
gds:       test_part_add_r.gds

lvx:       lvx-test_part_add_r
druc:      druc-test_part_add_r
view:      cgt-test_part_add_r
graal:     graal-test_part_add_r
