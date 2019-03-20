# -*- explicit-buffer-name: "Makefile<snx/c35b4>" -*-


        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = c35b4

            USE_CLOCKTREE = Yes
                USE_DEBUG = No
               USE_KATANA = Yes

                 NETLISTS = snx      \
                            alu16    \
                            cla16    \
                            inc16    \
                            reg4     \
                            type_dec

 include ./mk/design-flow.mk


blif:      snx.blif
layout:    snx_clocked_r.ap
gds:       snx_clocked_r.gds

lvx:       lvx-snx_clocked_r
druc:      druc-snx_clocked_r
view:      cgt-snx_clocked_r
