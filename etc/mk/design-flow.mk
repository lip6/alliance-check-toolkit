
 ifneq ($(PDKMASTER_TOP),)
     export NDA_TOP = $(PDKMASTER_TOP)/coriolis/techno
 endif
 $(info Using PDKMASTER_TOP = "${PDKMASTER_TOP}")

 include ./mk/os.mk
 include ./mk/users.mk
 include ./mk/binaries.mk
 $(info =============== CELLS_TOP="$(CELLS_TOP)")
 include ./mk/alliance.mk

# Some useful functions.
 run_if_older = if [ \( ! -e "$(1)" \) -o \( "$(1)" -ot "$(2)" \) ]; then $(3); else echo "\"$(1)\" newer than \"$(2)\" (skip rule)."; fi 

# Load the Design kit preset configuration.
 ifeq ($(shell if [ -e "./mk/dks.d/$(DESIGN_KIT).mk" ]; then echo "FOUND"; fi),FOUND)
   $(info Design kit configuration for "$(DESIGN_KIT)" (./mk/dks.d/$(DESIGN_KIT).mk) found.)
   include ./mk/dks.d/$(DESIGN_KIT).mk
 else
   $(error Design kit configuration for "$(DESIGN_KIT)" (./mk/dks.d/$(DESIGN_KIT).mk) NOT found.)
 endif
 $(info CELLS_TOP="$(CELLS_TOP)")

# Select the logical synthesis tools.
 ifeq ($(LOGICAL_SYNTHESIS),Yosys)
   include ./mk/synthesis-yosys.mk
 else ifeq ($(LOGICAL_SYNTHESIS),Alliance)
   include ./mk/synthesis-alliance.mk
 else
   include ./mk/synthesis-disabled.mk
 endif

# Select the physical synthesis tools.
 ifeq ($(PHYSICAL_SYNTHESIS),Coriolis)
   include ./mk/pr-coriolis.mk
 else ifeq ($(PHYSICAL_SYNTHESIS),Alliance)
   include ./mk/pr-alliance.mk
 else ifeq ($(PHYSICAL_SYNTHESIS),Hibikino)
   include ./mk/pr-hibikino.mk
 else
   $(error PHYSICAL_SYNTHESIS variable has not been set or has an unsupported value)
 endif

 $(info Using RDS_TECHNO_NAME = "${RDS_TECHNO_NAME}")
