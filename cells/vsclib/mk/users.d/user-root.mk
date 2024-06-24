
# The only case the build user is "root" should be under docker.

 DEBUG_OPTION   =
 BUILD_TYPE_DIR = Release.Shared

 export CORIOLIS_TOP   = $(HOME)/coriolis-2.x/$(BUILD_VARIANT)$(LIB_SUFFIX_)/$(BUILD_TYPE_DIR)/install
 export ALLIANCE_TOP   = $(HOME)/coriolis-2.x/$(BUILD_VARIANT)$(LIB_SUFFIX_)/$(BUILD_TYPE_DIR)/install
 export CHECK_TOOLKIT  = $(HOME)/coriolis-2.x/src/alliance-check-toolkit
 export YOSYS_TOP      = /usr
