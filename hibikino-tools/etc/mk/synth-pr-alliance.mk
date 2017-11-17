
# -------------------------------------------------------------------
# Alliance Synthesis Rules (vasy/boom/boog/loon/scr/ring)

  NETLISTS_VST    = $(foreach netlist,$(NETLISTS), $(netlist).vst) 
  CLEAN_SYNTHESIS = $(foreach netlist,$(NETLISTS), $(netlist).vbe $(netlist).vst $(netlist).ap $(netlist).sp $(subst _model,,$(netlist)).vst $(subst _model,,$(netlist)).ap) 
  CLEAN_SYNTHESIS += $(CORE).ap


%_model.vbe: %.vhdl ;  $(VASY) -a -p -o -I vhdl $<
%.vbe:       %.vhdl ;  $(VASY) -a -p -o -I vhdl $<

%_boog.vst: %.vbe
	$(BOOM) $(BOOMOPT) $*      $*_boom
	$(BOOG) $(BOOGOPT) $*_boom $*_boog

%.vst: %_boog.vst;  $(LOON) $(LOONOPT) $*_boog $*



%.ap : $(NETLISTS_VST) %.vst
	$(SCR) -l $(LO_NUM) -p -r i 1000 $* $*

$(CHIP).ap:$(CHIP).vst $(CORE).ap
#	cp $(SRCDIR)/chip_layout/$(CHIP).rin ./ 
#	cp $(SRCDIR)/chip_layout/$(CHIP).vst ./ 
	$(ENV_RING);$(GDB) $(RING) $(CHIP) $(CHIP) $(RING_OPT)
