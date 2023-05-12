# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/lsxlib>" -*-

 PHYSICAL_SYNTHESIS = Alliance
         DESIGN_KIT = lsxlib

 include ./mk/design-flow.mk
 include ./mk/check-library.mk

export MBK_CATA_LIB = $(CELLS_TOP)/lsxlib

characterize: lsxlib-dot-lib

check-lib-test: ./check/mx2_x0.ok
	# ./check/noa2a22_x0.ok
	# ./check/invbuf_x3.ok
	#./check/sffram2bw2r2.vhd
	# ./check/ctrw2r2_x1.ok
	# ./check/sram2b.ok 

Sgraal:
	export RDS_TECHNO_NAME=techno/symbolic.rds;\
	export GRAAL_TECHNO_NAME=techno/symbolic.graal;\
	graal -l $(C)

Rgraal:
	export RDS_TECHNO_NAME=techno/sky130_lsx.rds;\
	export GRAAL_TECHNO_NAME=techno/symbolic.graal;\
	graal -l $(C)

Dreal:
	export RDS_TECHNO_NAME=techno/sky130_lsx.rds;\
	export GRAAL_TECHNO_NAME=techno/symbolic.drea;\
	export RDS_OUT=cif;\
	export RDS_IN=cif;\
	s2r -t $(C);\
	dreal -l $(C)

check-clean: ; rm -f ./check/*
