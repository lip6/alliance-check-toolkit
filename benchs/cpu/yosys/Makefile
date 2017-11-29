# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/cpu/yosys>" -*-

                  TK_RTOP = ../..

                  BOOMOPT = -A
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
            USE_CLOCKTREE = Yes
               USE_KATANA = Yes
                USE_DEBUG = No

                 NETLISTS = cpu

 include $(TK_RTOP)/etc/mk/alliance.mk
 include $(TK_RTOP)/etc/mk/nsxlib.mk
 include $(TK_RTOP)/etc/mk/synthesis-yosys.mk
 include $(TK_RTOP)/etc/mk/pr-coriolis.mk

lvx:       lvx-cpu_clocked_kite
druc:      druc-cpu_clocked_kite
view:      cgt-cpu_clocked_kite

layout:    cpu_clocked_kite.ap
gds:       cpu_clocked_kite.gds
