# -*- explicit-buffer-name: "Makefile<AM2901/standard_cells>" -*-

       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib

                     CHIP = am2901
                  RM_CHIP = Yes
                   MARGIN = 5
                  BOOMOPT =
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
            USE_CLOCKTREE = Yes
                USE_DEBUG = No
                 USE_KITE = No

                 NETLISTS = coeur   \
                            accu    \
                            alu     \
                            muxe    \
                            muxs    \
                            ram

 include ./mk/design-flow.mk


am2901_r.vst: coeur.vst
	-$(call scl_cols,$(call c2env, cgt -tV --script=doDesign))

am2901_r.ap: am2901_r.vst

lvx:     lvx-am2901_r
druc:    druc-am2901_r
view:    cgt-am2901_r

layout:  am2901_r.ap
gds:     am2901_r.gds
