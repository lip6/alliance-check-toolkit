/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:52:30 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module cla4 ( p_reset , m_clock , a , b , ci , out , n , z , v , c , gm , pm , do );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [3:0] a;
  wire [3:0] a;
  input [3:0] b;
  wire [3:0] b;
  input ci;
  wire ci;
  output [3:0] out;
  wire [3:0] out;
  output n;
  wire n;
  output z;
  wire z;
  output v;
  wire v;
  output c;
  wire c;
  output gm;
  wire gm;
  output pm;
  wire pm;
  input do;
  wire do;
  wire c0;
  wire c1;
  wire c2;
  wire c3;
  wire g0;
  wire g1;
  wire g2;
  wire g3;
  wire p0;
  wire p1;
  wire p2;
  wire p3;

   assign  c0 = (g0|(p0&ci));
   assign  c1 = ((g1|(p1&g0))|((p1&p0)&ci));
   assign  c2 = (((g2|(p2&g1))|((p2&p1)&g0))|(((p2&p1)&p0)&ci));
   assign  c3 = ((((g3|(p3&g2))|((p3&p2)&g1))|(((p3&p2)&p1)&g0))|((((p3&p2)&p1)&p0)&ci));
   assign  g0 = ((a[0])&(b[0]));
   assign  g1 = ((a[1])&(b[1]));
   assign  g2 = ((a[2])&(b[2]));
   assign  g3 = ((a[3])&(b[3]));
   assign  p0 = ((a[0])^(b[0]));
   assign  p1 = ((a[1])^(b[1]));
   assign  p2 = ((a[2])^(b[2]));
   assign  p3 = ((a[3])^(b[3]));
   assign  out = ({(p3^c2),(p2^c1),(p1^c0),(p0^ci)});
   assign  n = (p3^c2);
   assign  z = ((((~(p3^c2))&(~(p2^c1)))&(~(p1^c0)))&(~(p0^ci)));
   assign  v = c2;
   assign  c = c3;
   assign  gm = (((g3|(p3&g2))|((p3&p2)&g1))|(((p3&p2)&p1)&g0));
   assign  pm = (((p3&p2)&p1)&p0);
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:52:30 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:52:30 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module cla16 ( p_reset , m_clock , a , b , ci , bi , out , n , z , v , c , do );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [15:0] a;
  wire [15:0] a;
  input [15:0] b;
  wire [15:0] b;
  input ci;
  wire ci;
  input bi;
  wire bi;
  output [15:0] out;
  wire [15:0] out;
  output n;
  wire n;
  output z;
  wire z;
  output v;
  wire v;
  output c;
  wire c;
  input do;
  wire do;
  wire c3;
  wire c7;
  wire c11;
  wire c14;
  wire c15;
  wire gm0;
  wire gm1;
  wire gm2;
  wire gm3;
  wire pm0;
  wire pm1;
  wire pm2;
  wire pm3;
  wire [3:0] _ad0_a;
  wire [3:0] _ad0_b;
  wire _ad0_ci;
  wire [3:0] _ad0_out;
  wire _ad0_n;
  wire _ad0_z;
  wire _ad0_v;
  wire _ad0_c;
  wire _ad0_gm;
  wire _ad0_pm;
  wire _ad0_do;
  wire _ad0_p_reset;
  wire _ad0_m_clock;
  wire [3:0] _ad1_a;
  wire [3:0] _ad1_b;
  wire _ad1_ci;
  wire [3:0] _ad1_out;
  wire _ad1_n;
  wire _ad1_z;
  wire _ad1_v;
  wire _ad1_c;
  wire _ad1_gm;
  wire _ad1_pm;
  wire _ad1_do;
  wire _ad1_p_reset;
  wire _ad1_m_clock;
  wire [3:0] _ad2_a;
  wire [3:0] _ad2_b;
  wire _ad2_ci;
  wire [3:0] _ad2_out;
  wire _ad2_n;
  wire _ad2_z;
  wire _ad2_v;
  wire _ad2_c;
  wire _ad2_gm;
  wire _ad2_pm;
  wire _ad2_do;
  wire _ad2_p_reset;
  wire _ad2_m_clock;
  wire [3:0] _ad3_a;
  wire [3:0] _ad3_b;
  wire _ad3_ci;
  wire [3:0] _ad3_out;
  wire _ad3_n;
  wire _ad3_z;
  wire _ad3_v;
  wire _ad3_c;
  wire _ad3_gm;
  wire _ad3_pm;
  wire _ad3_do;
  wire _ad3_p_reset;
  wire _ad3_m_clock;
  wire _net_0;
  wire _net_1;
  wire _net_2;
  wire _net_3;
  wire _net_4;
  wire _net_5;
  wire _net_6;
  wire _net_7;
  wire _net_8;
