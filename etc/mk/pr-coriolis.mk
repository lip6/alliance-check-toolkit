
 $(info Physical synthesis is using Coriolis.)

 ifeq ($(CORIOLIS_TOP),)
   $(error CORIOLIS_TOP has not been set)
 endif


 CLEAN_STRATUS = $(foreach netlist,$(STRATUS_NETLISTS), $(netlist).vst $(netlist).ap) \


# -------------------------------------------------------------------
# Coriolis Rules.

 ifeq ($(USE_KATANA),Yes)
   DoCHIP_FLAGS += --katana
 endif


 ifeq ($(REAL_MODE),Yes)

   $(info Coriolis is working in real mode (LEF & GDS))

   NETLIST_BLIF = $(firstword $(NETLISTS))

%_r.gds: $(NETLIST_BLIF).blif
	-$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) -prS --lef=$(LEF_LIBS) --blif=$*)

cgt-run: $(NETLIST_BLIF).blif
	$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(VALGRIND_COMMAND) cgt -V --script=loadDesign)

 else   # REAL_MODE

   $(info Coriolis is working in symbolic mode (vst & ap))

   ifeq ($(USE_CLOCKTREE),Yes)

%_clocked_r.ap  %_clocked_r.vst  %_clocked.vst:  $(NETLISTS_VST) $(DESIGN).py %_chip.py
	-$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) --script=$(DESIGN))

%_clocked_r.ap  %_clocked_r.vst  %_clocked.vst:  $(NETLISTS_VST) %_chip.py 
	-$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) -prCTS --cell=$*)

%_clocked_r.ap  %_clocked_r.vst  %_clocked.vst:  $(NETLISTS_VST)
	-$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) -prTS --cell=$*)

   else   # USE_CLOCKTREE

 CLEAN_PR = $(NETLISTS_VST:.vst=_r.vst) $(NETLISTS_VST:.vst=_r.ap)

%_r.ap  %_r.vst:  $(NETLISTS_VST) $(DESIGN).py %_chip.py
	-$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) --script=$(DESIGN))

%_r.ap  %_r.vst:  $(NETLISTS_VST) %_chip.py 
	-$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) -prCS --cell=$*)

%_r.ap  %_r.vst: $(NETLISTS_VST) %.ap
	-$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) -rS --cell=$*)

%_r.ap  %_r.vst: $(NETLISTS_VST)
	-$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) -prS --cell=$*)

#%_r.ap  %_r.vst:  %.vst %.ap
#	-eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) -rS --cell=$*

   endif   # USE_CLOCKTREE

cgt-%:
	$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(VALGRIND_COMMAND) cgt -V --cell=$*)

 endif   # REAL_MODE

cgt:
	$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(VALGRIND_COMMAND) cgt -V)

