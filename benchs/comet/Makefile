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
               USE_KATANA = Yes

                 NETLISTS = comet   \
                            alu16   \
                            cla16   \
                            inc16   \
                            reg16   \
                            shift16

 include ./mk/design-flow.mk


layout:    comet_clocked_r.ap
gds:       comet_clocked_r.gds

lvx:       lvx-comet_clocked_r
druc:      druc-comet_clocked_r
view:      cgt-comet_clocked_r
