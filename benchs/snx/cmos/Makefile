# -*- explicit-buffer-name: "Makefile<snx/cmos>" -*-

        LOGICAL_SYNTHESIS = Alliance
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib

                     CHIP = chip
	                 CORE = snx
                   MARGIN = 5
                  BOOMOPT = -A
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy -split -p
            USE_CLOCKTREE = Yes
                USE_DEBUG = No
                 USE_KITE = No

                 NETLISTS = snx_model   \
                            cla16       \
                            inc16       \
                            reg4        \
                            type_dec    \
                            alu16_model

 include ./mk/design-flow.mk

synth:     $(NETLISTS_VST)

layout:    chip_cts_r.ap
gds:       chip_cts_r.gds

lvx:       lvx-chip_cts_r
druc:      druc-chip_cts_r
view:      cgt-chip_cts_r
