module multiply #
 (parameter Nbits = 4,Ndata = 3)(
  input wire [Ndata*Nbits-1:0] multiplier,
  input wire [Ndata*Nbits-1:0] multiplicand,
  output wire [Ndata*2*Nbits-1:0] mult_out
);

    genvar index;
    generate
        for (index = 0; index  < Ndata; index = index + 1) begin 
                multiply_unitary #(
                    .Nbits (Nbits)
                ) u_multiply_unitary (
                    .multiplier_u    (  multiplicand[(index+1)*Nbits -1 : index*Nbits]),
                    .multiplicand_u  (  multiplier[(index+1)*Nbits   -1 : index*Nbits]),
                    .mult_out_u      (  mult_out[(index+1)*2*Nbits   -1 : 2*Nbits*index] )
                );
        end
    endgenerate
 endmodule 
