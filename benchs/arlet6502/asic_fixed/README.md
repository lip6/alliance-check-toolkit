jeu. 03 juil. 2025 12:23:55 CEST

ALU.v:
Define default states to prevent latch inference.
cpu_syncreset.v:
RDY behavior updated:
RDY now implements a true freeze. When RDY=1, the CPU runs normally. When RDY=0, the CPU stops completely and ignores inputs. Upon returning to RDY=1, execution resumes with fresh inputs. Only the PC, state, and IR are now gated by RDY. Unlike before, the IR also freezes. RDY is sampled synchronously.
Define default states to prevent latch inference.
Define reset states for unintialized registers.

You can run simulations using : (READ the header of the testbench for simulation details)
iverilog -o test tb_Arlet6502.v Arlet6502.v
vvp test
gtkwave  dump.vcd signals.gtkw
In this directory you can also target the technologies:
 -FPGA_DE2_115
 -sg130g2 (IHP)
 -nsx2    (symbolic that could target Sg130g2, SKY130, GF180)
You can perform P&R and gate level simulations. Read the README.md of each technology for details.
