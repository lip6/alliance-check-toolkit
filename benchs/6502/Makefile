# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/snx>" -*-

                  TK_RTOP = ..

                NSL2VHOPT = 
            USE_CLOCKTREE = Yes
                USE_DEBUG = No

                 NETLISTS = m65s   \
                            alu65  \
                            cpa8   \
                            decadj \
                            inc16

 include $(TK_RTOP)/etc/mk/alliance.mk
 include $(TK_RTOP)/etc/mk/nsxlib.mk
 include $(TK_RTOP)/etc/mk/synthesis-yosys.mk
 include $(TK_RTOP)/etc/mk/pr-coriolis.mk


lvx:       lvx-m65s_clocked_kite
druc:      druc-m65s_clocked_kite
view:      cgt-m65s_clocked_kite

layout:    m65s_clocked_kite.ap
gds:       m65s_clocked_kite.gds
