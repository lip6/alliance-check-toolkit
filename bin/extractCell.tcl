
set techno      [lindex $argv 0]
set spiceFormat [lindex $argv 1]
set cell        [lindex $argv 2]

puts "Using technology:        <$techno>"
puts "Extracting boolean cell: <$cell.spi>"

if ([string match sff* $cell]) {
  puts "Cell is a D flip-flop."

  inf_SetFigureName   $cell
  inf_MarkSignal      sff_m "FLIPFLOP+MASTER"
  inf_MarkSignal      sff_s SLAVE
}

avt_config   simToolModel  $spiceFormat
avt_LoadFile $techno       spice
avt_LoadFile $cell.spi     spice
avt_config   avtVddName    vdd
avt_config   avtVssName    vss
yagle $cell

