
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
 DoCHIP_FLAGS += $(VST_FLAGS)

 ifeq ($(NETLISTS_PNR),)
   NETLISTS_PNR     = $(NETLISTS)
   NETLISTS_PNR_VST = $(NETLISTS_VST)
 else
   NETLISTS_PNR_VST = $(addsuffix .vst,$(NETLISTS_PNR))
 endif
 $(info | Netlist for Place & Route (PNR):)
 $(foreach netlist,$(NETLISTS_PNR_VST),$(info |  - "$(netlist)"))

 ifeq ($(CORE),)
   CORE_NETLIST = $(word 1, $(NETLISTS_PNR))
 else
   CORE_NETLIST = $(CORE)
 endif
 $(info Using core netlist:   "$(CORE_NETLIST)")

 ifneq ($(CHIP),)
   ifeq ($(CORONA),)
     CORONA = $(firstword $(filter %corona,$(NETLISTS_PNR)) )
     ifeq ($(CORONA),)
       CORONA = corona
     endif
   endif
   $(info Using corona netlist: "$(CORONA).vst")
 endif


 ifeq ($(REAL_MODE),Yes)

   $(info Coriolis is working in real mode (LEF & GDS))

%_r.gds: $(CORE_NETLIST).blif
	-$(call scl_cols,$(call c2env, $(DoCHIP) $(DoCHIP_FLAGS) -prS --lef=$(LEF_LIBS) --blif=$*))

cgt-run: $(CORE_NETLIST).blif
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -V --script=loadDesign))

 else   # REAL_MODE

   $(info Coriolis is working in symbolic mode (vst & ap))

   ifeq ($(USE_CLOCKTREE),Yes)

%_cts_r.ap  %_cts_r.vst  %_cts.vst:  $(CHIP).vst ./coriolis2/ioring.py $(CORONA).vst $(NETLISTS_PNR_VST)
	-@echo "Using implicit rule for manually created CHIP/CORONA (clock tree enabled)."
	-$(call scl_cols,$(call c2env, $(DoCHIP) $(DoCHIP_FLAGS) -prCTS --cell=$(CHIP)))
	-touch *_cts.*

%_cts_r.ap  %_cts_r.vst  %_cts.vst:  ./coriolis2/ioring.py $(NETLISTS_PNR_VST)
	-@echo "Using implicit rule for automatic CHIP/CORONA generation (clock tree enabled)."
	-$(call run_if_older,$@,$(CORE_NETLIST),$(call scl_cols,$(call c2env, $(DoCHIP) $(DoCHIP_FLAGS) -prGCTS --cell=$(CORE_NETLIST))))
	-touch *_cts.*

%_cts_r.ap  %_cts_r.vst  %_cts.vst:  ./coriolis2/ioring.py $(NETLISTS_PNR_VST) $(DESIGN).py
	-@echo "Using implicit rule for CORE/BLOCK creation from a Python design (clock tree enabled)."
	-$(call scl_cols,$(call c2env, $(DoCHIP) $(DoCHIP_FLAGS) -prCTS --script=$(DESIGN)))
	-touch *_cts.*

%_cts_r.ap  %_cts_r.vst  %_cts.vst:  ./coriolis2/ioring.py  $(NETLISTS_PNR_VST)
	-@echo "Using implicit rule for CORE/BLOCK creation from a VST netlist (clock tree enabled)."
	-$(call scl_cols,$(call c2env, $(DoCHIP) $(DoCHIP_FLAGS) -prCTS --cell=$(CORE_NETLIST)))

%_cts_r.ap  %_cts_r.vst  %_cts.vst:  $(NETLISTS_PNR_VST)
	-@echo "Using implicit rule for CORE/BLOCK creation from a VST netlist, whithout ioring.py (clock tree enabled)."
	-$(call scl_cols,$(call c2env, $(DoCHIP) $(DoCHIP_FLAGS) -prTS --cell=$*))

   else   # USE_CLOCKTREE

%_r.ap  %_r.vst:  $(NETLISTS_PNR_VST) $(DESIGN).py ./coriolis2/ioring.py
	-@echo "Using implicit rule for CORE creation from a Python design (no clock tree)."
	-$(call scl_cols,$(call c2env, $(DoCHIP) $(DoCHIP_FLAGS) --script=$(DESIGN)))

%_r.ap  %_r.vst:  $(NETLISTS_PNR_VST) ./coriolis2/ioring.py 
	-@echo "Using implicit rule for manually created CHIP/CORONA (no clock tree)."
	-$(call scl_cols,$(call c2env, $(DoCHIP) $(DoCHIP_FLAGS) -prCS --cell=$*))

%_r.ap  %_r.vst: $(NETLISTS_PNR_VST) %.ap
	-@echo "Using implicit rule for routing an already placed design."
	-$(call scl_cols,$(call c2env, $(DoCHIP) $(DoCHIP_FLAGS) -rS --cell=$*))

%_r.ap  %_r.vst: $(NETLISTS_PNR_VST)
	-@echo "Using implicit rule for CORE/BLOCK creation from a VST netlist (no clock tree)."
	-$(call scl_cols,$(call c2env, $(DoCHIP) $(DoCHIP_FLAGS) -prS --cell=$*))

#%_r.ap  %_r.vst:  %.vst %.ap
#	-eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) $(DoCHIP_FLAGS) -rS --cell=$*

   endif   # USE_CLOCKTREE

cgt-%:
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -V --cell=$*))

 endif   # REAL_MODE

cgt:
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -V))


 EXTENSIONS = _r.vst _r.ap
 ifneq ($(PLACED),Yes)
   EXTENSIONS += .ap
 endif
 CLEAN_PR = $(foreach ext, $(EXTENSIONS), $(addsuffix $(ext),$(NETLISTS_SYNTH)))
