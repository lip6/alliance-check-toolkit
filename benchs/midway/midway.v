/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:01 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module midway ( p_reset , m_clock , btn , RXD , PS2D , PS2C , TXD , VGA_R , VGA_G , VGA_B , VGA_H , VGA_V , led , sseg , an , sw );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [2:0] btn;
  wire [2:0] btn;
  input RXD;
  wire RXD;
  input PS2D;
  wire PS2D;
  input PS2C;
  wire PS2C;
  output TXD;
  wire TXD;
  output VGA_R;
  wire VGA_R;
  output VGA_G;
  wire VGA_G;
  output VGA_B;
  wire VGA_B;
  output VGA_H;
  wire VGA_H;
  output VGA_V;
  wire VGA_V;
  output [7:0] led;
  wire [7:0] led;
  output [7:0] sseg;
  wire [7:0] sseg;
  output [3:0] an;
  wire [3:0] an;
  input [7:0] sw;
  wire [7:0] sw;
  wire [7:0] _cpu_datai;
  wire [7:0] _cpu_datao;
  wire [15:0] _cpu_adrs;
  wire _cpu_memory_read;
  wire _cpu_memory_write;
  wire [7:0] _cpu_joypad1;
  wire [7:0] _cpu_joypad2;
  wire _cpu_p_reset;
  wire _cpu_m_clock;
  wire _vga10m_r;
  wire _vga10m_g;
  wire _vga10m_b;
  wire _vga10m_h;
  wire _vga10m_v;
  wire _vga10m_mr;
  wire _vga10m_mbusy;
  wire [7:0] _vga10m_data;
  wire [12:0] _vga10m_adr;
  wire _vga10m_p_reset;
  wire _vga10m_m_clock;
  wire [7:0] _vram_datai;
  wire [7:0] _vram_datao;
  wire [12:0] _vram_adr;
  wire _vram_m_clock;
  wire _vram_p_reset;
  wire _vram_rd;
  wire _vram_wt;
  wire [7:0] _rom_datai;
  wire [7:0] _rom_datao;
  wire [12:0] _rom_adr;
  wire _rom_m_clock;
  wire _rom_p_reset;
  wire _rom_rd;
  wire _rom_wt;
  wire _net_0;
  wire _net_1;
  wire _net_2;
  wire _net_3;
  wire _net_4;
  wire _net_5;
  wire _net_6;
  wire _net_7;
  wire _net_8;
  wire _net_9;
  wire _net_10;
  wire _net_11;
  wire _net_12;
