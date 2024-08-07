# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/lsxlib>" -*-

 PHYSICAL_SYNTHESIS = Alliance
         DESIGN_KIT = lsxram
             TECHNO = sg13g2
             TECHNO = sky130
            RDS_TOP = $(CELLS_TOP)/../dks/$(TECHNO)_lsx/libs.tech/coriolis/$(TECHNO)_lsx

 include ./mk/design-flow.mk
 include ./mk/check-library.mk

v1: ./check/invbuf2_x0.ok
v2: ./check/n2oa2a22_x0.ok
v3: ./check/nm2x2_x0.ok
v4: ./check/ctrw2r2_x1.ok
v5: ./check/sram2bw2r2.ok

# ----------------------------------------------------------------------------- 
#  Interactive Commands  
# ----------------------------------------------------------------------------- 

Sgraal:
	export RDS_TECHNO_NAME=$(RDS_TOP)/symbolic.rds;\
	export GRAAL_TECHNO_NAME=$(RDS_TOP)/symbolic.graal;\
	graal -l $(C)

Rgraal:
	export RDS_TECHNO_NAME=$(RDS_TOP)/$(TECHNO)_lsx.rds;\
	export GRAAL_TECHNO_NAME=$(RDS_TOP)/symbolic.graal;\
	graal -l $(C)

Dreal:
	export RDS_TECHNO_NAME=$(RDS_TOP)/$(TECHNO)_lsx.rds;\
	export RDS_OUT=cif;\
	export RDS_IN=cif;\
	s2r -t $(C);\
	dreal -l $(C);\
	rm $(C).cif

check-clean: ; rm -f ./check/*
