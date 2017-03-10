
set techno [lindex $argv 0]
set cell   [lindex $argv 1]

puts "Using technology:        <$techno>"
puts "Extracting boolean cell: <$cell.spi>"

inf_SetFigureName   $cell
inf_MarkSignal      *ins_sff_m "FLIPFLOP+MASTER"
inf_MarkSignal      *ins_sff_s SLAVE

#inf_SetFigureName   $cell
#inf_MarkSignal      *sff_m "FLIPFLOP+MASTER"
#inf_MarkSignal      *sff_s SLAVE

avt_config   simToolModel  hspice
avt_LoadFile $techno       spice
avt_LoadFile $cell.spi     spice
avt_config   avtVddName    vdd
avt_config   avtVssName    vss
yagle $cell

