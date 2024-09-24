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


`timescale 1 ps/1 ps

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
