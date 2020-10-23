# -*- explicit-buffer-name: "Makefile<adder>" -*-

        LOGICAL_SYNTHESIS = Alliance
       PHYSICAL_SYNTHESIS = Coriolis
              #DESIGN_KIT = cmos45
               DESIGN_KIT = sxlib

                     CHIP = chip
                   MARGIN = 2
                  BOOMOPT =
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
            USE_CLOCKTREE = Yes
                USE_DEBUG = No
                 USE_KITE = No
                  RM_CHIP = Yes

                 NETLISTS = adder

 include ./mk/design-flow.mk


chip_r.vst: adder.vst
	-$(call scl_cols,$(call c2env, cgt -tV --script=doDesign))

chip_r.ap: chip_r.vst

lvx:         lvx-chip_r
druc:        druc-chip_r
dreal:       dreal-chip_r
flatph:      flatph-chip_r
view:        cgt-chip_r

layout:      chip_r.ap
gds:         chip_r.gds
gds_flat:    chip_r_flat.gds
cif:         chip_r.cif
