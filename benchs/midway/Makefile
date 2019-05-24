# -*- explicit-buffer-name: "Makefile<midway>" -*-


        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = cmos45

                  BOOMOPT = -A
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
            USE_CLOCKTREE = Yes
                USE_DEBUG = No
                 USE_KITE = No

                 NETLISTS = midway


 include ./mk/design-flow.mk


layout:    midway_htck_r.ap
gds:       midway_htck_r.gds

lvx:       lvx-midway_htck_r
druc:      druc-midway_htck_r
view:      cgt-midway_htck_r
