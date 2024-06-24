

 export RDS_TECHNO_NAME = $(CHECK_TOOLKIT)/dks/sky130_nsx2/libs.tech/coriolis/sky130_nsx2/sky130_nsx3.rds
 export SPI_TECHNO_NAME = $(CHECK_TOOLKIT)/etc/scn6m_deep.hsp

 export      CELLS_TOP = $(CHECK_TOOLKIT)/cells
 export MBK_TARGET_LIB = ${CELLS_TOP}/nsxlib2-s
 export   MBK_CATA_LIB = $(MBK_TARGET_LIB):${CELLS_TOP}/mpxlib:$(CELLS_TOP)/msplib:$(CELLS_TOP)/niolib
 export   LIBERTY_FILE = $(CELLS_TOP)/nsxlib2-s/nsxlib2-s.lib
