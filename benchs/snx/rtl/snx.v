/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 22:48:42 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module type_dec ( p_reset , m_clock , op , ctype , rtype , itype , dec );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [3:0] op;
  wire [3:0] op;
  output ctype;
  wire ctype;
  output rtype;
  wire rtype;
  output itype;
  wire itype;
  input dec;
  wire dec;
  wire _net_0;
  wire _net_1;
  wire _net_2;
  wire _net_3;
  wire _net_4;

   assign  _net_0 = (op==4'b0001);
   assign  _net_1 = (dec&_net_0);
   assign  _net_2 = (op==4'b0000);
   assign  _net_3 = (dec&_net_2);
   assign  _net_4 = ((dec&(~_net_0))&(~_net_2));
   assign  itype = _net_4;
   assign  rtype = _net_3;
   assign  ctype = _net_1;
endmodule
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 22:48:42 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 22:48:42 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module snx ( p_reset , m_clock , inst , datai , datao , iadrs , adrs , start , IntReq , inst_ok , mem_ok , inst_adr , inst_read , memory_adr , memory_read , memory_write , IntAck , wb , hlt  );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [15:0] inst;
  wire [15:0] inst;
  input [15:0] datai;
  wire [15:0] datai;
  output [15:0] datao;
  wire [15:0] datao;
  output [15:0] iadrs;
  wire [15:0] iadrs;
  output [15:0] adrs;
  wire [15:0] adrs;
  input start;
  wire start;
  input IntReq;
  wire IntReq;
  input inst_ok;
  wire inst_ok;
  input mem_ok;
  wire mem_ok;
  output inst_adr;
  wire inst_adr;
  output inst_read;
  wire inst_read;
  output memory_adr;
  wire memory_adr;
  output memory_read;
  wire memory_read;
  output memory_write;
  wire memory_write;
  output IntAck;
  wire IntAck;
  output wb;
  wire wb;
  output hlt;
  wire hlt;
  reg [15:0] pc;
  reg isr;
  reg [5:0] _opreg_fn;
  reg [1:0] _opreg_r1;
  reg [1:0] _opreg_r3;
  reg [1:0] _opreg_r2;
  reg [3:0] _opreg_op;
  reg [15:0] mar;
  reg [1:0] regnum;
  reg [15:0] cr0;
  reg [15:0] cr1;
  reg [15:0] cr2;
  reg [15:0] cr3;
  reg int0;
  reg int1;
  wire [15:0] npc;
  wire [15:0] nmar;
  wire [1:0] nregnum;
  wire [7:0] crnum;
  wire [15:0] crwdat;
  wire [15:0] crrdat;
  wire iset;
  wire msetld;
  wire crwrite;
  wire crread;
  reg ifetch;
  reg exec;
  reg mstore;
  reg mstore2;
  reg mload;
  wire [7:0] _opitype_I;
  wire [1:0] _opitype_r2;
  wire [1:0] _opitype_r1;
  wire [3:0] _opitype_op;
  wire [15:0] opr1;
  wire [15:0] opr2;
  wire [15:0] aluq;
  wire [15:0] wdata;
  wire [15:0] _alu_a;
  wire [15:0] _alu_b;
  wire [5:0] _alu_f;
  wire [15:0] _alu_q;
  wire _alu_exe;
  wire _alu_p_reset;
  wire _alu_m_clock;
  wire [15:0] _gr_regin;
  wire [15:0] _gr_regouta;
  wire [15:0] _gr_regoutb;
  wire [1:0] _gr_n_regin;
  wire [1:0] _gr_n_regouta;
  wire [1:0] _gr_n_regoutb;
  wire _gr_write;
  wire _gr_reada;
  wire _gr_readb;
  wire _gr_ShowReg;
  wire _gr_p_reset;
  wire _gr_m_clock;
  wire [15:0] _inc_in;
  wire [15:0] _inc_out;
  wire _inc_do;
  wire _inc_p_reset;
  wire _inc_m_clock;
  wire _proc_ifetch_set;
  wire _proc_ifetch_reset;
  wire _net_5;
  wire _proc_exec_set;
  wire _proc_exec_reset;
  wire _net_6;
  wire _proc_mstore_set;
  wire _proc_mstore_reset;
  wire _net_7;
  wire _proc_mstore2_set;
  wire _proc_mstore2_reset;
  wire _net_8;
  wire _proc_mload_set;
  wire _proc_mload_reset;
  wire _net_9;
  wire _net_10;
  reg _reg_11;
  reg _reg_12;
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
  wire _net_33;
  wire _net_34;
  wire _net_35;
  wire _net_37;
  wire _net_38;
  wire [15:0] _net_39;
  wire _net_40;
  wire _net_41;
  wire _net_42;
  wire _net_43;
  wire _net_44;
  wire _net_45;
  wire [3:0] _tdec_op;
  wire _tdec_itype;
  wire _tdec_rtype;
  wire _tdec_ctype;
  wire _tdec_dec;
  wire _tdec_p_reset;
  wire _tdec_m_clock;
  wire [15:0] _net_47;
  wire [15:0] _net_48;
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
inc16 inc (.m_clock(m_clock), .p_reset(p_reset), .do(_inc_do), .out(_inc_out), .in(_inc_in));
reg4 gr (.m_clock(m_clock), .p_reset(p_reset), .ShowReg(_gr_ShowReg), .readb(_gr_readb), .reada(_gr_reada), .write(_gr_write), .n_regoutb(_gr_n_regoutb), .n_regouta(_gr_n_regouta), .n_regin(_gr_n_regin), .regoutb(_gr_regoutb), .regouta(_gr_regouta), .regin(_gr_regin));
alu16 alu (.m_clock(m_clock), .p_reset(p_reset), .exe(_alu_exe), .q(_alu_q), .f(_alu_f), .b(_alu_b), .a(_alu_a));
type_dec tdec (.m_clock(m_clock), .p_reset(p_reset), .dec(_tdec_dec), .ctype(_tdec_ctype), .rtype(_tdec_rtype), .itype(_tdec_itype), .op(_tdec_op));

   assign  npc = (((_net_149|(_net_141|(mstore2|_net_124))))?pc:16'b0)|
    ((_net_104)?_inc_out:16'b0)|
    ((_net_99)?aluq:16'b0)|
    ((_net_95)?cr3:16'b0)|
    ((_reg_11)?cr2:16'b0)|
    ((start)?16'b0000000000000000:16'b0);
   assign  nmar = aluq;
   assign  nregnum = _opitype_r1;
   assign  crnum = (mar[7:0]);
   assign  crwdat = wdata;
   assign  crrdat = ((_net_35)?cr0:16'b0)|
    ((_net_33)?cr1:16'b0)|
    ((_net_31)?cr2:16'b0)|
    ((_net_29)?cr3:16'b0);
   assign  iset = (_net_148|(_net_140|(mstore2|(_net_123|(_net_101|(_net_98|(_net_94|(_reg_11|start))))))));
   assign  msetld = _net_80;
   assign  crwrite = _net_120;
   assign  crread = _net_138;
   assign  _opitype_I = (_net_48[7:0]);
   assign  _opitype_r2 = (_net_48[9:8]);
   assign  _opitype_r1 = (_net_48[11:10]);
   assign  _opitype_op = (_net_48[15:12]);
   assign  opr1 = _gr_regouta;
   assign  opr2 = ((_net_53)?_gr_regoutb:16'b0)|
    ((_net_50)?16'b0000000000000000:16'b0);
   assign  aluq = _alu_q;
   assign  wdata = _gr_regouta;
   assign  _alu_a = ((_net_68)?({({(_opitype_I[7]),(_opitype_I[7]),(_opitype_I[7]),(_opitype_I[7]),(_opitype_I[7]),(_opitype_I[7]),(_opitype_I[7]),(_opitype_I[7])}),_opitype_I}):16'b0)|
    ((_net_63)?({_opitype_I,8'b00000000}):16'b0)|
    ((_net_56)?opr1:16'b0);
   assign  _alu_b = opr2;
   assign  _alu_f = (((_net_69|_net_64))?6'b000000:6'b0)|
    ((_net_57)?_opreg_fn:6'b0);
   assign  _alu_exe = (_net_66|(_net_61|_net_54));
   assign  _alu_p_reset = p_reset;
   assign  _alu_m_clock = m_clock;
   assign  _gr_regin = ((_net_146)?datai:16'b0)|
    ((_net_138)?crrdat:16'b0)|
    (((_net_114|_net_111))?aluq:16'b0)|
    ((_net_107)?_inc_out:16'b0);
   assign  _gr_n_regin = (((_net_147|_net_139))?regnum:2'b0)|
    ((_net_115)?_opreg_r1:2'b0)|
    (((_net_112|_net_108))?_opitype_r1:2'b0);
   assign  _gr_n_regouta = (((_net_129|_net_118))?regnum:2'b0)|
    ((exec)?_opreg_r2:2'b0);
   assign  _gr_n_regoutb = _opreg_r3;
   assign  _gr_write = (_net_145|(_net_137|(_net_113|(_net_110|_net_106))));
   assign  _gr_reada = (_net_128|(_net_117|exec));
   assign  _gr_readb = _net_51;
   assign  _gr_ShowReg = exec;
   assign  _gr_p_reset = p_reset;
   assign  _gr_m_clock = m_clock;
   assign  _inc_in = pc;
   assign  _inc_do = (_net_107|(_net_102|(_net_83|_net_76)));
   assign  _inc_p_reset = p_reset;
   assign  _inc_m_clock = m_clock;
   assign  _proc_ifetch_set = _net_18;
   assign  _proc_ifetch_reset = _net_37;
   assign  _net_5 = (_proc_ifetch_set|_proc_ifetch_reset);
   assign  _proc_exec_set = _net_38;
   assign  _proc_exec_reset = (exec|_net_72);
   assign  _net_6 = (_proc_exec_set|_proc_exec_reset);
   assign  _proc_mstore_set = _net_73;
   assign  _proc_mstore_reset = (_net_134|(_net_132|_net_125));
   assign  _net_7 = (_proc_mstore_set|_proc_mstore_reset);
   assign  _proc_mstore2_set = _net_133;
   assign  _proc_mstore2_reset = mstore2;
   assign  _net_8 = (_proc_mstore2_set|_proc_mstore2_reset);
   assign  _proc_mload_set = msetld;
   assign  _proc_mload_reset = (_net_150|_net_142);
   assign  _net_9 = (_proc_mload_set|_proc_mload_reset);
   assign  _net_10 = (((cr0[0])&(~isr))&int1);
   assign  _net_13 = ((iset&_net_10)|_reg_12);
   assign  _net_14 = ((iset&_net_10)|_reg_12);
   assign  _net_15 = ((iset&_net_10)|(_reg_11|_reg_12));
   assign  _net_16 = (iset&(~_net_10));
   assign  _net_17 = (iset&(~_net_10));
   assign  _net_18 = (iset&(~_net_10));
   assign  _net_19 = (iset&(~_net_10));
   assign  _net_20 = (crnum==8'b00000011);
   assign  _net_21 = (crwrite&_net_20);
   assign  _net_22 = (crnum==8'b00000010);
   assign  _net_23 = (crwrite&_net_22);
   assign  _net_24 = (crnum==8'b00000001);
   assign  _net_25 = (crwrite&_net_24);
   assign  _net_26 = (crnum==8'b00000000);
   assign  _net_27 = (crwrite&_net_26);
   assign  _net_28 = (crnum==8'b00000011);
   assign  _net_29 = (crread&_net_28);
   assign  _net_30 = (crnum==8'b00000010);
   assign  _net_31 = (crread&_net_30);
   assign  _net_32 = (crnum==8'b00000001);
   assign  _net_33 = (crread&_net_32);
   assign  _net_34 = (crnum==8'b00000000);
   assign  _net_35 = (crread&_net_34);


// synthesis translate_on
// synopsys translate_on
   assign  _net_37 = (ifetch&inst_ok);
   assign  _net_38 = (ifetch&inst_ok);
   assign  _net_39 = inst;
   assign  _net_40 = (ifetch&inst_ok);
   assign  _net_41 = (ifetch&inst_ok);
   assign  _net_42 = (ifetch&inst_ok);
   assign  _net_43 = (ifetch&inst_ok);
   assign  _net_44 = (ifetch&inst_ok);
   assign  _net_45 = (ifetch&inst_ok);
   assign  _tdec_op = _opreg_op;
   assign  _tdec_dec = exec;
   assign  _tdec_p_reset = p_reset;
   assign  _tdec_m_clock = m_clock;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
    if(exec)
    begin
    $write("PC:%04x IS:%04X ",pc,_net_47);
    end
  end

// synthesis translate_on
// synopsys translate_on
   assign  _net_47 = ({({_opreg_op,_opreg_r2,_opreg_r3,_opreg_r1,_opreg_fn})});
   assign  _net_48 = ({_opreg_op,_opreg_r2,_opreg_r3,_opreg_r1,_opreg_fn});
   assign  _net_49 = (_tdec_itype&(_opreg_r3==2'b00));
   assign  _net_50 = (exec&_net_49);
   assign  _net_51 = (exec&(~_net_49));
   assign  _net_52 = (exec&(~_net_49));
   assign  _net_53 = (exec&(~_net_49));
   assign  _net_54 = (exec&_tdec_rtype);
   assign  _net_55 = (exec&_tdec_rtype);
   assign  _net_56 = (exec&_tdec_rtype);
   assign  _net_57 = (exec&_tdec_rtype);
   assign  _net_58 = (exec&_tdec_rtype);
   assign  _net_59 = (_opreg_op==4'b1011);
   assign  _net_60 = (exec&_tdec_itype);
   assign  _net_61 = ((exec&_tdec_itype)&_net_59);
   assign  _net_62 = ((exec&_tdec_itype)&_net_59);
   assign  _net_63 = ((exec&_tdec_itype)&_net_59);
   assign  _net_64 = ((exec&_tdec_itype)&_net_59);
   assign  _net_65 = ((exec&_tdec_itype)&_net_59);
   assign  _net_66 = ((exec&_tdec_itype)&(~_net_59));
   assign  _net_67 = ((exec&_tdec_itype)&(~_net_59));
   assign  _net_68 = ((exec&_tdec_itype)&(~_net_59));
   assign  _net_69 = ((exec&_tdec_itype)&(~_net_59));
   assign  _net_70 = ((exec&_tdec_itype)&(~_net_59));
   assign  _net_71 = (_opitype_op==4'b1001);
   assign  _net_72 = (exec&_net_71);
   assign  _net_73 = (exec&_net_71);
   assign  _net_74 = (exec&_net_71);
   assign  _net_75 = (exec&_net_71);
   assign  _net_76 = (exec&_net_71);
   assign  _net_77 = (exec&_net_71);
   assign  _net_78 = (exec&_net_71);
   assign  _net_79 = (_opitype_op==4'b1000);
   assign  _net_80 = (exec&_net_79);
   assign  _net_81 = (exec&_net_79);
   assign  _net_82 = (exec&_net_79);
   assign  _net_83 = (exec&_net_79);
   assign  _net_84 = (exec&_net_79);
   assign  _net_85 = (exec&_net_79);
   assign  _net_86 = (_opreg_fn==6'b000111);
   assign  _net_87 = (exec&_tdec_ctype);
   assign  _net_88 = ((exec&_tdec_ctype)&_net_86);
   assign  _net_89 = ((exec&_tdec_ctype)&_net_86);
   assign  _net_90 = (_opreg_fn==6'b000110);
   assign  _net_91 = (exec&_tdec_ctype);
   assign  _net_92 = ((exec&_tdec_ctype)&_net_90);
   assign  _net_93 = ((exec&_tdec_ctype)&_net_90);
   assign  _net_94 = ((exec&_tdec_ctype)&_net_90);
   assign  _net_95 = ((exec&_tdec_ctype)&_net_90);
   assign  _net_96 = ((_opitype_op==4'b1111)|((_opitype_op==4'b1110)&(opr1==16'b0000000000000000)));
   assign  _net_97 = (exec&_net_96);
   assign  _net_98 = (exec&_net_96);
   assign  _net_99 = (exec&_net_96);
   assign  _net_100 = ((((exec&(~_net_71))&(~_net_79))&(~_tdec_ctype))&(~_net_96));
   assign  _net_101 = ((((exec&(~_net_71))&(~_net_79))&(~_tdec_ctype))&(~_net_96));
   assign  _net_102 = ((((exec&(~_net_71))&(~_net_79))&(~_tdec_ctype))&(~_net_96));
   assign  _net_103 = ((((exec&(~_net_71))&(~_net_79))&(~_tdec_ctype))&(~_net_96));
   assign  _net_104 = ((((exec&(~_net_71))&(~_net_79))&(~_tdec_ctype))&(~_net_96));
   assign  _net_105 = (_opitype_op==4'b1111);
   assign  _net_106 = (exec&_net_105);
   assign  _net_107 = (exec&_net_105);
   assign  _net_108 = (exec&_net_105);
   assign  _net_109 = ((_opitype_op==4'b1010)|(_opitype_op==4'b1011));
   assign  _net_110 = (exec&_net_109);
   assign  _net_111 = (exec&_net_109);
   assign  _net_112 = (exec&_net_109);
   assign  _net_113 = (exec&_tdec_rtype);
   assign  _net_114 = (exec&_tdec_rtype);
   assign  _net_115 = (exec&_tdec_rtype);
   assign  _net_116 = ((mar[15:8])==8'b11111111);
   assign  _net_117 = (mstore&_net_116);
   assign  _net_118 = (mstore&_net_116);
   assign  _net_119 = (mstore&_net_116);
   assign  _net_120 = (mstore&_net_116);
   assign  _net_121 = (mstore&_net_116);
   assign  _net_122 = (mstore&_net_116);
   assign  _net_123 = (mstore&_net_116);
   assign  _net_124 = (mstore&_net_116);
   assign  _net_125 = (mstore&_net_116);
   assign  _net_126 = (mstore&_net_116);
   assign  _net_127 = (mstore&(~_net_116));
   assign  _net_128 = (mstore&(~_net_116));
   assign  _net_129 = (mstore&(~_net_116));
   assign  _net_130 = (mstore&(~_net_116));
   assign  _net_131 = (mstore&(~_net_116));
   assign  _net_132 = ((mstore&(~_net_116))&mem_ok);
   assign  _net_133 = ((mstore&(~_net_116))&mem_ok);
   assign  _net_134 = ((mstore&(~_net_116))&mem_ok);
   assign  _net_135 = ((mstore&(~_net_116))&mem_ok);
   assign  _net_136 = ((mar[15:8])==8'b11111111);
   assign  _net_137 = (mload&_net_136);
   assign  _net_138 = (mload&_net_136);
   assign  _net_139 = (mload&_net_136);
   assign  _net_140 = (mload&_net_136);
   assign  _net_141 = (mload&_net_136);
   assign  _net_142 = (mload&_net_136);
   assign  _net_143 = (mload&_net_136);
   assign  _net_144 = (mload&(~_net_136));
   assign  _net_145 = ((mload&(~_net_136))&mem_ok);
   assign  _net_146 = ((mload&(~_net_136))&mem_ok);
   assign  _net_147 = ((mload&(~_net_136))&mem_ok);
   assign  _net_148 = ((mload&(~_net_136))&mem_ok);
   assign  _net_149 = ((mload&(~_net_136))&mem_ok);
   assign  _net_150 = ((mload&(~_net_136))&mem_ok);
   assign  _net_151 = ((mload&(~_net_136))&mem_ok);
   assign  datao = _gr_regouta;
   assign  iadrs = npc;
   assign  adrs = ((_net_131)?mar:16'b0)|
    ((msetld)?nmar:16'b0);
   assign  inst_adr = _net_16;
   assign  inst_read = ifetch;
   assign  memory_adr = msetld;
   assign  memory_read = _net_144;
   assign  memory_write = _net_127;
   assign  IntAck = _reg_11;
   assign  wb = (_net_151|(_net_143|(_net_135|(_net_126|(_net_100|(_net_97|(_net_92|_net_88)))))));
   assign  hlt = _net_89;
always @(posedge m_clock)
  begin
if (((_net_85|_net_78))|(_net_19)) 
      pc <= (((_net_85|_net_78)) ?_inc_out:16'b0)|
    ((_net_19) ?npc:16'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     isr <= 1'b0;
else if ((_net_93)|(_net_14)) 
      isr <= ((_net_93) ?1'b0:1'b0)|
    ((_net_14) ?1'b1:1'b0);

end
always @(posedge m_clock)
  begin
if ((_net_45)) 
      _opreg_fn <= (_net_39[5:0]);
end
always @(posedge m_clock)
  begin
if ((_net_44)) 
      _opreg_r1 <= (_net_39[7:6]);
end
always @(posedge m_clock)
  begin
if ((_net_43)) 
      _opreg_r3 <= (_net_39[9:8]);
end
always @(posedge m_clock)
  begin
if ((_net_42)) 
      _opreg_r2 <= (_net_39[11:10]);
end
always @(posedge m_clock)
  begin
if ((_net_41)) 
      _opreg_op <= (_net_39[15:12]);
end
always @(posedge m_clock)
  begin
if ((_net_74)|(msetld)) 
      mar <= ((_net_74) ?aluq:16'b0)|
    ((msetld) ?nmar:16'b0);

end
always @(posedge m_clock)
  begin
if ((_net_75)|(msetld)) 
      regnum <= ((_net_75) ?_opitype_r1:2'b0)|
    ((msetld) ?nregnum:2'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     cr0 <= 16'b0000000000000000;
else if ((_net_27)) 
      cr0 <= crwdat;
end
always @(posedge m_clock)
  begin
if (p_reset)
     cr1 <= 16'b0000000000000000;
else if ((_net_25)) 
      cr1 <= crwdat;
end
always @(posedge m_clock)
  begin
if (p_reset)
     cr2 <= 16'b0000000000000000;
else if ((_net_23)) 
      cr2 <= crwdat;
end
always @(posedge m_clock)
  begin
if (p_reset)
     cr3 <= 16'b0000000000000000;
else if ((_net_21)|(_net_13)) 
      cr3 <= ((_net_21) ?crwdat:16'b0)|
    ((_net_13) ?npc:16'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     int0 <= 1'b0;
else   int0 <= IntReq;
end
always @(posedge m_clock)
  begin
if (p_reset)
     int1 <= 1'b0;
else   int1 <= int0;
end
always @(posedge m_clock)
  begin
if (p_reset)
     ifetch <= 1'b0;
else if ((_net_5)) 
      ifetch <= _proc_ifetch_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     exec <= 1'b0;
else if ((_net_6)) 
      exec <= _proc_exec_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     mstore <= 1'b0;
else if ((_net_7)) 
      mstore <= _proc_mstore_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     mstore2 <= 1'b0;
else if ((_net_8)) 
      mstore2 <= _proc_mstore2_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     mload <= 1'b0;
else if ((_net_9)) 
      mload <= _proc_mload_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_11 <= 1'b0;
else if ((_net_15)) 
      _reg_11 <= (_reg_12|(iset&_net_10));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_12 <= 1'b0;
else if ((_reg_12)) 
      _reg_12 <= 1'b0;
end
endmodule
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 22:48:42 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 22:48:42 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module alu16 ( p_reset , m_clock , a , b , f , q , exe );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [15:0] a;
  wire [15:0] a;
  input [15:0] b;
  wire [15:0] b;
  input [5:0] f;
  wire [5:0] f;
  output [15:0] q;
  wire [15:0] q;
  input exe;
  wire exe;
  wire _cla_cin;
  wire [15:0] _cla_in1;
  wire [15:0] _cla_in2;
  wire [15:0] _cla_out;
  wire _cla_do;
  wire _cla_p_reset;
  wire _cla_m_clock;
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
cla16 cla (.m_clock(m_clock), .p_reset(p_reset), .do(_cla_do), .out(_cla_out), .in2(_cla_in2), .in1(_cla_in1), .cin(_cla_cin));

   assign  _cla_cin = ((_net_169)?1'b0:1'b0)|
    ((_net_160)?1'b1:1'b0);
   assign  _cla_in1 = a;
   assign  _cla_in2 = ((_net_167)?b:16'b0)|
    ((_net_158)?(~b):16'b0);
   assign  _cla_do = (_net_166|_net_157);
   assign  _cla_p_reset = p_reset;
   assign  _cla_m_clock = m_clock;
   assign  _net_152 = (f==6'b000110);
   assign  _net_153 = (exe&_net_152);
   assign  _net_154 = (f==6'b000100);
   assign  _net_155 = (exe&_net_154);
   assign  _net_156 = (f==6'b000011);
   assign  _net_157 = (exe&_net_156);
   assign  _net_158 = (exe&_net_156);
   assign  _net_159 = (exe&_net_156);
   assign  _net_160 = (exe&_net_156);
   assign  _net_161 = ((((a[15])&(~(b[15])))|(((_cla_out[15])&(~(a[15])))&(~(b[15]))))|(((_cla_out[15])&(a[15]))&(b[15])));
   assign  _net_162 = (exe&_net_156);
   assign  _net_163 = (f==6'b000001);
   assign  _net_164 = (exe&_net_163);
   assign  _net_165 = (f==6'b000000);
   assign  _net_166 = (exe&_net_165);
   assign  _net_167 = (exe&_net_165);
   assign  _net_168 = (exe&_net_165);
   assign  _net_169 = (exe&_net_165);
   assign  _net_170 = (exe&_net_165);
   assign  q = ((_net_170)?_cla_out:16'b0)|
    ((_net_164)?(a&b):16'b0)|
    ((_net_162)?({15'b000000000000000,_net_161}):16'b0)|
    ((_net_155)?(~a):16'b0)|
    ((_net_153)?({1'b0,(a[15:1])}):16'b0);
endmodule
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 22:48:42 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 22:48:42 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module cla16 ( p_reset , m_clock , cin , in1 , in2 , out , do );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input cin;
  wire cin;
  input [15:0] in1;
  wire [15:0] in1;
  input [15:0] in2;
  wire [15:0] in2;
  output [15:0] out;
  wire [15:0] out;
  input do;
  wire do;
  wire _net_171;

   assign  _net_171 = cin;
   assign  out = ((in1+in2)+({15'b000000000000000,_net_171}));
endmodule
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 22:48:42 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 22:48:42 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module reg4 ( p_reset , m_clock , regin , regouta , regoutb , n_regin , n_regouta , n_regoutb , write , reada , readb , ShowReg );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [15:0] regin;
  wire [15:0] regin;
  output [15:0] regouta;
  wire [15:0] regouta;
  output [15:0] regoutb;
  wire [15:0] regoutb;
  input [1:0] n_regin;
  wire [1:0] n_regin;
  input [1:0] n_regouta;
  wire [1:0] n_regouta;
  input [1:0] n_regoutb;
  wire [1:0] n_regoutb;
  input write;
  wire write;
  input reada;
  wire reada;
  input readb;
  wire readb;
  input ShowReg;
  wire ShowReg;
  reg [15:0] r0;
  reg [15:0] r1;
  reg [15:0] r2;
  reg [15:0] r3;
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

   assign  _net_172 = (n_regin==2'b11);
   assign  _net_173 = (write&_net_172);
   assign  _net_174 = (n_regin==2'b10);
   assign  _net_175 = (write&_net_174);
   assign  _net_176 = (n_regin==2'b01);
   assign  _net_177 = (write&_net_176);
   assign  _net_178 = (n_regin==2'b00);
   assign  _net_179 = (write&_net_178);
   assign  _net_180 = (n_regouta==2'b11);
   assign  _net_181 = (reada&_net_180);
   assign  _net_182 = (n_regouta==2'b10);
   assign  _net_183 = (reada&_net_182);
   assign  _net_184 = (n_regouta==2'b01);
   assign  _net_185 = (reada&_net_184);
   assign  _net_186 = (n_regouta==2'b00);
   assign  _net_187 = (reada&_net_186);
   assign  _net_188 = (n_regoutb==2'b11);
   assign  _net_189 = (readb&_net_188);
   assign  _net_190 = (n_regoutb==2'b10);
   assign  _net_191 = (readb&_net_190);
   assign  _net_192 = (n_regoutb==2'b01);
   assign  _net_193 = (readb&_net_192);
   assign  _net_194 = (n_regoutb==2'b00);
   assign  _net_195 = (readb&_net_194);

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
    if(ShowReg)
    begin
    $display("$0:%04X $1:%04X $2:%04X $3:%04X",r0,r1,r2,r3);
    end
  end

// synthesis translate_on
// synopsys translate_on
   assign  regouta = ((_net_187)?r0:16'b0)|
    ((_net_185)?r1:16'b0)|
    ((_net_183)?r2:16'b0)|
    ((_net_181)?r3:16'b0);
   assign  regoutb = ((_net_195)?r0:16'b0)|
    ((_net_193)?r1:16'b0)|
    ((_net_191)?r2:16'b0)|
    ((_net_189)?r3:16'b0);
always @(posedge m_clock)
  begin
if ((_net_179)) 
      r0 <= regin;
end
always @(posedge m_clock)
  begin
if ((_net_177)) 
      r1 <= regin;
end
always @(posedge m_clock)
  begin
if ((_net_175)) 
      r2 <= regin;
end
always @(posedge m_clock)
  begin
if ((_net_173)) 
      r3 <= regin;
end
endmodule
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 22:48:42 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 22:48:42 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module inc16 ( p_reset , m_clock , in , out , do );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [15:0] in;
  wire [15:0] in;
  output [15:0] out;
  wire [15:0] out;
  input do;
  wire do;

   assign  out = (in+16'b0000000000000001);
endmodule
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 22:48:42 2016
 Licensed to :EVALUATION USER
*/
