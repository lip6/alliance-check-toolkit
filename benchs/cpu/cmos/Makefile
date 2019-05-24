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
                 USE_KITE = No

                 NETLISTS = cpu

 include ./mk/design-flow.mk


layout:  chip_htck_r.ap
gds:     chip_htck_r.gds

lvx:     lvx-chip_htck_r
druc:    druc-chip_htck_r
view:    cgt-chip_htck_r
