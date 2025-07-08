../../../../bin/crlenv.py doit clean_flow gds
rm serlialized_arlet6502_cts_r.v
../../../../bin/crlenv.py -- bash -c "vasy -v -I vst serialized_arlet6502_cts_r"
python remove_power_supply.py
iverilog -o test gate_serialized_arlet6502_tb_cpu.v serialized_arlet6502_cts_r.v std_cell_sg13g2.v
vvp test
gtkwave dump.vcd signals.gtkw &
