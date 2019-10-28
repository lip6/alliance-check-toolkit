# -*- explicit-buffer-name: "Makefile<adder>" -*-

        LOGICAL_SYNTHESIS = Alliance
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib

                     CHIP = chip
                   MARGIN = 2
                  BOOMOPT =
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
            USE_CLOCKTREE = Yes
                USE_DEBUG = Yes
                 USE_KITE = No
                  RM_CHIP = Yes

                 NETLISTS = adder

 include ./mk/design-flow.mk


lvx:         lvx-chip_cts_r
druc:        druc-chip_cts_r
dreal:       dreal-chip_cts_r
flatph:      flatph-chip_cts_r
view:        cgt-chip_cts_r

layout:      chip_cts_r.ap
gds:         chip_cts_r.gds
gds_flat:    chip_cts_r_flat.gds
cif:         chip_cts_r.cif
