# -*- explicit-buffer-name: "Makefile<AM2901>" -*-

       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib

                     CHIP = amd2901
                   MARGIN = 5
                  BOOMOPT =
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
            USE_CLOCKTREE = Yes
                USE_DEBUG = No
               USE_KATANA = No

                 NETLISTS = accu    \
                            alu     \
                            amd2901 \
                            coeur   \
                            muxe    \
                            muxs    \
                            ram

 include ./mk/design-flow.mk


lvx:     lvx-amd2901_clocked_r
druc:    druc-amd2901_clocked_r
view:    cgt-amd2901_clocked_r

layout:  amd2901_clocked_r.ap
gds:     amd2901_clocked_r.gds
