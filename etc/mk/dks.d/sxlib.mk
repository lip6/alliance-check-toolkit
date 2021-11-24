# -*- explicit-buffer-name: "sxlib.mk<alliance-check-toolkit>" -*-

 include ./mk/dks.d/cmos.mk

 export    MBK_TARGET_LIB = ${CELLS_TOP}/sxlib
 export             DPLIB = ${CELLS_TOP}/dp_sxlib
 export             RFLIB = ${CELLS_TOP}/rflib
 export            RF2LIB = ${CELLS_TOP}/rf2lib
 export            RAMLIB = ${CELLS_TOP}/ramlib
 export      MBK_CATA_LIB = $(MBK_TARGET_LIB):$(DPLIB):$(RFLIB):$(RF2LIB):$(RAMLIB):${CELLS_TOP}/pxlib
 export      LIBERTY_FILE = $(CELLS_TOP)/sxlib/sxlib.lib

 ifneq ($(CUSTOM_LIB),)
   export MBK_CATA_LIB+=:$(CUSTOM_LIB)
 endif
 $(info MBK_CATA_LIB=$(MBK_CATA_LIB))

 $(info Using sxlib symbolic DK)
