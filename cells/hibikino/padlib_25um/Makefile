# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/padlib_25um>" -*-

                  TK_RTOP = ../../..
 export      MBK_CATA_LIB = $(TOOLKIT_CELLS_TOP)/hibikino/padlib_25um

 include $(TK_RTOP)/etc/mk/alliance.mk
 include $(TK_RTOP)/etc/mk/hibikino.mk
 include $(TK_RTOP)/etc/mk/check-library.mk

check-lib-select: ./check/pck_sp.ok      \
                  ./check/pi_sp.ok       \
                  ./check/po_sp.ok       \
                  ./check/pvddck2_sp.ok  \
                  ./check/pvddssck_sp.ok \
                  ./check/pvssck2_sp.ok

characterize: padlib_25um-dot-lib
