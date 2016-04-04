# -*- explicit-buffer-name: "rules.mk<alliance-check-toolkit>" -*-

 UNAME_S          = $(shell uname -s)
 UNAME_R          = $(shell uname -r)
 UNAME_M          = $(shell uname -m)

 LIB_SUFFIX  = ""
 LIB_SUFFIX_ = ""
 ifeq ($(UNAME_M),x86_64)
   LIB_SUFFIX  = 64
   LIB_SUFFIX_ = _64
 endif

# We must use devtoolset-2 only under SL6.
 BUILD_VARIANT    = Linux
 USE_DEVTOOLSET_2 = No
 ifeq ($(UNAME_S),Linux)
   ifneq ($(findstring .el6.,$(UNAME_R)),)
     USE_DEVTOOLSET_2 = Yes
     BUILD_VARIANT    = Linux.slsoc6x
   endif
   ifneq ($(findstring .slsoc6.,$(UNAME_R)),)
     USE_DEVTOOLSET_2 = Yes
     BUILD_VARIANT    = Linux.slsoc6x
   endif
   ifneq ($(findstring .el7.,$(UNAME_R)),)
     BUILD_VARIANT    = Linux.el7
   endif
 endif


# -------------------------------------------------------------------
# User Detection, for Lazy People...

 DEBUG_OPTION   = 
 BUILD_TYPE_DIR = Release.Shared
 ifeq ($(USE_DEBUG),Yes)
   DEBUG_OPTION   = --debug
   BUILD_TYPE_DIR = Debug.Shared
 endif

 VALGRIND_COMMAND =
 ifeq ($(USE_DEBUG),Yes)
  #VALGRIND_COMMAND = valgrind --keep-stacktraces=alloc-and-free --read-var-info=yes --trace-children=yes
  #VALGRIND_COMMAND = valgrind --keep-stacktraces=alloc-and-free --read-var-info=yes --trace-children=yes --free-fill=0xff
 endif

 ifeq ($(USER),jpc)
  # Where Jean-Paul Chaput gets his tools installeds.

   CORIOLIS_TOP      = $(HOME)/coriolis-2.x/$(BUILD_VARIANT)$(LIB_SUFFIX_)/$(BUILD_TYPE_DIR)/install
   ALLIANCE_TOP      = $(HOME)/alliance/$(BUILD_VARIANT)$(LIB_SUFFIX_)/install
   ALLIANCE_TOOLKIT  = $(HOME)/coriolis-2.x/src/alliance-check-toolkit/benchs
   AVERTEC_TOP       = /dsk/l1/tasyag/Linux.el7_64/install
   AVERTEC_BIN       = $(AVERTEC_TOP)/bin
   YOSYS             = /usr/bin/yosys
 endif
 ifeq ($(USER),nshimizu)
  # Where Naohiko Shimizu gets his tools installeds.

   USE_NSL           = Yes
   CORIOLIS_TOP      = $(HOME)/coriolis-2.x/Cygwin.W8/$(BUILD_TYPE_DIR)/install
   ALLIANCE_TOP      = /opt/alliance
   ALLIANCE_TOOLKIT  = $(HOME)/coriolis-2.x/src/alliance-check-toolkit/benchs
 endif
 ifeq ($(USER),alnurn)
  # Where Gabriel Gouvine gets his tools installeds.

   CORIOLIS_TOP      = $(HOME)/coriolis-2.x/$(BUILD_VARIANT)$(LIB_SUFFIX_)/$(BUILD_TYPE_DIR)/install
   ALLIANCE_TOP      = /soc/alliance
   ALLIANCE_TOOLKIT  = $(HOME)/coriolis-2.x/src/alliance-check-toolkit/benchs
 endif
 ifeq ($(USER),coriolis)
   NIGHTLY = 
   ifneq ($(findstring nightly,$(shell pwd)),)
    # Assume this is the nightly build.
     NIGHTLY = /nightly
   endif

   DEBUG_OPTION      =
   BUILD_TYPE_DIR    = Release.Shared

   CORIOLIS_TOP      = $(HOME)$(NIGHTLY)/coriolis-2.x/$(BUILD_VARIANT)$(LIB_SUFFIX_)/$(BUILD_TYPE_DIR)/install
   ALLIANCE_TOP      = /soc/alliance
   ALLIANCE_TOOLKIT  = $(HOME)$(NIGHTLY)/coriolis-2.x/src/alliance-check-toolkit/benchs
 endif

