/*                                                                      */
/*  Avertec Release v3.4p5 (64 bits on Linux 6.7.12+bpo-amd64)          */
/*  [AVT_only] host: fsdev                                              */
/*  [AVT_only] arch: x86_64                                             */
/*  [AVT_only] path: /opt/tasyag-3.4p5/bin/avt_shell                    */
/*  argv:                                                               */
/*                                                                      */
/*  User: verhaegs                                                      */
/*  Generation date Tue Sep 24 13:35:35 2024                            */
/*                                                                      */
/*  Verilog data flow description generated from `xor2_x0`              */
/*                                                                      */


`timescale 1 ps/1 ps

module xor2_x0 (i0, i1, q);

  input  i0;
  input  i1;
  output q;

  wire i1_n;
  wire i0_n;

  assign i0_n = ~(i0);
  assign i1_n = ~(i1);

  assign q = ((~(i0_n) & ~(i1)) | (~(i0_n) & ~(i0)) | (~(i1_n) & ~(i1)) |
(~(i1_n) & ~(i0)));

endmodule
