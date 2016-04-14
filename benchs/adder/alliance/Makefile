# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/adder/alliance>" -*-

                  TK_RTOP = ../..

                     CHIP = chip
                     CORE = adder
                   MARGIN = 2
                  BOOMOPT =
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
            USE_CLOCKTREE = No
                USE_DEBUG = No

                 NETLISTS = adder

 include $(TK_RTOP)/etc/mk/alliance.mk
 include $(TK_RTOP)/etc/mk/nsxlib.mk
 include $(TK_RTOP)/etc/mk/synthesis-alliance.mk
 include $(TK_RTOP)/etc/mk/pr-alliance.mk



lvx:         lvx-chip
druc:        druc-chip
dreal:       dreal-chip
flatph:      flatph-chip
view:        cgt-chip

layout:      chip.ap
gds:         chip.gds
gds_flat:    chip_flat.gds
cif:         chip.cif
