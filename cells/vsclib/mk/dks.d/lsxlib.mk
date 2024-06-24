
#export RDS_TECHNO_NAME = /soc/alliance/etc/cmos.rds
export RDS_TECHNO_NAME = $(CHECK_TOOLKIT)/cells/lsxlib/techno/symbolic.rds
# export RDS_TECHNO_NAME = $(CHECK_TOOLKIT)/cells/lsxlib/techno/sky130_lsx.rds
 export SPI_TECHNO_NAME = $(CHECK_TOOLKIT)/cells/lsxlib/techno/C4M.Sky130_tt_model_hitas.spice
               SPIMODEL = $(CHECK_TOOLKIT)/cells/lsxlib/techno/spimodel.cfg
             SPI_FORMAT = spice
 export      CELLS_TOP  = $(CHECK_TOOLKIT)/cells
 export MBK_TARGET_LIB  = ${CELLS_TOP}/lsxlib
 export   MBK_CATA_LIB  = $(MBK_TARGET_LIB)
 export   LIBERTY_FILE  = $(CELLS_TOP)/lsxlib/lsxlib.lib
