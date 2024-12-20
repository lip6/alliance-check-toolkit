set VthHigh 0.8
set VthLow  0.2
set Slop    10e-12
set Temperature 27.0
set VddName  vdd
set VssName  vss

set vddvolt 1.8
set osdidll  {}
set spimodel  {}


 set techno      [lindex $argv 0]
 set spiceFormat [lindex $argv 1]
 set libName     [lindex $argv 2]

set idx 3
while {$idx < $argc} {
  set flag [lindex $argv $idx]
  incr idx
  switch -exact -- $flag {
  -Target -
  -t  {
     if {$idx < $argc} {
     set target [lindex $argv $idx]
     incr idx
   } }
  -OsdiDll -
  -o  {
     if {$idx < $argc} {
     set odsidll [lindex $argv $idx]
     incr idx
   } }
  -SpiceModel -
  -m  {
     if {$idx < $argc} {
     set spimodel [lindex $argv $idx]
     incr idx
   } }
  -SpiceType -
  -p  {
     if {$idx < $argc} {
     set spitype [lindex $argv $idx]
     incr idx
   } }
  -VddVoltage -
  -v  {
     if {$idx < $argc} {
     set vddvolt [lindex $argv $idx]
     incr idx
   } }
  -ClockSignal -
  -c  {
     if {$idx < $argc} {
     set clksig [lindex $argv $idx]
     incr idx
   } }
  -VddName -
  -V  {
     if {$idx < $argc} {
     set VddName [lindex $argv $idx]
     incr idx
   } }
  -VssName -
  -S  {
     if {$idx < $argc} {
     set VssName [lindex $argv $idx]
     incr idx
   } }
  -Temperature -
  -T  {
     if {$idx < $argc} {
     set Temperature [lindex $argv $idx]
     incr idx
   } }
  default {
    puts "Unknown parameter"
    exit 1
    }
 }
}

foreach i $osdidll {
	avt_LoadFile $i osdi
}
foreach i $spimodel {
	avt_LoadFile $i spice
}

 puts "Using technology:        <$techno>"
 puts "Characterizing library:  <$libName>"

 avt_config   yagSetResetDetection yes
 avt_config   simToolModel  $spiceFormat
 avt_LoadFile $techno       spice
 avt_config simVthHigh $VthHigh
 avt_config simVthLow $VthLow
 avt_config simSlope $Slop
 avt_config simTemperature $Temperature
 avt_config simPowerSupply $vddvolt
 avt_LoadFile $techno       spice
 avt_config   avtVddName    $VddName
 avt_config   avtVssName    $VssName

 set cells [glob *.spi]

 foreach cell $cells {
   set cellName [string map { .spi "" }  $cell]
 
   if ([string match ts_*  $cellName]) continue
   if ([string match nts_* $cellName]) continue
 
   avt_LoadFile $cell spice
   avt_config   tasBefig             yes
   avt_config   tmaFunctionalityMode w
   avt_config   tmaDriveCapaout      yes
   avt_config   avtPowerCalculation  yes

   if ([string match sff* $cell]) {
     puts "Cell is a D flip-flop."
   
     inf_SetFigureName   $cell
     inf_MarkSignal      sff_m "FLIPFLOP+MASTER"
     inf_MarkSignal      sff_s SLAVE
     create_clock -period 3000 ck
   }

   set fig      [hitas $cellName]
   set name ./check/$cellName
   set beh_fig  [avt_LoadBehavior ./check/$cellName.vhd vhdl]
   set abs_fig  [tma_abstract $fig $beh_fig]
 
   lappend fig_list $abs_fig
   lappend beh_list $beh_fig
 }
 
 lib_drivefile $fig_list $beh_list "$libName.lib" max
