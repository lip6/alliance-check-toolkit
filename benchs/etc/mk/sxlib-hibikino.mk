# -*- explicit-buffer-name: "nsxlib.mk<alliance-check-toolkit>" -*-

 include $(TK_RTOP)/etc/mk/hibikino.mk

 export MBK_TARGET_LIB = ${TOOLKIT_CELLS_TOP}/hibikino/sxlib_25um
 export   MBK_CATA_LIB = $(MBK_TARGET_LIB):${TOOLKIT_CELLS_TOP}/hibikino/padlib_25um
