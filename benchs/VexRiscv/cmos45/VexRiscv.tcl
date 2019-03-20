set verilog_file VexRiscv.v
set verilog_top  VexRiscv
set liberty_file /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/cells/nsxlib/nsxlib.lib
yosys read_verilog          $verilog_file
yosys hierarchy -check -top $verilog_top
yosys synth            -top $verilog_top
yosys dfflibmap -liberty    $liberty_file
yosys abc       -liberty    $liberty_file
yosys clean
yosys write_blif VexRiscv.blif
