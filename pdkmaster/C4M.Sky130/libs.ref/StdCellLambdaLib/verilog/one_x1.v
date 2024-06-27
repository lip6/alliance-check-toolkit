/*                                                                      */
/*  Avertec Release v3.4p5 (64 bits on Linux 6.6.13+bpo-amd64)          */
/*  [AVT_only] host: fsdev                                              */
/*  [AVT_only] arch: x86_64                                             */
/*  [AVT_only] path: /opt/tasyag-3.4p5/bin/avt_shell                    */
/*  argv:                                                               */
/*                                                                      */
/*  User: verhaegs                                                      */
/*  Generation date Wed May 29 10:55:23 2024                            */
/*                                                                      */
/*  Verilog data flow description generated from `one_x1`               */
/*                                                                      */


`timescale 1 ps/1 ps

module one_x1 (one);

  inout  one;

  reg one_bebus;
  reg zero;

always @ (one)
begin
  if (one === 1'b1)
    zero <= 1'b0;
  else
    zero <= 1'bz;
end

always @ (zero)
begin
  if (zero === 1'b0)
    one_bebus <= 1'b1;
  else
    one_bebus <= 1'bz;
end
assign one = one_bebus;

endmodule