ram8k vram (.wt(_vram_wt), .rd(_vram_rd), .m_clock(_vram_m_clock), .p_reset(_vram_p_reset), .adr(_vram_adr), .datao(_vram_datao), .datai(_vram_datai));
ram8k rom (.wt(_rom_wt), .rd(_rom_rd), .m_clock(_rom_m_clock), .p_reset(_rom_p_reset), .adr(_rom_adr), .datao(_rom_datao), .datai(_rom_datai));
vga vga10m (.m_clock(m_clock), .p_reset(p_reset), .adr(_vga10m_adr), .data(_vga10m_data), .mbusy(_vga10m_mbusy), .mr(_vga10m_mr), .h(_vga10m_h), .v(_vga10m_v), .b(_vga10m_b), .g(_vga10m_g), .r(_vga10m_r));
my80x cpu (.m_clock(m_clock), .p_reset(p_reset), .joypad2(_cpu_joypad2), .joypad1(_cpu_joypad1), .memory_write(_cpu_memory_write), .memory_read(_cpu_memory_read), .adrs(_cpu_adrs), .datao(_cpu_datao), .datai(_cpu_datai));

   assign  _cpu_datai = ((_net_4)?_rom_datao:8'b0)|
    ((_net_2)?_vram_datao:8'b0);
   assign  _cpu_joypad1 = ({1'b1,(btn[0]),(btn[2]),(btn[1]),1'b0,(sw[1]),(sw[2]),(~(sw[0]))});
   assign  _cpu_joypad2 = 8'b10000001;
   assign  _cpu_p_reset = p_reset;
   assign  _cpu_m_clock = m_clock;
   assign  _vga10m_mbusy = _net_0;
   assign  _vga10m_data = _vram_datao;
   assign  _vga10m_p_reset = p_reset;
   assign  _vga10m_m_clock = m_clock;
   assign  _vram_datai = _cpu_datao;
   assign  _vram_adr = ((_vga10m_mr)?(~_vga10m_adr):13'b0)|
    (((_net_8|_net_2))?(_cpu_adrs[12:0]):13'b0);
   assign  _vram_m_clock = (~m_clock);
   assign  _vram_p_reset = p_reset;
   assign  _vram_rd = (_vga10m_mr|_net_2);
   assign  _vram_wt = _net_6;
   assign  _rom_datai = _cpu_datao;
   assign  _rom_adr = (_cpu_adrs[12:0]);
   assign  _rom_m_clock = (~m_clock);
   assign  _rom_p_reset = p_reset;
   assign  _rom_rd = _net_4;
   assign  _rom_wt = _net_10;
   assign  _net_0 = ((_cpu_memory_read|_cpu_memory_write)&((_cpu_adrs[15:13])==3'b001));
   assign  _net_1 = ((_cpu_adrs[15:13])==3'b001);
   assign  _net_2 = (_cpu_memory_read&_net_1);
   assign  _net_3 = ((_cpu_adrs[15:13])==3'b000);
   assign  _net_4 = (_cpu_memory_read&_net_3);
   assign  _net_5 = ((_cpu_adrs[15:13])==3'b001);
   assign  _net_6 = (_cpu_memory_write&_net_5);
   assign  _net_7 = (_cpu_memory_write&_net_5);
   assign  _net_8 = (_cpu_memory_write&_net_5);
   assign  _net_9 = ((_cpu_adrs[15:13])==3'b000);
   assign  _net_10 = (_cpu_memory_write&_net_9);
   assign  _net_11 = (_cpu_memory_write&_net_9);
   assign  _net_12 = (_cpu_memory_write&_net_9);
   assign  TXD = 1'b0;
   assign  VGA_R = _vga10m_r;
   assign  VGA_G = _vga10m_g;
   assign  VGA_B = _vga10m_b;
   assign  VGA_H = (~_vga10m_h);
   assign  VGA_V = (~_vga10m_v);
   assign  led = (_cpu_adrs[7:0]);
   assign  sseg = 8'b11111111;
   assign  an = 4'b1111;
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:01 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:01 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module ram8k ( datai , datao , adr , m_clock , p_reset , rd , wt );
  input [7:0] datai;
  wire [7:0] datai;
  output [7:0] datao;
  wire [7:0] datao;
  input [12:0] adr;
  wire [12:0] adr;
  input m_clock;
  wire m_clock;
  input p_reset;
  wire p_reset;
  input rd;
  wire rd;
  input wt;
  wire wt;
  reg [7:0] dout;
  reg [7:0] ram [0:8191];

   assign  datao = dout;
always @(posedge m_clock)
  begin
  dout <= (ram[adr]);
end
always @(posedge m_clock)
  begin
   if (wt )
     ram[adr] <= datai;
end
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:01 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:02 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module sftl ( p_reset , m_clock , a , b , out , exe );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [15:0] a;
  wire [15:0] a;
  input [7:0] b;
  wire [7:0] b;
  output [7:0] out;
  wire [7:0] out;
  input exe;
  wire exe;
  wire [15:0] tmp;
  wire [15:0] tmp0;
  wire [15:0] tmp1;
  wire [15:0] tmp2;
  wire [15:0] tmp3;
  wire _net_13;
  wire _net_14;
  wire _net_15;
  wire _net_16;
  wire _net_17;
  wire _net_18;
  wire _net_19;
  wire _net_20;
  wire _net_21;
  wire _net_22;
  wire _net_23;
  wire _net_24;
  wire _net_25;
  wire _net_26;
  wire _net_27;
  wire _net_28;
  wire _net_29;
  wire _net_30;
  wire _net_31;
  wire _net_32;

   assign  tmp = ((_net_16)?({({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),1'b0}):16'b0)|
    ((_net_14)?tmp3:16'b0);
   assign  tmp0 = ((_net_32)?(a[15:0]):16'b0)|
    ((_net_30)?({(a[14:0]),1'b0}):16'b0);
   assign  tmp1 = ((_net_28)?(tmp0[15:0]):16'b0)|
    ((_net_26)?({(tmp0[13:0]),({({1'b0}),1'b0})}):16'b0);
   assign  tmp2 = ((_net_24)?(tmp1[15:0]):16'b0)|
    ((_net_22)?({(tmp1[11:0]),({({1'b0,1'b0,1'b0}),1'b0})}):16'b0);
   assign  tmp3 = ((_net_20)?(tmp2[15:0]):16'b0)|
    ((_net_18)?({(tmp2[7:0]),({({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),1'b0})}):16'b0);
   assign  _net_13 = (~(|(b[7:4])));
   assign  _net_14 = (exe&_net_13);
   assign  _net_15 = (|(b[7:4]));
   assign  _net_16 = (exe&_net_15);
   assign  _net_17 = (b[3]);
   assign  _net_18 = (exe&_net_17);
   assign  _net_19 = (~(b[3]));
   assign  _net_20 = (exe&_net_19);
   assign  _net_21 = (b[2]);
   assign  _net_22 = (exe&_net_21);
   assign  _net_23 = (~(b[2]));
   assign  _net_24 = (exe&_net_23);
   assign  _net_25 = (b[1]);
   assign  _net_26 = (exe&_net_25);
   assign  _net_27 = (~(b[1]));
   assign  _net_28 = (exe&_net_27);
   assign  _net_29 = (b[0]);
   assign  _net_30 = (exe&_net_29);
   assign  _net_31 = (~(b[0]));
   assign  _net_32 = (exe&_net_31);
   assign  out = (tmp[15:8]);
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:02 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:02 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module io_sft ( p_reset , m_clock , adrs , datai , datao , read , write );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [7:0] adrs;
  wire [7:0] adrs;
  input [7:0] datai;
  wire [7:0] datai;
  output [7:0] datao;
  wire [7:0] datao;
  input read;
  wire read;
  input write;
  wire write;
  reg [7:0] port2_reg;
  reg [7:0] port4_reg;
  reg [7:0] oldport4;
  wire [15:0] tmp;
  wire [15:0] _sft_a;
  wire [7:0] _sft_b;
  wire [7:0] _sft_out;
  wire _sft_exe;
  wire _sft_p_reset;
  wire _sft_m_clock;
  wire _net_33;
  wire _net_34;
  wire _net_35;
  wire _net_36;
  wire _net_37;
sftl sft (.m_clock(m_clock), .p_reset(p_reset), .exe(_sft_exe), .out(_sft_out), .a(_sft_a), .b(_sft_b));

   assign  tmp = ({port4_reg,oldport4});
   assign  _sft_a = tmp;
   assign  _sft_b = port2_reg;
   assign  _sft_exe = read;
   assign  _sft_p_reset = p_reset;
   assign  _sft_m_clock = m_clock;
   assign  _net_33 = (adrs==8'b00000100);
   assign  _net_34 = (write&_net_33);
   assign  _net_35 = (write&_net_33);
   assign  _net_36 = (adrs==8'b00000010);
   assign  _net_37 = (write&_net_36);
   assign  datao = _sft_out;
always @(posedge m_clock)
  begin
if (p_reset)
     port2_reg <= 8'b00000000;
else if ((_net_37)) 
      port2_reg <= datai;
end
always @(posedge m_clock)
  begin
if (p_reset)
     port4_reg <= 8'b00000000;
else if ((_net_34)) 
      port4_reg <= datai;
end
always @(posedge m_clock)
  begin
if (p_reset)
     oldport4 <= 8'b00000000;
else if ((_net_35)) 
      oldport4 <= port4_reg;
end
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:02 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:02 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module timer ( p_reset , m_clock , ack , irq );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input ack;
  wire ack;
  output irq;
  wire irq;
  reg [19:0] count_reg;
  reg int_req;
  wire _net_38;
  wire _net_39;
  wire _net_40;
  wire _net_41;

   assign  _net_38 = (int_req&ack);
   assign  _net_39 = ((~int_req)&(count_reg==20'b00011000011010100000));
   assign  _net_40 = (count_reg==20'b00011000011010100000);
   assign  _net_41 = (~(count_reg==20'b00011000011010100000));
   assign  irq = int_req;
always @(posedge m_clock)
  begin
if (p_reset)
     count_reg <= 20'b00000000000000000000;
else if ((_net_41)|(_net_40)) 
      count_reg <= ((_net_41) ?(count_reg+20'b00000000000000000001):20'b0)|
    ((_net_40) ?({({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),1'b0}):20'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     int_req <= 1'b0;
else if ((_net_39)|(_net_38)) 
      int_req <= ((_net_39) ?1'b1:1'b0)|
    ((_net_38) ?1'b0:1'b0);

end
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:02 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:02 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module cpa ( p_reset , m_clock , in1 , in2 , ci , out , co , exe );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input in1;
  wire in1;
  input in2;
  wire in2;
  input ci;
  wire ci;
  output out;
  wire out;
  output co;
  wire co;
  input exe;
  wire exe;

   assign  out = ((in1^in2)^ci);
   assign  co = (((in1&in2)|(in1&ci))|(in2&ci));
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:02 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:02 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module cpa4 ( p_reset , m_clock , in1 , in2 , ci , out , co , exe );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [3:0] in1;
  wire [3:0] in1;
  input [3:0] in2;
  wire [3:0] in2;
  input ci;
  wire ci;
  output [3:0] out;
  wire [3:0] out;
  output co;
  wire co;
  input exe;
  wire exe;
  wire _a4_in1;
  wire _a4_in2;
  wire _a4_ci;
  wire _a4_out;
  wire _a4_co;
  wire _a4_exe;
  wire _a4_p_reset;
  wire _a4_m_clock;
  wire _a3_in1;
  wire _a3_in2;
  wire _a3_ci;
  wire _a3_out;
  wire _a3_co;
  wire _a3_exe;
  wire _a3_p_reset;
  wire _a3_m_clock;
  wire _a2_in1;
  wire _a2_in2;
  wire _a2_ci;
  wire _a2_out;
  wire _a2_co;
  wire _a2_exe;
  wire _a2_p_reset;
  wire _a2_m_clock;
  wire _a1_in1;
  wire _a1_in2;
  wire _a1_ci;
  wire _a1_out;
  wire _a1_co;
  wire _a1_exe;
  wire _a1_p_reset;
  wire _a1_m_clock;
cpa a4 (.m_clock(m_clock), .p_reset(p_reset), .exe(_a4_exe), .out(_a4_out), .co(_a4_co), .in1(_a4_in1), .in2(_a4_in2), .ci(_a4_ci));
cpa a3 (.m_clock(m_clock), .p_reset(p_reset), .exe(_a3_exe), .out(_a3_out), .co(_a3_co), .in1(_a3_in1), .in2(_a3_in2), .ci(_a3_ci));
cpa a2 (.m_clock(m_clock), .p_reset(p_reset), .exe(_a2_exe), .out(_a2_out), .co(_a2_co), .in1(_a2_in1), .in2(_a2_in2), .ci(_a2_ci));
cpa a1 (.m_clock(m_clock), .p_reset(p_reset), .exe(_a1_exe), .out(_a1_out), .co(_a1_co), .in1(_a1_in1), .in2(_a1_in2), .ci(_a1_ci));

   assign  _a4_in1 = (in1[3]);
   assign  _a4_in2 = (in2[3]);
   assign  _a4_ci = _a3_co;
   assign  _a4_exe = exe;
   assign  _a4_p_reset = p_reset;
   assign  _a4_m_clock = m_clock;
   assign  _a3_in1 = (in1[2]);
   assign  _a3_in2 = (in2[2]);
   assign  _a3_ci = _a2_co;
   assign  _a3_exe = exe;
   assign  _a3_p_reset = p_reset;
   assign  _a3_m_clock = m_clock;
   assign  _a2_in1 = (in1[1]);
   assign  _a2_in2 = (in2[1]);
   assign  _a2_ci = _a1_co;
   assign  _a2_exe = exe;
   assign  _a2_p_reset = p_reset;
   assign  _a2_m_clock = m_clock;
   assign  _a1_in1 = (in1[0]);
   assign  _a1_in2 = (in2[0]);
   assign  _a1_ci = ci;
   assign  _a1_exe = exe;
   assign  _a1_p_reset = p_reset;
   assign  _a1_m_clock = m_clock;
   assign  out = ({_a4_out,_a3_out,_a2_out,_a1_out});
   assign  co = _a4_co;
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:02 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:02 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module cpa8 ( p_reset , m_clock , in1 , in2 , ci , out , co , ca , exe );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [7:0] in1;
  wire [7:0] in1;
  input [7:0] in2;
  wire [7:0] in2;
  input ci;
  wire ci;
  output [7:0] out;
  wire [7:0] out;
  output co;
  wire co;
  output ca;
  wire ca;
  input exe;
  wire exe;
  wire [3:0] _a2_in1;
  wire [3:0] _a2_in2;
  wire _a2_ci;
  wire [3:0] _a2_out;
  wire _a2_co;
  wire _a2_exe;
  wire _a2_p_reset;
  wire _a2_m_clock;
  wire [3:0] _a1_in1;
  wire [3:0] _a1_in2;
  wire _a1_ci;
  wire [3:0] _a1_out;
  wire _a1_co;
  wire _a1_exe;
  wire _a1_p_reset;
  wire _a1_m_clock;
cpa4 a2 (.m_clock(m_clock), .p_reset(p_reset), .exe(_a2_exe), .out(_a2_out), .co(_a2_co), .in1(_a2_in1), .in2(_a2_in2), .ci(_a2_ci));
cpa4 a1 (.m_clock(m_clock), .p_reset(p_reset), .exe(_a1_exe), .out(_a1_out), .co(_a1_co), .in1(_a1_in1), .in2(_a1_in2), .ci(_a1_ci));

   assign  _a2_in1 = (in1[7:4]);
   assign  _a2_in2 = (in2[7:4]);
   assign  _a2_ci = _a1_co;
   assign  _a2_exe = exe;
   assign  _a2_p_reset = p_reset;
   assign  _a2_m_clock = m_clock;
   assign  _a1_in1 = (in1[3:0]);
   assign  _a1_in2 = (in2[3:0]);
   assign  _a1_ci = ci;
   assign  _a1_exe = exe;
   assign  _a1_p_reset = p_reset;
   assign  _a1_m_clock = m_clock;
   assign  out = ({_a2_out,_a1_out});
   assign  co = _a2_co;
   assign  ca = _a1_co;
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:02 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:02 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module ha ( p_reset , m_clock , in , ci , dec , out , co , exe );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input in;
  wire in;
  input ci;
  wire ci;
  input dec;
  wire dec;
  output out;
  wire out;
  output co;
  wire co;
  input exe;
  wire exe;

   assign  out = (in^ci);
   assign  co = ((in^dec)&ci);
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:02 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:02 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module inc4 ( p_reset , m_clock , in , ci , dec , out , co , exe );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [3:0] in;
  wire [3:0] in;
  input ci;
  wire ci;
  input dec;
  wire dec;
  output [3:0] out;
  wire [3:0] out;
  output co;
  wire co;
  input exe;
  wire exe;
  wire _a4_in;
  wire _a4_ci;
  wire _a4_dec;
  wire _a4_out;
  wire _a4_co;
  wire _a4_exe;
  wire _a4_p_reset;
  wire _a4_m_clock;
  wire _a3_in;
  wire _a3_ci;
  wire _a3_dec;
  wire _a3_out;
  wire _a3_co;
  wire _a3_exe;
  wire _a3_p_reset;
  wire _a3_m_clock;
  wire _a2_in;
  wire _a2_ci;
  wire _a2_dec;
  wire _a2_out;
  wire _a2_co;
  wire _a2_exe;
  wire _a2_p_reset;
  wire _a2_m_clock;
  wire _a1_in;
  wire _a1_ci;
  wire _a1_dec;
  wire _a1_out;
  wire _a1_co;
  wire _a1_exe;
  wire _a1_p_reset;
  wire _a1_m_clock;
ha a4 (.m_clock(m_clock), .p_reset(p_reset), .exe(_a4_exe), .out(_a4_out), .co(_a4_co), .in(_a4_in), .ci(_a4_ci), .dec(_a4_dec));
ha a3 (.m_clock(m_clock), .p_reset(p_reset), .exe(_a3_exe), .out(_a3_out), .co(_a3_co), .in(_a3_in), .ci(_a3_ci), .dec(_a3_dec));
ha a2 (.m_clock(m_clock), .p_reset(p_reset), .exe(_a2_exe), .out(_a2_out), .co(_a2_co), .in(_a2_in), .ci(_a2_ci), .dec(_a2_dec));
ha a1 (.m_clock(m_clock), .p_reset(p_reset), .exe(_a1_exe), .out(_a1_out), .co(_a1_co), .in(_a1_in), .ci(_a1_ci), .dec(_a1_dec));

   assign  _a4_in = (in[3]);
   assign  _a4_ci = _a3_co;
   assign  _a4_dec = dec;
   assign  _a4_exe = exe;
   assign  _a4_p_reset = p_reset;
   assign  _a4_m_clock = m_clock;
   assign  _a3_in = (in[2]);
   assign  _a3_ci = _a2_co;
   assign  _a3_dec = dec;
   assign  _a3_exe = exe;
   assign  _a3_p_reset = p_reset;
   assign  _a3_m_clock = m_clock;
   assign  _a2_in = (in[1]);
   assign  _a2_ci = _a1_co;
   assign  _a2_dec = dec;
   assign  _a2_exe = exe;
   assign  _a2_p_reset = p_reset;
   assign  _a2_m_clock = m_clock;
   assign  _a1_in = (in[0]);
   assign  _a1_ci = ci;
   assign  _a1_dec = dec;
   assign  _a1_exe = exe;
   assign  _a1_p_reset = p_reset;
   assign  _a1_m_clock = m_clock;
   assign  out = ({_a4_out,_a3_out,_a2_out,_a1_out});
   assign  co = _a4_co;
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:02 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:02 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module inc8 ( p_reset , m_clock , in , ci , out , co , up , down );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [7:0] in;
  wire [7:0] in;
  input ci;
  wire ci;
  output [7:0] out;
  wire [7:0] out;
  output co;
  wire co;
  input up;
  wire up;
  input down;
  wire down;
  wire [3:0] _a2_in;
  wire _a2_ci;
  wire _a2_dec;
  wire [3:0] _a2_out;
  wire _a2_co;
  wire _a2_exe;
  wire _a2_p_reset;
  wire _a2_m_clock;
  wire [3:0] _a1_in;
  wire _a1_ci;
  wire _a1_dec;
  wire [3:0] _a1_out;
  wire _a1_co;
  wire _a1_exe;
  wire _a1_p_reset;
  wire _a1_m_clock;
inc4 a2 (.m_clock(m_clock), .p_reset(p_reset), .exe(_a2_exe), .out(_a2_out), .co(_a2_co), .in(_a2_in), .ci(_a2_ci), .dec(_a2_dec));
inc4 a1 (.m_clock(m_clock), .p_reset(p_reset), .exe(_a1_exe), .out(_a1_out), .co(_a1_co), .in(_a1_in), .ci(_a1_ci), .dec(_a1_dec));

   assign  _a2_in = (in[7:4]);
   assign  _a2_ci = _a1_co;
   assign  _a2_dec = down|
    ((up)?1'b0:1'b0);
   assign  _a2_exe = (down|up);
   assign  _a2_p_reset = p_reset;
   assign  _a2_m_clock = m_clock;
   assign  _a1_in = (in[3:0]);
   assign  _a1_ci = ci;
   assign  _a1_dec = down|
    ((up)?1'b0:1'b0);
   assign  _a1_exe = (down|up);
   assign  _a1_p_reset = p_reset;
   assign  _a1_m_clock = m_clock;
   assign  out = ({_a2_out,_a1_out});
   assign  co = _a2_co;
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:02 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:03 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module alu80 ( p_reset , m_clock , in1 , in2 , ci , out , s , z , a , p , c , do_adc , do_sbc , do_add , do_sub , do_and , do_or , do_xor , do_cmp );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [7:0] in1;
  wire [7:0] in1;
  input [7:0] in2;
  wire [7:0] in2;
  input ci;
  wire ci;
  output [7:0] out;
  wire [7:0] out;
  output s;
  wire s;
  output z;
  wire z;
  output a;
  wire a;
  output p;
  wire p;
  output c;
  wire c;
  input do_adc;
  wire do_adc;
  input do_sbc;
  wire do_sbc;
  input do_add;
  wire do_add;
  input do_sub;
  wire do_sub;
  input do_and;
  wire do_and;
  input do_or;
  wire do_or;
  input do_xor;
  wire do_xor;
  input do_cmp;
  wire do_cmp;
  wire [7:0] _cp8_in1;
  wire [7:0] _cp8_in2;
  wire _cp8_ci;
  wire [7:0] _cp8_out;
  wire _cp8_co;
  wire _cp8_ca;
  wire _cp8_exe;
  wire _cp8_p_reset;
  wire _cp8_m_clock;
cpa8 cp8 (.m_clock(m_clock), .p_reset(p_reset), .exe(_cp8_exe), .out(_cp8_out), .co(_cp8_co), .ca(_cp8_ca), .in1(_cp8_in1), .in2(_cp8_in2), .ci(_cp8_ci));

   assign  _cp8_in1 = in1;
   assign  _cp8_in2 = (((do_cmp|(do_sbc|do_sub)))?(~in2):8'b0)|
    (((do_adc|do_add))?in2:8'b0);
   assign  _cp8_ci = ((do_sbc)?(~ci):1'b0)|
    (((do_cmp|do_sub))?1'b1:1'b0)|
    ((do_adc)?ci:1'b0)|
    ((do_add)?1'b0:1'b0);
   assign  _cp8_exe = (do_cmp|(do_sbc|(do_sub|(do_adc|do_add))));
   assign  _cp8_p_reset = p_reset;
   assign  _cp8_m_clock = m_clock;
   assign  out = ((do_cmp)?in1:8'b0)|
    ((do_or)?(in1|in2):8'b0)|
    ((do_xor)?(in1^in2):8'b0)|
    ((do_and)?(in1&in2):8'b0)|
    (((do_sbc|(do_sub|(do_adc|do_add))))?_cp8_out:8'b0);
   assign  s = ((do_cmp)?(_cp8_out[7]):1'b0)|
    (((do_or|(do_xor|(do_and|(do_sbc|(do_sub|(do_adc|do_add)))))))?(out[7]):1'b0);
   assign  z = ((do_cmp)?(~(|_cp8_out)):1'b0)|
    (((do_or|(do_xor|(do_and|(do_sbc|(do_sub|(do_adc|do_add)))))))?(~(|out)):1'b0);
   assign  a = (((do_or|(do_xor|do_and)))?1'b0:1'b0)|
    (((do_cmp|(do_sbc|do_sub)))?(~_cp8_ca):1'b0)|
    (((do_adc|do_add))?_cp8_ca:1'b0);
   assign  p = ((do_cmp)?(~(^_cp8_out)):1'b0)|
    (((do_or|(do_xor|(do_and|(do_sbc|(do_sub|(do_adc|do_add)))))))?(~(^out)):1'b0);
   assign  c = (((do_or|(do_xor|do_and)))?1'b0:1'b0)|
    (((do_cmp|(do_sbc|do_sub)))?(~_cp8_co):1'b0)|
    (((do_adc|do_add))?_cp8_co:1'b0);
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:03 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:03 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module my80x ( p_reset , m_clock , datai , datao , adrs , memory_read , memory_write , joypad1 , joypad2 );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [7:0] datai;
  wire [7:0] datai;
  output [7:0] datao;
  wire [7:0] datao;
  output [15:0] adrs;
  wire [15:0] adrs;
  output memory_read;
  wire memory_read;
  output memory_write;
  wire memory_write;
  input [7:0] joypad1;
  wire [7:0] joypad1;
  input [7:0] joypad2;
  wire [7:0] joypad2;
  wire _tmr_ack;
  wire _tmr_irq;
  wire _tmr_p_reset;
  wire _tmr_m_clock;
  wire [7:0] _iosft_adrs;
  wire [7:0] _iosft_datai;
  wire [7:0] _iosft_datao;
  wire _iosft_read;
  wire _iosft_write;
  wire _iosft_p_reset;
  wire _iosft_m_clock;
  wire [7:0] _cpu_data;
  wire [7:0] _cpu_datao;
  wire [15:0] _cpu_adrs;
  wire _cpu_extint;
  wire _cpu_ack;
  wire _cpu_memory_read;
  wire _cpu_memory_write;
  wire _cpu_io_read;
  wire _cpu_io_write;
  wire _cpu_p_reset;
  wire _cpu_m_clock;
  wire _net_42;
  wire _net_43;
  wire _net_44;
  wire _net_45;
  wire _net_46;
  wire _net_47;
my80core cpu (.m_clock(m_clock), .p_reset(p_reset), .io_write(_cpu_io_write), .io_read(_cpu_io_read), .memory_write(_cpu_memory_write), .memory_read(_cpu_memory_read), .ack(_cpu_ack), .extint(_cpu_extint), .adrs(_cpu_adrs), .datao(_cpu_datao), .data(_cpu_data));
io_sft iosft (.m_clock(m_clock), .p_reset(p_reset), .write(_iosft_write), .read(_iosft_read), .datao(_iosft_datao), .datai(_iosft_datai), .adrs(_iosft_adrs));
timer tmr (.m_clock(m_clock), .p_reset(p_reset), .irq(_tmr_irq), .ack(_tmr_ack));

   assign  _tmr_ack = _cpu_ack;
   assign  _tmr_p_reset = p_reset;
   assign  _tmr_m_clock = m_clock;
   assign  _iosft_adrs = (adrs[7:0]);
   assign  _iosft_datai = _cpu_datao;
   assign  _iosft_read = _net_43;
   assign  _iosft_write = _cpu_io_write;
   assign  _iosft_p_reset = p_reset;
   assign  _iosft_m_clock = m_clock;
   assign  _cpu_data = ((_net_47)?joypad1:8'b0)|
    ((_net_45)?joypad2:8'b0)|
    ((_net_43)?_iosft_datao:8'b0)|
    ((_cpu_memory_read)?datai:8'b0);
   assign  _cpu_extint = _tmr_irq;
   assign  _cpu_p_reset = p_reset;
   assign  _cpu_m_clock = m_clock;
   assign  _net_42 = ((adrs[7:0])==8'b00000011);
   assign  _net_43 = (_cpu_io_read&_net_42);
   assign  _net_44 = ((adrs[7:0])==8'b00000010);
   assign  _net_45 = (_cpu_io_read&_net_44);
   assign  _net_46 = ((adrs[7:0])==8'b00000001);
   assign  _net_47 = (_cpu_io_read&_net_46);
   assign  datao = _cpu_datao;
   assign  adrs = _cpu_adrs;
   assign  memory_read = _cpu_memory_read;
   assign  memory_write = _cpu_memory_write;
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:03 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:06 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module my80core ( p_reset , m_clock , data , datao , adrs , extint , ack , memory_read , memory_write , io_read , io_write );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [7:0] data;
  wire [7:0] data;
  output [7:0] datao;
  wire [7:0] datao;
  output [15:0] adrs;
  wire [15:0] adrs;
  input extint;
  wire extint;
  output ack;
  wire ack;
  output memory_read;
  wire memory_read;
  output memory_write;
  wire memory_write;
  output io_read;
  wire io_read;
  output io_write;
  wire io_write;
  wire start;
  wire flagchk;
  wire dec1op;
  wire incop;
  wire incsp;
  wire incpc;
  wire loop1;
  wire lospl;
  wire lopcl;
  wire decsp;
  wire decpc;
  wire dmov;
  wire dalu;
  wire dinr;
  wire ddad;
  wire dinx;
  wire dpop;
  wire dpush;
  wire dldax;
  wire dstax;
  wire dretc;
  wire drst;
  wire dalum;
  wire dret;
  wire dxthl;
  wire dpchl;
  wire dsphl;
  wire dxchg;
  wire ddi;
  wire dei;
  wire dnop;
  wire dmvi;
  wire dalui;
  wire din;
  wire dout;
  wire dcc;
  wire dcall;
  wire djmp;
  wire djc;
  wire dlxi;
  wire dlda;
  wire dlhld;
  wire dshld;
  wire dsta;
  wire fetch2;
  wire fetch3;
  wire ifetch;
  wire S1;
  wire S2;
  wire S3;
  wire S4;
  reg [7:0] pch;
  reg [7:0] pcl;
  reg [7:0] sph;
  reg [7:0] spl;
  reg [7:0] a;
  reg [7:0] f;
  reg [7:0] b;
  reg [7:0] c;
  reg [7:0] d;
  reg [7:0] e;
  reg [7:0] h;
  reg [7:0] l;
  reg tc;
  reg imask;
  reg [7:0] op0;
  reg [7:0] op1;
  reg [7:0] op2;
  reg st0;
  reg st1;
  reg st2;
  reg int_state;
  wire [7:0] lo;
  wire flg;
  wire [2:0] rs;
  wire [2:0] rg;
  wire [7:0] v;
  wire setreg;
  wire getreg;
  wire setrx;
  wire getrx;
  reg intt;
  reg ift;
  reg [2:0] run;
  reg ex;
  wire [7:0] _inc_in;
  wire _inc_ci;
  wire [7:0] _inc_out;
  wire _inc_co;
  wire _inc_up;
  wire _inc_down;
  wire _inc_p_reset;
  wire _inc_m_clock;
  wire [7:0] _alu_in1;
  wire [7:0] _alu_in2;
  wire _alu_ci;
  wire [7:0] _alu_out;
  wire _alu_s;
  wire _alu_z;
  wire _alu_a;
  wire _alu_p;
  wire _alu_c;
  wire _alu_do_adc;
  wire _alu_do_sbc;
  wire _alu_do_add;
  wire _alu_do_sub;
  wire _alu_do_and;
  wire _alu_do_or;
  wire _alu_do_xor;
  wire _alu_do_cmp;
  wire _alu_p_reset;
  wire _alu_m_clock;
  wire _proc_intt_set;
  wire _proc_intt_reset;
  wire _net_48;
  wire _proc_ift_set;
  wire _proc_ift_reset;
  wire _net_49;
  wire _proc_ex_set;
  wire _proc_ex_reset;
  wire _net_50;
  wire _net_51;
  wire _net_52;
  wire _net_53;
  wire _net_54;
  wire _net_55;
  wire _net_56;
  wire _net_57;
  wire _net_58;
  wire _net_59;
  wire _net_60;
  wire _net_61;
  wire _net_62;
  wire _net_63;
  wire _net_64;
  wire _net_65;
  wire _net_66;
  wire _net_67;
  wire _net_68;
  wire _net_69;
  wire _net_70;
  wire _net_71;
  wire _net_72;
  wire _net_73;
  wire _net_74;
  wire _net_75;
  wire _net_76;
  wire _net_77;
  wire _net_78;
  wire _net_79;
  wire _net_80;
  wire _net_81;
  wire _net_82;
  wire _net_83;
  wire _net_84;
  wire _net_85;
  wire _net_86;
  wire _net_87;
  wire _net_88;
  wire _net_89;
  wire _net_90;
  wire _net_91;
  wire _net_92;
  wire _net_93;
  wire _net_94;
  wire _net_95;
  wire _net_96;
  wire _net_97;
  wire _net_98;
  wire _net_99;
  wire _net_100;
  wire _net_101;
  wire _net_102;
  wire _net_103;
  wire _net_104;
  wire _net_105;
  wire _net_106;
  wire _net_107;
  wire _net_108;
  wire _net_109;
  wire _net_110;
  wire _net_111;
  wire _net_112;
  wire _net_113;
  wire _net_114;
  wire _net_115;
  wire _net_116;
  wire _net_117;
  wire _net_118;
  wire _net_119;
  wire _net_120;
  wire _net_121;
  wire _net_122;
  wire _net_123;
  wire _net_124;
  wire _net_125;
  wire _net_126;
  wire _net_127;
  wire _net_128;
  wire _net_129;
  wire _net_130;
  wire _net_131;
  wire _net_132;
  wire _net_133;
  wire _net_134;
  wire _net_135;
  wire _net_136;
  wire _net_137;
  wire _net_138;
  wire _net_139;
  wire _net_140;
  wire _net_141;
  wire _net_142;
  wire _net_143;
  wire _net_144;
  wire _net_145;
  wire _net_146;
  wire _net_147;
  wire _net_148;
  wire _net_149;
  wire _net_150;
  wire _net_151;
  wire _net_152;
  wire _net_153;
  wire _net_154;
  wire _net_155;
  wire _net_156;
  wire _net_157;
  wire _net_158;
  wire _net_159;
  wire _net_160;
  wire _net_161;
  wire _net_162;
  wire _net_163;
  wire _net_164;
  wire _net_165;
  wire _net_166;
  wire _net_167;
  wire _net_168;
  wire _net_169;
  wire _net_170;
  wire _net_171;
  wire _net_172;
  wire _net_173;
  wire _net_174;
  wire _net_175;
  wire _net_176;
  wire _net_177;
  wire _net_178;
  wire _net_179;
  wire _net_180;
  wire _net_181;
  wire _net_182;
  wire _net_183;
  wire _net_184;
  wire _net_185;
  wire _net_186;
  wire _net_187;
  wire _net_188;
  wire _net_189;
  wire _net_190;
  wire _net_191;
  wire _net_192;
  wire _net_193;
  wire _net_194;
  wire _net_195;
  wire _net_196;
  wire _net_197;
  wire _net_198;
  wire _net_199;
  wire _net_200;
  wire _net_201;
  wire _net_202;
  wire _net_203;
  wire _net_204;
  wire _net_205;
  wire _net_206;
  wire _net_207;
  wire _net_208;
  wire _net_209;
  wire _net_210;
  wire _net_211;
  wire _net_212;
  wire _net_213;
  wire _net_214;
  wire _net_215;
  wire _net_216;
  wire _net_217;
  wire _net_218;
  wire _net_219;
  wire _net_220;
  wire _net_221;
  wire _net_222;
  wire _net_223;
  wire _net_224;
  wire _net_225;
  wire _net_226;
  wire _net_227;
  wire _net_228;
  wire _net_229;
  wire _net_230;
  wire _net_231;
  wire _net_232;
  wire _net_233;
  wire _net_234;
  wire _net_235;
  wire _net_236;
  wire _net_237;
  wire _net_238;
  wire _net_239;
  wire _net_240;
  wire _net_241;
  wire _net_242;
  wire _net_243;
  wire _net_244;
  wire _net_245;
  wire _net_246;
  wire _net_247;
  wire _net_248;
  wire _net_249;
  wire _net_250;
  wire _net_251;
  wire _net_252;
  wire _net_253;
  wire _net_254;
  wire _net_255;
  wire _net_256;
  wire _net_257;
  wire _net_258;
  wire _net_259;
  wire _net_260;
  wire _net_261;
  wire _net_262;
  wire _net_263;
  wire _net_264;
  wire _net_265;
  wire _net_266;
  wire _net_267;
  wire _net_268;
  wire _net_269;
  wire _net_270;
  wire _net_271;
  wire _net_272;
  wire _net_273;
  wire _net_274;
  wire _net_275;
  wire _net_276;
  wire _net_277;
  wire _net_278;
  wire _net_279;
  wire _net_280;
  wire _net_281;
  wire _net_282;
  wire _net_283;
  wire _net_284;
  wire _net_285;
  wire _net_286;
  wire _net_287;
  wire _net_288;
  wire _net_289;
  wire _net_290;
  wire _net_291;
  wire _net_292;
  wire _net_293;
  wire _net_294;
  wire _net_295;
  wire _net_296;
  wire _net_297;
  wire _net_298;
  wire _net_299;
  wire _net_300;
  wire _net_301;
  wire _net_302;
  wire _net_303;
  wire _net_304;
  wire _net_305;
  wire _net_306;
  wire _net_307;
  wire _net_308;
  wire _net_309;
  wire _net_310;
  wire _net_311;
  wire _net_312;
  wire _net_313;
  wire _net_314;
  wire _net_315;
  wire _net_316;
  wire _net_317;
  wire _net_318;
  wire _net_319;
  wire _net_320;
  wire _net_321;
  wire _net_322;
  wire _net_323;
  wire _net_324;
  wire _net_325;
  wire _net_326;
  wire _net_327;
  wire _net_328;
  wire _net_329;
  wire _net_330;
  wire _net_331;
  wire _net_332;
  wire _net_333;
  wire _net_334;
  wire _net_335;
  wire _net_336;
  wire _net_337;
  wire _net_338;
  wire _net_339;
  wire _net_340;
  wire _net_341;
  wire _net_342;
  wire _net_343;
  wire _net_344;
  wire _net_345;
  wire _net_346;
  wire _net_347;
  wire _net_348;
  wire _net_349;
  wire _net_350;
  wire _net_351;
  wire _net_352;
  wire _net_353;
  wire _net_354;
  wire _net_355;
  wire _net_356;
  wire _net_357;
  wire _net_358;
  wire _net_359;
  wire _net_360;
  wire _net_361;
  wire _net_362;
  wire _net_363;
  wire _net_364;
  wire _net_365;
  wire _net_366;
  wire _net_367;
  wire _net_368;
  wire _net_369;
  wire _net_370;
  wire _net_371;
  wire _net_372;
  wire _net_373;
  wire _net_374;
  wire _net_375;
  wire _net_376;
  wire _net_377;
  wire _net_378;
  wire _net_379;
  wire _net_380;
  wire _net_381;
  wire _net_382;
  wire _net_383;
  wire _net_384;
  wire _net_385;
  wire _net_386;
  wire _net_387;
  wire _net_388;
  wire _net_389;
  wire _net_390;
  wire _net_391;
  wire _net_392;
  wire _net_393;
  wire _net_394;
  wire _net_395;
  wire _net_396;
  wire _net_397;
  wire _net_398;
  wire _net_399;
  wire _net_400;
  wire _net_401;
  wire _net_402;
  wire _net_403;
  wire _net_404;
  wire _net_405;
  wire _net_406;
  wire _net_407;
  wire _net_408;
  wire _net_409;
  wire _net_410;
  wire _net_411;
  wire _net_412;
  wire _net_413;
  wire _net_414;
  wire _net_415;
  wire _net_416;
  wire _net_417;
  wire _net_418;
  wire _net_419;
  wire _net_420;
  wire _net_421;
  wire _net_422;
  wire _net_423;
  wire _net_424;
  wire _net_425;
  wire _net_426;
  wire _net_427;
  wire _net_428;
  wire _net_429;
  wire _net_430;
  wire _net_431;
  wire _net_432;
  wire _net_433;
  wire _net_434;
  wire _net_435;
  wire _net_436;
  wire _net_437;
  wire _net_438;
  wire _net_439;
  wire _net_440;
  wire _net_441;
  wire _net_442;
  wire _net_443;
  wire _net_444;
  wire _net_445;
  wire _net_446;
  wire _net_447;
  wire _net_448;
  wire _net_449;
  wire _net_450;
  wire _net_451;
  wire _net_452;
  wire _net_453;
  wire _net_454;
  wire _net_455;
  wire _net_456;
  wire _net_457;
  wire _net_458;
  wire _net_459;
  wire _net_460;
  wire _net_461;
  wire _net_462;
  wire _net_463;
  wire _net_464;
  wire _net_465;
  wire _net_466;
  wire _net_467;
  wire _net_468;
  wire _net_469;
  wire _net_470;
  wire _net_471;
  wire _net_472;
  wire _net_473;
  wire _net_474;
  wire _net_475;
  wire _net_476;
  wire _net_477;
  wire _net_478;
  wire _net_479;
  wire _net_480;
  wire _net_481;
  wire _net_482;
  wire _net_483;
  wire _net_484;
  wire _net_485;
  wire _net_486;
  wire _net_487;
  wire _net_488;
  wire _net_489;
  wire _net_490;
  wire _net_491;
  wire _net_492;
  wire _net_493;
  wire _net_494;
  wire _net_495;
  wire _net_496;
  wire _net_497;
  wire _net_498;
  wire _net_499;
  wire _net_500;
  wire _net_501;
  wire _net_502;
  wire _net_503;
  wire _net_504;
  wire _net_505;
  wire _net_506;
  wire _net_507;
  wire _net_508;
  wire _net_509;
  wire _net_510;
  wire _net_511;
  wire _net_512;
  wire _net_513;
  wire _net_514;
  wire _net_515;
  wire _net_516;
  wire _net_517;
  wire _net_518;
  wire _net_519;
  wire _net_520;
  wire _net_521;
  wire _net_522;
  wire _net_523;
  wire _net_524;
  wire _net_525;
  wire _net_526;
  wire _net_527;
  wire _net_528;
  wire _net_529;
  wire _net_530;
  wire _net_531;
  wire _net_532;
  wire _net_533;
  wire _net_534;
  wire _net_535;
  wire _net_536;
  wire _net_537;
  wire _net_538;
  wire _net_539;
  wire _net_540;
  wire _net_541;
  wire _net_542;
  wire _net_543;
  wire _net_544;
  wire _net_545;
  wire _net_546;
  wire _net_547;
  wire _net_548;
  wire _net_549;
  wire _net_550;
  wire _net_551;
  wire _net_552;
  wire _net_553;
  wire _net_554;
  wire _net_555;
  wire _net_556;
  wire _net_557;
  wire _net_558;
  wire _net_559;
  wire _net_560;
  wire _net_561;
  wire _net_562;
  wire _net_563;
  wire _net_564;
  wire _net_565;
  wire _net_566;
  wire _net_567;
  wire _net_568;
  wire _net_569;
  wire _net_570;
  wire _net_571;
  wire _net_572;
  wire _net_573;
  wire _net_574;
  wire _net_575;
  wire _net_576;
  wire _net_577;
  wire _net_578;
  wire _net_579;
  wire _net_580;
  wire _net_581;
  wire _net_582;
  wire _net_583;
  wire _net_584;
  wire _net_585;
  wire _net_586;
  wire _net_587;
  wire _net_588;
  wire _net_589;
  wire _net_590;
  wire _net_591;
  wire _net_592;
  wire _net_593;
  wire _net_594;
  wire _net_595;
  wire _net_596;
  wire _net_597;
  wire _net_598;
  wire _net_599;
  wire _net_600;
  wire _net_601;
  wire _net_602;
  wire _net_603;
  wire _net_604;
  wire _net_605;
  wire _net_606;
  wire _net_607;
  wire _net_608;
  wire _net_609;
  wire _net_610;
  wire _net_611;
  wire _net_612;
  wire _net_613;
  wire _net_614;
  wire _net_615;
  wire _net_616;
  wire _net_617;
  wire _net_618;
  wire _net_619;
  wire _net_620;
  wire _net_621;
  wire _net_622;
  wire _net_623;
  wire _net_624;
  wire _net_625;
  wire _net_626;
  wire _net_627;
  wire _net_628;
  wire _net_629;
  wire _net_630;
  wire _net_631;
  wire _net_632;
  wire _net_633;
  wire _net_634;
  wire _net_635;
  wire _net_636;
  wire _net_637;
  wire _net_638;
  wire _net_639;
  wire _net_640;
  wire _net_641;
  wire _net_642;
  wire _net_643;
  wire _net_644;
  wire _net_645;
  wire _net_646;
  wire _net_647;
  wire _net_648;
  wire _net_649;
  wire _net_650;
  wire _net_651;
  wire _net_652;
  wire _net_653;
  wire _net_654;
  wire _net_655;
  wire _net_656;
  wire _net_657;
  wire _net_658;
  wire _net_659;
  wire _net_660;
  wire _net_661;
  wire _net_662;
  wire _net_663;
  wire _net_664;
  wire _net_665;
  wire _net_666;
  wire _net_667;
  wire _net_668;
  wire _net_669;
  wire _net_670;
  wire _net_671;
  wire _net_672;
  wire _net_673;
  wire _net_674;
  wire _net_675;
  wire _net_676;
  wire _net_677;
  wire _net_678;
  wire _net_679;
  wire _net_680;
  wire _net_681;
  wire _net_682;
  wire _net_683;
  wire _net_684;
  wire _net_685;
  wire _net_686;
  wire _net_687;
  wire _net_688;
  wire _net_689;
  wire _net_690;
  wire _net_691;
  wire _net_692;
  wire _net_693;
  wire _net_694;
  wire _net_695;
  wire _net_696;
  wire _net_697;
  wire _net_698;
  wire _net_699;
  wire _net_700;
  wire _net_701;
  wire _net_702;
  wire _net_703;
  wire _net_704;
  wire _net_705;
  wire _net_706;
  wire _net_707;
  wire _net_708;
  wire _net_709;
  wire _net_710;
  wire _net_711;
  wire _net_712;
  wire _net_713;
  wire _net_714;
  wire _net_715;
  wire _net_716;
  wire _net_717;
  wire _net_718;
  wire _net_719;
  wire _net_720;
  wire _net_721;
  wire _net_722;
  wire _net_723;
  wire _net_724;
  wire _net_725;
  wire _net_726;
  wire _net_727;
  wire _net_728;
  wire _net_729;
  wire _net_730;
  wire _net_731;
  wire _net_732;
  wire _net_733;
  wire _net_734;
  wire _net_735;
  wire _net_736;
  wire _net_737;
  wire _net_738;
  wire _net_739;
  wire _net_740;
  wire _net_741;
  wire _net_742;
  wire _net_743;
  wire _net_744;
  wire _net_745;
  wire _net_746;
  wire _net_747;
  wire _net_748;
  wire _net_749;
  wire _net_750;
  wire _net_751;
  wire _net_752;
  wire _net_753;
  wire _net_754;
  wire _net_755;
  wire _net_756;
  wire _net_757;
  wire _net_758;
  wire _net_759;
  wire _net_760;
  wire _net_761;
  wire _net_762;
  wire _net_763;
  wire _net_764;
  wire _net_765;
  wire _net_766;
  wire _net_767;
  wire _net_768;
  wire _net_769;
  wire _net_770;
  wire _net_771;
  wire _net_772;
  wire _net_773;
  wire _net_774;
  wire _net_775;
  wire _net_776;
  wire _net_777;
  wire _net_778;
  wire _net_779;
  wire _net_780;
  wire _net_781;
  wire _net_782;
  wire _net_783;
  wire _net_784;
  wire _net_785;
  wire _net_786;
  wire _net_787;
  wire _net_788;
  wire _net_789;
  wire _net_790;
  wire _net_791;
  wire _net_792;
alu80 alu (.m_clock(m_clock), .p_reset(p_reset), .do_cmp(_alu_do_cmp), .do_xor(_alu_do_xor), .do_or(_alu_do_or), .do_and(_alu_do_and), .do_sub(_alu_do_sub), .do_add(_alu_do_add), .do_sbc(_alu_do_sbc), .do_adc(_alu_do_adc), .s(_alu_s), .z(_alu_z), .a(_alu_a), .p(_alu_p), .c(_alu_c), .out(_alu_out), .ci(_alu_ci), .in2(_alu_in2), .in1(_alu_in1));
inc8 inc (.m_clock(m_clock), .p_reset(p_reset), .down(_inc_down), .up(_inc_up), .out(_inc_out), .co(_inc_co), .in(_inc_in), .ci(_inc_ci));

   assign  start = _net_51;
   assign  flagchk = (_net_669|(_net_629|_net_437));
   assign  dec1op = ex;
   assign  incop = (_net_735|_net_718);
   assign  incsp = (_net_549|(_net_450|(_net_444|(_net_394|_net_386))));
   assign  incpc = (_net_758|(fetch3|fetch2));
   assign  loop1 = (_net_298|(_net_293|incop));
   assign  lospl = (decsp|incsp);
   assign  lopcl = (decpc|incpc);
   assign  decsp = (_net_651|(_net_648|(_net_535|(_net_455|(_net_414|_net_404)))));
   assign  decpc = _net_212;
   assign  dmov = (_net_605|_net_197);
   assign  dalu = (_net_609|_net_195);
   assign  dinr = _net_193;
   assign  ddad = _net_191;
   assign  dinx = _net_189;
   assign  dpop = _net_187;
   assign  dpush = _net_185;
   assign  dldax = _net_183;
   assign  dstax = _net_181;
   assign  dretc = _net_179;
   assign  drst = _net_177;
   assign  dalum = _net_175;
   assign  dret = (_net_438|(_net_435|_net_173));
   assign  dxthl = _net_171;
   assign  dpchl = _net_169;
   assign  dsphl = _net_167;
   assign  dxchg = _net_165;
   assign  ddi = _net_163;
   assign  dei = _net_161;
   assign  dnop = _net_159;
   assign  dmvi = _net_157;
   assign  dalui = _net_155;
   assign  din = _net_153;
   assign  dout = _net_151;
   assign  dcc = _net_149;
   assign  dcall = (_net_638|(_net_630|(_net_457|_net_143)));
   assign  djmp = (_net_670|(_net_643|_net_141));
   assign  djc = _net_147;
   assign  dlxi = _net_145;
   assign  dlda = _net_139;
   assign  dlhld = _net_137;
   assign  dshld = _net_135;
   assign  dsta = _net_133;
   assign  fetch2 = (_net_752|(_net_741|(_net_724|(_net_703|(_net_690|(_net_676|(_net_663|(_net_657|(_net_636|(_net_626|(_net_618|(_net_607|_net_603))))))))))));
   assign  fetch3 = (_net_749|(_net_738|(_net_721|(_net_700|(_net_684|(_net_673|(_net_660|(_net_654|_net_633))))))));
   assign  ifetch = (_net_747|(_net_730|(_net_711|(_net_698|(_net_682|(_net_671|(_net_667|(_net_631|(_net_624|(_net_616|(dnop|(dei|(ddi|(_net_574|(_net_562|(dpchl|(_net_536|(_net_527|(_net_520|(_net_513|(_net_506|(_net_485|(_net_479|(_net_475|(_net_470|(_net_445|(_net_439|(dstax|(dldax|(_net_402|(_net_387|(_net_363|(_net_335|(_net_323|(_net_287|(_net_271|(_net_213|(_net_208|_net_204))))))))))))))))))))))))))))))))))))));
   assign  S1 = (_net_753|(_net_742|(_net_725|(_net_704|(_net_691|(_net_677|(_net_664|(_net_658|(_net_637|(_net_627|(_net_619|(_net_601|(_net_569|(_net_555|(_net_499|(_net_451|(_net_415|(_net_395|(_net_379|(_net_346|_net_308))))))))))))))))))));
   assign  S2 = (_net_750|(_net_739|(_net_722|(_net_701|(_net_685|(_net_674|(_net_661|(_net_655|(_net_634|(_net_596|(_net_550|(_net_412|_net_301))))))))))));
   assign  S3 = (_net_736|(_net_719|(_net_652|(_net_608|(_net_604|(_net_589|(_net_541|(_net_456|(_net_405|(_net_282|(_net_278|(_net_223|_net_219))))))))))));
   assign  S4 = (_net_649|_net_581);
   assign  lo = ((_net_103)?sph:8'b0)|
    (((_net_115|_net_83))?b:8'b0)|
    (((_net_113|_net_81))?c:8'b0)|
    (((_net_111|_net_79))?d:8'b0)|
    (((_net_109|_net_77))?e:8'b0)|
    (((_net_107|_net_75))?h:8'b0)|
    (((_net_105|_net_73))?l:8'b0)|
    ((_net_71)?f:8'b0)|
    ((_net_69)?a:8'b0)|
    ((lopcl)?pcl:8'b0)|
    (((_net_101|lospl))?spl:8'b0)|
    ((loop1)?op1:8'b0);
   assign  flg = ((_net_131)?(~(f[6])):1'b0)|
    ((_net_129)?(f[6]):1'b0)|
    ((_net_127)?(~(f[0])):1'b0)|
    ((_net_125)?(f[0]):1'b0)|
    ((_net_123)?(~(f[2])):1'b0)|
    ((_net_121)?(f[2]):1'b0)|
    ((_net_119)?(~(f[7])):1'b0)|
    ((_net_117)?(f[7]):1'b0);
   assign  rs = ((_net_585)?3'b010:3'b0)|
    ((_net_573)?3'b011:3'b0)|
    ((_net_568)?3'b110:3'b0)|
    ((_net_393)?({(op0[5:4]),(~((op0[5])&(op0[4])))}):3'b0)|
    ((_net_385)?({(op0[5:4]),((op0[5])&(op0[4]))}):3'b0)|
    (((_net_688|_net_377))?({(op0[5:4]),1'b1}):3'b0)|
    (((_net_681|_net_362))?({(op0[5:4]),1'b0}):3'b0)|
    (((_net_717|(_net_580|(_net_548|_net_344))))?3'b101:3'b0)|
    (((_net_710|(_net_595|(_net_531|_net_333))))?3'b100:3'b0)|
    (((_net_697|(_net_615|(_net_561|(_net_525|(_net_518|(_net_511|(_net_504|(_net_497|(_net_484|(_net_468|(_net_426|(_net_421|_net_269)))))))))))))?3'b111:3'b0)|
    (((_net_321|_net_207))?(op0[5:3]):3'b0);
   assign  rg = ((_net_593)?3'b010:3'b0)|
    ((_net_578)?3'b011:3'b0)|
    (((_net_599|_net_566))?3'b100:3'b0)|
    (((_net_587|_net_559))?3'b101:3'b0)|
    ((_net_409)?({(op0[5:4]),((op0[5])&(op0[4]))}):3'b0)|
    ((_net_399)?({(op0[5:4]),(~((op0[5])&(op0[4])))}):3'b0)|
    (((_net_374|(_net_369|_net_339)))?({(op0[5:4]),1'b1}):3'b0)|
    (((_net_359|(_net_353|_net_327)))?({(op0[5:4]),1'b0}):3'b0)|
    (((_net_318|_net_313))?(op0[5:3]):3'b0)|
    (((_net_492|(_net_463|(_net_266|(_net_261|(_net_255|(_net_250|(_net_244|(_net_239|(_net_234|_net_229))))))))))?3'b111:3'b0)|
    (((_net_280|_net_221))?(op0[2:0]):3'b0);
   assign  v = ((_net_680)?op2:8'b0)|
    (((_net_594|(_net_579|(_net_567|_net_560))))?lo:8'b0)|
    ((_net_524)?({(a[6:0]),(a[7])}):8'b0)|
    ((_net_517)?({(a[0]),(a[7:1])}):8'b0)|
    ((_net_510)?({(a[6:0]),(f[0])}):8'b0)|
    ((_net_503)?({(f[0]),(a[7:1])}):8'b0)|
    ((_net_483)?(~a):8'b0)|
    (((_net_716|(_net_709|(_net_696|(_net_614|(_net_425|(_net_420|(_net_392|_net_384))))))))?data:8'b0)|
    (((_net_496|(_net_467|(_net_376|(_net_361|(_net_343|(_net_332|(_net_320|_net_268))))))))?_alu_out:8'b0)|
    (((_net_687|(_net_584|(_net_572|(_net_547|(_net_530|_net_206))))))?op1:8'b0);
   assign  setreg = (_net_713|(_net_706|(_net_693|(_net_611|(_net_591|(_net_583|(_net_576|(_net_571|(_net_546|(_net_529|(_net_523|(_net_516|(_net_509|(_net_502|(_net_490|(_net_482|(_net_461|(_net_422|(_net_417|(_net_389|(_net_381|(_net_319|(_net_267|_net_205)))))))))))))))))))))));
   assign  getreg = (_net_598|(_net_592|(_net_586|(_net_577|(_net_565|(_net_558|(_net_491|(_net_462|(_net_408|(_net_398|(_net_318|(_net_313|(_net_279|(_net_266|(_net_261|(_net_255|(_net_250|(_net_244|(_net_239|(_net_234|(_net_229|_net_220)))))))))))))))))))));
   assign  setrx = (_net_686|(_net_679|(_net_564|(_net_557|(_net_375|(_net_360|(_net_337|_net_325)))))));
   assign  getrx = (_net_374|(_net_369|(_net_359|(_net_353|(_net_338|_net_326)))));
   assign  _inc_in = (((decpc|incpc))?pch:8'b0)|
    (((decsp|incsp))?sph:8'b0)|
    ((incop)?op2:8'b0);
   assign  _inc_ci = _alu_c;
   assign  _inc_up = (incpc|(incsp|incop));
   assign  _inc_down = (decpc|decsp);
   assign  _inc_p_reset = p_reset;
   assign  _inc_m_clock = m_clock;
   assign  _alu_in1 = lo;
   assign  _alu_in2 = ((_net_494)?8'b00000110:8'b0)|
    ((_net_465)?8'b01100000:8'b0)|
    (((_net_358|_net_352))?8'b00000000:8'b0)|
    ((_net_341)?l:8'b0)|
    ((_net_330)?h:8'b0)|
    (((_net_265|(_net_260|(_net_254|(_net_249|(_net_243|(_net_238|(_net_233|_net_228))))))))?op1:8'b0)|
    (((_net_373|(_net_368|(_net_317|(_net_312|(_net_297|(_net_292|(decpc|(decsp|(incpc|(incsp|incop)))))))))))?8'b00000001:8'b0);
   assign  _alu_ci = (((_net_357|(_net_351|_net_329)))?tc:1'b0)|
    (((_net_259|_net_248))?(f[0]):1'b0);
   assign  _alu_do_adc = (_net_356|(_net_328|_net_258));
   assign  _alu_do_sbc = (_net_350|_net_247);
   assign  _alu_do_add = (_net_493|(_net_464|(_net_372|(_net_340|(_net_316|(_net_296|(_net_264|(incpc|(incsp|incop)))))))));
   assign  _alu_do_sub = (_net_367|(_net_311|(_net_291|(_net_253|(decpc|decsp)))));
   assign  _alu_do_and = _net_242;
   assign  _alu_do_or = _net_232;
   assign  _alu_do_xor = _net_237;
   assign  _alu_do_cmp = _net_227;
   assign  _alu_p_reset = p_reset;
   assign  _alu_m_clock = m_clock;
   assign  _proc_intt_set = extint;
   assign  _proc_intt_reset = intt;
   assign  _net_48 = (_proc_intt_set|_proc_intt_reset);
   assign  _proc_ift_set = (_net_779|start);
   assign  _proc_ift_reset = (_net_775|(_net_767|_net_759));
   assign  _net_49 = (_proc_ift_set|_proc_ift_reset);
   assign  _proc_ex_set = (_net_790|(_net_787|(_net_784|(_net_781|(_net_776|(_net_768|_net_760))))));
   assign  _proc_ex_reset = (_net_792|(_net_789|(_net_786|(_net_783|(_net_780|_net_778)))));
   assign  _net_50 = (_proc_ex_set|_proc_ex_reset);
   assign  _net_51 = ((st2==1'b0)&(st1==1'b1));
   assign  _net_52 = (rs==3'b111);
   assign  _net_53 = (setreg&_net_52);
   assign  _net_54 = (rs==3'b110);
   assign  _net_55 = (setreg&_net_54);
   assign  _net_56 = (rs==3'b101);
   assign  _net_57 = (setreg&_net_56);
   assign  _net_58 = (rs==3'b100);
   assign  _net_59 = (setreg&_net_58);
   assign  _net_60 = (rs==3'b011);
   assign  _net_61 = (setreg&_net_60);
   assign  _net_62 = (rs==3'b010);
   assign  _net_63 = (setreg&_net_62);
   assign  _net_64 = (rs==3'b001);
   assign  _net_65 = (setreg&_net_64);
   assign  _net_66 = (rs==3'b000);
   assign  _net_67 = (setreg&_net_66);
   assign  _net_68 = (rg==3'b111);
   assign  _net_69 = (getreg&_net_68);
   assign  _net_70 = (rg==3'b110);
   assign  _net_71 = (getreg&_net_70);
   assign  _net_72 = (rg==3'b101);
   assign  _net_73 = (getreg&_net_72);
   assign  _net_74 = (rg==3'b100);
   assign  _net_75 = (getreg&_net_74);
   assign  _net_76 = (rg==3'b011);
   assign  _net_77 = (getreg&_net_76);
   assign  _net_78 = (rg==3'b010);
   assign  _net_79 = (getreg&_net_78);
   assign  _net_80 = (rg==3'b001);
   assign  _net_81 = (getreg&_net_80);
   assign  _net_82 = (rg==3'b000);
   assign  _net_83 = (getreg&_net_82);
   assign  _net_84 = (rs==3'b111);
   assign  _net_85 = (setrx&_net_84);
   assign  _net_86 = (rs==3'b110);
   assign  _net_87 = (setrx&_net_86);
   assign  _net_88 = (rs==3'b101);
   assign  _net_89 = (setrx&_net_88);
   assign  _net_90 = (rs==3'b100);
   assign  _net_91 = (setrx&_net_90);
   assign  _net_92 = (rs==3'b011);
   assign  _net_93 = (setrx&_net_92);
   assign  _net_94 = (rs==3'b010);
   assign  _net_95 = (setrx&_net_94);
   assign  _net_96 = (rs==3'b001);
   assign  _net_97 = (setrx&_net_96);
   assign  _net_98 = (rs==3'b000);
   assign  _net_99 = (setrx&_net_98);
   assign  _net_100 = (rg==3'b111);
   assign  _net_101 = (getrx&_net_100);
   assign  _net_102 = (rg==3'b110);
   assign  _net_103 = (getrx&_net_102);
   assign  _net_104 = (rg==3'b101);
   assign  _net_105 = (getrx&_net_104);
   assign  _net_106 = (rg==3'b100);
   assign  _net_107 = (getrx&_net_106);
   assign  _net_108 = (rg==3'b011);
   assign  _net_109 = (getrx&_net_108);
   assign  _net_110 = (rg==3'b010);
   assign  _net_111 = (getrx&_net_110);
   assign  _net_112 = (rg==3'b001);
   assign  _net_113 = (getrx&_net_112);
   assign  _net_114 = (rg==3'b000);
   assign  _net_115 = (getrx&_net_114);
   assign  _net_116 = ((op0[5:3])==3'b111);
   assign  _net_117 = (flagchk&_net_116);
   assign  _net_118 = ((op0[5:3])==3'b110);
   assign  _net_119 = (flagchk&_net_118);
   assign  _net_120 = ((op0[5:3])==3'b101);
   assign  _net_121 = (flagchk&_net_120);
   assign  _net_122 = ((op0[5:3])==3'b100);
   assign  _net_123 = (flagchk&_net_122);
   assign  _net_124 = ((op0[5:3])==3'b011);
   assign  _net_125 = (flagchk&_net_124);
   assign  _net_126 = ((op0[5:3])==3'b010);
   assign  _net_127 = (flagchk&_net_126);
   assign  _net_128 = ((op0[5:3])==3'b001);
   assign  _net_129 = (flagchk&_net_128);
   assign  _net_130 = ((op0[5:3])==3'b000);
   assign  _net_131 = (flagchk&_net_130);
   assign  _net_132 = (op0==8'b00110010);
   assign  _net_133 = (dec1op&_net_132);
   assign  _net_134 = (op0==8'b00100010);
   assign  _net_135 = (dec1op&_net_134);
   assign  _net_136 = (op0==8'b00101010);
   assign  _net_137 = (dec1op&_net_136);
   assign  _net_138 = (op0==8'b00111010);
   assign  _net_139 = (dec1op&_net_138);
   assign  _net_140 = (op0==8'b11000011);
   assign  _net_141 = (dec1op&_net_140);
   assign  _net_142 = (op0==8'b11001101);
   assign  _net_143 = (dec1op&_net_142);
   assign  _net_144 = (({(op0[7:6]),(op0[3:0])})==6'b000001);
   assign  _net_145 = (dec1op&_net_144);
   assign  _net_146 = (({(op0[7:6]),(op0[2:0])})==5'b11010);
   assign  _net_147 = (dec1op&_net_146);
   assign  _net_148 = (({(op0[7:6]),(op0[2:0])})==5'b11100);
   assign  _net_149 = (dec1op&_net_148);
   assign  _net_150 = (op0==8'b11010011);
   assign  _net_151 = (dec1op&_net_150);
   assign  _net_152 = (op0==8'b11011011);
   assign  _net_153 = (dec1op&_net_152);
   assign  _net_154 = (({(op0[7:6]),(op0[2:0])})==5'b11110);
   assign  _net_155 = (dec1op&_net_154);
   assign  _net_156 = (({(op0[7:6]),(op0[2:0])})==5'b00110);
   assign  _net_157 = (dec1op&_net_156);
   assign  _net_158 = (op0==8'b00000000);
   assign  _net_159 = (dec1op&_net_158);
   assign  _net_160 = (op0==8'b11111011);
   assign  _net_161 = (dec1op&_net_160);
   assign  _net_162 = (op0==8'b11110011);
   assign  _net_163 = (dec1op&_net_162);
   assign  _net_164 = (op0==8'b11101011);
   assign  _net_165 = (dec1op&_net_164);
   assign  _net_166 = (op0==8'b11111001);
   assign  _net_167 = (dec1op&_net_166);
   assign  _net_168 = (op0==8'b11101001);
   assign  _net_169 = (dec1op&_net_168);
   assign  _net_170 = (op0==8'b11100011);
   assign  _net_171 = (dec1op&_net_170);
   assign  _net_172 = (op0==8'b11001001);
   assign  _net_173 = (dec1op&_net_172);
   assign  _net_174 = (({(op0[7:6]),(op0[2:0])})==5'b00111);
   assign  _net_175 = (dec1op&_net_174);
   assign  _net_176 = (({(op0[7:6]),(op0[2:0])})==5'b11111);
   assign  _net_177 = (dec1op&_net_176);
   assign  _net_178 = (({(op0[7:6]),(op0[2:0])})==5'b11000);
   assign  _net_179 = (dec1op&_net_178);
   assign  _net_180 = (({(op0[7:5]),(op0[3:0])})==7'b0000010);
   assign  _net_181 = (dec1op&_net_180);
   assign  _net_182 = (({(op0[7:5]),(op0[3:0])})==7'b0001010);
   assign  _net_183 = (dec1op&_net_182);
   assign  _net_184 = (({(op0[7:6]),(op0[3:0])})==6'b110101);
   assign  _net_185 = (dec1op&_net_184);
   assign  _net_186 = (({(op0[7:6]),(op0[3:0])})==6'b110001);
   assign  _net_187 = (dec1op&_net_186);
   assign  _net_188 = (({(op0[7:6]),(op0[2:0])})==5'b00011);
   assign  _net_189 = (dec1op&_net_188);
   assign  _net_190 = (({(op0[7:6]),(op0[3:0])})==6'b001001);
   assign  _net_191 = (dec1op&_net_190);
   assign  _net_192 = (({(op0[7:6]),(op0[2:1])})==4'b0010);
   assign  _net_193 = (dec1op&_net_192);
   assign  _net_194 = ((op0[7:6])==2'b10);
   assign  _net_195 = (dec1op&_net_194);
   assign  _net_196 = ((op0[7:6])==2'b01);
   assign  _net_197 = (dec1op&_net_196);
   assign  _net_198 = (ex&(run==3'b011));
   assign  _net_199 = ((op0[5:3])==3'b110);
   assign  _net_200 = (dmov&_net_198);
   assign  _net_201 = ((dmov&_net_198)&_net_199);
   assign  _net_202 = ((dmov&_net_198)&_net_199);
   assign  _net_203 = ((dmov&_net_198)&_net_199);
   assign  _net_204 = ((dmov&_net_198)&_net_199);
   assign  _net_205 = ((dmov&_net_198)&(~_net_199));
   assign  _net_206 = ((dmov&_net_198)&(~_net_199));
   assign  _net_207 = ((dmov&_net_198)&(~_net_199));
   assign  _net_208 = ((dmov&_net_198)&(~_net_199));
   assign  _net_209 = (ex&(run==3'b000));
   assign  _net_210 = ((op0[5:0])==6'b110110);
   assign  _net_211 = (dmov&_net_209);
   assign  _net_212 = ((dmov&_net_209)&_net_210);
   assign  _net_213 = ((dmov&_net_209)&_net_210);
   assign  _net_214 = ((op0[2:0])==3'b110);
   assign  _net_215 = ((dmov&_net_209)&(~_net_210));
   assign  _net_216 = (((dmov&_net_209)&(~_net_210))&_net_214);
   assign  _net_217 = (((dmov&_net_209)&(~_net_210))&_net_214);
   assign  _net_218 = (((dmov&_net_209)&(~_net_210))&_net_214);
   assign  _net_219 = (((dmov&_net_209)&(~_net_210))&_net_214);
   assign  _net_220 = (((dmov&_net_209)&(~_net_210))&(~_net_214));
   assign  _net_221 = (((dmov&_net_209)&(~_net_210))&(~_net_214));
   assign  _net_222 = (((dmov&_net_209)&(~_net_210))&(~_net_214));
   assign  _net_223 = (((dmov&_net_209)&(~_net_210))&(~_net_214));
   assign  _net_224 = (ex&(run==3'b011));
   assign  _net_225 = ((op0[5:3])==3'b111);
   assign  _net_226 = (dalu&_net_224);
   assign  _net_227 = ((dalu&_net_224)&_net_225);
   assign  _net_228 = ((dalu&_net_224)&_net_225);
   assign  _net_229 = ((dalu&_net_224)&_net_225);
   assign  _net_230 = ((op0[5:3])==3'b110);
   assign  _net_231 = (dalu&_net_224);
   assign  _net_232 = ((dalu&_net_224)&_net_230);
   assign  _net_233 = ((dalu&_net_224)&_net_230);
   assign  _net_234 = ((dalu&_net_224)&_net_230);
   assign  _net_235 = ((op0[5:3])==3'b101);
   assign  _net_236 = (dalu&_net_224);
   assign  _net_237 = ((dalu&_net_224)&_net_235);
   assign  _net_238 = ((dalu&_net_224)&_net_235);
   assign  _net_239 = ((dalu&_net_224)&_net_235);
   assign  _net_240 = ((op0[5:3])==3'b100);
   assign  _net_241 = (dalu&_net_224);
   assign  _net_242 = ((dalu&_net_224)&_net_240);
   assign  _net_243 = ((dalu&_net_224)&_net_240);
   assign  _net_244 = ((dalu&_net_224)&_net_240);
   assign  _net_245 = ((op0[5:3])==3'b011);
   assign  _net_246 = (dalu&_net_224);
   assign  _net_247 = ((dalu&_net_224)&_net_245);
   assign  _net_248 = ((dalu&_net_224)&_net_245);
   assign  _net_249 = ((dalu&_net_224)&_net_245);
   assign  _net_250 = ((dalu&_net_224)&_net_245);
   assign  _net_251 = ((op0[5:3])==3'b010);
   assign  _net_252 = (dalu&_net_224);
   assign  _net_253 = ((dalu&_net_224)&_net_251);
   assign  _net_254 = ((dalu&_net_224)&_net_251);
   assign  _net_255 = ((dalu&_net_224)&_net_251);
   assign  _net_256 = ((op0[5:3])==3'b001);
   assign  _net_257 = (dalu&_net_224);
   assign  _net_258 = ((dalu&_net_224)&_net_256);
   assign  _net_259 = ((dalu&_net_224)&_net_256);
   assign  _net_260 = ((dalu&_net_224)&_net_256);
   assign  _net_261 = ((dalu&_net_224)&_net_256);
   assign  _net_262 = ((op0[5:3])==3'b000);
   assign  _net_263 = (dalu&_net_224);
   assign  _net_264 = ((dalu&_net_224)&_net_262);
   assign  _net_265 = ((dalu&_net_224)&_net_262);
   assign  _net_266 = ((dalu&_net_224)&_net_262);
   assign  _net_267 = (dalu&_net_224);
   assign  _net_268 = (dalu&_net_224);
   assign  _net_269 = (dalu&_net_224);
   assign  _net_270 = (dalu&_net_224);
   assign  _net_271 = (dalu&_net_224);
   assign  _net_272 = (ex&(run==3'b000));
   assign  _net_273 = ((op0[2:0])==3'b110);
   assign  _net_274 = (dalu&_net_272);
   assign  _net_275 = ((dalu&_net_272)&_net_273);
   assign  _net_276 = ((dalu&_net_272)&_net_273);
   assign  _net_277 = ((dalu&_net_272)&_net_273);
   assign  _net_278 = ((dalu&_net_272)&_net_273);
   assign  _net_279 = ((dalu&_net_272)&(~_net_273));
   assign  _net_280 = ((dalu&_net_272)&(~_net_273));
   assign  _net_281 = ((dalu&_net_272)&(~_net_273));
   assign  _net_282 = ((dalu&_net_272)&(~_net_273));
   assign  _net_283 = (ex&(run==3'b010));
   assign  _net_284 = (dinr&_net_283);
   assign  _net_285 = (dinr&_net_283);
   assign  _net_286 = (dinr&_net_283);
   assign  _net_287 = (dinr&_net_283);
   assign  _net_288 = (ex&(run==3'b001));
   assign  _net_289 = (op0[0]);
   assign  _net_290 = (dinr&_net_288);
   assign  _net_291 = ((dinr&_net_288)&_net_289);
   assign  _net_292 = ((dinr&_net_288)&_net_289);
   assign  _net_293 = ((dinr&_net_288)&_net_289);
   assign  _net_294 = (~(op0[0]));
   assign  _net_295 = (dinr&_net_288);
   assign  _net_296 = ((dinr&_net_288)&_net_294);
   assign  _net_297 = ((dinr&_net_288)&_net_294);
   assign  _net_298 = ((dinr&_net_288)&_net_294);
   assign  _net_299 = (dinr&_net_288);
   assign  _net_300 = (dinr&_net_288);
   assign  _net_301 = (dinr&_net_288);
   assign  _net_302 = (ex&(run==3'b000));
   assign  _net_303 = ((op0[5:3])==3'b110);
   assign  _net_304 = (dinr&_net_302);
   assign  _net_305 = ((dinr&_net_302)&_net_303);
   assign  _net_306 = ((dinr&_net_302)&_net_303);
   assign  _net_307 = ((dinr&_net_302)&_net_303);
   assign  _net_308 = ((dinr&_net_302)&_net_303);
   assign  _net_309 = (op0[0]);
   assign  _net_310 = ((dinr&_net_302)&(~_net_303));
   assign  _net_311 = (((dinr&_net_302)&(~_net_303))&_net_309);
   assign  _net_312 = (((dinr&_net_302)&(~_net_303))&_net_309);
   assign  _net_313 = (((dinr&_net_302)&(~_net_303))&_net_309);
   assign  _net_314 = (~(op0[0]));
   assign  _net_315 = ((dinr&_net_302)&(~_net_303));
   assign  _net_316 = (((dinr&_net_302)&(~_net_303))&_net_314);
   assign  _net_317 = (((dinr&_net_302)&(~_net_303))&_net_314);
   assign  _net_318 = (((dinr&_net_302)&(~_net_303))&_net_314);
   assign  _net_319 = ((dinr&_net_302)&(~_net_303));
   assign  _net_320 = ((dinr&_net_302)&(~_net_303));
   assign  _net_321 = ((dinr&_net_302)&(~_net_303));
   assign  _net_322 = ((dinr&_net_302)&(~_net_303));
   assign  _net_323 = ((dinr&_net_302)&(~_net_303));
   assign  _net_324 = (ex&(run==3'b001));
   assign  _net_325 = (ddad&_net_324);
   assign  _net_326 = (ddad&_net_324);
   assign  _net_327 = (ddad&_net_324);
   assign  _net_328 = (ddad&_net_324);
   assign  _net_329 = (ddad&_net_324);
   assign  _net_330 = (ddad&_net_324);
   assign  _net_331 = (ddad&_net_324);
   assign  _net_332 = (ddad&_net_324);
   assign  _net_333 = (ddad&_net_324);
   assign  _net_334 = (ddad&_net_324);
   assign  _net_335 = (ddad&_net_324);
   assign  _net_336 = (ex&(run==3'b000));
   assign  _net_337 = (ddad&_net_336);
   assign  _net_338 = (ddad&_net_336);
   assign  _net_339 = (ddad&_net_336);
   assign  _net_340 = (ddad&_net_336);
   assign  _net_341 = (ddad&_net_336);
   assign  _net_342 = (ddad&_net_336);
   assign  _net_343 = (ddad&_net_336);
   assign  _net_344 = (ddad&_net_336);
   assign  _net_345 = (ddad&_net_336);
   assign  _net_346 = (ddad&_net_336);
   assign  _net_347 = (ex&(run==3'b001));
   assign  _net_348 = (op0[3]);
   assign  _net_349 = (dinx&_net_347);
   assign  _net_350 = ((dinx&_net_347)&_net_348);
   assign  _net_351 = ((dinx&_net_347)&_net_348);
   assign  _net_352 = ((dinx&_net_347)&_net_348);
   assign  _net_353 = ((dinx&_net_347)&_net_348);
   assign  _net_354 = (~(op0[3]));
   assign  _net_355 = (dinx&_net_347);
   assign  _net_356 = ((dinx&_net_347)&_net_354);
   assign  _net_357 = ((dinx&_net_347)&_net_354);
   assign  _net_358 = ((dinx&_net_347)&_net_354);
   assign  _net_359 = ((dinx&_net_347)&_net_354);
   assign  _net_360 = (dinx&_net_347);
   assign  _net_361 = (dinx&_net_347);
   assign  _net_362 = (dinx&_net_347);
   assign  _net_363 = (dinx&_net_347);
   assign  _net_364 = (ex&(run==3'b000));
   assign  _net_365 = (op0[3]);
   assign  _net_366 = (dinx&_net_364);
   assign  _net_367 = ((dinx&_net_364)&_net_365);
   assign  _net_368 = ((dinx&_net_364)&_net_365);
   assign  _net_369 = ((dinx&_net_364)&_net_365);
   assign  _net_370 = (~(op0[3]));
   assign  _net_371 = (dinx&_net_364);
   assign  _net_372 = ((dinx&_net_364)&_net_370);
   assign  _net_373 = ((dinx&_net_364)&_net_370);
   assign  _net_374 = ((dinx&_net_364)&_net_370);
   assign  _net_375 = (dinx&_net_364);
   assign  _net_376 = (dinx&_net_364);
   assign  _net_377 = (dinx&_net_364);
   assign  _net_378 = (dinx&_net_364);
   assign  _net_379 = (dinx&_net_364);
   assign  _net_380 = (ex&(run==3'b001));
   assign  _net_381 = (dpop&_net_380);
   assign  _net_382 = (dpop&_net_380);
   assign  _net_383 = (dpop&_net_380);
   assign  _net_384 = (dpop&_net_380);
   assign  _net_385 = (dpop&_net_380);
   assign  _net_386 = (dpop&_net_380);
   assign  _net_387 = (dpop&_net_380);
   assign  _net_388 = (ex&(run==3'b000));
   assign  _net_389 = (dpop&_net_388);
   assign  _net_390 = (dpop&_net_388);
   assign  _net_391 = (dpop&_net_388);
   assign  _net_392 = (dpop&_net_388);
   assign  _net_393 = (dpop&_net_388);
   assign  _net_394 = (dpop&_net_388);
   assign  _net_395 = (dpop&_net_388);
   assign  _net_396 = (ex&(run==3'b011));
   assign  _net_397 = (dpush&_net_396);
   assign  _net_398 = (dpush&_net_396);
   assign  _net_399 = (dpush&_net_396);
   assign  _net_400 = (dpush&_net_396);
   assign  _net_401 = (dpush&_net_396);
   assign  _net_402 = (dpush&_net_396);
   assign  _net_403 = (ex&(run==3'b010));
   assign  _net_404 = (dpush&_net_403);
   assign  _net_405 = (dpush&_net_403);
   assign  _net_406 = (ex&(run==3'b001));
   assign  _net_407 = (dpush&_net_406);
   assign  _net_408 = (dpush&_net_406);
   assign  _net_409 = (dpush&_net_406);
   assign  _net_410 = (dpush&_net_406);
   assign  _net_411 = (dpush&_net_406);
   assign  _net_412 = (dpush&_net_406);
   assign  _net_413 = (ex&(run==3'b000));
   assign  _net_414 = (dpush&_net_413);
   assign  _net_415 = (dpush&_net_413);
   assign  _net_416 = (~(op0[4]));
   assign  _net_417 = (dldax&_net_416);
   assign  _net_418 = (dldax&_net_416);
   assign  _net_419 = (dldax&_net_416);
   assign  _net_420 = (dldax&_net_416);
   assign  _net_421 = (dldax&_net_416);
   assign  _net_422 = (dldax&(~_net_416));
   assign  _net_423 = (dldax&(~_net_416));
   assign  _net_424 = (dldax&(~_net_416));
   assign  _net_425 = (dldax&(~_net_416));
   assign  _net_426 = (dldax&(~_net_416));
   assign  _net_427 = (~(op0[4]));
   assign  _net_428 = (dstax&_net_427);
   assign  _net_429 = (dstax&_net_427);
   assign  _net_430 = (dstax&_net_427);
   assign  _net_431 = (dstax&(~_net_427));
   assign  _net_432 = (dstax&(~_net_427));
   assign  _net_433 = (dstax&(~_net_427));
   assign  _net_434 = (ex&(run==3'b001));
   assign  _net_435 = (dretc&_net_434);
   assign  _net_436 = (ex&(run==3'b000));
   assign  _net_437 = (dretc&_net_436);
   assign  _net_438 = ((dretc&_net_436)&flg);
   assign  _net_439 = ((dretc&_net_436)&(~flg));
   assign  _net_440 = (ex&(run==3'b001));
   assign  _net_441 = (dret&_net_440);
   assign  _net_442 = (dret&_net_440);
   assign  _net_443 = (dret&_net_440);
   assign  _net_444 = (dret&_net_440);
   assign  _net_445 = (dret&_net_440);
   assign  _net_446 = (ex&(run==3'b000));
   assign  _net_447 = (dret&_net_446);
   assign  _net_448 = (dret&_net_446);
   assign  _net_449 = (dret&_net_446);
   assign  _net_450 = (dret&_net_446);
   assign  _net_451 = (dret&_net_446);
   assign  _net_452 = (ex&(run==3'b000));
   assign  _net_453 = (drst&_net_452);
   assign  _net_454 = (drst&_net_452);
   assign  _net_455 = (drst&_net_452);
   assign  _net_456 = (drst&_net_452);
   assign  _net_457 = (drst&(~_net_452));
   assign  _net_458 = (ex&(run==3'b001));
   assign  _net_459 = (((a[7])&((a[6])|(a[5])))|(f[0]));
   assign  _net_460 = (dalum&_net_458);
   assign  _net_461 = ((dalum&_net_458)&_net_459);
   assign  _net_462 = ((dalum&_net_458)&_net_459);
   assign  _net_463 = ((dalum&_net_458)&_net_459);
   assign  _net_464 = ((dalum&_net_458)&_net_459);
   assign  _net_465 = ((dalum&_net_458)&_net_459);
   assign  _net_466 = ((dalum&_net_458)&_net_459);
   assign  _net_467 = ((dalum&_net_458)&_net_459);
   assign  _net_468 = ((dalum&_net_458)&_net_459);
   assign  _net_469 = ((dalum&_net_458)&_net_459);
   assign  _net_470 = (dalum&_net_458);
   assign  _net_471 = (ex&(run==3'b000));
   assign  _net_472 = ((op0[5:3])==3'b111);
   assign  _net_473 = (dalum&_net_471);
   assign  _net_474 = ((dalum&_net_471)&_net_472);
   assign  _net_475 = ((dalum&_net_471)&_net_472);
   assign  _net_476 = ((op0[5:3])==3'b110);
   assign  _net_477 = (dalum&_net_471);
   assign  _net_478 = ((dalum&_net_471)&_net_476);
   assign  _net_479 = ((dalum&_net_471)&_net_476);
   assign  _net_480 = ((op0[5:3])==3'b101);
   assign  _net_481 = (dalum&_net_471);
   assign  _net_482 = ((dalum&_net_471)&_net_480);
   assign  _net_483 = ((dalum&_net_471)&_net_480);
   assign  _net_484 = ((dalum&_net_471)&_net_480);
   assign  _net_485 = ((dalum&_net_471)&_net_480);
   assign  _net_486 = ((op0[5:3])==3'b100);
   assign  _net_487 = (dalum&_net_471);
   assign  _net_488 = (((a[3])&((a[2])|(a[1])))|(f[4]));
   assign  _net_489 = ((dalum&_net_471)&_net_486);
   assign  _net_490 = (((dalum&_net_471)&_net_486)&_net_488);
   assign  _net_491 = (((dalum&_net_471)&_net_486)&_net_488);
   assign  _net_492 = (((dalum&_net_471)&_net_486)&_net_488);
   assign  _net_493 = (((dalum&_net_471)&_net_486)&_net_488);
   assign  _net_494 = (((dalum&_net_471)&_net_486)&_net_488);
   assign  _net_495 = (((dalum&_net_471)&_net_486)&_net_488);
   assign  _net_496 = (((dalum&_net_471)&_net_486)&_net_488);
   assign  _net_497 = (((dalum&_net_471)&_net_486)&_net_488);
   assign  _net_498 = (((dalum&_net_471)&_net_486)&_net_488);
   assign  _net_499 = ((dalum&_net_471)&_net_486);
   assign  _net_500 = ((op0[5:3])==3'b011);
   assign  _net_501 = (dalum&_net_471);
   assign  _net_502 = ((dalum&_net_471)&_net_500);
   assign  _net_503 = ((dalum&_net_471)&_net_500);
   assign  _net_504 = ((dalum&_net_471)&_net_500);
   assign  _net_505 = ((dalum&_net_471)&_net_500);
   assign  _net_506 = ((dalum&_net_471)&_net_500);
   assign  _net_507 = ((op0[5:3])==3'b010);
   assign  _net_508 = (dalum&_net_471);
   assign  _net_509 = ((dalum&_net_471)&_net_507);
   assign  _net_510 = ((dalum&_net_471)&_net_507);
   assign  _net_511 = ((dalum&_net_471)&_net_507);
   assign  _net_512 = ((dalum&_net_471)&_net_507);
   assign  _net_513 = ((dalum&_net_471)&_net_507);
   assign  _net_514 = ((op0[5:3])==3'b001);
   assign  _net_515 = (dalum&_net_471);
   assign  _net_516 = ((dalum&_net_471)&_net_514);
   assign  _net_517 = ((dalum&_net_471)&_net_514);
   assign  _net_518 = ((dalum&_net_471)&_net_514);
   assign  _net_519 = ((dalum&_net_471)&_net_514);
   assign  _net_520 = ((dalum&_net_471)&_net_514);
   assign  _net_521 = ((op0[5:3])==3'b000);
   assign  _net_522 = (dalum&_net_471);
   assign  _net_523 = ((dalum&_net_471)&_net_521);
   assign  _net_524 = ((dalum&_net_471)&_net_521);
   assign  _net_525 = ((dalum&_net_471)&_net_521);
   assign  _net_526 = ((dalum&_net_471)&_net_521);
   assign  _net_527 = ((dalum&_net_471)&_net_521);
   assign  _net_528 = (ex&(run==3'b011));
   assign  _net_529 = (dxthl&_net_528);
   assign  _net_530 = (dxthl&_net_528);
   assign  _net_531 = (dxthl&_net_528);
   assign  _net_532 = (dxthl&_net_528);
   assign  _net_533 = (dxthl&_net_528);
   assign  _net_534 = (dxthl&_net_528);
   assign  _net_535 = (dxthl&_net_528);
   assign  _net_536 = (dxthl&_net_528);
   assign  _net_537 = (ex&(run==3'b010));
   assign  _net_538 = (dxthl&_net_537);
   assign  _net_539 = (dxthl&_net_537);
   assign  _net_540 = (dxthl&_net_537);
   assign  _net_541 = (dxthl&_net_537);
   assign  _net_542 = (ex&(run==3'b001));
   assign  _net_543 = (dxthl&_net_542);
   assign  _net_544 = (dxthl&_net_542);
   assign  _net_545 = (dxthl&_net_542);
   assign  _net_546 = (dxthl&_net_542);
   assign  _net_547 = (dxthl&_net_542);
   assign  _net_548 = (dxthl&_net_542);
   assign  _net_549 = (dxthl&_net_542);
   assign  _net_550 = (dxthl&_net_542);
   assign  _net_551 = (ex&(run==3'b000));
   assign  _net_552 = (dxthl&_net_551);
   assign  _net_553 = (dxthl&_net_551);
   assign  _net_554 = (dxthl&_net_551);
   assign  _net_555 = (dxthl&_net_551);
   assign  _net_556 = (ex&(run==3'b001));
   assign  _net_557 = (dsphl&_net_556);
   assign  _net_558 = (dsphl&_net_556);
   assign  _net_559 = (dsphl&_net_556);
   assign  _net_560 = (dsphl&_net_556);
   assign  _net_561 = (dsphl&_net_556);
   assign  _net_562 = (dsphl&_net_556);
   assign  _net_563 = (ex&(run==3'b000));
   assign  _net_564 = (dsphl&_net_563);
   assign  _net_565 = (dsphl&_net_563);
   assign  _net_566 = (dsphl&_net_563);
   assign  _net_567 = (dsphl&_net_563);
   assign  _net_568 = (dsphl&_net_563);
   assign  _net_569 = (dsphl&_net_563);
   assign  _net_570 = (ex&(run==3'b100));
   assign  _net_571 = (dxchg&_net_570);
   assign  _net_572 = (dxchg&_net_570);
   assign  _net_573 = (dxchg&_net_570);
   assign  _net_574 = (dxchg&_net_570);
   assign  _net_575 = (ex&(run==3'b011));
   assign  _net_576 = (dxchg&_net_575);
   assign  _net_577 = (dxchg&_net_575);
   assign  _net_578 = (dxchg&_net_575);
   assign  _net_579 = (dxchg&_net_575);
   assign  _net_580 = (dxchg&_net_575);
   assign  _net_581 = (dxchg&_net_575);
   assign  _net_582 = (ex&(run==3'b010));
   assign  _net_583 = (dxchg&_net_582);
   assign  _net_584 = (dxchg&_net_582);
   assign  _net_585 = (dxchg&_net_582);
   assign  _net_586 = (dxchg&_net_582);
   assign  _net_587 = (dxchg&_net_582);
   assign  _net_588 = (dxchg&_net_582);
   assign  _net_589 = (dxchg&_net_582);
   assign  _net_590 = (ex&(run==3'b001));
   assign  _net_591 = (dxchg&_net_590);
   assign  _net_592 = (dxchg&_net_590);
   assign  _net_593 = (dxchg&_net_590);
   assign  _net_594 = (dxchg&_net_590);
   assign  _net_595 = (dxchg&_net_590);
   assign  _net_596 = (dxchg&_net_590);
   assign  _net_597 = (ex&(run==3'b000));
   assign  _net_598 = (dxchg&_net_597);
   assign  _net_599 = (dxchg&_net_597);
   assign  _net_600 = (dxchg&_net_597);
   assign  _net_601 = (dxchg&_net_597);
   assign  _net_602 = (ex&(run==3'b000));
   assign  _net_603 = (dmvi&_net_602);
   assign  _net_604 = (dmvi&_net_602);
   assign  _net_605 = (dmvi&(~_net_602));
   assign  _net_606 = (ex&(run==3'b000));
   assign  _net_607 = (dalui&_net_606);
   assign  _net_608 = (dalui&_net_606);
   assign  _net_609 = (dalui&(~_net_606));
   assign  _net_610 = (ex&(run==3'b001));
   assign  _net_611 = (din&_net_610);
   assign  _net_612 = (din&_net_610);
   assign  _net_613 = (din&_net_610);
   assign  _net_614 = (din&_net_610);
   assign  _net_615 = (din&_net_610);
   assign  _net_616 = (din&_net_610);
   assign  _net_617 = (ex&(run==3'b000));
   assign  _net_618 = (din&_net_617);
   assign  _net_619 = (din&_net_617);
   assign  _net_620 = (ex&(run==3'b001));
   assign  _net_621 = (dout&_net_620);
   assign  _net_622 = (dout&_net_620);
   assign  _net_623 = (dout&_net_620);
   assign  _net_624 = (dout&_net_620);
   assign  _net_625 = (ex&(run==3'b000));
   assign  _net_626 = (dout&_net_625);
   assign  _net_627 = (dout&_net_625);
   assign  _net_628 = (ex&(run==3'b010));
   assign  _net_629 = (dcc&_net_628);
   assign  _net_630 = ((dcc&_net_628)&flg);
   assign  _net_631 = ((dcc&_net_628)&(~flg));
   assign  _net_632 = (ex&(run==3'b001));
   assign  _net_633 = (dcc&_net_632);
   assign  _net_634 = (dcc&_net_632);
   assign  _net_635 = (ex&(run==3'b000));
   assign  _net_636 = (dcc&_net_635);
   assign  _net_637 = (dcc&_net_635);
   assign  _net_638 = (((dcc&(~_net_628))&(~_net_632))&(~_net_635));
   assign  _net_639 = (ex&(run==3'b100));
   assign  _net_640 = (dcall&_net_639);
   assign  _net_641 = (dcall&_net_639);
   assign  _net_642 = (dcall&_net_639);
   assign  _net_643 = (dcall&_net_639);
   assign  _net_644 = (ex&(run==3'b011));
   assign  _net_645 = (dcall&_net_644);
   assign  _net_646 = (dcall&_net_644);
   assign  _net_647 = (dcall&_net_644);
   assign  _net_648 = (dcall&_net_644);
   assign  _net_649 = (dcall&_net_644);
   assign  _net_650 = (ex&(run==3'b010));
   assign  _net_651 = (dcall&_net_650);
   assign  _net_652 = (dcall&_net_650);
   assign  _net_653 = (ex&(run==3'b001));
   assign  _net_654 = (dcall&_net_653);
   assign  _net_655 = (dcall&_net_653);
   assign  _net_656 = (ex&(run==3'b000));
   assign  _net_657 = (dcall&_net_656);
   assign  _net_658 = (dcall&_net_656);
   assign  _net_659 = (ex&(run==3'b001));
   assign  _net_660 = (djmp&_net_659);
   assign  _net_661 = (djmp&_net_659);
   assign  _net_662 = (ex&(run==3'b000));
   assign  _net_663 = (djmp&_net_662);
   assign  _net_664 = (djmp&_net_662);
   assign  _net_665 = ((djmp&(~_net_659))&(~_net_662));
   assign  _net_666 = ((djmp&(~_net_659))&(~_net_662));
   assign  _net_667 = ((djmp&(~_net_659))&(~_net_662));
   assign  _net_668 = (ex&(run==3'b010));
   assign  _net_669 = (djc&_net_668);
   assign  _net_670 = ((djc&_net_668)&flg);
   assign  _net_671 = ((djc&_net_668)&(~flg));
   assign  _net_672 = (ex&(run==3'b001));
   assign  _net_673 = (djc&_net_672);
   assign  _net_674 = (djc&_net_672);
   assign  _net_675 = (ex&(run==3'b000));
   assign  _net_676 = (djc&_net_675);
   assign  _net_677 = (djc&_net_675);
   assign  _net_678 = (ex&(run==3'b010));
   assign  _net_679 = (dlxi&_net_678);
   assign  _net_680 = (dlxi&_net_678);
   assign  _net_681 = (dlxi&_net_678);
   assign  _net_682 = (dlxi&_net_678);
   assign  _net_683 = (ex&(run==3'b001));
   assign  _net_684 = (dlxi&_net_683);
   assign  _net_685 = (dlxi&_net_683);
   assign  _net_686 = (dlxi&_net_683);
   assign  _net_687 = (dlxi&_net_683);
   assign  _net_688 = (dlxi&_net_683);
   assign  _net_689 = (ex&(run==3'b000));
   assign  _net_690 = (dlxi&_net_689);
   assign  _net_691 = (dlxi&_net_689);
   assign  _net_692 = (ex&(run==3'b010));
   assign  _net_693 = (dlda&_net_692);
   assign  _net_694 = (dlda&_net_692);
   assign  _net_695 = (dlda&_net_692);
   assign  _net_696 = (dlda&_net_692);
   assign  _net_697 = (dlda&_net_692);
   assign  _net_698 = (dlda&_net_692);
   assign  _net_699 = (ex&(run==3'b001));
   assign  _net_700 = (dlda&_net_699);
   assign  _net_701 = (dlda&_net_699);
   assign  _net_702 = (ex&(run==3'b000));
   assign  _net_703 = (dlda&_net_702);
   assign  _net_704 = (dlda&_net_702);
   assign  _net_705 = (ex&(run==3'b011));
   assign  _net_706 = (dlhld&_net_705);
   assign  _net_707 = (dlhld&_net_705);
   assign  _net_708 = (dlhld&_net_705);
   assign  _net_709 = (dlhld&_net_705);
   assign  _net_710 = (dlhld&_net_705);
   assign  _net_711 = (dlhld&_net_705);
   assign  _net_712 = (ex&(run==3'b010));
   assign  _net_713 = (dlhld&_net_712);
   assign  _net_714 = (dlhld&_net_712);
   assign  _net_715 = (dlhld&_net_712);
   assign  _net_716 = (dlhld&_net_712);
   assign  _net_717 = (dlhld&_net_712);
   assign  _net_718 = (dlhld&_net_712);
   assign  _net_719 = (dlhld&_net_712);
   assign  _net_720 = (ex&(run==3'b001));
   assign  _net_721 = (dlhld&_net_720);
   assign  _net_722 = (dlhld&_net_720);
   assign  _net_723 = (ex&(run==3'b000));
   assign  _net_724 = (dlhld&_net_723);
   assign  _net_725 = (dlhld&_net_723);
   assign  _net_726 = (ex&(run==3'b011));
   assign  _net_727 = (dshld&_net_726);
   assign  _net_728 = (dshld&_net_726);
   assign  _net_729 = (dshld&_net_726);
   assign  _net_730 = (dshld&_net_726);
   assign  _net_731 = (ex&(run==3'b010));
   assign  _net_732 = (dshld&_net_731);
   assign  _net_733 = (dshld&_net_731);
   assign  _net_734 = (dshld&_net_731);
   assign  _net_735 = (dshld&_net_731);
   assign  _net_736 = (dshld&_net_731);
   assign  _net_737 = (ex&(run==3'b001));
   assign  _net_738 = (dshld&_net_737);
   assign  _net_739 = (dshld&_net_737);
   assign  _net_740 = (ex&(run==3'b000));
   assign  _net_741 = (dshld&_net_740);
   assign  _net_742 = (dshld&_net_740);
   assign  _net_743 = (ex&(run==3'b010));
   assign  _net_744 = (dsta&_net_743);
   assign  _net_745 = (dsta&_net_743);
   assign  _net_746 = (dsta&_net_743);
   assign  _net_747 = (dsta&_net_743);
   assign  _net_748 = (ex&(run==3'b001));
   assign  _net_749 = (dsta&_net_748);
   assign  _net_750 = (dsta&_net_748);
   assign  _net_751 = (ex&(run==3'b000));
   assign  _net_752 = (dsta&_net_751);
   assign  _net_753 = (dsta&_net_751);
   assign  _net_754 = (imask|(~intt));
   assign  _net_755 = (ift&_net_754);
   assign  _net_756 = (ift&_net_754);
   assign  _net_757 = (ift&_net_754);
   assign  _net_758 = (ift&_net_754);
   assign  _net_759 = (ift&_net_754);
   assign  _net_760 = (ift&_net_754);
   assign  _net_761 = (ift&_net_754);
   assign  _net_762 = (((~imask)&intt)&int_state);
   assign  _net_763 = (ift&_net_762);
   assign  _net_764 = (ift&_net_762);
   assign  _net_765 = (ift&_net_762);
   assign  _net_766 = (ift&_net_762);
   assign  _net_767 = (ift&_net_762);
   assign  _net_768 = (ift&_net_762);
   assign  _net_769 = (ift&_net_762);
   assign  _net_770 = (((~imask)&intt)&(~int_state));
   assign  _net_771 = (ift&_net_770);
   assign  _net_772 = (ift&_net_770);
   assign  _net_773 = (ift&_net_770);
   assign  _net_774 = (ift&_net_770);
   assign  _net_775 = (ift&_net_770);
   assign  _net_776 = (ift&_net_770);
   assign  _net_777 = (ift&_net_770);
   assign  _net_778 = (ex&ifetch);
   assign  _net_779 = (ex&ifetch);
   assign  _net_780 = (ex&S4);
   assign  _net_781 = (ex&S4);
   assign  _net_782 = (ex&S4);
   assign  _net_783 = (ex&S3);
   assign  _net_784 = (ex&S3);
   assign  _net_785 = (ex&S3);
   assign  _net_786 = (ex&S2);
   assign  _net_787 = (ex&S2);
   assign  _net_788 = (ex&S2);
   assign  _net_789 = (ex&S1);
   assign  _net_790 = (ex&S1);
   assign  _net_791 = (ex&S1);
   assign  _net_792 = (((((ex&(~ifetch))&(~S4))&(~S3))&(~S2))&(~S1));
   assign  datao = ((_net_646)?pch:8'b0)|
    ((_net_641)?pcl:8'b0)|
    (((_net_733|_net_544))?l:8'b0)|
    (((_net_728|_net_533))?h:8'b0)|
    (((_net_745|(_net_622|(_net_432|_net_429))))?a:8'b0)|
    (((_net_410|_net_400))?lo:8'b0)|
    (((_net_285|_net_202))?op1:8'b0);
   assign  adrs = (((_net_756|(fetch3|fetch2)))?({pch,pcl}):16'b0)|
    (((_net_746|(_net_734|(_net_729|(_net_715|(_net_708|_net_695))))))?({op2,op1}):16'b0)|
    (((_net_623|_net_613))?({8'b00000000,op1}):16'b0)|
    (((_net_433|_net_424))?({d,e}):16'b0)|
    (((_net_430|_net_419))?({b,c}):16'b0)|
    (((_net_647|(_net_642|(_net_553|(_net_545|(_net_539|(_net_534|(_net_448|(_net_442|(_net_411|(_net_401|(_net_391|_net_383))))))))))))?({sph,spl}):16'b0)|
    (((_net_306|(_net_286|(_net_276|(_net_217|_net_203)))))?({h,l}):16'b0);
   assign  ack = (_net_774|_net_766);
   assign  memory_read = (_net_755|(fetch3|(fetch2|(_net_714|(_net_707|(_net_694|(_net_552|(_net_538|(_net_447|(_net_441|(_net_423|(_net_418|(_net_390|(_net_382|(_net_305|(_net_275|_net_216))))))))))))))));
   assign  memory_write = (_net_744|(_net_732|(_net_727|(_net_645|(_net_640|(_net_543|(_net_532|(_net_431|(_net_428|(_net_407|(_net_397|(_net_284|_net_201))))))))))));
   assign  io_read = _net_612;
   assign  io_write = _net_621;
always @(posedge m_clock)
  begin
if ((_net_666)|(dpchl)|(_net_443)|((decpc|incpc))|(start)) 
      pch <= ((_net_666) ?op2:8'b0)|
    ((dpchl) ?h:8'b0)|
    ((_net_443) ?data:8'b0)|
    (((decpc|incpc)) ?_inc_out:8'b0)|
    ((start) ?8'b00000000:8'b0);

end
always @(posedge m_clock)
  begin
if ((_net_665)|(dpchl)|(_net_449)|((decpc|incpc))|(start)) 
      pcl <= ((_net_665) ?op1:8'b0)|
    ((dpchl) ?l:8'b0)|
    ((_net_449) ?data:8'b0)|
    (((decpc|incpc)) ?_alu_out:8'b0)|
    ((start) ?8'b00000000:8'b0);

end
always @(posedge m_clock)
  begin
if (((decsp|incsp))|(_net_87)) 
      sph <= (((decsp|incsp)) ?_inc_out:8'b0)|
    ((_net_87) ?v:8'b0);

end
always @(posedge m_clock)
  begin
if (((decsp|incsp))|(_net_85)) 
      spl <= (((decsp|incsp)) ?_alu_out:8'b0)|
    ((_net_85) ?v:8'b0);

end
always @(posedge m_clock)
  begin
if ((_net_53)) 
      a <= v;
end
always @(posedge m_clock)
  begin
if (((_net_526|_net_512))|((_net_519|_net_505))|(_net_478)|(_net_474)|(_net_334)|((_net_322|_net_300))|((_net_498|(_net_469|_net_270)))|(_net_55)) 
      f <= (((_net_526|_net_512)) ?({(f[7:1]),(a[7])}):8'b0)|
    (((_net_519|_net_505)) ?({(f[7:1]),(a[0])}):8'b0)|
    ((_net_478) ?({(f[7:1]),1'b1}):8'b0)|
    ((_net_474) ?({(f[7:1]),(~(f[0]))}):8'b0)|
    ((_net_334) ?({(f[7:1]),_alu_c}):8'b0)|
    (((_net_322|_net_300)) ?({_alu_s,_alu_z,1'b0,_alu_a,1'b0,_alu_p,1'b0,(f[0])}):8'b0)|
    (((_net_498|(_net_469|_net_270))) ?({_alu_s,_alu_z,1'b0,_alu_a,1'b0,_alu_p,1'b0,_alu_c}):8'b0)|
    ((_net_55) ?v:8'b0);

end
always @(posedge m_clock)
  begin
if (((_net_99|_net_67))) 
      b <= v;
end
always @(posedge m_clock)
  begin
if (((_net_97|_net_65))) 
      c <= v;
end
always @(posedge m_clock)
  begin
if (((_net_95|_net_63))) 
      d <= v;
end
always @(posedge m_clock)
  begin
if (((_net_93|_net_61))) 
      e <= v;
end
always @(posedge m_clock)
  begin
if (((_net_91|_net_59))) 
      h <= v;
end
always @(posedge m_clock)
  begin
if (((_net_89|_net_57))) 
      l <= v;
end
always @(posedge m_clock)
  begin
if (((_net_378|_net_345))) 
      tc <= _alu_c;
end
always @(posedge m_clock)
  begin
if ((dei)|((_net_771|(_net_763|(ddi|start))))) 
      imask <= ((dei) ?1'b0:1'b0)|
    (((_net_771|(_net_763|(ddi|start)))) ?1'b1:1'b0);

end
always @(posedge m_clock)
  begin
if ((_net_772)|(_net_764)|(_net_757)) 
      op0 <= ((_net_772) ?8'b11001111:8'b0)|
    ((_net_764) ?8'b11010111:8'b0)|
    ((_net_757) ?data:8'b0);

end
always @(posedge m_clock)
  begin
if ((_net_453)|((_net_600|(_net_588|(_net_281|_net_222))))|((fetch2|(_net_554|(_net_540|(_net_307|(_net_277|_net_218))))))|((_net_299|incop))) 
      op1 <= ((_net_453) ?({2'b00,(op0[5:3]),3'b000}):8'b0)|
    (((_net_600|(_net_588|(_net_281|_net_222)))) ?lo:8'b0)|
    (((fetch2|(_net_554|(_net_540|(_net_307|(_net_277|_net_218)))))) ?data:8'b0)|
    (((_net_299|incop)) ?_alu_out:8'b0);

end
always @(posedge m_clock)
  begin
if ((fetch3)|(_net_454)|(incop)) 
      op2 <= ((fetch3) ?data:8'b0)|
    ((_net_454) ?8'b00000000:8'b0)|
    ((incop) ?_inc_out:8'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     st0 <= 1'b0;
else   st0 <= 1'b1;
end
always @(posedge m_clock)
  begin
  st1 <= st0;
end
always @(posedge m_clock)
  begin
  st2 <= st1;
end
always @(posedge m_clock)
  begin
if (p_reset)
     int_state <= 1'b0;
else if (((_net_773|_net_765))) 
      int_state <= (~int_state);
end
always @(posedge m_clock)
  begin
if (p_reset)
     intt <= 1'b0;
else if ((_net_48)) 
      intt <= _proc_intt_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     ift <= 1'b0;
else if ((_net_49)) 
      ift <= _proc_ift_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     run <= 3'b000;
else if ((_net_791)|(_net_788)|(_net_785)|(_net_782)|((_net_777|(_net_769|_net_761)))) 
      run <= ((_net_791) ?3'b001:3'b0)|
    ((_net_788) ?3'b010:3'b0)|
    ((_net_785) ?3'b011:3'b0)|
    ((_net_782) ?3'b100:3'b0)|
    (((_net_777|(_net_769|_net_761))) ?3'b000:3'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     ex <= 1'b0;
else if ((_net_50)) 
      ex <= _proc_ex_set;
end
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:06 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:06 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module vga ( p_reset , m_clock , b , g , r , h , v , mr , mbusy , data , adr );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  output b;
  wire b;
  output g;
  wire g;
  output r;
  wire r;
  output h;
  wire h;
  output v;
  wire v;
  output mr;
  wire mr;
  input mbusy;
  wire mbusy;
  input [7:0] data;
  wire [7:0] data;
  output [12:0] adr;
  wire [12:0] adr;
  reg h_dispon;
  reg v_dispon;
  reg h_sync;
  reg v_sync;
  reg reqfetcha;
  reg reqfetchb;
  reg [15:0] h_count;
  reg [15:0] v_count;
  reg [7:0] fn;
  reg [7:0] fca;
  reg [7:0] fcb;
  reg [15:0] vramadra;
  reg [15:0] vramadrb;
  reg side;
  reg fetched;
  wire [12:0] vramadr;
  wire [7:0] fc;
  wire vup;
  wire sidex;
  wire disp_char;
  wire vadr;
  reg fetch;
  wire _proc_fetch_set;
  wire _proc_fetch_reset;
  wire _net_793;
  wire _net_794;
  wire _net_795;
  wire _net_796;
  wire _net_797;
  wire _net_798;
  wire _net_799;
  wire _net_800;
  wire _net_801;
  wire _net_802;
  wire _net_803;
  wire _net_804;
  wire _net_805;
  wire _net_806;
  wire _net_807;
  wire _net_808;
  wire _net_809;
  wire _net_810;
  wire _net_811;
  wire _net_812;
  wire _net_813;
  wire _net_814;
  wire _net_815;
  wire _net_816;
  wire _net_817;
  wire _net_818;
  wire _net_819;
  wire _net_820;
  wire _net_821;
  reg _reg_822;
  reg _reg_823;
  reg _reg_824;
  reg _reg_825;
  reg _reg_826;
  reg _reg_827;
  reg _reg_828;
  reg _reg_829;
  reg _reg_830;
  wire _net_831;
  wire _net_832;
  wire _net_833;
  wire _net_834;
  wire _net_835;
  wire _net_836;
  wire _net_837;
  wire _net_838;
  wire _net_839;
  wire _net_840;
  wire _net_841;
  wire _net_842;
  wire _net_843;
  wire _net_844;
  wire _net_845;
  wire _net_846;
  wire _net_847;
  wire _net_848;
  wire _net_849;
  wire _net_850;
  wire _net_851;
  wire _net_852;
  wire _net_853;
  wire _net_854;
  wire _net_855;
  wire _net_856;
  wire _net_857;
  wire _net_858;
  wire _net_859;
  wire _net_860;
  wire _net_861;
  wire _net_862;
  wire _net_863;
  wire _net_864;
  wire _net_865;
  wire _net_866;
  wire _net_867;
  wire _net_868;
  wire _net_869;
  wire _net_870;
  wire _net_871;
  wire _net_872;
  wire _net_873;
  wire _net_874;
  wire _net_875;
  wire _net_876;
  wire _net_877;
  wire _net_878;
  wire _net_879;
  wire _net_880;
  wire _net_881;
  wire _net_882;
  wire _net_883;
  wire _net_884;
  wire _net_885;
  wire _net_886;
  wire _net_887;
  wire _net_888;
  wire _net_889;
  wire _net_890;
  wire _net_891;

   assign  vramadr = ((_net_877)?(vramadra[12:0]):13'b0)|
    ((_net_874)?(vramadrb[12:0]):13'b0);
   assign  fc = ((_net_878)?fca:8'b0)|
    ((_net_875)?fcb:8'b0);
   assign  vup = _net_796;
   assign  sidex = (vadr|_net_863);
   assign  disp_char = _net_794;
   assign  vadr = (_net_888|_net_883);
   assign  _proc_fetch_set = (_net_865|_net_798);
   assign  _proc_fetch_reset = _net_891;
   assign  _net_793 = (_proc_fetch_set|_proc_fetch_reset);
   assign  _net_794 = ((v_dispon&h_dispon)&((h_count[2:0])==3'b000));
   assign  _net_795 = (h_count==16'b0000000100111111);
   assign  _net_796 = (h_count==16'b0000000100101100);
   assign  _net_797 = (reqfetcha|reqfetchb);
   assign  _net_798 = (_net_796&_net_797);
   assign  _net_799 = ((_net_796&_net_797)&side);
   assign  _net_800 = (~side);
   assign  _net_801 = (_net_796&_net_797);
   assign  _net_802 = ((_net_796&_net_797)&_net_800);
   assign  _net_803 = (h_count==16'b0000000100000101);
   assign  _net_804 = (h_count==16'b0000000011111111);
   assign  _net_805 = (h_count==16'b0000000100111111);
   assign  _net_806 = (~_net_805);
   assign  _net_807 = (v_count==16'b0000001000001000);
   assign  _net_808 = (vup&_net_807);
   assign  _net_809 = (v_count==16'b0000000111101011);
   assign  _net_810 = (vup&_net_809);
   assign  _net_811 = (v_count==16'b0000000111011010);
   assign  _net_812 = (vup&_net_811);
   assign  _net_813 = (v_count==16'b0000000110111111);
   assign  _net_814 = (vup&_net_813);
   assign  _net_815 = (v_count==16'b0000001000001000);
   assign  _net_816 = (vup&_net_815);
   assign  _net_817 = (vup&_net_815);
   assign  _net_818 = (vup&_net_815);
   assign  _net_819 = (vup&_net_815);
   assign  _net_820 = (vup&_net_815);
   assign  _net_821 = (vup&(~_net_815));
   assign  _net_831 = (fn[0]);
   assign  _net_832 = (_reg_822&_net_831);
   assign  _net_833 = (_reg_822&_net_831);
   assign  _net_834 = (_reg_822&_net_831);
   assign  _net_835 = (fn[1]);
   assign  _net_836 = (_reg_823&_net_835);
   assign  _net_837 = (_reg_823&_net_835);
   assign  _net_838 = (_reg_823&_net_835);
   assign  _net_839 = (fn[2]);
   assign  _net_840 = (_reg_824&_net_839);
   assign  _net_841 = (_reg_824&_net_839);
   assign  _net_842 = (_reg_824&_net_839);
   assign  _net_843 = (fn[3]);
   assign  _net_844 = (_reg_825&_net_843);
   assign  _net_845 = (_reg_825&_net_843);
   assign  _net_846 = (_reg_825&_net_843);
   assign  _net_847 = (fn[4]);
   assign  _net_848 = (_reg_826&_net_847);
   assign  _net_849 = (_reg_826&_net_847);
   assign  _net_850 = (_reg_826&_net_847);
   assign  _net_851 = (fn[5]);
   assign  _net_852 = (_reg_827&_net_851);
   assign  _net_853 = (_reg_827&_net_851);
   assign  _net_854 = (_reg_827&_net_851);
   assign  _net_855 = (fn[6]);
   assign  _net_856 = (_reg_828&_net_855);
   assign  _net_857 = (_reg_828&_net_855);
   assign  _net_858 = (_reg_828&_net_855);
   assign  _net_859 = (fn[7]);
   assign  _net_860 = (_reg_829&_net_859);
   assign  _net_861 = (_reg_829&_net_859);
   assign  _net_862 = (_reg_829&_net_859);
   assign  _net_863 = (disp_char|_reg_830);
   assign  _net_864 = (disp_char|_reg_830);
   assign  _net_865 = (disp_char|_reg_830);
   assign  _net_866 = (disp_char|(_reg_829|_reg_830));
   assign  _net_867 = (_reg_828|_reg_829);
   assign  _net_868 = (_reg_827|_reg_828);
   assign  _net_869 = (_reg_826|_reg_827);
   assign  _net_870 = (_reg_825|_reg_826);
   assign  _net_871 = (_reg_824|_reg_825);
   assign  _net_872 = (_reg_823|_reg_824);
   assign  _net_873 = (_reg_822|_reg_823);
   assign  _net_874 = (sidex&side);
   assign  _net_875 = (sidex&side);
   assign  _net_876 = (~side);
   assign  _net_877 = (sidex&_net_876);
   assign  _net_878 = (sidex&_net_876);
   assign  _net_879 = (vadr&side);
   assign  _net_880 = (~side);
   assign  _net_881 = (vadr&_net_880);
   assign  _net_882 = (~mbusy);
   assign  _net_883 = ((fetch&_net_882)&side);
   assign  _net_884 = ((fetch&_net_882)&side);
   assign  _net_885 = ((fetch&_net_882)&side);
   assign  _net_886 = (~side);
   assign  _net_887 = (fetch&_net_882);
   assign  _net_888 = ((fetch&_net_882)&_net_886);
   assign  _net_889 = ((fetch&_net_882)&_net_886);
   assign  _net_890 = ((fetch&_net_882)&_net_886);
   assign  _net_891 = (fetch&_net_882);
   assign  r = (_net_860|(_net_856|(_net_852|(_net_848|(_net_844|(_net_840|(_net_836|_net_832)))))));
   assign  g = (_net_861|(_net_857|(_net_853|(_net_849|(_net_845|(_net_841|(_net_837|_net_833)))))));
   assign  b = (_net_862|(_net_858|(_net_854|(_net_850|(_net_846|(_net_842|(_net_838|_net_834)))))));
   assign  mr = (_net_889|_net_884);
always @(posedge m_clock)
  begin
if (p_reset)
     h_dispon <= 1'b0;
else if ((_net_804)|(_net_795)) 
      h_dispon <= ((_net_804) ?1'b0:1'b0)|
    ((_net_795) ?1'b1:1'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     v_dispon <= 1'b0;
else if ((_net_814)|(_net_808)) 
      v_dispon <= ((_net_814) ?1'b0:1'b0)|
    ((_net_808) ?1'b1:1'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     h_sync <= 1'b0;
else if ((_net_803)|(_net_796)) 
      h_sync <= ((_net_803) ?1'b1:1'b0)|
    ((_net_796) ?1'b0:1'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     v_sync <= 1'b0;
else if ((_net_812)|(_net_810)) 
      v_sync <= ((_net_812) ?1'b1:1'b0)|
    ((_net_810) ?1'b0:1'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     reqfetcha <= 1'b1;
else if ((_net_816)|(_net_802)) 
      reqfetcha <= ((_net_816) ?1'b1:1'b0)|
    ((_net_802) ?1'b0:1'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     reqfetchb <= 1'b1;
else if ((_net_817)|(_net_799)) 
      reqfetchb <= ((_net_817) ?1'b1:1'b0)|
    ((_net_799) ?1'b0:1'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     h_count <= 16'b0000000000000000;
else if ((_net_806)|(_net_805)) 
      h_count <= ((_net_806) ?(h_count+16'b0000000000000001):16'b0)|
    ((_net_805) ?16'b0000000000000000:16'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     v_count <= 16'b0000000000000000;
else if ((_net_821)|(_net_820)) 
      v_count <= ((_net_821) ?(v_count+16'b0000000000000001):16'b0)|
    ((_net_820) ?16'b0000000000000000:16'b0);

end
always @(posedge m_clock)
  begin
if ((_net_864)) 
      fn <= fc;
end
always @(posedge m_clock)
  begin
if ((_net_890)) 
      fca <= data;
end
always @(posedge m_clock)
  begin
if ((_net_885)) 
      fcb <= data;
end
always @(posedge m_clock)
  begin
if (p_reset)
     vramadra <= 16'b0000000000000000;
else if ((_net_881)|(_net_818)) 
      vramadra <= ((_net_881) ?(vramadra+16'b0000000000000001):16'b0)|
    ((_net_818) ?16'b0000000000000000:16'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     vramadrb <= 16'b0000000000000000;
else if ((_net_879)|(_net_819)) 
      vramadrb <= ((_net_879) ?(vramadrb+16'b0000000000000001):16'b0)|
    ((_net_819) ?16'b0000000000000000:16'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     side <= 1'b0;
else if ((_net_803)) 
      side <= (~side);
end
always @(posedge m_clock)
  begin
if (p_reset)
     fetched <= 1'b0;
end
always @(posedge m_clock)
  begin
if (p_reset)
     fetch <= 1'b0;
else if ((_net_793)) 
      fetch <= _proc_fetch_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_822 <= 1'b0;
else if ((_net_873)) 
      _reg_822 <= _reg_823;
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_823 <= 1'b0;
else if ((_net_872)) 
      _reg_823 <= _reg_824;
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_824 <= 1'b0;
else if ((_net_871)) 
      _reg_824 <= _reg_825;
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_825 <= 1'b0;
else if ((_net_870)) 
      _reg_825 <= _reg_826;
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_826 <= 1'b0;
else if ((_net_869)) 
      _reg_826 <= _reg_827;
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_827 <= 1'b0;
else if ((_net_868)) 
      _reg_827 <= _reg_828;
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_828 <= 1'b0;
else if ((_net_867)) 
      _reg_828 <= _reg_829;
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_829 <= 1'b0;
else if ((_net_866)) 
      _reg_829 <= (_reg_830|disp_char);
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_830 <= 1'b0;
else if ((_reg_830)) 
      _reg_830 <= 1'b0;
end
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:55:06 2016
 Licensed to :EVALUATION USER
*/
