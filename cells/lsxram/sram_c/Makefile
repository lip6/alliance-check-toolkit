# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/lsxlib>" -*-

 PHYSICAL_SYNTHESIS = Alliance
         DESIGN_KIT = lsxram
             TECHNO = sg13g2
             TECHNO = sky130
            RDS_TOP = $(CELLS_TOP)/../dks/$(TECHNO)_lsx/libs.tech/coriolis/$(TECHNO)_lsx

 include ./mk/design-flow.mk
 include ./mk/check-library.mk

v1: check/sram_w2r2_4x2.ok

# ----------------------------------------------------------------------------- 
#  Interactive Commands  
# ----------------------------------------------------------------------------- 

g1 sram_w2r2_4x2_w.ap : sram_w2r2.c
	export ALLIANCE_TOP=$(HOME)/coriolis-2.x/release/install;\
	genlib $< -e 4 2

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
