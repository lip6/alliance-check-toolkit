
        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = FlexLib018

            USE_CLOCKTREE = Yes
                USE_DEBUG = No
                 USE_KITE = No

                 NETLISTS = adder

 include ./mk/design-flow.mk

blif:   adder.blif
vst:    adder.vst
layout: adder_cts_r.ap
gds:    adder_cts_r.gds

lvx:    lvx-vst-adder_cts
druc:   druc-adder_cts_r

view:   cgt-adder
