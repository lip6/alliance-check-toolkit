module multiply_unitary #
 (parameter Nbits = 4)(
  input wire [Nbits-1:0] multiplier_u,
  input wire [Nbits-1:0] multiplicand_u,
  output wire [2*Nbits-1:0] mult_out_u
);
       assign  mult_out_u =multiplier_u * multiplicand_u;
endmodule
