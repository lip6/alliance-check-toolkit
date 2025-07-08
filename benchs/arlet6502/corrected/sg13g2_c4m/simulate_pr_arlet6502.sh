../../../../bin/crlenv.py doit clean_flow gds
rm arlet6502_cts_r.v
../../../../bin/crlenv.py -- bash -c "vasy -v -I vst arlet6502_cts_r"
python remove_power_supply.py
iverilog -o  test tb_gate_cpu.v arlet6502_cts_r.v std_cell_sg13g2.v
vvp test
gtkwave dump.vcd signals.gtkw &
