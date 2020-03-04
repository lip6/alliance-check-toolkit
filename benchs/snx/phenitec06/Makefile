# -*- explicit-buffer-name: "Makefile<snx/phenitec06>" -*-

        LOGICAL_SYNTHESIS = Yosys
       PHYSICAL_SYNTHESIS = Coriolis
               DESIGN_KIT = nsxlib

                     CHIP = snx_chip
            USE_CLOCKTREE = Yes
                USE_DEBUG = No
                 USE_KITE = No

                 NETLISTS = snx      \
                            alu16    \
                            cla16    \
                            inc16    \
                            reg4     \
                            type_dec
             NETLISTS_PNR = snx_scan

 include ./mk/design-flow.mk


CLEAN_SYNTHESIS += snx_flat.vst  \
                   snx_flat.dffs \
                   snx_flat.path \
                   snx_scan.ap   \
                   snx_scan.vst 


snx_flat.vst: $(addsuffix .vst,$(NETLISTS))
	flatlo -r snx snx_flat

snx_scan.vst: snx_flat.vst snx_flat.path
	scapin snx_flat snx_flat snx_scan

snx_flat.path: snx_flat.vst
	grep " : sff" snx_flat.vst > snx_flat.dffs
	awk 'BEGIN {FS=":"; printf "BEGIN_PATH_REG\n";} \
		{print $$1} \
		END {printf "END_PATH_REG\nBEGIN_CONNECTOR\n SCAN_IN scin\n SCAN_OUT scout\n SCAN_TEST sctest\nEND_CONNECTOR\n"}' snx_flat.dffs > snx_flat.path


vst:       snx_scan.vst
layout:    snx_chip_cts_r.ap
gds:       snx_chip_cts_r.gds

lvx:       lvx-snx_chip_cts_r
druc:      druc-snx_chip_cts_r
view:      cgt-snx_chip_cts_r
