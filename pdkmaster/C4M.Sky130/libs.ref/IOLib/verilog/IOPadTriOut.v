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
/*  Verilog data flow description generated from `IOPadTriOut`          */
/*                                                                      */


`timescale 1 ps/1 ps

module IOPadTriOut (c2p, c2p_en, pad);

  input  c2p;
  input  c2p_en;
  output pad;

  reg pad_bebus;
  reg gatedec_ngate_levelup_lvld_n;
  reg gatedec_ngate_levelup_lvld;
  reg gatedec_pgate_levelup_lvld_n;
  reg gatedec_pgate_levelup_lvld;
  wire pgate;
  wire ngate;
  wire gatedec_en_n;
  wire gatedec_ngate_core;
  wire gatedec_pgate_core;
  wire gatedec_ngate_levelup_i_n;
  wire gatedec_pgate_levelup_i_n;
  wire yag_zero;
  wire yag_one;

  assign yag_one = 1'b1;
  assign yag_zero = 1'b0;
  assign gatedec_pgate_levelup_i_n = ~(gatedec_pgate_core);
  assign gatedec_ngate_levelup_i_n = ~(gatedec_ngate_core);
  assign gatedec_pgate_core = (~(c2p_en) | ~(c2p));
  assign gatedec_ngate_core = (~(gatedec_en_n) & ~(c2p));
  assign gatedec_en_n = ~(c2p_en);
  assign ngate = ~(gatedec_ngate_levelup_lvld_n);
  assign pgate = ~(gatedec_pgate_levelup_lvld_n);

always @ (gatedec_pgate_levelup_i_n or gatedec_pgate_levelup_lvld_n)
begin
  if (gatedec_pgate_levelup_i_n === 1'b1)
    gatedec_pgate_levelup_lvld <= 1'b0;
  else if (gatedec_pgate_levelup_lvld_n === 1'b0)
    gatedec_pgate_levelup_lvld <= 1'b1;
  else
    gatedec_pgate_levelup_lvld <= 1'bz;
end

always @ (gatedec_pgate_core or gatedec_pgate_levelup_lvld)
begin
  if (gatedec_pgate_core === 1'b1)
    gatedec_pgate_levelup_lvld_n <= 1'b0;
  else if (gatedec_pgate_levelup_lvld === 1'b0)
    gatedec_pgate_levelup_lvld_n <= 1'b1;
  else
    gatedec_pgate_levelup_lvld_n <= 1'bz;
end

always @ (gatedec_ngate_levelup_i_n or gatedec_ngate_levelup_lvld_n)
begin
  if (gatedec_ngate_levelup_i_n === 1'b1)
    gatedec_ngate_levelup_lvld <= 1'b0;
  else if (gatedec_ngate_levelup_lvld_n === 1'b0)
    gatedec_ngate_levelup_lvld <= 1'b1;
  else
    gatedec_ngate_levelup_lvld <= 1'bz;
end

always @ (gatedec_ngate_core or gatedec_ngate_levelup_lvld)
begin
  if (gatedec_ngate_core === 1'b1)
    gatedec_ngate_levelup_lvld_n <= 1'b0;
  else if (gatedec_ngate_levelup_lvld === 1'b0)
    gatedec_ngate_levelup_lvld_n <= 1'b1;
  else
    gatedec_ngate_levelup_lvld_n <= 1'bz;
end

always @ (ngate or pgate)
begin
  if (ngate === 1'b1)
    pad_bebus <= 1'b0;
  else if (pgate === 1'b0)
    pad_bebus <= 1'b1;
  else
    pad_bebus <= 1'bz;
end
assign pad = pad_bebus;

endmodule
