# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/comet>" -*-

                  TK_RTOP = ..

                  BOOMOPT = -A
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
            USE_CLOCKTREE = Yes
                USE_DEBUG = No

                 NETLISTS = comet   \
                            alu16   \
                            cla16   \
                            inc16   \
                            reg16   \
                            shift16

 include $(TK_RTOP)/etc/mk/alliance.mk
 include $(TK_RTOP)/etc/mk/nsxlib.mk
 include $(TK_RTOP)/etc/mk/synthesis-yosys.mk
 include $(TK_RTOP)/etc/mk/pr-coriolis.mk


lvx:       lvx-comet_clocked_kite
druc:      druc-comet_clocked_kite
view:      cgt-comet_clocked_kite

layout:    comet_clocked_kite.ap
gds:       comet_clocked_kite.gds
