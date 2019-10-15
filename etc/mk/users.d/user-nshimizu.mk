# Where Naohiko Shimizu gets his tools installeds.

 USE_NSL        = Yes
 ifeq ($(UNAME_S), Linux)
   CORIOLIS_TOP = $(HOME)/coriolis-2.x/$(BUILD_VARIANT)$(LIB_SUFFIX_)/$(BUILD_TYPE_DIR)/install
 else
   CORIOLIS_TOP = $(HOME)/coriolis-2.x/Cygwin.W10/$(BUILD_TYPE_DIR)/install
 endif
 ALLIANCE_TOP   = /opt/alliance
 CHECK_TOOLKIT  = $(HOME)/Documents/Develop/alliance-check-toolkit
