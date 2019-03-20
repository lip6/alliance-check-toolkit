# -*- explicit-buffer-name: "Makefile<snx/cmos>" -*-

        LOGICAL_SYNTHESIS = Alliance
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib

                     CHIP = chip
                   MARGIN = 5
                  BOOMOPT = -A
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy -split -p
            USE_CLOCKTREE = Yes
                USE_DEBUG = No
               USE_KATANA = No
                     CORE = snx

                 NETLISTS = cla16       \
                            inc16       \
                            reg4        \
                            type_dec    \
                            alu16_model \
                            snx_model

 include ./mk/design-flow.mk


layout:    chip_clocked_r.ap
gds:       chip_clocked_r.gds

lvx:       lvx-chip_clocked_r
druc:      druc-chip_clocked_r
view:      cgt-chip_clocked_r
