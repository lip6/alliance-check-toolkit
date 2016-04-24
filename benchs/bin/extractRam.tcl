
 set techno [lindex $argv 0]
 set cell   [lindex $argv 1]

 puts "Using technology:        <$techno>"
 puts "Extracting boolean cell: <$cell.spi>"


 avt_config   simToolModel         hspice
 avt_LoadFile $techno              spice
 avt_LoadFile $cell.spi            spice
 avt_config   avtVddName           vdd
 avt_config   avtVssName           vss
 avt_config   yagTristateIsMemory  yes
 avt_config   yagMinimizeInvertors yes

 if ([string match block_ram* $cell]) {
   puts "Macro-block is a RAM."
   avt_config   fclLibraryDir        "./check/gns"
   avt_config   gnsLibraryDir        "./check/gns"
   avt_config   yagUseGenius         yes
 }
 
 yagle $cell
