# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/MIPS/microprogrammed>" -*-

                     CORE = mips_core_flat
                CORE_ONLY = Yes
        GENERATE_CORE_VST = No
              USE_STRATUS = No
            USE_CLOCKTREE = No
                USE_DEBUG = No

 include ../../etc/rules.mk

 export         MBK_IN_LO = vst
 export        MBK_OUT_LO = vst


check:   lvx

layout:  mips_core_flat_kite.ap
lvx:     lvx-mips_core_flat_kite
druc:    druc-mips_core_flat_kite
gds:     mips_core_flat_kite.gds
view:    cgt-view-mips_core_flat_kite

