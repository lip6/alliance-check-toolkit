#-------------------------------------------------------------------#
#							Makefile								#
#				Alliance 5.0 & Alliance 4.0(SCR)					#
#				Hibikino Process Rule ( 2um )						#
#				Lambda = 2.4										#
#-------------------------------------------------------------------#
#		2016.7.31	Takumi Furukawa									#
#-------------------------------------------------------------------#





FILENAME=test_chip
FILETYPE=gds

#CORE=$(FILENAME)
CORE=core_top

CHIP=chip64

SRCDIR=.
VPATH=$(SRCDIR)/:$(SRCDIR)/../src:$(SRCDIR)/chip_layout


USERTOOLS=../etc
USERCELL_TOP=$(USERTOOLS)/cells
USERRDS=$(USERTOOLS)/rds



#NETLISTS = $(FILENAME) module1 module2 ...
NETLISTS = $(FILENAME)
#NETLISTS_VST=$(foreach netlist,$(NETLISTS), $(netlist).vst)


# /*------------------------------------------------------------\
# |                            Environement                     |
# \------------------------------------------------------------*/

#GDB=gdb

#RING_OPT = debug
#RING_OPT = stat


LAMBDA=2.5
WORK_LIB	= .
CATAL_NAME	= CATAL
RDS_TECHNO_NAME	= $(RDS_TECHNO)
SPI_TECHNO_NAME=$(USERTOOLS)/h24um.hsp
GRAAL_TECHNO_NAME=$(ALLIANCE_TOP)/etc/cmos.graal
DREAL_TECHNO_NAME= $(USERTOOLS)/hibikino.dreal

MODELNAME = $(FILENAME)_model

TARGET_LIB      = $(ALLIANCE_TOP)/cells/sxlib

ifeq ($(LAMBDA),2.4)
CATA_LIB	= $(USERCELL_TOP)/h24umlib:$(ALLIANCE_TOP)/cells/sxlib:$(USERCELL_TOP)/padlib-h24um
RDS_TECHNO		= $(USERRDS)/h24um.rds
endif
ifeq ($(LAMBDA),2.5)
CATA_LIB	= $(USERCELL_TOP)/h25umlib:$(ALLIANCE_TOP)/cells/sxlib:$(USERCELL_TOP)/padlib-h25um
RDS_TECHNO		= $(USERRDS)/h25um.rds
endif



NSL2VHOPT = -vasy -split -O2

################################################################
# SCR opt
################################################################
METAL_LEVEL     = 2
LO_NUM			= 2




################################################################
# RING opt
################################################################
RING_WMIN_ALU1 = 2
RING_WMIN_ALU2 = 2
RING_DMIN_ALU1_ALU1 = 3
RING_DMIN_ALU2_ALU2 = 3
RING_WVIA_ALU1 = 2
RING_WVIA_ALU2 = 2
RING_EXTENSION_ALU2 = 1


ENV_RING= export RING_WMIN_ALU1=$(RING_WMIN_ALU1);\
	export RING_WMIN_ALU2=$(RING_WMIN_ALU2);\
	export RING_WVIA_ALU1=$(RING_WVIA_ALU1);\
	export RING_WVIA_ALU2=$(RING_WVIA_ALU2);\
	export RING_DMIN_ALU1_ALU1=$(RING_DMIN_ALU1_ALU1);\
	export RING_DMIN_ALU2_ALU2=$(RING_DMIN_ALU2_ALU2);\
	export RING_EXTENSION_ALU2=$(RING_EXTENSION_ALU2)

ENV_DREAL= export DREAL_TECHNO_NAME=$(DREAL_TECHNO_NAME)

.SECONDARY:
    export MBK_IN_LO=vst
    export MBK_PH_LO=ap
    export MBK_OUT_LO=vst
    export MBK_OUT_PH=ap
    export RDS_IN=gds
    export RDS_OUT=gds
    export MBK_VDD=vdd
    export MBK_VSS=vss
    export RDS_IN=gds
    export RDS_OUT=gds
    export MBK_WORK_LIB=$(WORK_LIB)
    export MBK_TARGET_LIB=$(TARGET_LIB)
    export MBK_CATA_LIB=$(CATA_LIB)
    export RDS_TECHNO_NAME=$(RDS_TECHNO)
    export MBK_CATAL_NAME=$(CATAL_NAME)


include $(USERTOOLS)/mk/synth-nsl.mk
include $(USERTOOLS)/mk/synth-pr-alliance.mk
include $(USERTOOLS)/mk/alliance.mk
include $(USERTOOLS)/mk/check-library.mk



all :  $(CHIP).gds

chip : $(CHIP).ap



CHECKDIR=check

%.check:
	@if [ ! -d $(CHECKDIR) ]; then \
        echo mkdir $(CHECKDIR); \
        mkdir $(CHECKDIR); \
    fi
	( cd $(CHECKDIR); \
	make -f ../Makefile VPATH=.. SRCDIR=.. USERTOOLS=../$(USERTOOLS) $*.ok) 

%.proof:
	@if [ ! -d $(CHECKDIR) ]; then \
        echo mkdir $(CHECKDIR); \
        mkdir $(CHECKDIR); \
    fi
	( cd $(CHECKDIR); \
	make -f ../Makefile VPATH=.. SRCDIR=.. USERTOOLS=../$(USERTOOLS) $*-proof ) 

	
%.druc:
	@if [ ! -d $(CHECKDIR) ]; then \
        echo mkdir $(CHECKDIR); \
        mkdir $(CHECKDIR); \
    fi
	( cd $(CHECKDIR); \
	make -f ../Makefile VPATH=.. SRCDIR=.. USERTOOLS=../$(USERTOOLS) $*-druc ) 


clean-tmp:
	rm -f *.drc *.cns *.stat *.rep *.spi *.dtx *.rcx *.stm *.vhd *_ext* *_rng.gds *_drc.gds

#clean-lib:clean-tmp
#	rm -rf $(CHECKDIR)
