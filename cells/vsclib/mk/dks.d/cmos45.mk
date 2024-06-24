# -*- explicit-buffer-name: "mosis.mk<alliance-check-toolkit>" -*-

 export RDS_TECHNO_NAME = $(CHECK_TOOLKIT)/etc/FreePDK45.rds
#export RDS_TECHNO_NAME = $(CHECK_TOOLKIT)/etc/scn6m_deep_09.rds
 export SPI_TECHNO_NAME = $(CHECK_TOOLKIT)/etc/scn6m_deep.hsp
 export CELLS_TOP       = $(CHECK_TOOLKIT)/cells
 export MBK_CATA_LIB    = ${CELLS_TOP}/nsxlib:${CELLS_TOP}/niolib
 export LIBERTY_FILE    = $(CELLS_TOP)/nsxlib/nsxlib.lib
