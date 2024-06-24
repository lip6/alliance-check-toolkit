# -*- explicit-buffer-name: "users.mk<uc1>" -*-
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

 USER_CONF = $(shell echo ./mk/users.d/user-$(USER).mk)
 $(info User configuration file: $(USER_CONF))
 CONF_EXIST = $(shell ls $(USER_CONF))
 ifneq ($(CONF_EXIST),$(USER_CONF))
   USER_CONF = ./mk/users.d/user-default.mk
   $(info Default configuration file: $(USER_CONF))
   CONF_EXIST = $(shell ls $(USER_CONF))
   ifneq ($(CONF_EXIST),$(USER_CONF))
     $(error No suitable profile found for users "$(USER)" or "default" in ./etc/users.d)
   endif
 endif
 include $(USER_CONF)

 export ALLIANCE_TOP
 export CORIOLIS_TOP
 export AVERTEC_TOP
 export YOSYS_TOP

#$(error Breakpoint after mk/users.mk active)
