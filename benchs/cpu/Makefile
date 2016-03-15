# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/cpu>" -*-

                     CORE = cpu
                     CHIP = chip
                   MARGIN = 2
                  BOOMOPT = -A
                  BOOGOPT =
                  LOONOPT =
                NSL2VHOPT = -vasy
        GENERATE_CORE_VST = No
           LIBRARY_FAMILY = nsxlib
            USE_CLOCKTREE = Yes
                USE_DEBUG = No

 include ../etc/rules.mk

 export         MBK_IN_LO = vst
 export        MBK_OUT_LO = vst

$(CORE).vhdl:	$(CORE).nsl
	nsl2vh -vasy -O2 $(CORE).nsl

$(CORE).vbe:	$(CORE).vhdl
	vasy -a -p $(CORE) -I vhdl -o

check:       lvx

layout:      chip_crl_clocked_kite.ap
flatph:      flatph-chip_crl_clocked_kite
lvx:         lvx-chip_crl_clocked_kite
druc:        druc-chip_crl_clocked_kite
gds:         chip_crl_clocked_kite.gds
gds_flat:    chip_crl_clocked_kite_flat.gds
cif:         chip_crl_clocked_kite.cif
view:        cgt-view-chip_crl_clocked_kite
dreal:       dreal-chip_crl_clocked_kite

layout-alc:  chip_alc.ap
lvx-alc:     lvx-chip_alc
druc-alc:    druc-chip_alc
