# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/snx>" -*-

                  TK_RTOP = ..

                  BOOMOPT = -A
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy -split -p
            USE_CLOCKTREE = Yes
                USE_DEBUG = No
               USE_KATANA = No
                     CORE = snx

                 NETLISTS = cla16       \
                            inc16       \
                            reg4        \
                            type_dec    \
                            alu16_model \
                            snx_model

 include $(TK_RTOP)/etc/mk/alliance.mk
#include $(TK_RTOP)/etc/mk/nsxlib.mk
 include $(TK_RTOP)/etc/mk/sxlib.mk
 include $(TK_RTOP)/etc/mk/synthesis-alliance.mk
 include $(TK_RTOP)/etc/mk/pr-coriolis.mk

lvx-snx:   lvx-snx_clocked_kite
druc-snx:  druc-snx_clocked_kite

lvx:       lvx-chip_clocked_kite
druc:      druc-chip_clocked_kite
view:      cgt-chip_clocked_kite

layout:    chip_clocked_kite.ap
gds:       chip_clocked_kite.gds
