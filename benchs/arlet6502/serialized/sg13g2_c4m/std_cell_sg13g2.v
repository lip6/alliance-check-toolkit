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
/*  Verilog data flow description generated from `and21nor_x0`          */
/*                                                                      */



module and21nor_x0 (nq, i0, i1, i2);

  output nq;
  input  i0;
  input  i1;
  input  i2;


  assign nq = ((~(i2) & ~(i1)) | (~(i2) & ~(i0)));

endmodule
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
/*  Verilog data flow description generated from `and21nor_x1`          */
/*                                                                      */



module and21nor_x1 (nq, i0, i1, i2);

  output nq;
  input  i0;
  input  i1;
  input  i2;


  assign nq = ((~(i2) & ~(i1)) | (~(i2) & ~(i0)));

endmodule
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
/*  Verilog data flow description generated from `and2_x1`              */
/*                                                                      */



module and2_x1 (q, i0, i1);

  output q;
  input  i0;
  input  i1;

  wire nq;

  assign nq = (~(i1) | ~(i0));

  assign q = ~(nq);

endmodule
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
/*  Verilog data flow description generated from `and3_x1`              */
/*                                                                      */



module and3_x1 (q, i0, i1, i2);

  output q;
  input  i0;
  input  i1;
  input  i2;

  wire nq;

  assign nq = (~(i2) | ~(i1) | ~(i0));

  assign q = ~(nq);

endmodule
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
/*  Verilog data flow description generated from `and4_x1`              */
/*                                                                      */



module and4_x1 (q, i0, i1, i2, i3);

  output q;
  input  i0;
  input  i1;
  input  i2;
  input  i3;

  wire nq;

  assign nq = (~(i3) | ~(i2) | ~(i1) | ~(i0));

  assign q = ~(nq);

endmodule
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
/*  Verilog data flow description generated from `buf_x1`               */
/*                                                                      */



module buf_x1 (i, q);

  input  i;
  output q;

  wire v_i_n;

  assign v_i_n = ~(i);

  assign q = ~(v_i_n);

endmodule
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
/*  Verilog data flow description generated from `buf_x2`               */
/*                                                                      */



module buf_x2 (i, q);

  input  i;
  output q;

  wire v_i_n;

  assign v_i_n = ~(i);

  assign q = ~(v_i_n);

endmodule
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
/*  Verilog data flow description generated from `buf_x4`               */
/*                                                                      */



module buf_x4 (i, q);

  input  i;
  output q;

  wire v_i_n;

  assign v_i_n = ~(i);

  assign q = ~(v_i_n);

endmodule
/*                                                                      */
/*  Avertec Release v3.4p5 (64 bits on Linux 5.10.0-0.bpo.9-amd64)      */
/*  [AVT_only] host: fsdev                                              */
/*  [AVT_only] arch: x86_64                                             */
/*  [AVT_only] path: /opt/tasyag-3.4p5/bin/avt_shell                    */
/*  argv:                                                               */
/*                                                                      */
/*  User: verhaegs                                                      */
/*  Generation date Thu Feb 10 13:11:38 2022                            */
/*                                                                      */
/*  Verilog data flow description generated from `decap_w0`             */
/*                                                                      */

module tie;

endmodule

module diode_w1 (
    input i
);
endmodule

module decap_w0;

endmodule
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
/*  Verilog data flow description generated from `dffnr_x1`             */
/*                                                                      */



module dffnr_x1 (i, clk, q, nrst);

  input  i;
  input  clk;
  output q;
  input  nrst;

  reg v_dff_m;
  reg v_dff_s;
  wire v_y;
  wire v_u;
  wire v_clk_buf;
  wire v_clk_n;

  assign v_clk_n = ~(clk);
  assign v_clk_buf = ~(v_clk_n);
  assign v_u = ~(i);
  assign v_y = (~(nrst) | ~(v_dff_m));

