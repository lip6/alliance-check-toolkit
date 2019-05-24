# -*- explicit-buffer-name: "Makefile<AM2901/datapath>" -*-


       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = sxlib

                     CHIP = amd2901
                   MARGIN = 5
                  BOOMOPT =
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
            USE_CLOCKTREE = No
                USE_DEBUG = No
                 USE_KITE = No

                 NETLISTS = amd2901_ctl
         STRATUS_NETLISTS = amd2901                 \
                            amd2901_core            \
                            amd2901_dpt             \
                            buff_2bits              \
                            inv_drive8_4bits        \
                            mux2_4bits              \
                            nand2_4bits             \
                            nand2mask_0b0000_4bits  \
                            nbuse_4bits             \
                            nor2_4bits              \
                            sff_4bits               \
                            xnor2_4bits             \
                            xnor2_drive4_4bits      \
                            xor2_4bits

 include ./mk/design-flow.mk


layout:  amd2901_r.ap
gds:     amd2901_r.gds

lvx:     lvx-amd2901_r
druc:    druc-amd2901_r
view:    cgt-amd2901_r

# gmake 3.81 implicit rule recursion workaround
amd2901_ctl.vst: non_generated/amd2901_ctl.vst
	cp non_generated/amd2901_ctl.vst .
