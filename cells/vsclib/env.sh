
 export CHECK_TOOLKIT=$HOME/lip6/alliance-check-toolkit
 export TECHDIR=$CHECK_TOOLKIT/dks/common/libs.tech
 export RDS_TECHNO_NAME=$CHECK_TOOLKIT/dks/sky130_vsc/libs.tech/coriolis/sky130_vsc/sky130_vsc.rds

 export      CELLS_TOP=$CHECK_TOOLKIT/cells
 export MBK_TARGET_LIB=${CELLS_TOP}/vsclib
 export   LIBERTY_FILE=$CELLS_TOP/vsclib/vsclib.lib
export MBK_SPI_MODEL=~/lip6/alliance-check-toolkit/dks/sky130_nsx2/libs.tech/coriolis/sky130_nsx2/spimodel.cfg
 export SPI_TECHNO_NAME=$MBK_SPI_MODEL
 export      SPI_FORMAT=hspice
 export RDS_OUT=gds
export SPIMODEL=$HOME/lip6/alliance-check-toolkit/dks/sky130_nsx2/libs.tech/coriolis/sky130_nsx2/spimodel.cfg
export YAGLE_OPTION="-SpiceModel 'sky130_fd_pr__nfet_01v8__mismatch.corner.spice sky130_fd_pr__nfet_01v8__tt.pm3.spice sky130_fd_pr__nfet_01v8__tt.corner.spice sky130_fd_pr__pfet_01v8__mismatch.corner.spice sky130_fd_pr__pfet_01v8__tt.pm3.spice sky130_fd_pr__pfet_01v8__tt.corner.spice  parameters/lod.spice ' -MasterFlipFlop df_m -SlaveFlipFlop df_s -FlipFlopCell dfnt\*"
export MBK_CATA_LIB=.:$HOME/lip6/alliance-check-toolkit/cells/vsclib:$TECHDIR/skywater-pdk-libs-sky130_fd_pr/models:$TECHDIR/skywater-pdk-libs-sky130_fd_pr/cells/pfet_01v8:$TECHDIR/skywater-pdk-libs-sky130_fd_pr/cells/nfet_01v8
