# -*- explicit-buffer-name: "Makefile<VexRiscv/cmos45>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = cmos45

            USE_CLOCKTREE = Yes
                USE_DEBUG = No
                 USE_KITE = No
            YOSYS_FLATTEN = Yes

ifeq ($(YOSYS_FLATTEN),Yes)
                 NETLISTS = ao68000
else
                 NETLISTS = ao68000 \
                            alu \
                            alu_mult \
                            bus_control \
                            condition \
                            decoder \
                            memory_registers \
                            microcode_branch \
                            registers
endif

 include ./mk/design-flow.mk

blif:   ao68000.blif
vst:    ao68000.vst
layout: ao68000_cts_r.ap
gds:    ao68000_cts_r.gds

lvx:    lvx-vst-ao68000_cts
druc:   druc-ao68000_cts_r
