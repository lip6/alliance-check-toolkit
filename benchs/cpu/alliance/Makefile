# -*- explicit-buffer-name: "Makefile<cpu/alliance>" -*-

        LOGICAL_SYNTHESIS = Alliance
       PHYSICAL_SYNTHESIS = Alliance
               DESIGN_KIT = nsxlib

                     CHIP = chip
                   MARGIN = 5
                  BOOMOPT =
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
            USE_CLOCKTREE = No
                USE_DEBUG = No
               USE_KATANA = No

                 NETLISTS = cpu

 include ./mk/design-flow.mk


layout:    chip.ap
gds:       chip.gds

lvx:       lvx-chip
druc:      druc-chip
view:      cgt-chip
