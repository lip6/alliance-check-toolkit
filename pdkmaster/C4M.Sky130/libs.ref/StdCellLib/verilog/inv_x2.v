/*                                                                      */
/*  Avertec Release v3.4p5 (64 bits on Linux 5.10.0-0.bpo.9-amd64)      */
/*  [AVT_only] host: fsdev                                              */
/*  [AVT_only] arch: x86_64                                             */
/*  [AVT_only] path: /opt/tasyag-3.4p5/bin/avt_shell                    */
/*  argv:                                                               */
/*                                                                      */
/*  User: verhaegs                                                      */
/*  Generation date Wed Dec 22 09:42:03 2021                            */
/*                                                                      */
/*  Verilog data flow description generated from `inv_x2`               */
/*                                                                      */


`timescale 1 ps/1 ps

module inv_x2 (i, nq);

  input  i;
  output nq;


  assign nq = ~(i);

endmodule