# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/xpu/phenitec>" -*-

                  TK_RTOP = ../..

                  BOOMOPT = -A
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy -split -p -O2 -neg_res
            USE_CLOCKTREE = Yes
                USE_DEBUG = No
                     CORE = xpu_core
                   MARGIN = 0.1

                 NETLISTS = add8       
#               YOSYS_TOP = /opt/yosys
#             AVERTEC_TOP = /opt/yastag

include $(TK_RTOP)/etc/mk/phlib.mk
include $(TK_RTOP)/etc/mk/alliance.mk
include $(TK_RTOP)/etc/mk/synthesis-alliance.mk
include $(TK_RTOP)/etc/mk/pr-alliance.mk
include $(TK_RTOP)/etc/mk/check-library.mk

$(CORE).vhdl:   $(CORE).nsl
	nsl2vh $(NSL2VHOPT) $(CORE).nsl


lvx:       lvx-chip_clocked_kite
druc:      druc-chip_clocked_kite
view:      cgt-chip_clocked_kite

layout:    chip_clocked_kite.ap
gds:       chip_clocked_kite.gds
