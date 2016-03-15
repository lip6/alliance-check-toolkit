# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/AM2901>" -*-

                     CHIP = amd2901
                  CONTROL = amd2901_ctl
                   MARGIN = 2
        GENERATE_CORE_VST = No
              USE_STRATUS = Yes
            USE_CLOCKTREE = No
                USE_DEBUG = No

 include ../../etc/rules.mk

 export         MBK_IN_LO = vst
 export        MBK_OUT_LO = vst


check:   lvx

layout:  amd2901_chip_kite.ap
lvx:     lvx-amd2901_chip_kite
druc:    druc-amd2901_chip_kite
gds:     amd2901_chip_kite.gds
view:    cgt-view-amd2901_chip_kite

