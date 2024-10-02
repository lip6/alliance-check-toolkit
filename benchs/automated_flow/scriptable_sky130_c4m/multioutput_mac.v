module multioutput_mac (
  input wire clk,
  input wire reset,
  input wire [3:0] multiplier,
  input wire [3:0] multiplicand,
  output wire [7:0] accumulator_out,
  output wire [9:0] accumulator2_out
);

  reg [7:0] accumulator;
  wire [7:0] partial_product;

  always @(posedge clk) begin
    if (reset) begin
      accumulator <= 8'b0;
    end else begin
      // Multiplier 4 bits multiplier and multiplicand
      partial_product <= multiplier * multiplicand;

      // Add the partial product to the accumulator
      accumulator <= accumulator + partial_product;
    end
  end

  assign accumulator_out[7:0] = accumulator[7:0];
  assign accumulator2_out[7:0] = accumulator[7:0];
  assign accumulator2_out[9] = accumulator[9]+2;
  assign accumulator2_out[8] = accumulator[8]+2;

endmodule
