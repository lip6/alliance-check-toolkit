# -*- explicit-buffer-name: "Makefile<cpu/cmos>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = nsxlib45

                   MARGIN = 10
                  BOOMOPT =
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
            USE_CLOCKTREE = Yes
                USE_DEBUG = No
               USE_KATANA = Yes

                 NETLISTS = cpu

 include ./mk/design-flow.mk


layout:  cpu_clocked_r.ap
gds:     cpu_clocked_r.gds

lvx:     lvx-cpu_clocked_r
druc:    druc-cpu_clocked_r
view:    cgt-cpu_clocked_r
