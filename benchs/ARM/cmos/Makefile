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


chip_r.vst: arm_core.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

chip_r.ap: chip_r.vst
	@echo "[INFO] Dummy rule to fool GNU Make (chip_r.ap <- chip_r.vst)..."


lvx:     lvx-chip_r
druc:    druc-chip_r
view:    cgt-chip_r

layout:  arm_chip_r.ap
gds:     arm_chip_r.gds
