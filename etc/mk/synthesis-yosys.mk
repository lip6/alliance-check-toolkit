
 $(info Logical synthesis is using Yosys.)

 ifeq ($(YOSYS_TOP),)
   $(error YOSYS_TOP has not been set)
 endif

 ifeq ($(YOSYS_FLATTEN),)
   YOSYS_FLATTEN = No
 endif


# -------------------------------------------------------------------
# Yosys Rules (pattern matching).

 NETLISTS_NOCORONA = $(foreach netlist,$(NETLISTS)         ,$(shell echo $(netlist) | sed 's:.*_model::'))
 NETLISTS_NOMODELS = $(foreach netlist,$(NETLISTS_NOCORONA),$(shell echo $(netlist) | sed 's:.*corona::'))
 VLOG_MODULE       = $(firstword $(NETLISTS_NOMODELS))
 NETLISTS_VST      = $(shell echo $(VLOG_MODULE) | tr '[:upper:]' '[:lower:]').vst 
 NETLISTS_SYNTH    = $(foreach netlist,$(NETLISTS_NOMODELS), $(shell echo $(netlist) | tr '[:upper:]' '[:lower:]'))
 CLEAN_SYNTHESIS   = $(addsuffix .vst,$(NETLISTS_SYNTH)) $(VLOG_MODULE).il $(VLOG_MODULE).blif $(VLOG_MODULE).tcl

 $(info | Verilog file & top model: "$(VLOG_MODULE)")
 $(info | Generated secondary VHDL structural files (vst):)
 $(foreach netlist,$(NETLISTS_SYNTH),$(info |  - "$(netlist)"))


%.il: %.py
	python3 $*.py generate -t il > $*.il


%.blif: %.v
	 yosysArgs="--input-lang=Verilog --design=$* --top=$* --liberty=$(LIBERTY_FILE)"; \
	 if [ "$(YOSYS_FLATTEN)" = "Yes" ]; then yosysArgs="$$yosysArgs --flatten"; fi;   \
	 $(call c2env, $(YOSYS_PY) $$yosysArgs)


%.blif: %.il
	 yosysArgs="--input-lang=RTLIL --design=$* --top=$* --liberty=$(LIBERTY_FILE)";  \
	 if [ "$(YOSYS_FLATTEN)" = "Yes" ]; then yosysArgs="$$yosysArgs --flatten"; fi;  \
	 $(call c2env, $(YOSYS_PY) $$yosysArgs)


# Any file put in "./non_generated/" will take precedence over the
# generation.

%.il  : ./non_generated/%.il   ;  cp $< .
%.blif: ./non_generated/%.blif ;  cp $< .


#%.blif: %.v
#	 rm -f $*.tcl; \
#	 echo "set verilog_file $*.v"                       >> $*.tcl; \
#	 echo "set verilog_top  $*"                         >> $*.tcl; \
#	 echo "set liberty_file $(LIBERTY_FILE)"            >> $*.tcl; \
#	 echo "yosys read_verilog          \$$verilog_file" >> $*.tcl; \
#	 echo "yosys hierarchy -check -top \$$verilog_top"  >> $*.tcl; \
#	 echo "yosys synth            -top \$$verilog_top"  >> $*.tcl; \
#	 if [ "$(YOSYS_FLATTEN)" = "Yes" ]; then                       \
#     echo "yosys flatten               \$$verilog_top"  >> $*.tcl; \
#     echo "yosys hierarchy        -top \$$verilog_top"  >> $*.tcl; \
#	 fi;                                                           \
#	 echo "yosys dfflibmap -liberty    \$$liberty_file" >> $*.tcl; \
#	 echo "yosys abc       -liberty    \$$liberty_file" >> $*.tcl; \
#	 echo "yosys clean"                                 >> $*.tcl; \
#	 echo "yosys write_blif $*.blif"                    >> $*.tcl;
#	 yosys -c $*.tcl

$(addsuffix .vst,$(NETLISTS_SYNTH)): $(VLOG_MODULE).blif
	-@$(call run_if_older,$@,$(VLOG_MODULE).blif,$(call scl_cols,$(call c2env, $(BLIF2VST) $(VST_FLAGS) --cell=$(VLOG_MODULE))) )
