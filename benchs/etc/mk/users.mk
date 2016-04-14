# -*- explicit-buffer-name: "users.mk<alliance-check-toolkit>" -*-
#
# Currently supported users are:
# * jpc        --  Jean-Paul Chaput
# * nshimizu   --  Naohiko Shimizu
# * alnurn     --  Gabriel Gouvine
# * coriolis   --  Nightly build on <bip>.
#
# Setup variables:
# * CORIOLIS_TOP
# * ALLIANCE_TOP
# * ALLIANCE_TOOLKIT
# * AVERTEC_TOP
# * YOSYS_TOP
#
# * USE_NSL


# -------------------------------------------------------------------
# User Detection, for Lazy People...

 ifeq ($(USER),jpc)
  # Where Jean-Paul Chaput gets his tools installeds.

   CORIOLIS_TOP      = $(HOME)/coriolis-2.x/$(BUILD_VARIANT)$(LIB_SUFFIX_)/$(BUILD_TYPE_DIR)/install
   ALLIANCE_TOP      = $(HOME)/alliance/$(BUILD_VARIANT)$(LIB_SUFFIX_)/install
   ALLIANCE_TOOLKIT  = $(HOME)/coriolis-2.x/src/alliance-check-toolkit/benchs
   AVERTEC_TOP       = /dsk/l1/tasyag/Linux.el7_64/install
   YOSYS_TOP         = /usr
 endif
 ifeq ($(USER),nshimizu)
  # Where Naohiko Shimizu gets his tools installeds.

   USE_NSL           = Yes
   ifeq ($(UNAME_S), Linux)
     CORIOLIS_TOP    = $(HOME)/coriolis-2.x/Linux.el7_64/$(BUILD_TYPE_DIR)/install
   else
     CORIOLIS_TOP    = $(HOME)/coriolis-2.x/Cygwin.W10/$(BUILD_TYPE_DIR)/install
   endif
   ALLIANCE_TOP      = /opt/alliance
   ALLIANCE_TOOLKIT  = $(HOME)/Documents/Develop/alliance-check-toolkit/benchs
 endif
 ifeq ($(USER),alnurn)
  # Where Gabriel Gouvine gets his tools installeds.

   CORIOLIS_TOP      = $(HOME)/coriolis-2.x/$(BUILD_VARIANT)$(LIB_SUFFIX_)/$(BUILD_TYPE_DIR)/install
   ALLIANCE_TOP      = /soc/alliance
   ALLIANCE_TOOLKIT  = $(HOME)/coriolis-2.x/src/alliance-check-toolkit/benchs
 endif
 ifeq ($(USER),coriolis)
   NIGHTLY = 
   ifneq ($(findstring nightly,$(shell pwd)),)
    # Assume this is the nightly build.
     NIGHTLY = /nightly
   endif

   DEBUG_OPTION      =
   BUILD_TYPE_DIR    = Release.Shared

   CORIOLIS_TOP      = $(HOME)$(NIGHTLY)/coriolis-2.x/$(BUILD_VARIANT)$(LIB_SUFFIX_)/$(BUILD_TYPE_DIR)/install
   ALLIANCE_TOP      = /soc/alliance
   ALLIANCE_TOOLKIT  = $(HOME)$(NIGHTLY)/coriolis-2.x/src/alliance-check-toolkit/benchs
 endif

 export ALLIANCE_TOP
 export CORIOLIS_TOP
 export AVERTEC_TOP
 export YOSYS_TOP
