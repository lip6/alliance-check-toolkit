C	?= lsxrules#
V	?= lsx#

help:
	@echo ""
	@echo "usage: make <graal|dreal> [C=cell] [V=sky_ver]"
	@echo ""
	@echo "    default C=$(C) V=$(V)"
	@echo ""

graal:
	export RDS_TECHNO_NAME=symbolic.rds;\
	export GRAAL_TECHNO_NAME=symbolic.graal;\
	graal -l $(C)

dreal:
	export RDS_TECHNO_NAME=sky130_$(V).rds;\
	export DREAL_TECHNO_NAME=symbolic.dreal;\
	export RDS_IN=cif;\
	export RDS_OUT=cif;\
	s2r -t $(C);\
	dreal -l $(C)

clean:
	rm $(C).cif
