# -*- explicit-buffer-name: "Makefile<comet>" -*-


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

                 NETLISTS = comet   \
                            alu16   \
                            cla16   \
                            inc16   \
                            reg16   \
                            shift16

 include ./mk/design-flow.mk


layout:    comet_htck_r.ap
gds:       comet_htck_r.gds

lvx:       lvx-comet_htck_r
druc:      druc-comet_htck_r
view:      cgt-comet_htck_r
