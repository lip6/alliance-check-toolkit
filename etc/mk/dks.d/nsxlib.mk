# -*- explicit-buffer-name: "nsxlib.mk<alliance-check-toolkit>" -*-

 include ./mk/dks.d/mosis.mk

 export      CELLS_TOP = $(CHECK_TOOLKIT)/cells
 export MBK_TARGET_LIB = ${CELLS_TOP}/nsxlib
 export   MBK_CATA_LIB = $(MBK_TARGET_LIB):${CELLS_TOP}/mpxlib:$(CELLS_TOP)/msplib
 export   LIBERTY_FILE = $(CELLS_TOP)/nsxlib/nsxlib.lib
