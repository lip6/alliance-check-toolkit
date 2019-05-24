# -*- explicit-buffer-name: "sxlib.mk<alliance-check-toolkit>" -*-

 include $(TK_RTOP)/etc/mk/cmos.mk

 export    MBK_TARGET_LIB = ${CELLS_TOP}/sxlib
 export             DPLIB = ${CELLS_TOP}/dp_sxlib
 export             RFLIB = ${CELLS_TOP}/rflib
 export            RF2LIB = ${CELLS_TOP}/rf2lib
 export            RAMLIB = ${CELLS_TOP}/ramlib
 export      MBK_CATA_LIB = $(MBK_TARGET_LIB):$(DPLIB):$(RFLIB):$(RF2LIB):$(RAMLIB):${CELLS_TOP}/pxlib
