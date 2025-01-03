# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/nsxlib>" -*-

 PHYSICAL_SYNTHESIS = Alliance
         DESIGN_KIT = vsclib
 SPI_FORMAT = hspice
 # SPIMODEL = techno/spimodel.cfg


 include ./mk/dks.d/vsclib.mk
 include ./mk/design-flow.mk
 include ./mk/check-library.mk

export YAGLE_OPTION=-SpiceModel 'sky130_fd_pr__nfet_01v8__mismatch.corner.spice sky130_fd_pr__nfet_01v8__tt.pm3.spice sky130_fd_pr__nfet_01v8__tt.corner.spice sky130_fd_pr__pfet_01v8__mismatch.corner.spice sky130_fd_pr__pfet_01v8__tt.pm3.spice sky130_fd_pr__pfet_01v8__tt.corner.spice  parameters/lod.spice ' -MasterFlipFlop df_m -SlaveFlipFlop df_s -FlipFlopCell dfnt\*


# export MBK_CATA_LIB = $(CELLS_TOP)/vsclib


characterize: vsclib-dot-lib


check-lib-test: ./check/inv_x1.ok \
                ./check/sff1_x4.ok \

#                ./check/sff1r_x4.ok

check-clean: ; rm -f ./check/*
