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
/*  Verilog data flow description generated from `nor3_x1`              */
/*                                                                      */


`timescale 1 ps/1 ps

module nor3_x1 (nq, i0, i1, i2);

  output nq;
  input  i0;
  input  i1;
  input  i2;


  assign nq = (~(i2) & ~(i1) & ~(i0));

endmodule
