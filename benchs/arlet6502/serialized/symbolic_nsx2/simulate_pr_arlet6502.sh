../../../../bin/crlenv.py doit clean_flow pnr
rm serlialized_arlet6502_cts_r.v
../../../../bin/crlenv.py -- bash -c "vasy -v -I vst serialized_arlet6502_cts_r"
iverilog -o test gate_serialized_arlet6502_tb_cpu.v serialized_arlet6502_cts_r.v std_cell_nsx2.v
vvp test
gtkwave dump.vcd signals.gtkw &
