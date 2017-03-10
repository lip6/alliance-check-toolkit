
%.vhdl: %.nsl  ; nsl2vh $(NSL2VHOPT) $<
%.v:    %.nsl  ; nsl2vl $(NSL2VHOPT) $<

#%.vhd:%.nsl
#	nsl2vh $< $(NSL2VHOPT)
#	sed 's/\r//g' $*.vhdl > $@
