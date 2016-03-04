# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/adder>" -*-

                     CORE = adder
                     CHIP = chip
                   MARGIN = 2
                  BOOMOPT =
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
        GENERATE_CORE_VST = Yes
            USE_CLOCKTREE = No
                USE_MOSIS = Yes
                USE_DEBUG = No

 include ../etc/rules.mk

 export         MBK_IN_LO = vst
 export        MBK_OUT_LO = vst


check:       lvx

layout:      chip_crl_kite.ap
flatph:      flatph-chip_crl_kite
lvx:         lvx-chip_crl_kite
druc:        druc-chip_crl_kite
gds:         chip_crl_kite.gds
gds_flat:    chip_crl_kite_flat.gds
cif:         chip_crl_kite.cif
view:        cgt-view-chip_crl_kite
dreal:       dreal-chip_crl_kite

layout-alc:  chip_alc.ap
lvx-alc:     lvx-chip_alc
druc-alc:    druc-chip_alc
