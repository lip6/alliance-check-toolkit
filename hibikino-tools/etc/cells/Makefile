#---------------------------------------------------------------#
#							CELL CHECK 							#
#---------------------------------------------------------------#
#	2016.07.30   Takumi Furukawa								#
#																#
#---------------------------------------------------------------#



FILETYPE=gds

SRCDIR=.
VPATH=$(SRCDIR)/


USERTOOLS=../../etc
USERCELL_TOP=$(USERTOOLS)/cells
USERRDS=$(USERTOOLS)/rds


# /*------------------------------------------------------------\
# |                            Environement                     |
# \------------------------------------------------------------*/


#TARGET_LIB      = $(ALLIANCE_TOP)/cells/sxlib
TARGET_LIB      = $(USERCELL_TOP)/h24umlib
#CATA_LIB	= $(USERCELL_TOP)/h24umlib:$(ALLIANCE_TOP)/cells/sxlib:$(ALLIANCE_TOP)/cells/padlib
#CATA_LIB	= $(USERCELL_TOP)/h24umlib:$(ALLIANCE_TOP)/cells/sxlib:$(USERCELL_TOP)/padlib-h24um
CATA_LIB	= $(USERCELL_TOP)/h24umlib:$(ALLIANCE_TOP)/cells/sxlib:$(USERCELL_TOP)/padlib-h25um
#CATA_LIB	= $(USERCELL_TOP)/h24umlib:$(ALLIANCE_TOP)/cells/sxlib:$(USERCELL_TOP)/padlib-test2
#CATA_LIB	= $(USERCELL_TOP)/h24umlib:$(ALLIANCE_TOP)/cells/sxlib:$(USERCELL_TOP)/padlib
#RDS_TECHNO		= $(USERRDS)/h24um.rds
RDS_TECHNO		= $(USERRDS)/other_rds/h25um.rds
METAL_LEVEL     = 2

LO_NUM			= 5

NSL2VHOPT = -vasy -split -O2 -DLSI


WORK_LIB	= .
CATAL_NAME	= CATAL


RDS_TECHNO_NAME	= $(RDS_TECHNO)
GRAAL_TECHNO_NAME=$(ALLIANCE_TOP)/etc/cmos.graal
DREAL_TECHNO_NAME= h24um.dreal
SPI_TECHNO_NAME=$(USERTOOLS)/h24um.hsp

MODELNAME = $(FILENAME)_model

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


#include $(USERTOOLS)/mk/synth-pr-alliance.mk
include $(USERTOOLS)/mk/alliance.mk
#include $(USERTOOLS)/mk/binaries.mk
include $(USERTOOLS)/mk/check-library.mk



all :  $(FILENAME).$(FILETYPE)


%.vhdl: %.nsl
	nsl2vh $(NSL2VHOPT) $<



