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
                 USE_KITE = No

                 NETLISTS = cpu

 include ./mk/design-flow.mk


layout:  cpu_htck_r.ap
gds:     cpu_htck_r.gds

lvx:     lvx-cpu_htck_r
druc:    druc-cpu_htck_r
view:    cgt-cpu_htck_r
