
 export RDS_TECHNO_NAME = $(CHECK_TOOLKIT)/dks/sky130_lsx/libs.tech/coriolis/sky130_lsx/sky130_lsx.rds
 export SPI_TECHNO_NAME = $(CHECK_TOOLKIT)/pdkmaster/C4M.Sky130/libs.tech/ngspice/C4M.Sky130_logic_tt_model.spice
               SPIMODEL = $(CHECK_TOOLKIT)/dks/sky130_lsx/libs.tech/coriolis/sky130_lsx/spimodel.cfg
             SPI_FORMAT = hspice
 export      CELLS_TOP  = $(CHECK_TOOLKIT)/cells
 export MBK_TARGET_LIB  = ${CELLS_TOP}/lsxram
 export   MBK_CATA_LIB  = $(MBK_TARGET_LIB)
 export   LIBERTY_FILE  = $(CELLS_TOP)/lsxram/lsxram.lib
