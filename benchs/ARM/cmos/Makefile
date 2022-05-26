# -*- explicit-buffer-name: "Makefile<ARM>" -*-

       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib

                     CHIP = arm_chip
                   MARGIN = 5
                  BOOMOPT =
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
            USE_CLOCKTREE = Yes
                USE_DEBUG = No
                 USE_KITE = No

                 NETLISTS = arm_core     \
                            decod_model  \
                            decod        \
                            exec_model   \
                            exec         \
                            fifo129      \
                            fifo32       \
                            fifo72       \
                            ifetch_model \
                            ifetch       \
                            alu          \
                            mem          \
                            reg          \
                            shifter

 include ./mk/design-flow.mk


lvx:     lvx-arm_core_cts_r
druc:    druc-arm_core_cts_r
view:    cgt-arm_core_cts_r

layout:  arm_core_cts_r.ap
gds:     arm_core_cts_r.gds
