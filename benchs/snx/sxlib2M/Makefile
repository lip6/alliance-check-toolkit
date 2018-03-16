# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/snx>" -*-

                  TK_RTOP = ../..

            USE_CLOCKTREE = No
                USE_DEBUG = No
               USE_KATANA = Yes

                 NETLISTS = snx         \
                            cla16       \
                            inc16       \
                            alu16       \
                            reg4        \
                            type_dec    \
                            alu16_model \
                            snx_model

 include $(TK_RTOP)/etc/mk/alliance.mk
 include $(TK_RTOP)/etc/mk/nsxlib.mk
#include $(TK_RTOP)/etc/mk/sxlib.mk
 include $(TK_RTOP)/etc/mk/synthesis-yosys.mk
 include $(TK_RTOP)/etc/mk/pr-coriolis.mk

lvx:   lvx-snx_kite
druc:  druc-snx_kite
