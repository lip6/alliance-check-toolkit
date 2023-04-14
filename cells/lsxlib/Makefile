# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/lsxlib>" -*-

 PHYSICAL_SYNTHESIS = Alliance
         DESIGN_KIT = lsxlib

 include ./mk/design-flow.mk
 include ./mk/check-library.mk


 export MBK_CATA_LIB = $(CELLS_TOP)/lsxlib


characterize: lsxlib-dot-lib


check-lib-test: ./check/inv_x1.ok

#               ./check/sff1_x4.ok \
#               ./check/sff1r_x4.ok

check-clean: ; rm -f ./check/*