# Secondary variables.
 PATTERNS  = patterns
 DESIGN    = design

# Standart System binary access paths.
 STANDART_BIN      = /usr/bin:/bin:/usr/sbin:/sbin

# Run in the source tree only.
 ALLIANCE_BIN      = $(ALLIANCE_TOP)/bin
 SYSCONF_TOP       = $(ALLIANCE_TOP)/etc
 CELLS_TOP         = $(ALLIANCE_TOP)/cells
 SPI_MODEL         = $(SYSCONF_TOP)/spimodel.cfg

 TOOLKIT_BIN       = $(ALLIANCE_TOOLKIT)/bin
 TOOLKIT_CELLS_TOP = $(ALLIANCE_TOOLKIT)/cells
 RDS_TECHNO_MOSIS  = $(ALLIANCE_TOOLKIT)/etc/scn6m_deep_09.rds
 RDS_TECHNO_SYMB   = $(SYSCONF_TOP)/cmos.rds
 SPI_TECHNO_MOSIS  = $(ALLIANCE_TOOLKIT)/etc/scn6m_deep.hsp


# -------------------------------------------------------------------
# Absolute access pathes to binaries

VASY         = $(ALLIANCE_BIN)/vasy
BOOM         = $(ALLIANCE_BIN)/boom
BOOG         = $(ALLIANCE_BIN)/boog
LOON         = $(ALLIANCE_BIN)/loon
ASIMUT       = $(ALLIANCE_BIN)/asimut
OCP          = $(ALLIANCE_BIN)/ocp
NERO         = $(ALLIANCE_BIN)/nero
RING         = $(ALLIANCE_BIN)/ring
FLATPH       = $(ALLIANCE_BIN)/flatph
S2R          = $(ALLIANCE_BIN)/s2r
S2R_cif      = export RDS_OUT=cif; \
               $(ALLIANCE_BIN)/s2r
GRAAL        = $(ALLIANCE_BIN)/graal
DREAL        = $(ALLIANCE_BIN)/dreal
COUGAR       = MBK_OUT_LO=al; export MBK_OUT_LO; \
               MBK_SEPAR='_'; export MBK_SEPAR;  \
               $(ALLIANCE_BIN)/cougar
DRUC         = $(ALLIANCE_BIN)/druc
L2P          = $(ALLIANCE_BIN)/l2p
DoCHIP       = $(TOOLKIT_BIN)/doChip.py
BLIF2VST     = $(TOOLKIT_BIN)/blif2vst.py
COUGAR_SPICE = MBK_SPI_MODEL=$(ALLIANCE_TOP)/etc/spimodel.cfg; export MBK_SPI_MODEL; \
               MBK_OUT_LO=spi;                                 export MBK_OUT_LO   ; \
               $(ALLIANCE_BIN)/cougar
LVX          = MBK_SEPAR='_'; export MBK_SEPAR; \
               $(ALLIANCE_BIN)/lvx
PROOF        = $(ALLIANCE_BIN)/proof
YAGLE_CELL   = $(AVERTEC_BIN)/avt_shell $(TOOLKIT_BIN)/extractCell.tcl
YAGLE_LIB    = $(AVERTEC_BIN)/avt_shell $(TOOLKIT_BIN)/buildLib.tcl


