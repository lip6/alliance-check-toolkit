# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/AM2901/datapath>" -*-

                  TK_RTOP = ../..

              USE_STRATUS = Yes
            USE_CLOCKTREE = No
                USE_DEBUG = No
               USE_KATANA = No

                 NETLISTS = amd2901_ctl

 include $(TK_RTOP)/etc/mk/alliance.mk
 include $(TK_RTOP)/etc/mk/sxlib.mk
 include $(TK_RTOP)/etc/mk/synthesis-disabled.mk
 include $(TK_RTOP)/etc/mk/pr-coriolis.mk



lvx:     lvx-amd2901_kite
druc:    druc-amd2901_kite
view:    cgt-amd2901_kite

layout:  amd2901_kite.ap
gds:     amd2901_kite.gds

# gmake 3.81 implicit rule recursion workaround
amd2901_ctl.vst: non_generated/amd2901_ctl.vst
	cp non_generated/amd2901_ctl.vst .
