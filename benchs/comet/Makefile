# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/comet/yosys>" -*-

                  BOOMOPT = -A
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
            USE_SYNTHESIS = Yosys
            USE_CLOCKTREE = Yes
           LIBRARY_FAMILY = nsxlib
                USE_DEBUG = No

                 NETLISTS = comet   \
                            alu16   \
                            cla16   \
                            inc16   \
                            reg16   \
                            shift16

 include ../etc/rules.mk

lvx:       lvx-comet_clocked_kite
druc:      druc-comet_clocked_kite
view:      cgt-comet_clocked_kite

layout:    comet_clocked_kite.ap
gds:       comet_clocked_kite.gds
