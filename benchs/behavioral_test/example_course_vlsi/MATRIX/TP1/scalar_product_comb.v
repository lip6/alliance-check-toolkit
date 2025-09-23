

module scalar_product #
(
  parameter Nbits = 4,
  parameter Ndata = 3
)(
  input  wire [Ndata*Nbits-1:0] A,
  input  wire [Ndata*Nbits-1:0] B,
  output wire [2*Nbits - 1:0] out
);
 wire [Ndata*2*Nbits-1:0] C; 

  wire [(Ndata+1)*2*Nbits-1:0] sum;

  multiply #(
    .Nbits (Nbits),
    .Ndata (Ndata)
  ) multiply_inst (
    .multiplier   (A),
    .multiplicand (B),
    .mult_out     (C)
  );

  assign sum[2*Nbits-1:0] = 0;

  genvar i;
generate 
	 for (i = 0; i < Ndata; i = i + 1)begin
		 assign sum[(i+2)*2*Nbits-1:(i+1)*2*Nbits]= sum[(i+1)*2*Nbits-1:i*2*Nbits]+ C[(i+1)*2*Nbits-1:2*Nbits*i];
    end
    endgenerate

assign out =sum[2*Nbits*(Ndata+1)-1:2*Nbits*Ndata];












endmodule
