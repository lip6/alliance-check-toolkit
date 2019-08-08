
 $(info Physical synthesis is using Coriolis.)

 ifeq ($(CORIOLIS_TOP),)
   $(error CORIOLIS_TOP has not been set)
 endif


 CLEAN_STRATUS = $(foreach netlist,$(STRATUS_NETLISTS), $(netlist).vst $(netlist).ap) \


# -------------------------------------------------------------------
# Coriolis Rules.

 ifeq ($(USE_KITE),Yes)
   DoCHIP_FLAGS += --kite
 endif

 ifeq ($(CORE),)
   CORE_NETLIST = $(firstword $(NETLISTS))
 else
   CORE_NETLIST = $(CORE)
 endif


 ifeq ($(REAL_MODE),Yes)

   $(info Coriolis is working in real mode (LEF & GDS))

%_r.gds: $(CORE_NETLIST).blif
	-$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) -prS --lef=$(LEF_LIBS) --blif=$*)

cgt-run: $(CORE_NETLIST).blif
	$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(VALGRIND_COMMAND) cgt -V --script=loadDesign)

 else   # REAL_MODE

   $(info Coriolis is working in symbolic mode (vst & ap))

   ifeq ($(USE_CLOCKTREE),Yes)

%_cts_r.ap  %_cts_r.vst  %_cts.vst:  $(CHIP).vst ioring.py corona.vst $(NETLISTS_VST)
	-$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) -prCTS --cell=$(CHIP))

%_cts_r.ap  %_cts_r.vst  %_cts.vst:  ioring.py $(NETLISTS_VST)
	-$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) -prGCTS --cell=$(CORE_NETLIST))

%_cts_r.ap  %_cts_r.vst  %_cts.vst:  $(NETLISTS_VST) $(DESIGN).py ioring.py
	-$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) -prCTS --script=$(DESIGN))

%_cts_r.ap  %_cts_r.vst  %_cts.vst:  $(NETLISTS_VST) ioring.py 
	-$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) -prCTS --cell=$(CORE_NETLIST))

%_cts_r.ap  %_cts_r.vst  %_cts.vst:  $(NETLISTS_VST)
	-$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) -prTS --cell=$*)

   else   # USE_CLOCKTREE

 CLEAN_PR = $(NETLISTS_VST:.vst=_r.vst) $(NETLISTS_VST:.vst=_r.ap)

%_r.ap  %_r.vst:  $(NETLISTS_VST) $(DESIGN).py ioring.py
	-$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) --script=$(DESIGN))

%_r.ap  %_r.vst:  $(NETLISTS_VST) ioring.py 
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

