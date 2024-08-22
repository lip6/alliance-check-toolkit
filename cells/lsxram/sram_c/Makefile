# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/lsxlib>" -*-

 PHYSICAL_SYNTHESIS = Alliance
         DESIGN_KIT = lsxram
             TECHNO = sg13g2
             TECHNO = sky130
            RDS_TOP = $(CELLS_TOP)/../dks/$(TECHNO)_lsx/libs.tech/coriolis/$(TECHNO)_lsx

help:
	@echo ""
	@echo "Usage : make test W=<nb words> B=<nb of bits>"
	@echo ""

 include ./mk/design-flow.mk
 include ./mk/check-library.mk

# Default SRAM geometry
W ?= 4
B  ?= 2

test: 
	make sram_w2r2_$(W)x$(B).ap
	make check/sram_w2r2_$(W)x$(B).ok

# ----------------------------------------------------------------------------- 
#  Interactive Commands  
# ----------------------------------------------------------------------------- 

g sram_w2r2_$(W)x$(B).ap : sram_w2r2.c
	export ALLIANCE_TOP=$(HOME)/coriolis-2.x/release/install;\
	genlib $< -e $(W) $(B)

s Sgraal:
	export RDS_TECHNO_NAME=$(RDS_TOP)/symbolic.rds;\
	export GRAAL_TECHNO_NAME=$(RDS_TOP)/symbolic.graal;\
	graal -l $(C)

r Rgraal:
	export RDS_TECHNO_NAME=$(RDS_TOP)/$(TECHNO)_lsx.rds;\
	export GRAAL_TECHNO_NAME=$(RDS_TOP)/symbolic.graal;\
	graal -l $(C)

d Dreal:
	export RDS_TECHNO_NAME=$(RDS_TOP)/$(TECHNO)_lsx.rds;\
	export RDS_OUT=cif;\
	export RDS_IN=cif;\
	s2r -t $(C);\
	dreal -l $(C);\
	rm $(C).cif

c check-clean: ; rm -f *.ap ./check/*
