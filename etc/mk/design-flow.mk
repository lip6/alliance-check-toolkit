
 ifneq ($(PDKMASTER_TOP),)
     export NDA_TOP = $(PDKMASTER_TOP)/coriolis/techno
 endif

 include ./mk/os.mk
 include ./mk/users.mk
 include ./mk/binaries.mk
 include ./mk/alliance.mk

# Some useful functions.
 run_if_older = if [ \( ! -e "$(1)" \) -o \( "$(1)" -ot "$(2)" \) ]; then $(3); else echo "\"$(1)\" newer than \"$(2)\" (skip rule)."; fi 

# Select the Design Kit.
 ifeq ($(DESIGN_KIT),sxlib)
   include ./mk/dks.d/sxlib.mk
 else ifeq ($(DESIGN_KIT),nsxlib)
   include ./mk/dks.d/nsxlib.mk
 else ifeq ($(DESIGN_KIT),nsxlib45)
   include ./mk/dks.d/nsxlib45.mk
 else ifeq ($(DESIGN_KIT),Hibikino)
   include ./mk/dks.d/sxlib-hibikino.mk
 else ifeq ($(DESIGN_KIT),FreePDK_45)
   include ./mk/dks.d/FreePDK_45.mk
 else ifeq ($(DESIGN_KIT),phenitec06)
   include ./mk/dks.d/phenitec06.mk
 else ifeq ($(DESIGN_KIT),cmos45)
   include ./mk/dks.d/nsxlib45.mk
 else ifeq ($(DESIGN_KIT),c35b4)
   include ./mk/dks.d/c35b4.mk
 else ifeq ($(DESIGN_KIT),FlexLib018)
   include ./mk/dks.d/FlexLib018.mk
 else ifeq ($(DESIGN_KIT),FreePDK_C4M45)
   include ./mk/dks.d/FreePDK_C4M45.mk
 else
   $(error DESIGN_KIT variable has not been set or has an unsupported value)
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
