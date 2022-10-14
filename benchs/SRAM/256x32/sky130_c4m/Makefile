
#export     PDKMASTER_TOP = $(shell pwd)/../../../../../C4M/open_pdk/C4M.Sky130
#export     PDKMASTER_TOP = $(shell pwd)/../../../../../C4M.Sky130
 export     PDKMASTER_TOP = $(shell pwd)/../../../../pdkmaster/C4M.Sky130
        LOGICAL_SYNTHESIS = Disabled
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = Sky130_C4M_CF

                USE_DEBUG = No
             USE_VALGRIND = No

                ASIMUTOPT = -zd
            USE_CLOCKTREE = Yes
                 NETLISTS = spram_256x32
                 PATTERNS = spram_256x32

 include ./mk/design-flow.mk

spram_256x32_r.vst: spram_256x32.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

spram_256x32_r.gds: spram_256x32_r.vst
	-@echo "[INFO] Overriden default GDS rule (for use with FlexLib)."

vst:    spram_256x32.vst
gds:    spram_256x32_r.gds
sim:    asimut-spram_256x32
