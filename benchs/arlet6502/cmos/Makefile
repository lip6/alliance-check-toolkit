# -*- explicit-buffer-name: "Makefile<Arlet6502/cmos>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib

            USE_CLOCKTREE = Yes
                USE_DEBUG = No
                 USE_KITE = No

                 NETLISTS = Arlet6502 \
                            alu       \
                            cpu

 include ./mk/design-flow.mk

blif:   Arlet6502.blif
vst:    arlet6502_cts.vst
layout: arlet6502_cts_r.ap
gds:    arlet6502_cts_r.gds

lvx:    lvx-vst-arlet6502_cts
druc:   druc-arlet6502_cts_r
