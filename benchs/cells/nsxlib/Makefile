# -*- explicit-buffer-name: "Makefile<alliance-check-toolkit/nsxlib>" -*-

                  TK_RTOP = ../..
 export      MBK_CATA_LIB = $(TOOLKIT_CELLS_TOP)/nsxlib

 include $(TK_RTOP)/etc/mk/users.mk
 include $(TK_RTOP)/etc/mk/binaries.mk
 include $(TK_RTOP)/etc/mk/alliance.mk
# include $(TK_RTOP)/etc/mk/phenitec.mk
# include $(TK_RTOP)/etc/mk/mosis.mk
 include $(TK_RTOP)/etc/mk/freepdk45.mk
 include $(TK_RTOP)/etc/mk/check-library.mk


 characterize: nsxlib-dot-lib


check-lib: ./check/inv_x1.ok \
           ./check/sff1_x4.ok

check-clean:
	rm ./check/*
