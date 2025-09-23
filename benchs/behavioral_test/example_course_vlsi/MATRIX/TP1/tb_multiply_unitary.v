module tb_multiply_unitary();
localparam  Nbits = 4;
reg [Nbits-1:0] A;
reg [Nbits-1:0] B;
wire [2*Nbits-1:0] C;
multiply_unitary # (.Nbits(4)) mult_tb (.multiplier_u(A),.multiplicand_u(B),.mult_out_u(C));
initial
begin
$dumpfile("dump_multiply_unitary.vcd"); $dumpvars(0, tb_multiply_unitary);
A<=3;
B<=2;
#200;
$finish;
end
endmodule
