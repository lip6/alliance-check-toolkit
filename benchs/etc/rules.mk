
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
 USE_DEVTOOLSET_2 = "No"
 ifeq ($(UNAME_S),Linux)
   ifneq ($(findstring .el6.,$(UNAME_R)),)
     USE_DEVTOOLSET_2 = "Yes"
     BUILD_VARIANT    = Linux.slsoc6x
   endif
   ifneq ($(findstring .slsoc6.,$(UNAME_R)),)
     USE_DEVTOOLSET_2 = "Yes"
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
   VALGRIND_COMMAND = valgrind --keep-stacktraces=alloc-and-free --read-var-info=yes --trace-children=yes --free-fill=0xff
 endif

 ifeq ($(USER),jpc)
   CORIOLIS_TOP      = $(HOME)/coriolis-2.x/$(BUILD_VARIANT)$(LIB_SUFFIX_)/$(BUILD_TYPE_DIR)/install
   ALLIANCE_TOP      = $(HOME)/alliance/$(BUILD_VARIANT)$(LIB_SUFFIX_)/install
   ALLIANCE_TOOLKIT  = $(HOME)/coriolis-2.x/src/alliance-check-toolkit/benchs
 endif
 ifeq ($(USER),nshimizu)
  # Hello Naohiko, you have to customize this according to where you installed
  # things on your system.

   CORIOLIS_TOP      = $(HOME)/coriolis-2.x/Cygwin.W8/$(BUILD_TYPE_DIR)/install
   ALLIANCE_TOP      = /opt/alliance/
   ALLIANCE_TOOLKIT  = $(HOME)/coriolis-2.x/src/alliance-check-toolkit/benchs
 endif
 ifeq ($(USER),alnurn)
   CORIOLIS_TOP      = $(HOME)/coriolis-2.x/$(BUILD_VARIANT)$(LIB_SUFFIX_)/$(BUILD_TYPE_DIR)/install
   ALLIANCE_TOP      = /soc/alliance/
   ALLIANCE_TOOLKIT  = $(HOME)/coriolis-2.x/src/alliance-check-toolkit/benchs
 endif

# Whether or not we uses a clock-tree.
 ifeq ($(USE_CLOCKTREE),Yes)
   CLOCKED = _clocked
 else
   CLOCKED =
 endif

# Secondary variables.
 ALLIANCE_CHIP     = $(CHIP)_alc
 CORIOLIS_CHIP     = $(CHIP)_crl
 CORIOLIS_CORE     = $(CORE)_crl

# Standart System binary access paths.
 STANDART_BIN      = /usr/bin:/bin:/usr/sbin:/sbin

# Run in the source tree only.
 ALLIANCE_BIN      = $(ALLIANCE_TOP)/bin
 SYSCONF_TOP       = $(ALLIANCE_TOP)/etc
 CELLS_TOP         = $(ALLIANCE_TOP)/cells
 SPI_MODEL         = $(SYSCONF_TOP)/spimodel.cfg

 TOOLKIT_CELLS_TOP = $(ALLIANCE_TOOLKIT)/cells
 RDS_TECHNO_MOSIS  = $(ALLIANCE_TOOLKIT)/etc/scn6m_deep_09.rds
 RDS_TECHNO_SYMB   = $(SYSCONF_TOP)/cmos.rds


# -------------------------------------------------------------------
# Absolute access pathes to binaries

GRAAL = $(ALLIANCE_BIN)/graal


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
   export      MBK_CATA_LIB = $(MBK_TARGET_LIB):${CELLS_TOP}/pxlib
   export   RDS_TECHNO_NAME = ${RDS_TECHNO_SYMB}
 endif


path:; @echo $(PATH)


# -------------------------------------------------------------------
# Keep intermediate files

.PRECIOUS: $(CORIOLIS_CHIP)$(CLOCKED).vst          $(CORIOLIS_CHIP)$(CLOCKED).ap      \
           $(CORIOLIS_CHIP)$(CLOCKED)_kite.vst     $(CORIOLIS_CHIP)$(CLOCKED)_kite.ap \
           $(CORIOLIS_CHIP)$(CLOCKED)_kite_ext.vst \
           $(CORIOLIS_CORE).vst                    $(CORIOLIS_CORE).ap \


# -------------------------------------------------------------------
# Common/Generic Rules.

%.gds: %.ap
	s2r -v -r $*

lvx-%: $(CHIP)_%.ap


# -------------------------------------------------------------------
# Alliance Rules.

 ifeq ($(GENERATE_CORE_VST),Yes)

#$(CORE).vhd:$(CORE).nsl Makefile
#	nsl2vh $(CORE).nsl $(NSL2VHOPT)
#	sed 's/\r//g' $(CORE).vhdl > $(CORE).vhd

$(CORE).vbe: $(CORE).vhd
	vasy -a -p -o -I vhd $(CORE).vhd

$(CORE).vst: $(CORE).vbe
	boom $(BOOMOPT) $(CORE) $(CORE)
	boog $(BOOGOPT) $(CORE)

$(CORE).xsc: $(CORE).vst
	loon $(LOONOPT) -o $(CORE)

 endif