# -------------------------------------------------------------------
# Misc. Rules.

 export ALLIANCE_TOP
 export CORIOLIS_TOP
 export AVERTEC_TOP
 export GRAAL_TECHNO_NAME = ${SYSCONF_TOP}/cmos.graal
 export MBK_IN_LO         = vst
 export MBK_OUT_LO        = vst
 export RDS_IN            = gds
 export RDS_OUT           = gds

 ifeq ($(LIBRARY_FAMILY),nsxlib)
   export    MBK_TARGET_LIB = ${TOOLKIT_CELLS_TOP}/nsxlib
   export      MBK_CATA_LIB = $(MBK_TARGET_LIB):${TOOLKIT_CELLS_TOP}/mpxlib:$(TOOLKIT_CELLS_TOP)/msplib
   export   RDS_TECHNO_NAME = ${RDS_TECHNO_MOSIS}
            SPI_TECHNO_NAME = ${SPI_TECHNO_MOSIS}
 else
   ifeq ($(LIBRARY_FAMILY),msxlib)
     export    MBK_TARGET_LIB = ${TOOLKIT_CELLS_TOP}/msxlib
     export      MBK_CATA_LIB = $(MBK_TARGET_LIB):${TOOLKIT_CELLS_TOP}/mpxlib:$(TOOLKIT_CELLS_TOP)/msplib
     export   RDS_TECHNO_NAME = ${RDS_TECHNO_MOSIS}
   else
     export    MBK_TARGET_LIB = ${CELLS_TOP}/sxlib
     export             DPLIB = ${CELLS_TOP}/dp_sxlib
     export             RFLIB = ${CELLS_TOP}/rflib
     export            RF2LIB = ${CELLS_TOP}/rf2lib
     export            RAMLIB = ${CELLS_TOP}/ramlib
     export      MBK_CATA_LIB = $(MBK_TARGET_LIB):$(DPLIB):$(RFLIB):$(RF2LIB):$(RAMLIB):${CELLS_TOP}/pxlib
     export   RDS_TECHNO_NAME = ${RDS_TECHNO_SYMB}
   endif
 endif


# -------------------------------------------------------------------
# Keep all intermediate files

ifeq ($(USE_SYNTHESIS),Yosys)
  NETLISTS_VST = $(firstword $(NETLISTS)).vst 
else
  NETLISTS_VST = $(foreach netlist,$(NETLISTS), $(netlist).vst) 
endif

path:; @echo $(PATH)
env: ; @echo "NETLISTS_VST = \"$(NETLISTS_VST)\""


# -------------------------------------------------------------------
# Keep all intermediate files

.SECONDARY:
.PRECIOUS:  %.ok
.PHONY:     cell-check-proof-tie_x0    \
            cell-check-proof-rowend_x0 \
            cell-check-proof-powmid_x0


# -------------------------------------------------------------------
# Cell Check Rules.

CELL_CHECK_DIR = if [ ! -d "./check" ]; then mkdir "./check"; fi; cd "./check"

clean-lib-tmp:
	@$(CELL_CHECK_DIR); rm -f *.drc *.gds *.cns *.stat *.rep *.spi *.dtx *.rcx *.stm *.vhd *.vbe

clean-lib: clean-lib-tmp
	@$(CELL_CHECK_DIR); rm -f *.ok

check-lib: $(foreach cell,$(wildcard *.ap),$(patsubst %.ap,./check/%.ok,$(cell)))

./check/%.ok: cell-check-druc-% cell-check-proof-%
	@$(CELL_CHECK_DIR); touch $*.ok
	@echo "Checking of <$*> has been done."

cell-check-druc-%: %.ap
	 $(CELL_CHECK_DIR); $(DRUC) $*

cell-check-proof-tie_x0:
cell-check-proof-rowend_x0:
cell-check-proof-powmid_x0:

cell-check-proof-%: ./%.vbe ./check/%.vhd
	  $(CELL_CHECK_DIR); sed -i -e '/ck.delayed/d' -e 's/linkage/in/' $*.vhd
	  $(CELL_CHECK_DIR); $(VASY) -I vhd -o -a $* $*_ext
	  $(CELL_CHECK_DIR); $(PROOF) $* $*_ext

./check/%.vhd: ./check/%.spi
	 $(CELL_CHECK_DIR); $(YAGLE_CELL) $(SPI_TECHNO_NAME) $*

./check/%.spi: %.ap
	 $(CELL_CHECK_DIR); $(COUGAR_SPICE) -ar -ac -t $*

