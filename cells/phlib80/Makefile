# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/nsxlib>" -*-

 PHYSICAL_SYNTHESIS = Alliance
         DESIGN_KIT = phenitec06

 include ./mk/design-flow.mk
 include ./mk/check-library.mk

 export MBK_CATA_LIB = $(CELLS_TOP)/phlib80


characterize: nsxlib-dot-lib


all: ./check/pck_sp.ok \
	./check/pi_sp.ok \
	./check/po_sp.ok \
	./check/pvddck2_sp.ok \
	./check/pvssck2_sp.ok

check-lib-test: ./check/pi_sp.ok 

check-clean: ; rm -f ./check/*
