module counter(input clk, output [7:0] count);

reg [127:0] ctr;

always @(posedge clk) ctr <= ctr + 1'b1;
assign count = ctr[127:120];

endmodule

