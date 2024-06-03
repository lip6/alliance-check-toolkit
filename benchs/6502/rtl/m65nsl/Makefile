M65SRC=model.h m65.nsl alu65.nsl cpa.nsl inc16.nsl
AP1SRC=ap1.nsl mem.nsl
AP1DAT=woz.mem in_data.mem
CLEANS=ap1.v ap1.vvp ap1.log ap1.vcd make.log
BUILD=build

all: ap1.log

clean:
	-rm $(CLEANS)
	-rm -fr $(BUILD)

ap1.v: $(M65SRC) $(AP1SRC)
	nsl2vl ap1.nsl -verisim2 -target ap1

ap1.vvp: ap1.v
	iverilog -o ap1.vvp ap1.v

ap1.log: ap1.vvp $(AP1DAT)
	vvp ap1.vvp | tee ap1.log

##############################
layout:
	(make netlist; make apdirect ; make ring; make s2r) 2>&1 | tee make.log


TARGETDIR=build
TARGETMOD=m65
SUBMODL=decadj inc16
SUBMODH=alu65 cpa8
TOPMOD=m65
SUBMODVHD=$(addsuffix .vhdl, $(SUBMODH) $(TOPMOD) $(SUBMODL) ) 
SUBMODLVBE=$(addsuffix .vbe, $(SUBMODL))
SUBMODHVBE=$(addsuffix _model.vbe, $(SUBMODH) $(TOPMOD)) 
TOPMODVBE=$(addsuffix _model.vbe, $(TOPMOD)) 
CHIP=chip
MARGIN=0.9
BOOMOPT=
BOOGOPT=
LOONOPT=
NSL2VHOPT= -vasy -p -split -o $(TARGETDIR)
CLEANVHDL= $(TARGETDIR)

export MBK_TARGET_LIB=$(ALLIANCE_TOP)/cells/sxlib
export MBK_CATA_LIB=$(MBK_TARGET_LIB):$(ALLIANCE_TOP)/cells/padlib
export MBK_IN_LO=vst
export MBK_OUT_LO=vst
export RDS_IN=gds
export RDS_OUT=gds


chip: $(TARGETDIR) $(TARGETDIR)/$(CHIP).$(RDS_OUT)

$(TARGETDIR):
	mkdir -p $(TARGETDIR)

$(addprefix $(TARGETDIR)/, $(SUBMODVHD)):$(TARGETDIR)  $(TARGETMOD).nsl
	date ; \
	nsl2vh $(TARGETMOD).nsl $(NSL2VHOPT) ;\
	date ; \

$(TAGETDIR)/$(TOPMOD)_model.vbe : $(TAGETDIR)/$(TOPMOD).vst

%.vst: $(addsuffix .vhdl, $(addprefix $(TARGETDIR)/, $(SUBMODH) $(TOPMOD)))
	( cd $(TARGETDIR); \
	date ; \
	vasy -a -p -o -I vhdl $(basename $(notdir $@))  ; \
	date ; \
	)

%.vbe :  $(addsuffix .vhdl, $(addprefix $(TARGETDIR)/, $(SUBMODL)))
	( cd $(TARGETDIR); \
	date ; \
	vasy -a -p -o -I vhdl $(basename $(notdir $@))  ; \
	date ; \
	)

echo1:
	echo $(SUBMODVBE)

$(addsuffix .vst, $(addprefix $(TARGETDIR)/, $(addsuffix _model, $(SUBMODH) $(TOPMOD) ) $(SUBMODL))):  $(addprefix $(TARGETDIR)/, $(addsuffix .vst, $(SUBMODH) $(TOPMOD)) $(SUBMODLVBE) )
	( cd $(TARGETDIR); \
	date ; \
	boom $(BOOMOPT) $(basename $(notdir  $@)) $(basename $(notdir  $@))  ;\
	date ; \
	boog $(BOOGOPT) $(basename $(notdir  $@)) ;\
	date ; \
	)

$(addsuffix .ap, $(addprefix $(TARGETDIR)/, $(SUBMODH) $(SUBMODL) $(addsuffix _model, $(TOPMOD)))):  $(addsuffix .vst, $(addprefix $(TARGETDIR)/, $(SUBMODH) $(addsuffix _model, $(SUBMODH) $(TOPMOD))  $(SUBMODL) $(TOPMOD)))
	( cd $(TARGETDIR); \
	date ; \
	ocp -margin $(MARGIN) $(basename $(notdir $@)) $(basename $(notdir $@))_place ;\
	date ; \
	)

netlist:  $(addsuffix .vst, $(addprefix $(TARGETDIR)/, $(SUBMODH) $(addsuffix _model, $(SUBMODH) $(TOPMOD))  $(SUBMODL) $(TOPMOD)))

$(TARGETDIR)/$(TOPMOD).ap:$(addsuffix .ap, $(addprefix $(TARGETDIR)/, $(SUBMODH) $(SUBMODL) $(addsuffix _model, $(TOPMOD))))

subap:$(addsuffix .ap, $(addprefix $(TARGETDIR)/, $(SUBMODH) $(SUBMODL) $(addsuffix _model, $(TOPMOD))))

apfile:
	( cd $(TARGETDIR); \
	cp ../$(TOPMOD)_new.ap . ;\
	date ; \
	ocp -ring -partial $(TOPMOD)_new $(TOPMOD) $(TOPMOD)_place ;\
	date ; \
	nero -p $(TOPMOD)_place $(TOPMOD) $(TOPMOD) ;\
	date ; \
	)

apdirect:
	( cd $(TARGETDIR); \
	date ; \
	ocp -ring -margin $(MARGIN) $(TOPMOD) $(TOPMOD)_place ;\
	date ; \
	nero -p $(TOPMOD)_place $(TOPMOD) $(TOPMOD) ;\
	date ; \
	)

$(TARGET).sp:$(TARGET).ap
	MBK_SPI_MODEL=$(ALLIANCE_TOP)/spimodel.cfg  \
	MBK_OUT_LO=sp \
	cougar -ar -ac -t $(TARGET)

#ring:$(TARGETDIR)/$(TOPMOD).ap
ring:
	( cd $(TARGETDIR); \
	cp ../$(CHIP).rin . ;\
	cp ../$(CHIP).vst . ;\
	date ; \
	ring $(CHIP) $(CHIP) ;\
	date ; \
	)

#s2r:$(TARGETDIR)/$(CHIP).ap
s2r:
	( cd $(TARGETDIR); \
	date ; \
	s2r -v -r $(CHIP) ;\
	date ; \
	)

dreal:$(TARGETDIR)/$(CHIP).$(RDS_OUT)
	( cd $(TARGETDIR); \
	dreal -l $(CHIP) ;\
	)

graal:$(TARGETDIR)/$(TARGET).ap
	( cd $(TARGETDIR); \
	graal -l $(TARGET) ;\
	)

l2p:
	l2p -color $(TARGET)
#############################################3
distclean:

	-rm $(CLEAN) 2> /dev/null
	-rm -f -r $(TARGETDIR)
	-rm -f -r $(PARTHEDIR)

