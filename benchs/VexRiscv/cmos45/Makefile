# -*- explicit-buffer-name: "Makefile<VexRiscv/cmos45>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = cmos45

            USE_CLOCKTREE = Yes
                USE_DEBUG = No
               USE_KATANA = Yes

                 NETLISTS = VexRiscv

 include ./mk/design-flow.mk

blif:   VexRiscv.blif
vst:    vexriscv.vst
layout: vexriscv_clocked_r.ap
gds:    vexriscv_clocked_r.gds

lvx:    lvx-vst-vexriscv_clocked
drc:    druc-vexriscv_clocked_r
