
 export CHECK_TOOLKIT=$HOME/lip6/alliance-check-toolkit
 export RDS_TECHNO_NAME=$CHECK_TOOLKIT/dks/sky130_vsc/libs.tech/coriolis/sky130_vsc/sky130_vsc.rds

 export      CELLS_TOP=$CHECK_TOOLKIT/cells
 export MBK_TARGET_LIB=${CELLS_TOP}/vsclib
 export   MBK_CATA_LIB=$MBK_TARGET_LIB:${CELLS_TOP}/mpxlib:$CELLS_TOP/msplib:$CELLS_TOP/niolib
 export   LIBERTY_FILE=$CELLS_TOP/vsclib/vsclib.lib
 export SPI_TECHNO_NAME=$CELLS_TOP/vsclib/techno/C4M.Sky130_tt_model_hitas.spice
 export        SPIMODEL=$CELLS_TOP/vsclib/techno/spimodel.cfg
 export      SPI_FORMAT=spice
 export RDS_OUT=gds