cla4 ad0 (.m_clock(m_clock), .p_reset(p_reset), .do(_ad0_do), .gm(_ad0_gm), .pm(_ad0_pm), .out(_ad0_out), .n(_ad0_n), .z(_ad0_z), .v(_ad0_v), .c(_ad0_c), .a(_ad0_a), .b(_ad0_b), .ci(_ad0_ci));
cla4 ad1 (.m_clock(m_clock), .p_reset(p_reset), .do(_ad1_do), .gm(_ad1_gm), .pm(_ad1_pm), .out(_ad1_out), .n(_ad1_n), .z(_ad1_z), .v(_ad1_v), .c(_ad1_c), .a(_ad1_a), .b(_ad1_b), .ci(_ad1_ci));
cla4 ad2 (.m_clock(m_clock), .p_reset(p_reset), .do(_ad2_do), .gm(_ad2_gm), .pm(_ad2_pm), .out(_ad2_out), .n(_ad2_n), .z(_ad2_z), .v(_ad2_v), .c(_ad2_c), .a(_ad2_a), .b(_ad2_b), .ci(_ad2_ci));
cla4 ad3 (.m_clock(m_clock), .p_reset(p_reset), .do(_ad3_do), .gm(_ad3_gm), .pm(_ad3_pm), .out(_ad3_out), .n(_ad3_n), .z(_ad3_z), .v(_ad3_v), .c(_ad3_c), .a(_ad3_a), .b(_ad3_b), .ci(_ad3_ci));

   assign  c3 = (gm0|(pm0&ci));
   assign  c7 = ((gm1|(pm1&gm0))|((pm1&pm0)&ci));
   assign  c11 = (((gm2|(pm2&gm1))|((pm2&pm1)&gm0))|(((pm2&pm1)&pm0)&ci));
   assign  c15 = ((((gm3|(pm3&gm2))|((pm3&pm2)&gm1))|(((pm3&pm2)&pm1)&gm0))|((((pm3&pm2)&pm1)&pm0)&ci));
   assign  gm0 = _ad0_gm;
   assign  gm1 = _ad1_gm;
   assign  gm2 = _ad2_gm;
   assign  gm3 = _ad3_gm;
   assign  pm0 = _ad0_pm;
   assign  pm1 = _ad1_pm;
   assign  pm2 = _ad2_pm;
   assign  pm3 = _ad3_pm;
   assign  _ad0_a = (a[3:0]);
   assign  _ad0_b = (b[3:0]);
   assign  _ad0_ci = ci;
   assign  _ad0_do = do;
   assign  _ad0_p_reset = p_reset;
   assign  _ad0_m_clock = m_clock;
   assign  _ad1_a = (a[7:4]);
   assign  _ad1_b = (b[7:4]);
   assign  _ad1_ci = c3;
   assign  _ad1_do = do;
   assign  _ad1_p_reset = p_reset;
   assign  _ad1_m_clock = m_clock;
   assign  _ad2_a = (a[11:8]);
   assign  _ad2_b = (b[11:8]);
   assign  _ad2_ci = c7;
   assign  _ad2_do = do;
   assign  _ad2_p_reset = p_reset;
   assign  _ad2_m_clock = m_clock;
   assign  _ad3_a = (a[15:12]);
   assign  _ad3_b = (b[15:12]);
   assign  _ad3_ci = c11;
   assign  _ad3_do = do;
   assign  _ad3_p_reset = p_reset;
   assign  _ad3_m_clock = m_clock;
   assign  _net_0 = (~bi);
   assign  _net_1 = (do&_net_0);
   assign  _net_2 = (do&_net_0);
   assign  _net_3 = (do&_net_0);
   assign  _net_4 = (do&_net_0);
   assign  _net_5 = (do&bi);
   assign  _net_6 = (do&bi);
   assign  _net_7 = (do&bi);
   assign  _net_8 = (do&bi);
   assign  out = ({_ad3_out,_ad2_out,_ad1_out,_ad0_out});
   assign  n = ((_net_5)?_ad1_n:1'b0)|
    ((_net_1)?_ad3_n:1'b0);
   assign  z = ((_net_6)?(_ad1_z&_ad0_z):1'b0)|
    ((_net_2)?(((_ad3_z&_ad2_z)&_ad1_z)&_ad0_z):1'b0);
   assign  v = ((_net_7)?(_ad1_v^c7):1'b0)|
    ((_net_3)?(_ad3_v^c15):1'b0);
   assign  c = ((_net_8)?c7:1'b0)|
    ((_net_4)?c15:1'b0);
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:52:30 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:52:30 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module bittest ( p_reset , m_clock , in , bi , n , z , do );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [15:0] in;
  wire [15:0] in;
  input bi;
  wire bi;
  output n;
  wire n;
  output z;
  wire z;
  input do;
  wire do;
  wire _net_9;
  wire _net_10;
  wire _net_11;
  wire _net_12;
  wire _net_13;

   assign  _net_9 = (do&bi);
   assign  _net_10 = (do&bi);
   assign  _net_11 = (~bi);
   assign  _net_12 = (do&_net_11);
   assign  _net_13 = (do&_net_11);
   assign  n = ((_net_12)?(in[15]):1'b0)|
    ((_net_9)?(in[7]):1'b0);
   assign  z = ((_net_13)?(~(|in)):1'b0)|
    ((_net_10)?(~(|(in[7:0]))):1'b0);
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:52:30 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:52:31 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module alu11 ( p_reset , m_clock , src , dst , ni , ci , bi , out , ccmask , ccout , cc , inc2 , dec2 , inc , dec , clr , com , neg , adc , sbc , tst , mmu , ror , rol , asr , asl , sxt , mov , cmp , bit_sig , bic , bis , add , sub , exor , swab );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [15:0] src;
  wire [15:0] src;
  input [15:0] dst;
  wire [15:0] dst;
  input ni;
  wire ni;
  input ci;
  wire ci;
  input bi;
  wire bi;
  output [15:0] out;
  wire [15:0] out;
  output [3:0] ccmask;
  wire [3:0] ccmask;
  output [3:0] ccout;
  wire [3:0] ccout;
  output cc;
  wire cc;
  input inc2;
  wire inc2;
  input dec2;
  wire dec2;
  input inc;
  wire inc;
  input dec;
  wire dec;
  input clr;
  wire clr;
  input com;
  wire com;
  input neg;
  wire neg;
  input adc;
  wire adc;
  input sbc;
  wire sbc;
  input tst;
  wire tst;
  input mmu;
  wire mmu;
  input ror;
  wire ror;
  input rol;
  wire rol;
  input asr;
  wire asr;
  input asl;
  wire asl;
  input sxt;
  wire sxt;
  input mov;
  wire mov;
  input cmp;
  wire cmp;
  input bit_sig;
  wire bit_sig;
  input bic;
  wire bic;
  input bis;
  wire bis;
  input add;
  wire add;
  input sub;
  wire sub;
  input exor;
  wire exor;
  input swab;
  wire swab;
  wire [15:0] _cla_a;
  wire [15:0] _cla_b;
  wire _cla_ci;
  wire _cla_bi;
  wire [15:0] _cla_out;
  wire _cla_n;
  wire _cla_z;
  wire _cla_v;
  wire _cla_c;
  wire _cla_do;
  wire _cla_p_reset;
  wire _cla_m_clock;
  wire [15:0] _btt_in;
  wire _btt_bi;
  wire _btt_n;
  wire _btt_z;
  wire _btt_do;
  wire _btt_p_reset;
  wire _btt_m_clock;
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
  wire [7:0] _net_70;
  wire _net_71;
bittest btt (.m_clock(m_clock), .p_reset(p_reset), .do(_btt_do), .n(_btt_n), .z(_btt_z), .in(_btt_in), .bi(_btt_bi));
cla16 cla (.m_clock(m_clock), .p_reset(p_reset), .do(_cla_do), .n(_cla_n), .z(_cla_z), .v(_cla_v), .c(_cla_c), .out(_cla_out), .a(_cla_a), .b(_cla_b), .ci(_cla_ci), .bi(_cla_bi));

   assign  _cla_a = ((add)?dst:16'b0)|
    (((sub|cmp))?(~dst):16'b0)|
    (((sbc|dec))?16'b1111111111111111:16'b0)|
    (((adc|(neg|inc)))?16'b0000000000000000:16'b0)|
    (((dec2|inc2))?src:16'b0);
   assign  _cla_b = ((neg)?(~src):16'b0)|
    (((sub|(add|(cmp|(sbc|(adc|(dec|inc)))))))?src:16'b0)|
    ((dec2)?16'b1111111111111110:16'b0)|
    ((inc2)?16'b0000000000000010:16'b0);
   assign  _cla_ci = ((sbc)?(~ci):1'b0)|
    ((adc)?ci:1'b0)|
    (((sub|(cmp|(neg|inc))))?1'b1:1'b0)|
    (((add|(dec|(dec2|inc2))))?1'b0:1'b0);
   assign  _cla_bi = (((cmp|(sbc|(adc|(neg|(dec|inc))))))?bi:1'b0)|
    (((sub|(add|(dec2|inc2))))?1'b0:1'b0);
   assign  _cla_do = (sub|(add|(cmp|(sbc|(adc|(neg|(dec|(inc|(dec2|inc2)))))))));
   assign  _cla_p_reset = p_reset;
   assign  _cla_m_clock = m_clock;
   assign  _btt_in = ((bit_sig)?(dst&src):16'b0)|
    (((mov|(mmu|tst)))?src:16'b0)|
    (((swab|(exor|(bis|(bic|(_net_64|(_net_57|(_net_49|(_net_42|(_net_34|(_net_27|(_net_22|(_net_18|com)))))))))))))?out:16'b0);
   assign  _btt_bi = (swab|(_net_63|(_net_48|(_net_33|_net_21))))|
    (((exor|(_net_56|(_net_41|(_net_26|_net_17)))))?1'b0:1'b0)|
    (((bis|(bic|(bit_sig|(mov|(mmu|(tst|com)))))))?bi:1'b0);
   assign  _btt_do = (swab|(exor|(bis|(bic|(bit_sig|(mov|(_net_62|(_net_55|(_net_47|(_net_40|(_net_32|(_net_25|(_net_20|(_net_16|(mmu|(tst|com))))))))))))))));
   assign  _btt_p_reset = p_reset;
   assign  _btt_m_clock = m_clock;
   assign  _net_14 = (~bi);
   assign  _net_15 = (ror&_net_14);
   assign  _net_16 = (ror&_net_14);
   assign  _net_17 = (ror&_net_14);
   assign  _net_18 = (ror&_net_14);
   assign  _net_19 = (ror&bi);
   assign  _net_20 = (ror&bi);
   assign  _net_21 = (ror&bi);
   assign  _net_22 = (ror&bi);
   assign  _net_23 = (~bi);
   assign  _net_24 = (rol&_net_23);
   assign  _net_25 = (rol&_net_23);
   assign  _net_26 = (rol&_net_23);
   assign  _net_27 = (rol&_net_23);
   assign  _net_28 = (rol&_net_23);
   assign  _net_29 = (rol&_net_23);
   assign  _net_30 = (rol&_net_23);
   assign  _net_31 = (rol&bi);
   assign  _net_32 = (rol&bi);
   assign  _net_33 = (rol&bi);
   assign  _net_34 = (rol&bi);
   assign  _net_35 = (rol&bi);
   assign  _net_36 = (rol&bi);
   assign  _net_37 = (rol&bi);
   assign  _net_38 = (~bi);
   assign  _net_39 = (asr&_net_38);
   assign  _net_40 = (asr&_net_38);
   assign  _net_41 = (asr&_net_38);
   assign  _net_42 = (asr&_net_38);
   assign  _net_43 = (asr&_net_38);
   assign  _net_44 = (asr&_net_38);
   assign  _net_45 = (asr&_net_38);
   assign  _net_46 = (asr&bi);
   assign  _net_47 = (asr&bi);
   assign  _net_48 = (asr&bi);
   assign  _net_49 = (asr&bi);
   assign  _net_50 = (asr&bi);
   assign  _net_51 = (asr&bi);
   assign  _net_52 = (asr&bi);
   assign  _net_53 = (~bi);
   assign  _net_54 = (asl&_net_53);
   assign  _net_55 = (asl&_net_53);
   assign  _net_56 = (asl&_net_53);
   assign  _net_57 = (asl&_net_53);
   assign  _net_58 = (asl&_net_53);
   assign  _net_59 = (asl&_net_53);
   assign  _net_60 = (asl&_net_53);
   assign  _net_61 = (asl&bi);
   assign  _net_62 = (asl&bi);
   assign  _net_63 = (asl&bi);
   assign  _net_64 = (asl&bi);
   assign  _net_65 = (asl&bi);
   assign  _net_66 = (asl&bi);
   assign  _net_67 = (asl&bi);
   assign  _net_68 = (~bi);
   assign  _net_69 = (mov&_net_68);
   assign  _net_70 = (src[7:0]);
   assign  _net_71 = (mov&bi);
   assign  out = ((swab)?({(src[7:0]),(src[15:8])}):16'b0)|
    ((exor)?(dst^src):16'b0)|
    ((bis)?(dst|src):16'b0)|
    ((bic)?(dst&(~src)):16'b0)|
    ((_net_71)?({({(_net_70[7]),(_net_70[7]),(_net_70[7]),(_net_70[7]),(_net_70[7]),(_net_70[7]),(_net_70[7]),(_net_70[7])}),(src[7:0])}):16'b0)|
    ((_net_69)?src:16'b0)|
    ((sxt)?({({ni,ni,ni,ni,ni,ni,ni,ni,ni,ni,ni,ni,ni,ni,ni}),ni}):16'b0)|
    ((_net_61)?({8'b00000000,(src[6:0]),1'b0}):16'b0)|
    ((_net_54)?({(src[14:0]),1'b0}):16'b0)|
    ((_net_46)?({8'b00000000,(src[7]),(src[7:1])}):16'b0)|
    ((_net_39)?({(src[15]),(src[15:1])}):16'b0)|
    ((_net_31)?({8'b00000000,(src[6:0]),ci}):16'b0)|
    ((_net_24)?({(src[14:0]),ci}):16'b0)|
    ((_net_19)?({8'b00000000,ci,(src[7:1])}):16'b0)|
    ((_net_15)?({ci,(src[15:1])}):16'b0)|
    ((com)?(~src):16'b0)|
    ((clr)?16'b0000000000000000:16'b0)|
    (((sub|(add|(sbc|(adc|(neg|(dec|(inc|(dec2|inc2)))))))))?_cla_out:16'b0);
   assign  ccmask = ((exor)?4'b1100:4'b0)|
    ((sxt)?4'b0100:4'b0)|
    (((swab|(sub|(add|(cmp|(_net_67|(_net_60|(_net_52|(_net_45|(_net_37|(_net_30|(ror|(tst|(sbc|(adc|(neg|(com|clr)))))))))))))))))?4'b1111:4'b0)|
    (((bis|(bic|(bit_sig|(mov|(mmu|(dec|inc)))))))?4'b1110:4'b0);
   assign  ccout = ((sxt)?({1'b0,(~ni),2'b00}):4'b0)|
    ((_net_66)?({_btt_n,_btt_z,((src[7])^(src[6])),(src[7])}):4'b0)|
    ((_net_59)?({_btt_n,_btt_z,((src[15])^(src[14])),(src[15])}):4'b0)|
    ((_net_51)?({_btt_n,_btt_z,((src[7])^(src[0])),(src[0])}):4'b0)|
    ((_net_44)?({_btt_n,_btt_z,((src[15])^(src[0])),(src[0])}):4'b0)|
    ((_net_36)?({_btt_n,_btt_z,(ci^(src[7])),(src[7])}):4'b0)|
    ((_net_29)?({_btt_n,_btt_z,(ci^(src[15])),(src[15])}):4'b0)|
    ((ror)?({_btt_n,_btt_z,(ci^(src[0])),(src[0])}):4'b0)|
    (((swab|(exor|(bis|(bic|(bit_sig|(mov|(mmu|tst))))))))?({_btt_n,_btt_z,2'b00}):4'b0)|
    (((sub|(cmp|sbc)))?({_cla_n,_cla_z,_cla_v,(~_cla_c)}):4'b0)|
    (((add|adc))?({_cla_n,_cla_z,_cla_v,_cla_c}):4'b0)|
    ((neg)?({_cla_n,_cla_z,_cla_v,(~_cla_z)}):4'b0)|
    ((com)?({_btt_n,_btt_z,2'b01}):4'b0)|
    ((clr)?4'b0100:4'b0)|
    (((dec|inc))?({_cla_n,_cla_z,_cla_v,1'b0}):4'b0);
   assign  cc = (swab|(exor|(sub|(add|(bis|(bic|(bit_sig|(cmp|(mov|(sxt|(_net_65|(_net_58|(_net_50|(_net_43|(_net_35|(_net_28|(ror|(mmu|(tst|(sbc|(adc|(neg|(com|(clr|(dec|inc)))))))))))))))))))))))));
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:52:31 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:52:33 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module data11 ( p_reset , m_clock , dbi , dbo , dba , opc , psw , mmu , swab , exor , sub , add , bis , bic , bit_sig , cmp , mov , sxt , asl , asr , rol , ror , tst , sbc , adc , neg , com , clr , dec , inc , dec2 , inc2 , setPCrom , dbiFP , FPpc , save_stat , adrPC , SRCadr , DSTadr , SELpc , SELadr , SELsrc , SELdst , ALUcc_cap , ALUsrc , ALUdstb , ALUdst , ALUsp , ALUpc , ADRreg , SRCreg , PCreg , DSTreg , ALUreg , setReg2 , setReg , regSEL2 , regSEL , selALU1 , ofs6ALU2 , ofs8ALU2 , adrALU1 , srcALU2 , dstALU2 , srcALU1 , dstALU1 , spALU1 , pcALU1 , dboAdr , dboSrc , dboDst , dboSEL , dbaAdr , dbaSrc , dbaDst , dbaSP , dbaPC , dbiPS , dbiReg , dbiPC , dbiSrc , dbiDst , setopc , vectorPS , reset_byte , kernel_mode , change_mode , change_opr , cctaken , ccset , ccclr , segerr , svc , iot , emt , bpt , err , buserr , ccget , spl , ashc , ash , mul , oddReg , clrADR , tstSRCADR , tstSRC , div_fin1 , div_fin0 , div_ini2 , div_ini1 , div_ini0 , div_end , div , ashdone , alucc , taken );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [15:0] dbi;
  wire [15:0] dbi;
  output [15:0] dbo;
  wire [15:0] dbo;
  output [15:0] dba;
  wire [15:0] dba;
  output [15:0] opc;
  wire [15:0] opc;
  output [15:0] psw;
  wire [15:0] psw;
  input mmu;
  wire mmu;
  input swab;
  wire swab;
  input exor;
  wire exor;
  input sub;
  wire sub;
  input add;
  wire add;
  input bis;
  wire bis;
  input bic;
  wire bic;
  input bit_sig;
  wire bit_sig;
  input cmp;
  wire cmp;
  input mov;
  wire mov;
  input sxt;
  wire sxt;
  input asl;
  wire asl;
  input asr;
  wire asr;
  input rol;
  wire rol;
  input ror;
  wire ror;
  input tst;
  wire tst;
  input sbc;
  wire sbc;
  input adc;
  wire adc;
  input neg;
  wire neg;
  input com;
  wire com;
  input clr;
  wire clr;
  input dec;
  wire dec;
  input inc;
  wire inc;
  input dec2;
  wire dec2;
  input inc2;
  wire inc2;
  input setPCrom;
  wire setPCrom;
  input dbiFP;
  wire dbiFP;
  input FPpc;
  wire FPpc;
  input save_stat;
  wire save_stat;
  input adrPC;
  wire adrPC;
  input SRCadr;
  wire SRCadr;
  input DSTadr;
  wire DSTadr;
  input SELpc;
  wire SELpc;
  input SELadr;
  wire SELadr;
  input SELsrc;
  wire SELsrc;
  input SELdst;
  wire SELdst;
  input ALUcc_cap;
  wire ALUcc_cap;
  input ALUsrc;
  wire ALUsrc;
  input ALUdstb;
  wire ALUdstb;
  input ALUdst;
  wire ALUdst;
  input ALUsp;
  wire ALUsp;
  input ALUpc;
  wire ALUpc;
  input ADRreg;
  wire ADRreg;
  input SRCreg;
  wire SRCreg;
  input PCreg;
  wire PCreg;
  input DSTreg;
  wire DSTreg;
  input ALUreg;
  wire ALUreg;
  input setReg2;
  wire setReg2;
  input setReg;
  wire setReg;
  input regSEL2;
  wire regSEL2;
  input regSEL;
  wire regSEL;
  input selALU1;
  wire selALU1;
  input ofs6ALU2;
  wire ofs6ALU2;
  input ofs8ALU2;
  wire ofs8ALU2;
  input adrALU1;
  wire adrALU1;
  input srcALU2;
  wire srcALU2;
  input dstALU2;
  wire dstALU2;
  input srcALU1;
  wire srcALU1;
  input dstALU1;
  wire dstALU1;
  input spALU1;
  wire spALU1;
  input pcALU1;
  wire pcALU1;
  input dboAdr;
  wire dboAdr;
  input dboSrc;
  wire dboSrc;
  input dboDst;
  wire dboDst;
  input dboSEL;
  wire dboSEL;
  input dbaAdr;
  wire dbaAdr;
  input dbaSrc;
  wire dbaSrc;
  input dbaDst;
  wire dbaDst;
  input dbaSP;
  wire dbaSP;
  input dbaPC;
  wire dbaPC;
  input dbiPS;
  wire dbiPS;
  input dbiReg;
  wire dbiReg;
  input dbiPC;
  wire dbiPC;
  input dbiSrc;
  wire dbiSrc;
  input dbiDst;
  wire dbiDst;
  input setopc;
  wire setopc;
  input vectorPS;
  wire vectorPS;
  input reset_byte;
  wire reset_byte;
  input kernel_mode;
  wire kernel_mode;
  input change_mode;
  wire change_mode;
  input change_opr;
  wire change_opr;
  input cctaken;
  wire cctaken;
  input ccset;
  wire ccset;
  input ccclr;
  wire ccclr;
  input segerr;
  wire segerr;
  input svc;
  wire svc;
  input iot;
  wire iot;
  input emt;
  wire emt;
  input bpt;
  wire bpt;
  input err;
  wire err;
  input buserr;
  wire buserr;
  input ccget;
  wire ccget;
  input spl;
  wire spl;
  input ashc;
  wire ashc;
  input ash;
  wire ash;
  input mul;
  wire mul;
  input oddReg;
  wire oddReg;
  input clrADR;
  wire clrADR;
  input tstSRCADR;
  wire tstSRCADR;
  input tstSRC;
  wire tstSRC;
  input div_fin1;
  wire div_fin1;
  input div_fin0;
  wire div_fin0;
  input div_ini2;
  wire div_ini2;
  input div_ini1;
  wire div_ini1;
  input div_ini0;
  wire div_ini0;
  input div_end;
  wire div_end;
  input div;
  wire div;
  output ashdone;
  wire ashdone;
  output [3:0] alucc;
  wire [3:0] alucc;
  output taken;
  wire taken;
  reg [15:0] PC;
  reg [15:0] R0;
  reg [15:0] R1;
  reg [15:0] R2;
  reg [15:0] R3;
  reg [15:0] R4;
  reg [15:0] R5;
  reg [15:0] kSP;
  reg [15:0] uSP;
  reg OPC_BYTE;
  reg [14:0] OPC;
  reg [15:0] SRC;
  reg [15:0] DST;
  reg [15:0] ADR;
  reg [1:0] cmode;
  reg [1:0] pmode;
  reg [2:0] priority;
  reg trapbit;
  reg fn;
  reg fz;
  reg fv;
  reg fc;
  reg multmp;
  reg dividen;
  reg divider;
  wire [15:0] ALU1;
  wire [15:0] ALU2;
  wire [15:0] REGsel;
  wire [15:0] REGin;
  wire [15:0] mul_HI;
  wire [15:0] _alu_src;
  wire [15:0] _alu_dst;
  wire _alu_ni;
  wire _alu_ci;
  wire _alu_bi;
  wire [15:0] _alu_out;
  wire [3:0] _alu_ccmask;
  wire [3:0] _alu_ccout;
  wire _alu_cc;
  wire _alu_inc2;
  wire _alu_dec2;
  wire _alu_inc;
  wire _alu_dec;
  wire _alu_clr;
  wire _alu_com;
  wire _alu_neg;
  wire _alu_adc;
  wire _alu_sbc;
  wire _alu_tst;
  wire _alu_mmu;
  wire _alu_ror;
  wire _alu_rol;
  wire _alu_asr;
  wire _alu_asl;
  wire _alu_sxt;
  wire _alu_mov;
  wire _alu_cmp;
  wire _alu_bit;
  wire _alu_bic;
  wire _alu_bis;
  wire _alu_add;
  wire _alu_sub;
  wire _alu_exor;
  wire _alu_swab;
  wire _alu_p_reset;
  wire _alu_m_clock;
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
alu11 alu (.m_clock(m_clock), .p_reset(p_reset), .swab(_alu_swab), .exor(_alu_exor), .sub(_alu_sub), .add(_alu_add), .bis(_alu_bis), .bic(_alu_bic), .bit_sig(_alu_bit), .cmp(_alu_cmp), .mov(_alu_mov), .sxt(_alu_sxt), .asl(_alu_asl), .asr(_alu_asr), .rol(_alu_rol), .ror(_alu_ror), .mmu(_alu_mmu), .tst(_alu_tst), .sbc(_alu_sbc), .adc(_alu_adc), .neg(_alu_neg), .com(_alu_com), .clr(_alu_clr), .dec(_alu_dec), .inc(_alu_inc), .dec2(_alu_dec2), .inc2(_alu_inc2), .cc(_alu_cc), .ccmask(_alu_ccmask), .ccout(_alu_ccout), .out(_alu_out), .ni(_alu_ni), .ci(_alu_ci), .bi(_alu_bi), .src(_alu_src), .dst(_alu_dst));

   assign  ALU1 = ((selALU1)?REGsel:16'b0)|
    ((adrALU1)?ADR:16'b0)|
    ((srcALU1)?SRC:16'b0)|
    ((dstALU1)?DST:16'b0)|
    ((_net_95)?kSP:16'b0)|
    ((_net_93)?uSP:16'b0)|
    ((pcALU1)?PC:16'b0);
   assign  ALU2 = ((ofs6ALU2)?({8'b00000000,1'b0,(opc[5:0]),1'b0}):16'b0)|
    ((ofs8ALU2)?({({({(opc[7]),(opc[7]),(opc[7]),(opc[7]),(opc[7]),(opc[7])}),(opc[7])}),(opc[7:0]),1'b0}):16'b0)|
    ((srcALU2)?SRC:16'b0)|
    ((dstALU2)?DST:16'b0);
   assign  REGsel = (((_net_131|_net_113))?R0:16'b0)|
    (((_net_129|_net_111))?R1:16'b0)|
    (((_net_127|_net_109))?R2:16'b0)|
    (((_net_125|_net_107))?R3:16'b0)|
    (((_net_123|_net_105))?R4:16'b0)|
    (((_net_121|_net_103))?R5:16'b0)|
    (((_net_119|_net_101))?PC:16'b0)|
    (((_net_117|_net_99))?kSP:16'b0)|
    (((_net_115|_net_97))?uSP:16'b0);
   assign  REGin = ((PCreg)?PC:16'b0)|
    ((ADRreg)?ADR:16'b0)|
    ((SRCreg)?SRC:16'b0)|
    ((DSTreg)?DST:16'b0)|
    ((ALUreg)?_alu_out:16'b0)|
    ((dbiReg)?dbi:16'b0);
   assign  mul_HI = (((_net_186|_net_181))?_alu_out:16'b0)|
    (((_net_188|_net_176))?ADR:16'b0);
   assign  _alu_src = (((div|(_net_218|(_net_214|_net_210))))?SRC:16'b0)|
    (((_net_270|(_net_260|(_net_249|(_net_241|(_net_195|_net_191))))))?DST:16'b0)|
    (((_net_222|(_net_206|(_net_185|_net_180))))?ADR:16'b0)|
    (((sub|(swab|(exor|(add|(bis|(bic|(bit_sig|(cmp|(mov|(sxt|(asl|(asr|(rol|(ror|(mmu|(tst|(sbc|(adc|(neg|(com|(clr|(dec|(inc|(dec2|inc2)))))))))))))))))))))))))?ALU1:16'b0);
   assign  _alu_dst = (((div|(_net_184|_net_179)))?DST:16'b0)|
    (((sub|(exor|(add|(bis|(bic|(bit_sig|cmp)))))))?ALU2:16'b0);
   assign  _alu_ni = fn;
   assign  _alu_ci = fc;
   assign  _alu_bi = OPC_BYTE;
   assign  _alu_inc2 = inc2;
   assign  _alu_dec2 = dec2;
   assign  _alu_inc = (_net_269|(_net_248|inc));
   assign  _alu_dec = (_net_259|(_net_240|dec));
   assign  _alu_clr = clr;
   assign  _alu_com = (_net_209|com);
   assign  _alu_neg = (_net_221|(_net_217|(_net_213|(_net_205|(_net_190|neg)))));
   assign  _alu_adc = adc;
   assign  _alu_sbc = sbc;
   assign  _alu_tst = (_net_194|tst);
   assign  _alu_mmu = mmu;
   assign  _alu_ror = ror;
   assign  _alu_rol = rol;
   assign  _alu_asr = asr;
   assign  _alu_asl = asl;
   assign  _alu_sxt = sxt;
   assign  _alu_mov = mov;
   assign  _alu_cmp = cmp;
   assign  _alu_bit = bit_sig;
   assign  _alu_bic = bic;
   assign  _alu_bis = bis;
   assign  _alu_add = (_net_183|add);
   assign  _alu_sub = (div|(_net_178|sub));
   assign  _alu_exor = exor;
   assign  _alu_swab = swab;
   assign  _alu_p_reset = p_reset;
   assign  _alu_m_clock = m_clock;
   assign  _net_72 = (_alu_ccmask[0]);
   assign  _net_73 = (ALUcc_cap&_net_72);
   assign  _net_74 = (_alu_ccmask[1]);
   assign  _net_75 = (ALUcc_cap&_net_74);
   assign  _net_76 = (_alu_ccmask[2]);
   assign  _net_77 = (ALUcc_cap&_net_76);
   assign  _net_78 = (_alu_ccmask[3]);
   assign  _net_79 = (ALUcc_cap&_net_78);
   assign  _net_80 = (OPC[0]);
   assign  _net_81 = (ccset&_net_80);
   assign  _net_82 = (OPC[1]);
   assign  _net_83 = (ccset&_net_82);
   assign  _net_84 = (OPC[2]);
   assign  _net_85 = (ccset&_net_84);
   assign  _net_86 = (OPC[3]);
   assign  _net_87 = (ccset&_net_86);
   assign  _net_88 = (&cmode);
   assign  _net_89 = (dbaSP&_net_88);
   assign  _net_90 = (~(|cmode));
   assign  _net_91 = (dbaSP&_net_90);
   assign  _net_92 = (&cmode);
   assign  _net_93 = (spALU1&_net_92);
   assign  _net_94 = (~(|cmode));
   assign  _net_95 = (spALU1&_net_94);
   assign  _net_96 = (((OPC[2:0])==3'b110)&(&cmode));
   assign  _net_97 = (regSEL&_net_96);
   assign  _net_98 = (((OPC[2:0])==3'b110)&(~(|cmode)));
   assign  _net_99 = (regSEL&_net_98);
   assign  _net_100 = ((OPC[2:0])==3'b111);
   assign  _net_101 = (regSEL&_net_100);
   assign  _net_102 = ((OPC[2:0])==3'b101);
   assign  _net_103 = (regSEL&_net_102);
   assign  _net_104 = ((OPC[2:0])==3'b100);
   assign  _net_105 = (regSEL&_net_104);
   assign  _net_106 = ((OPC[2:0])==3'b011);
   assign  _net_107 = (regSEL&_net_106);
   assign  _net_108 = ((OPC[2:0])==3'b010);
   assign  _net_109 = (regSEL&_net_108);
   assign  _net_110 = ((OPC[2:0])==3'b001);
   assign  _net_111 = (regSEL&_net_110);
   assign  _net_112 = ((OPC[2:0])==3'b000);
   assign  _net_113 = (regSEL&_net_112);
   assign  _net_114 = (((OPC[8:6])==3'b110)&(&cmode));
   assign  _net_115 = (regSEL2&_net_114);
   assign  _net_116 = (((OPC[8:6])==3'b110)&(~(|cmode)));
   assign  _net_117 = (regSEL2&_net_116);
   assign  _net_118 = ((OPC[8:6])==3'b111);
   assign  _net_119 = (regSEL2&_net_118);
   assign  _net_120 = ((OPC[8:6])==3'b101);
   assign  _net_121 = (regSEL2&_net_120);
   assign  _net_122 = ((OPC[8:6])==3'b100);
   assign  _net_123 = (regSEL2&_net_122);
   assign  _net_124 = ((OPC[8:6])==3'b011);
   assign  _net_125 = (regSEL2&_net_124);
   assign  _net_126 = ((OPC[8:6])==3'b010);
   assign  _net_127 = (regSEL2&_net_126);
   assign  _net_128 = ((OPC[8:6])==3'b001);
   assign  _net_129 = (regSEL2&_net_128);
   assign  _net_130 = ((OPC[8:6])==3'b000);
   assign  _net_131 = (regSEL2&_net_130);
   assign  _net_132 = (((OPC[2:0])==3'b110)&(&cmode));
   assign  _net_133 = (setReg&_net_132);
   assign  _net_134 = (((OPC[2:0])==3'b110)&(~(|cmode)));
   assign  _net_135 = (setReg&_net_134);
   assign  _net_136 = ((OPC[2:0])==3'b111);
   assign  _net_137 = (setReg&_net_136);
   assign  _net_138 = ((OPC[2:0])==3'b101);
   assign  _net_139 = (setReg&_net_138);
   assign  _net_140 = ((OPC[2:0])==3'b100);
   assign  _net_141 = (setReg&_net_140);
   assign  _net_142 = ((OPC[2:0])==3'b011);
   assign  _net_143 = (setReg&_net_142);
   assign  _net_144 = ((OPC[2:0])==3'b010);
   assign  _net_145 = (setReg&_net_144);
   assign  _net_146 = ((OPC[2:0])==3'b001);
   assign  _net_147 = (setReg&_net_146);
   assign  _net_148 = ((OPC[2:0])==3'b000);
   assign  _net_149 = (setReg&_net_148);
   assign  _net_150 = (((OPC[8:6])==3'b110)&(&cmode));
   assign  _net_151 = (setReg2&_net_150);
   assign  _net_152 = (((OPC[8:6])==3'b110)&(~(|cmode)));
   assign  _net_153 = (setReg2&_net_152);
   assign  _net_154 = ((OPC[8:6])==3'b111);
   assign  _net_155 = (setReg2&_net_154);
   assign  _net_156 = ((OPC[8:6])==3'b101);
   assign  _net_157 = (setReg2&_net_156);
   assign  _net_158 = ((OPC[8:6])==3'b100);
   assign  _net_159 = (setReg2&_net_158);
   assign  _net_160 = ((OPC[8:6])==3'b011);
   assign  _net_161 = (setReg2&_net_160);
   assign  _net_162 = ((OPC[8:6])==3'b010);
   assign  _net_163 = (setReg2&_net_162);
   assign  _net_164 = ((OPC[8:6])==3'b001);
   assign  _net_165 = (setReg2&_net_164);
   assign  _net_166 = ((OPC[8:6])==3'b000);
   assign  _net_167 = (setReg2&_net_166);
   assign  _net_168 = (&cmode);
   assign  _net_169 = (ALUsp&_net_168);
   assign  _net_170 = (~(|cmode));
   assign  _net_171 = (ALUsp&_net_170);
   assign  _net_172 = (~OPC_BYTE);
   assign  _net_173 = (ALUdstb&_net_172);
   assign  _net_174 = (ALUdstb&OPC_BYTE);
   assign  _net_175 = (({(SRC[0]),multmp})==2'b11);
   assign  _net_176 = (mul&_net_175);
   assign  _net_177 = (({(SRC[0]),multmp})==2'b10);
   assign  _net_178 = (mul&_net_177);
   assign  _net_179 = (mul&_net_177);
   assign  _net_180 = (mul&_net_177);
   assign  _net_181 = (mul&_net_177);
   assign  _net_182 = (({(SRC[0]),multmp})==2'b01);
   assign  _net_183 = (mul&_net_182);
   assign  _net_184 = (mul&_net_182);
   assign  _net_185 = (mul&_net_182);
   assign  _net_186 = (mul&_net_182);
   assign  _net_187 = (({(SRC[0]),multmp})==2'b00);
   assign  _net_188 = (mul&_net_187);
   assign  _net_189 = (DST[15]);
   assign  _net_190 = (div_ini0&_net_189);
   assign  _net_191 = (div_ini0&_net_189);
   assign  _net_192 = (div_ini0&_net_189);
   assign  _net_193 = (~(DST[15]));
   assign  _net_194 = (div_ini0&_net_193);
   assign  _net_195 = (div_ini0&_net_193);
   assign  _net_196 = (~(_alu_ccout[2]));
   assign  _net_197 = (div_ini0&_net_193);
   assign  _net_198 = ((div_ini0&_net_193)&_net_196);
   assign  _net_199 = ((div_ini0&_net_193)&_net_196);
   assign  _net_200 = (_alu_ccout[2]);
   assign  _net_201 = (div_ini0&_net_193);
   assign  _net_202 = ((div_ini0&_net_193)&_net_200);
   assign  _net_203 = ((div_ini0&_net_193)&_net_200);
   assign  _net_204 = (SRC[15]);
   assign  _net_205 = (div_ini1&_net_204);
   assign  _net_206 = (div_ini1&_net_204);
   assign  _net_207 = (div_ini1&_net_204);
   assign  _net_208 = (dividen&(~fv));
   assign  _net_209 = (div_ini2&_net_208);
   assign  _net_210 = (div_ini2&_net_208);
   assign  _net_211 = (div_ini2&_net_208);
   assign  _net_212 = (dividen&fv);
   assign  _net_213 = (div_ini2&_net_212);
   assign  _net_214 = (div_ini2&_net_212);
   assign  _net_215 = (div_ini2&_net_212);
   assign  _net_216 = (((~dividen)&divider)|(dividen&(~divider)));
   assign  _net_217 = (div_fin0&_net_216);
   assign  _net_218 = (div_fin0&_net_216);
   assign  _net_219 = (div_fin0&_net_216);
   assign  _net_220 = ((dividen&(~divider))|(dividen&divider));
   assign  _net_221 = (div_fin1&_net_220);
   assign  _net_222 = (div_fin1&_net_220);
   assign  _net_223 = (div_fin1&_net_220);
   assign  _net_224 = (_alu_out[15]);
   assign  _net_225 = (~div_end);
   assign  _net_226 = (div&_net_224);
   assign  _net_227 = ((div&_net_224)&_net_225);
   assign  _net_228 = ((div&_net_224)&div_end);
   assign  _net_229 = (div&_net_224);
   assign  _net_230 = (~(_alu_out[15]));
   assign  _net_231 = (~div_end);
   assign  _net_232 = (div&_net_230);
   assign  _net_233 = ((div&_net_230)&_net_231);
   assign  _net_234 = ((div&_net_230)&div_end);
   assign  _net_235 = ((div&_net_230)&div_end);
   assign  _net_236 = (div&_net_230);
   assign  _net_237 = (~((DST[5:0])==6'b000000));
   assign  _net_238 = (~(DST[5]));
   assign  _net_239 = (ash&_net_237);
   assign  _net_240 = ((ash&_net_237)&_net_238);
   assign  _net_241 = ((ash&_net_237)&_net_238);
   assign  _net_242 = ((ash&_net_237)&_net_238);
   assign  _net_243 = ((ash&_net_237)&_net_238);
   assign  _net_244 = ((ash&_net_237)&_net_238);
   assign  _net_245 = ((ash&_net_237)&_net_238);
   assign  _net_246 = (DST[5]);
   assign  _net_247 = (ash&_net_237);
   assign  _net_248 = ((ash&_net_237)&_net_246);
   assign  _net_249 = ((ash&_net_237)&_net_246);
   assign  _net_250 = ((ash&_net_237)&_net_246);
   assign  _net_251 = ((ash&_net_237)&_net_246);
   assign  _net_252 = ((ash&_net_237)&_net_246);
   assign  _net_253 = ((ash&_net_237)&_net_246);
   assign  _net_254 = ((DST[5:0])==6'b000000);
   assign  _net_255 = (ash&_net_254);
   assign  _net_256 = (~((DST[5:0])==6'b000000));
   assign  _net_257 = (~(DST[5]));
   assign  _net_258 = (ashc&_net_256);
   assign  _net_259 = ((ashc&_net_256)&_net_257);
   assign  _net_260 = ((ashc&_net_256)&_net_257);
   assign  _net_261 = ((ashc&_net_256)&_net_257);
   assign  _net_262 = ((ashc&_net_256)&_net_257);
   assign  _net_263 = ((ashc&_net_256)&_net_257);
   assign  _net_264 = ((ashc&_net_256)&_net_257);
   assign  _net_265 = ((ashc&_net_256)&_net_257);
   assign  _net_266 = ((ashc&_net_256)&_net_257);
   assign  _net_267 = (DST[5]);
   assign  _net_268 = (ashc&_net_256);
   assign  _net_269 = ((ashc&_net_256)&_net_267);
   assign  _net_270 = ((ashc&_net_256)&_net_267);
   assign  _net_271 = ((ashc&_net_256)&_net_267);
   assign  _net_272 = ((ashc&_net_256)&_net_267);
   assign  _net_273 = ((ashc&_net_256)&_net_267);
   assign  _net_274 = ((ashc&_net_256)&_net_267);
   assign  _net_275 = ((ashc&_net_256)&_net_267);
   assign  _net_276 = ((ashc&_net_256)&_net_267);
   assign  _net_277 = ((DST[5:0])==6'b000000);
   assign  _net_278 = (ashc&_net_277);
   assign  dbo = ((dboAdr)?ADR:16'b0)|
    ((dboSrc)?SRC:16'b0)|
    ((dboDst)?DST:16'b0)|
    ((dboSEL)?REGsel:16'b0);
   assign  dba = ((dbaAdr)?ADR:16'b0)|
    ((dbaSrc)?SRC:16'b0)|
    ((dbaDst)?DST:16'b0)|
    ((_net_91)?kSP:16'b0)|
    ((_net_89)?uSP:16'b0)|
    ((dbaPC)?PC:16'b0);
   assign  opc = ({OPC_BYTE,OPC});
   assign  psw = ({cmode,pmode,4'b0000,priority,trapbit,fn,fz,fv,fc});
   assign  ashdone = (_net_278|_net_255);
   assign  alucc = _alu_ccout;
   assign  taken = ((((((((({OPC_BYTE,(OPC[10:9])})==3'b000)|((({OPC_BYTE,(OPC[10:9])})==3'b001)&((~(OPC[8]))^fz)))|((({OPC_BYTE,(OPC[10:9])})==3'b010)&((~(OPC[8]))^(fn^fv))))|((({OPC_BYTE,(OPC[10:9])})==3'b011)&((~(OPC[8]))^((fn^fv)|fz))))|((({OPC_BYTE,(OPC[10:9])})==3'b100)&((~(OPC[8]))^fn)))|((({OPC_BYTE,(OPC[10:9])})==3'b101)&((~(OPC[8]))^(fc|fz))))|((({OPC_BYTE,(OPC[10:9])})==3'b110)&((~(OPC[8]))^fv)))|((({OPC_BYTE,(OPC[10:9])})==3'b111)&((~(OPC[8]))^fc)));
always @(posedge m_clock)
  begin
if (p_reset)
     PC <= 16'b0000000000000000;
else if ((adrPC)|(SELpc)|(ALUpc)|(FPpc)|((_net_155|_net_137))|(dbiPC)|(setPCrom)) 
      PC <= ((adrPC) ?ADR:16'b0)|
    ((SELpc) ?REGsel:16'b0)|
    ((ALUpc) ?_alu_out:16'b0)|
    ((FPpc) ?R5:16'b0)|
    (((_net_155|_net_137)) ?REGin:16'b0)|
    ((dbiPC) ?dbi:16'b0)|
    ((setPCrom) ?16'b1110000000000000:16'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     R0 <= 16'b0000000000000000;
else if (((_net_167|_net_149))) 
      R0 <= REGin;
end
always @(posedge m_clock)
  begin
if (p_reset)
     R1 <= 16'b0000000000000000;
else if (((_net_165|_net_147))) 
      R1 <= REGin;
end
always @(posedge m_clock)
  begin
if (p_reset)
     R2 <= 16'b0000000000000000;
else if (((_net_163|_net_145))) 
      R2 <= REGin;
end
always @(posedge m_clock)
  begin
if (p_reset)
     R3 <= 16'b0000000000000000;
else if (((_net_161|_net_143))) 
      R3 <= REGin;
end
always @(posedge m_clock)
  begin
if (p_reset)
     R4 <= 16'b0000000000000000;
else if (((_net_159|_net_141))) 
      R4 <= REGin;
end
always @(posedge m_clock)
  begin
if (p_reset)
     R5 <= 16'b0000000000000000;
else if (((_net_157|_net_139))|(dbiFP)) 
      R5 <= (((_net_157|_net_139)) ?REGin:16'b0)|
    ((dbiFP) ?dbi:16'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     kSP <= 16'b0000000000000000;
else if ((_net_171)|((_net_153|_net_135))) 
      kSP <= ((_net_171) ?_alu_out:16'b0)|
    (((_net_153|_net_135)) ?REGin:16'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     uSP <= 16'b0000000000000000;
else if ((_net_169)|((_net_151|_net_133))) 
      uSP <= ((_net_169) ?_alu_out:16'b0)|
    (((_net_151|_net_133)) ?REGin:16'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     OPC_BYTE <= 1'b0;
else if ((reset_byte)|(setopc)) 
      OPC_BYTE <= ((reset_byte) ?1'b0:1'b0)|
    ((setopc) ?(dbi[15]):1'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     OPC <= 15'b000000000000000;
else if ((oddReg)|(change_opr)|(setopc)) 
      OPC <= ((oddReg) ?({(OPC[14:7]),(~(OPC[6])),(OPC[5:0])}):15'b0)|
    ((change_opr) ?({(OPC[14:12]),(OPC[5:0]),(OPC[11:6])}):15'b0)|
    ((setopc) ?(dbi[14:0]):15'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     SRC <= 16'b0000000000000000;
else if (((_net_272|_net_251))|(_net_243)|(_net_233)|((_net_262|_net_227))|(mul)|(svc)|(iot)|(emt)|(bpt)|(err)|(segerr)|(buserr)|(SELsrc)|((_net_234|(_net_219|(_net_215|(_net_211|ALUsrc)))))|(dbiSrc)) 
      SRC <= (((_net_272|_net_251)) ?({(SRC[15]),(SRC[15:1])}):16'b0)|
    ((_net_243) ?({(SRC[14:0]),1'b0}):16'b0)|
    ((_net_233) ?({(_alu_out[14:0]),(ADR[15])}):16'b0)|
    (((_net_262|_net_227)) ?({(SRC[14:0]),(ADR[15])}):16'b0)|
    ((mul) ?({(mul_HI[0]),(SRC[15:1])}):16'b0)|
    ((svc) ?({1'b0,15'b000000000011100}):16'b0)|
    ((iot) ?({1'b0,15'b000000000010000}):16'b0)|
    ((emt) ?({1'b0,15'b000000000011000}):16'b0)|
    ((bpt) ?({1'b0,15'b000000000001100}):16'b0)|
    ((err) ?({1'b0,15'b000000000001000}):16'b0)|
    ((segerr) ?({1'b0,15'b000000010101000}):16'b0)|
    ((buserr) ?({1'b0,15'b000000000000100}):16'b0)|
    ((SELsrc) ?REGsel:16'b0)|
    (((_net_234|(_net_219|(_net_215|(_net_211|ALUsrc))))) ?_alu_out:16'b0)|
    ((dbiSrc) ?dbi:16'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     DST <= 16'b0000000000000000;
else if ((SELdst)|(_net_174)|((_net_271|(_net_261|(_net_250|(_net_242|(_net_192|(_net_173|ALUdst)))))))|(save_stat)|(dbiDst)) 
      DST <= ((SELdst) ?REGsel:16'b0)|
    ((_net_174) ?({(DST[15:8]),(_alu_out[7:0])}):16'b0)|
    (((_net_271|(_net_261|(_net_250|(_net_242|(_net_192|(_net_173|ALUdst))))))) ?_alu_out:16'b0)|
    ((save_stat) ?({cmode,pmode,4'b0000,priority,trapbit,fn,fz,fv,fc}):16'b0)|
    ((dbiDst) ?dbi:16'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     ADR <= 16'b0000000000000000;
else if ((_net_273)|(_net_236)|((_net_263|_net_229))|((_net_223|_net_207))|(mul)|(clrADR)|(SRCadr)|(DSTadr)|(SELadr)|(save_stat)) 
      ADR <= ((_net_273) ?({(SRC[0]),(ADR[15:1])}):16'b0)|
    ((_net_236) ?({(ADR[14:0]),1'b1}):16'b0)|
    (((_net_263|_net_229)) ?({(ADR[14:0]),1'b0}):16'b0)|
    (((_net_223|_net_207)) ?_alu_out:16'b0)|
    ((mul) ?({(mul_HI[15]),(mul_HI[15:1])}):16'b0)|
    ((clrADR) ?16'b0000000000000000:16'b0)|
    ((SRCadr) ?SRC:16'b0)|
    ((DSTadr) ?DST:16'b0)|
    ((SELadr) ?REGsel:16'b0)|
    ((save_stat) ?PC:16'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     cmode <= 2'b00;
else if ((kernel_mode)|(change_mode)|(dbiPS)) 
      cmode <= ((kernel_mode) ?2'b00:2'b0)|
    ((change_mode) ?pmode:2'b0)|
    ((dbiPS) ?(dbi[15:14]):2'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     pmode <= 2'b00;
else if (((kernel_mode|change_mode))|(dbiPS)) 
      pmode <= (((kernel_mode|change_mode)) ?cmode:2'b0)|
    ((dbiPS) ?(dbi[13:12]):2'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     priority <= 3'b000;
else if (((vectorPS|dbiPS))|(spl)) 
      priority <= (((vectorPS|dbiPS)) ?(dbi[7:5]):3'b0)|
    ((spl) ?(OPC[2:0]):3'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     trapbit <= 1'b0;
else if (((vectorPS|dbiPS))) 
      trapbit <= (dbi[4]);
end
always @(posedge m_clock)
  begin
if (p_reset)
     fn <= 1'b0;
else if ((_net_265)|(mul)|((_net_275|tstSRC))|((vectorPS|dbiPS))|(_net_87)|(_net_79)) 
      fn <= ((_net_265) ?(SRC[14]):1'b0)|
    ((mul) ?(mul_HI[15]):1'b0)|
    (((_net_275|tstSRC)) ?(SRC[15]):1'b0)|
    (((vectorPS|dbiPS)) ?(dbi[3]):1'b0)|
    ((_net_87) ?(OPC[4]):1'b0)|
    ((_net_79) ?(_alu_ccout[3]):1'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     fz <= 1'b0;
else if ((tstSRCADR)|(tstSRC)|((vectorPS|dbiPS))|(_net_85)|(_net_77)) 
      fz <= ((tstSRCADR) ?(~(|({ADR,SRC}))):1'b0)|
    ((tstSRC) ?(~(|SRC)):1'b0)|
    (((vectorPS|dbiPS)) ?(dbi[2]):1'b0)|
    ((_net_85) ?(OPC[4]):1'b0)|
    ((_net_77) ?(_alu_ccout[2]):1'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     fv <= 1'b0;
else if (((_net_276|(_net_266|(_net_253|_net_245))))|(_net_235)|(_net_228)|(div_ini1)|(_net_203)|((_net_199|mul))|((vectorPS|dbiPS))|(_net_83)|(_net_75)) 
      fv <= (((_net_276|(_net_266|(_net_253|_net_245)))) ?((SRC[15])^(SRC[14])):1'b0)|
    ((_net_235) ?(ADR[15]):1'b0)|
    ((_net_228) ?(|(ADR[15:14])):1'b0)|
    ((div_ini1) ?(_alu_ccout[2]):1'b0)|
    ((_net_203) ?1'b1:1'b0)|
    (((_net_199|mul)) ?1'b0:1'b0)|
    (((vectorPS|dbiPS)) ?(dbi[1]):1'b0)|
    ((_net_83) ?(OPC[4]):1'b0)|
    ((_net_75) ?(_alu_ccout[1]):1'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     fc <= 1'b0;
else if ((_net_274)|(_net_252)|((_net_264|_net_244))|(_net_202)|(_net_198)|(mul)|((vectorPS|dbiPS))|(_net_81)|(_net_73)) 
      fc <= ((_net_274) ?(ADR[0]):1'b0)|
    ((_net_252) ?(SRC[0]):1'b0)|
    (((_net_264|_net_244)) ?(SRC[15]):1'b0)|
    ((_net_202) ?1'b1:1'b0)|
    ((_net_198) ?1'b0:1'b0)|
    ((mul) ?(~((&(mul_HI[15:1]))|(~(|(mul_HI[15:1]))))):1'b0)|
    (((vectorPS|dbiPS)) ?(dbi[0]):1'b0)|
    ((_net_81) ?(OPC[4]):1'b0)|
    ((_net_73) ?(_alu_ccout[0]):1'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     multmp <= 1'b0;
else if ((mul)|(clrADR)) 
      multmp <= ((mul) ?(SRC[0]):1'b0)|
    ((clrADR) ?1'b0:1'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     dividen <= 1'b0;
else if ((div_ini1)) 
      dividen <= (SRC[15]);
end
always @(posedge m_clock)
  begin
if (p_reset)
     divider <= 1'b0;
else if ((div_ini0)) 
      divider <= (DST[15]);
end
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:52:33 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:52:34 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module idc ( p_reset , m_clock , idc_opc , unused , cco , bra , nof , rsd , dop , sop , dspl , dfloat , dsub , dmtpd , dmfpd , dtrap , demt , dsob , dfdiv , dfmul , dfsub , dfadd , dexor , dashc , dash , ddiv , dmul , dadd , dbis , dbic , dbit , dcmp , dmov , dsxt , dmtpi , dmfpi , dmark , dasl , dasr , drol , dror , dtst , dsbc , dadc , dneg , ddec , dinc , dcom , dclr , djsr , dswab , dnop , drts , djmp , drtt , dreset , diot , dbpt , drti , diwait , dhalt , do );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [15:0] idc_opc;
  wire [15:0] idc_opc;
  output unused;
  wire unused;
  output cco;
  wire cco;
  output bra;
  wire bra;
  output nof;
  wire nof;
  output rsd;
  wire rsd;
  output dop;
  wire dop;
  output sop;
  wire sop;
  output dspl;
  wire dspl;
  output dfloat;
  wire dfloat;
  output dsub;
  wire dsub;
  output dmtpd;
  wire dmtpd;
  output dmfpd;
  wire dmfpd;
  output dtrap;
  wire dtrap;
  output demt;
  wire demt;
  output dsob;
  wire dsob;
  output dfdiv;
  wire dfdiv;
  output dfmul;
  wire dfmul;
  output dfsub;
  wire dfsub;
  output dfadd;
  wire dfadd;
  output dexor;
  wire dexor;
  output dashc;
  wire dashc;
  output dash;
  wire dash;
  output ddiv;
  wire ddiv;
  output dmul;
  wire dmul;
  output dadd;
  wire dadd;
  output dbis;
  wire dbis;
  output dbic;
  wire dbic;
  output dbit;
  wire dbit;
  output dcmp;
  wire dcmp;
  output dmov;
  wire dmov;
  output dsxt;
  wire dsxt;
  output dmtpi;
  wire dmtpi;
  output dmfpi;
  wire dmfpi;
  output dmark;
  wire dmark;
  output dasl;
  wire dasl;
  output dasr;
  wire dasr;
  output drol;
  wire drol;
  output dror;
  wire dror;
  output dtst;
  wire dtst;
  output dsbc;
  wire dsbc;
  output dadc;
  wire dadc;
  output dneg;
  wire dneg;
  output ddec;
  wire ddec;
  output dinc;
  wire dinc;
  output dcom;
  wire dcom;
  output dclr;
  wire dclr;
  output djsr;
  wire djsr;
  output dswab;
  wire dswab;
  output dnop;
  wire dnop;
  output drts;
  wire drts;
  output djmp;
  wire djmp;
  output drtt;
  wire drtt;
  output dreset;
  wire dreset;
  output diot;
  wire diot;
  output dbpt;
  wire dbpt;
  output drti;
  wire drti;
  output diwait;
  wire diwait;
  output dhalt;
  wire dhalt;
  input do;
  wire do;
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

   assign  _net_279 = ((idc_opc[15:12])==({1'b1,3'b111}));
   assign  _net_280 = (do&_net_279);
   assign  _net_281 = (do&_net_279);
   assign  _net_282 = ((idc_opc[15:9])==({1'b1,6'b000111}));
   assign  _net_283 = (do&_net_282);
   assign  _net_284 = (do&_net_282);
   assign  _net_285 = ((idc_opc[15:6])==({1'b1,9'b000110111}));
   assign  _net_286 = (do&_net_285);
   assign  _net_287 = (do&_net_285);
   assign  _net_288 = ((idc_opc[15:6])==({1'b1,9'b000110110}));
   assign  _net_289 = (do&_net_288);
   assign  _net_290 = (do&_net_288);
   assign  _net_291 = ((idc_opc[15:6])==({1'b1,9'b000110101}));
   assign  _net_292 = (do&_net_291);
   assign  _net_293 = (do&_net_291);
   assign  _net_294 = ((idc_opc[15:6])==({1'b1,9'b000110100}));
   assign  _net_295 = (do&_net_294);
   assign  _net_296 = (do&_net_294);
   assign  _net_297 = (((idc_opc[15:9])==({1'b1,6'b000100}))&(idc_opc[8]));
   assign  _net_298 = (do&_net_297);
   assign  _net_299 = (do&_net_297);
   assign  _net_300 = (((idc_opc[15:9])==({1'b1,6'b000100}))&(~(idc_opc[8])));
   assign  _net_301 = (do&_net_300);
   assign  _net_302 = (do&_net_300);
   assign  _net_303 = ((idc_opc[15:9])==({1'b0,6'b111111}));
   assign  _net_304 = (do&_net_303);
   assign  _net_305 = (do&_net_303);
   assign  _net_306 = ((idc_opc[15:9])==({1'b0,6'b111110}));
   assign  _net_307 = (do&_net_306);
   assign  _net_308 = (do&_net_306);
   assign  _net_309 = (((idc_opc[15:9])==({1'b0,6'b111101}))&(|(idc_opc[8:6])));
   assign  _net_310 = (do&_net_309);
   assign  _net_311 = (do&_net_309);
   assign  _net_312 = ((idc_opc[15:5])==({1'b0,9'b111101000,1'b1}));
   assign  _net_313 = (do&_net_312);
   assign  _net_314 = (do&_net_312);
   assign  _net_315 = ((idc_opc[15:3])==({1'b0,12'b111101000011}));
   assign  _net_316 = (do&_net_315);
   assign  _net_317 = (do&_net_315);
   assign  _net_318 = ((idc_opc[15:3])==({1'b0,12'b111101000010}));
   assign  _net_319 = (do&_net_318);
   assign  _net_320 = (do&_net_318);
   assign  _net_321 = ((idc_opc[15:3])==({1'b0,12'b111101000001}));
   assign  _net_322 = (do&_net_321);
   assign  _net_323 = (do&_net_321);
   assign  _net_324 = ((idc_opc[15:3])==({1'b0,12'b111101000000}));
   assign  _net_325 = (do&_net_324);
   assign  _net_326 = (do&_net_324);
   assign  _net_327 = ((idc_opc[15:9])==({1'b0,6'b111100}));
   assign  _net_328 = (do&_net_327);
   assign  _net_329 = (do&_net_327);
   assign  _net_330 = ((idc_opc[15:9])==({1'b0,6'b111011}));
   assign  _net_331 = (do&_net_330);
   assign  _net_332 = (do&_net_330);
   assign  _net_333 = ((idc_opc[15:9])==({1'b0,6'b111010}));
   assign  _net_334 = (do&_net_333);
   assign  _net_335 = (do&_net_333);
   assign  _net_336 = ((idc_opc[15:9])==({1'b0,6'b111001}));
   assign  _net_337 = (do&_net_336);
   assign  _net_338 = (do&_net_336);
   assign  _net_339 = ((idc_opc[15:9])==({1'b0,6'b111000}));
   assign  _net_340 = (do&_net_339);
   assign  _net_341 = (do&_net_339);
   assign  _net_342 = ((idc_opc[15:12])==({1'b1,3'b110}));
   assign  _net_343 = (do&_net_342);
   assign  _net_344 = (do&_net_342);
   assign  _net_345 = ((idc_opc[15:12])==({1'b0,3'b110}));
   assign  _net_346 = (do&_net_345);
   assign  _net_347 = (do&_net_345);
   assign  _net_348 = ((idc_opc[14:12])==3'b101);
   assign  _net_349 = (do&_net_348);
   assign  _net_350 = (do&_net_348);
   assign  _net_351 = ((idc_opc[14:12])==3'b100);
   assign  _net_352 = (do&_net_351);
   assign  _net_353 = (do&_net_351);
   assign  _net_354 = ((idc_opc[14:12])==3'b011);
   assign  _net_355 = (do&_net_354);
   assign  _net_356 = (do&_net_354);
   assign  _net_357 = ((idc_opc[14:12])==3'b010);
   assign  _net_358 = (do&_net_357);
   assign  _net_359 = (do&_net_357);
   assign  _net_360 = ((idc_opc[14:12])==3'b001);
   assign  _net_361 = (do&_net_360);
   assign  _net_362 = (do&_net_360);
   assign  _net_363 = ((idc_opc[15:9])==({1'b0,6'b000111}));
   assign  _net_364 = (do&_net_363);
   assign  _net_365 = (do&_net_363);
   assign  _net_366 = ((idc_opc[15:6])==({1'b0,9'b000110111}));
   assign  _net_367 = (do&_net_366);
   assign  _net_368 = (do&_net_366);
   assign  _net_369 = ((idc_opc[15:6])==({1'b0,9'b000110110}));
   assign  _net_370 = (do&_net_369);
   assign  _net_371 = (do&_net_369);
   assign  _net_372 = ((idc_opc[15:6])==({1'b0,9'b000110101}));
   assign  _net_373 = (do&_net_372);
   assign  _net_374 = (do&_net_372);
   assign  _net_375 = ((idc_opc[15:6])==({1'b0,9'b000110100}));
   assign  _net_376 = (do&_net_375);
   assign  _net_377 = (do&_net_375);
   assign  _net_378 = ((idc_opc[14:6])==9'b000110011);
   assign  _net_379 = (do&_net_378);
   assign  _net_380 = (do&_net_378);
   assign  _net_381 = ((idc_opc[14:6])==9'b000110010);
   assign  _net_382 = (do&_net_381);
   assign  _net_383 = (do&_net_381);
   assign  _net_384 = ((idc_opc[14:6])==9'b000110001);
   assign  _net_385 = (do&_net_384);
   assign  _net_386 = (do&_net_384);
   assign  _net_387 = ((idc_opc[14:6])==9'b000110000);
   assign  _net_388 = (do&_net_387);
   assign  _net_389 = (do&_net_387);
   assign  _net_390 = ((idc_opc[14:6])==9'b000101111);
   assign  _net_391 = (do&_net_390);
   assign  _net_392 = (do&_net_390);
   assign  _net_393 = ((idc_opc[14:6])==9'b000101110);
   assign  _net_394 = (do&_net_393);
   assign  _net_395 = (do&_net_393);
   assign  _net_396 = ((idc_opc[14:6])==9'b000101101);
   assign  _net_397 = (do&_net_396);
   assign  _net_398 = (do&_net_396);
   assign  _net_399 = ((idc_opc[14:6])==9'b000101100);
   assign  _net_400 = (do&_net_399);
   assign  _net_401 = (do&_net_399);
   assign  _net_402 = ((idc_opc[14:6])==9'b000101011);
   assign  _net_403 = (do&_net_402);
   assign  _net_404 = (do&_net_402);
   assign  _net_405 = ((idc_opc[14:6])==9'b000101010);
   assign  _net_406 = (do&_net_405);
   assign  _net_407 = (do&_net_405);
   assign  _net_408 = ((idc_opc[14:6])==9'b000101001);
   assign  _net_409 = (do&_net_408);
   assign  _net_410 = (do&_net_408);
   assign  _net_411 = ((idc_opc[14:6])==9'b000101000);
   assign  _net_412 = (do&_net_411);
   assign  _net_413 = (do&_net_411);
   assign  _net_414 = ((idc_opc[15:9])==({1'b0,6'b000100}));
   assign  _net_415 = (do&_net_414);
   assign  _net_416 = (do&_net_414);
   assign  _net_417 = ((idc_opc[15:11])==({1'b1,3'b000,1'b0}));
   assign  _net_418 = (do&_net_417);
   assign  _net_419 = (((idc_opc[15:11])==({1'b0,3'b000,1'b0}))&(|(idc_opc[10:8])));
   assign  _net_420 = (do&_net_419);
   assign  _net_421 = ((idc_opc[15:6])==({1'b0,9'b000000011}));
   assign  _net_422 = (do&_net_421);
   assign  _net_423 = (do&_net_421);
   assign  _net_424 = ((idc_opc[15:4])==({1'b0,9'b000000010,2'b11}));
   assign  _net_425 = (do&_net_424);
   assign  _net_426 = (((idc_opc[15:4])==({1'b0,9'b000000010,2'b10}))&(|(idc_opc[3:0])));
   assign  _net_427 = (do&_net_426);
   assign  _net_428 = (((idc_opc[15:4])==({1'b0,9'b000000010,2'b10}))&(~(|(idc_opc[3:0]))));
   assign  _net_429 = (do&_net_428);
   assign  _net_430 = (do&_net_428);
   assign  _net_431 = ((idc_opc[15:3])==({1'b0,12'b000000010011}));
   assign  _net_432 = (do&_net_431);
   assign  _net_433 = (do&_net_431);
   assign  _net_434 = ((idc_opc[15:3])==({1'b0,12'b000000010010}));
   assign  _net_435 = (do&_net_434);
   assign  _net_436 = (do&_net_434);
   assign  _net_437 = ((idc_opc[15:3])==({1'b0,12'b000000010001}));
   assign  _net_438 = (do&_net_437);
   assign  _net_439 = (do&_net_437);
   assign  _net_440 = ((idc_opc[15:3])==({1'b0,12'b000000010000}));
   assign  _net_441 = (do&_net_440);
   assign  _net_442 = (do&_net_440);
   assign  _net_443 = ((idc_opc[15:6])==({1'b0,9'b000000001}));
   assign  _net_444 = (do&_net_443);
   assign  _net_445 = (do&_net_443);
   assign  _net_446 = ((idc_opc[15:0])==({1'b0,15'b000000000000111}));
   assign  _net_447 = (do&_net_446);
   assign  _net_448 = (do&_net_446);
   assign  _net_449 = ((idc_opc[15:0])==({1'b0,15'b000000000000110}));
   assign  _net_450 = (do&_net_449);
   assign  _net_451 = (do&_net_449);
   assign  _net_452 = ((idc_opc[15:0])==({1'b0,15'b000000000000101}));
   assign  _net_453 = (do&_net_452);
   assign  _net_454 = (do&_net_452);
   assign  _net_455 = ((idc_opc[15:0])==({1'b0,15'b000000000000100}));
   assign  _net_456 = (do&_net_455);
   assign  _net_457 = (do&_net_455);
   assign  _net_458 = ((idc_opc[15:0])==({1'b0,15'b000000000000011}));
   assign  _net_459 = (do&_net_458);
   assign  _net_460 = (do&_net_458);
   assign  _net_461 = ((idc_opc[15:0])==({1'b0,15'b000000000000010}));
   assign  _net_462 = (do&_net_461);
   assign  _net_463 = (do&_net_461);
   assign  _net_464 = ((idc_opc[15:0])==({1'b0,15'b000000000000001}));
   assign  _net_465 = (do&_net_464);
   assign  _net_466 = (do&_net_464);
   assign  _net_467 = ((idc_opc[15:0])==({1'b0,15'b000000000000000}));
   assign  _net_468 = (do&_net_467);
   assign  _net_469 = (do&_net_467);
   assign  sop = (_net_361|(_net_358|(_net_355|(_net_352|(_net_349|(_net_346|_net_343))))));
   assign  dop = (_net_444|(_net_441|(_net_422|(_net_415|(_net_412|(_net_409|(_net_406|(_net_403|(_net_400|(_net_397|(_net_394|(_net_391|(_net_388|(_net_385|(_net_382|(_net_379|(_net_373|(_net_370|_net_367))))))))))))))))));
   assign  rsd = (_net_340|(_net_337|(_net_334|(_net_331|(_net_328|(_net_325|(_net_322|(_net_319|_net_316))))))));
   assign  nof = (_net_468|(_net_465|(_net_462|(_net_459|(_net_456|(_net_453|(_net_450|(_net_447|(_net_438|(_net_435|(_net_432|(_net_429|(_net_376|(_net_364|(_net_313|(_net_310|(_net_307|(_net_304|(_net_301|(_net_298|(_net_295|(_net_292|(_net_289|(_net_286|(_net_283|_net_280)))))))))))))))))))))))));
   assign  bra = (_net_420|_net_418);
   assign  cco = (_net_427|_net_425);
   assign  unused = (_net_448|(_net_439|(_net_436|(_net_365|(_net_314|(_net_311|(_net_308|(_net_296|(_net_287|_net_284)))))))));
   assign  dhalt = _net_469;
   assign  diwait = _net_466;
   assign  drti = _net_463;
   assign  dbpt = _net_460;
   assign  diot = _net_457;
   assign  dreset = _net_454;
   assign  drtt = _net_451;
   assign  djmp = _net_445;
   assign  drts = _net_442;
   assign  dnop = _net_430;
   assign  dswab = _net_423;
   assign  djsr = _net_416;
   assign  dclr = _net_413;
   assign  dcom = _net_410;
   assign  dinc = _net_407;
   assign  ddec = _net_404;
   assign  dneg = _net_401;
   assign  dadc = _net_398;
   assign  dsbc = _net_395;
   assign  dtst = _net_392;
   assign  dror = _net_389;
   assign  drol = _net_386;
   assign  dasr = _net_383;
   assign  dasl = _net_380;
   assign  dmark = _net_377;
   assign  dmfpi = _net_374;
   assign  dmtpi = _net_371;
   assign  dsxt = _net_368;
   assign  dmov = _net_362;
   assign  dcmp = _net_359;
   assign  dbit = _net_356;
   assign  dbic = _net_353;
   assign  dbis = _net_350;
   assign  dadd = _net_347;
   assign  dmul = _net_341;
   assign  ddiv = _net_338;
   assign  dash = _net_335;
   assign  dashc = _net_332;
   assign  dexor = _net_329;
   assign  dfadd = _net_326;
   assign  dfsub = _net_323;
   assign  dfmul = _net_320;
   assign  dfdiv = _net_317;
   assign  dsob = _net_305;
   assign  demt = _net_302;
   assign  dtrap = _net_299;
   assign  dmfpd = _net_293;
   assign  dmtpd = _net_290;
   assign  dsub = _net_344;
   assign  dfloat = _net_281;
   assign  dspl = _net_433;
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:52:34 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:52:34 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module cnt_inc4 ( p_reset , m_clock , in , out , do );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [3:0] in;
  wire [3:0] in;
  output [3:0] out;
  wire [3:0] out;
  input do;
  wire do;
  wire s0;
  wire s1;
  wire s2;
  wire s3;

   assign  s0 = (~(in[0]));
   assign  s1 = ((in[1])^(in[0]));
   assign  s2 = ((in[2])^(&(in[1:0])));
   assign  s3 = ((in[3])^(&(in[2:0])));
   assign  out = ({s3,s2,s1,s0});
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:52:34 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:52:34 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module cnt4 ( p_reset , m_clock , rst , inc , out , c );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input rst;
  wire rst;
  input inc;
  wire inc;
  output [3:0] out;
  wire [3:0] out;
  output c;
  wire c;
  reg [3:0] cnt;
  reg ovf;
  wire [3:0] _cnt_inc_in;
  wire [3:0] _cnt_inc_out;
  wire _cnt_inc_do;
  wire _cnt_inc_p_reset;
  wire _cnt_inc_m_clock;
cnt_inc4 cnt_inc (.m_clock(m_clock), .p_reset(p_reset), .do(_cnt_inc_do), .out(_cnt_inc_out), .in(_cnt_inc_in));

   assign  _cnt_inc_in = cnt;
   assign  _cnt_inc_do = inc;
   assign  _cnt_inc_p_reset = p_reset;
   assign  _cnt_inc_m_clock = m_clock;
   assign  out = cnt;
   assign  c = ovf;
always @(posedge m_clock)
  begin
if (p_reset)
     cnt <= 4'b0000;
else if ((rst)|(inc)) 
      cnt <= ((rst) ?4'b0000:4'b0)|
    ((inc) ?_cnt_inc_out:4'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     ovf <= 1'b0;
else if ((rst)|(inc)) 
      ovf <= ((rst) ?1'b0:1'b0)|
    ((inc) ?(&cnt):1'b0);

end
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:52:34 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:52:37 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module pop11 ( p_reset , m_clock , dati , dato , adrs , fault , error_sig , rdy , irq_in , wt , rd , byte , int_ack , pswout , psi , inst , pswt );
  parameter _state__reg_937_if0 = 0;
  parameter _state__reg_937_id0 = 1;
  parameter _state__reg_937_of0 = 3;
  parameter _state__reg_937_of1 = 2;
  parameter _state__reg_937_of2 = 6;
  parameter _state__reg_937_of3 = 7;
  parameter _state__reg_937_of4 = 5;
  parameter _state__reg_937_cc0 = 4;
  parameter _state__reg_937_br0 = 12;
  parameter _state__reg_1243_wb_s0 = 0;
  parameter _state__reg_1293_trap0 = 0;
  parameter _state__reg_1293_trap1 = 1;
  parameter _state__reg_1293_trap2 = 3;
  parameter _state__reg_1293_trap3 = 2;
  parameter _state__reg_1293_trap4 = 6;
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [15:0] dati;
  wire [15:0] dati;
  output [15:0] dato;
  wire [15:0] dato;
  output [15:0] adrs;
  wire [15:0] adrs;
  input fault;
  wire fault;
  input error_sig;
  wire error_sig;
  input rdy;
  wire rdy;
  input irq_in;
  wire irq_in;
  output wt;
  wire wt;
  output rd;
  wire rd;
  output byte;
  wire byte;
  output int_ack;
  wire int_ack;
  output [15:0] pswout;
  wire [15:0] pswout;
  input [15:0] psi;
  wire [15:0] psi;
  output inst;
  wire inst;
  input pswt;
  wire pswt;
  reg st0;
  reg st1;
  reg st2;
  reg rsub;
  wire byte_sel;
  reg [3:0] tsk;
  wire start;
  wire ifrun;
  wire wback;
  wire svcall;
  wire decop;
  wire s0;
  wire s1;
  wire s2;
  wire s3;
  wire s4;
  wire s5;
  wire s6;
  wire s7;
  wire s8;
  wire write;
  wire read;
  reg [1:0] ifruns;
  reg ifetch;
  reg ex;
  reg wb;
  reg [2:0] trapkind;
  reg trap;
  wire [15:0] _dp_dbi;
  wire [15:0] _dp_dbo;
  wire [15:0] _dp_dba;
  wire [15:0] _dp_opc;
  wire [15:0] _dp_psw;
  wire _dp_inc2;
  wire _dp_dec2;
  wire _dp_inc;
  wire _dp_dec;
  wire _dp_clr;
  wire _dp_com;
  wire _dp_neg;
  wire _dp_adc;
  wire _dp_sbc;
  wire _dp_tst;
  wire _dp_ror;
  wire _dp_rol;
  wire _dp_asr;
  wire _dp_asl;
  wire _dp_sxt;
  wire _dp_mov;
  wire _dp_cmp;
  wire _dp_bit;
  wire _dp_bic;
  wire _dp_bis;
  wire _dp_add;
  wire _dp_sub;
  wire _dp_exor;
  wire _dp_swab;
  wire _dp_mmu;
  wire _dp_setopc;
  wire _dp_dbiDst;
  wire _dp_dbiSrc;
  wire _dp_dbiPC;
  wire _dp_dbiReg;
  wire _dp_dbiPS;
  wire _dp_dbaPC;
  wire _dp_dbaSP;
  wire _dp_dbaDst;
  wire _dp_dbaSrc;
  wire _dp_dbaAdr;
  wire _dp_dboSEL;
  wire _dp_dboDst;
  wire _dp_dboSrc;
  wire _dp_dboAdr;
  wire _dp_pcALU1;
  wire _dp_spALU1;
  wire _dp_dstALU1;
  wire _dp_srcALU1;
  wire _dp_dstALU2;
  wire _dp_srcALU2;
  wire _dp_adrALU1;
  wire _dp_ofs8ALU2;
  wire _dp_ofs6ALU2;
  wire _dp_selALU1;
  wire _dp_regSEL;
  wire _dp_regSEL2;
  wire _dp_setReg;
  wire _dp_setReg2;
  wire _dp_ALUreg;
  wire _dp_DSTreg;
  wire _dp_PCreg;
  wire _dp_SRCreg;
  wire _dp_ADRreg;
  wire _dp_ALUpc;
  wire _dp_ALUsp;
  wire _dp_ALUdst;
  wire _dp_ALUdstb;
  wire _dp_ALUsrc;
  wire _dp_ALUcc_cap;
  wire _dp_SELdst;
  wire _dp_SELsrc;
  wire _dp_SELadr;
  wire _dp_SELpc;
  wire _dp_DSTadr;
  wire _dp_SRCadr;
  wire _dp_adrPC;
  wire _dp_save_stat;
  wire _dp_FPpc;
  wire _dp_dbiFP;
  wire _dp_setPCrom;
  wire _dp_change_opr;
  wire _dp_change_mode;
  wire _dp_kernel_mode;
  wire _dp_reset_byte;
  wire _dp_vectorPS;
  wire _dp_ccclr;
  wire _dp_ccset;
  wire _dp_cctaken;
  wire _dp_buserr;
  wire _dp_err;
  wire _dp_bpt;
  wire _dp_emt;
  wire _dp_iot;
  wire _dp_svc;
  wire _dp_segerr;
  wire _dp_spl;
  wire _dp_ccget;
  wire _dp_clrADR;
  wire _dp_oddReg;
  wire _dp_mul;
  wire _dp_ash;
  wire _dp_ashc;
  wire _dp_div;
  wire _dp_div_end;
  wire _dp_div_ini0;
  wire _dp_div_ini1;
  wire _dp_div_ini2;
  wire _dp_div_fin0;
  wire _dp_div_fin1;
  wire _dp_tstSRC;
  wire _dp_tstSRCADR;
  wire _dp_ashdone;
  wire [3:0] _dp_alucc;
  wire _dp_taken;
  wire _dp_p_reset;
  wire _dp_m_clock;
  wire [15:0] _id_idc_opc;
  wire _id_sop;
  wire _id_dop;
  wire _id_rsd;
  wire _id_nof;
  wire _id_bra;
  wire _id_cco;
  wire _id_unused;
  wire _id_dhalt;
  wire _id_diwait;
  wire _id_drti;
  wire _id_dbpt;
  wire _id_diot;
  wire _id_dreset;
  wire _id_drtt;
  wire _id_djmp;
  wire _id_drts;
  wire _id_dnop;
  wire _id_dswab;
  wire _id_djsr;
  wire _id_dclr;
  wire _id_dcom;
  wire _id_dinc;
  wire _id_ddec;
  wire _id_dneg;
  wire _id_dadc;
  wire _id_dsbc;
  wire _id_dtst;
  wire _id_dror;
  wire _id_drol;
  wire _id_dasr;
  wire _id_dasl;
  wire _id_dmark;
  wire _id_dmfpi;
  wire _id_dmtpi;
  wire _id_dsxt;
  wire _id_dmov;
  wire _id_dcmp;
  wire _id_dbit;
  wire _id_dbic;
  wire _id_dbis;
  wire _id_dadd;
  wire _id_dmul;
  wire _id_ddiv;
  wire _id_dash;
  wire _id_dashc;
  wire _id_dexor;
  wire _id_dfadd;
  wire _id_dfsub;
  wire _id_dfmul;
  wire _id_dfdiv;
  wire _id_dsob;
  wire _id_demt;
  wire _id_dtrap;
  wire _id_dmfpd;
  wire _id_dmtpd;
  wire _id_dsub;
  wire _id_dfloat;
  wire _id_dspl;
  wire _id_do;
  wire _id_p_reset;
  wire _id_m_clock;
  wire _cnt_inc;
  wire _cnt_rst;
  wire [3:0] _cnt_out;
  wire _cnt_c;
  wire _cnt_p_reset;
  wire _cnt_m_clock;
  wire _proc_ifetch_set;
  wire _proc_ifetch_reset;
  wire _net_470;
  wire _proc_ex_set;
  wire _proc_ex_reset;
  wire _net_471;
  wire _proc_wb_set;
  wire _proc_wb_reset;
  wire _net_472;
  wire _proc_trap_set;
  wire _proc_trap_reset;
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
  wire _net_822;
  wire _net_823;
  wire _net_824;
  wire _net_825;
  wire _net_826;
  wire _net_827;
  wire _net_828;
  wire _net_829;
  wire _net_830;
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
  wire _net_892;
  wire _net_893;
  wire _net_894;
  wire _net_895;
  wire _net_896;
  wire _net_897;
  wire _net_898;
  wire _net_899;
  wire _net_900;
  wire _net_901;
  wire _net_902;
  wire _net_903;
  wire _net_904;
  wire _net_905;
  wire _net_906;
  wire _net_907;
  wire _net_908;
  wire _net_909;
  wire _net_910;
  wire _net_911;
  wire _net_912;
  wire _net_913;
  wire _net_914;
  wire _net_915;
  wire _net_916;
  wire _net_917;
  wire _net_918;
  wire _net_919;
  wire _net_920;
  wire _net_921;
  wire _net_922;
  wire _net_923;
  wire _net_924;
  wire _net_925;
  wire _net_926;
  wire _net_927;
  wire _net_928;
  wire _net_929;
  wire _net_930;
  wire _net_931;
  wire _net_932;
  wire _net_933;
  wire _net_934;
  wire _net_935;
  wire _net_936;
  reg [3:0] _reg_937;
  wire _net_938;
  wire _net_939;
  wire _net_940;
  wire _net_941;
  wire _net_942;
  wire _net_943;
  wire _net_944;
  wire _net_945;
  wire _net_946;
  wire _net_947;
  wire _net_948;
  wire _net_949;
  wire _net_950;
  wire _net_951;
  wire _net_952;
  wire _net_953;
  wire _net_954;
  wire _net_955;
  wire _net_956;
  wire _net_957;
  wire _net_958;
  wire _net_959;
  wire _net_960;
  wire _net_961;
  wire _net_962;
  wire _net_963;
  wire _net_964;
  wire _net_965;
  wire _net_966;
  wire _net_967;
  wire _net_968;
  wire _net_969;
  wire _net_970;
  wire _net_971;
  wire _net_972;
  wire _net_973;
  wire _net_974;
  wire _net_975;
  wire _net_976;
  wire _net_977;
  wire _net_978;
  wire _net_979;
  wire _net_980;
  wire _net_981;
  wire _net_982;
  wire _net_983;
  wire _net_984;
  wire _net_985;
  wire _net_986;
  wire _net_987;
  wire _net_988;
  wire _net_989;
  wire _net_990;
  wire _net_991;
  wire _net_992;
  wire _net_993;
  wire _net_994;
  wire _net_995;
  wire _net_996;
  wire _net_997;
  wire _net_998;
  wire _net_999;
  wire _net_1000;
  wire _net_1001;
  wire _net_1002;
  wire _net_1003;
  wire _net_1004;
  wire _net_1005;
  wire _net_1006;
  wire _net_1007;
  wire _net_1008;
  wire _net_1009;
  wire _net_1010;
  wire _net_1011;
  wire _net_1012;
  wire _net_1013;
  wire _net_1014;
  wire _net_1015;
  wire _net_1016;
  wire _net_1017;
  wire _net_1018;
  wire _net_1019;
  wire _net_1020;
  wire _net_1021;
  wire _net_1022;
  wire _net_1023;
  wire _net_1024;
  wire _net_1025;
  wire _net_1026;
  wire _net_1027;
  wire _net_1028;
  wire _net_1029;
  wire _net_1030;
  wire _net_1031;
  wire _net_1032;
  wire _net_1033;
  wire _net_1034;
  wire _net_1035;
  wire _net_1036;
  wire _net_1037;
  wire _net_1038;
  wire _net_1039;
  wire _net_1040;
  wire _net_1041;
  wire _net_1042;
  wire _net_1043;
  wire _net_1044;
  wire _net_1045;
  wire _net_1046;
  wire _net_1047;
  wire _net_1048;
  wire _net_1049;
  wire _net_1050;
  wire _net_1051;
  wire _net_1052;
  wire _net_1053;
  wire _net_1054;
  wire _net_1055;
  wire _net_1056;
  wire _net_1057;
  wire _net_1058;
  wire _net_1059;
  wire _net_1060;
  wire _net_1061;
  wire _net_1062;
  wire _net_1063;
  wire _net_1064;
  wire _net_1065;
  wire _net_1066;
  wire _net_1067;
  wire _net_1068;
  wire _net_1069;
  wire _net_1070;
  wire _net_1071;
  wire _net_1072;
  wire _net_1073;
  wire _net_1074;
  wire _net_1075;
  wire _net_1076;
  wire _net_1077;
  wire _net_1078;
  wire _net_1079;
  wire _net_1080;
  wire _net_1081;
  wire _net_1082;
  wire _net_1083;
  wire _net_1084;
  wire _net_1085;
  wire _net_1086;
  wire _net_1087;
  wire _net_1088;
  wire _net_1089;
  wire _net_1090;
  wire _net_1091;
  wire _net_1092;
  wire _net_1093;
  wire _net_1094;
  wire _net_1095;
  wire _net_1096;
  wire _net_1097;
  wire _net_1098;
  wire _net_1099;
  wire _net_1100;
  wire _net_1101;
  wire _net_1102;
  wire _net_1103;
  wire _net_1104;
  wire _net_1105;
  wire _net_1106;
  wire _net_1107;
  wire _net_1108;
  wire _net_1109;
  wire _net_1110;
  wire _net_1111;
  wire _net_1112;
  wire _net_1113;
  wire _net_1114;
  wire _net_1115;
  wire _net_1116;
  wire _net_1117;
  wire _net_1118;
  wire _net_1119;
  wire _net_1120;
  wire _net_1121;
  wire _net_1122;
  wire _net_1123;
  wire _net_1124;
  wire _net_1125;
  wire _net_1126;
  wire _net_1127;
  wire _net_1128;
  wire _net_1129;
  wire _net_1130;
  wire _net_1131;
  wire _net_1132;
  wire _net_1133;
  wire _net_1134;
  wire _net_1135;
  wire _net_1136;
  wire _net_1137;
  wire _net_1138;
  wire _net_1139;
  wire _net_1140;
  wire _net_1141;
  wire _net_1142;
  wire _net_1143;
  wire _net_1144;
  wire _net_1145;
  wire _net_1146;
  wire _net_1147;
  wire _net_1148;
  wire _net_1149;
  wire _net_1150;
  wire _net_1151;
  wire _net_1152;
  wire _net_1153;
  wire _net_1154;
  wire _net_1155;
  wire _net_1156;
  wire _net_1157;
  wire _net_1158;
  wire _net_1159;
  wire _net_1160;
  wire _net_1161;
  wire _net_1162;
  wire _net_1163;
  wire _net_1164;
  wire _net_1165;
  wire _net_1166;
  wire _net_1167;
  wire _net_1168;
  wire _net_1169;
  wire _net_1170;
  wire _net_1171;
  wire _net_1172;
  wire _net_1173;
  wire _net_1174;
  wire _net_1175;
  wire _net_1176;
  wire _net_1177;
  wire _net_1178;
  wire _net_1179;
  wire _net_1180;
  wire _net_1181;
  wire _net_1182;
  wire _net_1183;
  wire _net_1184;
  wire _net_1185;
  wire _net_1186;
  wire _net_1187;
  wire _net_1188;
  wire _net_1189;
  wire _net_1190;
  wire _net_1191;
  wire _net_1192;
  wire _net_1193;
  wire _net_1194;
  wire _net_1195;
  wire _net_1196;
  wire _net_1197;
  wire _net_1198;
  wire _net_1199;
  wire _net_1200;
  wire _net_1201;
  wire _net_1202;
  wire _net_1203;
  wire _net_1204;
  wire _net_1205;
  wire _net_1206;
  wire _net_1207;
  wire _net_1208;
  wire _net_1209;
  wire _net_1210;
  wire _net_1211;
  wire _net_1212;
  wire _net_1213;
  wire _net_1214;
  wire _net_1215;
  wire _net_1216;
  wire _net_1217;
  wire _net_1218;
  wire _net_1219;
  wire _net_1220;
  wire _net_1221;
  wire _net_1222;
  wire _net_1223;
  wire _net_1224;
  wire _net_1225;
  wire _net_1226;
  wire _net_1227;
  wire _net_1228;
  wire _net_1229;
  wire _net_1230;
  wire _net_1231;
  wire _net_1232;
  wire _net_1233;
  wire _net_1234;
  wire _net_1235;
  wire _net_1236;
  wire _net_1237;
  wire _net_1238;
  wire _net_1239;
  wire _net_1240;
  wire _net_1241;
  wire _net_1242;
  reg _reg_1243;
  wire _net_1244;
  wire _net_1245;
  wire _net_1246;
  wire _net_1247;
  wire _net_1248;
  wire _net_1249;
  wire _net_1250;
  wire _net_1251;
  wire _net_1252;
  wire _net_1253;
  wire _net_1254;
  wire _net_1255;
  wire _net_1256;
  wire _net_1257;
  wire _net_1258;
  wire _net_1259;
  wire _net_1260;
  wire _net_1261;
  wire _net_1262;
  wire _net_1263;
  wire _net_1264;
  wire _net_1265;
  wire _net_1266;
  wire _net_1267;
  wire _net_1268;
  wire _net_1269;
  wire _net_1270;
  wire _net_1271;
  wire _net_1272;
  wire _net_1273;
  wire _net_1274;
  wire _net_1275;
  wire _net_1276;
  wire _net_1277;
  wire _net_1278;
  wire _net_1279;
  wire _net_1280;
  wire _net_1281;
  wire _net_1282;
  wire _net_1283;
  wire _net_1284;
  wire _net_1285;
  wire _net_1286;
  wire _net_1287;
  wire _net_1288;
  wire _net_1289;
  wire _net_1290;
  wire _net_1291;
  wire _net_1292;
  reg [2:0] _reg_1293;
  wire _net_1294;
  wire _net_1295;
  wire _net_1296;
  wire _net_1297;
  wire _net_1298;
  wire _net_1299;
  wire _net_1300;
  wire _net_1301;
  wire _net_1302;
  wire _net_1303;
  wire _net_1304;
  wire _net_1305;
  wire _net_1306;
  wire _net_1307;
  wire _net_1308;
  wire _net_1309;
  wire _net_1310;
  wire _net_1311;
  wire _net_1312;
  wire _net_1313;
  wire _net_1314;
  wire _net_1315;
  wire _net_1316;
  wire _net_1317;
  wire _net_1318;
  wire _net_1319;
  wire _net_1320;
  wire _net_1321;
cnt4 cnt (.m_clock(m_clock), .p_reset(p_reset), .out(_cnt_out), .c(_cnt_c), .rst(_cnt_rst), .inc(_cnt_inc));
idc id (.m_clock(m_clock), .p_reset(p_reset), .do(_id_do), .dspl(_id_dspl), .dfloat(_id_dfloat), .dsub(_id_dsub), .dmtpd(_id_dmtpd), .dmfpd(_id_dmfpd), .dtrap(_id_dtrap), .demt(_id_demt), .dsob(_id_dsob), .dfdiv(_id_dfdiv), .dfmul(_id_dfmul), .dfsub(_id_dfsub), .dfadd(_id_dfadd), .dexor(_id_dexor), .dashc(_id_dashc), .dash(_id_dash), .ddiv(_id_ddiv), .dmul(_id_dmul), .dadd(_id_dadd), .dbis(_id_dbis), .dbic(_id_dbic), .dbit(_id_dbit), .dcmp(_id_dcmp), .dmov(_id_dmov), .dsxt(_id_dsxt), .dmtpi(_id_dmtpi), .dmfpi(_id_dmfpi), .dmark(_id_dmark), .dasl(_id_dasl), .dasr(_id_dasr), .drol(_id_drol), .dror(_id_dror), .dtst(_id_dtst), .dsbc(_id_dsbc), .dadc(_id_dadc), .dneg(_id_dneg), .ddec(_id_ddec), .dinc(_id_dinc), .dcom(_id_dcom), .dclr(_id_dclr), .djsr(_id_djsr), .dswab(_id_dswab), .dnop(_id_dnop), .drts(_id_drts), .djmp(_id_djmp), .drtt(_id_drtt), .dreset(_id_dreset), .diot(_id_diot), .dbpt(_id_dbpt), .drti(_id_drti), .diwait(_id_diwait), .dhalt(_id_dhalt), .unused(_id_unused), .cco(_id_cco), .bra(_id_bra), .nof(_id_nof), .rsd(_id_rsd), .dop(_id_dop), .sop(_id_sop), .idc_opc(_id_idc_opc));
data11 dp (.m_clock(m_clock), .p_reset(p_reset), .taken(_dp_taken), .alucc(_dp_alucc), .ashdone(_dp_ashdone), .tstSRCADR(_dp_tstSRCADR), .tstSRC(_dp_tstSRC), .div_fin1(_dp_div_fin1), .div_fin0(_dp_div_fin0), .div_ini2(_dp_div_ini2), .div_ini1(_dp_div_ini1), .div_ini0(_dp_div_ini0), .div_end(_dp_div_end), .div(_dp_div), .ashc(_dp_ashc), .ash(_dp_ash), .mul(_dp_mul), .oddReg(_dp_oddReg), .clrADR(_dp_clrADR), .ccget(_dp_ccget), .spl(_dp_spl), .segerr(_dp_segerr), .svc(_dp_svc), .iot(_dp_iot), .emt(_dp_emt), .bpt(_dp_bpt), .err(_dp_err), .buserr(_dp_buserr), .cctaken(_dp_cctaken), .ccset(_dp_ccset), .ccclr(_dp_ccclr), .vectorPS(_dp_vectorPS), .reset_byte(_dp_reset_byte), .kernel_mode(_dp_kernel_mode), .change_mode(_dp_change_mode), .change_opr(_dp_change_opr), .setPCrom(_dp_setPCrom), .dbiFP(_dp_dbiFP), .FPpc(_dp_FPpc), .save_stat(_dp_save_stat), .adrPC(_dp_adrPC), .SRCadr(_dp_SRCadr), .DSTadr(_dp_DSTadr), .SELpc(_dp_SELpc), .SELadr(_dp_SELadr), .SELsrc(_dp_SELsrc), .SELdst(_dp_SELdst), .ALUcc_cap(_dp_ALUcc_cap), .ALUsrc(_dp_ALUsrc), .ALUdstb(_dp_ALUdstb), .ALUdst(_dp_ALUdst), .ALUsp(_dp_ALUsp), .ALUpc(_dp_ALUpc), .ADRreg(_dp_ADRreg), .SRCreg(_dp_SRCreg), .PCreg(_dp_PCreg), .DSTreg(_dp_DSTreg), .ALUreg(_dp_ALUreg), .setReg2(_dp_setReg2), .setReg(_dp_setReg), .regSEL2(_dp_regSEL2), .regSEL(_dp_regSEL), .selALU1(_dp_selALU1), .ofs6ALU2(_dp_ofs6ALU2), .ofs8ALU2(_dp_ofs8ALU2), .adrALU1(_dp_adrALU1), .srcALU2(_dp_srcALU2), .dstALU2(_dp_dstALU2), .srcALU1(_dp_srcALU1), .dstALU1(_dp_dstALU1), .spALU1(_dp_spALU1), .pcALU1(_dp_pcALU1), .dboAdr(_dp_dboAdr), .dboSrc(_dp_dboSrc), .dboDst(_dp_dboDst), .dboSEL(_dp_dboSEL), .dbaAdr(_dp_dbaAdr), .dbaSrc(_dp_dbaSrc), .dbaDst(_dp_dbaDst), .dbaSP(_dp_dbaSP), .dbaPC(_dp_dbaPC), .dbiPS(_dp_dbiPS), .dbiReg(_dp_dbiReg), .dbiPC(_dp_dbiPC), .dbiSrc(_dp_dbiSrc), .dbiDst(_dp_dbiDst), .setopc(_dp_setopc), .mmu(_dp_mmu), .swab(_dp_swab), .exor(_dp_exor), .sub(_dp_sub), .add(_dp_add), .bis(_dp_bis), .bic(_dp_bic), .bit_sig(_dp_bit), .cmp(_dp_cmp), .mov(_dp_mov), .sxt(_dp_sxt), .asl(_dp_asl), .asr(_dp_asr), .rol(_dp_rol), .ror(_dp_ror), .tst(_dp_tst), .sbc(_dp_sbc), .adc(_dp_adc), .neg(_dp_neg), .com(_dp_com), .clr(_dp_clr), .dec(_dp_dec), .inc(_dp_inc), .dec2(_dp_dec2), .inc2(_dp_inc2), .dbo(_dp_dbo), .dba(_dp_dba), .opc(_dp_opc), .psw(_dp_psw), .dbi(_dp_dbi));

   assign  byte_sel = (((_net_1317|(_net_1312|(_net_1247|(_net_1167|(_net_1146|_net_1104))))))?(_dp_opc[15]):1'b0)|
    (((_net_1306|(_net_1300|(_net_1101|(_net_1009|(_net_938|(_net_763|(_net_750|(_net_737|(_net_717|(_net_694|(_net_674|(_net_656|(_net_645|_net_626))))))))))))))?1'b0:1'b0);
   assign  start = _net_474;
   assign  ifrun = (_net_900|(_net_866|(_net_861|(_net_820|(_net_819|(_net_808|(_net_807|(_net_806|(_net_802|(_net_801|(_net_787|(_net_772|(_net_746|(_net_713|(_net_704|(_net_662|(_net_638|(_net_632|(_net_598|(_net_590|(_net_567|(_net_551|(_net_541|(_net_524|(_net_509|_net_481)))))))))))))))))))))))));
   assign  wback = (_net_935|(_net_930|(_net_925|(_net_920|(_net_915|(_net_910|(_net_905|(_net_896|(_net_891|(_net_886|(_net_881|(_net_876|(_net_871|(_net_856|(_net_850|(_net_844|(_net_837|(_net_830|_net_824))))))))))))))))));
   assign  svcall = (_net_817|(_net_815|(_net_813|_net_811)));
   assign  decop = ex;
   assign  s0 = (_net_805|(_net_754|_net_516));
   assign  s1 = (_net_798|(_net_780|(_net_767|(_net_759|(_net_741|(_net_732|(_net_723|(_net_709|(_net_698|(_net_690|(_net_652|(_net_620|(_net_611|(_net_584|(_net_513|_net_503)))))))))))))));
   assign  s2 = (_net_726|(_net_686|(_net_680|(_net_615|(_net_580|(_net_499|_net_494))))));
   assign  s3 = (_net_668|(_net_605|(_net_575|_net_491)));
   assign  s4 = (_net_571|(_net_559|_net_487));
   assign  s5 = _net_563;
   assign  s6 = _net_548;
   assign  s7 = _net_538;
   assign  s8 = _net_528;
   assign  write = (_net_1317|(_net_1312|(_net_1246|(_net_716|(_net_655|_net_625)))));
   assign  read = (_net_1306|(_net_1300|(_net_1166|(_net_1145|(_net_1103|(_net_1100|(_net_1008|(_net_938|(_net_762|(_net_749|(_net_736|(_net_693|(_net_673|_net_644)))))))))))));
   assign  _dp_dbi = ((pswt)?psi:16'b0)|
    (((_net_1297|_net_475))?dati:16'b0);
   assign  _dp_inc2 = (_net_1303|(_net_1059|(_net_1022|(_net_948|(_net_770|(_net_757|(_net_744|(_net_702|_net_648))))))));
   assign  _dp_dec2 = (_net_1314|(_net_1309|(_net_1041|(_net_730|_net_666))));
   assign  _dp_inc = (_net_1056|_net_923);
   assign  _dp_dec = (_net_1038|(_net_918|_net_792));
   assign  _dp_clr = _net_933;
   assign  _dp_com = _net_928;
   assign  _dp_neg = _net_913;
   assign  _dp_adc = _net_908;
   assign  _dp_sbc = _net_903;
   assign  _dp_tst = (_net_899|_net_522);
   assign  _dp_ror = _net_894;
   assign  _dp_rol = _net_889;
   assign  _dp_asr = _net_884;
   assign  _dp_asl = _net_879;
   assign  _dp_sxt = _net_874;
   assign  _dp_mov = _net_869;
   assign  _dp_cmp = _net_865;
   assign  _dp_bit = _net_860;
   assign  _dp_bic = _net_854;
   assign  _dp_bis = _net_848;
   assign  _dp_add = (_net_1091|(_net_994|(_net_842|_net_777)));
   assign  _dp_sub = (_net_835|_net_785);
   assign  _dp_exor = _net_828;
   assign  _dp_swab = _net_822;
   assign  _dp_mmu = (_net_660|_net_640);
   assign  _dp_setopc = _net_950;
   assign  _dp_dbiDst = (_net_1180|(_net_1121|(_net_1026|_net_679)));
   assign  _dp_dbiSrc = (_net_1298|(_net_1159|(_net_1125|(_net_1029|_net_651))));
   assign  _dp_dbiPC = (_net_1301|_net_755);
   assign  _dp_dbiReg = _net_699;
   assign  _dp_dbiPS = (_net_742|pswt);
   assign  _dp_dbaPC = (_net_1010|_net_938);
   assign  _dp_dbaSP = (_net_1317|(_net_1312|(_net_764|(_net_751|(_net_738|(_net_720|(_net_695|(_net_657|_net_646))))))));
   assign  _dp_dbaDst = (_net_1168|_net_1106);
   assign  _dp_dbaSrc = (_net_1306|(_net_1300|(_net_1147|_net_1108)));
   assign  _dp_dbaAdr = (_net_1249|(_net_675|_net_627));
   assign  _dp_dboSEL = _net_719;
   assign  _dp_dboDst = (_net_1312|(_net_1248|_net_658));
   assign  _dp_dboSrc = _net_628;
   assign  _dp_dboAdr = _net_1317;
   assign  _dp_pcALU1 = (_net_1021|(_net_992|(_net_947|_net_783)));
   assign  _dp_spALU1 = (_net_1313|(_net_1308|(_net_775|(_net_769|(_net_756|(_net_743|(_net_729|(_net_701|(_net_665|_net_647)))))))));
   assign  _dp_dstALU1 = (_net_932|(_net_927|(_net_922|(_net_917|(_net_912|(_net_907|(_net_902|(_net_898|(_net_893|(_net_888|(_net_883|(_net_878|(_net_873|(_net_834|_net_821))))))))))))));
   assign  _dp_srcALU1 = (_net_1302|(_net_868|(_net_863|(_net_858|(_net_852|(_net_846|(_net_840|(_net_826|(_net_659|_net_639)))))))));
   assign  _dp_dstALU2 = (_net_1093|(_net_864|(_net_859|(_net_853|(_net_847|(_net_841|_net_827))))));
   assign  _dp_srcALU2 = (_net_1096|_net_833);
   assign  _dp_adrALU1 = _net_521;
   assign  _dp_ofs8ALU2 = _net_993;
   assign  _dp_ofs6ALU2 = (_net_784|_net_776);
   assign  _dp_selALU1 = (_net_1091|(_net_1051|(_net_1033|_net_791)));
   assign  _dp_regSEL = (_net_1091|(_net_1074|(_net_1050|(_net_1032|(_net_1005|(_net_707|_net_684))))));
   assign  _dp_regSEL2 = (_net_790|(_net_718|(_net_578|_net_497)));
   assign  _dp_setReg = (_net_1276|(_net_1053|(_net_1035|(_net_700|_net_637))));
   assign  _dp_setReg2 = (_net_794|(_net_725|(_net_602|(_net_596|(_net_589|(_net_530|(_net_520|(_net_508|(_net_485|_net_479)))))))));
   assign  _dp_ALUreg = (_net_1052|(_net_1034|_net_793));
   assign  _dp_DSTreg = _net_1275;
   assign  _dp_PCreg = _net_724;
   assign  _dp_SRCreg = (_net_636|(_net_595|(_net_588|(_net_529|(_net_507|_net_478)))));
   assign  _dp_ADRreg = (_net_601|(_net_519|_net_484));
   assign  _dp_ALUpc = (_net_1023|(_net_995|(_net_949|_net_786)));
   assign  _dp_ALUsp = (_net_1315|(_net_1310|(_net_778|(_net_771|(_net_758|(_net_745|(_net_731|(_net_703|(_net_667|_net_649)))))))));
   assign  _dp_ALUdst = (_net_1094|(_net_1044|_net_870));
   assign  _dp_ALUdstb = (_net_934|(_net_929|(_net_924|(_net_919|(_net_914|(_net_909|(_net_904|(_net_895|(_net_890|(_net_885|(_net_880|(_net_875|(_net_855|(_net_849|(_net_843|(_net_836|(_net_829|_net_823)))))))))))))))));
   assign  _dp_ALUsrc = (_net_1304|(_net_1097|_net_1047));
   assign  _dp_ALUcc_cap = (_net_936|(_net_931|(_net_926|(_net_921|(_net_916|(_net_911|(_net_906|(_net_901|(_net_897|(_net_892|(_net_887|(_net_882|(_net_877|(_net_872|(_net_867|(_net_862|(_net_857|(_net_851|(_net_845|(_net_838|(_net_831|(_net_825|(_net_661|(_net_641|_net_523))))))))))))))))))))))));
   assign  _dp_SELdst = (_net_1070|(_net_1062|_net_685));
   assign  _dp_SELsrc = (_net_1073|(_net_1065|_net_1005));
   assign  _dp_SELadr = (_net_579|_net_498);
   assign  _dp_SELpc = _net_708;
   assign  _dp_DSTadr = (_net_1179|_net_1122);
   assign  _dp_SRCadr = (_net_1158|_net_1126);
   assign  _dp_adrPC = (_net_818|_net_712);
   assign  _dp_save_stat = _net_1294;
   assign  _dp_FPpc = _net_779;
   assign  _dp_dbiFP = _net_768;
   assign  _dp_setPCrom = start;
   assign  _dp_change_opr = (_net_1164|(_net_1133|(_net_1081|(_net_1005|(_net_966|_net_957)))));
   assign  _dp_change_mode = (_net_689|(_net_683|(_net_678|(_net_677|(_net_676|(_net_650|(_net_635|(_net_631|(_net_630|_net_629)))))))));
   assign  _dp_kernel_mode = _net_1294;
   assign  _dp_reset_byte = (_net_1294|_net_975);
   assign  _dp_vectorPS = _net_1307;
   assign  _dp_ccclr = 1'b0;
   assign  _dp_ccset = _net_981;
   assign  _dp_cctaken = _net_991;
   assign  _dp_buserr = (_net_1266|(_net_1211|(_net_1170|(_net_1149|(_net_1110|(_net_1012|_net_939))))));
   assign  _dp_err = _net_977;
   assign  _dp_bpt = (_net_1289|(_net_1262|(_net_1190|(_net_1001|(_net_987|_net_816)))));
   assign  _dp_emt = _net_812;
   assign  _dp_iot = _net_814;
   assign  _dp_svc = _net_810;
   assign  _dp_segerr = (_net_1270|(_net_1207|(_net_1175|(_net_1154|(_net_1115|(_net_1017|_net_943))))));
   assign  _dp_spl = _net_809;
   assign  _dp_ccget = _net_795;
   assign  _dp_clrADR = _net_619;
   assign  _dp_oddReg = (_net_603|(_net_585|(_net_531|(_net_502|_net_486))));
   assign  _dp_mul = _net_608;
   assign  _dp_ash = _net_512;
   assign  _dp_ashc = _net_490;
   assign  _dp_div = (_net_556|_net_544);
   assign  _dp_div_end = _net_545;
   assign  _dp_div_ini0 = _net_583;
   assign  _dp_div_ini1 = _net_574;
   assign  _dp_div_ini2 = _net_570;
   assign  _dp_div_fin0 = _net_537;
   assign  _dp_div_fin1 = _net_527;
   assign  _dp_tstSRC = (_net_597|(_net_532|_net_506));
   assign  _dp_tstSRCADR = (_net_604|_net_480);
   assign  _dp_p_reset = p_reset;
   assign  _dp_m_clock = m_clock;
   assign  _id_idc_opc = _dp_opc;
   assign  _id_do = (ex|_net_952);
   assign  _id_p_reset = p_reset;
   assign  _id_m_clock = m_clock;
   assign  _cnt_inc = (_net_612|_net_560);
   assign  _cnt_rst = (_net_616|_net_564);
   assign  _cnt_p_reset = p_reset;
   assign  _cnt_m_clock = m_clock;
   assign  _proc_ifetch_set = (_net_1320|(_net_1280|(_net_1253|(_net_1200|(_net_1187|(_net_1162|(_net_1131|(_net_1079|(_net_964|(_net_960|(_net_955|start)))))))))));
   assign  _proc_ifetch_reset = (_net_1182|(_net_1176|(_net_1171|(_net_1161|(_net_1155|(_net_1150|(_net_1137|(_net_1130|(_net_1116|(_net_1111|(_net_1085|(_net_1078|(_net_1018|(_net_1013|(_net_1002|(_net_997|(_net_988|(_net_983|(_net_978|(_net_968|(_net_963|(_net_959|(_net_954|(_net_944|_net_940))))))))))))))))))))))));
   assign  _net_470 = (_proc_ifetch_set|_proc_ifetch_reset);
   assign  _proc_ex_set = (_net_1241|(_net_1238|(_net_1235|(_net_1232|(_net_1229|(_net_1226|(_net_1223|(_net_1220|(_net_1217|(_net_1183|(_net_1138|(_net_1086|_net_969))))))))))));
   assign  _proc_ex_reset = (_net_1240|(_net_1237|(_net_1234|(_net_1231|(_net_1228|(_net_1225|(_net_1222|(_net_1219|(_net_1216|(_net_1212|(_net_1208|(_net_1205|(_net_1202|(_net_1199|(_net_1195|(_net_1191|_net_1186))))))))))))))));
   assign  _net_471 = (_proc_ex_set|_proc_ex_reset);
   assign  _proc_wb_set = _net_1206;
   assign  _proc_wb_reset = (_net_1290|(_net_1284|(_net_1279|(_net_1271|(_net_1267|(_net_1263|(_net_1257|_net_1252)))))));
   assign  _net_472 = (_proc_wb_set|_proc_wb_reset);
   assign  _proc_trap_set = (_net_1291|(_net_1285|(_net_1272|(_net_1268|(_net_1264|(_net_1258|(_net_1213|(_net_1209|(_net_1203|(_net_1196|(_net_1192|(_net_1177|(_net_1172|(_net_1156|(_net_1151|(_net_1117|(_net_1112|(_net_1019|(_net_1014|(_net_1003|(_net_998|(_net_989|(_net_984|(_net_979|(_net_945|_net_941)))))))))))))))))))))))));
   assign  _proc_trap_reset = _net_1319;
   assign  _net_473 = (_proc_trap_set|_proc_trap_reset);
   assign  _net_474 = ((st2==1'b0)&(st1==1'b1));
   assign  _net_475 = (read&rdy);
   assign  _net_476 = (ex&(tsk==4'b0100));
   assign  _net_477 = (decop&_id_dashc);
   assign  _net_478 = ((decop&_id_dashc)&_net_476);
   assign  _net_479 = ((decop&_id_dashc)&_net_476);
   assign  _net_480 = ((decop&_id_dashc)&_net_476);
   assign  _net_481 = ((decop&_id_dashc)&_net_476);
   assign  _net_482 = (ex&(tsk==4'b0011));
   assign  _net_483 = (decop&_id_dashc);
   assign  _net_484 = ((decop&_id_dashc)&_net_482);
   assign  _net_485 = ((decop&_id_dashc)&_net_482);
   assign  _net_486 = ((decop&_id_dashc)&_net_482);
   assign  _net_487 = ((decop&_id_dashc)&_net_482);
   assign  _net_488 = (ex&(tsk==4'b0010));
   assign  _net_489 = (decop&_id_dashc);
   assign  _net_490 = ((decop&_id_dashc)&_net_488);
   assign  _net_491 = (((decop&_id_dashc)&_net_488)&_dp_ashdone);
   assign  _net_492 = (~_dp_ashdone);
   assign  _net_493 = ((decop&_id_dashc)&_net_488);
   assign  _net_494 = (((decop&_id_dashc)&_net_488)&_net_492);
   assign  _net_495 = (ex&(tsk==4'b0001));
   assign  _net_496 = (decop&_id_dashc);
   assign  _net_497 = ((decop&_id_dashc)&_net_495);
   assign  _net_498 = ((decop&_id_dashc)&_net_495);
   assign  _net_499 = ((decop&_id_dashc)&_net_495);
   assign  _net_500 = (ex&(tsk==4'b0000));
   assign  _net_501 = (decop&_id_dashc);
   assign  _net_502 = ((decop&_id_dashc)&_net_500);
   assign  _net_503 = ((decop&_id_dashc)&_net_500);
   assign  _net_504 = (ex&(tsk==4'b0001));
   assign  _net_505 = (decop&_id_dash);
   assign  _net_506 = ((decop&_id_dash)&_net_504);
   assign  _net_507 = ((decop&_id_dash)&_net_504);
   assign  _net_508 = ((decop&_id_dash)&_net_504);
   assign  _net_509 = ((decop&_id_dash)&_net_504);
   assign  _net_510 = (ex&(tsk==4'b0000));
   assign  _net_511 = (decop&_id_dash);
   assign  _net_512 = ((decop&_id_dash)&_net_510);
   assign  _net_513 = (((decop&_id_dash)&_net_510)&_dp_ashdone);
   assign  _net_514 = (~_dp_ashdone);
   assign  _net_515 = ((decop&_id_dash)&_net_510);
   assign  _net_516 = (((decop&_id_dash)&_net_510)&_net_514);
   assign  _net_517 = (ex&(tsk==4'b1000));
   assign  _net_518 = (decop&_id_ddiv);
   assign  _net_519 = ((decop&_id_ddiv)&_net_517);
   assign  _net_520 = ((decop&_id_ddiv)&_net_517);
   assign  _net_521 = ((decop&_id_ddiv)&_net_517);
   assign  _net_522 = ((decop&_id_ddiv)&_net_517);
   assign  _net_523 = ((decop&_id_ddiv)&_net_517);
   assign  _net_524 = ((decop&_id_ddiv)&_net_517);
   assign  _net_525 = (ex&(tsk==4'b0111));
   assign  _net_526 = (decop&_id_ddiv);
   assign  _net_527 = ((decop&_id_ddiv)&_net_525);
   assign  _net_528 = ((decop&_id_ddiv)&_net_525);
   assign  _net_529 = ((decop&_id_ddiv)&_net_525);
   assign  _net_530 = ((decop&_id_ddiv)&_net_525);
   assign  _net_531 = ((decop&_id_ddiv)&_net_525);
   assign  _net_532 = ((decop&_id_ddiv)&_net_525);
   assign  _net_533 = (ex&(tsk==4'b0110));
   assign  _net_534 = (decop&_id_ddiv);
   assign  _net_535 = (~(_dp_psw[1]));
   assign  _net_536 = ((decop&_id_ddiv)&_net_533);
   assign  _net_537 = (((decop&_id_ddiv)&_net_533)&_net_535);
   assign  _net_538 = (((decop&_id_ddiv)&_net_533)&_net_535);
   assign  _net_539 = (_dp_psw[1]);
   assign  _net_540 = ((decop&_id_ddiv)&_net_533);
   assign  _net_541 = (((decop&_id_ddiv)&_net_533)&_net_539);
   assign  _net_542 = (ex&(tsk==4'b0101));
   assign  _net_543 = (decop&_id_ddiv);
   assign  _net_544 = ((decop&_id_ddiv)&_net_542);
   assign  _net_545 = ((decop&_id_ddiv)&_net_542);
   assign  _net_546 = (~(_dp_psw[1]));
   assign  _net_547 = ((decop&_id_ddiv)&_net_542);
   assign  _net_548 = (((decop&_id_ddiv)&_net_542)&_net_546);
   assign  _net_549 = (_dp_psw[1]);
   assign  _net_550 = ((decop&_id_ddiv)&_net_542);
   assign  _net_551 = (((decop&_id_ddiv)&_net_542)&_net_549);
   assign  _net_552 = (ex&(tsk==4'b0100));
   assign  _net_553 = (decop&_id_ddiv);
   assign  _net_554 = (~(_dp_psw[1]));
   assign  _net_555 = ((decop&_id_ddiv)&_net_552);
   assign  _net_556 = (((decop&_id_ddiv)&_net_552)&_net_554);
   assign  _net_557 = ((~(_dp_psw[1]))&(~(_cnt_out==4'b1111)));
   assign  _net_558 = ((decop&_id_ddiv)&_net_552);
   assign  _net_559 = (((decop&_id_ddiv)&_net_552)&_net_557);
   assign  _net_560 = (((decop&_id_ddiv)&_net_552)&_net_557);
   assign  _net_561 = ((~(_dp_psw[1]))&(_cnt_out==4'b1111));
   assign  _net_562 = ((decop&_id_ddiv)&_net_552);
   assign  _net_563 = (((decop&_id_ddiv)&_net_552)&_net_561);
   assign  _net_564 = (((decop&_id_ddiv)&_net_552)&_net_561);
   assign  _net_565 = (_dp_psw[1]);
   assign  _net_566 = ((decop&_id_ddiv)&_net_552);
   assign  _net_567 = (((decop&_id_ddiv)&_net_552)&_net_565);
   assign  _net_568 = (ex&(tsk==4'b0011));
   assign  _net_569 = (decop&_id_ddiv);
   assign  _net_570 = ((decop&_id_ddiv)&_net_568);
   assign  _net_571 = ((decop&_id_ddiv)&_net_568);
   assign  _net_572 = (ex&(tsk==4'b0010));
   assign  _net_573 = (decop&_id_ddiv);
   assign  _net_574 = ((decop&_id_ddiv)&_net_572);
   assign  _net_575 = ((decop&_id_ddiv)&_net_572);
   assign  _net_576 = (ex&(tsk==4'b0001));
   assign  _net_577 = (decop&_id_ddiv);
   assign  _net_578 = ((decop&_id_ddiv)&_net_576);
   assign  _net_579 = ((decop&_id_ddiv)&_net_576);
   assign  _net_580 = ((decop&_id_ddiv)&_net_576);
   assign  _net_581 = (ex&(tsk==4'b0000));
   assign  _net_582 = (decop&_id_ddiv);
   assign  _net_583 = ((decop&_id_ddiv)&_net_581);
   assign  _net_584 = ((decop&_id_ddiv)&_net_581);
   assign  _net_585 = ((decop&_id_ddiv)&_net_581);
   assign  _net_586 = (ex&(tsk==4'b0011));
   assign  _net_587 = (decop&_id_dmul);
   assign  _net_588 = ((decop&_id_dmul)&_net_586);
   assign  _net_589 = ((decop&_id_dmul)&_net_586);
   assign  _net_590 = ((decop&_id_dmul)&_net_586);
   assign  _net_591 = (ex&(tsk==4'b0010));
   assign  _net_592 = (decop&_id_dmul);
   assign  _net_593 = (_dp_opc[6]);
   assign  _net_594 = ((decop&_id_dmul)&_net_591);
   assign  _net_595 = (((decop&_id_dmul)&_net_591)&_net_593);
   assign  _net_596 = (((decop&_id_dmul)&_net_591)&_net_593);
   assign  _net_597 = (((decop&_id_dmul)&_net_591)&_net_593);
   assign  _net_598 = (((decop&_id_dmul)&_net_591)&_net_593);
   assign  _net_599 = (~(_dp_opc[6]));
   assign  _net_600 = ((decop&_id_dmul)&_net_591);
   assign  _net_601 = (((decop&_id_dmul)&_net_591)&_net_599);
   assign  _net_602 = (((decop&_id_dmul)&_net_591)&_net_599);
   assign  _net_603 = (((decop&_id_dmul)&_net_591)&_net_599);
   assign  _net_604 = (((decop&_id_dmul)&_net_591)&_net_599);
   assign  _net_605 = (((decop&_id_dmul)&_net_591)&_net_599);
   assign  _net_606 = (ex&(tsk==4'b0001));
   assign  _net_607 = (decop&_id_dmul);
   assign  _net_608 = ((decop&_id_dmul)&_net_606);
   assign  _net_609 = (~(_cnt_out==4'b1111));
   assign  _net_610 = ((decop&_id_dmul)&_net_606);
   assign  _net_611 = (((decop&_id_dmul)&_net_606)&_net_609);
   assign  _net_612 = (((decop&_id_dmul)&_net_606)&_net_609);
   assign  _net_613 = (_cnt_out==4'b1111);
   assign  _net_614 = ((decop&_id_dmul)&_net_606);
   assign  _net_615 = (((decop&_id_dmul)&_net_606)&_net_613);
   assign  _net_616 = (((decop&_id_dmul)&_net_606)&_net_613);
   assign  _net_617 = (ex&(tsk==4'b0000));
   assign  _net_618 = (decop&_id_dmul);
   assign  _net_619 = ((decop&_id_dmul)&_net_617);
   assign  _net_620 = ((decop&_id_dmul)&_net_617);
   assign  _net_621 = (ex&(tsk==4'b0001));
   assign  _net_622 = (decop&_id_dmtpi);
   assign  _net_623 = (|(_dp_opc[5:3]));
   assign  _net_624 = ((decop&_id_dmtpi)&_net_621);
   assign  _net_625 = (((decop&_id_dmtpi)&_net_621)&_net_623);
   assign  _net_626 = (((decop&_id_dmtpi)&_net_621)&_net_623);
   assign  _net_627 = (((decop&_id_dmtpi)&_net_621)&_net_623);
   assign  _net_628 = (((decop&_id_dmtpi)&_net_621)&_net_623);
   assign  _net_629 = ((((decop&_id_dmtpi)&_net_621)&_net_623)&error_sig);
   assign  _net_630 = ((((decop&_id_dmtpi)&_net_621)&_net_623)&fault);
   assign  _net_631 = ((((decop&_id_dmtpi)&_net_621)&_net_623)&rdy);
   assign  _net_632 = ((((decop&_id_dmtpi)&_net_621)&_net_623)&rdy);
   assign  _net_633 = (~(|(_dp_opc[5:3])));
   assign  _net_634 = ((decop&_id_dmtpi)&_net_621);
   assign  _net_635 = (((decop&_id_dmtpi)&_net_621)&_net_633);
   assign  _net_636 = (((decop&_id_dmtpi)&_net_621)&_net_633);
   assign  _net_637 = (((decop&_id_dmtpi)&_net_621)&_net_633);
   assign  _net_638 = (((decop&_id_dmtpi)&_net_621)&_net_633);
   assign  _net_639 = ((decop&_id_dmtpi)&_net_621);
   assign  _net_640 = ((decop&_id_dmtpi)&_net_621);
   assign  _net_641 = ((decop&_id_dmtpi)&_net_621);
   assign  _net_642 = (ex&(tsk==4'b0000));
   assign  _net_643 = (decop&_id_dmtpi);
   assign  _net_644 = ((decop&_id_dmtpi)&_net_642);
   assign  _net_645 = ((decop&_id_dmtpi)&_net_642);
   assign  _net_646 = ((decop&_id_dmtpi)&_net_642);
   assign  _net_647 = (((decop&_id_dmtpi)&_net_642)&rdy);
   assign  _net_648 = (((decop&_id_dmtpi)&_net_642)&rdy);
   assign  _net_649 = (((decop&_id_dmtpi)&_net_642)&rdy);
   assign  _net_650 = (((decop&_id_dmtpi)&_net_642)&rdy);
   assign  _net_651 = (((decop&_id_dmtpi)&_net_642)&rdy);
   assign  _net_652 = (((decop&_id_dmtpi)&_net_642)&rdy);
   assign  _net_653 = (ex&(tsk==4'b0011));
   assign  _net_654 = (decop&_id_dmfpi);
   assign  _net_655 = ((decop&_id_dmfpi)&_net_653);
   assign  _net_656 = ((decop&_id_dmfpi)&_net_653);
   assign  _net_657 = ((decop&_id_dmfpi)&_net_653);
   assign  _net_658 = ((decop&_id_dmfpi)&_net_653);
   assign  _net_659 = (((decop&_id_dmfpi)&_net_653)&rdy);
   assign  _net_660 = (((decop&_id_dmfpi)&_net_653)&rdy);
   assign  _net_661 = (((decop&_id_dmfpi)&_net_653)&rdy);
   assign  _net_662 = (((decop&_id_dmfpi)&_net_653)&rdy);
   assign  _net_663 = (ex&(tsk==4'b0010));
   assign  _net_664 = (decop&_id_dmfpi);
   assign  _net_665 = ((decop&_id_dmfpi)&_net_663);
   assign  _net_666 = ((decop&_id_dmfpi)&_net_663);
   assign  _net_667 = ((decop&_id_dmfpi)&_net_663);
   assign  _net_668 = ((decop&_id_dmfpi)&_net_663);
   assign  _net_669 = (ex&(tsk==4'b0001));
   assign  _net_670 = (decop&_id_dmfpi);
   assign  _net_671 = (|(_dp_opc[5:3]));
   assign  _net_672 = ((decop&_id_dmfpi)&_net_669);
   assign  _net_673 = (((decop&_id_dmfpi)&_net_669)&_net_671);
   assign  _net_674 = (((decop&_id_dmfpi)&_net_669)&_net_671);
   assign  _net_675 = (((decop&_id_dmfpi)&_net_669)&_net_671);
   assign  _net_676 = ((((decop&_id_dmfpi)&_net_669)&_net_671)&error_sig);
   assign  _net_677 = ((((decop&_id_dmfpi)&_net_669)&_net_671)&fault);
   assign  _net_678 = ((((decop&_id_dmfpi)&_net_669)&_net_671)&rdy);
   assign  _net_679 = ((((decop&_id_dmfpi)&_net_669)&_net_671)&rdy);
   assign  _net_680 = ((((decop&_id_dmfpi)&_net_669)&_net_671)&rdy);
   assign  _net_681 = (~(|(_dp_opc[5:3])));
   assign  _net_682 = ((decop&_id_dmfpi)&_net_669);
   assign  _net_683 = (((decop&_id_dmfpi)&_net_669)&_net_681);
   assign  _net_684 = (((decop&_id_dmfpi)&_net_669)&_net_681);
   assign  _net_685 = (((decop&_id_dmfpi)&_net_669)&_net_681);
   assign  _net_686 = (((decop&_id_dmfpi)&_net_669)&_net_681);
   assign  _net_687 = (ex&(tsk==4'b0000));
   assign  _net_688 = (decop&_id_dmfpi);
   assign  _net_689 = ((decop&_id_dmfpi)&_net_687);
   assign  _net_690 = ((decop&_id_dmfpi)&_net_687);
   assign  _net_691 = (ex&(tsk==4'b0001));
   assign  _net_692 = (decop&_id_drts);
   assign  _net_693 = ((decop&_id_drts)&_net_691);
   assign  _net_694 = ((decop&_id_drts)&_net_691);
   assign  _net_695 = ((decop&_id_drts)&_net_691);
   assign  _net_696 = (~rdy);
   assign  _net_697 = ((decop&_id_drts)&_net_691);
   assign  _net_698 = (((decop&_id_drts)&_net_691)&_net_696);
   assign  _net_699 = (((decop&_id_drts)&_net_691)&rdy);
   assign  _net_700 = (((decop&_id_drts)&_net_691)&rdy);
   assign  _net_701 = (((decop&_id_drts)&_net_691)&rdy);
   assign  _net_702 = (((decop&_id_drts)&_net_691)&rdy);
   assign  _net_703 = (((decop&_id_drts)&_net_691)&rdy);
   assign  _net_704 = (((decop&_id_drts)&_net_691)&rdy);
   assign  _net_705 = (ex&(tsk==4'b0000));
   assign  _net_706 = (decop&_id_drts);
   assign  _net_707 = ((decop&_id_drts)&_net_705);
   assign  _net_708 = ((decop&_id_drts)&_net_705);
   assign  _net_709 = ((decop&_id_drts)&_net_705);
   assign  _net_710 = (ex&(tsk==4'b0010));
   assign  _net_711 = (decop&_id_djsr);
   assign  _net_712 = ((decop&_id_djsr)&_net_710);
   assign  _net_713 = ((decop&_id_djsr)&_net_710);
   assign  _net_714 = (ex&(tsk==4'b0001));
   assign  _net_715 = (decop&_id_djsr);
   assign  _net_716 = ((decop&_id_djsr)&_net_714);
   assign  _net_717 = ((decop&_id_djsr)&_net_714);
   assign  _net_718 = ((decop&_id_djsr)&_net_714);
   assign  _net_719 = ((decop&_id_djsr)&_net_714);
   assign  _net_720 = ((decop&_id_djsr)&_net_714);
   assign  _net_721 = (~rdy);
   assign  _net_722 = ((decop&_id_djsr)&_net_714);
   assign  _net_723 = (((decop&_id_djsr)&_net_714)&_net_721);
   assign  _net_724 = (((decop&_id_djsr)&_net_714)&rdy);
   assign  _net_725 = (((decop&_id_djsr)&_net_714)&rdy);
   assign  _net_726 = (((decop&_id_djsr)&_net_714)&rdy);
   assign  _net_727 = (ex&(tsk==4'b0000));
   assign  _net_728 = (decop&_id_djsr);
   assign  _net_729 = ((decop&_id_djsr)&_net_727);
   assign  _net_730 = ((decop&_id_djsr)&_net_727);
   assign  _net_731 = ((decop&_id_djsr)&_net_727);
   assign  _net_732 = ((decop&_id_djsr)&_net_727);
   assign  _net_733 = (_id_drti|_id_drtt);
   assign  _net_734 = (ex&(tsk==4'b0001));
   assign  _net_735 = (decop&_net_733);
   assign  _net_736 = ((decop&_net_733)&_net_734);
   assign  _net_737 = ((decop&_net_733)&_net_734);
   assign  _net_738 = ((decop&_net_733)&_net_734);
   assign  _net_739 = (~rdy);
   assign  _net_740 = ((decop&_net_733)&_net_734);
   assign  _net_741 = (((decop&_net_733)&_net_734)&_net_739);
   assign  _net_742 = (((decop&_net_733)&_net_734)&rdy);
   assign  _net_743 = (((decop&_net_733)&_net_734)&rdy);
   assign  _net_744 = (((decop&_net_733)&_net_734)&rdy);
   assign  _net_745 = (((decop&_net_733)&_net_734)&rdy);
   assign  _net_746 = (((decop&_net_733)&_net_734)&rdy);
   assign  _net_747 = (ex&(tsk==4'b0000));
   assign  _net_748 = (decop&_net_733);
   assign  _net_749 = ((decop&_net_733)&_net_747);
   assign  _net_750 = ((decop&_net_733)&_net_747);
   assign  _net_751 = ((decop&_net_733)&_net_747);
   assign  _net_752 = (~rdy);
   assign  _net_753 = ((decop&_net_733)&_net_747);
   assign  _net_754 = (((decop&_net_733)&_net_747)&_net_752);
   assign  _net_755 = (((decop&_net_733)&_net_747)&rdy);
   assign  _net_756 = (((decop&_net_733)&_net_747)&rdy);
   assign  _net_757 = (((decop&_net_733)&_net_747)&rdy);
   assign  _net_758 = (((decop&_net_733)&_net_747)&rdy);
   assign  _net_759 = (((decop&_net_733)&_net_747)&rdy);
   assign  _net_760 = (ex&(tsk==4'b0001));
   assign  _net_761 = (decop&_id_dmark);
   assign  _net_762 = ((decop&_id_dmark)&_net_760);
   assign  _net_763 = ((decop&_id_dmark)&_net_760);
   assign  _net_764 = ((decop&_id_dmark)&_net_760);
   assign  _net_765 = (~rdy);
   assign  _net_766 = ((decop&_id_dmark)&_net_760);
   assign  _net_767 = (((decop&_id_dmark)&_net_760)&_net_765);
   assign  _net_768 = (((decop&_id_dmark)&_net_760)&rdy);
   assign  _net_769 = (((decop&_id_dmark)&_net_760)&rdy);
   assign  _net_770 = (((decop&_id_dmark)&_net_760)&rdy);
   assign  _net_771 = (((decop&_id_dmark)&_net_760)&rdy);
   assign  _net_772 = (((decop&_id_dmark)&_net_760)&rdy);
   assign  _net_773 = (ex&(tsk==4'b0000));
   assign  _net_774 = (decop&_id_dmark);
   assign  _net_775 = ((decop&_id_dmark)&_net_773);
   assign  _net_776 = ((decop&_id_dmark)&_net_773);
   assign  _net_777 = ((decop&_id_dmark)&_net_773);
   assign  _net_778 = ((decop&_id_dmark)&_net_773);
   assign  _net_779 = ((decop&_id_dmark)&_net_773);
   assign  _net_780 = ((decop&_id_dmark)&_net_773);
   assign  _net_781 = (ex&(tsk==4'b0001));
   assign  _net_782 = (decop&_id_dsob);
   assign  _net_783 = ((decop&_id_dsob)&_net_781);
   assign  _net_784 = ((decop&_id_dsob)&_net_781);
   assign  _net_785 = ((decop&_id_dsob)&_net_781);
   assign  _net_786 = ((decop&_id_dsob)&_net_781);
   assign  _net_787 = ((decop&_id_dsob)&_net_781);
   assign  _net_788 = (ex&(tsk==4'b0000));
   assign  _net_789 = (decop&_id_dsob);
   assign  _net_790 = ((decop&_id_dsob)&_net_788);
   assign  _net_791 = ((decop&_id_dsob)&_net_788);
   assign  _net_792 = ((decop&_id_dsob)&_net_788);
   assign  _net_793 = ((decop&_id_dsob)&_net_788);
   assign  _net_794 = ((decop&_id_dsob)&_net_788);
   assign  _net_795 = ((decop&_id_dsob)&_net_788);
   assign  _net_796 = (~(_dp_alucc[2]));
   assign  _net_797 = ((decop&_id_dsob)&_net_788);
   assign  _net_798 = (((decop&_id_dsob)&_net_788)&_net_796);
   assign  _net_799 = (_dp_alucc[2]);
   assign  _net_800 = ((decop&_id_dsob)&_net_788);
   assign  _net_801 = (((decop&_id_dsob)&_net_788)&_net_799);
   assign  _net_802 = ((decop&_id_diwait)&irq_in);
   assign  _net_803 = (~irq_in);
   assign  _net_804 = (decop&_id_diwait);
   assign  _net_805 = ((decop&_id_diwait)&_net_803);
   assign  _net_806 = (decop&_id_dreset);
   assign  _net_807 = (decop&_id_dfloat);
   assign  _net_808 = (decop&_id_dspl);
   assign  _net_809 = (decop&_id_dspl);
   assign  _net_810 = (decop&_id_dtrap);
   assign  _net_811 = (decop&_id_dtrap);
   assign  _net_812 = (decop&_id_demt);
   assign  _net_813 = (decop&_id_demt);
   assign  _net_814 = (decop&_id_diot);
   assign  _net_815 = (decop&_id_diot);
   assign  _net_816 = (decop&_id_dbpt);
   assign  _net_817 = (decop&_id_dbpt);
   assign  _net_818 = (decop&_id_djmp);
   assign  _net_819 = (decop&_id_djmp);
   assign  _net_820 = (decop&_id_dnop);
   assign  _net_821 = (decop&_id_dswab);
   assign  _net_822 = (decop&_id_dswab);
   assign  _net_823 = (decop&_id_dswab);
   assign  _net_824 = (decop&_id_dswab);
   assign  _net_825 = (decop&_id_dswab);
   assign  _net_826 = (decop&_id_dexor);
   assign  _net_827 = (decop&_id_dexor);
   assign  _net_828 = (decop&_id_dexor);
   assign  _net_829 = (decop&_id_dexor);
   assign  _net_830 = (decop&_id_dexor);
   assign  _net_831 = (decop&_id_dexor);
   assign  _net_832 = (_id_dadd&rsub);
   assign  _net_833 = (decop&_net_832);
   assign  _net_834 = (decop&_net_832);
   assign  _net_835 = (decop&_net_832);
   assign  _net_836 = (decop&_net_832);
   assign  _net_837 = (decop&_net_832);
   assign  _net_838 = (decop&_net_832);
   assign  _net_839 = (_id_dadd&(~rsub));
   assign  _net_840 = (decop&_net_839);
   assign  _net_841 = (decop&_net_839);
   assign  _net_842 = (decop&_net_839);
   assign  _net_843 = (decop&_net_839);
   assign  _net_844 = (decop&_net_839);
   assign  _net_845 = (decop&_net_839);
   assign  _net_846 = (decop&_id_dbis);
   assign  _net_847 = (decop&_id_dbis);
   assign  _net_848 = (decop&_id_dbis);
   assign  _net_849 = (decop&_id_dbis);
   assign  _net_850 = (decop&_id_dbis);
   assign  _net_851 = (decop&_id_dbis);
   assign  _net_852 = (decop&_id_dbic);
   assign  _net_853 = (decop&_id_dbic);
   assign  _net_854 = (decop&_id_dbic);
   assign  _net_855 = (decop&_id_dbic);
   assign  _net_856 = (decop&_id_dbic);
   assign  _net_857 = (decop&_id_dbic);
   assign  _net_858 = (decop&_id_dbit);
   assign  _net_859 = (decop&_id_dbit);
   assign  _net_860 = (decop&_id_dbit);
   assign  _net_861 = (decop&_id_dbit);
   assign  _net_862 = (decop&_id_dbit);
   assign  _net_863 = (decop&_id_dcmp);
   assign  _net_864 = (decop&_id_dcmp);
   assign  _net_865 = (decop&_id_dcmp);
   assign  _net_866 = (decop&_id_dcmp);
   assign  _net_867 = (decop&_id_dcmp);
   assign  _net_868 = (decop&_id_dmov);
   assign  _net_869 = (decop&_id_dmov);
   assign  _net_870 = (decop&_id_dmov);
   assign  _net_871 = (decop&_id_dmov);
   assign  _net_872 = (decop&_id_dmov);
   assign  _net_873 = (decop&_id_dsxt);
   assign  _net_874 = (decop&_id_dsxt);
   assign  _net_875 = (decop&_id_dsxt);
   assign  _net_876 = (decop&_id_dsxt);
   assign  _net_877 = (decop&_id_dsxt);
   assign  _net_878 = (decop&_id_dasl);
   assign  _net_879 = (decop&_id_dasl);
   assign  _net_880 = (decop&_id_dasl);
   assign  _net_881 = (decop&_id_dasl);
   assign  _net_882 = (decop&_id_dasl);
   assign  _net_883 = (decop&_id_dasr);
   assign  _net_884 = (decop&_id_dasr);
   assign  _net_885 = (decop&_id_dasr);
   assign  _net_886 = (decop&_id_dasr);
   assign  _net_887 = (decop&_id_dasr);
   assign  _net_888 = (decop&_id_drol);
   assign  _net_889 = (decop&_id_drol);
   assign  _net_890 = (decop&_id_drol);
   assign  _net_891 = (decop&_id_drol);
   assign  _net_892 = (decop&_id_drol);
   assign  _net_893 = (decop&_id_dror);
   assign  _net_894 = (decop&_id_dror);
   assign  _net_895 = (decop&_id_dror);
   assign  _net_896 = (decop&_id_dror);
   assign  _net_897 = (decop&_id_dror);
   assign  _net_898 = (decop&_id_dtst);
   assign  _net_899 = (decop&_id_dtst);
   assign  _net_900 = (decop&_id_dtst);
   assign  _net_901 = (decop&_id_dtst);
   assign  _net_902 = (decop&_id_dsbc);
   assign  _net_903 = (decop&_id_dsbc);
   assign  _net_904 = (decop&_id_dsbc);
   assign  _net_905 = (decop&_id_dsbc);
   assign  _net_906 = (decop&_id_dsbc);
   assign  _net_907 = (decop&_id_dadc);
   assign  _net_908 = (decop&_id_dadc);
   assign  _net_909 = (decop&_id_dadc);
   assign  _net_910 = (decop&_id_dadc);
   assign  _net_911 = (decop&_id_dadc);
   assign  _net_912 = (decop&_id_dneg);
   assign  _net_913 = (decop&_id_dneg);
   assign  _net_914 = (decop&_id_dneg);
   assign  _net_915 = (decop&_id_dneg);
   assign  _net_916 = (decop&_id_dneg);
   assign  _net_917 = (decop&_id_ddec);
   assign  _net_918 = (decop&_id_ddec);
   assign  _net_919 = (decop&_id_ddec);
   assign  _net_920 = (decop&_id_ddec);
   assign  _net_921 = (decop&_id_ddec);
   assign  _net_922 = (decop&_id_dinc);
   assign  _net_923 = (decop&_id_dinc);
   assign  _net_924 = (decop&_id_dinc);
   assign  _net_925 = (decop&_id_dinc);
   assign  _net_926 = (decop&_id_dinc);
   assign  _net_927 = (decop&_id_dcom);
   assign  _net_928 = (decop&_id_dcom);
   assign  _net_929 = (decop&_id_dcom);
   assign  _net_930 = (decop&_id_dcom);
   assign  _net_931 = (decop&_id_dcom);
   assign  _net_932 = (decop&_id_dclr);
   assign  _net_933 = (decop&_id_dclr);
   assign  _net_934 = (decop&_id_dclr);
   assign  _net_935 = (decop&_id_dclr);
   assign  _net_936 = (decop&_id_dclr);
   assign  _net_938 = ((_reg_937==_state__reg_937_if0)&ifetch);
   assign  _net_939 = (_net_938&error_sig);
   assign  _net_940 = (_net_938&error_sig);
   assign  _net_941 = (_net_938&error_sig);
   assign  _net_942 = (_net_938&error_sig);
   assign  _net_943 = (_net_938&fault);
   assign  _net_944 = (_net_938&fault);
   assign  _net_945 = (_net_938&fault);
   assign  _net_946 = (_net_938&fault);
   assign  _net_947 = (_net_938&rdy);
   assign  _net_948 = (_net_938&rdy);
   assign  _net_949 = (_net_938&rdy);
   assign  _net_950 = (_net_938&rdy);
   assign  _net_951 = (_net_938&rdy);
   assign  _net_952 = ((_reg_937==_state__reg_937_id0)&ifetch);
   assign  _net_953 = (_net_952&_id_sop);
   assign  _net_954 = (_net_952&_id_sop);
   assign  _net_955 = (_net_952&_id_sop);
   assign  _net_956 = (_net_952&_id_sop);
   assign  _net_957 = (_net_952&_id_sop);
   assign  _net_958 = (_net_952&_id_dop);
   assign  _net_959 = (_net_952&_id_dop);
   assign  _net_960 = (_net_952&_id_dop);
   assign  _net_961 = (_net_952&_id_dop);
   assign  _net_962 = (_net_952&_id_rsd);
   assign  _net_963 = (_net_952&_id_rsd);
   assign  _net_964 = (_net_952&_id_rsd);
   assign  _net_965 = (_net_952&_id_rsd);
   assign  _net_966 = (_net_952&_id_rsd);
   assign  _net_967 = (_net_952&_id_nof);
   assign  _net_968 = (_net_952&_id_nof);
   assign  _net_969 = (_net_952&_id_nof);
   assign  _net_970 = (_net_952&_id_nof);
   assign  _net_971 = (_net_952&_id_cco);
   assign  _net_972 = (_net_952&_id_bra);
   assign  _net_973 = (_net_952&_id_dadd);
   assign  _net_974 = (_net_952&_id_dsub);
   assign  _net_975 = (_net_952&_id_dsub);
   assign  _net_976 = (_net_952&_id_unused);
   assign  _net_977 = (_net_952&_id_unused);
   assign  _net_978 = (_net_952&_id_unused);
   assign  _net_979 = (_net_952&_id_unused);
   assign  _net_980 = (_net_952&_id_unused);
   assign  _net_981 = ((_reg_937==_state__reg_937_cc0)&ifetch);
   assign  _net_982 = ((~(trapkind==3'b010))&irq_in);
   assign  _net_983 = (_net_981&_net_982);
   assign  _net_984 = (_net_981&_net_982);
   assign  _net_985 = (_net_981&_net_982);
   assign  _net_986 = (trapkind==3'b010);
   assign  _net_987 = (_net_981&_net_986);
   assign  _net_988 = (_net_981&_net_986);
   assign  _net_989 = (_net_981&_net_986);
   assign  _net_990 = (_net_981&_net_986);
   assign  _net_991 = ((_reg_937==_state__reg_937_br0)&ifetch);
   assign  _net_992 = (_net_991&_dp_taken);
   assign  _net_993 = (_net_991&_dp_taken);
   assign  _net_994 = (_net_991&_dp_taken);
   assign  _net_995 = (_net_991&_dp_taken);
   assign  _net_996 = ((~(trapkind==3'b010))&irq_in);
   assign  _net_997 = (_net_991&_net_996);
   assign  _net_998 = (_net_991&_net_996);
   assign  _net_999 = (_net_991&_net_996);
   assign  _net_1000 = (trapkind==3'b010);
   assign  _net_1001 = (_net_991&_net_1000);
   assign  _net_1002 = (_net_991&_net_1000);
   assign  _net_1003 = (_net_991&_net_1000);
   assign  _net_1004 = (_net_991&_net_1000);
   assign  _net_1005 = ((_reg_937==_state__reg_937_of0)&ifetch);
   assign  _net_1006 = ((_reg_937==_state__reg_937_of1)&ifetch);
   assign  _net_1007 = ((_dp_opc[5:4])==2'b11);
   assign  _net_1008 = (_net_1006&_net_1007);
   assign  _net_1009 = (_net_1006&_net_1007);
   assign  _net_1010 = (_net_1006&_net_1007);
   assign  _net_1011 = ((_net_1006&_net_1007)&error_sig);
   assign  _net_1012 = ((_net_1006&_net_1007)&error_sig);
   assign  _net_1013 = ((_net_1006&_net_1007)&error_sig);
   assign  _net_1014 = ((_net_1006&_net_1007)&error_sig);
   assign  _net_1015 = ((_net_1006&_net_1007)&error_sig);
   assign  _net_1016 = ((_net_1006&_net_1007)&fault);
   assign  _net_1017 = ((_net_1006&_net_1007)&fault);
   assign  _net_1018 = ((_net_1006&_net_1007)&fault);
   assign  _net_1019 = ((_net_1006&_net_1007)&fault);
   assign  _net_1020 = ((_net_1006&_net_1007)&fault);
   assign  _net_1021 = ((_net_1006&_net_1007)&rdy);
   assign  _net_1022 = ((_net_1006&_net_1007)&rdy);
   assign  _net_1023 = ((_net_1006&_net_1007)&rdy);
   assign  _net_1024 = (ifruns==2'b10);
   assign  _net_1025 = ((_net_1006&_net_1007)&rdy);
   assign  _net_1026 = (((_net_1006&_net_1007)&rdy)&_net_1024);
   assign  _net_1027 = (ifruns==2'b01);
   assign  _net_1028 = ((_net_1006&_net_1007)&rdy);
   assign  _net_1029 = (((_net_1006&_net_1007)&rdy)&_net_1027);
   assign  _net_1030 = ((_net_1006&_net_1007)&rdy);
   assign  _net_1031 = ((_dp_opc[5:4])==2'b10);
   assign  _net_1032 = (_net_1006&_net_1031);
   assign  _net_1033 = (_net_1006&_net_1031);
   assign  _net_1034 = (_net_1006&_net_1031);
   assign  _net_1035 = (_net_1006&_net_1031);
   assign  _net_1036 = ((_dp_opc[15])&(~((_dp_opc[3])|((_dp_opc[2])&(_dp_opc[1])))));
   assign  _net_1037 = (_net_1006&_net_1031);
   assign  _net_1038 = ((_net_1006&_net_1031)&_net_1036);
   assign  _net_1039 = ((~(_dp_opc[15]))|((_dp_opc[3])|((_dp_opc[2])&(_dp_opc[1]))));
   assign  _net_1040 = (_net_1006&_net_1031);
   assign  _net_1041 = ((_net_1006&_net_1031)&_net_1039);
   assign  _net_1042 = (ifruns==2'b10);
   assign  _net_1043 = (_net_1006&_net_1031);
   assign  _net_1044 = ((_net_1006&_net_1031)&_net_1042);
   assign  _net_1045 = (ifruns==2'b01);
   assign  _net_1046 = (_net_1006&_net_1031);
   assign  _net_1047 = ((_net_1006&_net_1031)&_net_1045);
   assign  _net_1048 = (_net_1006&_net_1031);
   assign  _net_1049 = ((_dp_opc[5:4])==2'b01);
   assign  _net_1050 = (_net_1006&_net_1049);
   assign  _net_1051 = (_net_1006&_net_1049);
   assign  _net_1052 = (_net_1006&_net_1049);
   assign  _net_1053 = (_net_1006&_net_1049);
   assign  _net_1054 = ((_dp_opc[15])&(~((_dp_opc[3])|((_dp_opc[2])&(_dp_opc[1])))));
   assign  _net_1055 = (_net_1006&_net_1049);
   assign  _net_1056 = ((_net_1006&_net_1049)&_net_1054);
   assign  _net_1057 = ((~(_dp_opc[15]))|((_dp_opc[3])|((_dp_opc[2])&(_dp_opc[1]))));
   assign  _net_1058 = (_net_1006&_net_1049);
   assign  _net_1059 = ((_net_1006&_net_1049)&_net_1057);
   assign  _net_1060 = (ifruns==2'b10);
   assign  _net_1061 = (_net_1006&_net_1049);
   assign  _net_1062 = ((_net_1006&_net_1049)&_net_1060);
   assign  _net_1063 = (ifruns==2'b01);
   assign  _net_1064 = (_net_1006&_net_1049);
   assign  _net_1065 = ((_net_1006&_net_1049)&_net_1063);
   assign  _net_1066 = (_net_1006&_net_1049);
   assign  _net_1067 = ((_dp_opc[5:4])==2'b00);
   assign  _net_1068 = (ifruns==2'b10);
   assign  _net_1069 = (_net_1006&_net_1067);
   assign  _net_1070 = ((_net_1006&_net_1067)&_net_1068);
   assign  _net_1071 = (ifruns==2'b01);
   assign  _net_1072 = (_net_1006&_net_1067);
   assign  _net_1073 = ((_net_1006&_net_1067)&_net_1071);
   assign  _net_1074 = (_net_1006&_net_1067);
   assign  _net_1075 = ((ifruns==2'b01)&(~(_dp_opc[3])));
   assign  _net_1076 = (_net_1006&_net_1067);
   assign  _net_1077 = ((_net_1006&_net_1067)&_net_1075);
   assign  _net_1078 = ((_net_1006&_net_1067)&_net_1075);
   assign  _net_1079 = ((_net_1006&_net_1067)&_net_1075);
   assign  _net_1080 = ((_net_1006&_net_1067)&_net_1075);
   assign  _net_1081 = ((_net_1006&_net_1067)&_net_1075);
   assign  _net_1082 = ((ifruns==2'b10)&(~(_dp_opc[3])));
   assign  _net_1083 = (_net_1006&_net_1067);
   assign  _net_1084 = ((_net_1006&_net_1067)&_net_1082);
   assign  _net_1085 = ((_net_1006&_net_1067)&_net_1082);
   assign  _net_1086 = ((_net_1006&_net_1067)&_net_1082);
   assign  _net_1087 = ((_net_1006&_net_1067)&_net_1082);
   assign  _net_1088 = (_dp_opc[3]);
   assign  _net_1089 = (_net_1006&_net_1067);
   assign  _net_1090 = ((_net_1006&_net_1067)&_net_1088);
   assign  _net_1091 = ((_reg_937==_state__reg_937_of2)&ifetch);
   assign  _net_1092 = (ifruns==2'b10);
   assign  _net_1093 = (_net_1091&_net_1092);
   assign  _net_1094 = (_net_1091&_net_1092);
   assign  _net_1095 = (ifruns==2'b01);
   assign  _net_1096 = (_net_1091&_net_1095);
   assign  _net_1097 = (_net_1091&_net_1095);
   assign  _net_1098 = ((_reg_937==_state__reg_937_of3)&ifetch);
   assign  _net_1099 = (_dp_opc[3]);
   assign  _net_1100 = (_net_1098&_net_1099);
   assign  _net_1101 = (_net_1098&_net_1099);
   assign  _net_1102 = (~(_dp_opc[3]));
   assign  _net_1103 = (_net_1098&_net_1102);
   assign  _net_1104 = (_net_1098&_net_1102);
   assign  _net_1105 = (ifruns==2'b10);
   assign  _net_1106 = (_net_1098&_net_1105);
   assign  _net_1107 = (ifruns==2'b01);
   assign  _net_1108 = (_net_1098&_net_1107);
   assign  _net_1109 = (_net_1098&error_sig);
   assign  _net_1110 = (_net_1098&error_sig);
   assign  _net_1111 = (_net_1098&error_sig);
   assign  _net_1112 = (_net_1098&error_sig);
   assign  _net_1113 = (_net_1098&error_sig);
   assign  _net_1114 = (_net_1098&fault);
   assign  _net_1115 = (_net_1098&fault);
   assign  _net_1116 = (_net_1098&fault);
   assign  _net_1117 = (_net_1098&fault);
   assign  _net_1118 = (_net_1098&fault);
   assign  _net_1119 = (ifruns==2'b10);
   assign  _net_1120 = (_net_1098&rdy);
   assign  _net_1121 = ((_net_1098&rdy)&_net_1119);
   assign  _net_1122 = ((_net_1098&rdy)&_net_1119);
   assign  _net_1123 = (ifruns==2'b01);
   assign  _net_1124 = (_net_1098&rdy);
   assign  _net_1125 = ((_net_1098&rdy)&_net_1123);
   assign  _net_1126 = ((_net_1098&rdy)&_net_1123);
   assign  _net_1127 = ((ifruns==2'b01)&(~(_dp_opc[3])));
   assign  _net_1128 = (_net_1098&rdy);
   assign  _net_1129 = ((_net_1098&rdy)&_net_1127);
   assign  _net_1130 = ((_net_1098&rdy)&_net_1127);
   assign  _net_1131 = ((_net_1098&rdy)&_net_1127);
   assign  _net_1132 = ((_net_1098&rdy)&_net_1127);
   assign  _net_1133 = ((_net_1098&rdy)&_net_1127);
   assign  _net_1134 = ((ifruns==2'b10)&(~(_dp_opc[3])));
   assign  _net_1135 = (_net_1098&rdy);
   assign  _net_1136 = ((_net_1098&rdy)&_net_1134);
   assign  _net_1137 = ((_net_1098&rdy)&_net_1134);
   assign  _net_1138 = ((_net_1098&rdy)&_net_1134);
   assign  _net_1139 = ((_net_1098&rdy)&_net_1134);
   assign  _net_1140 = (_dp_opc[3]);
   assign  _net_1141 = (_net_1098&rdy);
   assign  _net_1142 = ((_net_1098&rdy)&_net_1140);
   assign  _net_1143 = ((_reg_937==_state__reg_937_of4)&ifetch);
   assign  _net_1144 = (ifruns==2'b01);
   assign  _net_1145 = (_net_1143&_net_1144);
   assign  _net_1146 = (_net_1143&_net_1144);
   assign  _net_1147 = (_net_1143&_net_1144);
   assign  _net_1148 = ((_net_1143&_net_1144)&error_sig);
   assign  _net_1149 = ((_net_1143&_net_1144)&error_sig);
   assign  _net_1150 = ((_net_1143&_net_1144)&error_sig);
   assign  _net_1151 = ((_net_1143&_net_1144)&error_sig);
   assign  _net_1152 = ((_net_1143&_net_1144)&error_sig);
   assign  _net_1153 = ((_net_1143&_net_1144)&fault);
   assign  _net_1154 = ((_net_1143&_net_1144)&fault);
   assign  _net_1155 = ((_net_1143&_net_1144)&fault);
   assign  _net_1156 = ((_net_1143&_net_1144)&fault);
   assign  _net_1157 = ((_net_1143&_net_1144)&fault);
   assign  _net_1158 = ((_net_1143&_net_1144)&rdy);
   assign  _net_1159 = ((_net_1143&_net_1144)&rdy);
   assign  _net_1160 = ((_net_1143&_net_1144)&rdy);
   assign  _net_1161 = ((_net_1143&_net_1144)&rdy);
   assign  _net_1162 = ((_net_1143&_net_1144)&rdy);
   assign  _net_1163 = ((_net_1143&_net_1144)&rdy);
   assign  _net_1164 = ((_net_1143&_net_1144)&rdy);
   assign  _net_1165 = (ifruns==2'b10);
   assign  _net_1166 = (_net_1143&_net_1165);
   assign  _net_1167 = (_net_1143&_net_1165);
   assign  _net_1168 = (_net_1143&_net_1165);
   assign  _net_1169 = ((_net_1143&_net_1165)&error_sig);
   assign  _net_1170 = ((_net_1143&_net_1165)&error_sig);
   assign  _net_1171 = ((_net_1143&_net_1165)&error_sig);
   assign  _net_1172 = ((_net_1143&_net_1165)&error_sig);
   assign  _net_1173 = ((_net_1143&_net_1165)&error_sig);
   assign  _net_1174 = ((_net_1143&_net_1165)&fault);
   assign  _net_1175 = ((_net_1143&_net_1165)&fault);
   assign  _net_1176 = ((_net_1143&_net_1165)&fault);
   assign  _net_1177 = ((_net_1143&_net_1165)&fault);
   assign  _net_1178 = ((_net_1143&_net_1165)&fault);
   assign  _net_1179 = ((_net_1143&_net_1165)&rdy);
   assign  _net_1180 = ((_net_1143&_net_1165)&rdy);
   assign  _net_1181 = ((_net_1143&_net_1165)&rdy);
   assign  _net_1182 = ((_net_1143&_net_1165)&rdy);
   assign  _net_1183 = ((_net_1143&_net_1165)&rdy);
   assign  _net_1184 = ((_net_1143&_net_1165)&rdy);
   assign  _net_1185 = ((ifrun&(trapkind==3'b010))&_id_drtt);
   assign  _net_1186 = (ex&_net_1185);
   assign  _net_1187 = (ex&_net_1185);
   assign  _net_1188 = (ex&_net_1185);
   assign  _net_1189 = ((ifrun&(trapkind==3'b010))&(~_id_drtt));
   assign  _net_1190 = (ex&_net_1189);
   assign  _net_1191 = (ex&_net_1189);
   assign  _net_1192 = (ex&_net_1189);
   assign  _net_1193 = (ex&_net_1189);
   assign  _net_1194 = ((ifrun&(~(trapkind==3'b010)))&irq_in);
   assign  _net_1195 = (ex&_net_1194);
   assign  _net_1196 = (ex&_net_1194);
   assign  _net_1197 = (ex&_net_1194);
   assign  _net_1198 = ((ifrun&(~(trapkind==3'b010)))&(~irq_in));
   assign  _net_1199 = (ex&_net_1198);
   assign  _net_1200 = (ex&_net_1198);
   assign  _net_1201 = (ex&_net_1198);
   assign  _net_1202 = (ex&svcall);
   assign  _net_1203 = (ex&svcall);
   assign  _net_1204 = (ex&svcall);
   assign  _net_1205 = (ex&wback);
   assign  _net_1206 = (ex&wback);
   assign  _net_1207 = (ex&fault);
   assign  _net_1208 = (ex&fault);
   assign  _net_1209 = (ex&fault);
   assign  _net_1210 = (ex&fault);
   assign  _net_1211 = (ex&error_sig);
   assign  _net_1212 = (ex&error_sig);
   assign  _net_1213 = (ex&error_sig);
   assign  _net_1214 = (ex&error_sig);
   assign  _net_1215 = (~(error_sig|fault));
   assign  _net_1216 = ((ex&_net_1215)&s8);
   assign  _net_1217 = ((ex&_net_1215)&s8);
   assign  _net_1218 = ((ex&_net_1215)&s8);
   assign  _net_1219 = ((ex&_net_1215)&s7);
   assign  _net_1220 = ((ex&_net_1215)&s7);
   assign  _net_1221 = ((ex&_net_1215)&s7);
   assign  _net_1222 = ((ex&_net_1215)&s6);
   assign  _net_1223 = ((ex&_net_1215)&s6);
   assign  _net_1224 = ((ex&_net_1215)&s6);
   assign  _net_1225 = ((ex&_net_1215)&s5);
   assign  _net_1226 = ((ex&_net_1215)&s5);
   assign  _net_1227 = ((ex&_net_1215)&s5);
   assign  _net_1228 = ((ex&_net_1215)&s4);
   assign  _net_1229 = ((ex&_net_1215)&s4);
   assign  _net_1230 = ((ex&_net_1215)&s4);
   assign  _net_1231 = ((ex&_net_1215)&s3);
   assign  _net_1232 = ((ex&_net_1215)&s3);
   assign  _net_1233 = ((ex&_net_1215)&s3);
   assign  _net_1234 = ((ex&_net_1215)&s2);
   assign  _net_1235 = ((ex&_net_1215)&s2);
   assign  _net_1236 = ((ex&_net_1215)&s2);
   assign  _net_1237 = ((ex&_net_1215)&s1);
   assign  _net_1238 = ((ex&_net_1215)&s1);
   assign  _net_1239 = ((ex&_net_1215)&s1);
   assign  _net_1240 = ((ex&_net_1215)&s0);
   assign  _net_1241 = ((ex&_net_1215)&s0);
   assign  _net_1242 = ((ex&_net_1215)&s0);
   assign  _net_1244 = ((_reg_1243==_state__reg_1243_wb_s0)&wb);
   assign  _net_1245 = (|(_dp_opc[5:3]));
   assign  _net_1246 = (_net_1244&_net_1245);
   assign  _net_1247 = (_net_1244&_net_1245);
   assign  _net_1248 = (_net_1244&_net_1245);
   assign  _net_1249 = (_net_1244&_net_1245);
   assign  _net_1250 = ((rdy&(~(trapkind==3'b010)))&(~irq_in));
   assign  _net_1251 = (_net_1244&_net_1245);
   assign  _net_1252 = ((_net_1244&_net_1245)&_net_1250);
   assign  _net_1253 = ((_net_1244&_net_1245)&_net_1250);
   assign  _net_1254 = ((_net_1244&_net_1245)&_net_1250);
   assign  _net_1255 = ((rdy&(~(trapkind==3'b010)))&irq_in);
   assign  _net_1256 = (_net_1244&_net_1245);
   assign  _net_1257 = ((_net_1244&_net_1245)&_net_1255);
   assign  _net_1258 = ((_net_1244&_net_1245)&_net_1255);
   assign  _net_1259 = ((_net_1244&_net_1245)&_net_1255);
   assign  _net_1260 = (rdy&(trapkind==3'b010));
   assign  _net_1261 = (_net_1244&_net_1245);
   assign  _net_1262 = ((_net_1244&_net_1245)&_net_1260);
   assign  _net_1263 = ((_net_1244&_net_1245)&_net_1260);
   assign  _net_1264 = ((_net_1244&_net_1245)&_net_1260);
   assign  _net_1265 = ((_net_1244&_net_1245)&_net_1260);
   assign  _net_1266 = ((_net_1244&_net_1245)&error_sig);
   assign  _net_1267 = ((_net_1244&_net_1245)&error_sig);
   assign  _net_1268 = ((_net_1244&_net_1245)&error_sig);
   assign  _net_1269 = ((_net_1244&_net_1245)&error_sig);
   assign  _net_1270 = ((_net_1244&_net_1245)&fault);
   assign  _net_1271 = ((_net_1244&_net_1245)&fault);
   assign  _net_1272 = ((_net_1244&_net_1245)&fault);
   assign  _net_1273 = ((_net_1244&_net_1245)&fault);
   assign  _net_1274 = (~(|(_dp_opc[5:3])));
   assign  _net_1275 = (_net_1244&_net_1274);
   assign  _net_1276 = (_net_1244&_net_1274);
   assign  _net_1277 = ((~(trapkind==3'b010))&(~irq_in));
   assign  _net_1278 = (_net_1244&_net_1274);
   assign  _net_1279 = ((_net_1244&_net_1274)&_net_1277);
   assign  _net_1280 = ((_net_1244&_net_1274)&_net_1277);
   assign  _net_1281 = ((_net_1244&_net_1274)&_net_1277);
   assign  _net_1282 = ((~(trapkind==3'b010))&irq_in);
   assign  _net_1283 = (_net_1244&_net_1274);
   assign  _net_1284 = ((_net_1244&_net_1274)&_net_1282);
   assign  _net_1285 = ((_net_1244&_net_1274)&_net_1282);
   assign  _net_1286 = ((_net_1244&_net_1274)&_net_1282);
   assign  _net_1287 = (trapkind==3'b010);
   assign  _net_1288 = (_net_1244&_net_1274);
   assign  _net_1289 = ((_net_1244&_net_1274)&_net_1287);
   assign  _net_1290 = ((_net_1244&_net_1274)&_net_1287);
   assign  _net_1291 = ((_net_1244&_net_1274)&_net_1287);
   assign  _net_1292 = ((_net_1244&_net_1274)&_net_1287);
   assign  _net_1294 = ((_reg_1293==_state__reg_1293_trap0)&trap);
   assign  _net_1295 = (trapkind==3'b000);
   assign  _net_1296 = (_net_1294&_net_1295);
   assign  _net_1297 = (_net_1294&_net_1295);
   assign  _net_1298 = (_net_1294&_net_1295);
   assign  _net_1299 = (trapkind==3'b001);
   assign  _net_1300 = ((_reg_1293==_state__reg_1293_trap1)&trap);
   assign  _net_1301 = (_net_1300&rdy);
   assign  _net_1302 = (_net_1300&rdy);
   assign  _net_1303 = (_net_1300&rdy);
   assign  _net_1304 = (_net_1300&rdy);
   assign  _net_1305 = (_net_1300&rdy);
   assign  _net_1306 = ((_reg_1293==_state__reg_1293_trap2)&trap);
   assign  _net_1307 = (_net_1306&rdy);
   assign  _net_1308 = (_net_1306&rdy);
   assign  _net_1309 = (_net_1306&rdy);
   assign  _net_1310 = (_net_1306&rdy);
   assign  _net_1311 = (_net_1306&rdy);
   assign  _net_1312 = ((_reg_1293==_state__reg_1293_trap3)&trap);
   assign  _net_1313 = (_net_1312&rdy);
   assign  _net_1314 = (_net_1312&rdy);
   assign  _net_1315 = (_net_1312&rdy);
   assign  _net_1316 = (_net_1312&rdy);
   assign  _net_1317 = ((_reg_1293==_state__reg_1293_trap4)&trap);
   assign  _net_1318 = (_net_1317&rdy);
   assign  _net_1319 = (_net_1317&rdy);
   assign  _net_1320 = (_net_1317&rdy);
   assign  _net_1321 = (_net_1317&rdy);
   assign  dato = _dp_dbo;
   assign  adrs = _dp_dba;
   assign  rd = read;
   assign  wt = write;
   assign  byte = byte_sel;
   assign  int_ack = _net_1296;
   assign  pswout = _dp_psw;
   assign  inst = _net_938;
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
if ((_net_974)|(_net_973)) 
      rsub <= ((_net_974) ?1'b1:1'b0)|
    ((_net_973) ?1'b0:1'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     tsk <= 4'b0000;
else if ((_net_1239)|(_net_1236)|(_net_1233)|(_net_1230)|(_net_1227)|(_net_1224)|(_net_1221)|(_net_1218)|((_net_1242|(_net_1184|(_net_1139|(_net_1087|_net_970)))))) 
      tsk <= ((_net_1239) ?4'b0001:4'b0)|
    ((_net_1236) ?4'b0010:4'b0)|
    ((_net_1233) ?4'b0011:4'b0)|
    ((_net_1230) ?4'b0100:4'b0)|
    ((_net_1227) ?4'b0101:4'b0)|
    ((_net_1224) ?4'b0110:4'b0)|
    ((_net_1221) ?4'b0111:4'b0)|
    ((_net_1218) ?4'b1000:4'b0)|
    (((_net_1242|(_net_1184|(_net_1139|(_net_1087|_net_970))))) ?4'b0000:4'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     ifruns <= 2'b00;
else if (((_net_1163|(_net_1132|(_net_1080|(_net_965|_net_961)))))|(_net_956)|((_net_1321|(_net_1281|(_net_1254|(_net_1201|(_net_1188|start))))))) 
      ifruns <= (((_net_1163|(_net_1132|(_net_1080|(_net_965|_net_961))))) ?2'b10:2'b0)|
    ((_net_956) ?2'b01:2'b0)|
    (((_net_1321|(_net_1281|(_net_1254|(_net_1201|(_net_1188|start)))))) ?2'b00:2'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     ifetch <= 1'b0;
else if ((_net_470)) 
      ifetch <= _proc_ifetch_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     ex <= 1'b0;
else if ((_net_471)) 
      ex <= _proc_ex_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     wb <= 1'b0;
else if ((_net_472)) 
      wb <= _proc_wb_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     trapkind <= 3'b000;
else if (((_net_1286|(_net_1259|(_net_1197|(_net_999|_net_985)))))|((_net_1292|(_net_1273|(_net_1269|(_net_1265|(_net_1214|(_net_1210|(_net_1204|(_net_1193|(_net_1178|(_net_1173|(_net_1157|(_net_1152|(_net_1118|(_net_1113|(_net_1020|(_net_1015|(_net_1004|(_net_990|(_net_980|(_net_946|_net_942)))))))))))))))))))))) 
      trapkind <= (((_net_1286|(_net_1259|(_net_1197|(_net_999|_net_985))))) ?3'b000:3'b0)|
    (((_net_1292|(_net_1273|(_net_1269|(_net_1265|(_net_1214|(_net_1210|(_net_1204|(_net_1193|(_net_1178|(_net_1173|(_net_1157|(_net_1152|(_net_1118|(_net_1113|(_net_1020|(_net_1015|(_net_1004|(_net_990|(_net_980|(_net_946|_net_942))))))))))))))))))))) ?3'b001:3'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     trap <= 1'b0;
else if ((_net_473)) 
      trap <= _proc_trap_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_937 <= _state__reg_937_if0;
else if (((_net_1142|_net_1090))|((_net_1091|(_net_1066|_net_1048)))|(_net_1030)|(_net_972)|(_net_971)|((_net_1181|(_net_1174|(_net_1169|(_net_1153|(_net_1148|(_net_1136|(_net_1114|(_net_1109|(_net_1084|(_net_1016|(_net_1011|(_net_991|(_net_981|(_net_976|_net_967)))))))))))))))|(_net_962)|((_net_1160|(_net_1129|(_net_1077|(_net_1005|(_net_958|_net_953))))))|(_net_951)) 
      _reg_937 <= (((_net_1142|_net_1090)) ?_state__reg_937_of4:4'b0)|
    (((_net_1091|(_net_1066|_net_1048))) ?_state__reg_937_of3:4'b0)|
    ((_net_1030) ?_state__reg_937_of2:4'b0)|
    ((_net_972) ?_state__reg_937_br0:4'b0)|
    ((_net_971) ?_state__reg_937_cc0:4'b0)|
    (((_net_1181|(_net_1174|(_net_1169|(_net_1153|(_net_1148|(_net_1136|(_net_1114|(_net_1109|(_net_1084|(_net_1016|(_net_1011|(_net_991|(_net_981|(_net_976|_net_967))))))))))))))) ?_state__reg_937_if0:4'b0)|
    ((_net_962) ?_state__reg_937_of0:4'b0)|
    (((_net_1160|(_net_1129|(_net_1077|(_net_1005|(_net_958|_net_953)))))) ?_state__reg_937_of1:4'b0)|
    ((_net_951) ?_state__reg_937_id0:4'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_1243 <= _state__reg_1243_wb_s0;
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_1293 <= _state__reg_1293_trap0;
else if ((_net_1318)|(_net_1316)|(_net_1311)|(_net_1305)|(_net_1294)) 
      _reg_1293 <= ((_net_1318) ?_state__reg_1293_trap0:3'b0)|
    ((_net_1316) ?_state__reg_1293_trap4:3'b0)|
    ((_net_1311) ?_state__reg_1293_trap3:3'b0)|
    ((_net_1305) ?_state__reg_1293_trap2:3'b0)|
    ((_net_1294) ?_state__reg_1293_trap1:3'b0);

end
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:52:37 2016
 Licensed to :EVALUATION USER
*/
