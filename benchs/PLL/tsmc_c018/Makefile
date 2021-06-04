
                USE_DEBUG = No
             USE_VALGRIND = No

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = FlexLib018
            YOSYS_FLATTEN = No
         YOSYS_BLACKBOXES = pll
#           YOSYS_SET_TOP = Yes
                    CHIP  = chip
                    CORE  = wrappll
            USE_CLOCKTREE = Yes
                  RM_CHIP = Yes
                VST_FLAGS = --vst-uniquify-uppercase

                 NETLISTS = wrappll

 include ./mk/design-flow.mk


chip_cts_r.vst: non_generated/wrappll.vst 
	cp non_generated/wrappll.vst .
	-$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

chip_cts_r.gds: chip_cts_r.vst
	-@echo "[INFO] Overriden default GDS rule (for use with FlexLib)."

gds: chip_cts_r.gds
