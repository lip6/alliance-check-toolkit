../../../../bin/crlenv.py doit clean_flow pnr
rm arlet6502_cts_r.v
../../../../bin/crlenv.py -- bash -c "vasy -v -I vst arlet6502_cts_r"
iverilog -o  test tb_gate_cpu.v arlet6502_cts_r.v std_cell_nsx2.v
vvp test
gtkwave dump.vcd signals.gtkw &
