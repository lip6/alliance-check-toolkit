
`timescale	1ns / 1ns
`default_nettype none

/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Wed Mar 16 01:49:26 2016
 Licensed to :EVALUATION USER
*/

// synthesis translate_off
// synopsys translate_off
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module cputest ( p_reset , m_clock );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  wire res;
  reg [7:0] m [0:255];
  reg [63:0] _reg_0;
  wire [7:0] _p_dbusi;
  wire [7:0] _p_dbuso;
  wire [7:0] _p_adder;
  wire _p_mread;
  wire _p_mwrite;
  wire _p_p_reset;
  wire _p_m_clock;
  wire [7:0] _net_2;
  wire [7:0] _net_3;
  wire _net_4;
  reg _reg_5;
  reg _reg_6;
  reg _reg_7;
  reg _reg_8;
  reg _reg_9;
  wire _net_11;
  wire _reg_7_goto;
  wire _reg_7_goin;
  reg [63:0] _time;
cpu p (.m_clock(m_clock), .p_reset(_p_p_reset), .mwrite(_p_mwrite), .mread(_p_mread), .adder(_p_adder), .dbuso(_p_dbuso), .dbusi(_p_dbusi));

always @(posedge res)
  begin
#1 if (res===1'bx)
 begin
$display("Warning: control hazard(cputest:res) at %d",$time);
 end
