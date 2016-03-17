# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/MIPS/chip>" -*-

                     CHIP = mips_r3000_1m
                  CONTROL = mips_r3000_1m_ct
                   MARGIN = 2
        GENERATE_CORE_VST = No
              USE_STRATUS = Yes
            USE_CLOCKTREE = No
                USE_DEBUG = No

 include ../../etc/rules.mk


check:   lvx

layout:  mips_r3000_1m_chip_kite.ap
lvx:     lvx-mips_r3000_1m_chip_kite
druc:    druc-mips_r3000_1m_chip_kite
gds:     mips_r3000_1m_chip_kite.gds
view:    cgt-view-mips_r3000_1m_chip_kite

