
#export     PDKMASTER_TOP = $(shell pwd)/../../../../C4M/open_pdk/C4M.Sky130
#export     PDKMASTER_TOP = $(shell pwd)/../../../../../C4M.Sky130
 export     PDKMASTER_TOP = $(shell pwd)/../../../../../mpw4/thirdparty/open_pdk/C4M.Sky130
        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = Sky130_C4M_CF

            YOSYS_FLATTEN = 
            YOSYS_SET_TOP = Yes
                USE_DEBUG = No
                  RM_CHIP = Yes
                VST_FLAGS = 

                     CHIP = chip
                 NETLISTS = user_project_core_lambdasoc

 include ./mk/design-flow.mk


user_project_core_lambdasoc.gds: user_project_core_lambdasoc.vst
	$(call scl_cols,$(call c2env, $(VALGRIND_COMMAND) cgt -tV --script=doDesign))

blif:   user_project_core_lambdasoc.blif
vst:    user_project_core_lambdasoc.vst
gds:    user_project_core_lambdasoc.gds
