module mac (
  input wire clk,
  input wire reset,
  input wire [3:0] multiplier,
  input wire [3:0] multiplicand,
  output wire [7:0] accumulator_out
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

  assign accumulator_out = accumulator;

endmodule
