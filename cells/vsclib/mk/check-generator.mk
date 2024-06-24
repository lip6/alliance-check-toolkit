
# -------------------------------------------------------------------
# Macro-Generator Check Rules.

.PRECIOUS:  %.ok

 export MBLOCK = $(patsubst Makefile.%,%,$(firstword $(MAKEFILE_LIST)))
 ifeq ($(MBLOCK),$(firstword $(MAKEFILE_LIST)))
   $(error [ERROR] Cannot guess MBLOCK value. The file must be named <Makefile.MBLOCK>.)
 else
   $(info check-generator.mk: Guessed value of MBLOCK : <$(MBLOCK)>.)
 endif

 MACRO_CHECK_DIR = if [ ! -d "./check" ]; then mkdir "./check"; fi; cd "./check"

 CLEAN_SYNTHESIS = $(MBLOCK)*.ap $(MBLOCK)*.vst $(MBLOCK)*.vhd ./check/*.ok


./check/%.ok: lvx-%_r druc-%_r
	@$(MACRO_CHECK_DIR); touch $*.ok
	@echo "Checking of <$*> has been done."


%_r.ap %_r.vst: ./check/generate.py
	$(call scl_cols,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	                     ./check/generate.py -m $* \
	                         $(foreach param,$(subst _p_, ,$(subst $(MBLOCK),,$*)), -$(subst _, ,$(param))))
	$(call scl_cols,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
                          $(DoCHIP) -rS --cell=$*)


%.vhd: %.spi
	 $(YAGLE_RAM) $(SPI_TECHNO_NAME) $*

%.spi: %.ap
	 $(COUGAR_spice) -ar -ac -t $*

cgt:
	$(call scl_cols,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(VALGRIND_COMMAND) cgt -v)

cgt-%:
	$(call scl_cols,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(VALGRIND_COMMAND) cgt -v --cell=$*)
