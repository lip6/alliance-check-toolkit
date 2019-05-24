
%_ocp.ap  : %.vst                ;  $(OCP)          -margin $(MARGIN) -ring $* $*_ocp
%.ap      : %.vst %_ocp.ap       ;  $(NERO)         -p $*_ocp $* $*
%_flat.ap : %.ap                 ;  $(FLATPH)       -t $* $*_flat

$(CHIP).ap: $(CHIP).vst $(CORE).vst $(CORE).ap; ring $(CHIP) $(CHIP)
ring_debug: $(CHIP).vst $(CORE).vst $(CORE).ap; ring $(CHIP) $(CHIP) debug
ring_gdb:   $(CHIP).vst $(CORE).vst $(CORE).ap; gdb ring

 CLEAN_PR = *_ocp.ap
