# -*- explicit-buffer-name: "nsxlib.mk<alliance-check-toolkit>" -*-

 include $(TK_RTOP)/etc/mk/mosis.mk

 export MBK_TARGET_LIB = ${TOOLKIT_CELLS_TOP}/nsxlib
 export   MBK_CATA_LIB = $(MBK_TARGET_LIB):${TOOLKIT_CELLS_TOP}/mpxlib:$(TOOLKIT_CELLS_TOP)/msplib
