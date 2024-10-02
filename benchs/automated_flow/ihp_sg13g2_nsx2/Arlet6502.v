/*
 * Bare wrapper around code mainly to give module the right name
 */

`include "ALU.v"
`include "cpu_syncreset.v"

module Arlet6502(clk, reset, A, DI, DO, WE, IRQ, NMI, RDY);

input clk;              // CPU clock 
input reset;            // reset signal
output [15:0] A;        // address bus
input [7:0] DI;         // data in, read bus
output [7:0] DO;        // data out, write bus
output WE;              // write enable
input IRQ;              // interrupt request
input NMI;              // non-maskable interrupt request
input RDY;              // Ready signal. Pauses CPU when RDY=0 

cpu MOS6502(
    .clk(clk), .reset(reset), .AB(A), .DI(DI), .DO(DO), .WE(WE),
    .IRQ(IRQ), .NMI(NMI), .RDY(RDY)
);

endmodule // Arlet6502
