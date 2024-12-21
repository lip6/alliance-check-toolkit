#!/usr/bin/env avt_shell
set VthHigh 0.8
set VthLow  0.2
set Slop    10e-12
set Temperature 27.0
set VddName  vdd
set VssName  vss
set vddvolt 1.8


set techno      [lindex $argv 0]
set spiceFormat [lindex $argv 1]
set cell        [lindex $argv 2]

set osdidll  {}
set spimodel  {}

puts "MBK_CATA_LIB=$env(MBK_CATA_LIB)"

set idx 3
puts [lindex $argv $idx]

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
     set osdidll [lindex $argv $idx]
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
    puts [lindex $argv $idx]
    puts "Unknown parameter"
    exit 1
    }
 }
}


puts "Using technology:        <$techno>"
puts "Extracting boolean cell: <$cell.spi>"

if ([string match sff* $cell]) {
  puts "Cell is a D flip-flop."

  inf_SetFigureName   $cell
  inf_MarkSignal      sff_m "FLIPFLOP+MASTER"
  inf_MarkSignal      sff_s SLAVE
}

avt_config   yagSetResetDetection yes
avt_config   simToolModel  $spiceFormat
foreach i $osdidll {
	avt_LoadFile $i osdi
}
foreach i $spimodel {
	avt_LoadFile $i spice
}
avt_config simVthHigh $VthHigh
avt_config simVthLow $VthLow
avt_config simSlope $Slop
avt_config simTemperature $Temperature
avt_config simPowerSupply $vddvolt
avt_LoadFile $techno       spice
avt_LoadFile $cell.spi     spice
avt_config   avtVddName    $VddName
avt_config   avtVssName    $VssName
yagle $cell

