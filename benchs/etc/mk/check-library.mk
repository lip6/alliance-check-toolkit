
# -------------------------------------------------------------------
# Keep all intermediate files

.PRECIOUS:  %.ok
.PHONY:     cell-check-proof-tie_x0    \
            cell-check-proof-rowend_x0 \
            cell-check-proof-powmid_x0 \

#           ./check/ao2o22_x2.ok \
#           ./check/ao2o22_x4.ok


# -------------------------------------------------------------------
# Cell Check Rules.

CELL_CHECK_DIR = if [ ! -d "./check" ]; then mkdir "./check"; fi; cd "./check"

clean-lib-tmp:
	@$(CELL_CHECK_DIR); rm -f *.drc *.gds *.cns *.stat *.rep *.spi *.dtx *.rcx *.stm *.vhd *.vbe

clean-lib: clean-lib-tmp
	@$(CELL_CHECK_DIR); rm -f *.ok

check-lib: $(foreach cell,$(wildcard *.ap),$(patsubst %.ap,./check/%.ok,$(cell)))

./check/%.ok: cell-check-druc-% cell-check-proof-%
	@$(CELL_CHECK_DIR); touch $*.ok
	@echo "Checking of <$*> has been done."

cell-check-druc-%: %.ap
	 $(CELL_CHECK_DIR); $(DRUC) $*

cell-check-proof-tie_x0:
cell-check-proof-rowend_x0:
cell-check-proof-powmid_x0:

cell-check-proof-%: ./%.vbe ./check/%.vhd
	  $(CELL_CHECK_DIR); sed -i -e '/ck.delayed/d' -e 's/linkage/in/' $*.vhd
	  $(CELL_CHECK_DIR); $(VASY) -I vhd -o -a $* $*_ext
	  $(CELL_CHECK_DIR); $(PROOF) $* $*_ext

./check/%.vhd: ./check/%.spi
	 $(CELL_CHECK_DIR); $(YAGLE_CELL) $(SPI_TECHNO_NAME) $*

./check/%.spi: %.ap
	 $(CELL_CHECK_DIR); $(COUGAR_spice) -ar -ac -t $*

%-dot-lib: $(foreach cell,$(wildcard *.ap),$(patsubst %.ap,./check/%.spi,$(cell)))
	 $(CELL_CHECK_DIR); $(YAGLE_LIB) $(SPI_TECHNO_NAME) $*
	 mv -f ./check/$*.lib $*.lib.new