%-dot-lib: $(foreach cell,$(wildcard *.ap),$(patsubst %.ap,./check/%.spi,$(cell)))
	 $(CELL_CHECK_DIR); $(YAGLE_LIB) $(SPI_TECHNO_NAME) $*
	 mv -f ./check/$*.lib $*.lib.new


# -------------------------------------------------------------------
# Yosys Rules (pattern matching).

ifeq ($(USE_SYNTHESIS),Yosys)

%.blif: %.v %.ys
	$(YOSYS) -s $*.ys

ifeq ($(USE_DEVTOOLSET_2),Yes)

%.vst: %.blif
	-@scl enable devtoolset-2 'eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	                           $(BLIF2VST) $*'

else

%.vst: %.blif
	-@eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(BLIF2VST) $*

endif

endif


# -------------------------------------------------------------------
# Alliance Rules (pattern matching).

ifeq ($(USE_SYNTHESIS),Alliance)

ifeq ($(USE_NSL),Yes)
%.vhdl: %.nsl  ; nsl2vh $(NSL2VHOPT) $<
endif

#%.vhd:%.nsl
#	nsl2vh $< $(NSL2VHOPT)
#	sed 's/\r//g' $*.vhdl > $@

%_model.vbe: %.vhdl ;  $(VASY) -a -p -o -I vhdl $<
%.vbe:       %.vhdl ;  $(VASY) -a -p -o -I vhdl $<

%_boog.vst: %.vbe
	$(BOOM) $(BOOMOPT) $*      $*_boom
	$(BOOG) $(BOOGOPT) $*_boom $*_boog

%.vst: %_boog.vst;  $(LOON) $(LOONOPT) $*_boog $*

else

%.vst    : non_generated/%.vst ;  cp $< .

endif

asimut-%  : %.vst $(PATTERNS).pat;  $(ASIMUT)       -zd -nores $* patterns

ifeq ($(USE_ALLIANCE_PR),Yes)
%_ocp.ap  : %.vst                ;  $(OCP)          -margin $(MARGIN) -ring $* $*_ocp
%.ap      : %.vst %_ocp.ap       ;  $(NERO)         -p $*_ocp $* $*
%_flat.ap : %.ap                 ;  $(FLATPH)       -t $* $*_flat

$(CHIP).ap: $(CHIP).vst $(CORE).vst $(CORE).ap; ring $(CHIP) $(CHIP)
ring_debug: $(CHIP).vst $(CORE).vst $(CORE).ap; ring $(CHIP) $(CHIP) debug
ring_gdb:   $(CHIP).vst $(CORE).vst $(CORE).ap; gdb ring
endif

%.gds     : %.ap                 ;  $(S2R)          -v -r $*
%.cif     : %.ap                 ;  $(S2R_cif)      -v -r $*
%.spi     : %.ap                 ;  $(COUGAR_SPICE) -ar -ac -t $*
%.ps      : %.ap                 ;  $(L2P)          -color $*
druc-%    : %.ap                 ;  $(DRUC)         $(DRUC_FLAGS) $*
%_ext.al  : %.ap                 ;  $(COUGAR)       -f $* $*_ext
lvx-%     : %.vst %_ext.al       ;  $(LVX)          vst al $* $*_ext -f
lvx-%_kite: %.vst %_kite_ext.al  ;  $(LVX)          vst al $* $*_kite_ext -f
dreal-%   : %.gds                ;  $(DREAL)        --debug -l $*
graal-%   : %.ap                 ;  $(GRAAL)        -l $*
graal     :                      ;  $(GRAAL)


# -------------------------------------------------------------------
# Coriolis Rules.


ifeq ($(USE_DEVTOOLSET_2),Yes)


ifeq ($(USE_CLOCKTREE),Yes)

%_clocked_kite.ap  %_clocked_kite.vst  %_clocked.vst:  $(NETLISTS_VST) $(DESIGN).py %_chip.py
	-@scl enable devtoolset-2 'eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	                           $(DoCHIP) --script=$(DESIGN)'

%_clocked_kite.ap  %_clocked_kite.vst  %_clocked.vst:  $(NETLISTS_VST) %_chip.py 
	-@scl enable devtoolset-2 'eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	                           $(DoCHIP) -prCTS --cell=$*'

