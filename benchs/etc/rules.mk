
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
 endif
 ifeq ($(USER),nshimizu)
  # Where Naohiko Shimizu gets his tools installeds.

   CORIOLIS_TOP      = $(HOME)/coriolis-2.x/Cygwin.W8/$(BUILD_TYPE_DIR)/install
   ALLIANCE_TOP      = /opt/alliance/
   ALLIANCE_TOOLKIT  = $(HOME)/coriolis-2.x/src/alliance-check-toolkit/benchs
 endif
 ifeq ($(USER),alnurn)
  # Where Gabriel Gouvine gets his tools installeds.

   CORIOLIS_TOP      = $(HOME)/coriolis-2.x/$(BUILD_VARIANT)$(LIB_SUFFIX_)/$(BUILD_TYPE_DIR)/install
   ALLIANCE_TOP      = /soc/alliance/
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
   ALLIANCE_TOP      = /soc/alliance/
   ALLIANCE_TOOLKIT  = $(HOME)$(NIGHTLY)/coriolis-2.x/src/alliance-check-toolkit/benchs
 endif

# Secondary variables.
 PATTERNS = patterns
 DESIGN   = design
 ifeq ($(USE_STRATUS),Yes)
   ALLIANCE_CHIP = $(CHIP)_alc
   CORIOLIS_CORE = $(CORE)_core
 else
   ALLIANCE_CHIP = $(CHIP)_alc
   CORIOLIS_CORE = $(CORE)_crl
 endif

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
S2R          = $(ALLIANCE_BIN)/s2r
GRAAL        = $(ALLIANCE_BIN)/graal
DREAL        = $(ALLIANCE_BIN)/dreal
COUGAR       = MBK_OUT_LO=al; export MBK_OUT_LO; \
               MBK_SEPAR='_'; export MBK_SEPAR;  \
               $(ALLIANCE_BIN)/cougar
DRUC         = $(ALLIANCE_BIN)/druc
L2P          = $(ALLIANCE_BIN)/l2p
DoCHIP       = $(TOOLKIT_BIN)/doChip.py
COUGAR_SPICE = MBK_SPI_MODEL=$(ALLIANCE_TOP)/spimodel.cfg; export MBK_SPI_MODEL; \
               MBK_OUT_LO=sp;                              export MBK_OUT_LO   ; \
               $(ALLIANCE_BIN)/cougar
LVX          = MBK_SEPAR='_'; export MBK_SEPAR; \
               $(ALLIANCE_BIN)/lvx


# -------------------------------------------------------------------
# Misc. Rules.

 export ALLIANCE_TOP
 export CORIOLIS_TOP
 export GRAAL_TECHNO_NAME = ${SYSCONF_TOP}/cmos.graal

 ifeq ($(USE_MOSIS),Yes)
   export    MBK_TARGET_LIB = ${TOOLKIT_CELLS_TOP}/msxlib
   export      MBK_CATA_LIB = $(MBK_TARGET_LIB):${TOOLKIT_CELLS_TOP}/mpxlib:$(TOOLKIT_CELLS_TOP)/msplib
   export   RDS_TECHNO_NAME = ${RDS_TECHNO_MOSIS}
 else
   export    MBK_TARGET_LIB = ${CELLS_TOP}/sxlib
   export             DPLIB = ${CELLS_TOP}/dp_sxlib
   export      MBK_CATA_LIB = $(MBK_TARGET_LIB):$(DPLIB):${CELLS_TOP}/pxlib
   export   RDS_TECHNO_NAME = ${RDS_TECHNO_SYMB}
 endif


path:; @echo $(PATH)


# -------------------------------------------------------------------
# Keep all intermediate files

.SECONDARY:



# -------------------------------------------------------------------
# Alliance Rules (pattern matching).

ifeq ($(GENERATE_CORE_VST),Yes)

#%.vhd:%.nsl Makefile
#	nsl2vh $< $(NSL2VHOPT)
#	sed 's/\r//g' $*.vhdl > $@

%.vbe: %.vhd;  $(VASY) -a -p -o -I vhd $<

%_boog.vst: %.vbe
	$(BOOM) $(BOOMOPT) $*      $*_boom
	$(BOOG) $(BOOGOPT) $*_boom $*_boog

%.vst: %_boog.vst;  $(LOON) $(LOONOPT) $*_boog $*

endif

