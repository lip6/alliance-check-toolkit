export MBK_CATA_LIB=.:../../../../dks/common/libs.tech/skywater-pdk-libs-sky130_fd_pr/models/corners:../../../dks/sky130_nsx2/libs.tech/coriolis/sky130_nsx2
export NGSPICE_INPUT_DIR=". ../../../../dks/common/libs.tech/skywater-pdk-libs-sky130_fd_pr/models/corners ../../../dks/sky130_nsx2/libs.tech/coriolis/sky130_nsx2"

sed -i '16s/^include/* include/' ../../../../dks/common/libs.tech/skywater-pdk-libs-sky130_fd_pr/cells/nfet_05v0_nvt/sky130_fd_pr__nfet_05v0_nvt.pm3.spice
