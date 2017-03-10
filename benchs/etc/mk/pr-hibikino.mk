
# -------------------------------------------------------------------
# Alliance Place & Route Rules for Hibikino (src/ring)

export RING_WMIN_ALU1      = 2
export RING_WMIN_ALU2      = 2
export RING_WVIA_ALU1      = 2
export RING_WVIA_ALU2      = 2
export RING_DMIN_ALU1_ALU1 = 3
export RING_DMIN_ALU2_ALU2 = 3
export RING_EXTENSION_ALU2 = 1


%.ap       : $(NETLISTS_VST) %.vst  ; $(SCR) -p -r $(SCROPT) $* $*
$(CHIP).ap : $(CHIP).vst $(CORE).ap ; $(RING) $(CHIP) $(CHIP) $(RINGOPT)

