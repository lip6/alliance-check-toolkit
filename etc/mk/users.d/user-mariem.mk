# Where Marie-Minerve Louërat gets his tools installeds.

 ifeq ($(shell hostname),lepka)
     export NDA_TOP       = ${HOME}/crypted/soc/techno
 else
     export NDA_TOP       = /users/soft/techno/techno
 endif
 export AMS_C35B4     = ${NDA_TOP}/AMS/035hv-4.10
 export FreePDK_45    = ${HOME}/coriolis-2.x/work/DKs/FreePDK45
 export FlexLib_CM018 = ${NDA_TOP}/etc/coriolis2/NDA/node180/tsmc_c018
 export CORIOLIS_TOP  = $(HOME)/coriolis-2.x/$(BUILD_VARIANT)$(LIB_SUFFIX_)/$(BUILD_TYPE_DIR)/install
 export ALLIANCE_TOP  = $(HOME)/coriolis-2.x/$(BUILD_VARIANT)$(LIB_SUFFIX_)/Release.Shared/install
 export CHECK_TOOLKIT = $(HOME)/coriolis-2.x/src/alliance-check-toolkit
 export AVERTEC_TOP   = /dsk/l1/tasyag/Linux.el7_64/install
 export YOSYS_TOP     = /usr
