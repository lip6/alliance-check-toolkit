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
/*  Verilog data flow description generated from `o2_x2`                */
/*                                                                      */


`timescale 1 ps/1 ps

module o2_x2 (q, i0, i1);

  output q;
  input  i0;
  input  i1;

  wire v_net1;

  assign v_net1 = (~(i1) & ~(i0));

  assign q = ~(v_net1);

endmodule
