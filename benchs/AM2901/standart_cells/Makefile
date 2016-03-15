# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/AM2901>" -*-

                     CORE = coeur
                     CHIP = amd2901
                   MARGIN = 2
        GENERATE_CORE_VST = No
              USE_STRATUS = No
            USE_CLOCKTREE = Yes
                USE_DEBUG = No

 include ../../etc/rules.mk

 export         MBK_IN_LO = vst
 export        MBK_OUT_LO = vst


check:   lvx

layout:  amd2901_crl_clocked_kite.ap
lvx:     lvx-amd2901_crl_clocked_kite
druc:    druc-amd2901_crl_clocked_kite
gds:     amd2901_crl_clocked_kite.gds
view:    cgt-view-amd2901_crl_clocked_kite
