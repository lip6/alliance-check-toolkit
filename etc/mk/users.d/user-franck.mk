# Default value for unregistered user.
# This sccript *must* be edited to match your Coriolis installation.

 DEFAULT_ROOT=${HOME}
 DEFAULT_ROOT=/users/outil/coriolis
 ifeq ($(NDA_TOP),)
     ifeq ($(shell hostname),lepka)
         export NDA_TOP = ${DEFAULT_ROOT}/crypted/soc/techno
     else ifeq ($(shell hostname),rolland)
         export NDA_TOP = ${DEFAULT_ROOT}/crypted/soc/techno
     else
         export NDA_TOP = /users/soft/techno/techno
     endif
 endif
 export AMS_C35B4     = ${NDA_TOP}/AMS/035hv-4.10
 export FreePDK_45    = ${DEFAULT_ROOT}/coriolis-2.x/work/DKs/FreePDK45
 export FlexLib_CM018 = ${NDA_TOP}/etc/coriolis2/NDA/node180/tsmc_c018
 export CORIOLIS_TOP  = $(DEFAULT_ROOT)/coriolis-2.x/$(BUILD_VARIANT)$(LIB_SUFFIX_)/$(BUILD_TYPE_DIR)/install
#export ALLIANCE_TOP  = $(DEFAULT_ROOT)/coriolis-2.x/$(BUILD_VARIANT)$(LIB_SUFFIX_)/Release.Shared/install
 export ALLIANCE_TOP  = $(CORIOLIS_TOP)
 export CHECK_TOOLKIT = $(HOME)/coriolis-2.x/src/alliance-check-toolkit
 export AVERTEC_TOP   = $(ALLIANCE_TOP)/share/tasyag
 export YOSYS_TOP     = /usr
