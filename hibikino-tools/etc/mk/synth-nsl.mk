

%.vhdl: %.nsl
	nsl2vh $(NSL2VHOPT) $<

%.v:%.nsl
	nsl2vl $(NSL2VLOPT) $<

CLEAN_VHDL= *.vhdl
