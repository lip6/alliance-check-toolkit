# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/pop11/yosys>" -*-

                  TK_RTOP = ..

                  BOOMOPT = -A
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
            USE_CLOCKTREE = Yes
                USE_DEBUG = No

                 NETLISTS = pop11     \
                            alu11     \
                            bittest   \
                            cla16     \
                            cla4      \
                            cnt4      \
                            cnt_inc4  \
                            data11    \
                            idc

 include $(TK_RTOP)/etc/mk/alliance.mk
 include $(TK_RTOP)/etc/mk/nsxlib.mk
 include $(TK_RTOP)/etc/mk/synthesis-yosys.mk
 include $(TK_RTOP)/etc/mk/pr-coriolis.mk


lvx:       lvx-pop11_clocked_kite
druc:      druc-pop11_clocked_kite
view:      cgt-pop11_clocked_kite

layout:    pop11_clocked_kite.ap
gds:       pop11_clocked_kite.gds