.place: $(CORE).xsc 
	ocp -margin $(MARGIN) -ring $(CORE) $(CORE)
	touch .place

$(CORE).ap: .place
	nero $(CORE) $(CORE)

$(CORE).sp: $(CORE).ap
	MBK_SPI_MODEL=$(ALLIANCE_TOP)/spimodel.cfg  \
	MBK_OUT_LO=sp \
	cougar -ar -ac -t $(CORE)

$(ALLIANCE_CHIP).ap: $(CORE).ap
	ring $(ALLIANCE_CHIP) $(ALLIANCE_CHIP)

ring_debug: $(CORE).ap
	ring $(ALLIANCE_CHIP) $(ALLIANCE_CHIP) debug

ring_gdb: $(CORE).ap
	gdb ring

druc: $(ALLIANCE_CHIP).ap
	druc $(ALLIANCE_CHIP)

lvx: $(ALLIANCE_CHIP).ap druc
	cougar $(ALLIANCE_CHIP) $(ALLIANCE_CHIP)_ext
	lvx vst vst $(ALLIANCE_CHIP) $(ALLIANCE_CHIP)_ext

dreal:$(ALLIANCE_CHIP).gds
	dreal -l $(ALLIANCE_CHIP)

graal-core: $(CORE).ap
	$(GRAAL) -l $(CORE)

graal:
	$(GRAAL)

l2p:
	l2p -color $(CORE)


# -------------------------------------------------------------------
# Coriolis Rules.

$(CORIOLIS_CORE).vst: $(CORE).vst
	sed 's,\<$(CORE)\>,$(CORIOLIS_CORE),g' $(CORE).vst > $(CORIOLIS_CORE).vst

druc-crl: $(CORIOLIS_CHIP)$(CLOCKED)_kite.ap
	druc $(CORIOLIS_CHIP)$(CLOCKED)_kite

lvx-crl: $(CORIOLIS_CHIP)$(CLOCKED)_kite.ap
	cougar -f $(CORIOLIS_CHIP)$(CLOCKED)_kite $(CORIOLIS_CHIP)$(CLOCKED)_kite_ext
	MBK_SEPAR='_' lvx vst vst $(CORIOLIS_CHIP)$(CLOCKED) $(CORIOLIS_CHIP)$(CLOCKED)_kite_ext -f

ifeq ($(USE_DEVTOOLSET_2),"Yes")

$(CORIOLIS_CHIP)$(CLOCKED).ap: $(CORIOLIS_CORE).vst $(CORIOLIS_CHIP).vst $(CORIOLIS_CHIP)_chip.py
	@scl enable devtoolset-2 'eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	                          ../bin/doChip.py --place --cell=$(CORIOLIS_CHIP)'

$(CORIOLIS_CHIP)$(CLOCKED)_kite.ap: $(CORIOLIS_CHIP)$(CLOCKED).ap $(CORIOLIS_CHIP)_chip.py
	@scl enable devtoolset-2 'eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	                          ../bin/doChip.py --route --cell=$(CORIOLIS_CHIP)$(CLOCKED)'

cgt-interactive: $(CORIOLIS_CORE).vst $(CORIOLIS_CHIP).vst $(CORIOLIS_CHIP)_chip.py
	-rm -f *clocked*
	@scl enable devtoolset-2 'eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	                          cgt -V --cell=$(CORIOLIS_CHIP)'

cgt:
	@scl enable devtoolset-2 'eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	                          cgt -V'
else

$(CORIOLIS_CHIP)$(CLOCKED)_kite.ap: $(CORIOLIS_CORE).vst $(CORIOLIS_CHIP).vst $(CORIOLIS_CHIP)_chip.py
	@eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; \
	 ../bin/doChip.py --cell=$(CORIOLIS_CHIP)

cgt-interactive: $(CORIOLIS_CORE).vst $(CORIOLIS_CHIP).vst $(CORIOLIS_CHIP)_chip.py
	-rm -f *clocked*
	@eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; cgt -V --cell=$(CORIOLIS_CHIP)

cgt:
	@eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; $(VALGRIND_COMMAND) cgt -v

endif


# -------------------------------------------------------------------
# Cleaning Rules.

 CLEAN_CHIP = $(ALLIANCE_CHIP).gds      \
              $(ALLIANCE_CHIP).ps       \
              $(ALLIANCE_CHIP)_ext.ap   \
              $(ALLIANCE_CHIP).drc      \
              $(ALLIANCE_CHIP)_drc.gds  \
              $(ALLIANCE_CHIP)_rng.gds  \
              alldata.dat               \
              .place                    \
              *clocked*                 \
              *.pyc

 ifeq ($(GENERATE_CORE_VST),Yes)
   CLEAN_CORE = $(CORE).vst           \
                $(CORE).xsc           \
                $(CORE).sp            \
                $(CORE).vbe           \
                $(CORIOLIS_CORE).vst  \
                $(CORE).ap    
 else	
   CLEAN_CORE =  $(CORIOLIS_CORE).vst
 endif

clean:
	-rm -f $(CLEAN_CHIP) $(CLEAN_CORE) *.ap