%_clocked_kite.ap  %_clocked_kite.vst  %_clocked.vst:  $(NETLISTS_VST)
	-@scl enable devtoolset-2 'eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	                           $(DoCHIP) -prTS --cell=$*'

else

%_kite.ap  %_kite.vst:  $(NETLISTS_VST) $(DESIGN).py %_chip.py
	-@scl enable devtoolset-2 'eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	                           $(DoCHIP) --script=$(DESIGN)'

%_kite.ap  %_kite.vst:  $(NETLISTS_VST) %_chip.py
	-@scl enable devtoolset-2 'eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	                           $(DoCHIP) --cell=$*'

%_kite.ap  %_kite.vst:  $(NETLISTS_VST) %.ap
	-@scl enable devtoolset-2 'eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	                           $(DoCHIP) -rS --cell=$*'

%_kite.ap  %_kite.vst:  $(NETLISTS_VST)
	-@scl enable devtoolset-2 'eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	                           $(DoCHIP) -prS --cell=$*'

endif

%: %.aux %.nets %.nodes %.pl %.scl %.wts
	@scl enable devtoolset-2 'eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	                          cgt -V --ispd-05=$*'
cgt:
	@scl enable devtoolset-2 'eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	                          cgt -V'

cgt-%:
	@scl enable devtoolset-2 'eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	                          cgt -V -c $*'


else


ifeq ($(USE_CLOCKTREE),Yes)

%_clocked_kite.ap  %_clocked_kite.vst  %_clocked.vst:  $(NETLISTS_VST) $(DESIGN).py %_chip.py
	-@eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) --script=$(DESIGN)

%_clocked_kite.ap  %_clocked_kite.vst  %_clocked.vst:  $(NETLISTS_VST) %_chip.py 
	-@eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) -prCTS --cell=$*

%_clocked_kite.ap  %_clocked_kite.vst  %_clocked.vst:  $(NETLISTS_VST)
	-@eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) -prTS --cell=$*

else

%_kite.ap  %_kite.vst:  $(NETLISTS_VST) $(DESIGN).py %_chip.py
	-@eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) --script=$(DESIGN)

%_kite.ap  %_kite.vst:  $(NETLISTS_VST) %_chip.py 
	-@eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) -prCTS --cell=$*

%_kite.ap  %_kite.vst: $(NETLISTS_VST) %.ap
	-@eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) -rS --cell=$*

%_kite.ap  %_kite.vst:  $(NETLISTS_VST)
	-@eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) -prTS --cell=$*

endif

cgt:
	@eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(VALGRIND_COMMAND) cgt -v

cgt-%:
	@eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(VALGRIND_COMMAND) cgt -v --cell=$*

ispd-%: %.aux %.nets %.nodes %.pl %.scl %.wts
	@eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; cgt -V --ispd-05=$*


endif


# -------------------------------------------------------------------
# Cleaning Rules.

 CLEAN_CHIP = *.ps                      \
              *.xsc                     \
              *.al                      \
              *.drc                     \
              *.gds                     \
              *.cif                     \
              alldata.dat               \
              *_clocked*                \
              *_ext*                    \
              *_boom*                   \
              *_boog*                   \
              *_loon*                   \
              *_kite*                   \
              *_u[0-9][0-9]*            \
              *.pyc                     \
              *.log

 ifeq ($(USE_SYNTHESIS),Alliance)
   CLEAN_SYNTHESIS = $(foreach netlist,$(NETLISTS), $(netlist).vbe $(netlist).vst $(netlist).ap $(netlist).sp $(subst _model,,$(netlist)).vst $(subst _model,,$(netlist)).ap) 
 endif
 ifeq ($(USE_SYNTHESIS),Yosys)
   CLEAN_SYNTHESIS = *.blif $(foreach netlist,$(NETLISTS), $(netlist).vst $(netlist).ap) 
 endif

 ifeq ($(USE_STRATUS),Yes)
   CLEAN_STRATUS = *.vst *.ap
 endif

clean:
	-rm -f $(CLEAN_CHIP) $(CLEAN_SYNTHESIS) $(CLEAN_STRATUS)
