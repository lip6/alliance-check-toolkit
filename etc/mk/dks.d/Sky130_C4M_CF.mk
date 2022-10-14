
export      REAL_MODE = Yes
export      CELLS_TOP = $(PDKMASTER_TOP)/libs.ref
export   LIBERTY_FILE = $(CELLS_TOP)/StdCellLib/liberty/StdCellLib_nom.lib
export MBK_TARGET_LIB = ${CELLS_TOP}/StdCellLib/vhdl
export   MBK_CATA_LIB = $(MBK_TARGET_LIB)

ifneq ($(PDKMASTER_TOP),)
  ifeq ($(wildcard $(PDKMASTER_TOP)),)
    $(error [ERROR] PDK Master "$(PDKMASTER_TOP)" not found.)
  endif
  ifeq ($(wildcard $(LIBERTY_FILE)),)
    $(error [ERROR] Liberty file "$(LIBERTY_FILE)" not found.)
  endif
endif

ifneq ($(CUSTOM_LIB),)
  export MBK_CATA_LIB+=:$(CUSTOM_LIB)
endif
$(info MBK_CATA_LIB=$(MBK_CATA_LIB))

