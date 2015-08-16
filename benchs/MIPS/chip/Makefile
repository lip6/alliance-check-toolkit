# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/AM2901>" -*-

                     CHIP = mips_r3000_1m
                  CONTROL = mips_r3000_1m_ct
                   MARGIN = 2
        GENERATE_CORE_VST = No
              USE_STRATUS = Yes
            USE_CLOCKTREE = No
                USE_MOSIS = No
                USE_DEBUG = No

 include ../../etc/rules.mk

 export         MBK_IN_LO = vst
 export        MBK_OUT_LO = vst
 export            RDS_IN = gds
 export           RDS_OUT = gds


check:   lvx

layout:  mips_r3000_1m_chip_kite.ap
lvx:     lvx-mips_r3000_1m_chip_kite
druc:    druc-mips_r3000_1m_chip_kite
gds:     mips_r3000_1m_chip_kite.gds
view:    cgt-view-mips_r3000_1m_chip_kite

