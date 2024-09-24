/*                                                                      */
/*  Avertec Release v3.4p5 (64 bits on Linux 6.7.12+bpo-amd64)          */
/*  [AVT_only] host: fsdev                                              */
/*  [AVT_only] arch: x86_64                                             */
/*  [AVT_only] path: /opt/tasyag-3.4p5/bin/avt_shell                    */
/*  argv:                                                               */
/*                                                                      */
/*  User: verhaegs                                                      */
/*  Generation date Tue Sep 24 13:35:36 2024                            */
/*                                                                      */
/*  Verilog data flow description generated from `IOPadIn`              */
/*                                                                      */


`timescale 1 ps/1 ps

module IOPadIn (p2c, pad);

  output p2c;
  input  pad;

  wire LevelDown_padres_n;
  wire yag_zero;
  wire yag_one;

  assign yag_one = 1'b1;
  assign yag_zero = 1'b0;
  assign LevelDown_padres_n = ~(pad);

  assign p2c = ~(LevelDown_padres_n);

endmodule
