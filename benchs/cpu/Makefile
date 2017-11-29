# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/cpu>" -*-

                  TK_RTOP = ..

                  BOOMOPT = -A
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
            USE_CLOCKTREE = Yes
                USE_DEBUG = No

                 NETLISTS = cpu

 include $(TK_RTOP)/etc/mk/alliance.mk
 include $(TK_RTOP)/etc/mk/nsxlib.mk
 include $(TK_RTOP)/etc/mk/synthesis-alliance.mk
 include $(TK_RTOP)/etc/mk/pr-coriolis.mk

lvx-cpu:   lvx-cpu_clocked_kite
druc-cpu:  druc-cpu_clocked_kite

lvx:       lvx-chip_clocked_kite
druc:      druc-chip_clocked_kite
view:      cgt-view-chip_clocked_kite

layout:    chip_clocked_kite.ap
gds:       chip_clocked_kite.gds
