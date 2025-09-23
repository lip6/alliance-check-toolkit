module scalar_product_mac #
(
  parameter Nbits = 4,
  parameter Ndata = 3
)(
  input  wire [Ndata*Nbits-1:0] A,
  input  wire [Ndata*Nbits-1:0] B,
  input  wire clk,
  input  wire reset,
  output wire [2*Nbits - 1:0] out
);

  reg [Ndata*Nbits-1:0] A_tmp;
  reg [Ndata*Nbits-1:0] B_tmp;
  reg [Nbits-1:0] multiplier;
  reg [Nbits-1:0] multiplicand;
  wire [2*Nbits-1:0] accumulator_out;
  mac # (.Nbits (Nbits)) mac_inst 
  (
    .clk(clk),
    .reset(reset),
    .multiplier(multiplier),
    .multiplicand(multiplicand),
    .accumulator_out(out));   
    
  always @(posedge clk)
	  if (reset ) begin
    multiplier <= 0;
    multiplicand <= 0;
    A_tmp <= B;   
    B_tmp <= A;
    end else begin
    A_tmp<= (A_tmp >> Nbits);
    B_tmp<= (B_tmp >> Nbits);
    multiplier <= A_tmp[Nbits-1:0] ;
    multiplicand <= B_tmp[Nbits-1:0];
    end
endmodule

