# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/AM2901>" -*-

                     CHIP = amd2901
                   MARGIN = 2
            USE_SYNTHESIS = No
            USE_CLOCKTREE = Yes
                USE_DEBUG = No

                 NETLISTS = accu    \
                            alu     \
                            amd2901 \
                            coeur   \
                            muxe    \
                            muxs    \
                            ram

 include ../../etc/rules.mk

lvx:     lvx-amd2901_clocked_kite
druc:    druc-amd2901_clocked_kite
view:    cgt-amd2901_clocked_kite

layout:  amd2901_clocked_kite.ap
gds:     amd2901_clocked_kite.gds
