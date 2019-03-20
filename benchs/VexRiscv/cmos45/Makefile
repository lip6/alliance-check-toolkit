# -*- explicit-buffer-name: "Makefile<VexRiscv/cmos45>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = cmos45

            USE_CLOCKTREE = No
                USE_DEBUG = No
               USE_KATANA = Yes

                 NETLISTS = VexRiscv

 include ./mk/design-flow.mk

blif:   VexRiscv.blif
layout: vexriscv_r.ap
gds:    vexriscv_r.gds

lvx:    lvx-vst-vexriscv
drc:    druc-vexriscv_r
