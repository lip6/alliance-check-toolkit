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
/*  Verilog data flow description generated from `and3_x1`              */
/*                                                                      */


`timescale 1 ps/1 ps

module and3_x1 (q, i0, i1, i2);

  output q;
  input  i0;
  input  i1;
  input  i2;

  wire nq;

  assign nq = (~(i2) | ~(i1) | ~(i0));

  assign q = ~(nq);

endmodule
