/*
 * Bare wrapper around code mainly to give module the right name
 */

`include "cpu_syncreset.v"
`include "ALU.v"
`include "serializer.v"

module serialized_arlet6502(clk, reset, DI, DO, WE, IRQ, NMI, RDY,  lh);

input clk;              // CPU clock 
input reset;            // reset signal
input [7:0] DI;         // data in, read bus
output [7:0] DO;        // data out, write bus
output WE;              // write enable
input IRQ;              // interrupt request
input NMI;              // non-maskable interrupt request
input RDY;              // Ready signal. Pauses CPU when RDY=0 
output  [2:0] lh;
wire [7:0] DO_in;
wire [15:0] A;        // address bus
wire RDY_cpu;
wire RDY_in;
assign RDY_cpu = RDY & RDY_in;
cpu MOS6502(
    .clk(clk), .reset(reset), .AB(A), .DI(DI), .DO(DO_in), .WE(WE),
    .IRQ(IRQ),.RDY(RDY_cpu), .NMI(NMI)
);
serializer SER (.clk(clk), .reset(reset), .WE(WE), .RDY_in(RDY_in),.lh(lh),.DO_pad(DO),.AB(A),.DO(DO_in));

endmodule // Arlet6502
