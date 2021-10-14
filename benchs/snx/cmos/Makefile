# -*- explicit-buffer-name: "Makefile<snx/cmos>" -*-

        LOGICAL_SYNTHESIS = Alliance
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib

                     CHIP = chip
                     CORE = snx
                   MARGIN = 5
                  BOOMOPT = -A
                  BOOGOPT =
                  LOONOPT = -m 0
                NSL2VHOPT = -vasy -split -p
            USE_CLOCKTREE = Yes
                USE_DEBUG = No
                 USE_KITE = No
                  RM_CHIP = Yes

                 NETLISTS = snx_model   \
                            cla16       \
                            inc16       \
                            reg4        \
                            type_dec    \
                            alu16_model

 include ./mk/design-flow.mk

 
chip_r.vst: synth
	-$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

chip_r.ap: chip_r.vst

synth:     $(NETLISTS_VST)

layout:    chip_r.ap
gds:       chip_r.gds

lvx:       lvx-chip_r
druc:      druc-chip_r
view:      cgt-chip_r
