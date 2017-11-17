# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/adder>" -*-

                  TK_RTOP = ..

                     CHIP = chip
                   MARGIN = 2
                  BOOMOPT =
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
            USE_CLOCKTREE = No
                USE_DEBUG = Yes
               USE_KATANA = No

                 NETLISTS = adder

 include $(TK_RTOP)/etc/mk/alliance.mk
 include $(TK_RTOP)/etc/mk/nsxlib.mk
#include $(TK_RTOP)/etc/mk/sxlib.mk
 include $(TK_RTOP)/etc/mk/synthesis-alliance.mk
 include $(TK_RTOP)/etc/mk/pr-coriolis.mk


lvx:         lvx-chip_kite
druc:        druc-chip_kite
dreal:       dreal-chip_kite
flatph:      flatph-chip_kite
view:        cgt-chip_kite

layout:      chip_kite.ap
gds:         chip_kite.gds
gds_flat:    chip_kite_flat.gds
cif:         chip_kite.cif
