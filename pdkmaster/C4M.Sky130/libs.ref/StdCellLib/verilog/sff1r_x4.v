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
/*  Verilog data flow description generated from `sff1r_x4`             */
/*                                                                      */


`timescale 1 ps/1 ps

module sff1r_x4 (ck, i, nrst, q);

  input  ck;
  input  i;
  input  nrst;
  inout  q;

  reg sff_m;
  wire u;
  wire sff_s;
  wire y;
  wire ckr;
  wire nckr;

  assign nckr = ~(ck);
  assign ckr = ~(nckr);
  assign y = (~(sff_m) | ~(nrst));
  assign sff_s = ((~(ckr) & ~(nrst)) | (~(ckr) & ~(q)) | (~(nckr) & ~(nrst)) |
(~(nckr) & ~(sff_m)));
  assign u = ~(i);

always @ (nckr or u or ckr)
begin
  if (nckr === 1'b1)
    sff_m <= ~(u);
  if (ckr === 1'b0)
    sff_m <= ~(u);
end

  assign q = ~(sff_s);

endmodule
