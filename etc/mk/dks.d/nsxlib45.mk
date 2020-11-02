
 include ./mk/dks.d/cmos45.mk

 export      CELLS_TOP = $(CHECK_TOOLKIT)/cells
 export MBK_TARGET_LIB = ${CELLS_TOP}/nsxlib
 export   MBK_CATA_LIB = $(MBK_TARGET_LIB):${CELLS_TOP}/mpxlib:$(CELLS_TOP)/phlib80:$(CELLS_TOP)/niolib
 export   LIBERTY_FILE = $(CELLS_TOP)/nsxlib/nsxlib.lib
