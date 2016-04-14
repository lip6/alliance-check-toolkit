

 ifeq ($(YOSYS_TOP),)
   $(error "./etc/mk/synthesis-yosys.mk: YOSYS_TOP has not been set.")
 endif


# -------------------------------------------------------------------
# Yosys Rules (pattern matching).

 NETLISTS_VST    = $(firstword $(NETLISTS)).vst 
 CLEAN_SYNTHESIS = $(foreach netlist,$(NETLISTS), $(netlist).vst $(netlist).ap) \
                   *.blif


%.blif: %.v %.ys
	$(YOSYS) -s $*.ys

%.vst: %.blif
	-@$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(BLIF2VST) $*)
