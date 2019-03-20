# -*- explicit-buffer-name: "Makefile<snx/cmos>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib

            USE_CLOCKTREE = No
                USE_DEBUG = No
               USE_KATANA = Yes

                 NETLISTS = snx         \
                            alu16       \
                            cla16       \
                            inc16       \
                            reg4        \
                            type_dec    \
                            alu16_model \
                            snx_model

 include ./mk/design-flow.mk


blif:      snx.blif
layout:    snx_r.ap
gds:       snx_r.gds

lvx:       lvx-snx_r
druc:      druc-snx_r
view:      cgt-snx_r
