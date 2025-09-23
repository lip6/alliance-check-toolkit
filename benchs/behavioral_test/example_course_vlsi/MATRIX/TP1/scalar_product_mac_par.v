module scalar_product_mac_par #
(
  parameter Nbits = 4,
  parameter Ndata = 4,
  parameter Nmac = 2
)(
  input  wire [Ndata*Nbits-1:0] A,
  input  wire [Ndata*Nbits-1:0] B,
  input  wire clk,
  input  wire reset,
  output wire [2*Nbits - 1:0] out
);
  wire [Nmac*2*Nbits-1:0]C;
  wire [(Nmac+1)*2*Nbits-1:0] sum;
  assign sum[2*Nbits-1:0] = 0;
  genvar n;
   generate
        for (n = 0; n  < Nmac; n = n + 1) begin
		   scalar_product_mac #(.Nbits (4),.Ndata (Ndata/Nmac))scalar_product_inst (
                  .A(A[(n+1)*(Ndata/Nmac*Nbits)-1:n*(Ndata/Nmac*Nbits)]),
                  .B(B[(n+1)*(Ndata/Nmac*Nbits)-1:n*(Ndata/Nmac*Nbits)]),
                  .out(C[(n+1)*(2*Nbits)-1:n*2*Nbits]),
                  .clk(clk),
                  .reset(reset));
	           assign sum[(n+2)*2*Nbits-1:(n+1)*2*Nbits]= sum[(n+1)*2*Nbits-1:n*2*Nbits]+ C[(n+1)*2*Nbits-1:2*Nbits*n];
	  
	end
endgenerate
assign out = sum[2*Nbits*(Nmac+1)-1:2*Nbits*Nmac];   
endmodule

