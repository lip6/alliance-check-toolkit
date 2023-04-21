
#export RDS_TECHNO_NAME = /soc/alliance/etc/cmos.rds
#export RDS_TECHNO_NAME = $(CHECK_TOOLKIT)/cells/lsxlib/techno/cmos.rds
 export RDS_TECHNO_NAME = $(CHECK_TOOLKIT)/cells/lsxlib/techno/sky130d1_2.rds
 export SPI_TECHNO_NAME = $(CHECK_TOOLKIT)/cells/lsxlib/techno/C4M_LIP6_Sky130_hitas.spice
 export SPI_TECHNO_NAME = $(CHECK_TOOLKIT)/cells/lsxlib/techno/C4M_LIP6_Sky130.spice
 export      CELLS_TOP  = $(CHECK_TOOLKIT)/cells
 export MBK_TARGET_LIB  = ${CELLS_TOP}/lsxlib
 export   MBK_CATA_LIB  = $(MBK_TARGET_LIB)
 export   LIBERTY_FILE  = $(CELLS_TOP)/lsxlib/lsxlib.lib
