# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/cpu/alliance>" -*-

                  TK_RTOP = ../..

                     CHIP = chip
                     CORE = cpu
                   MARGIN = 2
                  BOOMOPT = -A
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
                USE_DEBUG = No

                 NETLISTS = cpu

 include $(TK_RTOP)/etc/mk/alliance.mk
 include $(TK_RTOP)/etc/mk/nsxlib.mk
 include $(TK_RTOP)/etc/mk/synthesis-alliance.mk
 include $(TK_RTOP)/etc/mk/pr-alliance.mk


lvx:       lvx-chip
druc:      druc-chip
view:      cgt-chip

layout:    chip.ap
gds:       chip.gds
