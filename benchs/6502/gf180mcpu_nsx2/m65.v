
/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Mon Jun  3 09:43:16 2024
 Licensed to :EVALUATION USER*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module decadj ( p_reset , m_clock , in , sub , out , adj );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [4:0] in;
  wire [4:0] in;
  input sub;
  wire sub;
  output [4:0] out;
  wire [4:0] out;
  input adj;
  wire adj;
  wire [3:0] tmp;
  wire _net_0;
  wire [3:0] _net_1;
  wire _net_2;
  wire _net_3;
  wire _net_4;
  wire _net_5;
  wire _net_6;

   assign  tmp = ((in[3:0])+_net_1);
   assign  _net_0 = (((sub^(in[4]))|((in[3])&(in[2])))|((in[3])&(in[1])));
   assign  _net_1 = ((_net_3)?4'b0110:4'b0)|
    ((_net_2)?4'b1010:4'b0);
   assign  _net_2 = ((adj&_net_0)&(sub != 1'b0));
   assign  _net_3 = ((adj&_net_0)&(~(sub != 1'b0)));
   assign  _net_4 = (adj&_net_0);
   assign  _net_5 = (adj&_net_0);
   assign  _net_6 = (adj&(~_net_0));
   assign  out = ((_net_6)?in:5'b0)|
    ((_net_5)?({(~sub),tmp}):5'b0);
endmodule

/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Mon Jun  3 09:43:16 2024
 Licensed to :EVALUATION USER*/

/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Mon Jun  3 09:43:16 2024
 Licensed to :EVALUATION USER*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module cpa8 ( p_reset , m_clock , in1 , in2 , ci , df , out , co , add , sub );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [7:0] in1;
  wire [7:0] in1;
  input [7:0] in2;
  wire [7:0] in2;
  input ci;
  wire ci;
  input df;
  wire df;
  output [7:0] out;
  wire [7:0] out;
  output co;
  wire co;
  input add;
  wire add;
  input sub;
  wire sub;
  wire [4:0] h1;
  wire [4:0] h2;
  wire [4:0] l1;
  wire [4:0] l2;
  wire ct;
  wire [4:0] _lo_in;
  wire _lo_sub;
  wire [4:0] _lo_out;
  wire _lo_adj;
  wire _lo_p_reset;
  wire _lo_m_clock;
  wire [4:0] _hi_in;
  wire _hi_sub;
  wire [4:0] _hi_out;
  wire _hi_adj;
  wire _hi_p_reset;
  wire _hi_m_clock;
  wire [3:0] _net_7;
  wire [3:0] _net_8;
  wire _net_9;
  wire [3:0] _net_10;
  wire [3:0] _net_11;
  wire _net_12;
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
  wire [3:0] _net_25;
  wire [3:0] _net_26;
  wire _net_27;
  wire [3:0] _net_28;
  wire [3:0] _net_29;
  wire _net_30;
  wire _net_31;
  wire _net_32;
  wire _net_33;
  wire _net_34;
  wire _net_35;
  wire _net_36;
  wire _net_37;
  wire _net_38;
  wire _net_39;
  wire _net_40;
  wire _net_41;
  wire _net_42;
decadj lo (.m_clock(m_clock), .p_reset( p_reset), .adj(_lo_adj), .out(_lo_out), .in(_lo_in), .sub(_lo_sub));
decadj hi (.m_clock(m_clock), .p_reset( p_reset), .adj(_hi_adj), .out(_hi_out), .in(_hi_in), .sub(_hi_sub));

   assign  h1 = ((sub)?((({1'b0,_net_28})+({1'b0,_net_29}))+({4'b0000,_net_30})):5'b0)|
    ((add)?((({1'b0,_net_10})+({1'b0,_net_11}))+({4'b0000,_net_12})):5'b0);
   assign  l1 = ((sub)?((({1'b0,_net_25})+({1'b0,_net_26}))+({4'b0000,_net_27})):5'b0)|
    ((add)?((({1'b0,_net_7})+({1'b0,_net_8}))+({4'b0000,_net_9})):5'b0);
   assign  ct = (((_net_41|_net_23))?(l1[4]):1'b0)|
    (((_net_38|_net_20))?(_lo_out[4]):1'b0);
   assign  _lo_in = l1;
   assign  _lo_sub = _net_32|
    ((_net_14)?1'b0:1'b0);
   assign  _lo_adj = (_net_31|_net_13);
   assign  _lo_p_reset = p_reset;
   assign  _lo_m_clock = m_clock;
   assign  _hi_in = h1;
   assign  _hi_sub = _net_35|
    ((_net_17)?1'b0:1'b0);
   assign  _hi_adj = (_net_34|_net_16);
   assign  _hi_p_reset = p_reset;
   assign  _hi_m_clock = m_clock;
   assign  _net_7 = (in1[3:0]);
   assign  _net_8 = (in2[3:0]);
   assign  _net_9 = ci;
   assign  _net_10 = (in1[7:4]);
   assign  _net_11 = (in2[7:4]);
   assign  _net_12 = ct;
   assign  _net_13 = (add&(df != 1'b0));
   assign  _net_14 = (add&(df != 1'b0));
   assign  _net_15 = (add&(df != 1'b0));
   assign  _net_16 = (add&(df != 1'b0));
   assign  _net_17 = (add&(df != 1'b0));
   assign  _net_18 = (add&(df != 1'b0));
   assign  _net_19 = (add&(df != 1'b0));
   assign  _net_20 = (add&(df != 1'b0));
   assign  _net_21 = (add&(df != 1'b0));
   assign  _net_22 = (add&(~(df != 1'b0)));
   assign  _net_23 = (add&(~(df != 1'b0)));
   assign  _net_24 = (add&(~(df != 1'b0)));
   assign  _net_25 = (in1[3:0]);
   assign  _net_26 = (~(in2[3:0]));
   assign  _net_27 = ci;
   assign  _net_28 = (in1[7:4]);
   assign  _net_29 = (~(in2[7:4]));
   assign  _net_30 = ct;
   assign  _net_31 = (sub&(df != 1'b0));
   assign  _net_32 = (sub&(df != 1'b0));
   assign  _net_33 = (sub&(df != 1'b0));
   assign  _net_34 = (sub&(df != 1'b0));
   assign  _net_35 = (sub&(df != 1'b0));
   assign  _net_36 = (sub&(df != 1'b0));
   assign  _net_37 = (sub&(df != 1'b0));
   assign  _net_38 = (sub&(df != 1'b0));
   assign  _net_39 = (sub&(df != 1'b0));
   assign  _net_40 = (sub&(~(df != 1'b0)));
   assign  _net_41 = (sub&(~(df != 1'b0)));
   assign  _net_42 = (sub&(~(df != 1'b0)));
   assign  out = (((_net_40|_net_22))?({(h1[3:0]),(l1[3:0])}):8'b0)|
    (((_net_37|_net_19))?({(_hi_out[3:0]),(_lo_out[3:0])}):8'b0);
   assign  co = (((_net_42|_net_24))?(h1[4]):1'b0)|
    (((_net_39|_net_21))?(_hi_out[4]):1'b0);
endmodule

/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Mon Jun  3 09:43:16 2024
 Licensed to :EVALUATION USER*/

/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Mon Jun  3 09:43:16 2024
 Licensed to :EVALUATION USER*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module alu65 ( p_reset , m_clock , in1 , in2 , ci , df , out , c , z , v , s , adc , sbc , do_and , bita , do_or , eor , inc , dec , dec2 , incc , asl , lsr , ror , rol , thr );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [7:0] in1;
  wire [7:0] in1;
  input [7:0] in2;
  wire [7:0] in2;
  input ci;
  wire ci;
  input df;
  wire df;
  output [7:0] out;
  wire [7:0] out;
  output c;
  wire c;
  output z;
  wire z;
  output v;
  wire v;
  output s;
  wire s;
  input adc;
  wire adc;
  input sbc;
  wire sbc;
  input do_and;
  wire do_and;
  input bita;
  wire bita;
  input do_or;
  wire do_or;
  input eor;
  wire eor;
  input inc;
  wire inc;
  input dec;
  wire dec;
  input dec2;
  wire dec2;
  input incc;
  wire incc;
  input asl;
  wire asl;
  input lsr;
  wire lsr;
  input ror;
  wire ror;
  input rol;
  wire rol;
  input thr;
  wire thr;
  wire [7:0] out_in;
  wire set_out;
  wire [7:0] _adder_in1;
  wire [7:0] _adder_in2;
  wire _adder_ci;
  wire _adder_df;
  wire [7:0] _adder_out;
  wire _adder_co;
  wire _adder_add;
  wire _adder_sub;
  wire _adder_p_reset;
  wire _adder_m_clock;
  wire _net_43;
  wire _net_44;
  wire _net_45;
  wire _net_46;
  wire _net_47;
  wire _net_48;
  wire _net_49;
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
cpa8 adder (.m_clock(m_clock), .p_reset( p_reset), .sub(_adder_sub), .add(_adder_add), .out(_adder_out), .co(_adder_co), .in1(_adder_in1), .in2(_adder_in2), .ci(_adder_ci), .df(_adder_df));

   assign  out_in = ((thr)?in1:8'b0)|
    ((ror)?({ci,(in1[7:1])}):8'b0)|
    ((rol)?({(in1[6:0]),ci}):8'b0)|
    ((lsr)?({1'b0,(in1[7:1])}):8'b0)|
    ((asl)?({(in1[6:0]),1'b0}):8'b0)|
    ((do_or)?(in1|in2):8'b0)|
    ((eor)?(in1^in2):8'b0)|
    (((bita|do_and))?(in1&in2):8'b0)|
    (((dec2|(incc|(dec|(inc|(sbc|adc))))))?_adder_out:8'b0);
   assign  set_out = (dec2|(thr|(ror|(rol|(lsr|(asl|(incc|(dec|(inc|(do_or|(eor|(do_and|(sbc|adc)))))))))))));
   assign  _adder_in1 = ((dec2)?8'b11111111:8'b0)|
    (((incc|(dec|(inc|(sbc|adc)))))?in1:8'b0);
   assign  _adder_in2 = (((incc|(dec|inc)))?8'b00000000:8'b0)|
    (((dec2|(sbc|adc)))?in2:8'b0);
   assign  _adder_ci = (((dec2|dec))?1'b0:1'b0)|
    ((inc)?1'b1:1'b0)|
    (((incc|(sbc|adc)))?ci:1'b0);
   assign  _adder_df = (((dec2|(incc|(dec|inc))))?1'b0:1'b0)|
    (((sbc|adc))?df:1'b0);
   assign  _adder_add = (dec2|(incc|(inc|adc)));
   assign  _adder_sub = (dec|sbc);
   assign  _adder_p_reset = p_reset;
   assign  _adder_m_clock = m_clock;
   assign  _net_43 = (out_in[7]);
   assign  _net_44 = (set_out&_net_43);
   assign  _net_45 = (~(|out_in));
   assign  _net_46 = (set_out&_net_45);
   assign  _net_47 = (adc&(_adder_co != 1'b0));
   assign  _net_48 = ((((~(in1[7]))&(~(in2[7])))&(out_in[7]))|(((in1[7])&(in2[7]))&(~(out_in[7]))));
   assign  _net_49 = (adc&_net_48);
   assign  _net_50 = ((((~(in1[7]))&(in2[7]))&(_adder_out[7]))|(((in1[7])&(~(in2[7])))&(~(_adder_out[7]))));
   assign  _net_51 = (sbc&_net_50);
   assign  _net_52 = (sbc&(_adder_co != 1'b0));
   assign  _net_53 = (in2[7]);
   assign  _net_54 = (bita&_net_53);
   assign  _net_55 = (~(|out_in));
   assign  _net_56 = (bita&_net_55);
   assign  _net_57 = (in2[6]);
   assign  _net_58 = (bita&_net_57);
   assign  _net_59 = (inc&(_adder_co != 1'b0));
   assign  _net_60 = (dec&(_adder_co != 1'b0));
   assign  _net_61 = (incc&(_adder_co != 1'b0));
   assign  _net_62 = (in1[7]);
   assign  _net_63 = (asl&_net_62);
   assign  _net_64 = (in1[0]);
   assign  _net_65 = (lsr&_net_64);
   assign  _net_66 = (in1[7]);
   assign  _net_67 = (rol&_net_66);
   assign  _net_68 = (in1[0]);
   assign  _net_69 = (ror&_net_68);
   assign  out = out_in;
   assign  s = (_net_54|_net_44);
   assign  v = (_net_58|(_net_51|_net_49));
   assign  z = (_net_56|_net_46);
   assign  c = (_net_69|(_net_67|(_net_65|(_net_63|(_net_61|(_net_60|(_net_59|(_net_52|_net_47))))))));
endmodule

/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Mon Jun  3 09:43:16 2024
 Licensed to :EVALUATION USER*/

/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Mon Jun  3 09:43:16 2024
 Licensed to :EVALUATION USER*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module inc16 ( p_reset , m_clock , in , ci , out , co , dox , thr );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [15:0] in;
  wire [15:0] in;
  input ci;
  wire ci;
  output [15:0] out;
  wire [15:0] out;
  output co;
  wire co;
  input dox;
  wire dox;
  input thr;
  wire thr;
  wire [16:0] res;
  wire [15:0] _net_70;

   assign  res = (({1'b0,_net_70})+17'b00000000000000001);
   assign  _net_70 = in;
   assign  out = ((thr)?in:16'b0)|
    ((dox)?(res[15:0]):16'b0);
   assign  co = ((thr)?1'b0:1'b0)|
    ((dox)?(res[16]):1'b0);
endmodule

/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Mon Jun  3 09:43:16 2024
 Licensed to :EVALUATION USER*/

/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Mon Jun  3 09:43:16 2024
 Licensed to :EVALUATION USER*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module m65 ( p_reset , m_clock , data , datao , adrs , debug , start , rdy , nmi , irq , wt , rd , sync );
  parameter _state__reg_762_st0 = 0;
  parameter _state__reg_762_st1 = 1;
  parameter _state__reg_762_st2 = 3;
  parameter _state__reg_762_st3 = 2;
  parameter _state__reg_762_st4 = 6;
  parameter _state__reg_762_st5 = 7;
  parameter _state__reg_762_st6 = 5;
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [7:0] data;
  wire [7:0] data;
  output [7:0] datao;
  wire [7:0] datao;
  output [15:0] adrs;
  wire [15:0] adrs;
  output [15:0] debug;
  wire [15:0] debug;
  input start;
  wire start;
  input rdy;
  wire rdy;
  input nmi;
  wire nmi;
  input irq;
  wire irq;
  output wt;
  wire wt;
  output rd;
  wire rd;
  output sync;
  wire sync;
  wire s1;
  wire s2;
  wire s3;
  wire s4;
  wire s5;
  wire ifrun;
  wire pf;
  wire write;
  wire read;
  wire decop;
  wire ea;
  wire dasl;
  wire dbit;
  wire dclc;
  wire dcmp;
  wire dcpx;
  wire ddec;
  wire dmisc;
  wire djmp;
  wire djsr;
  wire dlda;
  wire dldx;
  wire dnop;
  wire dora;
  wire dphp;
  wire dplp;
  wire drti;
  wire drts;
  wire dsta;
  wire dstx;
  wire dbc;
  wire mimp;
  wire mimm;
  wire mzpx;
  wire mzpxi;
  wire mzpiy;
  wire mabs;
  wire maby;
  wire rmw;
  wire nif0;
  wire nif1;
  wire nif2;
  reg fn;
  reg fv;
  reg fd;
  reg fz;
  reg fc;
  reg fi;
  reg swt;
  reg nm1;
  reg tc;
  wire [7:0] psr;
  wire [7:0] psri;
  wire taken;
  wire [7:0] ALU1;
  wire [7:0] ABLin;
  wire [7:0] dbo;
  wire [7:0] dbi;
  wire [7:0] opc;
  reg [7:0] RY;
  reg [7:0] RX;
  reg [7:0] RS;
  reg [7:0] RA;
  reg [7:0] PCL;
  reg [7:0] DL;
  reg [7:0] OP;
  reg [7:0] rABH;
  reg [7:0] rABL;
  reg [7:0] PCH;
  wire setpsr;
  reg ift_run;
  reg do_nmi;
  reg do_irq;
  reg do_brk;
  reg do_res;
  reg int_req;
  reg [5:0] ex_st;
  reg [15:0] dbgreg;
  reg rdflg;
  reg [7:0] dbg_datai;
  reg ex;
  wire [7:0] _alu_in1;
  wire [7:0] _alu_in2;
  wire _alu_ci;
  wire _alu_df;
  wire [7:0] _alu_out;
  wire _alu_s;
  wire _alu_v;
  wire _alu_z;
  wire _alu_c;
  wire _alu_adc;
  wire _alu_sbc;
  wire _alu_do_and;
  wire _alu_bita;
  wire _alu_do_or;
  wire _alu_eor;
  wire _alu_inc;
  wire _alu_dec;
  wire _alu_dec2;
  wire _alu_incc;
  wire _alu_asl;
  wire _alu_lsr;
  wire _alu_ror;
  wire _alu_rol;
  wire _alu_thr;
  wire _alu_p_reset;
  wire _alu_m_clock;
  wire [15:0] _incr_in;
  wire _incr_ci;
  wire [15:0] _incr_out;
  wire _incr_co;
  wire _incr_dox;
  wire _incr_thr;
  wire _incr_p_reset;
  wire _incr_m_clock;
  wire _proc_ift_run_set;
  wire _proc_ift_run_reset;
  wire _net_71;
  wire _proc_do_nmi_set;
  wire _proc_do_nmi_reset;
  wire _net_72;
  wire _proc_do_irq_set;
  wire _proc_do_irq_reset;
  wire _net_73;
  wire _proc_do_brk_set;
  wire _proc_do_brk_reset;
  wire _net_74;
  wire _proc_do_res_set;
  wire _proc_do_res_reset;
  wire _net_75;
  wire _proc_int_req_set;
  wire _proc_int_req_reset;
  wire _net_76;
  wire _proc_ex_set;
  wire _proc_ex_reset;
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
  reg [2:0] _reg_762;
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
inc16 incr (.m_clock(m_clock), .p_reset( p_reset), .thr(_incr_thr), .dox(_incr_dox), .out(_incr_out), .co(_incr_co), .in(_incr_in), .ci(_incr_ci));
alu65 alu (.m_clock(m_clock), .p_reset( p_reset), .thr(_alu_thr), .rol(_alu_rol), .ror(_alu_ror), .lsr(_alu_lsr), .asl(_alu_asl), .incc(_alu_incc), .dec2(_alu_dec2), .dec(_alu_dec), .inc(_alu_inc), .eor(_alu_eor), .do_or(_alu_do_or), .bita(_alu_bita), .do_and(_alu_do_and), .sbc(_alu_sbc), .adc(_alu_adc), .c(_alu_c), .z(_alu_z), .v(_alu_v), .s(_alu_s), .out(_alu_out), .df(_alu_df), .ci(_alu_ci), .in2(_alu_in2), .in1(_alu_in1));

   assign  s1 = (_net_736|(_net_529|(_net_502|(_net_490|(_net_321|(_net_289|(_net_250|(_net_233|(_net_211|_net_180)))))))));
   assign  s2 = (_net_733|(_net_518|(_net_483|(_net_424|(_net_313|(_net_274|(_net_204|_net_173)))))));
   assign  s3 = (_net_471|(_net_304|(_net_272|(_net_195|_net_165))));
   assign  s4 = (_net_508|(_net_496|(_net_474|(_net_460|(_net_454|(_net_427|(_net_403|_net_263)))))));
   assign  s5 = _net_662;
   assign  ifrun = (_net_739|(_net_719|(_net_713|(_net_666|(pf|(dmisc|(dclc|(_net_316|(_net_296|(_net_258|(_net_243|(_net_226|(_net_187|(_net_164|_net_152))))))))))))));
   assign  pf = (_net_742|(_net_658|(_net_652|(_net_636|(_net_617|(_net_601|(_net_592|(_net_578|(_net_571|_net_561)))))))));
   assign  write = (_net_775|(_net_773|(_net_772|(_net_768|(_net_663|(_net_657|(_net_591|(_net_574|(_net_280|(_net_265|(_net_260|(_net_251|_net_235))))))))))));
   assign  read = (_net_785|(_net_781|(_net_748|(_net_722|(_net_660|(_net_641|(_net_620|(_net_604|(_net_595|(_net_564|(_net_532|(_net_521|(_net_511|(_net_505|(_net_499|(_net_493|(_net_486|(_net_477|(_net_463|(_net_433|(_net_406|(_net_318|(_net_306|(_net_298|(_net_291|(_net_282|(_net_253|(_net_213|(_net_197|(_net_189|(_net_182|(_net_167|_net_154))))))))))))))))))))))))))))))));
   assign  decop = ex;
   assign  ea = (_net_707|(_net_692|(_net_653|(_net_637|(_net_618|(_net_602|(_net_593|(_net_579|(_net_572|_net_562)))))))));
   assign  dasl = (_net_126|_net_107);
   assign  dbit = _net_122;
   assign  dclc = _net_105;
   assign  dcmp = _net_128;
   assign  dcpx = (_net_116|_net_110);
   assign  ddec = _net_124;
   assign  dmisc = _net_103;
   assign  djmp = _net_99;
   assign  djsr = _net_97;
   assign  dlda = _net_130;
   assign  dldx = (_net_118|_net_113);
   assign  dnop = (_net_362|(_net_341|(_net_331|_net_329)));
   assign  dora = _net_134;
   assign  dphp = _net_91;
   assign  dplp = _net_89;
   assign  drti = _net_95;
   assign  drts = _net_93;
   assign  dsta = _net_132;
   assign  dstx = _net_120;
   assign  dbc = _net_101;
   assign  mimp = _net_108;
   assign  mimm = (_net_144|(_net_114|_net_111));
   assign  mzpx = _net_138;
   assign  mzpxi = _net_146;
   assign  mzpiy = _net_140;
   assign  mabs = (_net_430|_net_142);
   assign  maby = _net_136;
   assign  rmw = (_net_706|(_net_694|(_net_670|_net_668)));
   assign  nif0 = (dmisc|(dclc|(_net_262|(_net_242|_net_225))));
   assign  nif1 = (_net_783|(_net_752|(_net_501|(pf|(_net_320|_net_300)))));
   assign  nif2 = _net_770;
   assign  psr = ({fn,fv,1'b1,1'b1,fd,fi,fz,fc});
   assign  psri = dbi;
   assign  taken = ((((((((((opc[7:5])==3'b000)&(~fn))|(((opc[7:5])==3'b001)&fn))|(((opc[7:5])==3'b010)&(~fv)))|(((opc[7:5])==3'b011)&fv))|(((opc[7:5])==3'b100)&(~fc)))|(((opc[7:5])==3'b101)&fc))|(((opc[7:5])==3'b110)&(~fz)))|(((opc[7:5])==3'b111)&fz));
   assign  ALU1 = ((_net_664)?RA:8'b0)|
    ((_net_655)?DL:8'b0);
   assign  ABLin = ((_net_779)?8'b11111010:8'b0)|
    (((_net_780|_net_778))?8'b11111110:8'b0)|
    ((_net_777)?8'b11111100:8'b0);
   assign  dbo = ((_net_774)?(psr&({3'b111,(~(do_irq|do_nmi)),4'b1111})):8'b0)|
    (((_net_656|(_net_590|(_net_585|_net_577))))?_alu_out:8'b0)|
    (((_net_772|_net_266))?PCH:8'b0)|
    (((_net_773|_net_261))?PCL:8'b0)|
    ((_net_241)?psr:8'b0)|
    ((_net_238)?RA:8'b0);
   assign  dbi = data;
   assign  opc = OP;
   assign  setpsr = (_net_223|_net_198);
   assign  _alu_in1 = ((_net_726)?PCL:8'b0)|
    (((_net_716|_net_710))?PCH:8'b0)|
    (((_net_702|(_net_698|(_net_688|(_net_684|(_net_679|_net_675))))))?ALU1:8'b0)|
    (((_net_608|(_net_576|(_net_567|(_net_553|(_net_548|(_net_543|(_net_538|(_net_371|_net_365)))))))))?RA:8'b0)|
    (((_net_626|(_net_584|(_net_469|(_net_444|(_net_422|(_net_393|(_net_381|_net_350))))))))?RY:8'b0)|
    (((_net_632|(_net_589|(_net_527|(_net_516|(_net_451|(_net_415|(_net_387|(_net_377|(_net_344|_net_334))))))))))?RX:8'b0)|
    ((_net_302)?rABL:8'b0)|
    (((_net_750|(_net_650|(_net_645|(_net_599|(_net_437|_net_217))))))?dbi:8'b0)|
    (((_net_356|(_net_229|(_net_207|(_net_201|(_net_192|(_net_177|_net_170)))))))?RS:8'b0)|
    (((_net_481|(_net_458|(_net_401|(_net_157|_net_149)))))?DL:8'b0);
   assign  _alu_in2 = (((_net_725|(_net_631|(_net_625|(_net_607|(_net_566|(_net_552|(_net_547|(_net_542|(_net_537|(_net_526|(_net_450|_net_443))))))))))))?dbi:8'b0)|
    (((_net_515|(_net_468|(_net_421|_net_414))))?DL:8'b0)|
    (((_net_774|(_net_773|(_net_772|(_net_285|(_net_268|_net_246))))))?RS:8'b0);
   assign  _alu_ci = (((_net_683|_net_674))?fc:1'b0)|
    ((_net_606)?((~(opc[5]))|fc):1'b0)|
    ((_net_536)?((fc|dcmp)|dcpx):1'b0)|
    (((_net_724|(_net_630|(_net_624|_net_514))))?1'b1:1'b0)|
    (((_net_525|(_net_467|(_net_449|(_net_442|(_net_420|_net_413))))))?1'b0:1'b0)|
    ((_net_400)?tc:1'b0);
   assign  _alu_df = (_net_613|_net_531);
   assign  _alu_adc = (_net_723|(_net_535|(_net_524|(_net_513|(_net_466|(_net_448|(_net_441|(_net_419|_net_412))))))));
   assign  _alu_sbc = (_net_629|(_net_623|_net_605));
   assign  _alu_do_and = _net_546;
   assign  _alu_bita = _net_565;
   assign  _alu_do_or = _net_551;
   assign  _alu_eor = _net_541;
   assign  _alu_inc = (_net_715|(_net_697|(_net_480|(_net_457|(_net_349|(_net_333|(_net_301|(_net_228|(_net_206|(_net_200|(_net_191|(_net_176|(_net_169|(_net_156|_net_148))))))))))))));
   assign  _alu_dec = (_net_709|(_net_701|(_net_392|_net_343)));
   assign  _alu_dec2 = (_net_774|(_net_773|(_net_772|(_net_284|(_net_267|_net_245)))));
   assign  _alu_incc = _net_399;
   assign  _alu_asl = _net_687;
   assign  _alu_lsr = _net_678;
   assign  _alu_ror = _net_673;
   assign  _alu_rol = _net_682;
   assign  _alu_thr = (_net_749|(_net_649|(_net_644|(_net_598|(_net_588|(_net_583|(_net_575|(_net_436|(_net_386|(_net_380|(_net_376|(_net_370|(_net_364|(_net_355|_net_216))))))))))))));
   assign  _alu_p_reset = p_reset;
   assign  _alu_m_clock = m_clock;
   assign  _incr_in = ({PCH,PCL});
   assign  _incr_ci = _net_275;
   assign  _incr_dox = (nif2|(nif1|_net_277));
   assign  _incr_thr = nif0;
   assign  _incr_p_reset = p_reset;
   assign  _incr_m_clock = m_clock;
   assign  _proc_ift_run_set = (_net_799|_net_793);
   assign  _proc_ift_run_reset = (_net_759|(_net_755|_net_753));
   assign  _net_71 = (_proc_ift_run_set|_proc_ift_run_reset);
   assign  _proc_do_nmi_set = _net_86;
   assign  _proc_do_nmi_reset = _net_796;
   assign  _net_72 = (_proc_do_nmi_set|_proc_do_nmi_reset);
   assign  _proc_do_irq_set = _net_83;
   assign  _proc_do_irq_reset = _net_797;
   assign  _net_73 = (_proc_do_irq_set|_proc_do_irq_reset);
   assign  _proc_do_brk_set = _net_754;
   assign  _proc_do_brk_reset = _net_795;
   assign  _net_74 = (_proc_do_brk_set|_proc_do_brk_reset);
   assign  _proc_do_res_set = start;
   assign  _proc_do_res_reset = _net_794;
   assign  _net_75 = (_proc_do_res_set|_proc_do_res_reset);
   assign  _proc_int_req_set = (_net_756|(start|(_net_87|_net_84)));
   assign  _proc_int_req_reset = _net_792;
   assign  _net_76 = (_proc_int_req_set|_proc_int_req_reset);
   assign  _proc_ex_set = (_net_813|(_net_810|(_net_807|(_net_804|(_net_801|_net_760)))));
   assign  _proc_ex_reset = (_net_815|(_net_812|(_net_809|(_net_806|(_net_803|(_net_800|_net_798))))));
   assign  _net_77 = (_proc_ex_set|_proc_ex_reset);
   assign  _net_78 = (1'b0 != 1'b0);
   assign  _net_79 = (1'b0 != 1'b0);
   assign  _net_80 = (write&(1'b1 != 1'b0));
   assign  _net_81 = (write&(1'b1 != 1'b0));
   assign  _net_82 = ((~int_req)&(~fi));
   assign  _net_83 = (irq&_net_82);
   assign  _net_84 = (irq&_net_82);
   assign  _net_85 = ((~int_req)&(~nm1));
   assign  _net_86 = (nmi&_net_85);
   assign  _net_87 = (nmi&_net_85);
   assign  _net_88 = (({(opc[7]),(opc[5:0])})==7'b0101000);
   assign  _net_89 = (decop&_net_88);
   assign  _net_90 = (({(opc[7]),(opc[5:0])})==7'b0001000);
   assign  _net_91 = (decop&_net_90);
   assign  _net_92 = (opc==8'b01100000);
   assign  _net_93 = (decop&_net_92);
   assign  _net_94 = (opc==8'b01000000);
   assign  _net_95 = (decop&_net_94);
   assign  _net_96 = (opc==8'b00100000);
   assign  _net_97 = (decop&_net_96);
   assign  _net_98 = (({(opc[7:6]),(opc[4:0])})==7'b0101100);
   assign  _net_99 = (decop&_net_98);
   assign  _net_100 = ((opc[4:0])==5'b10000);
   assign  _net_101 = (decop&_net_100);
   assign  _net_102 = (({(opc[7]),(opc[3:2]),(opc[0])})==4'b1100);
   assign  _net_103 = (decop&_net_102);
   assign  _net_104 = (({(opc[7]),(opc[4:0])})==6'b011000);
   assign  _net_105 = (decop&_net_104);
   assign  _net_106 = (({(opc[7]),(opc[4:0])})==6'b001010);
   assign  _net_107 = (decop&_net_106);
   assign  _net_108 = (decop&_net_106);
   assign  _net_109 = (({(opc[7:6]),(opc[4:0])})==7'b1100000);
   assign  _net_110 = (decop&_net_109);
   assign  _net_111 = (decop&_net_109);
   assign  _net_112 = (({(opc[7:2]),(opc[0])})==7'b1010000);
   assign  _net_113 = (decop&_net_112);
   assign  _net_114 = (decop&_net_112);
   assign  _net_115 = (({(opc[7:6]),(opc[2:0])})==5'b11100);
   assign  _net_116 = (decop&_net_115);
   assign  _net_117 = (({(opc[7:5]),(opc[2]),(opc[0])})==5'b10110);
   assign  _net_118 = (decop&_net_117);
   assign  _net_119 = (({(opc[7:5]),(opc[2]),(opc[0])})==5'b10010);
   assign  _net_120 = (decop&_net_119);
   assign  _net_121 = (({(opc[7:5]),(opc[2:0])})==6'b001100);
   assign  _net_122 = (decop&_net_121);
   assign  _net_123 = (({(opc[7:6]),(opc[2:0])})==5'b11110);
   assign  _net_124 = (decop&_net_123);
   assign  _net_125 = (({(opc[7]),(opc[2:0])})==4'b0110);
   assign  _net_126 = (decop&_net_125);
   assign  _net_127 = (({(opc[7:6]),(opc[1:0])})==4'b1101);
   assign  _net_128 = (decop&_net_127);
   assign  _net_129 = (({(opc[7:5]),(opc[1:0])})==5'b10101);
   assign  _net_130 = (decop&_net_129);
   assign  _net_131 = (({(opc[7:5]),(opc[1:0])})==5'b10001);
   assign  _net_132 = (decop&_net_131);
   assign  _net_133 = (({(opc[7]),(opc[1:0])})==3'b001);
   assign  _net_134 = (decop&_net_133);
   assign  _net_135 = ((opc[4:3])==2'b11);
   assign  _net_136 = (decop&_net_135);
   assign  _net_137 = ((opc[3:2])==2'b01);
   assign  _net_138 = (decop&_net_137);
   assign  _net_139 = ((opc[4:2])==3'b100);
   assign  _net_140 = (decop&_net_139);
   assign  _net_141 = ((opc[4:2])==3'b011);
   assign  _net_142 = (decop&_net_141);
   assign  _net_143 = ((opc[4:2])==3'b010);
   assign  _net_144 = (decop&_net_143);
   assign  _net_145 = ((opc[4:2])==3'b000);
   assign  _net_146 = (decop&_net_145);
   assign  _net_147 = (ex_st[3]);
   assign  _net_148 = (drts&_net_147);
   assign  _net_149 = (drts&_net_147);
   assign  _net_150 = (drts&_net_147);
   assign  _net_151 = (drts&_net_147);
   assign  _net_152 = (drts&_net_147);
   assign  _net_153 = (ex_st[2]);
   assign  _net_154 = (drts&_net_153);
   assign  _net_155 = ((drts&_net_153)&(rdy != 1'b0));
   assign  _net_156 = ((drts&_net_153)&(rdy != 1'b0));
   assign  _net_157 = ((drts&_net_153)&(rdy != 1'b0));
   assign  _net_158 = ((drts&_net_153)&(rdy != 1'b0));
   assign  _net_159 = ((drts&_net_153)&(rdy != 1'b0));
   assign  _net_160 = ((drts&_net_153)&(rdy != 1'b0));
   assign  _net_161 = ((drts&_net_153)&(rdy != 1'b0));
   assign  _net_162 = (~_alu_c);
   assign  _net_163 = ((drts&_net_153)&(rdy != 1'b0));
   assign  _net_164 = (((drts&_net_153)&(rdy != 1'b0))&_net_162);
   assign  _net_165 = (((drts&_net_153)&(rdy != 1'b0))&(_alu_c != 1'b0));
   assign  _net_166 = (ex_st[1]);
   assign  _net_167 = (drts&_net_166);
   assign  _net_168 = (drts&_net_166);
   assign  _net_169 = ((drts&_net_166)&(rdy != 1'b0));
   assign  _net_170 = ((drts&_net_166)&(rdy != 1'b0));
   assign  _net_171 = ((drts&_net_166)&(rdy != 1'b0));
   assign  _net_172 = ((drts&_net_166)&(rdy != 1'b0));
   assign  _net_173 = ((drts&_net_166)&(rdy != 1'b0));
   assign  _net_174 = (ex_st[0]);
   assign  _net_175 = (drts&_net_174);
   assign  _net_176 = (drts&_net_174);
   assign  _net_177 = (drts&_net_174);
   assign  _net_178 = (drts&_net_174);
   assign  _net_179 = (drts&_net_174);
   assign  _net_180 = (drts&_net_174);
   assign  _net_181 = (ex_st[3]);
   assign  _net_182 = (drti&_net_181);
   assign  _net_183 = ((drti&_net_181)&(rdy != 1'b0));
   assign  _net_184 = ((drti&_net_181)&(rdy != 1'b0));
   assign  _net_185 = ((drti&_net_181)&(rdy != 1'b0));
   assign  _net_186 = ((drti&_net_181)&(rdy != 1'b0));
   assign  _net_187 = ((drti&_net_181)&(rdy != 1'b0));
   assign  _net_188 = (ex_st[2]);
   assign  _net_189 = (drti&_net_188);
   assign  _net_190 = ((drti&_net_188)&(rdy != 1'b0));
   assign  _net_191 = ((drti&_net_188)&(rdy != 1'b0));
   assign  _net_192 = ((drti&_net_188)&(rdy != 1'b0));
   assign  _net_193 = ((drti&_net_188)&(rdy != 1'b0));
   assign  _net_194 = ((drti&_net_188)&(rdy != 1'b0));
   assign  _net_195 = ((drti&_net_188)&(rdy != 1'b0));
   assign  _net_196 = (ex_st[1]);
   assign  _net_197 = (drti&_net_196);
   assign  _net_198 = (drti&_net_196);
   assign  _net_199 = (drti&_net_196);
   assign  _net_200 = ((drti&_net_196)&(rdy != 1'b0));
   assign  _net_201 = ((drti&_net_196)&(rdy != 1'b0));
   assign  _net_202 = ((drti&_net_196)&(rdy != 1'b0));
   assign  _net_203 = ((drti&_net_196)&(rdy != 1'b0));
   assign  _net_204 = ((drti&_net_196)&(rdy != 1'b0));
   assign  _net_205 = (ex_st[0]);
   assign  _net_206 = (drti&_net_205);
   assign  _net_207 = (drti&_net_205);
   assign  _net_208 = (drti&_net_205);
   assign  _net_209 = (drti&_net_205);
   assign  _net_210 = (drti&_net_205);
   assign  _net_211 = (drti&_net_205);
   assign  _net_212 = (ex_st[1]);
   assign  _net_213 = (dplp&_net_212);
   assign  _net_214 = (opc[6]);
   assign  _net_215 = (dplp&_net_212);
   assign  _net_216 = ((dplp&_net_212)&_net_214);
   assign  _net_217 = ((dplp&_net_212)&_net_214);
   assign  _net_218 = ((dplp&_net_212)&_net_214);
   assign  _net_219 = ((dplp&_net_212)&_net_214);
   assign  _net_220 = ((dplp&_net_212)&_net_214);
   assign  _net_221 = (~(opc[6]));
   assign  _net_222 = (dplp&_net_212);
   assign  _net_223 = ((dplp&_net_212)&_net_221);
   assign  _net_224 = ((dplp&_net_212)&_net_221);
   assign  _net_225 = ((dplp&_net_212)&(rdy != 1'b0));
   assign  _net_226 = ((dplp&_net_212)&(rdy != 1'b0));
   assign  _net_227 = (ex_st[0]);
   assign  _net_228 = (dplp&_net_227);
   assign  _net_229 = (dplp&_net_227);
   assign  _net_230 = (dplp&_net_227);
   assign  _net_231 = (dplp&_net_227);
   assign  _net_232 = (dplp&_net_227);
   assign  _net_233 = (dplp&_net_227);
   assign  _net_234 = (ex_st[1]);
   assign  _net_235 = ((dphp&_net_234)&(1'b1 != 1'b0));
   assign  _net_236 = (opc[6]);
   assign  _net_237 = (dphp&_net_234);
   assign  _net_238 = ((dphp&_net_234)&_net_236);
   assign  _net_239 = (~(opc[6]));
   assign  _net_240 = (dphp&_net_234);
   assign  _net_241 = ((dphp&_net_234)&_net_239);
   assign  _net_242 = (dphp&_net_234);
   assign  _net_243 = (dphp&_net_234);
   assign  _net_244 = (ex_st[0]);
   assign  _net_245 = (dphp&_net_244);
   assign  _net_246 = (dphp&_net_244);
   assign  _net_247 = (dphp&_net_244);
   assign  _net_248 = (dphp&_net_244);
   assign  _net_249 = (dphp&_net_244);
   assign  _net_250 = (dphp&_net_244);
   assign  _net_251 = ((dphp&_net_244)&(1'b0 != 1'b0));
   assign  _net_252 = (ex_st[4]);
   assign  _net_253 = (djsr&_net_252);
   assign  _net_254 = ((djsr&_net_252)&(rdy != 1'b0));
   assign  _net_255 = ((djsr&_net_252)&(rdy != 1'b0));
   assign  _net_256 = ((djsr&_net_252)&(rdy != 1'b0));
   assign  _net_257 = ((djsr&_net_252)&(rdy != 1'b0));
   assign  _net_258 = ((djsr&_net_252)&(rdy != 1'b0));
   assign  _net_259 = (ex_st[3]);
   assign  _net_260 = ((djsr&_net_259)&(1'b1 != 1'b0));
   assign  _net_261 = (djsr&_net_259);
   assign  _net_262 = (djsr&_net_259);
   assign  _net_263 = (djsr&_net_259);
   assign  _net_264 = (ex_st[2]);
   assign  _net_265 = (djsr&_net_264);
   assign  _net_266 = (djsr&_net_264);
   assign  _net_267 = (djsr&_net_264);
   assign  _net_268 = (djsr&_net_264);
   assign  _net_269 = (djsr&_net_264);
   assign  _net_270 = (djsr&_net_264);
   assign  _net_271 = (djsr&_net_264);
   assign  _net_272 = (djsr&_net_264);
   assign  _net_273 = (ex_st[1]);
   assign  _net_274 = (djsr&_net_273);
   assign  _net_275 = (djsr&_net_273);
   assign  _net_276 = (djsr&_net_273);
   assign  _net_277 = (djsr&_net_273);
   assign  _net_278 = (djsr&_net_273);
   assign  _net_279 = (djsr&_net_273);
   assign  _net_280 = ((djsr&_net_273)&(1'b0 != 1'b0));
   assign  _net_281 = (ex_st[0]);
   assign  _net_282 = (djsr&_net_281);
   assign  _net_283 = (djsr&_net_281);
   assign  _net_284 = ((djsr&_net_281)&(rdy != 1'b0));
   assign  _net_285 = ((djsr&_net_281)&(rdy != 1'b0));
   assign  _net_286 = ((djsr&_net_281)&(rdy != 1'b0));
   assign  _net_287 = ((djsr&_net_281)&(rdy != 1'b0));
   assign  _net_288 = ((djsr&_net_281)&(rdy != 1'b0));
   assign  _net_289 = ((djsr&_net_281)&(rdy != 1'b0));
   assign  _net_290 = (ex_st[3]);
   assign  _net_291 = (djmp&_net_290);
   assign  _net_292 = ((djmp&_net_290)&(rdy != 1'b0));
   assign  _net_293 = ((djmp&_net_290)&(rdy != 1'b0));
   assign  _net_294 = ((djmp&_net_290)&(rdy != 1'b0));
   assign  _net_295 = ((djmp&_net_290)&(rdy != 1'b0));
   assign  _net_296 = ((djmp&_net_290)&(rdy != 1'b0));
   assign  _net_297 = (ex_st[2]);
   assign  _net_298 = (djmp&_net_297);
   assign  _net_299 = ((djmp&_net_297)&(rdy != 1'b0));
   assign  _net_300 = (((djmp&_net_297)&(rdy != 1'b0))&(1'b0 != 1'b0));
   assign  _net_301 = (((djmp&_net_297)&(rdy != 1'b0))&(~(1'b0 != 1'b0)));
   assign  _net_302 = (((djmp&_net_297)&(rdy != 1'b0))&(~(1'b0 != 1'b0)));
   assign  _net_303 = (((djmp&_net_297)&(rdy != 1'b0))&(~(1'b0 != 1'b0)));
   assign  _net_304 = ((djmp&_net_297)&(rdy != 1'b0));
   assign  _net_305 = (ex_st[1]);
   assign  _net_306 = (djmp&_net_305);
   assign  _net_307 = ((djmp&_net_305)&(rdy != 1'b0));
   assign  _net_308 = ((djmp&_net_305)&(rdy != 1'b0));
   assign  _net_309 = ((djmp&_net_305)&(rdy != 1'b0));
   assign  _net_310 = ((djmp&_net_305)&(rdy != 1'b0));
   assign  _net_311 = (opc[5]);
   assign  _net_312 = ((djmp&_net_305)&(rdy != 1'b0));
   assign  _net_313 = (((djmp&_net_305)&(rdy != 1'b0))&_net_311);
   assign  _net_314 = (~(opc[5]));
   assign  _net_315 = ((djmp&_net_305)&(rdy != 1'b0));
   assign  _net_316 = (((djmp&_net_305)&(rdy != 1'b0))&_net_314);
   assign  _net_317 = (ex_st[0]);
   assign  _net_318 = (djmp&_net_317);
   assign  _net_319 = (djmp&_net_317);
   assign  _net_320 = ((djmp&_net_317)&(rdy != 1'b0));
   assign  _net_321 = ((djmp&_net_317)&(rdy != 1'b0));
   assign  _net_322 = ((opc[6])==1'b1);
   assign  _net_323 = (dclc&_net_322);
   assign  _net_324 = ((opc[6])==1'b0);
   assign  _net_325 = (dclc&_net_324);
   assign  _net_326 = (({(opc[6:4]),(opc[1])})==4'b1111);
   assign  _net_327 = (({(opc[6:4]),(opc[1])})==4'b1110);
   assign  _net_328 = (dmisc&_net_327);
   assign  _net_329 = (dmisc&_net_327);
   assign  _net_330 = (({(opc[6:4]),(opc[1])})==4'b1101);
   assign  _net_331 = (dmisc&_net_330);
   assign  _net_332 = (({(opc[6:4]),(opc[1])})==4'b1100);
   assign  _net_333 = (dmisc&_net_332);
   assign  _net_334 = (dmisc&_net_332);
   assign  _net_335 = (dmisc&_net_332);
   assign  _net_336 = (dmisc&_net_332);
   assign  _net_337 = (dmisc&_net_332);
   assign  _net_338 = (({(opc[6:4]),(opc[1])})==4'b1011);
   assign  _net_339 = (({(opc[6:4]),(opc[1])})==4'b1010);
   assign  _net_340 = (dmisc&_net_339);
   assign  _net_341 = (dmisc&_net_339);
   assign  _net_342 = (({(opc[6:4]),(opc[1])})==4'b1001);
   assign  _net_343 = (dmisc&_net_342);
   assign  _net_344 = (dmisc&_net_342);
   assign  _net_345 = (dmisc&_net_342);
   assign  _net_346 = (dmisc&_net_342);
   assign  _net_347 = (dmisc&_net_342);
   assign  _net_348 = (({(opc[6:4]),(opc[1])})==4'b1000);
   assign  _net_349 = (dmisc&_net_348);
   assign  _net_350 = (dmisc&_net_348);
   assign  _net_351 = (dmisc&_net_348);
   assign  _net_352 = (dmisc&_net_348);
   assign  _net_353 = (dmisc&_net_348);
   assign  _net_354 = (({(opc[6:4]),(opc[1])})==4'b0111);
   assign  _net_355 = (dmisc&_net_354);
   assign  _net_356 = (dmisc&_net_354);
   assign  _net_357 = (dmisc&_net_354);
   assign  _net_358 = (dmisc&_net_354);
   assign  _net_359 = (dmisc&_net_354);
   assign  _net_360 = (({(opc[6:4]),(opc[1])})==4'b0110);
   assign  _net_361 = (dmisc&_net_360);
   assign  _net_362 = (dmisc&_net_360);
   assign  _net_363 = (({(opc[6:4]),(opc[1])})==4'b0101);
   assign  _net_364 = (dmisc&_net_363);
   assign  _net_365 = (dmisc&_net_363);
   assign  _net_366 = (dmisc&_net_363);
   assign  _net_367 = (dmisc&_net_363);
   assign  _net_368 = (dmisc&_net_363);
   assign  _net_369 = (({(opc[6:4]),(opc[1])})==4'b0100);
   assign  _net_370 = (dmisc&_net_369);
   assign  _net_371 = (dmisc&_net_369);
   assign  _net_372 = (dmisc&_net_369);
   assign  _net_373 = (dmisc&_net_369);
   assign  _net_374 = (dmisc&_net_369);
   assign  _net_375 = (({(opc[6:4]),(opc[1])})==4'b0011);
   assign  _net_376 = (dmisc&_net_375);
   assign  _net_377 = (dmisc&_net_375);
   assign  _net_378 = (dmisc&_net_375);
   assign  _net_379 = (({(opc[6:4]),(opc[1])})==4'b0010);
   assign  _net_380 = (dmisc&_net_379);
   assign  _net_381 = (dmisc&_net_379);
   assign  _net_382 = (dmisc&_net_379);
   assign  _net_383 = (dmisc&_net_379);
   assign  _net_384 = (dmisc&_net_379);
   assign  _net_385 = (({(opc[6:4]),(opc[1])})==4'b0001);
   assign  _net_386 = (dmisc&_net_385);
   assign  _net_387 = (dmisc&_net_385);
   assign  _net_388 = (dmisc&_net_385);
   assign  _net_389 = (dmisc&_net_385);
   assign  _net_390 = (dmisc&_net_385);
   assign  _net_391 = (({(opc[6:4]),(opc[1])})==4'b0000);
   assign  _net_392 = (dmisc&_net_391);
   assign  _net_393 = (dmisc&_net_391);
   assign  _net_394 = (dmisc&_net_391);
   assign  _net_395 = (dmisc&_net_391);
   assign  _net_396 = (dmisc&_net_391);
   assign  _net_397 = (ex_st[2]);
   assign  _net_398 = (ea&maby);
   assign  _net_399 = ((ea&maby)&_net_397);
   assign  _net_400 = ((ea&maby)&_net_397);
   assign  _net_401 = ((ea&maby)&_net_397);
   assign  _net_402 = ((ea&maby)&_net_397);
   assign  _net_403 = ((ea&maby)&_net_397);
   assign  _net_404 = (ex_st[1]);
   assign  _net_405 = (ea&maby);
   assign  _net_406 = ((ea&maby)&_net_404);
   assign  _net_407 = ((ea&maby)&_net_404);
   assign  _net_408 = (((ea&maby)&_net_404)&(rdy != 1'b0));
   assign  _net_409 = (((ea&maby)&_net_404)&(rdy != 1'b0));
   assign  _net_410 = ((opc[2])&((~dldx)|(~(opc[1]))));
   assign  _net_411 = (((ea&maby)&_net_404)&(rdy != 1'b0));
   assign  _net_412 = ((((ea&maby)&_net_404)&(rdy != 1'b0))&_net_410);
   assign  _net_413 = ((((ea&maby)&_net_404)&(rdy != 1'b0))&_net_410);
   assign  _net_414 = ((((ea&maby)&_net_404)&(rdy != 1'b0))&_net_410);
   assign  _net_415 = ((((ea&maby)&_net_404)&(rdy != 1'b0))&_net_410);
   assign  _net_416 = ((((ea&maby)&_net_404)&(rdy != 1'b0))&_net_410);
   assign  _net_417 = ((~(opc[2]))|(dldx&(opc[1])));
   assign  _net_418 = (((ea&maby)&_net_404)&(rdy != 1'b0));
   assign  _net_419 = ((((ea&maby)&_net_404)&(rdy != 1'b0))&_net_417);
   assign  _net_420 = ((((ea&maby)&_net_404)&(rdy != 1'b0))&_net_417);
   assign  _net_421 = ((((ea&maby)&_net_404)&(rdy != 1'b0))&_net_417);
   assign  _net_422 = ((((ea&maby)&_net_404)&(rdy != 1'b0))&_net_417);
   assign  _net_423 = ((((ea&maby)&_net_404)&(rdy != 1'b0))&_net_417);
   assign  _net_424 = ((((ea&maby)&_net_404)&(rdy != 1'b0))&_alu_c);
   assign  _net_425 = (~_alu_c);
   assign  _net_426 = (((ea&maby)&_net_404)&(rdy != 1'b0));
   assign  _net_427 = ((((ea&maby)&_net_404)&(rdy != 1'b0))&_net_425);
   assign  _net_428 = (ex_st[0]);
   assign  _net_429 = (ea&maby);
   assign  _net_430 = ((ea&maby)&_net_428);
   assign  _net_431 = (ex_st[0]);
   assign  _net_432 = (ea&mzpx);
   assign  _net_433 = ((ea&mzpx)&_net_431);
   assign  _net_434 = (~(opc[4]));
   assign  _net_435 = (((ea&mzpx)&_net_431)&(rdy != 1'b0));
   assign  _net_436 = ((((ea&mzpx)&_net_431)&(rdy != 1'b0))&_net_434);
   assign  _net_437 = ((((ea&mzpx)&_net_431)&(rdy != 1'b0))&_net_434);
   assign  _net_438 = ((((ea&mzpx)&_net_431)&(rdy != 1'b0))&_net_434);
   assign  _net_439 = (((opc[4])&(dldx|dstx))&(opc[1]));
   assign  _net_440 = (((ea&mzpx)&_net_431)&(rdy != 1'b0));
   assign  _net_441 = ((((ea&mzpx)&_net_431)&(rdy != 1'b0))&_net_439);
   assign  _net_442 = ((((ea&mzpx)&_net_431)&(rdy != 1'b0))&_net_439);
   assign  _net_443 = ((((ea&mzpx)&_net_431)&(rdy != 1'b0))&_net_439);
   assign  _net_444 = ((((ea&mzpx)&_net_431)&(rdy != 1'b0))&_net_439);
   assign  _net_445 = ((((ea&mzpx)&_net_431)&(rdy != 1'b0))&_net_439);
   assign  _net_446 = ((opc[4])&(((~dldx)&(~dstx))|(~(opc[1]))));
   assign  _net_447 = (((ea&mzpx)&_net_431)&(rdy != 1'b0));
   assign  _net_448 = ((((ea&mzpx)&_net_431)&(rdy != 1'b0))&_net_446);
   assign  _net_449 = ((((ea&mzpx)&_net_431)&(rdy != 1'b0))&_net_446);
   assign  _net_450 = ((((ea&mzpx)&_net_431)&(rdy != 1'b0))&_net_446);
   assign  _net_451 = ((((ea&mzpx)&_net_431)&(rdy != 1'b0))&_net_446);
   assign  _net_452 = ((((ea&mzpx)&_net_431)&(rdy != 1'b0))&_net_446);
   assign  _net_453 = (((ea&mzpx)&_net_431)&(rdy != 1'b0));
   assign  _net_454 = (((ea&mzpx)&_net_431)&(rdy != 1'b0));
   assign  _net_455 = (ex_st[3]);
   assign  _net_456 = (ea&mzpiy);
   assign  _net_457 = ((ea&mzpiy)&_net_455);
   assign  _net_458 = ((ea&mzpiy)&_net_455);
   assign  _net_459 = ((ea&mzpiy)&_net_455);
   assign  _net_460 = ((ea&mzpiy)&_net_455);
   assign  _net_461 = (ex_st[2]);
   assign  _net_462 = (ea&mzpiy);
   assign  _net_463 = ((ea&mzpiy)&_net_461);
   assign  _net_464 = (((ea&mzpiy)&_net_461)&(rdy != 1'b0));
   assign  _net_465 = (((ea&mzpiy)&_net_461)&(rdy != 1'b0));
   assign  _net_466 = (((ea&mzpiy)&_net_461)&(rdy != 1'b0));
   assign  _net_467 = (((ea&mzpiy)&_net_461)&(rdy != 1'b0));
   assign  _net_468 = (((ea&mzpiy)&_net_461)&(rdy != 1'b0));
   assign  _net_469 = (((ea&mzpiy)&_net_461)&(rdy != 1'b0));
   assign  _net_470 = (((ea&mzpiy)&_net_461)&(rdy != 1'b0));
   assign  _net_471 = ((((ea&mzpiy)&_net_461)&(rdy != 1'b0))&_alu_c);
   assign  _net_472 = (~_alu_c);
   assign  _net_473 = (((ea&mzpiy)&_net_461)&(rdy != 1'b0));
   assign  _net_474 = ((((ea&mzpiy)&_net_461)&(rdy != 1'b0))&_net_472);
   assign  _net_475 = (ex_st[1]);
   assign  _net_476 = (ea&mzpiy);
   assign  _net_477 = ((ea&mzpiy)&_net_475);
   assign  _net_478 = (((ea&mzpiy)&_net_475)&(rdy != 1'b0));
   assign  _net_479 = (((ea&mzpiy)&_net_475)&(rdy != 1'b0));
   assign  _net_480 = (((ea&mzpiy)&_net_475)&(rdy != 1'b0));
   assign  _net_481 = (((ea&mzpiy)&_net_475)&(rdy != 1'b0));
   assign  _net_482 = (((ea&mzpiy)&_net_475)&(rdy != 1'b0));
   assign  _net_483 = (((ea&mzpiy)&_net_475)&(rdy != 1'b0));
   assign  _net_484 = (ex_st[0]);
   assign  _net_485 = (ea&mzpiy);
   assign  _net_486 = ((ea&mzpiy)&_net_484);
   assign  _net_487 = (((ea&mzpiy)&_net_484)&(rdy != 1'b0));
   assign  _net_488 = (((ea&mzpiy)&_net_484)&(rdy != 1'b0));
   assign  _net_489 = (((ea&mzpiy)&_net_484)&(rdy != 1'b0));
   assign  _net_490 = (((ea&mzpiy)&_net_484)&(rdy != 1'b0));
   assign  _net_491 = (ex_st[1]);
   assign  _net_492 = (ea&mabs);
   assign  _net_493 = ((ea&mabs)&_net_491);
   assign  _net_494 = (((ea&mabs)&_net_491)&(rdy != 1'b0));
   assign  _net_495 = (((ea&mabs)&_net_491)&(rdy != 1'b0));
   assign  _net_496 = (((ea&mabs)&_net_491)&(rdy != 1'b0));
   assign  _net_497 = (ex_st[0]);
   assign  _net_498 = (ea&mabs);
   assign  _net_499 = ((ea&mabs)&_net_497);
   assign  _net_500 = (((ea&mabs)&_net_497)&(rdy != 1'b0));
   assign  _net_501 = (((ea&mabs)&_net_497)&(rdy != 1'b0));
   assign  _net_502 = (((ea&mabs)&_net_497)&(rdy != 1'b0));
   assign  _net_503 = (ex_st[2]);
   assign  _net_504 = (ea&mzpxi);
   assign  _net_505 = ((ea&mzpxi)&_net_503);
   assign  _net_506 = (((ea&mzpxi)&_net_503)&(rdy != 1'b0));
   assign  _net_507 = (((ea&mzpxi)&_net_503)&(rdy != 1'b0));
   assign  _net_508 = (((ea&mzpxi)&_net_503)&(rdy != 1'b0));
   assign  _net_509 = (ex_st[1]);
   assign  _net_510 = (ea&mzpxi);
   assign  _net_511 = ((ea&mzpxi)&_net_509);
   assign  _net_512 = (((ea&mzpxi)&_net_509)&(rdy != 1'b0));
   assign  _net_513 = (((ea&mzpxi)&_net_509)&(rdy != 1'b0));
   assign  _net_514 = (((ea&mzpxi)&_net_509)&(rdy != 1'b0));
   assign  _net_515 = (((ea&mzpxi)&_net_509)&(rdy != 1'b0));
   assign  _net_516 = (((ea&mzpxi)&_net_509)&(rdy != 1'b0));
   assign  _net_517 = (((ea&mzpxi)&_net_509)&(rdy != 1'b0));
   assign  _net_518 = (((ea&mzpxi)&_net_509)&(rdy != 1'b0));
   assign  _net_519 = (ex_st[0]);
   assign  _net_520 = (ea&mzpxi);
   assign  _net_521 = ((ea&mzpxi)&_net_519);
   assign  _net_522 = (((ea&mzpxi)&_net_519)&(rdy != 1'b0));
   assign  _net_523 = (((ea&mzpxi)&_net_519)&(rdy != 1'b0));
   assign  _net_524 = (((ea&mzpxi)&_net_519)&(rdy != 1'b0));
   assign  _net_525 = (((ea&mzpxi)&_net_519)&(rdy != 1'b0));
   assign  _net_526 = (((ea&mzpxi)&_net_519)&(rdy != 1'b0));
   assign  _net_527 = (((ea&mzpxi)&_net_519)&(rdy != 1'b0));
   assign  _net_528 = (((ea&mzpxi)&_net_519)&(rdy != 1'b0));
   assign  _net_529 = (((ea&mzpxi)&_net_519)&(rdy != 1'b0));
   assign  _net_530 = (mimm|(ex_st[4]));
   assign  _net_531 = ((dora&_net_530)&(fd != 1'b0));
   assign  _net_532 = (dora&_net_530);
   assign  _net_533 = ((opc[6:5])==2'b11);
   assign  _net_534 = (dora&_net_530);
   assign  _net_535 = ((dora&_net_530)&_net_533);
   assign  _net_536 = ((dora&_net_530)&_net_533);
   assign  _net_537 = ((dora&_net_530)&_net_533);
   assign  _net_538 = ((dora&_net_530)&_net_533);
   assign  _net_539 = ((opc[6:5])==2'b10);
   assign  _net_540 = (dora&_net_530);
   assign  _net_541 = ((dora&_net_530)&_net_539);
   assign  _net_542 = ((dora&_net_530)&_net_539);
   assign  _net_543 = ((dora&_net_530)&_net_539);
   assign  _net_544 = ((opc[6:5])==2'b01);
   assign  _net_545 = (dora&_net_530);
   assign  _net_546 = ((dora&_net_530)&_net_544);
   assign  _net_547 = ((dora&_net_530)&_net_544);
   assign  _net_548 = ((dora&_net_530)&_net_544);
   assign  _net_549 = ((opc[6:5])==2'b00);
   assign  _net_550 = (dora&_net_530);
   assign  _net_551 = ((dora&_net_530)&_net_549);
   assign  _net_552 = ((dora&_net_530)&_net_549);
   assign  _net_553 = ((dora&_net_530)&_net_549);
   assign  _net_554 = ((dora&_net_530)&(rdy != 1'b0));
   assign  _net_555 = ((dora&_net_530)&(rdy != 1'b0));
   assign  _net_556 = ((opc[6:5])==2'b11);
   assign  _net_557 = ((dora&_net_530)&(rdy != 1'b0));
   assign  _net_558 = (((dora&_net_530)&(rdy != 1'b0))&_net_556);
   assign  _net_559 = (((dora&_net_530)&(rdy != 1'b0))&_net_556);
   assign  _net_560 = ((dora&_net_530)&(rdy != 1'b0));
   assign  _net_561 = ((dora&_net_530)&(rdy != 1'b0));
   assign  _net_562 = (dora&(~_net_530));
   assign  _net_563 = (mimm|(ex_st[4]));
   assign  _net_564 = (dbit&_net_563);
   assign  _net_565 = ((dbit&_net_563)&(rdy != 1'b0));
   assign  _net_566 = ((dbit&_net_563)&(rdy != 1'b0));
   assign  _net_567 = ((dbit&_net_563)&(rdy != 1'b0));
   assign  _net_568 = ((dbit&_net_563)&(rdy != 1'b0));
   assign  _net_569 = ((dbit&_net_563)&(rdy != 1'b0));
   assign  _net_570 = ((dbit&_net_563)&(rdy != 1'b0));
   assign  _net_571 = ((dbit&_net_563)&(rdy != 1'b0));
   assign  _net_572 = (dbit&(~_net_563));
   assign  _net_573 = ((ex_st[4])|(ex_st[5]));
   assign  _net_574 = ((dsta&_net_573)&(1'b1 != 1'b0));
   assign  _net_575 = (dsta&_net_573);
   assign  _net_576 = (dsta&_net_573);
   assign  _net_577 = (dsta&_net_573);
   assign  _net_578 = (dsta&_net_573);
   assign  _net_579 = (dsta&(~_net_573));
   assign  _net_580 = ((ex_st[4])|(ex_st[5]));
   assign  _net_581 = (~(opc[1]));
   assign  _net_582 = (dstx&_net_580);
   assign  _net_583 = ((dstx&_net_580)&_net_581);
   assign  _net_584 = ((dstx&_net_580)&_net_581);
   assign  _net_585 = ((dstx&_net_580)&_net_581);
   assign  _net_586 = (opc[1]);
   assign  _net_587 = (dstx&_net_580);
   assign  _net_588 = ((dstx&_net_580)&_net_586);
   assign  _net_589 = ((dstx&_net_580)&_net_586);
   assign  _net_590 = ((dstx&_net_580)&_net_586);
   assign  _net_591 = ((dstx&_net_580)&(1'b1 != 1'b0));
   assign  _net_592 = (dstx&_net_580);
   assign  _net_593 = (dstx&(~_net_580));
   assign  _net_594 = (mimm|(ex_st[4]));
   assign  _net_595 = (dlda&_net_594);
   assign  _net_596 = ((dlda&_net_594)&(rdy != 1'b0));
   assign  _net_597 = ((dlda&_net_594)&(rdy != 1'b0));
   assign  _net_598 = ((dlda&_net_594)&(rdy != 1'b0));
   assign  _net_599 = ((dlda&_net_594)&(rdy != 1'b0));
   assign  _net_600 = ((dlda&_net_594)&(rdy != 1'b0));
   assign  _net_601 = ((dlda&_net_594)&(rdy != 1'b0));
   assign  _net_602 = (dlda&(~_net_594));
   assign  _net_603 = (mimm|(ex_st[4]));
   assign  _net_604 = (dcmp&_net_603);
   assign  _net_605 = ((dcmp&_net_603)&(rdy != 1'b0));
   assign  _net_606 = ((dcmp&_net_603)&(rdy != 1'b0));
   assign  _net_607 = ((dcmp&_net_603)&(rdy != 1'b0));
   assign  _net_608 = ((dcmp&_net_603)&(rdy != 1'b0));
   assign  _net_609 = (opc[5]);
   assign  _net_610 = ((dcmp&_net_603)&(rdy != 1'b0));
   assign  _net_611 = (((dcmp&_net_603)&(rdy != 1'b0))&_net_609);
   assign  _net_612 = (((dcmp&_net_603)&(rdy != 1'b0))&_net_609);
   assign  _net_613 = ((((dcmp&_net_603)&(rdy != 1'b0))&_net_609)&(fd != 1'b0));
   assign  _net_614 = ((dcmp&_net_603)&(rdy != 1'b0));
   assign  _net_615 = ((dcmp&_net_603)&(rdy != 1'b0));
   assign  _net_616 = ((dcmp&_net_603)&(rdy != 1'b0));
   assign  _net_617 = ((dcmp&_net_603)&(rdy != 1'b0));
   assign  _net_618 = (dcmp&(~_net_603));
   assign  _net_619 = (mimm|(ex_st[4]));
   assign  _net_620 = (dcpx&_net_619);
   assign  _net_621 = (~(opc[5]));
   assign  _net_622 = ((dcpx&_net_619)&(rdy != 1'b0));
   assign  _net_623 = (((dcpx&_net_619)&(rdy != 1'b0))&_net_621);
   assign  _net_624 = (((dcpx&_net_619)&(rdy != 1'b0))&_net_621);
   assign  _net_625 = (((dcpx&_net_619)&(rdy != 1'b0))&_net_621);
   assign  _net_626 = (((dcpx&_net_619)&(rdy != 1'b0))&_net_621);
   assign  _net_627 = (opc[5]);
   assign  _net_628 = ((dcpx&_net_619)&(rdy != 1'b0));
   assign  _net_629 = (((dcpx&_net_619)&(rdy != 1'b0))&_net_627);
   assign  _net_630 = (((dcpx&_net_619)&(rdy != 1'b0))&_net_627);
   assign  _net_631 = (((dcpx&_net_619)&(rdy != 1'b0))&_net_627);
   assign  _net_632 = (((dcpx&_net_619)&(rdy != 1'b0))&_net_627);
   assign  _net_633 = ((dcpx&_net_619)&(rdy != 1'b0));
   assign  _net_634 = ((dcpx&_net_619)&(rdy != 1'b0));
   assign  _net_635 = ((dcpx&_net_619)&(rdy != 1'b0));
   assign  _net_636 = ((dcpx&_net_619)&(rdy != 1'b0));
   assign  _net_637 = (dcpx&(~_net_619));
   assign  _net_638 = (mimm|(ex_st[4]));
   assign  _net_639 = (dldx&_net_638);
   assign  _net_640 = (dldx&_net_638);
   assign  _net_641 = (dldx&_net_638);
   assign  _net_642 = (~(opc[1]));
   assign  _net_643 = ((dldx&_net_638)&(rdy != 1'b0));
   assign  _net_644 = (((dldx&_net_638)&(rdy != 1'b0))&_net_642);
   assign  _net_645 = (((dldx&_net_638)&(rdy != 1'b0))&_net_642);
   assign  _net_646 = (((dldx&_net_638)&(rdy != 1'b0))&_net_642);
   assign  _net_647 = (opc[1]);
   assign  _net_648 = ((dldx&_net_638)&(rdy != 1'b0));
   assign  _net_649 = (((dldx&_net_638)&(rdy != 1'b0))&_net_647);
   assign  _net_650 = (((dldx&_net_638)&(rdy != 1'b0))&_net_647);
   assign  _net_651 = (((dldx&_net_638)&(rdy != 1'b0))&_net_647);
   assign  _net_652 = ((dldx&_net_638)&(rdy != 1'b0));
   assign  _net_653 = (dldx&(~_net_638));
   assign  _net_654 = (ex_st[5]);
   assign  _net_655 = (rmw&_net_654);
   assign  _net_656 = (rmw&_net_654);
   assign  _net_657 = ((rmw&_net_654)&(1'b1 != 1'b0));
   assign  _net_658 = (rmw&_net_654);
   assign  _net_659 = (ex_st[4]);
   assign  _net_660 = (rmw&_net_659);
   assign  _net_661 = ((rmw&_net_659)&(rdy != 1'b0));
   assign  _net_662 = ((rmw&_net_659)&(rdy != 1'b0));
   assign  _net_663 = (((rmw&_net_659)&(rdy != 1'b0))&(1'b0 != 1'b0));
   assign  _net_664 = (rmw&mimp);
   assign  _net_665 = (rmw&mimp);
   assign  _net_666 = (rmw&mimp);
   assign  _net_667 = (ex_st[4]);
   assign  _net_668 = (dasl&_net_667);
   assign  _net_669 = (mimp|(ex_st[5]));
   assign  _net_670 = (dasl&_net_669);
   assign  _net_671 = ((opc[6:5])==2'b11);
   assign  _net_672 = (dasl&_net_669);
   assign  _net_673 = ((dasl&_net_669)&_net_671);
   assign  _net_674 = ((dasl&_net_669)&_net_671);
   assign  _net_675 = ((dasl&_net_669)&_net_671);
   assign  _net_676 = ((opc[6:5])==2'b10);
   assign  _net_677 = (dasl&_net_669);
   assign  _net_678 = ((dasl&_net_669)&_net_676);
   assign  _net_679 = ((dasl&_net_669)&_net_676);
   assign  _net_680 = ((opc[6:5])==2'b01);
   assign  _net_681 = (dasl&_net_669);
   assign  _net_682 = ((dasl&_net_669)&_net_680);
   assign  _net_683 = ((dasl&_net_669)&_net_680);
   assign  _net_684 = ((dasl&_net_669)&_net_680);
   assign  _net_685 = ((opc[6:5])==2'b00);
   assign  _net_686 = (dasl&_net_669);
   assign  _net_687 = ((dasl&_net_669)&_net_685);
   assign  _net_688 = ((dasl&_net_669)&_net_685);
   assign  _net_689 = (dasl&_net_669);
   assign  _net_690 = (dasl&_net_669);
   assign  _net_691 = (dasl&_net_669);
   assign  _net_692 = ((dasl&(~_net_667))&(~_net_669));
   assign  _net_693 = (ex_st[5]);
   assign  _net_694 = (ddec&_net_693);
   assign  _net_695 = (opc[5]);
   assign  _net_696 = (ddec&_net_693);
   assign  _net_697 = ((ddec&_net_693)&_net_695);
   assign  _net_698 = ((ddec&_net_693)&_net_695);
   assign  _net_699 = (~(opc[5]));
   assign  _net_700 = (ddec&_net_693);
   assign  _net_701 = ((ddec&_net_693)&_net_699);
   assign  _net_702 = ((ddec&_net_693)&_net_699);
   assign  _net_703 = (ddec&_net_693);
   assign  _net_704 = (ddec&_net_693);
   assign  _net_705 = (ex_st[4]);
   assign  _net_706 = (ddec&_net_705);
   assign  _net_707 = ((ddec&(~_net_693))&(~_net_705));
   assign  _net_708 = (ex_st[2]);
   assign  _net_709 = (dbc&_net_708);
   assign  _net_710 = (dbc&_net_708);
   assign  _net_711 = (dbc&_net_708);
   assign  _net_712 = (dbc&_net_708);
   assign  _net_713 = (dbc&_net_708);
   assign  _net_714 = (ex_st[1]);
   assign  _net_715 = (dbc&_net_714);
   assign  _net_716 = (dbc&_net_714);
   assign  _net_717 = (dbc&_net_714);
   assign  _net_718 = (dbc&_net_714);
   assign  _net_719 = (dbc&_net_714);
   assign  _net_720 = (ex_st[0]);
   assign  _net_721 = (dbc&_net_720);
   assign  _net_722 = (dbc&_net_720);
   assign  _net_723 = (((dbc&_net_720)&taken)&(rdy != 1'b0));
   assign  _net_724 = (((dbc&_net_720)&taken)&(rdy != 1'b0));
   assign  _net_725 = (((dbc&_net_720)&taken)&(rdy != 1'b0));
   assign  _net_726 = (((dbc&_net_720)&taken)&(rdy != 1'b0));
   assign  _net_727 = (((dbc&_net_720)&taken)&(rdy != 1'b0));
   assign  _net_728 = (((dbc&_net_720)&taken)&(rdy != 1'b0));
   assign  _net_729 = (_alu_c^(data[7]));
   assign  _net_730 = (((dbc&_net_720)&taken)&(rdy != 1'b0));
   assign  _net_731 = (data[7]);
   assign  _net_732 = ((((dbc&_net_720)&taken)&(rdy != 1'b0))&_net_729);
   assign  _net_733 = (((((dbc&_net_720)&taken)&(rdy != 1'b0))&_net_729)&_net_731);
   assign  _net_734 = (~(data[7]));
   assign  _net_735 = ((((dbc&_net_720)&taken)&(rdy != 1'b0))&_net_729);
   assign  _net_736 = (((((dbc&_net_720)&taken)&(rdy != 1'b0))&_net_729)&_net_734);
   assign  _net_737 = ((~_alu_c)^(data[7]));
   assign  _net_738 = (((dbc&_net_720)&taken)&(rdy != 1'b0));
   assign  _net_739 = ((((dbc&_net_720)&taken)&(rdy != 1'b0))&_net_737);
   assign  _net_740 = (~taken);
   assign  _net_741 = (dbc&_net_720);
   assign  _net_742 = ((dbc&_net_720)&_net_740);
   assign  _net_743 = (~int_req);
   assign  _net_744 = (~nmi);
   assign  _net_745 = (ift_run&_net_743);
   assign  _net_746 = ((ift_run&_net_743)&_net_744);
   assign  _net_747 = (ift_run&_net_743);
   assign  _net_748 = (ift_run&_net_743);
   assign  _net_749 = (ift_run&_net_743);
   assign  _net_750 = (ift_run&_net_743);
   assign  _net_751 = (ift_run&_net_743);
   assign  _net_752 = ((ift_run&_net_743)&(rdy != 1'b0));
   assign  _net_753 = (((ift_run&_net_743)&(rdy != 1'b0))&_alu_z);
   assign  _net_754 = (((ift_run&_net_743)&(rdy != 1'b0))&_alu_z);
   assign  _net_755 = (((ift_run&_net_743)&(rdy != 1'b0))&_alu_z);
   assign  _net_756 = (((ift_run&_net_743)&(rdy != 1'b0))&_alu_z);
   assign  _net_757 = (~_alu_z);
   assign  _net_758 = ((ift_run&_net_743)&(rdy != 1'b0));
   assign  _net_759 = (((ift_run&_net_743)&(rdy != 1'b0))&_net_757);
   assign  _net_760 = (((ift_run&_net_743)&(rdy != 1'b0))&_net_757);
   assign  _net_761 = (((ift_run&_net_743)&(rdy != 1'b0))&_net_757);
   assign  _net_763 = ((_reg_762==_state__reg_762_st0)&int_req);
   assign  _net_764 = ((ift_run&(do_irq|do_nmi))|do_brk);
   assign  _net_765 = ((_net_763&_net_764)&(do_nmi != 1'b0));
   assign  _net_766 = (_net_763&_net_764);
   assign  _net_767 = (_net_763&_net_764);
   assign  _net_768 = ((_net_763&_net_764)&(1'b0 != 1'b0));
   assign  _net_769 = (_net_763&_net_764);
   assign  _net_770 = (_net_763&do_brk);
   assign  _net_771 = (_net_763&do_res);
   assign  _net_772 = ((_reg_762==_state__reg_762_st1)&int_req);
   assign  _net_773 = ((_reg_762==_state__reg_762_st2)&int_req);
   assign  _net_774 = ((_reg_762==_state__reg_762_st3)&int_req);
   assign  _net_775 = (_net_774&(1'b1 != 1'b0));
   assign  _net_776 = ((_reg_762==_state__reg_762_st4)&int_req);
   assign  _net_777 = (_net_776&do_res);
   assign  _net_778 = ((_net_776&(~do_res))&do_brk);
   assign  _net_779 = (((_net_776&(~do_res))&(~do_brk))&do_nmi);
   assign  _net_780 = ((((_net_776&(~do_res))&(~do_brk))&(~do_nmi))&do_irq);
   assign  _net_781 = ((_reg_762==_state__reg_762_st5)&int_req);
   assign  _net_782 = (_net_781&(rdy != 1'b0));
   assign  _net_783 = (_net_781&(rdy != 1'b0));
   assign  _net_784 = (_net_781&(rdy != 1'b0));
   assign  _net_785 = ((_reg_762==_state__reg_762_st6)&int_req);
   assign  _net_786 = (_net_785&(rdy != 1'b0));
   assign  _net_787 = (_net_785&(rdy != 1'b0));
   assign  _net_788 = (_net_785&(rdy != 1'b0));
   assign  _net_789 = (_net_785&(rdy != 1'b0));
   assign  _net_790 = (_net_785&(rdy != 1'b0));
   assign  _net_791 = (_net_785&(rdy != 1'b0));
   assign  _net_792 = (_net_785&(rdy != 1'b0));
   assign  _net_793 = (_net_785&(rdy != 1'b0));
   assign  _net_794 = ((_net_785&(rdy != 1'b0))&do_res);
   assign  _net_795 = (((_net_785&(rdy != 1'b0))&(~do_res))&do_brk);
   assign  _net_796 = ((((_net_785&(rdy != 1'b0))&(~do_res))&(~do_brk))&do_nmi);
   assign  _net_797 = (((((_net_785&(rdy != 1'b0))&(~do_res))&(~do_brk))&(~do_nmi))&do_irq);
   assign  _net_798 = (ex&ifrun);
   assign  _net_799 = (ex&ifrun);
   assign  _net_800 = (ex&s5);
   assign  _net_801 = (ex&s5);
   assign  _net_802 = (ex&s5);
   assign  _net_803 = (ex&s4);
   assign  _net_804 = (ex&s4);
   assign  _net_805 = (ex&s4);
   assign  _net_806 = (ex&s3);
   assign  _net_807 = (ex&s3);
   assign  _net_808 = (ex&s3);
   assign  _net_809 = (ex&s2);
   assign  _net_810 = (ex&s2);
   assign  _net_811 = (ex&s2);
   assign  _net_812 = (ex&s1);
   assign  _net_813 = (ex&s1);
   assign  _net_814 = (ex&s1);
   assign  _net_815 = ((((((ex&(~ifrun))&(~s5))&(~s4))&(~s3))&(~s2))&(~s1));
   assign  datao = dbo;
   assign  adrs = ({(rABH&8'b11111111),rABL});
   assign  debug = ({PCH,PCL});
   assign  rd = read;
   assign  wt = (_net_80|_net_78);
   assign  sync = _net_747;
always @(posedge m_clock or negedge p_reset)
  begin
if (~p_reset)
     fn <= 1'b0;
else if (((_net_704|(_net_690|(_net_640|(_net_634|(_net_615|(_net_597|(_net_569|(_net_555|(_net_396|(_net_390|(_net_384|(_net_374|(_net_368|(_net_359|(_net_353|(_net_347|(_net_337|_net_219))))))))))))))))))|(setpsr)) 
      fn <= (((_net_704|(_net_690|(_net_640|(_net_634|(_net_615|(_net_597|(_net_569|(_net_555|(_net_396|(_net_390|(_net_384|(_net_374|(_net_368|(_net_359|(_net_353|(_net_347|(_net_337|_net_219)))))))))))))))))) ?_alu_s:1'b0)|
    ((setpsr) ?(psri[7]):1'b0);

end
always @(posedge m_clock or negedge p_reset)
  begin
if (~p_reset)
     fv <= 1'b0;
else if (((_net_612|(_net_570|_net_559)))|(_net_361)|(setpsr)) 
      fv <= (((_net_612|(_net_570|_net_559))) ?_alu_v:1'b0)|
    ((_net_361) ?1'b0:1'b0)|
    ((setpsr) ?(psri[6]):1'b0);

end
always @(posedge m_clock or negedge p_reset)
  begin
if (~p_reset)
     fd <= 1'b0;
else if ((_net_340)|(_net_328)|(setpsr)) 
      fd <= ((_net_340) ?1'b0:1'b0)|
    ((_net_328) ?1'b1:1'b0)|
    ((setpsr) ?(psri[3]):1'b0);

end
always @(posedge m_clock or negedge p_reset)
  begin
if (~p_reset)
     fz <= 1'b0;
else if (((_net_703|(_net_689|(_net_639|(_net_633|(_net_614|(_net_596|(_net_568|(_net_554|(_net_395|(_net_389|(_net_383|(_net_373|(_net_367|(_net_358|(_net_352|(_net_346|(_net_336|_net_220))))))))))))))))))|(setpsr)) 
      fz <= (((_net_703|(_net_689|(_net_639|(_net_633|(_net_614|(_net_596|(_net_568|(_net_554|(_net_395|(_net_389|(_net_383|(_net_373|(_net_367|(_net_358|(_net_352|(_net_346|(_net_336|_net_220)))))))))))))))))) ?_alu_z:1'b0)|
    ((setpsr) ?(psri[1]):1'b0);

end
always @(posedge m_clock or negedge p_reset)
  begin
if (~p_reset)
     fc <= 1'b0;
else if (((_net_691|(_net_635|(_net_616|_net_558))))|(_net_325)|(setpsr)) 
      fc <= (((_net_691|(_net_635|(_net_616|_net_558)))) ?_alu_c:1'b0)|
    ((_net_325) ?(opc[5]):1'b0)|
    ((setpsr) ?(psri[0]):1'b0);

end
always @(posedge m_clock or negedge p_reset)
  begin
if (~p_reset)
     fi <= 1'b1;
else if ((_net_790)|(_net_323)|(setpsr)) 
      fi <= ((_net_790) ?1'b1:1'b0)|
    ((_net_323) ?(opc[5]):1'b0)|
    ((setpsr) ?(psri[2]):1'b0);

end
always @(posedge m_clock)
  begin
  swt <= 1'b0;
end
always @(posedge m_clock or negedge p_reset)
  begin
if (~p_reset)
     nm1 <= 1'b0;
else if ((_net_765)|(_net_746)) 
      nm1 <= ((_net_765) ?1'b1:1'b0)|
    ((_net_746) ?1'b0:1'b0);

end
always @(posedge m_clock)
  begin
if ((_net_407)) 
      tc <= _alu_c;
end
always @(posedge m_clock)
  begin
if (((_net_646|(_net_394|(_net_372|_net_351))))) 
      RY <= _alu_out;
end
always @(posedge m_clock)
  begin
if (((_net_651|(_net_366|(_net_357|(_net_345|_net_335)))))) 
      RX <= _alu_out;
end
always @(posedge m_clock or negedge p_reset)
  begin
if (~p_reset)
     RS <= 8'b11111111;
else if (((_net_774|(_net_773|(_net_772|(_net_378|(_net_286|(_net_269|(_net_247|(_net_230|(_net_208|(_net_203|(_net_194|(_net_179|_net_172)))))))))))))) 
      RS <= _alu_out;
end
always @(posedge m_clock)
  begin
if (((_net_665|(_net_611|(_net_600|(_net_560|(_net_388|(_net_382|_net_218)))))))) 
      RA <= _alu_out;
end
always @(posedge m_clock)
  begin
if ((_net_776)|((nif2|(nif1|_net_279)))|((_net_787|(_net_307|(_net_294|(_net_256|_net_186)))))|((_net_728|_net_158))) 
      PCL <= ((_net_776) ?ABLin:8'b0)|
    (((nif2|(nif1|_net_279))) ?(_incr_out[7:0]):8'b0)|
    (((_net_787|(_net_307|(_net_294|(_net_256|_net_186))))) ?DL:8'b0)|
    (((_net_728|_net_158)) ?_alu_out:8'b0);

end
always @(posedge m_clock)
  begin
if (((_net_782|(_net_661|(_net_522|(_net_512|(_net_500|(_net_487|(_net_478|(_net_464|(_net_408|(_net_319|(_net_299|(_net_283|(_net_190|(_net_168|_net_155)))))))))))))))) 
      DL <= dbi;
end
always @(posedge m_clock)
  begin
if ((_net_751)) 
      OP <= dbi;
end
always @(posedge m_clock)
  begin
if ((_net_776)|((_net_523|(_net_488|(_net_479|_net_453))))|((nif1|nif0))|((_net_766|(_net_287|(_net_270|(_net_248|(_net_231|(_net_209|_net_175)))))))|((_net_788|(_net_506|(_net_494|(_net_465|(_net_409|(_net_310|(_net_293|(_net_255|(_net_183|_net_161))))))))))|((_net_718|(_net_712|(_net_459|(_net_402|_net_151)))))) 
      rABH <= ((_net_776) ?8'b11111111:8'b0)|
    (((_net_523|(_net_488|(_net_479|_net_453)))) ?(8'b00000000&8'b11111111):8'b0)|
    (((nif1|nif0)) ?((_incr_out[15:8])&8'b11111111):8'b0)|
    (((_net_766|(_net_287|(_net_270|(_net_248|(_net_231|(_net_209|_net_175))))))) ?(8'b00000001&8'b11111111):8'b0)|
    (((_net_788|(_net_506|(_net_494|(_net_465|(_net_409|(_net_310|(_net_293|(_net_255|(_net_183|_net_161)))))))))) ?(dbi&8'b11111111):8'b0)|
    (((_net_718|(_net_712|(_net_459|(_net_402|_net_151))))) ?(_alu_out&8'b11111111):8'b0);

end
always @(posedge m_clock)
  begin
if ((_net_776)|(_net_489)|((nif1|nif0))|((_net_767|(_net_288|(_net_271|_net_249))))|((_net_789|(_net_507|(_net_495|(_net_309|(_net_292|(_net_254|_net_184)))))))|((_net_774|(_net_773|(_net_772|(_net_727|(_net_528|(_net_517|(_net_482|(_net_470|(_net_452|(_net_445|(_net_438|(_net_423|(_net_416|(_net_303|(_net_232|(_net_210|(_net_202|(_net_193|(_net_178|(_net_171|_net_159)))))))))))))))))))))) 
      rABL <= ((_net_776) ?ABLin:8'b0)|
    ((_net_489) ?dbi:8'b0)|
    (((nif1|nif0)) ?(_incr_out[7:0]):8'b0)|
    (((_net_767|(_net_288|(_net_271|_net_249)))) ?RS:8'b0)|
    (((_net_789|(_net_507|(_net_495|(_net_309|(_net_292|(_net_254|_net_184))))))) ?DL:8'b0)|
    (((_net_774|(_net_773|(_net_772|(_net_727|(_net_528|(_net_517|(_net_482|(_net_470|(_net_452|(_net_445|(_net_438|(_net_423|(_net_416|(_net_303|(_net_232|(_net_210|(_net_202|(_net_193|(_net_178|(_net_171|_net_159))))))))))))))))))))) ?_alu_out:8'b0);

end
always @(posedge m_clock)
  begin
if ((_net_776)|((nif2|(nif1|_net_276)))|((_net_786|(_net_308|(_net_295|(_net_257|(_net_185|_net_160))))))|((_net_717|(_net_711|_net_150)))) 
      PCH <= ((_net_776) ?8'b11111111:8'b0)|
    (((nif2|(nif1|_net_276))) ?((_incr_out[15:8])&8'b11111111):8'b0)|
    (((_net_786|(_net_308|(_net_295|(_net_257|(_net_185|_net_160)))))) ?(dbi&8'b11111111):8'b0)|
    (((_net_717|(_net_711|_net_150))) ?(_alu_out&8'b11111111):8'b0);

end
always @(posedge m_clock or negedge p_reset)
  begin
if (~p_reset)
     ift_run <= 1'b0;
else if ((_net_71)) 
      ift_run <= _proc_ift_run_set;
end
always @(posedge m_clock or negedge p_reset)
  begin
if (~p_reset)
     do_nmi <= 1'b0;
else if ((_net_72)) 
      do_nmi <= _proc_do_nmi_set;
end
always @(posedge m_clock or negedge p_reset)
  begin
if (~p_reset)
     do_irq <= 1'b0;
else if ((_net_73)) 
      do_irq <= _proc_do_irq_set;
end
always @(posedge m_clock or negedge p_reset)
  begin
if (~p_reset)
     do_brk <= 1'b0;
else if ((_net_74)) 
      do_brk <= _proc_do_brk_set;
end
always @(posedge m_clock or negedge p_reset)
  begin
if (~p_reset)
     do_res <= 1'b0;
else if ((_net_75)) 
      do_res <= _proc_do_res_set;
end
always @(posedge m_clock or negedge p_reset)
  begin
if (~p_reset)
     int_req <= 1'b0;
else if ((_net_76)) 
      int_req <= _proc_int_req_set;
end
always @(posedge m_clock)
  begin
if ((_net_814)|(_net_811)|(_net_808)|(_net_805)|(_net_802)|(_net_761)) 
      ex_st <= ((_net_814) ?6'b000010:6'b0)|
    ((_net_811) ?6'b000100:6'b0)|
    ((_net_808) ?6'b001000:6'b0)|
    ((_net_805) ?6'b010000:6'b0)|
    ((_net_802) ?6'b100000:6'b0)|
    ((_net_761) ?6'b000001:6'b0);

end
always @(posedge m_clock)
  begin
if ((_net_776)) 
      dbgreg <= ({PCH,PCL});
end
always @(posedge m_clock or negedge p_reset)
  begin
if (~p_reset)
     rdflg <= 1'b0;
else if ((start)) 
      rdflg <= 1'b1;
end
always @(posedge m_clock)
  begin
  dbg_datai <= data;
end
always @(posedge m_clock or negedge p_reset)
  begin
if (~p_reset)
     ex <= 1'b0;
else if ((_net_77)) 
      ex <= _proc_ex_set;
end
always @(posedge m_clock or negedge p_reset)
  begin
if (~p_reset)
     _reg_762 <= 3'b000;
else if ((_net_791)|(_net_784)|(_net_776)|(_net_773)|(_net_772)|((_net_774|_net_771))|(_net_769)) 
      _reg_762 <= ((_net_791) ?_state__reg_762_st0:3'b0)|
    ((_net_784) ?_state__reg_762_st6:3'b0)|
    ((_net_776) ?_state__reg_762_st5:3'b0)|
    ((_net_773) ?_state__reg_762_st3:3'b0)|
    ((_net_772) ?_state__reg_762_st2:3'b0)|
    (((_net_774|_net_771)) ?_state__reg_762_st4:3'b0)|
    ((_net_769) ?_state__reg_762_st1:3'b0);

end
endmodule

/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Mon Jun  3 09:43:16 2024
 Licensed to :EVALUATION USER*/
