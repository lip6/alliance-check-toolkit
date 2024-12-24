
# -------------------------------------------------------------------
# Keep all intermediate files

.PRECIOUS:  %.ok
.PHONY:     cell-check-proof-tie_x0    \
            cell-check-proof-rowend_x0 \
            cell-check-proof-powmid_x0 \

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
cell-check-proof-sffw2r2_x1:

cell-check-proof-%: ./%.vbe ./check/%.vhd
	  $(CELL_CHECK_DIR); sed -i -e '/ck.delayed/d' -e 's/linkage/in/' $*.vhd
	  $(CELL_CHECK_DIR); $(VASY) -I vhd -o -a $* $*_ext
	  $(CELL_CHECK_DIR); $(BOOM) -l 3 -o $*_ext $*_opt
	  $(CELL_CHECK_DIR); $(PROOF) -d $* $*_opt

./check/%.vhd: ./check/%.spi
	 $(CELL_CHECK_DIR); $(YAGLE_CELL) $(SPI_TECHNO_NAME) $(SPI_FORMAT) $* $(YAGLE_OPTION)

./check/%.spi: %.ap
	 $(CELL_CHECK_DIR); $(FLATPH) -t $* $*_flat
	 $(CELL_CHECK_DIR); sed "s/[^,]*\(,[A-Z]*,.*TRANS\)/*\1/" $*_flat.ap |\
						sed "s/$*_flat/$*_rename/" |\
						sed "s/ff\([0-9]*\)\.\([ms][01]\)/ff\2 \1/" |\
						sed "s/w\([0-9]*\)_w\([0-9]*\)_nff_\([0-9]*\)\.\([ms]\)0/w\2\4 \3/"|\
						sed "s/w\([0-9]*\)_w\([0-9]*\)_nff_\([0-9]*\)\.\([ms]\)1/w\1\4 \3/" \
						> $*_rename.ap
	 $(CELL_CHECK_DIR); $(COUGAR_spice) -ar -ac -t $*_rename $*

%-dot-lib: check-lib $(foreach cell,$(wildcard *.ap),$(patsubst %.ap,./check/%.spi,$(cell)))
	 $(CELL_CHECK_DIR); $(YAGLE_LIB) $(SPI_TECHNO_NAME) $(SPI_FORMAT) $* $(YAGLE_OPTION)
	 mv -f ./check/$*.lib $*.lib.new
