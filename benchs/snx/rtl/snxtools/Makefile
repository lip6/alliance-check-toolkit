SHELL=bash
#PARTHENON=$(cyg_user)\home\parthenon
#PATH=/home/parthenon/com:/bin:/usr/local/bin:$PATH
#AUTO=auto.bat
STACKTOP=0x400
DATAOFF=0x200
RAMEND=0x400
MEMADRSZ=9
AUTO=auto
FPGABOARD=mu200ea40
SYSSIM=system
SNX=snx2
SYNTHEOPT=-O2 -neg_res
SIMOPT=-verisim2 -target $(SYSSIM)  -neg_res -DMEMADRSZ=$(MEMADRSZ) -DDATAOFF=$(DATAOFF) -DRAMEND=$(RAMEND)
SNXOPT=-neg_res
VCD=+vcd=1
P=
TEST1=if
TEST2=for
TEST3=recur
TEST4=sort
CLEANS=$(SYSSIM).exe $(SYSSIM).vcd $(SYSSIM).v snx.mem sim.log snxc2/snxc snxc2/snxi snxasm2/snxasm test.v snx2.v
CLEAN1=$(TEST1).mem $(TEST1).dat $(TEST1).s
CLEAN2=$(TEST2).mem $(TEST2).dat $(TEST2).s
CLEAN3=$(TEST3).mem $(TEST3).dat $(TEST3).s
CLEAN4=$(TEST4).mem $(TEST4).dat $(TEST4).s
CLEANT=$(TARGET).mem $(TARGET).dat $(TARGET).s
CLEAN=$(CLEANS) $(CLEAN1) $(CLEAN2) $(CLEAN3) $(CLEAN4) $(CLEANT) cpu.v make.log auto.log
SNXEXE=./$(SYSSIM).exe
SNXMEM=snx.mem
NSL2VL=nsl2vl
VERILOG=iverilog
VVP=vvp
PARTHEDIR=parthenon

edif:
	nsl2sfl snx$(P).nsl
	-mkdir -p $(PARTHEDIR)
	mv snx$(P).sfl $(PARTHEDIR)/snx.sfl
	(cd $(PARTHEDIR); \
	$(AUTO) snx clean ; \
	$(AUTO) snx nld4 DEMO demo | tee ../auto.log ;\
	)

layout:
	(make netlist; make apdirect ; make ring; make s2r) 2>&1 | tee make.log


reidai.mem: reidai.s snxasm2/snxasm
	./snxasm2/snxasm < reidai.s | tee $@

reidai:	reidai.mem $(SNXEXE)
	cp reidai.mem $(SNXMEM)
	$(VVP) $(SNXEXE) $(VCD)| tee sim.log

sim1:
	make TARGET=$(TEST1) sim

sim2:
	make TARGET=$(TEST2) sim

sim3:
	make TARGET=$(TEST3) sim

sim4:
	make TARGET=$(TEST4) sim

sim:	$(TARGET).mem $(SNXEXE)
	cp $(TARGET).mem $(SNXMEM)
	$(VVP) $(SNXEXE) $(VCD)| tee sim.log


$(TARGET).mem:	$(TARGET).s
	./snxasm2/snxasm < $(TARGET).s | tee $(TARGET).mem

$(TARGET).dat:	$(TARGET).s
	./snxasm2/snxasm b < $(TARGET).s > $(TARGET).dat

$(TARGET).hex:	$(TARGET).s
	./snxasm2/snxasm i < $(TARGET).s > $(TARGET).hex

$(TARGET).s:	snxc2/snxc snxasm2/snxasm $(TARGET).sc
	./snxc2/snxc < $(TARGET).sc | tee $(TARGET).s

compile:
	make $(TARGET).s

inter:	snxc2/snxi
	./snxc2/snxi < $(TARGET).sc

snxc2/snxc:
	-rm snxc2/snxc.exe
	( cd snxc2; make CC=gcc STACKTOP=$(STACKTOP) snxc)

snxc2/snxi:
	( cd snxc2; make CC=gcc snxi)

snxasm2/snxasm:
	-rm snxasm2/snxasm.exe
	( cd snxasm2; make CC=gcc snxasm)

$(SNXEXE): $(SYSSIM).v $(SNX).v
	$(VERILOG) -o $(SNXEXE) $(SYSSIM).v $(SNX).v

$(SYSSIM).v:	$(SYSSIM).nsl $(SNX).h
	$(NSL2VL) $(SYSSIM).nsl $(SIMOPT)

$(SNX).v:	$(SNX).nsl $(SNX).h
	$(NSL2VL) $(SNX).nsl $(SNXOPT)

synthe:	snx.nsl mem.h $(FPGABOARD).nsl
	$(NSL2VL) snx$(P).nsl $(SYNTHEOPT)
	$(NSL2VL) $(FPGABOARD).nsl $(SYNTHEOPT)


##############################

TARGETDIR=build
TARGETMOD=snx$(P)
SUBMODL=cla16 inc16 reg4
SUBMODH=alu16 
TOPMOD=snx
SUBMODVHD=$(addsuffix .vhdl, $(SUBMODH) $(TOPMOD) $(SUBMODL) ) 
SUBMODLVBE=$(addsuffix .vbe, $(SUBMODL))
SUBMODHVBE=$(addsuffix _model.vbe, $(SUBMODH) $(TOPMOD)) 
TOPMODVBE=$(addsuffix _model.vbe, $(TOPMOD)) 
CHIP=chip
MARGIN=0.9
BOOMOPT=
BOOGOPT=
LOONOPT=
NSL2VHOPT= -binout -vasy -p -split -o $(TARGETDIR)
CLEANVHDL= $(TARGETDIR)

export MBK_TARGET_LIB=$(ALLIANCE_TOP)/cells/sxlib
export MBK_CATA_LIB=$(MBK_TARGET_LIB):$(ALLIANCE_TOP)/cells/padlib
export MBK_IN_LO=vst
export MBK_OUT_LO=vst
export RDS_IN=gds
export RDS_OUT=gds


chip: $(TARGETDIR)/$(CHIP).$(RDS_OUT)

$(TARGETDIR) $(addprefix $(TARGETDIR)/, $(SUBMODVHD)): $(TARGETMOD).nsl
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
	make clean
	-rm snxc2/snxc.exe
	-rm snxasm2/snxasm.exe

clean:
	-rm $(CLEAN) 2> /dev/null
	-rm -f -r $(TARGETDIR)
	-rm -f -r $(PARTHEDIR)
	( cd snxc2; make clean ) 2> /dev/null
	( cd snxasm2; make clean ) 2> /dev/null

