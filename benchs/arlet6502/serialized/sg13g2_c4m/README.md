mar. 08 juil. 2025 14:37:59 CEST
in this directory you can place and route the arlet6502, and performe gate level simulation on the IHP sg130g2 technology:
For that run the script:
source simulate_pr_arlet6502.sh
This script does:
../../../../bin/crlenv.py doit clean_flow gds  --> logic synthesis + conversion blif to vst+ placement and routing
rm serialized_arlet6502_cts_r.v
../../../../bin/crlenv.py -- bash -c "vasy -v -I vst serialized_arlet6502_cts_r"   convert vst of the gate level to verilog	   
python remove_power_supply.py                                           adapt the netlist to the spice behavioral lib by removing power supply pins
iverilog -o test gate_serialized_arlet6502_tb_cpu.v serialized_arlet6502_cts_r.v std_cell_sg13g2.v simulation on gate level including the behavioral netlist of std cells
vvp test
gtkwave dump.vcd signals.gtkw &
