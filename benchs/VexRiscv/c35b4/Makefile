# -*- explicit-buffer-name: "Makefile<SpinalRTL/layout>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = c35b4

            USE_CLOCKTREE = No
                USE_DEBUG = No
                 USE_KITE = No

                 NETLISTS = VexRiscv

 include ./mk/design-flow.mk


blif:   VexRiscv.blif
layout: VexRiscv_r.gds
