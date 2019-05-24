# -*- explicit-buffer-name: "Makefile<VexRiscv/FreePDK_45>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = FreePDK_45

            USE_CLOCKTREE = No
                USE_DEBUG = No
                 USE_KITE = No

                 NETLISTS = VexRiscv

 include ./mk/design-flow.mk

blif:   VexRiscv.blif
layout: VexRiscv_r.gds

