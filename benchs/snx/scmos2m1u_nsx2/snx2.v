
/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Thu Jun 20 10:03:13 2024
 Licensed to :EVALUATION USER*/
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

/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Thu Jun 20 10:03:13 2024
 Licensed to :EVALUATION USER*/

/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Thu Jun 20 10:03:13 2024
 Licensed to :EVALUATION USER*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module snx2 ( p_reset , m_clock , datai , datao , adrs , start , mem_ok , memory_adr , memory_read , memory_write , stgi , stge , stgs , stgs2 , stgl , wb , hlt );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [15:0] datai;
  wire [15:0] datai;
  output [15:0] datao;
  wire [15:0] datao;
  output [9:0] adrs;
  wire [9:0] adrs;
  input start;
  wire start;
  input mem_ok;
  wire mem_ok;
  output memory_adr;
  wire memory_adr;
  output memory_read;
  wire memory_read;
  output memory_write;
  wire memory_write;
  output stgi;
  wire stgi;
  output stge;
  wire stge;
  output stgs;
  wire stgs;
  output stgs2;
  wire stgs2;
  output stgl;
  wire stgl;
  output wb;
  wire wb;
  output hlt;
  wire hlt;
  reg [9:0] pc;
  reg [5:0] _opreg_fn;
  reg [1:0] _opreg_r1;
  reg [1:0] _opreg_r3;
  reg [1:0] _opreg_r2;
  reg [3:0] _opreg_op;
  reg [9:0] mar;
  reg [1:0] regnum;
  wire [9:0] npc;
  wire [9:0] nmar;
  wire [1:0] nregnum;
  wire iset;
  wire msetld;
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
  wire _gr_p_reset;
  wire _gr_m_clock;
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
  wire _net_11;
  wire [15:0] _net_12;
  wire _net_13;
  wire _net_14;
  wire _net_15;
  wire _net_16;
  wire _net_17;
  wire _net_18;
  wire [9:0] _net_19;
  wire _net_20;
  wire _net_21;
  wire _net_22;
  wire _net_23;
  wire _net_24;
  wire [3:0] _tdec_op;
  wire _tdec_itype;
  wire _tdec_rtype;
  wire _tdec_ctype;
  wire _tdec_dec;
  wire _tdec_p_reset;
  wire _tdec_m_clock;
  wire [15:0] _net_26;
  wire [9:0] _net_27;
  wire [15:0] _net_28;
  wire _net_29;
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
  wire [9:0] _net_70;
  wire _net_71;
  wire _net_72;
  wire _net_73;
  wire _net_74;
  wire [9:0] _net_75;
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
  wire [9:0] _net_88;
  wire _net_89;
  wire _net_90;
  wire _net_91;
  wire _net_92;
  wire [9:0] _net_93;
  wire _net_94;
  wire _net_95;
  wire _net_96;