asimut-%  : %.vst $(PATTERNS).pat;  $(ASIMUT)       -zd -nores $* patterns
%_ocp.ap  : %.vst                ;  $(OCP)          -margin $(MARGIN) -ring $* $*_ocp
%.ap      : %.vst %_ocp.ap       ;  $(NERO)         -p $*_ocp $* $*
%.gds     : %.ap                 ;  $(S2R)          -v -r $*
%.spi     : %.ap                 ;  $(COUGAR_SPICE) -ar -ac -t $(CORE)
%.ps      : %.ap                 ;  $(L2P)          -color $*
druc-%    : %.ap                 ;  $(DRUC)         $*
%_ext.al  : %.ap                 ;  $(COUGAR)       -f $* $*_ext
lvx-%     : %.vst %_ext.al       ;  $(LVX)          vst al $* $*_ext -f
lvx-%_kite: %.vst %_kite_ext.al  ;  $(LVX)          vst al $* $*_kite_ext -f
dreal-%   : %.gds                ;  $(DREAL)        -l $*
graal-%   : %.ap                 ;  $(GRAAL)        -l $*
graal     :                      ;  $(GRAAL)


# Alliance Rules (variables dependants). 

$(ALLIANCE_CHIP).ap: $(ALLIANCE_CHIP).vst $(CORE).vst $(CORE).ap
	ring $(ALLIANCE_CHIP) $(ALLIANCE_CHIP)

ring_debug: $(ALLIANCE_CHIP).vst $(CORE).vst $(CORE).ap
	ring $(ALLIANCE_CHIP) $(ALLIANCE_CHIP) debug

ring_gdb: $(ALLIANCE_CHIP).vst $(CORE).vst $(CORE).ap
	gdb ring


# -------------------------------------------------------------------
# Coriolis Rules.

%.vst    : non_generated/%.vst ;  cp   $< .
%_crl.vst: %.vst               ;  sed 's,\<$*\>,$*_crl,g' $< > $@


ifeq ($(USE_DEVTOOLSET_2),Yes)


ifeq ($(USE_CLOCKTREE),Yes)

%_clocked_kite.ap  %_clocked.vst:  $(DESIGN).py  %_chip.py  $(CONTROL).vst
	-@scl enable devtoolset-2 'eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	                           $(DoCHIP) --script=$(DESIGN)'

%_clocked_kite.ap  %_clocked.vst:  $(CORIOLIS_CORE).vst  %.vst  %_chip.py
	-@scl enable devtoolset-2 'eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	                           $(DoCHIP) --cell=$*'

else

%_kite.ap  %_kite.vst:  $(DESIGN).py  %_chip.py  $(CONTROL).vst
	-@scl enable devtoolset-2 'eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	                           $(DoCHIP) --script=$(DESIGN)'

%_kite.ap  %_kite.vst:  $(CORIOLIS_CORE).vst  %.vst  %_chip.py
	-@scl enable devtoolset-2 'eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	                           $(DoCHIP) --cell=$*'

endif

%: %.aux %.nets %.nodes %.pl %.scl %.wts
	@scl enable devtoolset-2 'eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	                          cgt -V --ispd-05=$*'
cgt:
	@scl enable devtoolset-2 'eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	                          cgt -V'


else


ifeq ($(USE_CLOCKTREE),Yes)

%_clocked_kite.ap  %_clocked_kite.vst  %_clocked.vst:  $(DESIGN).py  %_chip.py  $(CONTROL).vst
	-@eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) --script=$(DESIGN)

%_clocked_kite.ap  %_clocked_kite.vst  %_clocked.vst:  $(CORIOLIS_CORE).vst  %.vst  %_chip.py
	-@eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) --cell=$*

else

%_kite.ap  %_kite.vst:  $(DESIGN).py  %_chip.py  $(CONTROL).vst
	-@eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) --script=$(DESIGN)

%_kite.ap  %_kite.vst: $(CORIOLIS_CORE).vst  %.vst  %_chip.py
	-@eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(DoCHIP) --cell=$*

endif

cgt-view-%: %.ap
	-@eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; cgt -V --cell=$*

cgt:
	@eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(VALGRIND_COMMAND) cgt -v

ispd-%: %.aux %.nets %.nodes %.pl %.scl %.wts
	@eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; cgt -V --ispd-05=$*


endif


# -------------------------------------------------------------------
# Cleaning Rules.

 CLEAN_CHIP = *.ps                      \
              $(ALLIANCE_CHIP)_ext.al   \
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
              *.pyc

 ifeq ($(GENERATE_CORE_VST),Yes)
   CLEAN_CORE = $(CORE).vst           \
                $(CORE).xsc           \
                $(CORE).sp            \
                $(CORE).vbe           \
                $(CORIOLIS_CORE).vst  \
                $(CORE).ap    
 else	
   CLEAN_CORE = $(CORIOLIS_CORE).vst
 endif
 ifeq ($(USE_STRATUS),Yes)
   CLEAN_STRATUS = *.vst
 else	
   CLEAN_STRATUS = 
 endif

clean:
	-rm -f $(CLEAN_CHIP) $(CLEAN_CORE) $(CLEAN_STRATUS) *.ap
