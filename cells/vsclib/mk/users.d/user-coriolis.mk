 NIGHTLY = 
 ifneq ($(findstring nightly,$(shell pwd)),)
  # Assume this is the nightly build.
   NIGHTLY = /nightly
 endif

 DEBUG_OPTION   =
 BUILD_TYPE_DIR = Release.Shared

 export CORIOLIS_TOP   = $(HOME)$(NIGHTLY)/coriolis-2.x/$(BUILD_VARIANT)$(LIB_SUFFIX_)/$(BUILD_TYPE_DIR)/install
 export ALLIANCE_TOP   = /soc/alliance
 export CHECK_TOOLKIT  = $(HOME)$(NIGHTLY)/coriolis-2.x/src/alliance-check-toolkit
 export YOSYS_TOP      = /usr
