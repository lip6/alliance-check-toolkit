# -*- explicit-buffer-name: "nsxlib.mk<alliance-check-toolkit>" -*-

 include ./mk/hibikino.mk

 export      CELLS_TOP = $(CHECK_TOOLKIT)/cells
 export MBK_TARGET_LIB = ${CELLS_TOP}/hibikino/sxlib_25um
 export   MBK_CATA_LIB = $(MBK_TARGET_LIB):${CELLS_TOP}/hibikino/padlib_25um
