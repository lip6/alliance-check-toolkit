# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/snx/yosys>" -*-

                  TK_RTOP = ../..

                  BOOMOPT = -A
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
            USE_CLOCKTREE = Yes
                USE_DEBUG = No

                 NETLISTS = snx      \
                            alu16    \
                            cla16    \
                            inc16    \
                            reg4     \
                            type_dec

 include $(TK_RTOP)/etc/mk/alliance.mk
 include $(TK_RTOP)/etc/mk/nsxlib.mk
 include $(TK_RTOP)/etc/mk/synthesis-yosys.mk
 include $(TK_RTOP)/etc/mk/pr-coriolis.mk


lvx:       lvx-snx_clocked_kite
druc:      druc-snx_clocked_kite
view:      cgt-snx_clocked_kite

layout:    snx_clocked_kite.ap
gds:       snx_clocked_kite.gds
