
#export     PDKMASTER_TOP = $(shell pwd)/../../../../C4M/open_pdk/C4M.Sky130
#export     PDKMASTER_TOP = $(shell pwd)/../../../../C4M.Sky130
 export     PDKMASTER_TOP = $(shell pwd)/../../../pdkmaster/C4M.Sky130
        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = Sky130_C4M_CF

                USE_DEBUG = No
             USE_VALGRIND = No

                ASIMUTOPT = -zd
            USE_CLOCKTREE = Yes
                     CHIP = chip
                  RM_CHIP = Yes
                 NETLISTS = eth_spram_256x32
                 PATTERNS = eth_spram_256x32

 include ./mk/design-flow.mk

eth_spram_256x32_r.vst: eth_spram_256x32.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=placeSRAM))

eth_spram_256x32_r.gds: eth_spram_256x32_r.vst
	-@echo "[INFO] Overriden default GDS rule (for use with FlexLib)."

blif:   eth_spram_256x32.blif
vst:    eth_spram_256x32.vst
gds:    eth_spram_256x32_r.gds
sim:    asimut-eth_spram_256x32
