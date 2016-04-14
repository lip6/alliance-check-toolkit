
%.vhdl: %.nsl  ; nsl2vh $(NSL2VHOPT) $<

#%.vhd:%.nsl
#	nsl2vh $< $(NSL2VHOPT)
#	sed 's/\r//g' $*.vhdl > $@
