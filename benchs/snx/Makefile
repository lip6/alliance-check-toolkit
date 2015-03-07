# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/snx>" -*-

                     CORE = snx
                     CHIP = chip
                   MARGIN = 2
                  BOOMOPT =
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
        GENERATE_CORE_VST = No
            USE_CLOCKTREE = Yes
                USE_MOSIS = Yes
                USE_DEBUG = No

 include ../etc/rules.mk

 export         MBK_IN_LO = vst
 export        MBK_OUT_LO = vst
 export            RDS_IN = gds
 export           RDS_OUT = gds

check:    lvx

lvx:      lvx-chip_crl_clocked_kite
druc:     druc-chip_crl_clocked_kite
gds:      chip_crl_clocked_kite.gds
view:     cgt-view-chip_crl_clocked_kite
