# -*- explicit-buffer-name: "Makefile<retrouc/cmos45>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = cmos45

            USE_CLOCKTREE = Yes
                USE_DEBUG = No
                 USE_KITE = No

                 NETLISTS = RetrouC_2020Beta \
                            alu              \
                            cpu

 include ./mk/design-flow.mk

blif:   RetrouC_2020Beta.blif
vst:    retrouc_2020beta.vst
layout: retrouc_2020beta_cts_r.ap
gds:    retrouc_2020beta_cts_r.gds
view:   cgt-retrouc_2020beta

lvx:    lvx-vst-retrouc_2020beta_cts
druc:   druc-retrouc_2020beta_cts_r
