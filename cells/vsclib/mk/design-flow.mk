
 ifneq ($(PDKMASTER_TOP),)
     export NDA_TOP = $(PDKMASTER_TOP)/coriolis/techno
 endif
 $(info Using PDKMASTER_TOP = "${PDKMASTER_TOP}")

 include ./mk/os.mk
 include ./mk/users.mk
 include ./mk/binaries.mk
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

# In we are using PDKMaster, check for it's presence.
 ifneq ($(PDKMASTER_TOP),)
   ifeq ($(wildcard $(PDKMASTER_TOP)),)
     $(error [ERROR] PDK Master "$(PDKMASTER_TOP)" not found.)
   endif
   ifeq ($(wildcard $(LIBERTY_FILE)),)
     $(error [ERROR] Liberty file "$(LIBERTY_FILE)" not found.)
   endif
 endif


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

 ifeq ($(SPIMODEL),)
   SPIMODEL = $(ALLIANCE_TOP)/etc/spimodel.cfg
 endif

 ifeq ($(SPI_FORMAT),)
   SPI_FORMAT = hspice
 endif
