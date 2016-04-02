
 set techno  [lindex $argv 0]
 set libName [lindex $argv 1]

 puts "Using technology:        <$techno>"
 puts "Characterizing library:  <$libName>"

 avt_config   simToolModel  hspice
 avt_LoadFile $techno       spice

 set cells [glob *.spi]

 foreach cell $cells {
   set cellName [string map { .spi "" }  $cell]
 
   if ([string match ts_*  $cellName]) continue
   if ([string match nts_* $cellName]) continue
 
   avt_LoadFile $cell spice
   avt_config   tasBefig             yes
  #avt_config   tmaFunctionalityMode w
   avt_config   tmaDriveCapaout      yes
   avt_config   avtPowerCalculation  yes
   avt_config   simPowerSupply       1.8
   avt_config   simSlope             50

   if ([string match sff* $cell]) {
     puts "Cell is a D flip-flop."
   
     inf_SetFigureName   $cell
     inf_MarkSignal      sff_m "FLIPFLOP+MASTER"
     inf_MarkSignal      sff_s SLAVE
     create_clock -period 3000 ck
   }

   set fig      [hitas $cellName]
   if ([string match sff* $cell]) {
     set beh_fig  NULL
   } else {
     set beh_fig  [avt_LoadBehavior ./check/$cellName.vhd vhdl]
   }
   set abs_fig  [tma_abstract $fig $beh_fig]
 
   lappend fig_list $abs_fig
   lappend beh_list $beh_fig
 }
 
 lib_drivefile $fig_list $beh_list "$libName.lib" max
