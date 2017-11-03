# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/xpu>" -*-

                  TK_RTOP = ../..

                   SCROPT = -l 8 -i 1000
                  BOOMOPT = -A
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy -split -p -O2 -neg_res
                     CORE = xpu_core
                     CHIP = chip64

                 NETLISTS = xpu_core

 include $(TK_RTOP)/etc/mk/alliance.mk
 include $(TK_RTOP)/etc/mk/sxlib-hibikino.mk
 include $(TK_RTOP)/etc/mk/synthesis-alliance.mk
 include $(TK_RTOP)/etc/mk/pr-hibikino.mk


lvx:       lvx-chip64
druc:      druc-chip64
#view:      cgt-chip

layout:    chip64.ap
gds:       chip64.gds
