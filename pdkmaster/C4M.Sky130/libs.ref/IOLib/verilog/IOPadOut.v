/*                                                                      */
/*  Avertec Release v3.4p5 (64 bits on Linux 6.6.13+bpo-amd64)          */
/*  [AVT_only] host: fsdev                                              */
/*  [AVT_only] arch: x86_64                                             */
/*  [AVT_only] path: /opt/tasyag-3.4p5/bin/avt_shell                    */
/*  argv:                                                               */
/*                                                                      */
/*  User: verhaegs                                                      */
/*  Generation date Wed May 29 10:55:34 2024                            */
/*                                                                      */
/*  Verilog data flow description generated from `IOPadOut`             */
/*                                                                      */


`timescale 1 ps/1 ps

module IOPadOut (c2p, pad);

  input  c2p;
  output pad;

  reg pad_bebus;
  reg gatelu_ngate_levelup_lvld_n;
  reg gatelu_ngate_levelup_lvld;
  reg gatelu_pgate_levelup_lvld_n;
  reg gatelu_pgate_levelup_lvld;
  wire pgate;
  wire ngate;
  wire gatelu_ngate_levelup_i_n;
  wire gatelu_pgate_levelup_i_n;
  wire yag_zero;
  wire yag_one;

  assign yag_one = 1'b1;
  assign yag_zero = 1'b0;
  assign gatelu_pgate_levelup_i_n = ~(c2p);
  assign gatelu_ngate_levelup_i_n = ~(c2p);
  assign ngate = ~(gatelu_ngate_levelup_lvld_n);
  assign pgate = ~(gatelu_pgate_levelup_lvld_n);

always @ (c2p or gatelu_pgate_levelup_lvld_n)
begin
  if (c2p === 1'b1)
    gatelu_pgate_levelup_lvld <= 1'b0;
  else if (gatelu_pgate_levelup_lvld_n === 1'b0)
    gatelu_pgate_levelup_lvld <= 1'b1;
  else
    gatelu_pgate_levelup_lvld <= 1'bz;
end

always @ (gatelu_pgate_levelup_i_n or gatelu_pgate_levelup_lvld)
begin
  if (gatelu_pgate_levelup_i_n === 1'b1)
    gatelu_pgate_levelup_lvld_n <= 1'b0;
  else if (gatelu_pgate_levelup_lvld === 1'b0)
    gatelu_pgate_levelup_lvld_n <= 1'b1;
  else
    gatelu_pgate_levelup_lvld_n <= 1'bz;
end

always @ (c2p or gatelu_ngate_levelup_lvld_n)
begin
  if (c2p === 1'b1)
    gatelu_ngate_levelup_lvld <= 1'b0;
  else if (gatelu_ngate_levelup_lvld_n === 1'b0)
    gatelu_ngate_levelup_lvld <= 1'b1;
  else
    gatelu_ngate_levelup_lvld <= 1'bz;
end

always @ (gatelu_ngate_levelup_i_n or gatelu_ngate_levelup_lvld)
begin
  if (gatelu_ngate_levelup_i_n === 1'b1)
    gatelu_ngate_levelup_lvld_n <= 1'b0;
  else if (gatelu_ngate_levelup_lvld === 1'b0)
    gatelu_ngate_levelup_lvld_n <= 1'b1;
  else
    gatelu_ngate_levelup_lvld_n <= 1'bz;
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
