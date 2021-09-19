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


CLEAN_CUSTOM = $(foreach ext, .vst .spi, $(addsuffix $(ext),$(NETLISTS)))

$(CHIP)_r.vst: coeur.vst $(NETLISTS_VST)
	-$(call scl_cols,$(call c2env, cgt -tV --script=doDesign))

$(CHIP)_r.ap: $(CHIP)_r.vst

lvx:     lvx-$(CHIP)_r
druc:    druc-$(CHIP)_r
view:    cgt-$(CHIP)_r

layout:  $(CHIP)_r.ap
gds:     $(CHIP)_r.gds
