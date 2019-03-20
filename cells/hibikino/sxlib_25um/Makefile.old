#make check-lib



CHECKDIR=check

DONT_PROOF=tie_x0 powmid_x0 rowend_x0

graal:
	make -f ../Makefile USERTOOLS=../../../etc graal

graal-%:%.ap
	make -f ../Makefile USERTOOLS=../../../etc graal-$*

check-lib: $(foreach cell,$(wildcard *.vbe),$(patsubst %.vbe,%.check,$(cell)))

%.check:
	@if [ ! -d $(CHECKDIR) ]; then \
       	echo mkdir $(CHECKDIR); \
        mkdir $(CHECKDIR); \
    fi 
	@if ! `echo $(DONT_PROOF) | grep -q $*` ; then \
	    ( cd $(CHECKDIR); \
	    make -f ../../Makefile VPATH=.. USERTOOLS=../../../../etc $*.ok) \
	fi

%.proof:
	(@if [ ! -d $(CHECKDIR) ]; then \
        echo mkdir $(CHECKDIR); \
        mkdir $(CHECKDIR); \
    fi
	@if ! `echo $(DONT_PROOF) | grep -q $*` ; then \
	( cd $(CHECKDIR); \
	make -f ../../Makefile VPATH=.. USERTOOLS=../../../../etc $*-proof ) ) \
	fi

	
%.druc:
	@if [ ! -d $(CHECKDIR) ]; then \
        echo mkdir $(CHECKDIR); \
        mkdir $(CHECKDIR); \
    fi
	( cd $(CHECKDIR); \
	make -f ../../Makefile VPATH=.. USERTOOLS=../../../../etc $*-druc ) 


clean-tmp:
	@if [ ! -d $(CHECKDIR) ]; then \
        echo mkdir $(CHECKDIR); \
        mkdir $(CHECKDIR); \
    fi
	(cd $(CHECKDIR); rm -f *.drc *.gds *.cns *.stat *.rep *.spi *.dtx *.rcx *.stm *.vhd *.vbe)

clean-lib:clean-tmp
	rm -rf $(CHECKDIR)
	
