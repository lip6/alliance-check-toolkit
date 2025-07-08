lun. 07 juil. 2025 13:44:23 CEST
This directory contains rtl files for a serialized MOS6502 CPU. This version uses the ../rtl_corrected version.
DO[7:0] and AB[15:0] are serialized into DO_PAD[7:0] to reduce the number of output pads.
This was originally implemented to meet IHP SG13G2 tape-out constraints, where the number of available pads was limited.
To run simulaitons:(READ the header of the testbench for simulation details)
iverilog -o test  tb_serialized_arlet6502.v serialized_arlet6502.v
vvp test
gtkwave dump.vcd signals.gtkw 
In this directory you can also target the technologies:
 -FPGA_DE2_115
 -sg130g2 (IHP)
 -nsx2    (symbolic that could target Sg130g2, SKY130, GF180)
You can perform P&R and gate level simulations. Read the README.md of each technology for details.
