module alu_mult(
    input clock,
    input signed [16:0] dataa,
    input signed [16:0] datab,
    output signed [33:0] result
);

reg signed [16:0] a;
reg signed [16:0] b;

always @(posedge clock) begin
    a <= dataa;
    b <= datab;
end

assign result = a * b;

endmodule // alu_mult
