# -*- explicit-buffer-name: "Makefile<pop11>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = nsxlib45

                NSL2VHOPT = -vasy
            USE_CLOCKTREE = Yes
                USE_DEBUG = No
               USE_KATANA = Yes

                 NETLISTS = pop11     \
                            alu11     \
                            bittest   \
                            cla16     \
                            cla4      \
                            cnt4      \
                            cnt_inc4  \
                            data11    \
                            idc

 include ./mk/design-flow.mk

blif:      pop11.blif
layout:    pop11_clocked_r.ap
gds:       pop11_clocked_r.gds

lvx:       lvx-pop11_clocked_r
druc:      druc-pop11_clocked_r
view:      cgt-pop11_clocked_r
