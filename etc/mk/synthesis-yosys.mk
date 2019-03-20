
 $(info Logical synthesis is using Yosys.)

 ifeq ($(YOSYS_TOP),)
   $(error YOSYS_TOP has not been set)
 endif


# -------------------------------------------------------------------
# Yosys Rules (pattern matching).

 VLOG_MODULE     = $(firstword $(NETLISTS))
 NETLISTS_VST    = $(shell echo $(VLOG_MODULE) | tr '[:upper:]' '[:lower:]').vst 
 NETLISTS_LOWER  = $(foreach netlist,$(NETLISTS), $(shell echo $(netlist) | tr '[:upper:]' '[:lower:]'))
 CLEAN_SYNTHESIS = $(foreach netlist,$(NETLISTS_LOWER), $(netlist).vst $(netlist).ap) \
                   $(VLOG_MODULE).blif $(VLOG_MODULE).tcl


%.blif: %.v
	 rm -f $*.tcl; \
	 echo "set verilog_file $*.v"                       >> $*.tcl; \
	 echo "set verilog_top  $*"                         >> $*.tcl; \
	 echo "set liberty_file $(LIBERTY_FILE)"            >> $*.tcl; \
	 echo "yosys read_verilog          \$$verilog_file" >> $*.tcl; \
	 echo "yosys hierarchy -check -top \$$verilog_top"  >> $*.tcl; \
	 echo "yosys synth            -top \$$verilog_top"  >> $*.tcl; \
	 echo "yosys dfflibmap -liberty    \$$liberty_file" >> $*.tcl; \
	 echo "yosys abc       -liberty    \$$liberty_file" >> $*.tcl; \
	 echo "yosys clean"                                 >> $*.tcl; \
	 echo "yosys write_blif $*.blif"                    >> $*.tcl;
	 yosys -c $*.tcl

$(NETLISTS_VST): $(VLOG_MODULE).blif
	-@$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(BLIF2VST) $(VLOG_MODULE))
