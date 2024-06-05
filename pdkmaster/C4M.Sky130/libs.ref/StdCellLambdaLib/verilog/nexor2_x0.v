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
/*  Verilog data flow description generated from `nexor2_x0`            */
/*                                                                      */


`timescale 1 ps/1 ps

module nexor2_x0 (i0, i1, nq);

  input  i0;
  input  i1;
  output nq;

  wire i1_n;
  wire i0_n;

  assign i0_n = ~(i0);
  assign i1_n = ~(i1);

  assign nq = ((~(i0_n) & ~(i1_n)) | (~(i0_n) & ~(i0)) | (~(i1) & ~(i1_n))
| (~(i1) & ~(i0)));

endmodule
