
 include $(TK_RTOP)/etc/mk/os.mk
 include $(TK_RTOP)/etc/mk/users.mk
 include $(TK_RTOP)/etc/mk/binaries.mk


# -------------------------------------------------------------------
# Keep all intermediate files

.SECONDARY:

# Secondary variables.
 PATTERNS = patterns
 DESIGN   = design

 export MBK_IN_LO=vst
 export MBK_PH_LO=ap
 export MBK_OUT_LO=vst
 export MBK_OUT_PH=ap
 export RDS_IN=gds
 export RDS_OUT=gds


# -------------------------------------------------------------------
# Alliance Rules (pattern matching).

asimut-%  : %.vst $(PATTERNS).pat;  $(ASIMUT)       -zd -nores $* patterns
%.gds     : %.ap                 ;  $(S2R)          -v -r $*
%.cif     : %.ap                 ;  $(S2R_cif)      -v -r $*
%.spi     : %.ap                 ;  $(COUGAR_spice) -ar -ac -t $*
%_yag.spi : %.ap                 ;  $(COUGAR_spice) -ar -ac -t $* $*_yag
%.ps      : %.ap                 ;  $(L2P)          -color $*
druc-%    : %.ap                 ;  $(DRUC)         $(DRUC_FLAGS) $*
%_ext.al  : %.ap                 ;  $(COUGAR)       -f $* $*_ext
%_yag.al  : %.ap                 ;  $(COUGAR)       -t $* $*_ext
lvx-%     : %.vst %_ext.al       ;  $(LVX)          vst al $* $*_ext -f
lvx-%_kite: %.vst %_kite_ext.al  ;  $(LVX)          vst al $* $*_kite_ext -f
dreal-%   : %.gds                ;  $(DREAL)        --debug -l $*
graal-%   : %.ap                 ;  $(GRAAL)        -l $*
dreal     :                      ;  $(DREAL)
graal     :                      ;  $(GRAAL)
%_yag.vhd : %_yag.spi            ;  $(YAGLE_CHIP)   $(SPI_TECHNO_NAME) $*_yag

proof-%: %.vbe %_yag.vhd
	  sed -i -e '/ck.*delayed/d' -e 's/linkage/in/' $*_yag.vhd
	  $(VASY) -I vhd -o -a $*_yag $*_yag
	  $(PROOF) -d $* $*_yag


# -------------------------------------------------------------------
# Cleaning Rules.

 CLEAN_CHIP = *.ps                      \
              *.xsc                     \
              *.al                      \
              *.drc                     \
              *.gds                     \
              *.cif                     \
              alldata.dat               \
              *_clocked*                \
              *_ext*                    \
              *_boom*                   \
              *_boog*                   \
              *_loon*                   \
              *_kite*                   \
              *_yag.cns                 \
              *_yag.rep                 \
              *_yag.spi                 \
              *_yag.stat                \
              *_yag.vbe                 \
              *_yag.vhd                 \
              *_u[0-9][0-9]*            \
              *.pyc                     \
              *.log

 ifneq ($(CHIP),)
   CLEAN_CHIP += $(CHIP).ap
 endif

 ifeq ($(USE_STRATUS),Yes)
   CLEAN_STRATUS = *.vst *.ap
 endif

clean:
	-rm -f $(CLEAN_CHIP) $(CLEAN_SYNTHESIS) $(CLEAN_PR) $(CLEAN_STRATUS)
