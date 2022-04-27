# -*- explicit-buffer-name: "Makefile<benchs/c4m_512w64b8w>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = FlexLib018

                     CHIP = chip
                     CORE = memory
            USE_CLOCKTREE = Yes
                USE_DEBUG = No
                  RM_CHIP = Yes

                VST_FLAGS = --vst-no-lowercase
            YOSYS_FLATTEN =
         YOSYS_BLACKBOXES = spblock_512w64b8w
                 NETLISTS = $(shell cat netlists.txt)


 include ./mk/design-flow.mk


blif:      sram_test.blif
vst:       sram_test.vst
gds:       chip_cts_r.gds