#1 if ((((_net_4|_reg_9))===1'bx) || (1'b1)===1'bx) $display("hazard ((_net_4|_reg_9) || 1'b1) line 56 at %d\n",$time);
 end
   assign  res = (_net_4|_reg_9);
   assign  _p_dbusi = (_p_mread)? ((_p_mread)?(m[_p_adder]):8'b0):8'bx;
always @(posedge m_clock or posedge p_reset)
  begin
if (((~res)&res))
 begin $display("Warning: assign collision(cputest:_p_p_reset) at %d",$time);
if ((~res)) $display("assert ((~res)) line 53 at %d\n",$time);
if (res) $display("assert (res) line 52 at %d\n",$time);
 end
 end
   assign  _p_p_reset = (((~res)&res))? 1'bx :(((~res)|res))? (((~res))?1'b0:1'b0)|
    ((res)?1'b1:1'b0):1'bx;
   assign  _p_m_clock = m_clock;
   assign  _net_2 = (_p_mwrite)? ((_p_mwrite)?_net_3:8'b0):8'bx;
   assign  _net_3 = _p_adder;
   assign  _net_4 = ((_time)==64'b0000000000000000000000000000000000000000000000000000000000000010);
always @(posedge m_clock)
  begin
    if(_reg_5)
    begin
    $stop;
    end
  end
   assign  _net_11 = (_reg_7)? ((_reg_7)?((_time) < _reg_0):1'b0):1'bx;
always @(posedge _reg_7_goto)
  begin
#1 if (_reg_7_goto===1'bx)
 begin
$display("Warning: control hazard(cputest:_reg_7_goto) at %d",$time);
 end
#1 if ((((_reg_7&_net_11))===1'bx) || (1'b1)===1'bx) $display("hazard ((_reg_7&_net_11) || 1'b1) line 57 at %d\n",$time);
 end
   assign  _reg_7_goto = (_reg_7&_net_11);
always @(posedge _reg_7_goin)
  begin
#1 if (_reg_7_goin===1'bx)
 begin
$display("Warning: control hazard(cputest:_reg_7_goin) at %d",$time);
 end
#1 if ((((_reg_7&_net_11))===1'bx) || (1'b1)===1'bx) $display("hazard ((_reg_7&_net_11) || 1'b1) line 57 at %d\n",$time);
 end
   assign  _reg_7_goin = (_reg_7&_net_11);
initial begin
    m[0] <= 8'b10000001;
    m[1] <= 8'b00000011;
    m[2] <= 8'b10000101;
    m[3] <= 8'b00000111;
    m[4] <= 8'b00000011;
    m[5] <= 8'b10000100;
    m[6] <= 8'b00000010;
    m[7] <= 8'b10000100;
    m[8] <= 8'b00000111;
    m[9] <= 0;
    m[10] <= 0;
    m[11] <= 0;
    m[12] <= 0;
    m[13] <= 0;
    m[14] <= 0;
    m[15] <= 0;
    m[16] <= 0;
    m[17] <= 0;
    m[18] <= 0;
    m[19] <= 0;
    m[20] <= 0;
    m[21] <= 0;
    m[22] <= 0;
    m[23] <= 0;
    m[24] <= 0;
    m[25] <= 0;
    m[26] <= 0;
    m[27] <= 0;
    m[28] <= 0;
    m[29] <= 0;
    m[30] <= 0;
    m[31] <= 0;
    m[32] <= 0;
    m[33] <= 0;
    m[34] <= 0;
    m[35] <= 0;
    m[36] <= 0;
    m[37] <= 0;
    m[38] <= 0;
    m[39] <= 0;
    m[40] <= 0;
    m[41] <= 0;
    m[42] <= 0;
    m[43] <= 0;
    m[44] <= 0;
    m[45] <= 0;
    m[46] <= 0;
    m[47] <= 0;
    m[48] <= 0;
    m[49] <= 0;
    m[50] <= 0;
    m[51] <= 0;
    m[52] <= 0;
    m[53] <= 0;
    m[54] <= 0;
    m[55] <= 0;
    m[56] <= 0;
    m[57] <= 0;
    m[58] <= 0;
    m[59] <= 0;
    m[60] <= 0;
    m[61] <= 0;
    m[62] <= 0;
    m[63] <= 0;
    m[64] <= 0;
    m[65] <= 0;
    m[66] <= 0;
    m[67] <= 0;
    m[68] <= 0;
    m[69] <= 0;
    m[70] <= 0;
    m[71] <= 0;
    m[72] <= 0;
    m[73] <= 0;
    m[74] <= 0;
    m[75] <= 0;
    m[76] <= 0;
    m[77] <= 0;
    m[78] <= 0;
    m[79] <= 0;
    m[80] <= 0;
    m[81] <= 0;
    m[82] <= 0;
    m[83] <= 0;
    m[84] <= 0;
    m[85] <= 0;
    m[86] <= 0;
    m[87] <= 0;
    m[88] <= 0;
    m[89] <= 0;
    m[90] <= 0;
    m[91] <= 0;
    m[92] <= 0;
    m[93] <= 0;
    m[94] <= 0;
    m[95] <= 0;
    m[96] <= 0;
    m[97] <= 0;
    m[98] <= 0;
    m[99] <= 0;
    m[100] <= 0;
    m[101] <= 0;
    m[102] <= 0;
    m[103] <= 0;
    m[104] <= 0;
    m[105] <= 0;
    m[106] <= 0;
    m[107] <= 0;
    m[108] <= 0;
    m[109] <= 0;
    m[110] <= 0;
    m[111] <= 0;
    m[112] <= 0;
    m[113] <= 0;
    m[114] <= 0;
    m[115] <= 0;
    m[116] <= 0;
    m[117] <= 0;
    m[118] <= 0;
    m[119] <= 0;
    m[120] <= 0;
    m[121] <= 0;
    m[122] <= 0;
    m[123] <= 0;
    m[124] <= 0;
    m[125] <= 0;
    m[126] <= 0;
    m[127] <= 0;
    m[128] <= 0;
    m[129] <= 0;
    m[130] <= 0;
    m[131] <= 0;
    m[132] <= 0;
    m[133] <= 0;
    m[134] <= 0;
    m[135] <= 0;
    m[136] <= 0;
    m[137] <= 0;
    m[138] <= 0;
    m[139] <= 0;
    m[140] <= 0;
    m[141] <= 0;
    m[142] <= 0;
    m[143] <= 0;
    m[144] <= 0;
    m[145] <= 0;
    m[146] <= 0;
    m[147] <= 0;
    m[148] <= 0;
    m[149] <= 0;
    m[150] <= 0;
    m[151] <= 0;
    m[152] <= 0;
    m[153] <= 0;
    m[154] <= 0;
    m[155] <= 0;
    m[156] <= 0;
    m[157] <= 0;
    m[158] <= 0;
    m[159] <= 0;
    m[160] <= 0;
    m[161] <= 0;
    m[162] <= 0;
    m[163] <= 0;
    m[164] <= 0;
    m[165] <= 0;
    m[166] <= 0;
    m[167] <= 0;
    m[168] <= 0;
    m[169] <= 0;
    m[170] <= 0;
    m[171] <= 0;
    m[172] <= 0;
    m[173] <= 0;
    m[174] <= 0;
    m[175] <= 0;
    m[176] <= 0;
    m[177] <= 0;
    m[178] <= 0;
    m[179] <= 0;
    m[180] <= 0;
    m[181] <= 0;
    m[182] <= 0;
    m[183] <= 0;
    m[184] <= 0;
    m[185] <= 0;
    m[186] <= 0;
    m[187] <= 0;
    m[188] <= 0;
    m[189] <= 0;
    m[190] <= 0;
    m[191] <= 0;
    m[192] <= 0;
    m[193] <= 0;
    m[194] <= 0;
    m[195] <= 0;
    m[196] <= 0;
    m[197] <= 0;
    m[198] <= 0;
    m[199] <= 0;
    m[200] <= 0;
    m[201] <= 0;
    m[202] <= 0;
    m[203] <= 0;
    m[204] <= 0;
    m[205] <= 0;
    m[206] <= 0;
    m[207] <= 0;
    m[208] <= 0;
    m[209] <= 0;
    m[210] <= 0;
    m[211] <= 0;
    m[212] <= 0;
    m[213] <= 0;
    m[214] <= 0;
    m[215] <= 0;
    m[216] <= 0;
    m[217] <= 0;
    m[218] <= 0;
    m[219] <= 0;
    m[220] <= 0;
    m[221] <= 0;
    m[222] <= 0;
    m[223] <= 0;
    m[224] <= 0;
    m[225] <= 0;
    m[226] <= 0;
    m[227] <= 0;
    m[228] <= 0;
    m[229] <= 0;
    m[230] <= 0;
    m[231] <= 0;
    m[232] <= 0;
    m[233] <= 0;
    m[234] <= 0;
    m[235] <= 0;
    m[236] <= 0;
    m[237] <= 0;
    m[238] <= 0;
    m[239] <= 0;
    m[240] <= 0;
    m[241] <= 0;
    m[242] <= 0;
    m[243] <= 0;
    m[244] <= 0;
    m[245] <= 0;
    m[246] <= 0;
    m[247] <= 0;
    m[248] <= 0;
    m[249] <= 0;
    m[250] <= 0;
    m[251] <= 0;
    m[252] <= 0;
    m[253] <= 0;
    m[254] <= 0;
    m[255] <= 0;
end
always @(posedge m_clock)
  begin
   if (_p_mwrite )
     m[_net_2] <= _p_dbuso;
end
always @(posedge m_clock)
  begin
if (_reg_8)
      _reg_0 <= ((_time)+64'b0000000000000000000000000000000000000000000000000000000101011100);
end
always @(posedge m_clock or posedge p_reset)
  begin
if (p_reset)
     _reg_5 <= 1'b0;
else if ((_reg_5|_reg_6))
      _reg_5 <= _reg_6;
end
always @(posedge m_clock or posedge p_reset)
  begin
if (p_reset)
     _reg_6 <= 1'b0;
else if ((_reg_6|_reg_7))
      _reg_6 <= (_reg_7&(~_reg_7_goto));
end
always @(posedge m_clock or posedge p_reset)
  begin
if (p_reset)
     _reg_7 <= 1'b0;
else if (((_reg_7&_net_11)|(_reg_7|_reg_8)))
      _reg_7 <= ((_reg_7&_net_11)|_reg_8);
end
always @(posedge m_clock or posedge p_reset)
  begin
if (p_reset)
     _reg_8 <= 1'b0;
else if ((_net_4|(_reg_8|_reg_9)))
      _reg_8 <= (_reg_9|_net_4);
end
always @(posedge m_clock or posedge p_reset)
  begin
if (p_reset)
     _reg_9 <= 1'b0;
else if (_reg_9)
      _reg_9 <= 1'b0;
end
initial begin
     _time = 64'b0000000000000000000000000000000000000000000000000000000000000000;
end
always @(posedge m_clock)
  begin
  _time <= (_time+64'b0000000000000000000000000000000000000000000000000000000000000001);
end
endmodule

// synthesis translate_on
// synopsys translate_on
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Wed Mar 16 01:49:26 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Wed Mar 16 01:49:26 2016
 Licensed to :EVALUATION USER:
*/

//synthesis translate_off
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/
module tb;
	parameter tCYC=2;
	parameter tPD=(tCYC/10);

	reg p_reset;
	reg m_clock;

	cputest cputest_instance(
		.p_reset(p_reset),
		.m_clock(m_clock)
	);

	initial forever #(tCYC/2) m_clock = ~m_clock;

	initial begin
		$dumpfile("cputest.vcd");
		$dumpvars(0,cputest_instance);
	end

	initial begin
		#(tPD)
			p_reset = 1;
			m_clock = 0;
		#(tCYC)
			p_reset = 0;
	end

endmodule

//synthesis translate_on
