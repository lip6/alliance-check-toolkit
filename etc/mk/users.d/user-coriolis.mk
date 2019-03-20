 NIGHTLY = 
 ifneq ($(findstring nightly,$(shell pwd)),)
  # Assume this is the nightly build.
   NIGHTLY = /nightly
 endif

 DEBUG_OPTION   =
 BUILD_TYPE_DIR = Release.Shared

 CORIOLIS_TOP   = $(HOME)$(NIGHTLY)/coriolis-2.x/$(BUILD_VARIANT)$(LIB_SUFFIX_)/$(BUILD_TYPE_DIR)/install
 ALLIANCE_TOP   = /soc/alliance
 CHECK_TOOLKIT  = $(HOME)$(NIGHTLY)/coriolis-2.x/src/alliance-check-toolkit
