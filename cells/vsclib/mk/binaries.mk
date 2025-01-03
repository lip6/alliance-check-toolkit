# -*- explicit-buffer-name: "binaries.mk<alliance-check-toolkit>" -*-


 ALLIANCE_BIN      = $(ALLIANCE_TOP)/bin
 SYSCONF_TOP       = $(ALLIANCE_TOP)/etc
 CELLS_TOP         = $(ALLIANCE_TOP)/cells
 SPI_MODEL         = $(SYSCONF_TOP)/spimodel.cfg
 TOOLKIT_BIN       = $(CHECK_TOOLKIT)/bin

 AVERTEC_BIN       = $(AVERTEC_TOP)/../../bin
 YOSYS_BIN         = $(YOSYS_TOP)/bin

 PATH              = $(ALLIANCE_BIN):$(shell echo $$PATH)
 LD_LIBRARY_PATH   = $(ALLIANCE_TOP)/lib:$(shell echo $$LD_LIBRARY_PATH)

 export CELLS_TOP
 export PATH
 export LD_LIBRARY_PATH


# -------------------------------------------------------------------
# Absolute access pathes to binaries

 VASY          = $(ALLIANCE_BIN)/vasy
 BOOM          = $(ALLIANCE_BIN)/boom
 BOOG          = $(ALLIANCE_BIN)/boog
 LOON          = $(ALLIANCE_BIN)/loon
 GENPAT        = $(ALLIANCE_BIN)/genpat
 ASIMUT        = $(ALLIANCE_BIN)/asimut
 SCR           = $(ALLIANCE_BIN)/scr
 OCP           = $(ALLIANCE_BIN)/ocp
 NERO          = $(ALLIANCE_BIN)/nero
 RING          = $(ALLIANCE_BIN)/ring
 FLATLO        = $(ALLIANCE_BIN)/flatlo
 FLATPH        = $(ALLIANCE_BIN)/flatph
 S2R           = $(ALLIANCE_BIN)/s2r
 S2R_cif       = export RDS_OUT=cif; \
                 $(ALLIANCE_BIN)/s2r
 GRAAL         = $(ALLIANCE_BIN)/graal
 DREAL         = $(ALLIANCE_BIN)/dreal
 COUGAR        = MBK_OUT_LO=al; export MBK_OUT_LO; \
                 MBK_SEPAR='_'; export MBK_SEPAR;  \
                 $(ALLIANCE_BIN)/cougar
 DRUC          = $(ALLIANCE_BIN)/druc
 L2P           = $(ALLIANCE_BIN)/l2p
 DoCHIP        = $(TOOLKIT_BIN)/doChip.py
 BLIF2VST      = $(TOOLKIT_BIN)/blif2vst.py
 YOSYS_PY      = $(TOOLKIT_BIN)/yosys.py
 COUGAR_spice  = MBK_SPI_MODEL=$(SPIMODEL); export MBK_SPI_MODEL; \
                 MBK_SEPAR='_';             export MBK_SEPAR    ; \
                 MBK_OUT_LO=spi;            export MBK_OUT_LO   ; \
                 $(ALLIANCE_BIN)/cougar
 COUGAR_vst    = MBK_OUT_LO=vst;            export MBK_OUT_LO   ; \
                 $(ALLIANCE_BIN)/cougar
 LVX           = MBK_SEPAR='_'; export MBK_SEPAR; \
                 $(ALLIANCE_BIN)/lvx
 PROOF         = $(ALLIANCE_BIN)/proof


 ifneq ($(YOSYS_TOP),)
   export YOSYS = $(YOSYS_BIN)/yosys
 else
   $(info YOSYS_TOP is not defined, Yosys synthesis is not available)
 endif

 ifneq ($(AVERTEC_TOP),)
   YAGLE_CHIP = $(AVERTEC_BIN)/avt_shell $(TOOLKIT_BIN)/extractChip.tcl
   YAGLE_CELL = $(AVERTEC_BIN)/avt_shell $(TOOLKIT_BIN)/extractCell.tcl
   YAGLE_LIB  = $(AVERTEC_BIN)/avt_shell $(TOOLKIT_BIN)/buildLib.tcl
   YAGLE_RAM  = $(AVERTEC_BIN)/avt_shell $(TOOLKIT_BIN)/extractRam.tcl
 else
   $(info AVERTEC_TOP is not defined, HiTas/Yagle are not availables)
 endif
