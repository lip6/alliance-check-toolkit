
# -------------------------------------------------------------------
# Macro-Generator Check Rules.

.PRECIOUS:  %.ok

MACRO_CHECK_DIR = if [ ! -d "./check" ]; then mkdir "./check"; fi; cd "./check"

CLEAN_SYNTHESIS = macro*.ap macro*.vst macro*.vhd ./check/*.ok


./check/macro%.ok: lvx-macro%_kite druc-macro%_kite
	@$(MACRO_CHECK_DIR); touch macro$*.ok
	@echo "Checking of <macro$*> has been done."


macro%_kite.ap macro%_kite.vst: ./check/generate.py
	$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	                     ./check/generate.py -m macro$* $(foreach param,$(subst _p_, ,$*), -$(subst _, ,$(param))))
	$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) -rS --cell=macro$*)


%.vhd: %.spi
	 $(YAGLE_RAM) $(SPI_TECHNO_NAME) $*

%.spi: %.ap
	 $(COUGAR_spice) -ar -ac -t $*

cgt:
	$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(VALGRIND_COMMAND) cgt -v)

cgt-%:
	$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(VALGRIND_COMMAND) cgt -v --cell=$*)