always @ (nrst or v_clk_n or v_dff_m)
begin
  if (nrst === 1'b0)
    v_dff_s <= 1'b1;
  else if ((nrst === 1'b1 && v_clk_n === 1'b0))
    v_dff_s <= ~(v_dff_m);
end

always @ (nrst or v_clk_n or v_u)
begin
  if ((nrst === 1'b0 && v_clk_n === 1'b0))
    v_dff_m <= 1'b0;
  else if (v_clk_n === 1'b1)
    v_dff_m <= ~(v_u);
end

  assign q = ~(v_dff_s);

endmodule
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
/*  Verilog data flow description generated from `dff_x1`               */
/*                                                                      */


//module dff_x1 (rst,clk, i, q);
//
//  input  	clk;
//  input  	i;
//  input  	rst;
//  output 	q;
//  input  	vdd;
//  input  	vss;
//
//  reg 	  sff_m;
//  reg 	  sff_s;
//  assign	q = ~(sff_s);
//
//  always @ ( i or clk )
//    if (clk == 1'b0) sff_m = i;
//
//  always @ ( sff_m or rst or clk )
//    if (clk == 1'b1) sff_s = ((rst) | ~(sff_m));
//
//endmodule
module dff_x1 (i, clk, q);

  input  i;
  input  clk;
  output q;

  reg v_dff_m;
  reg v_dff_s;
  wire v_y;
  wire v_u;
  wire v_clk_buf;
  wire v_clk_n;

  assign v_clk_n = ~(clk);
  assign v_clk_buf = ~(v_clk_n);
  assign v_u = ~(i);
  assign v_y = ~(v_dff_m);

always @ (v_clk_n or v_dff_m)
begin
  if (v_clk_n === 1'b0)
    v_dff_s <= ~(v_dff_m);
end

always @ (v_clk_n or v_u)
begin
  if (v_clk_n === 1'b1)
    v_dff_m <= ~(v_u);
end

  assign q = ~(v_dff_s);

endmodule
// no model for diode_w1
// no model for fill
// no model for fill_w2
// no model for fill_w4
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
/*  Verilog data flow description generated from `inv_x0`               */
/*                                                                      */



module inv_x0 (i, nq);

  input  i;
  output nq;


  assign nq = ~(i);

endmodule
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
/*  Verilog data flow description generated from `inv_x1`               */
/*                                                                      */



module inv_x1 (i, nq);

  input  i;
  output nq;


  assign nq = ~(i);

endmodule
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
/*  Verilog data flow description generated from `inv_x2`               */
/*                                                                      */



module inv_x2 (i, nq);

  input  i;
  output nq;


  assign nq = ~(i);

endmodule
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
/*  Verilog data flow description generated from `inv_x4`               */
/*                                                                      */



module inv_x4 (i, nq);

  input  i;
  output nq;


  assign nq = ~(i);

endmodule
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
/*  Verilog data flow description generated from `mux2_x1`              */
/*                                                                      */



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
/*  Verilog data flow description generated from `nand2_x0`             */
/*                                                                      */



module nand2_x0 (nq, i0, i1);

  output nq;
  input  i0;
  input  i1;


  assign nq = (~(i1) | ~(i0));

endmodule
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
/*  Verilog data flow description generated from `nand2_x1`             */
/*                                                                      */



module nand2_x1 (nq, i0, i1);

  output nq;
  input  i0;
  input  i1;


  assign nq = (~(i1) | ~(i0));

endmodule
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
/*  Verilog data flow description generated from `nand3_x0`             */
/*                                                                      */



module nand3_x0 (nq, i0, i1, i2);

  output nq;
  input  i0;
  input  i1;
  input  i2;


  assign nq = (~(i2) | ~(i1) | ~(i0));

endmodule
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
/*  Verilog data flow description generated from `nand3_x1`             */
/*                                                                      */



module nand3_x1 (nq, i0, i1, i2);

  output nq;
  input  i0;
  input  i1;
  input  i2;


  assign nq = (~(i2) | ~(i1) | ~(i0));

endmodule
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
/*  Verilog data flow description generated from `nand4_x0`             */
/*                                                                      */



module nand4_x0 (nq, i0, i1, i2, i3);

  output nq;
  input  i0;
  input  i1;
  input  i2;
  input  i3;


  assign nq = (~(i3) | ~(i2) | ~(i1) | ~(i0));

endmodule
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
/*  Verilog data flow description generated from `nand4_x1`             */
/*                                                                      */



module nand4_x1 (nq, i0, i1, i2, i3);

  output nq;
  input  i0;
  input  i1;
  input  i2;
  input  i3;


  assign nq = (~(i3) | ~(i2) | ~(i1) | ~(i0));

endmodule
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
/*  Verilog data flow description generated from `nexor2_x0`            */
/*                                                                      */



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
/*  Verilog data flow description generated from `nor2_x0`              */
/*                                                                      */



module nor2_x0 (nq, i0, i1);

  output nq;
  input  i0;
  input  i1;


  assign nq = (~(i1) & ~(i0));

endmodule
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
/*  Verilog data flow description generated from `nor2_x1`              */
/*                                                                      */



module nor2_x1 (nq, i0, i1);

  output nq;
  input  i0;
  input  i1;


  assign nq = (~(i1) & ~(i0));

endmodule
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
/*  Verilog data flow description generated from `nor3_x0`              */
/*                                                                      */



module nor3_x0 (nq, i0, i1, i2);

  output nq;
  input  i0;
  input  i1;
  input  i2;


  assign nq = (~(i2) & ~(i1) & ~(i0));

endmodule
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



module nor3_x1 (nq, i0, i1, i2);

  output nq;
  input  i0;
  input  i1;
  input  i2;


  assign nq = (~(i2) & ~(i1) & ~(i0));

endmodule
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
/*  Verilog data flow description generated from `nor4_x0`              */
/*                                                                      */



module nor4_x0 (nq, i0, i1, i2, i3);

  output nq;
  input  i0;
  input  i1;
  input  i2;
  input  i3;


  assign nq = (~(i3) & ~(i2) & ~(i1) & ~(i0));

endmodule
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
/*  Verilog data flow description generated from `nor4_x1`              */
/*                                                                      */



module nor4_x1 (nq, i0, i1, i2, i3);

  output nq;
  input  i0;
  input  i1;
  input  i2;
  input  i3;


  assign nq = (~(i3) & ~(i2) & ~(i1) & ~(i0));

endmodule
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
/*  Verilog data flow description generated from `nsnrlatch_x0`         */
/*                                                                      */



module nsnrlatch_x0 (nset, nrst, q, nq);

  input  nset;
  input  nrst;
  inout  q;
  inout  nq;


  assign nq = (~(nrst) | ~(q));
  assign q = (~(nq) | ~(nset));

endmodule
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
/*  Verilog data flow description generated from `nsnrlatch_x1`         */
/*                                                                      */



module nsnrlatch_x1 (nset, nrst, q, nq);

  input  nset;
  input  nrst;
  inout  q;
  inout  nq;


  assign nq = (~(nrst) | ~(q));
  assign q = (~(nq) | ~(nset));

endmodule
/*                                                                      */
/*  Avertec Release v3.4p5 (64 bits on Linux 5.10.0-0.bpo.9-amd64)      */
/*  [AVT_only] host: fsdev                                              */
/*  [AVT_only] arch: x86_64                                             */
/*  [AVT_only] path: /opt/tasyag-3.4p5/bin/avt_shell                    */
/*  argv:                                                               */
/*                                                                      */
/*  User: verhaegs                                                      */
/*  Generation date Thu Feb 10 13:11:38 2022                            */
/*                                                                      */
/*  Verilog data flow description generated from `one_x1`               */
/*                                                                      */



module one_x1 (one);

  output one;
  assign one = 1;

endmodule
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
/*  Verilog data flow description generated from `or21nand_x0`          */
/*                                                                      */



module or21nand_x0 (nq, i0, i1, i2);

  output nq;
  input  i0;
  input  i1;
  input  i2;


  assign nq = (~(i2) | (~(i1) & ~(i0)));

endmodule
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
/*  Verilog data flow description generated from `or21nand_x1`          */
/*                                                                      */



module or21nand_x1 (nq, i0, i1, i2);

  output nq;
  input  i0;
  input  i1;
  input  i2;


  assign nq = (~(i2) | (~(i1) & ~(i0)));

endmodule
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
/*  Verilog data flow description generated from `or2_x1`               */
/*                                                                      */



module or2_x1 (q, i0, i1);

  output q;
  input  i0;
  input  i1;

  wire nq;

  assign nq = (~(i0) & ~(i1));

  assign q = ~(nq);

endmodule
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
/*  Verilog data flow description generated from `or3_x1`               */
/*                                                                      */



module or3_x1 (q, i0, i1, i2);

  output q;
  input  i0;
  input  i1;
  input  i2;

  wire nq;

  assign nq = (~(i0) & ~(i1) & ~(i2));

  assign q = ~(nq);

endmodule
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
/*  Verilog data flow description generated from `or4_x1`               */
/*                                                                      */



module or4_x1 (q, i0, i1, i2, i3);

  output q;
  input  i0;
  input  i1;
  input  i2;
  input  i3;

  wire nq;

  assign nq = (~(i0) & ~(i1) & ~(i2) & ~(i3));

  assign q = ~(nq);

endmodule
// no model for tie_diff
// no model for tie_diff_w2
// no model for tie_diff_w4
// no model for tie_poly
// no model for tie_poly_w2
// no model for tie_poly_w4
// no model for tie
// no model for tie_w2
// no model for tie_w4
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
/*                                                                      */
/*  Avertec Release v3.4p5 (64 bits on Linux 5.10.0-0.bpo.9-amd64)      */
/*  [AVT_only] host: fsdev                                              */
/*  [AVT_only] arch: x86_64                                             */
/*  [AVT_only] path: /opt/tasyag-3.4p5/bin/avt_shell                    */
/*  argv:                                                               */
/*                                                                      */
/*  User: verhaegs                                                      */
/*  Generation date Thu Feb 10 13:11:38 2022                            */
/*                                                                      */
/*  Verilog data flow description generated from `zeroone_x1`           */
/*                                                                      */



module zeroone_x1 (zero, one);

  output zero;
  output one;
  assign zero = 0;
  assign one = 1;

endmodule
/*                                                                      */
/*  Avertec Release v3.4p5 (64 bits on Linux 5.10.0-0.bpo.9-amd64)      */
/*  [AVT_only] host: fsdev                                              */
/*  [AVT_only] arch: x86_64                                             */
/*  [AVT_only] path: /opt/tasyag-3.4p5/bin/avt_shell                    */
/*  argv:                                                               */
/*                                                                      */
/*  User: verhaegs                                                      */
/*  Generation date Thu Feb 10 13:11:38 2022                            */
/*                                                                      */
/*  Verilog data flow description generated from `zero_x1`              */
/*                                                                      */



module zero_x1 (zero);

  output zero;
  assign zero = 0;

endmodule
