
  NETLISTS_VST    = $(foreach netlist,$(NETLISTS), $(netlist).vst) 
  CLEAN_SYNTHESIS = $(foreach netlist,$(NETLISTS), $(netlist).ap) 


%.vst: non_generated/%.vst ;  cp $< .