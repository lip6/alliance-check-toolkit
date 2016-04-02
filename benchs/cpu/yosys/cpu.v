/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 22:44:12 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module cpu ( p_reset , m_clock , dbusi , dbuso , adder , mread , mwrite );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [7:0] dbusi;
  wire [7:0] dbusi;
  output [7:0] dbuso;
  wire [7:0] dbuso;
  output [7:0] adder;
  wire [7:0] adder;
  output mread;
  wire mread;
  output mwrite;
  wire mwrite;
  reg [7:0] pc;
  reg [7:0] ins;
  reg [7:0] op;
  reg [7:0] count;
  reg [7:0] a;
  reg [7:0] i;
  reg ifetch;
  reg ofetch;
  reg exop;
  reg exec;
  wire [7:0] op1;
  wire [7:0] op2;
  wire [7:0] res;
  wire [7:0] pco;
  wire pcinc;
  wire add;
  wire br_taken;
  wire _proc_exec_set;
  wire _proc_exec_reset;
  wire _net_0;
  wire _proc_exop_set;
  wire _proc_exop_reset;
  wire _net_1;
  wire _proc_ofetch_set;
  wire _proc_ofetch_reset;
  wire _net_2;
  wire _proc_ifetch_set;
  wire _proc_ifetch_reset;
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

   assign  op1 = (((_net_95|_net_85))?i:8'b0)|
    ((_net_29)?op:8'b0)|
    (((_net_100|(_net_90|(_net_74|_net_22))))?a:8'b0);
   assign  op2 = (((_net_99|_net_94))?8'b00000001:8'b0)|
    (((_net_89|_net_84))?8'b11111111:8'b0)|
    (((_net_73|_net_28))?i:8'b0)|
    ((_net_21)?op:8'b0);
   assign  res = (op1+op2);
   assign  pco = pc;
   assign  pcinc = (_net_9|ifetch);
   assign  add = (_net_98|(_net_93|(_net_88|(_net_83|(_net_72|(_net_27|_net_20))))));
   assign  br_taken = (_net_56|_net_54);
   assign  _proc_exec_set = _net_14;
   assign  _proc_exec_reset = exec;
   assign  _net_0 = (_proc_exec_set|_proc_exec_reset);
   assign  _proc_exop_set = _net_8;
   assign  _proc_exop_reset = (_net_64|_net_61);
   assign  _net_1 = (_proc_exop_set|_proc_exop_reset);
   assign  _proc_ofetch_set = ifetch;
   assign  _proc_ofetch_reset = (_net_13|_net_7);
   assign  _net_2 = (_proc_ofetch_set|_proc_ofetch_reset);
   assign  _proc_ifetch_set = (exec|(_net_65|(_net_62|_net_5)));
   assign  _proc_ifetch_reset = ifetch;
   assign  _net_3 = (_proc_ifetch_set|_proc_ifetch_reset);
   assign  _net_4 = (count != 8'b00000000);
   assign  _net_5 = (count==8'b00000001);
   assign  _net_6 = (ins[7]);
   assign  _net_7 = (ofetch&_net_6);
   assign  _net_8 = (ofetch&_net_6);
   assign  _net_9 = (ofetch&_net_6);
   assign  _net_10 = (ofetch&_net_6);
   assign  _net_11 = (ofetch&_net_6);
   assign  _net_12 = (ofetch&_net_6);
   assign  _net_13 = (ofetch&(~_net_6));
   assign  _net_14 = (ofetch&(~_net_6));
   assign  _net_15 = (ins==8'b10101010);
   assign  _net_16 = (exop&_net_15);
   assign  _net_17 = (ins==8'b10101001);
   assign  _net_18 = (exop&_net_17);
   assign  _net_19 = (ins==8'b10101000);
   assign  _net_20 = (exop&_net_19);
   assign  _net_21 = (exop&_net_19);
   assign  _net_22 = (exop&_net_19);
   assign  _net_23 = (exop&_net_19);
   assign  _net_24 = (ins==8'b10011010);
   assign  _net_25 = (exop&_net_24);
   assign  _net_26 = (exop&_net_24);
   assign  _net_27 = (exop&_net_24);
   assign  _net_28 = (exop&_net_24);
   assign  _net_29 = (exop&_net_24);
   assign  _net_30 = (exop&_net_24);
   assign  _net_31 = (ins==8'b10011001);
   assign  _net_32 = (exop&_net_31);
   assign  _net_33 = (exop&_net_31);
   assign  _net_34 = (exop&_net_31);
   assign  _net_35 = (ins==8'b10011000);
   assign  _net_36 = (exop&_net_35);
   assign  _net_37 = (exop&_net_35);
   assign  _net_38 = (exop&_net_35);
   assign  _net_39 = (ins==8'b10001010);
   assign  _net_40 = (exop&_net_39);
   assign  _net_41 = (exop&_net_39);
   assign  _net_42 = (exop&_net_39);
   assign  _net_43 = (ins==8'b10001001);
   assign  _net_44 = (exop&_net_43);
   assign  _net_45 = (exop&_net_43);
   assign  _net_46 = (exop&_net_43);
   assign  _net_47 = (ins==8'b10001000);
   assign  _net_48 = (exop&_net_47);
   assign  _net_49 = (exop&_net_47);
   assign  _net_50 = (exop&_net_47);
   assign  _net_51 = (ins==8'b10000101);
   assign  _net_52 = (a==8'b00000000);
   assign  _net_53 = (exop&_net_51);
   assign  _net_54 = ((exop&_net_51)&_net_52);
   assign  _net_55 = (ins==8'b10000100);
   assign  _net_56 = (exop&_net_55);
   assign  _net_57 = (ins==8'b10000010);
   assign  _net_58 = (exop&_net_57);
   assign  _net_59 = (ins==8'b10000001);
   assign  _net_60 = (exop&_net_59);
   assign  _net_61 = (exop&br_taken);
   assign  _net_62 = (exop&br_taken);
   assign  _net_63 = (exop&br_taken);
   assign  _net_64 = (exop&(~br_taken));
   assign  _net_65 = (exop&(~br_taken));
   assign  _net_66 = (exop&(~br_taken));
   assign  _net_67 = (ins==8'b00001010);
   assign  _net_68 = (exec&_net_67);
   assign  _net_69 = (ins==8'b00001001);
   assign  _net_70 = (exec&_net_69);
   assign  _net_71 = (ins==8'b00001000);
   assign  _net_72 = (exec&_net_71);
   assign  _net_73 = (exec&_net_71);
   assign  _net_74 = (exec&_net_71);
   assign  _net_75 = (exec&_net_71);
   assign  _net_76 = (ins==8'b00000111);
   assign  _net_77 = (exec&_net_76);
   assign  _net_78 = (ins==8'b00000110);
   assign  _net_79 = (exec&_net_78);
   assign  _net_80 = (ins==8'b00000101);
   assign  _net_81 = (exec&_net_80);
   assign  _net_82 = (ins==8'b00000100);
   assign  _net_83 = (exec&_net_82);
   assign  _net_84 = (exec&_net_82);
   assign  _net_85 = (exec&_net_82);
   assign  _net_86 = (exec&_net_82);
   assign  _net_87 = (ins==8'b00000011);
   assign  _net_88 = (exec&_net_87);
   assign  _net_89 = (exec&_net_87);
   assign  _net_90 = (exec&_net_87);
   assign  _net_91 = (exec&_net_87);
   assign  _net_92 = (ins==8'b00000010);
   assign  _net_93 = (exec&_net_92);
   assign  _net_94 = (exec&_net_92);
   assign  _net_95 = (exec&_net_92);
   assign  _net_96 = (exec&_net_92);
   assign  _net_97 = (ins==8'b00000001);
   assign  _net_98 = (exec&_net_97);
   assign  _net_99 = (exec&_net_97);
   assign  _net_100 = (exec&_net_97);
   assign  _net_101 = (exec&_net_97);
   assign  dbuso = ((_net_33)?i:8'b0)|
    (((_net_37|_net_26))?a:8'b0);
   assign  adder = ((_net_41)?(op+i):8'b0)|
    (((_net_49|(_net_45|(_net_38|_net_34))))?op:8'b0)|
    ((_net_30)?res:8'b0)|
    (((_net_11|ifetch))?pco:8'b0);
   assign  mread = (_net_48|(_net_44|(_net_40|(_net_10|ifetch))));
   assign  mwrite = (_net_36|(_net_32|_net_25));
always @(posedge m_clock)
  begin
if (p_reset)
     pc <= 8'b00000000;
else if (((exec|_net_66))|(_net_63)|(_net_5)|(pcinc)) 
      pc <= (((exec|_net_66)) ?pc:8'b0)|
    ((_net_63) ?op:8'b0)|
    ((_net_5) ?8'b00000000:8'b0)|
    ((pcinc) ?(pc+8'b00000001):8'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     ins <= 8'b00000000;
else if ((ifetch)) 
      ins <= dbusi;
end
always @(posedge m_clock)
  begin
if ((_net_12)) 
      op <= dbusi;
end
always @(posedge m_clock)
  begin
if (p_reset)
     count <= 8'b11111111;
else if ((_net_4)) 
      count <= (count-8'b00000001);
end
always @(posedge m_clock)
  begin
if (p_reset)
     a <= 8'b00000000;
else if ((_net_81)|(_net_79)|(_net_77)|(_net_70)|(_net_68)|(_net_60)|((_net_50|_net_42))|((_net_101|(_net_91|(_net_75|_net_23))))|(_net_18)|(_net_16)) 
      a <= ((_net_81) ?({1'b0,(a[7:1])}):8'b0)|
    ((_net_79) ?({(a[6:0]),1'b0}):8'b0)|
    ((_net_77) ?({(a[7]),(a[7:1])}):8'b0)|
    ((_net_70) ?(a&i):8'b0)|
    ((_net_68) ?(a^i):8'b0)|
    ((_net_60) ?op:8'b0)|
    (((_net_50|_net_42)) ?dbusi:8'b0)|
    (((_net_101|(_net_91|(_net_75|_net_23)))) ?res:8'b0)|
    ((_net_18) ?(a&op):8'b0)|
    ((_net_16) ?(a^op):8'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     i <= 8'b00000000;
else if (((_net_96|_net_86))|(_net_58)|(_net_46)) 
      i <= (((_net_96|_net_86)) ?res:8'b0)|
    ((_net_58) ?op:8'b0)|
    ((_net_46) ?dbusi:8'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     ifetch <= 1'b0;
else if ((_net_3)) 
      ifetch <= _proc_ifetch_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     ofetch <= 1'b0;
else if ((_net_2)) 
      ofetch <= _proc_ofetch_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     exop <= 1'b0;
else if ((_net_1)) 
      exop <= _proc_exop_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     exec <= 1'b0;
else if ((_net_0)) 
      exec <= _proc_exec_set;
end
endmodule
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 22:44:12 2016
 Licensed to :EVALUATION USER
*/
