/*                                                                      */
/*  Avertec Release v3.4p5 (64 bits on Linux 5.10.0-15-amd64)           */
/*  [AVT_only] host: fsdev                                              */
/*  [AVT_only] arch: x86_64                                             */
/*  [AVT_only] path: /opt/tasyag-3.4p5/bin/avt_shell                    */
/*  argv:                                                               */
/*                                                                      */
/*  User: verhaegs                                                      */
/*  Generation date Mon Jul 25 16:04:02 2022                            */
/*                                                                      */
/*  Verilog data flow description generated from `sff1_x4`              */
/*                                                                      */


`timescale 1 ps/1 ps

module sff1_x4 (ck, i, q);

  input  ck;
  input  i;
  output q;

  reg sff_m;
  wire u;
  wire ck_delayed;

  assign ck'delayed = 1'bx;
  assign u = ~(i);

always @ (posedge ck)
begin
  sff_m <= ~(u);
end

  assign q = sff_m;

endmodule
