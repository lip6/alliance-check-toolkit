# -*- explicit-buffer-name: "Makefile<snx/cmos45>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = nsxlib45

            USE_CLOCKTREE = Yes
                USE_DEBUG = No
                 USE_KITE = No

                 NETLISTS = snx      \
                            alu16    \
                            cla16    \
                            inc16    \
                            reg4     \
                            type_dec

 include ./mk/design-flow.mk


layout:    snx_htck_r.ap
gds:       snx_htck_r.gds

lvx:       lvx-snx_htck_r
druc:      druc-snx_htck_r
view:      cgt-snx_htck_r
