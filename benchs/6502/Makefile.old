# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/snx>" -*-

                NSL2VHOPT = 
            USE_SYNTHESIS = Yosys
            USE_CLOCKTREE = Yes
           LIBRARY_FAMILY = nsxlib
                USE_DEBUG = No

                 NETLISTS = m65s

 include ../etc/rules.mk

lvx:       lvx-m65s_clocked_kite
druc:      druc-m65s_clocked_kite
view:      cgt-m65s_clocked_kite

layout:    m65s_clocked_kite.ap
gds:       m65s_clocked_kite.gds
