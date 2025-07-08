
/* RAM model used to infer RAMs in FPGAs, the interface contains Read enable
* and Write enable */
module RAM_model (
    input wire    clk,
    input wire  [15:0] addr,
    input   wire we,
    input   wire re,
    input   wire  [7:0] data_in,
    output reg  [7:0] data_out
);

    reg [7:0] mem [0:65535];
    always @(posedge clk) begin
		  if (we)
			  mem[addr] <= data_in;
		  if (re) 
			  data_out <= mem[addr];
	 end
endmodule
