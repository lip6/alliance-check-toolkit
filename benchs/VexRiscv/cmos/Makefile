# -*- explicit-buffer-name: "Makefile<SpinalRTL/layout>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib

            USE_CLOCKTREE = No
                USE_DEBUG = No
               USE_KATANA = Yes

                 NETLISTS = VexRiscv

 include ./mk/design-flow.mk

blif:   VexRiscv.blif
layout: vexriscv_r.ap

lvx:    lvx-vst-vexriscv
drc:    druc-vexriscv_r
