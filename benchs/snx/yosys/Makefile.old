# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/snx/yosys>" -*-

                  BOOMOPT = -A
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
            USE_SYNTHESIS = Yosys
            USE_CLOCKTREE = Yes
           LIBRARY_FAMILY = nsxlib
                USE_DEBUG = No

                 NETLISTS = snx      \
                            alu16    \
                            cla16    \
                            inc16    \
                            reg4     \
                            type_dec

 include ../../etc/rules.mk

lvx:       lvx-snx_clocked_kite
druc:      druc-snx_clocked_kite
view:      cgt-snx_clocked_kite

layout:    snx_clocked_kite.ap
gds:       snx_clocked_kite.gds
