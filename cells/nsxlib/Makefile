# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/nsxlib>" -*-

 PHYSICAL_SYNTHESIS = Alliance
         DESIGN_KIT = nsxlib45

 include ./mk/design-flow.mk
 include ./mk/check-library.mk


 export MBK_CATA_LIB = $(CELLS_TOP)/nsxlib


characterize: nsxlib-dot-lib


check-lib-test: ./check/inv_x1.ok \
                ./check/sff1_x4.ok

check-clean: ; rm -f ./check/*
