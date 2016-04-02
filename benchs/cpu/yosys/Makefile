# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/cpu/yosys>" -*-

                  BOOMOPT = -A
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
            USE_SYNTHESIS = Yosys
            USE_CLOCKTREE = Yes
           LIBRARY_FAMILY = nsxlib
                USE_DEBUG = No

                 NETLISTS = cpu

 include ../../etc/rules.mk

lvx:       lvx-cpu_clocked_kite
druc:      druc-cpu_clocked_kite
view:      cgt-cpu_clocked_kite

layout:    cpu_clocked_kite.ap
gds:       cpu_clocked_kite.gds
