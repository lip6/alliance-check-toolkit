
#export RDS_TECHNO_NAME = $(CHECK_TOOLKIT)/cells/lsxlib/techno/sky130d1_1.rds
 export RDS_TECHNO_NAME = $(CHECK_TOOLKIT)/cells/lsxlib/techno/cmos.rds
#export SPI_TECHNO_NAME = $(CHECK_TOOLKIT)/etc/scn6m_deep.hsp
 export      CELLS_TOP  = $(CHECK_TOOLKIT)/cells
 export MBK_TARGET_LIB  = ${CELLS_TOP}/lsxlib
 export   MBK_CATA_LIB  = $(MBK_TARGET_LIB)
 export   LIBERTY_FILE  = $(CELLS_TOP)/lsxlib/lsxlib.lib
