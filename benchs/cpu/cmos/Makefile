# -*- explicit-buffer-name: "Makefile<cpu/cmos>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = nsxlib

                     CHIP = chip
                   MARGIN = 5
                  BOOMOPT =
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
            USE_CLOCKTREE = Yes
                USE_DEBUG = No
               USE_KATANA = No

                 NETLISTS = cpu

 include ./mk/design-flow.mk


layout:  chip_clocked_r.ap
gds:     chip_clocked_r.gds

lvx:     lvx-chip_clocked_r
druc:    druc-chip_clocked_r
view:    cgt-chip_clocked_r
