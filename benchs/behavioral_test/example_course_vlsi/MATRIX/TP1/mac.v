module mac # 
 (parameter Nbits = 4) (
  input wire clk,
  input wire reset,
  input wire [Nbits-1:0] multiplier,
  input wire [Nbits-1:0] multiplicand,
  output reg [2*Nbits-1:0] accumulator_out);
multiply_unitary #(
                    .Nbits (Nbits)
                ) u_multiply_unitary (
                    .multiplier_u   (multiplier),
                    .multiplicand_u   (multiplicand),
                    .mult_out_u (partial_product)
                );

  wire [2*Nbits-1:0] partial_product;

  always @(posedge clk) begin
    if (reset) begin
      accumulator_out <= 0;
    end else begin
      accumulator_out <= accumulator_out + partial_product; 
    end
  end

endmodule
