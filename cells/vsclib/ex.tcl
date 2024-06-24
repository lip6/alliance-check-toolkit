
set techno      techno/spimodel.cfg
set spiceFormat spice
set cell         dfnt1v0x2

puts "Using technology:        <$techno>"
puts "Extracting boolean cell: <$cell.spi>"

if ([string match df* $cell]) {
  puts "Cell is a D flip-flop."

  inf_SetFigureName   $cell
  inf_MarkSignal      df_m "FLIPFLOP+MASTER"
}

avt_config   simToolModel  $spiceFormat
avt_LoadFile $techno       spice
avt_LoadFile $cell.spi     spice
avt_config   avtVddName    vdd
avt_config   avtVssName    vss
yagle $cell

