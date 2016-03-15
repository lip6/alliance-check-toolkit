

                     CORE = snx
                     CHIP = chip
                   MARGIN = 2
                  BOOMOPT =
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
        GENERATE_CORE_VST = No
            USE_CLOCKTREE = Yes
           LIBRARY_FAMILY = nsxlib
                USE_DEBUG = No

 include ../etc/rules.mk

 export         MBK_IN_LO = vst
 export        MBK_OUT_LO = vst

check:   lvx

layout:  chip_crl_clocked_kite.ap
lvx:     lvx-chip_crl_clocked_kite
druc:    druc-chip_crl_clocked_kite
gds:     chip_crl_clocked_kite.gds
view:    cgt-view-chip_crl_clocked_kite
