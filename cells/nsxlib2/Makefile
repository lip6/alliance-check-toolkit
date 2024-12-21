# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/nsxlib>" -*-

 PHYSICAL_SYNTHESIS = Alliance
         DESIGN_KIT = nsxlib2

SPI_TECHNO_NAME=$(MBK_SPI_MODEL)

 include ./mk/dks.d/nsxlib2.mk
 include ./mk/design-flow.mk
 include ./mk/check-library.mk


# export MBK_CATA_LIB = $(CELLS_TOP)/nsxlib2


characterize: nsxlib2-dot-lib


check-lib-test: ./check/inv_x1.ok \
                ./check/sff1_x4.ok \

#                ./check/sff1r_x4.ok

check-clean: ; rm -f ./check/*
