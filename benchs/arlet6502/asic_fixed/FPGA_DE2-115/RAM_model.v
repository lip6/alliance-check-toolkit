//RAM model used for FPGA
module RAM_model (
    input wire    clk,
    input wire  [15:0] addr,
    input   wire we,
    input   wire  [7:0] data_in,
    output reg  [7:0] data_out
);
reg [7:0] mem [0:65535];
always @(posedge clk) begin
	if (we)
		mem[addr] <= data_in;
	else  
		data_out <= mem[addr];
end
endmodule
