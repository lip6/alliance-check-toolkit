# make file to make my80core.v
CORENAME=my80core
SOURCENAME=my80x

$(CORENAME).v: ../$(SOURCENAME).nsl ../config.h
	nsl2vl -O2 -DSTANDALONE -sync_res -neg_res ../$(SOURCENAME).nsl -o $(CORENAME).v

drc:
	klayout -r /home/nshimizu/lip6/alliance-check-toolkit/dks/sky130_vsc/libs.tech/klayout/sky130A.lydrc -rd input=$(CORENAME)_cts_r.gds -rd report=$(CORENAME)_cts_r.report
report:
	klayout $(CORENAME)_cts_r.gds -m $(CORENAME)_cts_r.report
klayout:
	klayout $(CORENAME)_cts_r.gds
