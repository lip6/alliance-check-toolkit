export REAL_MODE    = Yes
export LIBERTY_FILE = $(PDKMASTER_TOP)/libs.ref/StdCellLib/liberty/StdCellLib_nom.lib

ifneq ($(PDKMASTER_TOP),)
  ifeq ($(wildcard $(PDKMASTER_TOP)),)
    $(error [ERROR] PDK Master "$(PDKMASTER_TOP)" not found.)
  endif
  ifeq ($(wildcard $(LIBERTY_FILE)),)
    $(error [ERROR] Liberty file "$(LIBERTY_FILE)" not found.)
  endif
endif
