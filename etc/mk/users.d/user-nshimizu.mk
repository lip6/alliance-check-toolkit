# Where Naohiko Shimizu gets his tools installeds.

 USE_NSL        = Yes
 ifeq ($(UNAME_S), Linux)
   CORIOLIS_TOP = $(HOME)/coriolis-2.x/Linux.el7_64/$(BUILD_TYPE_DIR)/install
 else
   CORIOLIS_TOP = $(HOME)/coriolis-2.x/Cygwin.W10/$(BUILD_TYPE_DIR)/install
 endif
 ALLIANCE_TOP   = /opt/alliance
 CHECK_TOOLKIT  = $(HOME)/Documents/Develop/alliance-check-toolkit
