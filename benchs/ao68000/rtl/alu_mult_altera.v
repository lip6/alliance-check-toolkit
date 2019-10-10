module alu_mult(
    input clock,
    input signed [16:0] dataa,
    input signed [16:0] datab,
    output signed [33:0] result
);

lpm_mult muls(
    .clock  (clock),
    .dataa  (dataa),
    .datab  (datab),
    .result (result)
);
defparam
    muls.lpm_widtha = 17,
    muls.lpm_widthb = 17,
    muls.lpm_widthp = 34,
    muls.lpm_representation = "SIGNED",
    muls.lpm_pipeline = 1;

endmodule // alu_mult
