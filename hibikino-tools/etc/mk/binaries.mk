# -*- explicit-buffer-name: "binaries.mk<alliance-check-toolkit>" -*-


 ALLIANCE_BIN      = $(ALLIANCE_TOP)/bin
 ALLIANCE4_BIN      = $(ALLIANCE4_TOP)/bin
 SYSCONF_TOP       = $(ALLIANCE_TOP)/etc
 CELLS_TOP         = $(ALLIANCE_TOP)/cells
 SPI_MODEL         = $(SYSCONF_TOP)/spimodel.cfg

 #TOOLKIT_BIN       = $(ALLIANCE_TOOLKIT)/bin
 USER_CELLS_TOP = $(USER_TOP)/etc/cells

 AVERTEC_BIN       = $(AVERTEC_TOP)/bin
 YOSYS_BIN         = $(YOSYS_TOP)/bin


# -------------------------------------------------------------------
# Absolute access pathes to binaries

 VASY         = $(ALLIANCE_BIN)/vasy
 BOOM         = $(ALLIANCE_BIN)/boom -A
 BOOG         = $(ALLIANCE_BIN)/boog
 LOON         = $(ALLIANCE_BIN)/loon
 ASIMUT       = $(ALLIANCE_BIN)/asimut
 OCP          = $(ALLIANCE_BIN)/ocp
 NERO         = $(ALLIANCE_BIN)/nero
 RING         = $(ALLIANCE_BIN)/ring
 FLATPH       = $(ALLIANCE_BIN)/flatph
 S2R          = $(GDB) $(ALLIANCE_BIN)/s2r
 S2R_cif      = export RDS_OUT=cif; \
                $(ALLIANCE_BIN)/s2r
 GRAAL        = $(GDB) $(ALLIANCE_BIN)/graal
 DREAL        = $(GDB) $(ALLIANCE_BIN)/dreal
 COUGAR       = MBK_OUT_LO=al; export MBK_OUT_LO; \
                MBK_SEPAR='.'; export MBK_SEPAR;  \
                $(ALLIANCE_BIN)/cougar
 DRUC         = $(ALLIANCE_BIN)/druc
 L2P          = $(ALLIANCE_BIN)/l2p
 DoCHIP       = $(TOOLKIT_BIN)/doChip.py
 BLIF2VST     = $(TOOLKIT_BIN)/blif2vst.py
 COUGAR_spice = MBK_SPI_MODEL=$(ALLIANCE_TOP)/etc/spimodel.cfg; export MBK_SPI_MODEL; \
                MBK_OUT_LO=spi;                                 export MBK_OUT_LO   ; \
                $(ALLIANCE_BIN)/cougar
 LVX          = MBK_SEPAR='.'; export MBK_SEPAR; \
                $(ALLIANCE_BIN)/lvx
 PROOF        = $(ALLIANCE_BIN)/proof

 SCR          = $(ALLIANCE4_BIN)/scr

 ifneq ($(YOSYS_TOP),)
   YOSYS = $(YOSYS_BIN)/yosys
 else
   $(info "./etc/binaries.mk: YOSYS_TOP is not defined, Yosys synthesis is not available.")
 endif

 ifneq ($(AVERTEC_TOP),)
   YAGLE_CELL = $(AVERTEC_BIN)/avt_shell $(USERTOOLS)/tcl/extractCell.tcl
   YAGLE_CHIP = $(AVERTEC_BIN)/avt_shell $(USERTOOLS)/tcl/extractChip.tcl
   YAGLE_LIB  = $(AVERTEC_BIN)/avt_shell $(USERTOOLS)/tcl/buildLib.tcl
   YAGLE_RAM  = $(AVERTEC_BIN)/avt_shell $(USERTOOLS)/etc/extractRam.tcl
 else
   $(info "./etc/binaries.mk: AVERTEC_TOP is not defined, HiTas/Yagle are not availables.")
 endif
