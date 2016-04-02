# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/snx>" -*-

                  BOOMOPT = -A
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
            USE_SYNTHESIS = Alliance
            USE_CLOCKTREE = Yes
           LIBRARY_FAMILY = nsxlib
                USE_DEBUG = No
                     CORE = snx

                 NETLISTS = cla16       \
                            inc16       \
                            reg4        \
                            type_dec    \
                            alu16_model \
                            snx_model

 include ../etc/rules.mk

lvx:       lvx-chip_clocked_kite
druc:      druc-chip_clocked_kite
view:      cgt-chip_clocked_kite

layout:    chip_clocked_kite.ap
gds:       chip_clocked_kite.gds
