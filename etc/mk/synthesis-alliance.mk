
 $(info Logical synthesis is using Alliance.)

# -------------------------------------------------------------------
# Alliance Synthesis Rules (vasy/boom/boog)

  NETLISTS_VST    = $(foreach netlist,$(NETLISTS), $(netlist).vst) 
 #NETLISTS_VST    = $(firstword $(NETLISTS)).vst 
  CLEAN_SYNTHESIS = $(foreach netlist,$(NETLISTS), $(netlist).vbe $(netlist).vst $(netlist).ap $(netlist).sp $(subst _model,,$(netlist)).vst $(subst _model,,$(netlist)).ap) 


%_model.vbe: %.vhdl ;  $(VASY) -a -p -o -I vhdl $<
%.vbe:       %.vhdl ;  $(VASY) -a -p -o -I vhdl $<

%_boog.vst: %.vbe
	$(BOOM) $(BOOMOPT) $*      $*_boom
	$(BOOG) $(BOOGOPT) $*_boom $*_boog

%.vst: %_boog.vst;  $(LOON) $(LOONOPT) $*_boog $*
