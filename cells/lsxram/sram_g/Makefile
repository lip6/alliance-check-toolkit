# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/lsxlib>" -*-

 PHYSICAL_SYNTHESIS = Alliance
         DESIGN_KIT = lsxram
             TECHNO = sg13g2
             TECHNO = sky130
            RDS_TOP = $(CELLS_TOP)/../dks/$(TECHNO)_lsx/libs.tech/coriolis/$(TECHNO)_lsx

 include ./mk/design-flow.mk
 include ./mk/check-library.mk

all: v1 v2 v3 v4 v5 v6
v1: check/sram_nmxr2_2x1.ok
v2: check/sram_w2r2_2x1_dec.ok
v3: check/sram_w2r2_2x1_mx.ok
v4: check/sram_w2r2_4x1.ok
v5: check/sram_w2r2_2x1.ok
v6: check/sram_w2r2_2x2.ok

# ----------------------------------------------------------------------------- 
#  Interactive Commands  
# ----------------------------------------------------------------------------- 

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

c check-clean: clean ; rm -f ./check/*