reg4 gr (.m_clock(m_clock), .p_reset( p_reset), .readb(_gr_readb), .reada(_gr_reada), .write(_gr_write), .n_regoutb(_gr_n_regoutb), .n_regouta(_gr_n_regouta), .n_regin(_gr_n_regin), .regoutb(_gr_regoutb), .regouta(_gr_regouta), .regin(_gr_regin));
alu16 alu (.m_clock(m_clock), .p_reset( p_reset), .exe(_alu_exe), .q(_alu_q), .f(_alu_f), .b(_alu_b), .a(_alu_a));
type_dec tdec (.m_clock(m_clock), .p_reset( p_reset), .dec(_tdec_dec), .ctype(_tdec_ctype), .rtype(_tdec_rtype), .itype(_tdec_itype), .op(_tdec_op));

   assign  npc = ((_net_94)?({6'b000000,_net_93}):10'b0)|
    ((mstore2)?({6'b000000,_net_88}):10'b0)|
    ((_net_71)?({6'b000000,_net_70}):10'b0)|
    ((_net_67)?aluq:10'b0)|
    ((start)?16'b0000000000000000:10'b0);
   assign  nmar = aluq;
   assign  nregnum = _opitype_r1;
   assign  iset = (_net_92|(mstore2|(_net_69|(_net_66|start))));
   assign  msetld = _net_57;
   assign  _opitype_I = (_net_28[7:0]);
   assign  _opitype_r2 = (_net_28[9:8]);
   assign  _opitype_r1 = (_net_28[11:10]);
   assign  _opitype_op = (_net_28[15:12]);
   assign  opr1 = _gr_regouta;
   assign  opr2 = ((_net_33)?_gr_regoutb:16'b0)|
    ((_net_30)?16'b0000000000000000:16'b0);
   assign  aluq = _alu_q;
   assign  _alu_a = ((_net_48)?({({(_opitype_I[7]),(_opitype_I[7]),(_opitype_I[7]),(_opitype_I[7]),(_opitype_I[7]),(_opitype_I[7]),(_opitype_I[7]),(_opitype_I[7])}),_opitype_I}):16'b0)|
    ((_net_43)?({_opitype_I,8'b00000000}):16'b0)|
    ((_net_36)?opr1:16'b0)|
    ((_net_22)?({6'b000000,_net_19}):16'b0);
   assign  _alu_b = (((_net_47|(_net_42|_net_35)))?opr2:16'b0)|
    ((_net_21)?16'b0000000000000001:16'b0);
   assign  _alu_f = ((_net_37)?_opreg_fn:6'b0)|
    (((_net_49|(_net_44|_net_23)))?6'b000000:6'b0);
   assign  _alu_exe = (_net_46|(_net_41|(_net_34|_net_20)));
   assign  _alu_p_reset = p_reset;
   assign  _alu_m_clock = m_clock;
   assign  _gr_regin = ((_net_90)?datai:16'b0)|
    (((_net_82|_net_79))?aluq:16'b0)|
    ((_net_74)?({6'b000000,_net_75}):16'b0);
   assign  _gr_n_regin = ((_net_91)?regnum:2'b0)|
    ((_net_83)?_opreg_r1:2'b0)|
    (((_net_80|_net_76))?_opitype_r1:2'b0);
   assign  _gr_n_regouta = ((mstore)?regnum:2'b0)|
    ((exec)?_opreg_r2:2'b0);
   assign  _gr_n_regoutb = _opreg_r3;
   assign  _gr_write = (_net_89|(_net_81|(_net_78|_net_73)));
   assign  _gr_reada = (mstore|exec);
   assign  _gr_readb = _net_31;
   assign  _gr_p_reset = p_reset;
   assign  _gr_m_clock = m_clock;
   assign  _proc_ifetch_set = iset;
   assign  _proc_ifetch_reset = _net_10;
   assign  _net_5 = (_proc_ifetch_set|_proc_ifetch_reset);
   assign  _proc_exec_set = _net_11;
   assign  _proc_exec_reset = (exec|_net_52);
   assign  _net_6 = (_proc_exec_set|_proc_exec_reset);
   assign  _proc_mstore_set = _net_53;
   assign  _proc_mstore_reset = (_net_86|_net_84);
   assign  _net_7 = (_proc_mstore_set|_proc_mstore_reset);
   assign  _proc_mstore2_set = _net_85;
   assign  _proc_mstore2_reset = mstore2;
   assign  _net_8 = (_proc_mstore2_set|_proc_mstore2_reset);
   assign  _proc_mload_set = msetld;
   assign  _proc_mload_reset = _net_95;
   assign  _net_9 = (_proc_mload_set|_proc_mload_reset);
   assign  _net_10 = (ifetch&(mem_ok != 1'b0));
   assign  _net_11 = (ifetch&(mem_ok != 1'b0));
   assign  _net_12 = datai;
   assign  _net_13 = (ifetch&(mem_ok != 1'b0));
   assign  _net_14 = (ifetch&(mem_ok != 1'b0));
   assign  _net_15 = (ifetch&(mem_ok != 1'b0));
   assign  _net_16 = (ifetch&(mem_ok != 1'b0));
   assign  _net_17 = (ifetch&(mem_ok != 1'b0));
   assign  _net_18 = (ifetch&(mem_ok != 1'b0));
   assign  _net_19 = pc;
   assign  _net_20 = (ifetch&(mem_ok != 1'b0));
   assign  _net_21 = (ifetch&(mem_ok != 1'b0));
   assign  _net_22 = (ifetch&(mem_ok != 1'b0));
   assign  _net_23 = (ifetch&(mem_ok != 1'b0));
   assign  _net_24 = (ifetch&(mem_ok != 1'b0));
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
    $write("PC:%04x IS:%04X ",({6'b000000,_net_27}),_net_26);
    end
  end

// synthesis translate_on
// synopsys translate_on
   assign  _net_26 = ({({_opreg_op,_opreg_r2,_opreg_r3,_opreg_r1,_opreg_fn})});
   assign  _net_27 = pc;
   assign  _net_28 = ({_opreg_op,_opreg_r2,_opreg_r3,_opreg_r1,_opreg_fn});
   assign  _net_29 = (_tdec_itype&(_opreg_r3==2'b00));
   assign  _net_30 = (exec&_net_29);
   assign  _net_31 = (exec&(~_net_29));
   assign  _net_32 = (exec&(~_net_29));
   assign  _net_33 = (exec&(~_net_29));
   assign  _net_34 = (exec&_tdec_rtype);
   assign  _net_35 = (exec&_tdec_rtype);
   assign  _net_36 = (exec&_tdec_rtype);
   assign  _net_37 = (exec&_tdec_rtype);
   assign  _net_38 = (exec&_tdec_rtype);
   assign  _net_39 = (_opreg_op==4'b1011);
   assign  _net_40 = (exec&_tdec_itype);
   assign  _net_41 = ((exec&_tdec_itype)&_net_39);
   assign  _net_42 = ((exec&_tdec_itype)&_net_39);
   assign  _net_43 = ((exec&_tdec_itype)&_net_39);
   assign  _net_44 = ((exec&_tdec_itype)&_net_39);
   assign  _net_45 = ((exec&_tdec_itype)&_net_39);
   assign  _net_46 = ((exec&_tdec_itype)&(~_net_39));
   assign  _net_47 = ((exec&_tdec_itype)&(~_net_39));
   assign  _net_48 = ((exec&_tdec_itype)&(~_net_39));
   assign  _net_49 = ((exec&_tdec_itype)&(~_net_39));
   assign  _net_50 = ((exec&_tdec_itype)&(~_net_39));
   assign  _net_51 = (_opitype_op==4'b1001);
   assign  _net_52 = (exec&_net_51);
   assign  _net_53 = (exec&_net_51);
   assign  _net_54 = (exec&_net_51);
   assign  _net_55 = (exec&_net_51);
   assign  _net_56 = (_opitype_op==4'b1000);
   assign  _net_57 = (exec&_net_56);
   assign  _net_58 = (exec&_net_56);
   assign  _net_59 = (exec&_net_56);
   assign  _net_60 = (_opreg_fn==6'b000111);
   assign  _net_61 = (exec&_tdec_ctype);
   assign  _net_62 = ((exec&_tdec_ctype)&_net_60);
   assign  _net_63 = ((exec&_tdec_ctype)&_net_60);
   assign  _net_64 = ((_opitype_op==4'b1111)|((_opitype_op==4'b1110)&(opr1==16'b0000000000000000)));
   assign  _net_65 = (exec&_net_64);
   assign  _net_66 = (exec&_net_64);
   assign  _net_67 = (exec&_net_64);
   assign  _net_68 = ((((exec&(~_net_51))&(~_net_56))&(~_tdec_ctype))&(~_net_64));
   assign  _net_69 = ((((exec&(~_net_51))&(~_net_56))&(~_tdec_ctype))&(~_net_64));
   assign  _net_70 = pc;
   assign  _net_71 = ((((exec&(~_net_51))&(~_net_56))&(~_tdec_ctype))&(~_net_64));
   assign  _net_72 = (_opitype_op==4'b1111);
   assign  _net_73 = (exec&_net_72);
   assign  _net_74 = (exec&_net_72);
   assign  _net_75 = pc;
   assign  _net_76 = (exec&_net_72);
   assign  _net_77 = ((_opitype_op==4'b1010)|(_opitype_op==4'b1011));
   assign  _net_78 = (exec&_net_77);
   assign  _net_79 = (exec&_net_77);
   assign  _net_80 = (exec&_net_77);
   assign  _net_81 = (exec&_tdec_rtype);
   assign  _net_82 = (exec&_tdec_rtype);
   assign  _net_83 = (exec&_tdec_rtype);
   assign  _net_84 = (mstore&(mem_ok != 1'b0));
   assign  _net_85 = (mstore&(mem_ok != 1'b0));
   assign  _net_86 = (mstore&(mem_ok != 1'b0));
   assign  _net_87 = (mstore&(mem_ok != 1'b0));
   assign  _net_88 = pc;
   assign  _net_89 = (mload&(mem_ok != 1'b0));
   assign  _net_90 = (mload&(mem_ok != 1'b0));
   assign  _net_91 = (mload&(mem_ok != 1'b0));
   assign  _net_92 = (mload&(mem_ok != 1'b0));
   assign  _net_93 = pc;
   assign  _net_94 = (mload&(mem_ok != 1'b0));
   assign  _net_95 = (mload&(mem_ok != 1'b0));
   assign  _net_96 = (mload&(mem_ok != 1'b0));
   assign  datao = _gr_regouta;
   assign  adrs = ((mstore)?mar:10'b0)|
    ((msetld)?nmar:10'b0)|
    ((iset)?npc:10'b0);
   assign  memory_adr = (msetld|iset);
   assign  memory_read = (mload|ifetch);
   assign  memory_write = mstore;
   assign  stgi = ifetch;
   assign  stge = exec;
   assign  stgs = mstore;
   assign  stgs2 = mstore2;
   assign  stgl = mload;
   assign  wb = (_net_96|(_net_87|(_net_68|(_net_65|_net_62))));
   assign  hlt = _net_63;
always @(posedge m_clock)
  begin
if ((_net_24)|(iset)) 
      pc <= ((_net_24) ?_alu_q:10'b0)|
    ((iset) ?npc:10'b0);

end
always @(posedge m_clock)
  begin
if ((_net_18)) 
      _opreg_fn <= (_net_12[5:0]);
end
always @(posedge m_clock)
  begin
if ((_net_17)) 
      _opreg_r1 <= (_net_12[7:6]);
end
always @(posedge m_clock)
  begin
if ((_net_16)) 
      _opreg_r3 <= (_net_12[9:8]);
end
always @(posedge m_clock)
  begin
if ((_net_15)) 
      _opreg_r2 <= (_net_12[11:10]);
end
always @(posedge m_clock)
  begin
if ((_net_14)) 
      _opreg_op <= (_net_12[15:12]);
end
always @(posedge m_clock)
  begin
if ((_net_54)|(msetld)) 
      mar <= ((_net_54) ?aluq:10'b0)|
    ((msetld) ?nmar:10'b0);

end
always @(posedge m_clock)
  begin
if ((_net_55)|(msetld)) 
      regnum <= ((_net_55) ?_opitype_r1:2'b0)|
    ((msetld) ?nregnum:2'b0);

end
always @(posedge m_clock or negedge p_reset)
  begin
if (~p_reset)
     ifetch <= 1'b0;
else if ((_net_5)) 
      ifetch <= _proc_ifetch_set;
end
always @(posedge m_clock or negedge p_reset)
  begin
if (~p_reset)
     exec <= 1'b0;
else if ((_net_6)) 
      exec <= _proc_exec_set;
end
always @(posedge m_clock or negedge p_reset)
  begin
if (~p_reset)
     mstore <= 1'b0;
else if ((_net_7)) 
      mstore <= _proc_mstore_set;
end
always @(posedge m_clock or negedge p_reset)
  begin
if (~p_reset)
     mstore2 <= 1'b0;
else if ((_net_8)) 
      mstore2 <= _proc_mstore2_set;
end
always @(posedge m_clock or negedge p_reset)
  begin
if (~p_reset)
     mload <= 1'b0;
else if ((_net_9)) 
      mload <= _proc_mload_set;
end
endmodule

/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Thu Jun 20 10:03:13 2024
 Licensed to :EVALUATION USER*/

/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Thu Jun 20 10:03:13 2024
 Licensed to :EVALUATION USER*/
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
cla16 cla (.m_clock(m_clock), .p_reset( p_reset), .do(_cla_do), .out(_cla_out), .in2(_cla_in2), .in1(_cla_in1), .cin(_cla_cin));

   assign  _cla_cin = ((_net_114)?1'b0:1'b0)|
    ((_net_105)?1'b1:1'b0);
   assign  _cla_in1 = a;
   assign  _cla_in2 = ((_net_112)?b:16'b0)|
    ((_net_103)?(~b):16'b0);
   assign  _cla_do = (_net_111|_net_102);
   assign  _cla_p_reset = p_reset;
   assign  _cla_m_clock = m_clock;
   assign  _net_97 = (f==6'b000110);
   assign  _net_98 = (exe&_net_97);
   assign  _net_99 = (f==6'b000100);
   assign  _net_100 = (exe&_net_99);
   assign  _net_101 = (f==6'b000011);
   assign  _net_102 = (exe&_net_101);
   assign  _net_103 = (exe&_net_101);
   assign  _net_104 = (exe&_net_101);
   assign  _net_105 = (exe&_net_101);
   assign  _net_106 = ((((a[15])&(~(b[15])))|(((_cla_out[15])&(~(a[15])))&(~(b[15]))))|(((_cla_out[15])&(a[15]))&(b[15])));
   assign  _net_107 = (exe&_net_101);
   assign  _net_108 = (f==6'b000001);
   assign  _net_109 = (exe&_net_108);
   assign  _net_110 = (f==6'b000000);
   assign  _net_111 = (exe&_net_110);
   assign  _net_112 = (exe&_net_110);
   assign  _net_113 = (exe&_net_110);
   assign  _net_114 = (exe&_net_110);
   assign  _net_115 = (exe&_net_110);
   assign  q = ((_net_115)?_cla_out:16'b0)|
    ((_net_109)?(a&b):16'b0)|
    ((_net_107)?({15'b000000000000000,_net_106}):16'b0)|
    ((_net_100)?(~a):16'b0)|
    ((_net_98)?({1'b0,(a[15:1])}):16'b0);
endmodule

/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Thu Jun 20 10:03:13 2024
 Licensed to :EVALUATION USER*/

/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Thu Jun 20 10:03:13 2024
 Licensed to :EVALUATION USER*/
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
  wire _net_116;

   assign  _net_116 = cin;
   assign  out = ((in1+in2)+({15'b000000000000000,_net_116}));
endmodule

/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Thu Jun 20 10:03:13 2024
 Licensed to :EVALUATION USER*/

/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Thu Jun 20 10:03:13 2024
 Licensed to :EVALUATION USER*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module reg4 ( p_reset , m_clock , regin , regouta , regoutb , n_regin , n_regouta , n_regoutb , write , reada , readb );
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
  reg [15:0] r0;
  reg [15:0] r1;
  reg [15:0] r2;
  reg [15:0] r3;
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

   assign  _net_117 = (n_regin==2'b11);
   assign  _net_118 = (write&_net_117);
   assign  _net_119 = (n_regin==2'b10);
   assign  _net_120 = (write&_net_119);
   assign  _net_121 = (n_regin==2'b01);
   assign  _net_122 = (write&_net_121);
   assign  _net_123 = (n_regin==2'b00);
   assign  _net_124 = (write&_net_123);
   assign  _net_125 = (n_regouta==2'b11);
   assign  _net_126 = (reada&_net_125);
   assign  _net_127 = (n_regouta==2'b10);
   assign  _net_128 = (reada&_net_127);
   assign  _net_129 = (n_regouta==2'b01);
   assign  _net_130 = (reada&_net_129);
   assign  _net_131 = (n_regouta==2'b00);
   assign  _net_132 = (reada&_net_131);
   assign  _net_133 = (n_regoutb==2'b11);
   assign  _net_134 = (readb&_net_133);
   assign  _net_135 = (n_regoutb==2'b10);
   assign  _net_136 = (readb&_net_135);
   assign  _net_137 = (n_regoutb==2'b01);
   assign  _net_138 = (readb&_net_137);
   assign  _net_139 = (n_regoutb==2'b00);
   assign  _net_140 = (readb&_net_139);
   assign  regouta = ((_net_132)?r0:16'b0)|
    ((_net_130)?r1:16'b0)|
    ((_net_128)?r2:16'b0)|
    ((_net_126)?r3:16'b0);
   assign  regoutb = ((_net_140)?r0:16'b0)|
    ((_net_138)?r1:16'b0)|
    ((_net_136)?r2:16'b0)|
    ((_net_134)?r3:16'b0);
always @(posedge m_clock)
  begin
if ((_net_124)) 
      r0 <= regin;
end
always @(posedge m_clock)
  begin
if ((_net_122)) 
      r1 <= regin;
end
always @(posedge m_clock)
  begin
if ((_net_120)) 
      r2 <= regin;
end
always @(posedge m_clock)
  begin
if ((_net_118)) 
      r3 <= regin;
end
endmodule

/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Thu Jun 20 10:03:13 2024
 Licensed to :EVALUATION USER*/
