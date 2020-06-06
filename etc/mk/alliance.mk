
# -------------------------------------------------------------------
# Any file put in "./non_generated/" will take precedence over the
# generation.

%.vst: ./non_generated/%.vst ;  cp $< .


# -------------------------------------------------------------------
# Keep all intermediate files

.SECONDARY:

# Secondary variables.
 ifeq ($(PATTERNS),)
   PATTERNS  = patterns
 endif
 ifeq ($(DESIGN),)
   DESIGN = design
 endif

 export MBK_IN_LO=vst
 export MBK_PH_LO=ap
 export MBK_OUT_LO=vst
 export MBK_OUT_PH=ap
 export RDS_IN=gds
 export RDS_OUT=gds
 export MBK_TRACE_MODE=Y



# -------------------------------------------------------------------
# Alliance Rules (pattern matching).

 $(info Using ALLIANCE_TOP = "$(ALLIANCE_TOP)".)
 $(info Using PATTERNS = "$(PATTERNS)".)


%.pat           : %_pat.c              ;  $(GENPAT)       $*_pat
asimut-%        : %.vst $(PATTERNS).pat;  $(ASIMUT)       $(ASIMUTOPT) $* $(PATTERNS) $(PATTERNS)_sim
ifneq ($(REAL_MODE),Yes)
%.gds           : %.ap                 ;  $(S2R)          -v -r $*
%.cif           : %.ap                 ;  $(S2R_cif)      -v -r $*
endif	        
%.spi           : %.ap                 ;  $(COUGAR_spice) -ar -ac -t $*
%_yag.spi       : %.ap                 ;  $(COUGAR_spice) -ar -ac -t $* $*_yag
%.ps            : %.ap                 ;  $(L2P)          -color $*
druc-%          : %.ap                 ;  $(DRUC)         $(DRUC_FLAGS) $*
%_ext.vst       : %.ap                 ;  $(COUGAR_vst)   -c -f $* $*_ext
%_ext.al        : %.ap                 ;  $(COUGAR)       -c -f $* $*_ext
%_yag.al        : %.ap                 ;  $(COUGAR)       -c -t $* $*_ext
lvx-1-%         : %.vst %_ext.vst      ;  $(LVX)          vst vst $* $*_ext -f
lvx-vst-%       : %.vst %_r_ext.vst    ;  $(LVX)          vst vst $* $*_r_ext -f
lvx-%           : %.vst %_ext.al       ;  $(LVX)          vst al $* $*_ext -f
dreal-%         : %.gds                ;  $(DREAL)        --debug -l $*
graal-%         : %.ap                 ;  $(GRAAL)        -l $*
dreal           :                      ;  $(DREAL)
graal           :                      ;  $(GRAAL)
%_yag.vhd       : %_yag.spi            ;  $(YAGLE_CHIP)   $(SPI_TECHNO_NAME) $*_yag

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
              *_cts*                    \
              *_cts*                    \
              *_ext*                    \
              *_boom*                   \
              *_boog*                   \
              *_loon*                   \
              *_r.*                     \
              *_yag.cns                 \
              *_yag.rep                 \
              *_yag.spi                 \
              *_yag.stat                \
              *_yag.vbe                 \
              *_yag.vhd                 \
	          *.pat                     \
              *_u[0-9][0-9]*            \
              *.pyc                     \
              *.log

 ifneq ($(CHIP),)
   CLEAN_CHIP += $(CHIP).ap corona.vst corona.ap
   ifeq ($(RM_CHIP),Yes)
     CLEAN_CHIP += $(CHIP).vst
   endif
 endif

clean:
	-rm -f $(CLEAN_CHIP) $(CLEAN_SYNTHESIS) $(CLEAN_PR) $(CLEAN_STRATUS) core_float.ap
