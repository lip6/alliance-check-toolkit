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
 ifneq ($(USER_CONF),)
   include $(USER_CONF)
 else
   $(error No suitable profile found for user $(USER) in ./etc/users.d)
 endif 

 export ALLIANCE_TOP
 export CORIOLIS_TOP
 export AVERTEC_TOP
 export YOSYS_TOP

