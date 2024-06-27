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
/*  Verilog data flow description generated from `mux2_x1`              */
/*                                                                      */


`timescale 1 ps/1 ps

module mux2_x1 (i0, i1, cmd, q);

  input  i0;
  input  i1;
  input  cmd;
  output q;

  wire v_q_n;
  wire cmd_n;

  assign cmd_n = ~(cmd);
  assign v_q_n = ((~(cmd_n) & ~(i1)) | (~(cmd) & ~(i0)));

  assign q = ~(v_q_n);

endmodule
