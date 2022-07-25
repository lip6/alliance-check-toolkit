`include "counter.v"

module counter_harness(
    input [37:0] io_in,
    output [37:0] io_out,
    output [37:0] io_oeb,
);

counter counter(
    .clk(io_in[30]),
    .count(io_out[11:4])
);

assign io_oeb[30] = 1;
assign io_out[30] = 0;

assign io_oeb[11:4] = 0;

endmodule
