

 ifeq ($(CORIOLIS_TOP),)
   $(error "./etc/pr-coriolis.mk: CORIOLIS_TOP has not been set.")
 endif


# -------------------------------------------------------------------
# Coriolis Rules.

 ifeq ($(USE_KATANA),Yes)
   DoCHIP_FLAGS += --katana
 endif


 ifeq ($(USE_CLOCKTREE),Yes)

%_clocked_kite.ap  %_clocked_kite.vst  %_clocked.vst:  $(NETLISTS_VST) $(DESIGN).py %_chip.py
	-$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) --script=$(DESIGN))

%_clocked_kite.ap  %_clocked_kite.vst  %_clocked.vst:  $(NETLISTS_VST) %_chip.py 
	-$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) -prCTS --cell=$*)

%_clocked_kite.ap  %_clocked_kite.vst  %_clocked.vst:  $(NETLISTS_VST)
	-$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) -prTS --cell=$*)

 else   # USE_CLOCKTREE

%_kite.ap  %_kite.vst:  $(NETLISTS_VST) $(DESIGN).py %_chip.py
	-$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) --script=$(DESIGN))

%_kite.ap  %_kite.vst:  $(NETLISTS_VST) %_chip.py 
	-$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) -prCS --cell=$*)

%_kite.ap  %_kite.vst: $(NETLISTS_VST) %.ap
	-$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) -rS --cell=$*)

%_kite.ap  %_kite.vst:  $(NETLISTS_VST)
	-$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) -prS --cell=$*)

#%_kite.ap  %_kite.vst:  %.vst %.ap
#	-eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) -rS --cell=$*

 endif   # USE_CLOCKTREE

cgt:
	$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(VALGRIND_COMMAND) cgt -v)

cgt-%:
	$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(VALGRIND_COMMAND) cgt -v --cell=$*)

ispd-%: %.aux %.nets %.nodes %.pl %.scl %.wts
	$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; cgt -V --ispd-05=$*)

