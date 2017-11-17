
# -------------------------------------------------------------------
# Keep all intermediate files

.PRECIOUS:  %.ok
.PHONY:     cell-check-proof-tie_x0    \
            cell-check-proof-rowend_x0 \
            cell-check-proof-powmid_x0


# -------------------------------------------------------------------
# Cell Check Rules.

CHECKDIR=check

#CELL_CHECK_DIR = if [ ! -d "./check" ]; then mkdir "./check"; fi; cd "./check" 

clean-lib-tmp:
	@$(CELL_CHECK_DIR); rm -f *.drc *.gds *.cns *.stat *.rep *.spi *.dtx *.rcx *.stm *.vhd *.vbe

clean-lib: clean-lib-tmp
	@$(CELL_CHECK_DIR); rm -f *.ok

check-lib: $(foreach cell,$(wildcard *.ap),$(patsubst %.ap,./check/%.ok,$(cell)))

%.ok: %-druc %-proof
	touch $*.ok
	@echo "Checking of <$*> has been done."

%-druc: %.ap
	$(DRUC) $*

cell-check-proof-tie_x0:
cell-check-proof-rowend_x0:
cell-check-proof-powmid_x0:

%-proof: %.vbe %.vhd
	  sed -i -e '/ck.delayed/d' -e 's/linkage/in/' $*.vhd
	  $(VASY) -I vhd -o -a $* $*_ext
	  $(PROOF) $* $*_ext

%.vhd: %.spi
	 $(YAGLE_CELL) $(SPI_TECHNO_NAME) $*

%.spi: %.ap
	 $(COUGAR_spice) -t $*
	 #$(COUGAR_spice) -t -ar -ac $*

%-dot-lib: $(foreach cell,$(wildcard *.ap),$(patsubst %.ap,./check/%.spi,$(cell)))
	 $(CELL_CHECK_DIR); $(YAGLE_LIB) $(SPI_TECHNO_NAME) $*
	 mv -f ./check/$*.lib $*.lib.new
