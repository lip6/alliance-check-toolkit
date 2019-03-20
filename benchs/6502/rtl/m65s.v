/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 01:56:01 2016
 Licensed to :EVALUATION USER
*/
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

   assign  tmp = 
// synthesis translate_off
// synopsys translate_off
((adj&_net_0))? 
// synthesis translate_on
// synopsys translate_on
(((adj&_net_0))?((in[3:0])+_net_1):4'b0)
// synthesis translate_off
// synopsys translate_off
:4'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_0 = 
// synthesis translate_off
// synopsys translate_off
(adj)? 
// synthesis translate_on
// synopsys translate_on
((adj)?(((sub^(in[4]))|((in[3])&(in[2])))|((in[3])&(in[1]))):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((((adj&_net_0)&(~sub))&((adj&_net_0)&sub)))
 begin $display("Warning: assign collision(decadj:_net_1) at %d",$time);
if (((adj&_net_0)&(~sub))) $display("assert (((adj&_net_0)&(~sub))) line 19 at %d\n",$time);
if (((adj&_net_0)&sub)) $display("assert (((adj&_net_0)&sub)) line 19 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  _net_1 = 
// synthesis translate_off
// synopsys translate_off
((((adj&_net_0)&(~sub))&((adj&_net_0)&sub)))? 4'bx :((((adj&_net_0)&(~sub))|((adj&_net_0)&sub)))? 
// synthesis translate_on
// synopsys translate_on
((((adj&_net_0)&(~sub)))?4'b0110:4'b0)|
    ((((adj&_net_0)&sub))?4'b1010:4'b0)
// synthesis translate_off
// synopsys translate_off
:4'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if (((adj&(~_net_0))&(adj&_net_0)))
 begin $display("Warning: assign collision(decadj:out) at %d",$time);
if ((adj&(~_net_0))) $display("assert ((adj&(~_net_0))) line 23 at %d\n",$time);
if ((adj&_net_0)) $display("assert ((adj&_net_0)) line 20 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  out = 
// synthesis translate_off
// synopsys translate_off
(((adj&(~_net_0))&(adj&_net_0)))? 5'bx :(((adj&(~_net_0))|(adj&_net_0)))? 
// synthesis translate_on
// synopsys translate_on
(((adj&(~_net_0)))?in:5'b0)|
    (((adj&_net_0))?({(~sub),tmp}):5'b0)
// synthesis translate_off
// synopsys translate_off
:5'bx
// synthesis translate_on
// synopsys translate_on
;
endmodule
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 01:56:01 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 01:56:01 2016
 Licensed to :EVALUATION USER
*/
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
  wire [3:0] _net_2;
  wire [3:0] _net_3;
  wire _net_4;
  wire [3:0] _net_5;
  wire [3:0] _net_6;
  wire _net_7;
  wire [3:0] _net_8;
  wire [3:0] _net_9;
  wire _net_10;
  wire [3:0] _net_11;
  wire [3:0] _net_12;
  wire _net_13;
decadj lo (.m_clock(m_clock), .p_reset(p_reset), .adj(_lo_adj), .out(_lo_out), .in(_lo_in), .sub(_lo_sub));
decadj hi (.m_clock(m_clock), .p_reset(p_reset), .adj(_hi_adj), .out(_hi_out), .in(_hi_in), .sub(_hi_sub));


// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((sub&add))
 begin $display("Warning: assign collision(cpa8:h1) at %d",$time);
if (sub) $display("assert (sub) line 48 at %d\n",$time);
if (add) $display("assert (add) line 34 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  h1 = 
// synthesis translate_off
// synopsys translate_off
((sub&add))? 5'bx :((sub|add))? 
// synthesis translate_on
// synopsys translate_on
((sub)?((({1'b0,_net_11})+({1'b0,_net_12}))+({4'b0000,_net_13})):5'b0)|
    ((add)?((({1'b0,_net_5})+({1'b0,_net_6}))+({4'b0000,_net_7})):5'b0)
// synthesis translate_off
// synopsys translate_off
:5'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((sub&add))
 begin $display("Warning: assign collision(cpa8:l1) at %d",$time);
if (sub) $display("assert (sub) line 47 at %d\n",$time);
if (add) $display("assert (add) line 33 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  l1 = 
// synthesis translate_off
// synopsys translate_off
((sub&add))? 5'bx :((sub|add))? 
// synthesis translate_on
// synopsys translate_on
((sub)?((({1'b0,_net_8})+({1'b0,_net_9}))+({4'b0000,_net_10})):5'b0)|
    ((add)?((({1'b0,_net_2})+({1'b0,_net_3}))+({4'b0000,_net_4})):5'b0)
// synthesis translate_off
// synopsys translate_off
:5'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if (((((sub&(~df))&(sub&df))|(((sub&(~df))|(sub&df))&(add&(~df))))|((((sub&(~df))|(sub&df))|(add&(~df)))&(add&df))))
 begin $display("Warning: assign collision(cpa8:ct) at %d",$time);
if ((sub&(~df))) $display("assert ((sub&(~df))) line 56 at %d\n",$time);
if ((sub&df)) $display("assert ((sub&df)) line 51 at %d\n",$time);
if ((add&(~df))) $display("assert ((add&(~df))) line 42 at %d\n",$time);
if ((add&df)) $display("assert ((add&df)) line 37 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  ct = 
// synthesis translate_off
// synopsys translate_off
(((((sub&(~df))&(sub&df))|(((sub&(~df))|(sub&df))&(add&(~df))))|((((sub&(~df))|(sub&df))|(add&(~df)))&(add&df))))? 1'bx :(((((sub&(~df))|(sub&df))|(add&(~df)))|(add&df)))? 
// synthesis translate_on
// synopsys translate_on
(((sub&(~df)))?(l1[4]):1'b0)|
    (((sub&df))?(_lo_out[4]):1'b0)|
    (((add&(~df)))?(l1[4]):1'b0)|
    (((add&df))?(_lo_out[4]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if (((sub&df)&(add&df)))
 begin $display("Warning: assign collision(cpa8:_lo_in) at %d",$time);
if ((sub&df)) $display("assert ((sub&df)) line 50 at %d\n",$time);
if ((add&df)) $display("assert ((add&df)) line 36 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  _lo_in = 
// synthesis translate_off
// synopsys translate_off
(((sub&df)&(add&df)))? 5'bx :(((sub&df)|(add&df)))? 
// synthesis translate_on
// synopsys translate_on
(((sub&df))?l1:5'b0)|
    (((add&df))?l1:5'b0)
// synthesis translate_off
// synopsys translate_off
:5'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if (((sub&df)&(add&df)))
 begin $display("Warning: assign collision(cpa8:_lo_sub) at %d",$time);
if ((sub&df)) $display("assert ((sub&df)) line 50 at %d\n",$time);
if ((add&df)) $display("assert ((add&df)) line 36 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  _lo_sub = 
// synthesis translate_off
// synopsys translate_off
(((sub&df)&(add&df)))? 1'bx :(((sub&df)|(add&df)))? 
// synthesis translate_on
// synopsys translate_on
(sub&df)|
    (((add&df))?1'b0:1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge _lo_adj)
  begin
#1 if (_lo_adj===1'bx)
 begin
$display("Warning: control hazard(cpa8:_lo_adj) at %d",$time);
 end
#1 if ((((sub&df))===1'bx) || (1'b1)===1'bx) $display("hazard ((sub&df) || 1'b1) line 50 at %d\n",$time);
#1 if ((((add&df))===1'bx) || (1'b1)===1'bx) $display("hazard ((add&df) || 1'b1) line 36 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _lo_adj = (sub&df)|
    (add&df);
   assign  _lo_p_reset = p_reset;
   assign  _lo_m_clock = m_clock;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if (((sub&df)&(add&df)))
 begin $display("Warning: assign collision(cpa8:_hi_in) at %d",$time);
if ((sub&df)) $display("assert ((sub&df)) line 50 at %d\n",$time);
if ((add&df)) $display("assert ((add&df)) line 36 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  _hi_in = 
// synthesis translate_off
// synopsys translate_off
(((sub&df)&(add&df)))? 5'bx :(((sub&df)|(add&df)))? 
// synthesis translate_on
// synopsys translate_on
(((sub&df))?h1:5'b0)|
    (((add&df))?h1:5'b0)
// synthesis translate_off
// synopsys translate_off
:5'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if (((sub&df)&(add&df)))
 begin $display("Warning: assign collision(cpa8:_hi_sub) at %d",$time);
if ((sub&df)) $display("assert ((sub&df)) line 50 at %d\n",$time);
if ((add&df)) $display("assert ((add&df)) line 36 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  _hi_sub = 
// synthesis translate_off
// synopsys translate_off
(((sub&df)&(add&df)))? 1'bx :(((sub&df)|(add&df)))? 
// synthesis translate_on
// synopsys translate_on
(sub&df)|
    (((add&df))?1'b0:1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge _hi_adj)
  begin
#1 if (_hi_adj===1'bx)
 begin
$display("Warning: control hazard(cpa8:_hi_adj) at %d",$time);
 end
#1 if ((((sub&df))===1'bx) || (1'b1)===1'bx) $display("hazard ((sub&df) || 1'b1) line 50 at %d\n",$time);
#1 if ((((add&df))===1'bx) || (1'b1)===1'bx) $display("hazard ((add&df) || 1'b1) line 36 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _hi_adj = (sub&df)|
    (add&df);
   assign  _hi_p_reset = p_reset;
   assign  _hi_m_clock = m_clock;
   assign  _net_2 = (in1[3:0]);
   assign  _net_3 = (in2[3:0]);
   assign  _net_4 = ci;
   assign  _net_5 = (in1[7:4]);
   assign  _net_6 = (in2[7:4]);
   assign  _net_7 = ct;
   assign  _net_8 = (in1[3:0]);
   assign  _net_9 = (~(in2[3:0]));
   assign  _net_10 = ci;
   assign  _net_11 = (in1[7:4]);
   assign  _net_12 = (~(in2[7:4]));
   assign  _net_13 = ct;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if (((((sub&(~df))&(sub&df))|(((sub&(~df))|(sub&df))&(add&(~df))))|((((sub&(~df))|(sub&df))|(add&(~df)))&(add&df))))
 begin $display("Warning: assign collision(cpa8:out) at %d",$time);
if ((sub&(~df))) $display("assert ((sub&(~df))) line 55 at %d\n",$time);
if ((sub&df)) $display("assert ((sub&df)) line 50 at %d\n",$time);
if ((add&(~df))) $display("assert ((add&(~df))) line 41 at %d\n",$time);
if ((add&df)) $display("assert ((add&df)) line 36 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  out = 
// synthesis translate_off
// synopsys translate_off
(((((sub&(~df))&(sub&df))|(((sub&(~df))|(sub&df))&(add&(~df))))|((((sub&(~df))|(sub&df))|(add&(~df)))&(add&df))))? 8'bx :(((((sub&(~df))|(sub&df))|(add&(~df)))|(add&df)))? 
// synthesis translate_on
// synopsys translate_on
(((sub&(~df)))?({(h1[3:0]),(l1[3:0])}):8'b0)|
    (((sub&df))?({(_hi_out[3:0]),(_lo_out[3:0])}):8'b0)|
    (((add&(~df)))?({(h1[3:0]),(l1[3:0])}):8'b0)|
    (((add&df))?({(_hi_out[3:0]),(_lo_out[3:0])}):8'b0)
// synthesis translate_off
// synopsys translate_off
:8'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if (((((sub&(~df))&(sub&df))|(((sub&(~df))|(sub&df))&(add&(~df))))|((((sub&(~df))|(sub&df))|(add&(~df)))&(add&df))))
 begin $display("Warning: assign collision(cpa8:co) at %d",$time);
if ((sub&(~df))) $display("assert ((sub&(~df))) line 57 at %d\n",$time);
if ((sub&df)) $display("assert ((sub&df)) line 52 at %d\n",$time);
if ((add&(~df))) $display("assert ((add&(~df))) line 43 at %d\n",$time);
if ((add&df)) $display("assert ((add&df)) line 38 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  co = 
// synthesis translate_off
// synopsys translate_off
(((((sub&(~df))&(sub&df))|(((sub&(~df))|(sub&df))&(add&(~df))))|((((sub&(~df))|(sub&df))|(add&(~df)))&(add&df))))? 1'bx :(((((sub&(~df))|(sub&df))|(add&(~df)))|(add&df)))? 
// synthesis translate_on
// synopsys translate_on
(((sub&(~df)))?(h1[4]):1'b0)|
    (((sub&df))?(_hi_out[4]):1'b0)|
    (((add&(~df)))?(h1[4]):1'b0)|
    (((add&df))?(_hi_out[4]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
endmodule
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 01:56:01 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 01:56:01 2016
 Licensed to :EVALUATION USER
*/
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
cpa8 adder (.m_clock(m_clock), .p_reset(p_reset), .sub(_adder_sub), .add(_adder_add), .out(_adder_out), .co(_adder_co), .in1(_adder_in1), .in2(_adder_in2), .ci(_adder_ci), .df(_adder_df));


// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if (((((((((((((((dec2&thr)|((dec2|thr)&ror))|(((dec2|thr)|ror)&rol))|((((dec2|thr)|ror)|rol)&lsr))|(((((dec2|thr)|ror)|rol)|lsr)&asl))|((((((dec2|thr)|ror)|rol)|lsr)|asl)&incc))|(((((((dec2|thr)|ror)|rol)|lsr)|asl)|incc)&dec))|((((((((dec2|thr)|ror)|rol)|lsr)|asl)|incc)|dec)&inc))|(((((((((dec2|thr)|ror)|rol)|lsr)|asl)|incc)|dec)|inc)&do_or))|((((((((((dec2|thr)|ror)|rol)|lsr)|asl)|incc)|dec)|inc)|do_or)&eor))|(((((((((((dec2|thr)|ror)|rol)|lsr)|asl)|incc)|dec)|inc)|do_or)|eor)&bita))|((((((((((((dec2|thr)|ror)|rol)|lsr)|asl)|incc)|dec)|inc)|do_or)|eor)|bita)&do_and))|(((((((((((((dec2|thr)|ror)|rol)|lsr)|asl)|incc)|dec)|inc)|do_or)|eor)|bita)|do_and)&sbc))|((((((((((((((dec2|thr)|ror)|rol)|lsr)|asl)|incc)|dec)|inc)|do_or)|eor)|bita)|do_and)|sbc)&adc)))
 begin $display("Warning: assign collision(alu65:out_in) at %d",$time);
if (dec2) $display("assert (dec2) line 109 at %d\n",$time);
if (thr) $display("assert (thr) line 105 at %d\n",$time);
if (ror) $display("assert (ror) line 100 at %d\n",$time);
if (rol) $display("assert (rol) line 95 at %d\n",$time);
if (lsr) $display("assert (lsr) line 90 at %d\n",$time);
if (asl) $display("assert (asl) line 85 at %d\n",$time);
if (incc) $display("assert (incc) line 80 at %d\n",$time);
if (dec) $display("assert (dec) line 75 at %d\n",$time);
if (inc) $display("assert (inc) line 70 at %d\n",$time);
if (do_or) $display("assert (do_or) line 66 at %d\n",$time);
if (eor) $display("assert (eor) line 62 at %d\n",$time);
if (bita) $display("assert (bita) line 55 at %d\n",$time);
if (do_and) $display("assert (do_and) line 51 at %d\n",$time);
if (sbc) $display("assert (sbc) line 45 at %d\n",$time);
if (adc) $display("assert (adc) line 39 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  out_in = 
// synthesis translate_off
// synopsys translate_off
(((((((((((((((dec2&thr)|((dec2|thr)&ror))|(((dec2|thr)|ror)&rol))|((((dec2|thr)|ror)|rol)&lsr))|(((((dec2|thr)|ror)|rol)|lsr)&asl))|((((((dec2|thr)|ror)|rol)|lsr)|asl)&incc))|(((((((dec2|thr)|ror)|rol)|lsr)|asl)|incc)&dec))|((((((((dec2|thr)|ror)|rol)|lsr)|asl)|incc)|dec)&inc))|(((((((((dec2|thr)|ror)|rol)|lsr)|asl)|incc)|dec)|inc)&do_or))|((((((((((dec2|thr)|ror)|rol)|lsr)|asl)|incc)|dec)|inc)|do_or)&eor))|(((((((((((dec2|thr)|ror)|rol)|lsr)|asl)|incc)|dec)|inc)|do_or)|eor)&bita))|((((((((((((dec2|thr)|ror)|rol)|lsr)|asl)|incc)|dec)|inc)|do_or)|eor)|bita)&do_and))|(((((((((((((dec2|thr)|ror)|rol)|lsr)|asl)|incc)|dec)|inc)|do_or)|eor)|bita)|do_and)&sbc))|((((((((((((((dec2|thr)|ror)|rol)|lsr)|asl)|incc)|dec)|inc)|do_or)|eor)|bita)|do_and)|sbc)&adc)))? 8'bx :(((((((((((((((dec2|thr)|ror)|rol)|lsr)|asl)|incc)|dec)|inc)|do_or)|eor)|bita)|do_and)|sbc)|adc))? 
// synthesis translate_on
// synopsys translate_on
((dec2)?_adder_out:8'b0)|
    ((thr)?in1:8'b0)|
    ((ror)?({ci,(in1[7:1])}):8'b0)|
    ((rol)?({(in1[6:0]),ci}):8'b0)|
    ((lsr)?({1'b0,(in1[7:1])}):8'b0)|
    ((asl)?({(in1[6:0]),1'b0}):8'b0)|
    ((incc)?_adder_out:8'b0)|
    ((dec)?_adder_out:8'b0)|
    ((inc)?_adder_out:8'b0)|
    ((do_or)?(in1|in2):8'b0)|
    ((eor)?(in1^in2):8'b0)|
    ((bita)?(in1&in2):8'b0)|
    ((do_and)?(in1&in2):8'b0)|
    ((sbc)?_adder_out:8'b0)|
    ((adc)?_adder_out:8'b0)
// synthesis translate_off
// synopsys translate_off
:8'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge set_out)
  begin
#1 if (set_out===1'bx)
 begin
$display("Warning: control hazard(alu65:set_out) at %d",$time);
 end
#1 if (((dec2)===1'bx) || (1'b1)===1'bx) $display("hazard (dec2 || 1'b1) line 110 at %d\n",$time);
#1 if (((thr)===1'bx) || (1'b1)===1'bx) $display("hazard (thr || 1'b1) line 106 at %d\n",$time);
#1 if (((ror)===1'bx) || (1'b1)===1'bx) $display("hazard (ror || 1'b1) line 102 at %d\n",$time);
#1 if (((rol)===1'bx) || (1'b1)===1'bx) $display("hazard (rol || 1'b1) line 97 at %d\n",$time);
#1 if (((lsr)===1'bx) || (1'b1)===1'bx) $display("hazard (lsr || 1'b1) line 92 at %d\n",$time);
#1 if (((asl)===1'bx) || (1'b1)===1'bx) $display("hazard (asl || 1'b1) line 87 at %d\n",$time);
#1 if (((incc)===1'bx) || (1'b1)===1'bx) $display("hazard (incc || 1'b1) line 82 at %d\n",$time);
#1 if (((dec)===1'bx) || (1'b1)===1'bx) $display("hazard (dec || 1'b1) line 77 at %d\n",$time);
#1 if (((inc)===1'bx) || (1'b1)===1'bx) $display("hazard (inc || 1'b1) line 72 at %d\n",$time);
#1 if (((do_or)===1'bx) || (1'b1)===1'bx) $display("hazard (do_or || 1'b1) line 67 at %d\n",$time);
#1 if (((eor)===1'bx) || (1'b1)===1'bx) $display("hazard (eor || 1'b1) line 63 at %d\n",$time);
#1 if (((do_and)===1'bx) || (1'b1)===1'bx) $display("hazard (do_and || 1'b1) line 52 at %d\n",$time);
#1 if (((sbc)===1'bx) || (1'b1)===1'bx) $display("hazard (sbc || 1'b1) line 48 at %d\n",$time);
#1 if (((adc)===1'bx) || (1'b1)===1'bx) $display("hazard (adc || 1'b1) line 42 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  set_out = dec2|
    thr|
    ror|
    rol|
    lsr|
    asl|
    incc|
    dec|
    inc|
    do_or|
    eor|
    do_and|
    sbc|
    adc;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((((((dec2&incc)|((dec2|incc)&dec))|(((dec2|incc)|dec)&inc))|((((dec2|incc)|dec)|inc)&sbc))|(((((dec2|incc)|dec)|inc)|sbc)&adc)))
 begin $display("Warning: assign collision(alu65:_adder_in1) at %d",$time);
if (dec2) $display("assert (dec2) line 109 at %d\n",$time);
if (incc) $display("assert (incc) line 80 at %d\n",$time);
if (dec) $display("assert (dec) line 75 at %d\n",$time);
if (inc) $display("assert (inc) line 70 at %d\n",$time);
if (sbc) $display("assert (sbc) line 45 at %d\n",$time);
if (adc) $display("assert (adc) line 39 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  _adder_in1 = 
// synthesis translate_off
// synopsys translate_off
((((((dec2&incc)|((dec2|incc)&dec))|(((dec2|incc)|dec)&inc))|((((dec2|incc)|dec)|inc)&sbc))|(((((dec2|incc)|dec)|inc)|sbc)&adc)))? 8'bx :((((((dec2|incc)|dec)|inc)|sbc)|adc))? 
// synthesis translate_on
// synopsys translate_on
((dec2)?8'b11111111:8'b0)|
    ((incc)?in1:8'b0)|
    ((dec)?in1:8'b0)|
    ((inc)?in1:8'b0)|
    ((sbc)?in1:8'b0)|
    ((adc)?in1:8'b0)
// synthesis translate_off
// synopsys translate_off
:8'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((((((dec2&incc)|((dec2|incc)&dec))|(((dec2|incc)|dec)&inc))|((((dec2|incc)|dec)|inc)&sbc))|(((((dec2|incc)|dec)|inc)|sbc)&adc)))
 begin $display("Warning: assign collision(alu65:_adder_in2) at %d",$time);
if (dec2) $display("assert (dec2) line 109 at %d\n",$time);
if (incc) $display("assert (incc) line 80 at %d\n",$time);
if (dec) $display("assert (dec) line 75 at %d\n",$time);
if (inc) $display("assert (inc) line 70 at %d\n",$time);
if (sbc) $display("assert (sbc) line 45 at %d\n",$time);
if (adc) $display("assert (adc) line 39 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  _adder_in2 = 
// synthesis translate_off
// synopsys translate_off
((((((dec2&incc)|((dec2|incc)&dec))|(((dec2|incc)|dec)&inc))|((((dec2|incc)|dec)|inc)&sbc))|(((((dec2|incc)|dec)|inc)|sbc)&adc)))? 8'bx :((((((dec2|incc)|dec)|inc)|sbc)|adc))? 
// synthesis translate_on
// synopsys translate_on
((dec2)?in2:8'b0)|
    ((incc)?8'b00000000:8'b0)|
    ((dec)?8'b00000000:8'b0)|
    ((inc)?8'b00000000:8'b0)|
    ((sbc)?in2:8'b0)|
    ((adc)?in2:8'b0)
// synthesis translate_off
// synopsys translate_off
:8'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((((((dec2&incc)|((dec2|incc)&dec))|(((dec2|incc)|dec)&inc))|((((dec2|incc)|dec)|inc)&sbc))|(((((dec2|incc)|dec)|inc)|sbc)&adc)))
 begin $display("Warning: assign collision(alu65:_adder_ci) at %d",$time);
if (dec2) $display("assert (dec2) line 109 at %d\n",$time);
if (incc) $display("assert (incc) line 80 at %d\n",$time);
if (dec) $display("assert (dec) line 75 at %d\n",$time);
if (inc) $display("assert (inc) line 70 at %d\n",$time);
if (sbc) $display("assert (sbc) line 45 at %d\n",$time);
if (adc) $display("assert (adc) line 39 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  _adder_ci = 
// synthesis translate_off
// synopsys translate_off
((((((dec2&incc)|((dec2|incc)&dec))|(((dec2|incc)|dec)&inc))|((((dec2|incc)|dec)|inc)&sbc))|(((((dec2|incc)|dec)|inc)|sbc)&adc)))? 1'bx :((((((dec2|incc)|dec)|inc)|sbc)|adc))? 
// synthesis translate_on
// synopsys translate_on
((dec2)?1'b0:1'b0)|
    ((incc)?ci:1'b0)|
    ((dec)?1'b0:1'b0)|
    ((inc)?1'b1:1'b0)|
    ((sbc)?ci:1'b0)|
    ((adc)?ci:1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((((((dec2&incc)|((dec2|incc)&dec))|(((dec2|incc)|dec)&inc))|((((dec2|incc)|dec)|inc)&sbc))|(((((dec2|incc)|dec)|inc)|sbc)&adc)))
 begin $display("Warning: assign collision(alu65:_adder_df) at %d",$time);
if (dec2) $display("assert (dec2) line 109 at %d\n",$time);
if (incc) $display("assert (incc) line 80 at %d\n",$time);
if (dec) $display("assert (dec) line 75 at %d\n",$time);
if (inc) $display("assert (inc) line 70 at %d\n",$time);
if (sbc) $display("assert (sbc) line 45 at %d\n",$time);
if (adc) $display("assert (adc) line 39 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  _adder_df = 
// synthesis translate_off
// synopsys translate_off
((((((dec2&incc)|((dec2|incc)&dec))|(((dec2|incc)|dec)&inc))|((((dec2|incc)|dec)|inc)&sbc))|(((((dec2|incc)|dec)|inc)|sbc)&adc)))? 1'bx :((((((dec2|incc)|dec)|inc)|sbc)|adc))? 
// synthesis translate_on
// synopsys translate_on
((dec2)?1'b0:1'b0)|
    ((incc)?1'b0:1'b0)|
    ((dec)?1'b0:1'b0)|
    ((inc)?1'b0:1'b0)|
    ((sbc)?df:1'b0)|
    ((adc)?df:1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge _adder_add)
  begin
#1 if (_adder_add===1'bx)
 begin
$display("Warning: control hazard(alu65:_adder_add) at %d",$time);
 end
#1 if (((dec2)===1'bx) || (1'b1)===1'bx) $display("hazard (dec2 || 1'b1) line 109 at %d\n",$time);
#1 if (((incc)===1'bx) || (1'b1)===1'bx) $display("hazard (incc || 1'b1) line 80 at %d\n",$time);
#1 if (((inc)===1'bx) || (1'b1)===1'bx) $display("hazard (inc || 1'b1) line 70 at %d\n",$time);
#1 if (((adc)===1'bx) || (1'b1)===1'bx) $display("hazard (adc || 1'b1) line 39 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _adder_add = dec2|
    incc|
    inc|
    adc;

// synthesis translate_off
// synopsys translate_off
always @(posedge _adder_sub)
  begin
#1 if (_adder_sub===1'bx)
 begin
$display("Warning: control hazard(alu65:_adder_sub) at %d",$time);
 end
#1 if (((dec)===1'bx) || (1'b1)===1'bx) $display("hazard (dec || 1'b1) line 75 at %d\n",$time);
#1 if (((sbc)===1'bx) || (1'b1)===1'bx) $display("hazard (sbc || 1'b1) line 45 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _adder_sub = dec|
    sbc;
   assign  _adder_p_reset = p_reset;
   assign  _adder_m_clock = m_clock;
   assign  _net_14 = 
// synthesis translate_off
// synopsys translate_off
(set_out)? 
// synthesis translate_on
// synopsys translate_on
((set_out)?(out_in[7]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_15 = 
// synthesis translate_off
// synopsys translate_off
(set_out)? 
// synthesis translate_on
// synopsys translate_on
((set_out)?(~(|out_in)):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_16 = 
// synthesis translate_off
// synopsys translate_off
(adc)? 
// synthesis translate_on
// synopsys translate_on
((adc)?((((~(in1[7]))&(~(in2[7])))&(out_in[7]))|(((in1[7])&(in2[7]))&(~(out_in[7])))):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_17 = 
// synthesis translate_off
// synopsys translate_off
(sbc)? 
// synthesis translate_on
// synopsys translate_on
((sbc)?((((~(in1[7]))&(in2[7]))&(_adder_out[7]))|(((in1[7])&(~(in2[7])))&(~(_adder_out[7])))):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_18 = 
// synthesis translate_off
// synopsys translate_off
(bita)? 
// synthesis translate_on
// synopsys translate_on
((bita)?(in2[7]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_19 = 
// synthesis translate_off
// synopsys translate_off
(bita)? 
// synthesis translate_on
// synopsys translate_on
((bita)?(~(|out_in)):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_20 = 
// synthesis translate_off
// synopsys translate_off
(bita)? 
// synthesis translate_on
// synopsys translate_on
((bita)?(in2[6]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_21 = 
// synthesis translate_off
// synopsys translate_off
(asl)? 
// synthesis translate_on
// synopsys translate_on
((asl)?(in1[7]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_22 = 
// synthesis translate_off
// synopsys translate_off
(lsr)? 
// synthesis translate_on
// synopsys translate_on
((lsr)?(in1[0]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_23 = 
// synthesis translate_off
// synopsys translate_off
(rol)? 
// synthesis translate_on
// synopsys translate_on
((rol)?(in1[7]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_24 = 
// synthesis translate_off
// synopsys translate_off
(ror)? 
// synthesis translate_on
// synopsys translate_on
((ror)?(in1[0]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((bita&set_out))
 begin $display("Warning: assign collision(alu65:out) at %d",$time);
if (bita) $display("assert (bita) line 56 at %d\n",$time);
if (set_out) $display("assert (set_out) line 35 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  out = 
// synthesis translate_off
// synopsys translate_off
((bita&set_out))? 8'bx :((bita|set_out))? 
// synthesis translate_on
// synopsys translate_on
((bita)?out_in:8'b0)|
    ((set_out)?out_in:8'b0)
// synthesis translate_off
// synopsys translate_off
:8'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge s)
  begin
#1 if (s===1'bx)
 begin
$display("Warning: control hazard(alu65:s) at %d",$time);
 end
#1 if ((((bita&_net_18))===1'bx) || (1'b1)===1'bx) $display("hazard ((bita&_net_18) || 1'b1) line 57 at %d\n",$time);
#1 if ((((set_out&_net_14))===1'bx) || (1'b1)===1'bx) $display("hazard ((set_out&_net_14) || 1'b1) line 34 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  s = (bita&_net_18)|
    (set_out&_net_14);

// synthesis translate_off
// synopsys translate_off
always @(posedge v)
  begin
#1 if (v===1'bx)
 begin
$display("Warning: control hazard(alu65:v) at %d",$time);
 end
#1 if ((((bita&_net_20))===1'bx) || (1'b1)===1'bx) $display("hazard ((bita&_net_20) || 1'b1) line 59 at %d\n",$time);
#1 if ((((sbc&_net_17))===1'bx) || (1'b1)===1'bx) $display("hazard ((sbc&_net_17) || 1'b1) line 46 at %d\n",$time);
#1 if ((((adc&_net_16))===1'bx) || (1'b1)===1'bx) $display("hazard ((adc&_net_16) || 1'b1) line 41 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  v = (bita&_net_20)|
    (sbc&_net_17)|
    (adc&_net_16);

// synthesis translate_off
// synopsys translate_off
always @(posedge z)
  begin
#1 if (z===1'bx)
 begin
$display("Warning: control hazard(alu65:z) at %d",$time);
 end
#1 if ((((bita&_net_19))===1'bx) || (1'b1)===1'bx) $display("hazard ((bita&_net_19) || 1'b1) line 58 at %d\n",$time);
#1 if ((((set_out&_net_15))===1'bx) || (1'b1)===1'bx) $display("hazard ((set_out&_net_15) || 1'b1) line 34 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  z = (bita&_net_19)|
    (set_out&_net_15);

// synthesis translate_off
// synopsys translate_off
always @(posedge c)
  begin
#1 if (c===1'bx)
 begin
$display("Warning: control hazard(alu65:c) at %d",$time);
 end
#1 if ((((ror&_net_24))===1'bx) || (1'b1)===1'bx) $display("hazard ((ror&_net_24) || 1'b1) line 101 at %d\n",$time);
#1 if ((((rol&_net_23))===1'bx) || (1'b1)===1'bx) $display("hazard ((rol&_net_23) || 1'b1) line 96 at %d\n",$time);
#1 if ((((lsr&_net_22))===1'bx) || (1'b1)===1'bx) $display("hazard ((lsr&_net_22) || 1'b1) line 91 at %d\n",$time);
#1 if ((((asl&_net_21))===1'bx) || (1'b1)===1'bx) $display("hazard ((asl&_net_21) || 1'b1) line 86 at %d\n",$time);
#1 if ((((incc&_adder_co))===1'bx) || (1'b1)===1'bx) $display("hazard ((incc&_adder_co) || 1'b1) line 81 at %d\n",$time);
#1 if ((((dec&_adder_co))===1'bx) || (1'b1)===1'bx) $display("hazard ((dec&_adder_co) || 1'b1) line 76 at %d\n",$time);
#1 if ((((inc&_adder_co))===1'bx) || (1'b1)===1'bx) $display("hazard ((inc&_adder_co) || 1'b1) line 71 at %d\n",$time);
#1 if ((((sbc&_adder_co))===1'bx) || (1'b1)===1'bx) $display("hazard ((sbc&_adder_co) || 1'b1) line 47 at %d\n",$time);
#1 if ((((adc&_adder_co))===1'bx) || (1'b1)===1'bx) $display("hazard ((adc&_adder_co) || 1'b1) line 40 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  c = (ror&_net_24)|
    (rol&_net_23)|
    (lsr&_net_22)|
    (asl&_net_21)|
    (incc&_adder_co)|
    (dec&_adder_co)|
    (inc&_adder_co)|
    (sbc&_adder_co)|
    (adc&_adder_co);
endmodule
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 01:56:01 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 01:56:01 2016
 Licensed to :EVALUATION USER
*/
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
  wire [15:0] _net_25;

   assign  res = 
// synthesis translate_off
// synopsys translate_off
(dox)? 
// synthesis translate_on
// synopsys translate_on
((dox)?(({1'b0,_net_25})+17'b00000000000000001):17'b0)
// synthesis translate_off
// synopsys translate_off
:17'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_25 = in;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((thr&dox))
 begin $display("Warning: assign collision(inc16:out) at %d",$time);
if (thr) $display("assert (thr) line 16 at %d\n",$time);
if (dox) $display("assert (dox) line 12 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  out = 
// synthesis translate_off
// synopsys translate_off
((thr&dox))? 16'bx :((thr|dox))? 
// synthesis translate_on
// synopsys translate_on
((thr)?in:16'b0)|
    ((dox)?(res[15:0]):16'b0)
// synthesis translate_off
// synopsys translate_off
:16'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((thr&dox))
 begin $display("Warning: assign collision(inc16:co) at %d",$time);
if (thr) $display("assert (thr) line 17 at %d\n",$time);
if (dox) $display("assert (dox) line 13 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  co = 
// synthesis translate_off
// synopsys translate_off
((thr&dox))? 1'bx :((thr|dox))? 
// synthesis translate_on
// synopsys translate_on
((thr)?1'b0:1'b0)|
    ((dox)?(res[16]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
endmodule
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 01:56:01 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 01:56:01 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module m65s ( p_reset , m_clock , data , datao , adrs , debug , start , rdy , nmi , irq , wt , rd , sync );
  parameter _state__reg_165_st0 = 0;
  parameter _state__reg_165_st1 = 1;
  parameter _state__reg_165_st2 = 2;
  parameter _state__reg_165_st3 = 3;
  parameter _state__reg_165_st4 = 4;
  parameter _state__reg_165_st5 = 5;
  parameter _state__reg_165_st6 = 6;
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
  wire _proc_do_nmi_set;
  wire _proc_do_nmi_reset;
  wire _proc_do_irq_set;
  wire _proc_do_irq_reset;
  wire _proc_do_brk_set;
  wire _proc_do_brk_reset;
  wire _proc_do_res_set;
  wire _proc_do_res_reset;
  wire _proc_int_req_set;
  wire _proc_int_req_reset;
  wire _proc_ex_set;
  wire _proc_ex_reset;
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
  reg [2:0] _reg_165;
  wire _net_166;
  wire _net_167;
  wire _net_168;
  wire _net_169;
  wire _net_170;
  wire _net_171;
  wire _net_172;
  wire _net_173;
inc16 incr (.m_clock(m_clock), .p_reset(p_reset), .thr(_incr_thr), .dox(_incr_dox), .out(_incr_out), .co(_incr_co), .in(_incr_in), .ci(_incr_ci));
alu65 alu (.m_clock(m_clock), .p_reset(p_reset), .thr(_alu_thr), .rol(_alu_rol), .ror(_alu_ror), .lsr(_alu_lsr), .asl(_alu_asl), .incc(_alu_incc), .dec2(_alu_dec2), .dec(_alu_dec), .inc(_alu_inc), .eor(_alu_eor), .do_or(_alu_do_or), .bita(_alu_bita), .do_and(_alu_do_and), .sbc(_alu_sbc), .adc(_alu_adc), .c(_alu_c), .z(_alu_z), .v(_alu_v), .s(_alu_s), .out(_alu_out), .df(_alu_df), .ci(_alu_ci), .in2(_alu_in2), .in1(_alu_in1));


// synthesis translate_off
// synopsys translate_off
always @(posedge s1)
  begin
#1 if (s1===1'bx)
 begin
$display("Warning: control hazard(m65s:s1) at %d",$time);
 end
#1 if ((((((((dbc&_net_156)&taken)&rdy)&_net_157)&_net_159))===1'bx) || (1'b1)===1'bx) $display("hazard ((((((dbc&_net_156)&taken)&rdy)&_net_157)&_net_159) || 1'b1) line 745 at %d\n",$time);
#1 if ((((((ea&mzpxi)&_net_121)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard ((((ea&mzpxi)&_net_121)&rdy) || 1'b1) line 454 at %d\n",$time);
#1 if ((((((ea&mabs)&_net_118)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard ((((ea&mabs)&_net_118)&rdy) || 1'b1) line 480 at %d\n",$time);
#1 if ((((((ea&mzpiy)&_net_116)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard ((((ea&mzpiy)&_net_116)&rdy) || 1'b1) line 499 at %d\n",$time);
#1 if (((((djmp&_net_83)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((djmp&_net_83)&rdy) || 1'b1) line 319 at %d\n",$time);
#1 if (((((djsr&_net_77)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((djsr&_net_77)&rdy) || 1'b1) line 279 at %d\n",$time);
#1 if ((((dphp&_net_72))===1'bx) || (1'b1)===1'bx) $display("hazard ((dphp&_net_72) || 1'b1) line 260 at %d\n",$time);
#1 if ((((dplp&_net_68))===1'bx) || (1'b1)===1'bx) $display("hazard ((dplp&_net_68) || 1'b1) line 242 at %d\n",$time);
#1 if ((((drti&_net_64))===1'bx) || (1'b1)===1'bx) $display("hazard ((drti&_net_64) || 1'b1) line 207 at %d\n",$time);
#1 if ((((drts&_net_60))===1'bx) || (1'b1)===1'bx) $display("hazard ((drts&_net_60) || 1'b1) line 174 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  s1 = (((((dbc&_net_156)&taken)&rdy)&_net_157)&_net_159)|
    (((ea&mzpxi)&_net_121)&rdy)|
    (((ea&mabs)&_net_118)&rdy)|
    (((ea&mzpiy)&_net_116)&rdy)|
    ((djmp&_net_83)&rdy)|
    ((djsr&_net_77)&rdy)|
    (dphp&_net_72)|
    (dplp&_net_68)|
    (drti&_net_64)|
    (drts&_net_60);

// synthesis translate_off
// synopsys translate_off
always @(posedge s2)
  begin
#1 if (s2===1'bx)
 begin
$display("Warning: control hazard(m65s:s2) at %d",$time);
 end
#1 if ((((((((dbc&_net_156)&taken)&rdy)&_net_157)&_net_158))===1'bx) || (1'b1)===1'bx) $display("hazard ((((((dbc&_net_156)&taken)&rdy)&_net_157)&_net_158) || 1'b1) line 746 at %d\n",$time);
#1 if ((((((ea&mzpxi)&_net_120)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard ((((ea&mzpxi)&_net_120)&rdy) || 1'b1) line 462 at %d\n",$time);
#1 if ((((((ea&mzpiy)&_net_115)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard ((((ea&mzpiy)&_net_115)&rdy) || 1'b1) line 508 at %d\n",$time);
#1 if (((((((ea&maby)&_net_103)&rdy)&_alu_c))===1'bx) || (1'b1)===1'bx) $display("hazard (((((ea&maby)&_net_103)&rdy)&_alu_c) || 1'b1) line 556 at %d\n",$time);
#1 if ((((((djmp&_net_80)&rdy)&_net_81))===1'bx) || (1'b1)===1'bx) $display("hazard ((((djmp&_net_80)&rdy)&_net_81) || 1'b1) line 331 at %d\n",$time);
#1 if ((((djsr&_net_76))===1'bx) || (1'b1)===1'bx) $display("hazard ((djsr&_net_76) || 1'b1) line 283 at %d\n",$time);
#1 if (((((drti&_net_63)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((drti&_net_63)&rdy) || 1'b1) line 214 at %d\n",$time);
#1 if (((((drts&_net_59)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((drts&_net_59)&rdy) || 1'b1) line 181 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  s2 = (((((dbc&_net_156)&taken)&rdy)&_net_157)&_net_158)|
    (((ea&mzpxi)&_net_120)&rdy)|
    (((ea&mzpiy)&_net_115)&rdy)|
    ((((ea&maby)&_net_103)&rdy)&_alu_c)|
    (((djmp&_net_80)&rdy)&_net_81)|
    (djsr&_net_76)|
    ((drti&_net_63)&rdy)|
    ((drts&_net_59)&rdy);

// synthesis translate_off
// synopsys translate_off
always @(posedge s3)
  begin
#1 if (s3===1'bx)
 begin
$display("Warning: control hazard(m65s:s3) at %d",$time);
 end
#1 if (((((((ea&mzpiy)&_net_113)&rdy)&_alu_c))===1'bx) || (1'b1)===1'bx) $display("hazard (((((ea&mzpiy)&_net_113)&rdy)&_alu_c) || 1'b1) line 519 at %d\n",$time);
#1 if (((((djmp&_net_79)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((djmp&_net_79)&rdy) || 1'b1) line 343 at %d\n",$time);
#1 if ((((djsr&_net_75))===1'bx) || (1'b1)===1'bx) $display("hazard ((djsr&_net_75) || 1'b1) line 295 at %d\n",$time);
#1 if (((((drti&_net_62)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((drti&_net_62)&rdy) || 1'b1) line 223 at %d\n",$time);
#1 if ((((((drts&_net_57)&rdy)&_alu_c))===1'bx) || (1'b1)===1'bx) $display("hazard ((((drts&_net_57)&rdy)&_alu_c) || 1'b1) line 193 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  s3 = ((((ea&mzpiy)&_net_113)&rdy)&_alu_c)|
    ((djmp&_net_79)&rdy)|
    (djsr&_net_75)|
    ((drti&_net_62)&rdy)|
    (((drts&_net_57)&rdy)&_alu_c);

// synthesis translate_off
// synopsys translate_off
always @(posedge s4)
  begin
#1 if (s4===1'bx)
 begin
$display("Warning: control hazard(m65s:s4) at %d",$time);
 end
#1 if ((((((ea&mzpxi)&_net_119)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard ((((ea&mzpxi)&_net_119)&rdy) || 1'b1) line 470 at %d\n",$time);
#1 if ((((((ea&mabs)&_net_117)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard ((((ea&mabs)&_net_117)&rdy) || 1'b1) line 488 at %d\n",$time);
#1 if (((((((ea&mzpiy)&_net_113)&rdy)&_net_114))===1'bx) || (1'b1)===1'bx) $display("hazard (((((ea&mzpiy)&_net_113)&rdy)&_net_114) || 1'b1) line 518 at %d\n",$time);
#1 if (((((ea&mzpiy)&_net_112))===1'bx) || (1'b1)===1'bx) $display("hazard (((ea&mzpiy)&_net_112) || 1'b1) line 525 at %d\n",$time);
#1 if ((((((ea&mzpx)&_net_108)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard ((((ea&mzpx)&_net_108)&rdy) || 1'b1) line 538 at %d\n",$time);
#1 if (((((((ea&maby)&_net_103)&rdy)&_net_106))===1'bx) || (1'b1)===1'bx) $display("hazard (((((ea&maby)&_net_103)&rdy)&_net_106) || 1'b1) line 555 at %d\n",$time);
#1 if (((((ea&maby)&_net_102))===1'bx) || (1'b1)===1'bx) $display("hazard (((ea&maby)&_net_102) || 1'b1) line 562 at %d\n",$time);
#1 if ((((djsr&_net_74))===1'bx) || (1'b1)===1'bx) $display("hazard ((djsr&_net_74) || 1'b1) line 301 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  s4 = (((ea&mzpxi)&_net_119)&rdy)|
    (((ea&mabs)&_net_117)&rdy)|
    ((((ea&mzpiy)&_net_113)&rdy)&_net_114)|
    ((ea&mzpiy)&_net_112)|
    (((ea&mzpx)&_net_108)&rdy)|
    ((((ea&maby)&_net_103)&rdy)&_net_106)|
    ((ea&maby)&_net_102)|
    (djsr&_net_74);

// synthesis translate_off
// synopsys translate_off
always @(posedge s5)
  begin
#1 if (s5===1'bx)
 begin
$display("Warning: control hazard(m65s:s5) at %d",$time);
 end
#1 if (((((rmw&_net_143)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((rmw&_net_143)&rdy) || 1'b1) line 685 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  s5 = ((rmw&_net_143)&rdy);

// synthesis translate_off
// synopsys translate_off
always @(posedge ifrun)
  begin
#1 if (ifrun===1'bx)
 begin
$display("Warning: control hazard(m65s:ifrun) at %d",$time);
 end
#1 if (((((((dbc&_net_156)&taken)&rdy)&_net_160))===1'bx) || (1'b1)===1'bx) $display("hazard (((((dbc&_net_156)&taken)&rdy)&_net_160) || 1'b1) line 742 at %d\n",$time);
#1 if ((((dbc&_net_155))===1'bx) || (1'b1)===1'bx) $display("hazard ((dbc&_net_155) || 1'b1) line 757 at %d\n",$time);
#1 if ((((dbc&_net_154))===1'bx) || (1'b1)===1'bx) $display("hazard ((dbc&_net_154) || 1'b1) line 762 at %d\n",$time);
#1 if ((((rmw&mimp))===1'bx) || (1'b1)===1'bx) $display("hazard ((rmw&mimp) || 1'b1) line 679 at %d\n",$time);
#1 if (((pf)===1'bx) || (1'b1)===1'bx) $display("hazard (pf || 1'b1) line 443 at %d\n",$time);
#1 if (((dmisc)===1'bx) || (1'b1)===1'bx) $display("hazard (dmisc || 1'b1) line 365 at %d\n",$time);
#1 if (((dclc)===1'bx) || (1'b1)===1'bx) $display("hazard (dclc || 1'b1) line 358 at %d\n",$time);
#1 if ((((((djmp&_net_80)&rdy)&_net_82))===1'bx) || (1'b1)===1'bx) $display("hazard ((((djmp&_net_80)&rdy)&_net_82) || 1'b1) line 330 at %d\n",$time);
#1 if (((((djmp&_net_78)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((djmp&_net_78)&rdy) || 1'b1) line 353 at %d\n",$time);
#1 if (((((djsr&_net_73)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((djsr&_net_73)&rdy) || 1'b1) line 310 at %d\n",$time);
#1 if ((((dphp&_net_69))===1'bx) || (1'b1)===1'bx) $display("hazard ((dphp&_net_69) || 1'b1) line 269 at %d\n",$time);
#1 if (((((dplp&_net_65)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((dplp&_net_65)&rdy) || 1'b1) line 251 at %d\n",$time);
#1 if (((((drti&_net_61)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((drti&_net_61)&rdy) || 1'b1) line 233 at %d\n",$time);
#1 if ((((((drts&_net_57)&rdy)&_net_58))===1'bx) || (1'b1)===1'bx) $display("hazard ((((drts&_net_57)&rdy)&_net_58) || 1'b1) line 192 at %d\n",$time);
#1 if ((((drts&_net_56))===1'bx) || (1'b1)===1'bx) $display("hazard ((drts&_net_56) || 1'b1) line 199 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  ifrun = ((((dbc&_net_156)&taken)&rdy)&_net_160)|
    (dbc&_net_155)|
    (dbc&_net_154)|
    (rmw&mimp)|
    pf|
    dmisc|
    dclc|
    (((djmp&_net_80)&rdy)&_net_82)|
    ((djmp&_net_78)&rdy)|
    ((djsr&_net_73)&rdy)|
    (dphp&_net_69)|
    ((dplp&_net_65)&rdy)|
    ((drti&_net_61)&rdy)|
    (((drts&_net_57)&rdy)&_net_58)|
    (drts&_net_56);

// synthesis translate_off
// synopsys translate_off
always @(posedge pf)
  begin
#1 if (pf===1'bx)
 begin
$display("Warning: control hazard(m65s:pf) at %d",$time);
 end
#1 if (((((dbc&_net_156)&_net_161))===1'bx) || (1'b1)===1'bx) $display("hazard (((dbc&_net_156)&_net_161) || 1'b1) line 736 at %d\n",$time);
#1 if ((((rmw&_net_142))===1'bx) || (1'b1)===1'bx) $display("hazard ((rmw&_net_142) || 1'b1) line 692 at %d\n",$time);
#1 if (((((dldx&_net_139)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((dldx&_net_139)&rdy) || 1'b1) line 670 at %d\n",$time);
#1 if (((((dcpx&_net_136)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((dcpx&_net_136)&rdy) || 1'b1) line 656 at %d\n",$time);
#1 if (((((dcmp&_net_134)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((dcmp&_net_134)&rdy) || 1'b1) line 641 at %d\n",$time);
#1 if (((((dlda&_net_133)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((dlda&_net_133)&rdy) || 1'b1) line 625 at %d\n",$time);
#1 if ((((dstx&_net_130))===1'bx) || (1'b1)===1'bx) $display("hazard ((dstx&_net_130) || 1'b1) line 614 at %d\n",$time);
#1 if ((((dsta&_net_129))===1'bx) || (1'b1)===1'bx) $display("hazard ((dsta&_net_129) || 1'b1) line 602 at %d\n",$time);
#1 if (((((dbit&_net_128)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((dbit&_net_128)&rdy) || 1'b1) line 592 at %d\n",$time);
#1 if (((((dora&_net_122)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((dora&_net_122)&rdy) || 1'b1) line 581 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  pf = ((dbc&_net_156)&_net_161)|
    (rmw&_net_142)|
    ((dldx&_net_139)&rdy)|
    ((dcpx&_net_136)&rdy)|
    ((dcmp&_net_134)&rdy)|
    ((dlda&_net_133)&rdy)|
    (dstx&_net_130)|
    (dsta&_net_129)|
    ((dbit&_net_128)&rdy)|
    ((dora&_net_122)&rdy);

// synthesis translate_off
// synopsys translate_off
always @(posedge write)
  begin
#1 if (write===1'bx)
 begin
$display("Warning: control hazard(m65s:write) at %d",$time);
 end
#1 if (((_net_170)===1'bx) || (1'b1)===1'bx) $display("hazard (_net_170 || 1'b1) line 814 at %d\n",$time);
#1 if (((_net_169)===1'bx) || (1'b1)===1'bx) $display("hazard (_net_169 || 1'b1) line 807 at %d\n",$time);
#1 if (((_net_168)===1'bx) || (1'b1)===1'bx) $display("hazard (_net_168 || 1'b1) line 800 at %d\n",$time);
#1 if ((((rmw&_net_142))===1'bx) || (1'b1)===1'bx) $display("hazard ((rmw&_net_142) || 1'b1) line 691 at %d\n",$time);
#1 if ((((dstx&_net_130))===1'bx) || (1'b1)===1'bx) $display("hazard ((dstx&_net_130) || 1'b1) line 613 at %d\n",$time);
#1 if ((((dsta&_net_129))===1'bx) || (1'b1)===1'bx) $display("hazard ((dsta&_net_129) || 1'b1) line 600 at %d\n",$time);
#1 if ((((djsr&_net_75))===1'bx) || (1'b1)===1'bx) $display("hazard ((djsr&_net_75) || 1'b1) line 290 at %d\n",$time);
#1 if ((((djsr&_net_74))===1'bx) || (1'b1)===1'bx) $display("hazard ((djsr&_net_74) || 1'b1) line 298 at %d\n",$time);
#1 if ((((dphp&_net_69))===1'bx) || (1'b1)===1'bx) $display("hazard ((dphp&_net_69) || 1'b1) line 264 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  write = _net_170|
    _net_169|
    _net_168|
    (rmw&_net_142)|
    (dstx&_net_130)|
    (dsta&_net_129)|
    (djsr&_net_75)|
    (djsr&_net_74)|
    (dphp&_net_69);

// synthesis translate_off
// synopsys translate_off
always @(posedge read)
  begin
#1 if (read===1'bx)
 begin
$display("Warning: control hazard(m65s:read) at %d",$time);
 end
#1 if (((_net_173)===1'bx) || (1'b1)===1'bx) $display("hazard (_net_173 || 1'b1) line 843 at %d\n",$time);
#1 if (((_net_172)===1'bx) || (1'b1)===1'bx) $display("hazard (_net_172 || 1'b1) line 835 at %d\n",$time);
#1 if ((((ift_run&_net_162))===1'bx) || (1'b1)===1'bx) $display("hazard ((ift_run&_net_162) || 1'b1) line 773 at %d\n",$time);
#1 if ((((dbc&_net_156))===1'bx) || (1'b1)===1'bx) $display("hazard ((dbc&_net_156) || 1'b1) line 734 at %d\n",$time);
#1 if ((((rmw&_net_143))===1'bx) || (1'b1)===1'bx) $display("hazard ((rmw&_net_143) || 1'b1) line 682 at %d\n",$time);
#1 if ((((dldx&_net_139))===1'bx) || (1'b1)===1'bx) $display("hazard ((dldx&_net_139) || 1'b1) line 664 at %d\n",$time);
#1 if ((((dcpx&_net_136))===1'bx) || (1'b1)===1'bx) $display("hazard ((dcpx&_net_136) || 1'b1) line 648 at %d\n",$time);
#1 if ((((dcmp&_net_134))===1'bx) || (1'b1)===1'bx) $display("hazard ((dcmp&_net_134) || 1'b1) line 632 at %d\n",$time);
#1 if ((((dlda&_net_133))===1'bx) || (1'b1)===1'bx) $display("hazard ((dlda&_net_133) || 1'b1) line 621 at %d\n",$time);
#1 if ((((dbit&_net_128))===1'bx) || (1'b1)===1'bx) $display("hazard ((dbit&_net_128) || 1'b1) line 588 at %d\n",$time);
#1 if ((((dora&_net_122))===1'bx) || (1'b1)===1'bx) $display("hazard ((dora&_net_122) || 1'b1) line 570 at %d\n",$time);
#1 if (((((ea&mzpxi)&_net_121))===1'bx) || (1'b1)===1'bx) $display("hazard (((ea&mzpxi)&_net_121) || 1'b1) line 449 at %d\n",$time);
#1 if (((((ea&mzpxi)&_net_120))===1'bx) || (1'b1)===1'bx) $display("hazard (((ea&mzpxi)&_net_120) || 1'b1) line 458 at %d\n",$time);
#1 if (((((ea&mzpxi)&_net_119))===1'bx) || (1'b1)===1'bx) $display("hazard (((ea&mzpxi)&_net_119) || 1'b1) line 466 at %d\n",$time);
#1 if (((((ea&mabs)&_net_118))===1'bx) || (1'b1)===1'bx) $display("hazard (((ea&mabs)&_net_118) || 1'b1) line 476 at %d\n",$time);
#1 if (((((ea&mabs)&_net_117))===1'bx) || (1'b1)===1'bx) $display("hazard (((ea&mabs)&_net_117) || 1'b1) line 484 at %d\n",$time);
#1 if (((((ea&mzpiy)&_net_116))===1'bx) || (1'b1)===1'bx) $display("hazard (((ea&mzpiy)&_net_116) || 1'b1) line 494 at %d\n",$time);
#1 if (((((ea&mzpiy)&_net_115))===1'bx) || (1'b1)===1'bx) $display("hazard (((ea&mzpiy)&_net_115) || 1'b1) line 503 at %d\n",$time);
#1 if (((((ea&mzpiy)&_net_113))===1'bx) || (1'b1)===1'bx) $display("hazard (((ea&mzpiy)&_net_113) || 1'b1) line 512 at %d\n",$time);
#1 if (((((ea&mzpx)&_net_108))===1'bx) || (1'b1)===1'bx) $display("hazard (((ea&mzpx)&_net_108) || 1'b1) line 530 at %d\n",$time);
#1 if (((((ea&maby)&_net_103))===1'bx) || (1'b1)===1'bx) $display("hazard (((ea&maby)&_net_103) || 1'b1) line 545 at %d\n",$time);
#1 if ((((djmp&_net_83))===1'bx) || (1'b1)===1'bx) $display("hazard ((djmp&_net_83) || 1'b1) line 316 at %d\n",$time);
#1 if ((((djmp&_net_80))===1'bx) || (1'b1)===1'bx) $display("hazard ((djmp&_net_80) || 1'b1) line 323 at %d\n",$time);
#1 if ((((djmp&_net_79))===1'bx) || (1'b1)===1'bx) $display("hazard ((djmp&_net_79) || 1'b1) line 336 at %d\n",$time);
#1 if ((((djmp&_net_78))===1'bx) || (1'b1)===1'bx) $display("hazard ((djmp&_net_78) || 1'b1) line 347 at %d\n",$time);
#1 if ((((djsr&_net_77))===1'bx) || (1'b1)===1'bx) $display("hazard ((djsr&_net_77) || 1'b1) line 274 at %d\n",$time);
#1 if ((((djsr&_net_73))===1'bx) || (1'b1)===1'bx) $display("hazard ((djsr&_net_73) || 1'b1) line 304 at %d\n",$time);
#1 if ((((dplp&_net_65))===1'bx) || (1'b1)===1'bx) $display("hazard ((dplp&_net_65) || 1'b1) line 245 at %d\n",$time);
#1 if ((((drti&_net_63))===1'bx) || (1'b1)===1'bx) $display("hazard ((drti&_net_63) || 1'b1) line 210 at %d\n",$time);
#1 if ((((drti&_net_62))===1'bx) || (1'b1)===1'bx) $display("hazard ((drti&_net_62) || 1'b1) line 218 at %d\n",$time);
#1 if ((((drti&_net_61))===1'bx) || (1'b1)===1'bx) $display("hazard ((drti&_net_61) || 1'b1) line 227 at %d\n",$time);
#1 if ((((drts&_net_59))===1'bx) || (1'b1)===1'bx) $display("hazard ((drts&_net_59) || 1'b1) line 177 at %d\n",$time);
#1 if ((((drts&_net_57))===1'bx) || (1'b1)===1'bx) $display("hazard ((drts&_net_57) || 1'b1) line 185 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  read = _net_173|
    _net_172|
    (ift_run&_net_162)|
    (dbc&_net_156)|
    (rmw&_net_143)|
    (dldx&_net_139)|
    (dcpx&_net_136)|
    (dcmp&_net_134)|
    (dlda&_net_133)|
    (dbit&_net_128)|
    (dora&_net_122)|
    ((ea&mzpxi)&_net_121)|
    ((ea&mzpxi)&_net_120)|
    ((ea&mzpxi)&_net_119)|
    ((ea&mabs)&_net_118)|
    ((ea&mabs)&_net_117)|
    ((ea&mzpiy)&_net_116)|
    ((ea&mzpiy)&_net_115)|
    ((ea&mzpiy)&_net_113)|
    ((ea&mzpx)&_net_108)|
    ((ea&maby)&_net_103)|
    (djmp&_net_83)|
    (djmp&_net_80)|
    (djmp&_net_79)|
    (djmp&_net_78)|
    (djsr&_net_77)|
    (djsr&_net_73)|
    (dplp&_net_65)|
    (drti&_net_63)|
    (drti&_net_62)|
    (drti&_net_61)|
    (drts&_net_59)|
    (drts&_net_57);

// synthesis translate_off
// synopsys translate_off
always @(posedge decop)
  begin
#1 if (decop===1'bx)
 begin
$display("Warning: control hazard(m65s:decop) at %d",$time);
 end
#1 if (((ex)===1'bx) || (1'b1)===1'bx) $display("hazard (ex || 1'b1) line 863 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  decop = ex;

// synthesis translate_off
// synopsys translate_off
always @(posedge ea)
  begin
#1 if (ea===1'bx)
 begin
$display("Warning: control hazard(m65s:ea) at %d",$time);
 end
#1 if (((((ddec&(~_net_150))&(~_net_153)))===1'bx) || (1'b1)===1'bx) $display("hazard (((ddec&(~_net_150))&(~_net_153)) || 1'b1) line 720 at %d\n",$time);
#1 if (((((dasl&(~_net_144))&(~_net_145)))===1'bx) || (1'b1)===1'bx) $display("hazard (((dasl&(~_net_144))&(~_net_145)) || 1'b1) line 708 at %d\n",$time);
#1 if ((((dldx&(~_net_139)))===1'bx) || (1'b1)===1'bx) $display("hazard ((dldx&(~_net_139)) || 1'b1) line 673 at %d\n",$time);
#1 if ((((dcpx&(~_net_136)))===1'bx) || (1'b1)===1'bx) $display("hazard ((dcpx&(~_net_136)) || 1'b1) line 659 at %d\n",$time);
#1 if ((((dcmp&(~_net_134)))===1'bx) || (1'b1)===1'bx) $display("hazard ((dcmp&(~_net_134)) || 1'b1) line 644 at %d\n",$time);
#1 if ((((dlda&(~_net_133)))===1'bx) || (1'b1)===1'bx) $display("hazard ((dlda&(~_net_133)) || 1'b1) line 628 at %d\n",$time);
#1 if ((((dstx&(~_net_130)))===1'bx) || (1'b1)===1'bx) $display("hazard ((dstx&(~_net_130)) || 1'b1) line 616 at %d\n",$time);
#1 if ((((dsta&(~_net_129)))===1'bx) || (1'b1)===1'bx) $display("hazard ((dsta&(~_net_129)) || 1'b1) line 604 at %d\n",$time);
#1 if ((((dbit&(~_net_128)))===1'bx) || (1'b1)===1'bx) $display("hazard ((dbit&(~_net_128)) || 1'b1) line 595 at %d\n",$time);
#1 if ((((dora&(~_net_122)))===1'bx) || (1'b1)===1'bx) $display("hazard ((dora&(~_net_122)) || 1'b1) line 584 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  ea = ((ddec&(~_net_150))&(~_net_153))|
    ((dasl&(~_net_144))&(~_net_145))|
    (dldx&(~_net_139))|
    (dcpx&(~_net_136))|
    (dcmp&(~_net_134))|
    (dlda&(~_net_133))|
    (dstx&(~_net_130))|
    (dsta&(~_net_129))|
    (dbit&(~_net_128))|
    (dora&(~_net_122));

// synthesis translate_off
// synopsys translate_off
always @(posedge dasl)
  begin
#1 if (dasl===1'bx)
 begin
$display("Warning: control hazard(m65s:dasl) at %d",$time);
 end
#1 if ((((decop&_net_45))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_45) || 1'b1) line 147 at %d\n",$time);
#1 if ((((decop&_net_37))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_37) || 1'b1) line 155 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  dasl = (decop&_net_45)|
    (decop&_net_37);

// synthesis translate_off
// synopsys translate_off
always @(posedge dbit)
  begin
#1 if (dbit===1'bx)
 begin
$display("Warning: control hazard(m65s:dbit) at %d",$time);
 end
#1 if ((((decop&_net_43))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_43) || 1'b1) line 149 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  dbit = (decop&_net_43);

// synthesis translate_off
// synopsys translate_off
always @(posedge dclc)
  begin
#1 if (dclc===1'bx)
 begin
$display("Warning: control hazard(m65s:dclc) at %d",$time);
 end
#1 if ((((decop&_net_36))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_36) || 1'b1) line 156 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  dclc = (decop&_net_36);

// synthesis translate_off
// synopsys translate_off
always @(posedge dcmp)
  begin
#1 if (dcmp===1'bx)
 begin
$display("Warning: control hazard(m65s:dcmp) at %d",$time);
 end
#1 if ((((decop&_net_46))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_46) || 1'b1) line 146 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  dcmp = (decop&_net_46);

// synthesis translate_off
// synopsys translate_off
always @(posedge dcpx)
  begin
#1 if (dcpx===1'bx)
 begin
$display("Warning: control hazard(m65s:dcpx) at %d",$time);
 end
#1 if ((((decop&_net_40))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_40) || 1'b1) line 152 at %d\n",$time);
#1 if ((((decop&_net_38))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_38) || 1'b1) line 154 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  dcpx = (decop&_net_40)|
    (decop&_net_38);

// synthesis translate_off
// synopsys translate_off
always @(posedge ddec)
  begin
#1 if (ddec===1'bx)
 begin
$display("Warning: control hazard(m65s:ddec) at %d",$time);
 end
#1 if ((((decop&_net_44))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_44) || 1'b1) line 148 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  ddec = (decop&_net_44);

// synthesis translate_off
// synopsys translate_off
always @(posedge dmisc)
  begin
#1 if (dmisc===1'bx)
 begin
$display("Warning: control hazard(m65s:dmisc) at %d",$time);
 end
#1 if ((((decop&_net_35))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_35) || 1'b1) line 157 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  dmisc = (decop&_net_35);

// synthesis translate_off
// synopsys translate_off
always @(posedge djmp)
  begin
#1 if (djmp===1'bx)
 begin
$display("Warning: control hazard(m65s:djmp) at %d",$time);
 end
#1 if ((((decop&_net_33))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_33) || 1'b1) line 160 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  djmp = (decop&_net_33);

// synthesis translate_off
// synopsys translate_off
always @(posedge djsr)
  begin
#1 if (djsr===1'bx)
 begin
$display("Warning: control hazard(m65s:djsr) at %d",$time);
 end
#1 if ((((decop&_net_32))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_32) || 1'b1) line 161 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  djsr = (decop&_net_32);

// synthesis translate_off
// synopsys translate_off
always @(posedge dlda)
  begin
#1 if (dlda===1'bx)
 begin
$display("Warning: control hazard(m65s:dlda) at %d",$time);
 end
#1 if ((((decop&_net_47))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_47) || 1'b1) line 145 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  dlda = (decop&_net_47);

// synthesis translate_off
// synopsys translate_off
always @(posedge dldx)
  begin
#1 if (dldx===1'bx)
 begin
$display("Warning: control hazard(m65s:dldx) at %d",$time);
 end
#1 if ((((decop&_net_41))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_41) || 1'b1) line 151 at %d\n",$time);
#1 if ((((decop&_net_39))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_39) || 1'b1) line 153 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  dldx = (decop&_net_41)|
    (decop&_net_39);

// synthesis translate_off
// synopsys translate_off
always @(posedge dnop)
  begin
#1 if (dnop===1'bx)
 begin
$display("Warning: control hazard(m65s:dnop) at %d",$time);
 end
#1 if ((((dmisc&_net_95))===1'bx) || (1'b1)===1'bx) $display("hazard ((dmisc&_net_95) || 1'b1) line 396 at %d\n",$time);
#1 if ((((dmisc&_net_91))===1'bx) || (1'b1)===1'bx) $display("hazard ((dmisc&_net_91) || 1'b1) line 412 at %d\n",$time);
#1 if ((((dmisc&_net_88))===1'bx) || (1'b1)===1'bx) $display("hazard ((dmisc&_net_88) || 1'b1) line 419 at %d\n",$time);
#1 if ((((dmisc&_net_87))===1'bx) || (1'b1)===1'bx) $display("hazard ((dmisc&_net_87) || 1'b1) line 420 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  dnop = (dmisc&_net_95)|
    (dmisc&_net_91)|
    (dmisc&_net_88)|
    (dmisc&_net_87);

// synthesis translate_off
// synopsys translate_off
always @(posedge dora)
  begin
#1 if (dora===1'bx)
 begin
$display("Warning: control hazard(m65s:dora) at %d",$time);
 end
#1 if ((((decop&_net_49))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_49) || 1'b1) line 143 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  dora = (decop&_net_49);

// synthesis translate_off
// synopsys translate_off
always @(posedge dphp)
  begin
#1 if (dphp===1'bx)
 begin
$display("Warning: control hazard(m65s:dphp) at %d",$time);
 end
#1 if ((((decop&_net_29))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_29) || 1'b1) line 164 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  dphp = (decop&_net_29);

// synthesis translate_off
// synopsys translate_off
always @(posedge dplp)
  begin
#1 if (dplp===1'bx)
 begin
$display("Warning: control hazard(m65s:dplp) at %d",$time);
 end
#1 if ((((decop&_net_28))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_28) || 1'b1) line 165 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  dplp = (decop&_net_28);

// synthesis translate_off
// synopsys translate_off
always @(posedge drti)
  begin
#1 if (drti===1'bx)
 begin
$display("Warning: control hazard(m65s:drti) at %d",$time);
 end
#1 if ((((decop&_net_31))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_31) || 1'b1) line 162 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  drti = (decop&_net_31);

// synthesis translate_off
// synopsys translate_off
always @(posedge drts)
  begin
#1 if (drts===1'bx)
 begin
$display("Warning: control hazard(m65s:drts) at %d",$time);
 end
#1 if ((((decop&_net_30))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_30) || 1'b1) line 163 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  drts = (decop&_net_30);

// synthesis translate_off
// synopsys translate_off
always @(posedge dsta)
  begin
#1 if (dsta===1'bx)
 begin
$display("Warning: control hazard(m65s:dsta) at %d",$time);
 end
#1 if ((((decop&_net_48))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_48) || 1'b1) line 144 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  dsta = (decop&_net_48);

// synthesis translate_off
// synopsys translate_off
always @(posedge dstx)
  begin
#1 if (dstx===1'bx)
 begin
$display("Warning: control hazard(m65s:dstx) at %d",$time);
 end
#1 if ((((decop&_net_42))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_42) || 1'b1) line 150 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  dstx = (decop&_net_42);

// synthesis translate_off
// synopsys translate_off
always @(posedge dbc)
  begin
#1 if (dbc===1'bx)
 begin
$display("Warning: control hazard(m65s:dbc) at %d",$time);
 end
#1 if ((((decop&_net_34))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_34) || 1'b1) line 159 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  dbc = (decop&_net_34);

// synthesis translate_off
// synopsys translate_off
always @(posedge mimp)
  begin
#1 if (mimp===1'bx)
 begin
$display("Warning: control hazard(m65s:mimp) at %d",$time);
 end
#1 if ((((decop&_net_37))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_37) || 1'b1) line 155 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  mimp = (decop&_net_37);

// synthesis translate_off
// synopsys translate_off
always @(posedge mimm)
  begin
#1 if (mimm===1'bx)
 begin
$display("Warning: control hazard(m65s:mimm) at %d",$time);
 end
#1 if ((((decop&_net_54))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_54) || 1'b1) line 138 at %d\n",$time);
#1 if ((((decop&_net_39))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_39) || 1'b1) line 153 at %d\n",$time);
#1 if ((((decop&_net_38))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_38) || 1'b1) line 154 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  mimm = (decop&_net_54)|
    (decop&_net_39)|
    (decop&_net_38);

// synthesis translate_off
// synopsys translate_off
always @(posedge mzpx)
  begin
#1 if (mzpx===1'bx)
 begin
$display("Warning: control hazard(m65s:mzpx) at %d",$time);
 end
#1 if ((((decop&_net_51))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_51) || 1'b1) line 141 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  mzpx = (decop&_net_51);

// synthesis translate_off
// synopsys translate_off
always @(posedge mzpxi)
  begin
#1 if (mzpxi===1'bx)
 begin
$display("Warning: control hazard(m65s:mzpxi) at %d",$time);
 end
#1 if ((((decop&_net_55))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_55) || 1'b1) line 137 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  mzpxi = (decop&_net_55);

// synthesis translate_off
// synopsys translate_off
always @(posedge mzpiy)
  begin
#1 if (mzpiy===1'bx)
 begin
$display("Warning: control hazard(m65s:mzpiy) at %d",$time);
 end
#1 if ((((decop&_net_52))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_52) || 1'b1) line 140 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  mzpiy = (decop&_net_52);

// synthesis translate_off
// synopsys translate_off
always @(posedge mabs)
  begin
#1 if (mabs===1'bx)
 begin
$display("Warning: control hazard(m65s:mabs) at %d",$time);
 end
#1 if (((((ea&maby)&_net_107))===1'bx) || (1'b1)===1'bx) $display("hazard (((ea&maby)&_net_107) || 1'b1) line 543 at %d\n",$time);
#1 if ((((decop&_net_53))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_53) || 1'b1) line 139 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  mabs = ((ea&maby)&_net_107)|
    (decop&_net_53);

// synthesis translate_off
// synopsys translate_off
always @(posedge maby)
  begin
#1 if (maby===1'bx)
 begin
$display("Warning: control hazard(m65s:maby) at %d",$time);
 end
#1 if ((((decop&_net_50))===1'bx) || (1'b1)===1'bx) $display("hazard ((decop&_net_50) || 1'b1) line 142 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  maby = (decop&_net_50);

// synthesis translate_off
// synopsys translate_off
always @(posedge rmw)
  begin
#1 if (rmw===1'bx)
 begin
$display("Warning: control hazard(m65s:rmw) at %d",$time);
 end
#1 if ((((ddec&_net_153))===1'bx) || (1'b1)===1'bx) $display("hazard ((ddec&_net_153) || 1'b1) line 711 at %d\n",$time);
#1 if ((((ddec&_net_150))===1'bx) || (1'b1)===1'bx) $display("hazard ((ddec&_net_150) || 1'b1) line 713 at %d\n",$time);
#1 if ((((dasl&_net_145))===1'bx) || (1'b1)===1'bx) $display("hazard ((dasl&_net_145) || 1'b1) line 698 at %d\n",$time);
#1 if ((((dasl&_net_144))===1'bx) || (1'b1)===1'bx) $display("hazard ((dasl&_net_144) || 1'b1) line 707 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  rmw = (ddec&_net_153)|
    (ddec&_net_150)|
    (dasl&_net_145)|
    (dasl&_net_144);

// synthesis translate_off
// synopsys translate_off
always @(posedge nif0)
  begin
#1 if (nif0===1'bx)
 begin
$display("Warning: control hazard(m65s:nif0) at %d",$time);
 end
#1 if (((dmisc)===1'bx) || (1'b1)===1'bx) $display("hazard (dmisc || 1'b1) line 365 at %d\n",$time);
#1 if (((dclc)===1'bx) || (1'b1)===1'bx) $display("hazard (dclc || 1'b1) line 358 at %d\n",$time);
#1 if ((((djsr&_net_74))===1'bx) || (1'b1)===1'bx) $display("hazard ((djsr&_net_74) || 1'b1) line 300 at %d\n",$time);
#1 if ((((dphp&_net_69))===1'bx) || (1'b1)===1'bx) $display("hazard ((dphp&_net_69) || 1'b1) line 269 at %d\n",$time);
#1 if (((((dplp&_net_65)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((dplp&_net_65)&rdy) || 1'b1) line 251 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  nif0 = dmisc|
    dclc|
    (djsr&_net_74)|
    (dphp&_net_69)|
    ((dplp&_net_65)&rdy);

// synthesis translate_off
// synopsys translate_off
always @(posedge nif1)
  begin
#1 if (nif1===1'bx)
 begin
$display("Warning: control hazard(m65s:nif1) at %d",$time);
 end
#1 if ((((_net_172&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard ((_net_172&rdy) || 1'b1) line 838 at %d\n",$time);
#1 if (((((ift_run&_net_162)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((ift_run&_net_162)&rdy) || 1'b1) line 776 at %d\n",$time);
#1 if ((((((ea&mabs)&_net_118)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard ((((ea&mabs)&_net_118)&rdy) || 1'b1) line 479 at %d\n",$time);
#1 if (((pf)===1'bx) || (1'b1)===1'bx) $display("hazard (pf || 1'b1) line 442 at %d\n",$time);
#1 if (((((djmp&_net_83)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((djmp&_net_83)&rdy) || 1'b1) line 318 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  nif1 = (_net_172&rdy)|
    ((ift_run&_net_162)&rdy)|
    (((ea&mabs)&_net_118)&rdy)|
    pf|
    ((djmp&_net_83)&rdy);

// synthesis translate_off
// synopsys translate_off
always @(posedge nif2)
  begin
#1 if (nif2===1'bx)
 begin
$display("Warning: control hazard(m65s:nif2) at %d",$time);
 end
#1 if ((((_net_166&do_brk))===1'bx) || (1'b1)===1'bx) $display("hazard ((_net_166&do_brk) || 1'b1) line 790 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  nif2 = (_net_166&do_brk);
   assign  psr = ({fn,fv,1'b1,1'b1,fd,fi,fz,fc});

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((((dplp&_net_65)&_net_67)&(drti&_net_63)))
 begin $display("Warning: assign collision(m65s:psri) at %d",$time);
if (((dplp&_net_65)&_net_67)) $display("assert (((dplp&_net_65)&_net_67)) line 247 at %d\n",$time);
if ((drti&_net_63)) $display("assert ((drti&_net_63)) line 210 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  psri = 
// synthesis translate_off
// synopsys translate_off
((((dplp&_net_65)&_net_67)&(drti&_net_63)))? 8'bx :((((dplp&_net_65)&_net_67)|(drti&_net_63)))? 
// synthesis translate_on
// synopsys translate_on
((((dplp&_net_65)&_net_67))?dbi:8'b0)|
    (((drti&_net_63))?dbi:8'b0)
// synthesis translate_off
// synopsys translate_off
:8'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  taken = 
// synthesis translate_off
// synopsys translate_off
((dbc&_net_156))? 
// synthesis translate_on
// synopsys translate_on
(((dbc&_net_156))?((((((((((opc[7:5])==3'b000)&(~fn))|(((opc[7:5])==3'b001)&fn))|(((opc[7:5])==3'b010)&(~fv)))|(((opc[7:5])==3'b011)&fv))|(((opc[7:5])==3'b100)&(~fc)))|(((opc[7:5])==3'b101)&fc))|(((opc[7:5])==3'b110)&(~fz)))|(((opc[7:5])==3'b111)&fz)):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if (((rmw&mimp)&(rmw&_net_142)))
 begin $display("Warning: assign collision(m65s:ALU1) at %d",$time);
if ((rmw&mimp)) $display("assert ((rmw&mimp)) line 679 at %d\n",$time);
if ((rmw&_net_142)) $display("assert ((rmw&_net_142)) line 690 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  ALU1 = 
// synthesis translate_off
// synopsys translate_off
(((rmw&mimp)&(rmw&_net_142)))? 8'bx :(((rmw&mimp)|(rmw&_net_142)))? 
// synthesis translate_on
// synopsys translate_on
(((rmw&mimp))?RA:8'b0)|
    (((rmw&_net_142))?DL:8'b0)
// synthesis translate_off
// synopsys translate_off
:8'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((((((((_net_171&(~do_res))&(~do_brk))&(~do_nmi))&do_irq)&(((_net_171&(~do_res))&(~do_brk))&do_nmi))|((((((_net_171&(~do_res))&(~do_brk))&(~do_nmi))&do_irq)|(((_net_171&(~do_res))&(~do_brk))&do_nmi))&((_net_171&(~do_res))&do_brk)))|(((((((_net_171&(~do_res))&(~do_brk))&(~do_nmi))&do_irq)|(((_net_171&(~do_res))&(~do_brk))&do_nmi))|((_net_171&(~do_res))&do_brk))&(_net_171&do_res))))
 begin $display("Warning: assign collision(m65s:ABLin) at %d",$time);
if (((((_net_171&(~do_res))&(~do_brk))&(~do_nmi))&do_irq)) $display("assert (((((_net_171&(~do_res))&(~do_brk))&(~do_nmi))&do_irq)) line 825 at %d\n",$time);
if ((((_net_171&(~do_res))&(~do_brk))&do_nmi)) $display("assert ((((_net_171&(~do_res))&(~do_brk))&do_nmi)) line 824 at %d\n",$time);
if (((_net_171&(~do_res))&do_brk)) $display("assert (((_net_171&(~do_res))&do_brk)) line 823 at %d\n",$time);
if ((_net_171&do_res)) $display("assert ((_net_171&do_res)) line 822 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  ABLin = 
// synthesis translate_off
// synopsys translate_off
((((((((_net_171&(~do_res))&(~do_brk))&(~do_nmi))&do_irq)&(((_net_171&(~do_res))&(~do_brk))&do_nmi))|((((((_net_171&(~do_res))&(~do_brk))&(~do_nmi))&do_irq)|(((_net_171&(~do_res))&(~do_brk))&do_nmi))&((_net_171&(~do_res))&do_brk)))|(((((((_net_171&(~do_res))&(~do_brk))&(~do_nmi))&do_irq)|(((_net_171&(~do_res))&(~do_brk))&do_nmi))|((_net_171&(~do_res))&do_brk))&(_net_171&do_res))))? 8'bx :((((((((_net_171&(~do_res))&(~do_brk))&(~do_nmi))&do_irq)|(((_net_171&(~do_res))&(~do_brk))&do_nmi))|((_net_171&(~do_res))&do_brk))|(_net_171&do_res)))? 
// synthesis translate_on
// synopsys translate_on
((((((_net_171&(~do_res))&(~do_brk))&(~do_nmi))&do_irq))?8'b11111110:8'b0)|
    (((((_net_171&(~do_res))&(~do_brk))&do_nmi))?8'b11111010:8'b0)|
    ((((_net_171&(~do_res))&do_brk))?8'b11111110:8'b0)|
    (((_net_171&do_res))?8'b11111100:8'b0)
// synthesis translate_off
// synopsys translate_off
:8'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if (((((((((((_net_170&_net_169)|((_net_170|_net_169)&_net_168))|(((_net_170|_net_169)|_net_168)&(rmw&_net_142)))|((((_net_170|_net_169)|_net_168)|(rmw&_net_142))&((dstx&_net_130)&_net_132)))|(((((_net_170|_net_169)|_net_168)|(rmw&_net_142))|((dstx&_net_130)&_net_132))&((dstx&_net_130)&_net_131)))|((((((_net_170|_net_169)|_net_168)|(rmw&_net_142))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))&(dsta&_net_129)))|(((((((_net_170|_net_169)|_net_168)|(rmw&_net_142))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))&(djsr&_net_75)))|((((((((_net_170|_net_169)|_net_168)|(rmw&_net_142))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|(djsr&_net_75))&(djsr&_net_74)))|(((((((((_net_170|_net_169)|_net_168)|(rmw&_net_142))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|(djsr&_net_75))|(djsr&_net_74))&((dphp&_net_69)&_net_71)))|((((((((((_net_170|_net_169)|_net_168)|(rmw&_net_142))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|(djsr&_net_75))|(djsr&_net_74))|((dphp&_net_69)&_net_71))&((dphp&_net_69)&_net_70))))
 begin $display("Warning: assign collision(m65s:dbo) at %d",$time);
if (_net_170) $display("assert (_net_170) line 815 at %d\n",$time);
if (_net_169) $display("assert (_net_169) line 808 at %d\n",$time);
if (_net_168) $display("assert (_net_168) line 801 at %d\n",$time);
if ((rmw&_net_142)) $display("assert ((rmw&_net_142)) line 690 at %d\n",$time);
if (((dstx&_net_130)&_net_132)) $display("assert (((dstx&_net_130)&_net_132)) line 610 at %d\n",$time);
if (((dstx&_net_130)&_net_131)) $display("assert (((dstx&_net_130)&_net_131)) line 611 at %d\n",$time);
if ((dsta&_net_129)) $display("assert ((dsta&_net_129)) line 601 at %d\n",$time);
if ((djsr&_net_75)) $display("assert ((djsr&_net_75)) line 291 at %d\n",$time);
if ((djsr&_net_74)) $display("assert ((djsr&_net_74)) line 299 at %d\n",$time);
if (((dphp&_net_69)&_net_71)) $display("assert (((dphp&_net_69)&_net_71)) line 266 at %d\n",$time);
if (((dphp&_net_69)&_net_70)) $display("assert (((dphp&_net_69)&_net_70)) line 267 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  dbo = 
// synthesis translate_off
// synopsys translate_off
(((((((((((_net_170&_net_169)|((_net_170|_net_169)&_net_168))|(((_net_170|_net_169)|_net_168)&(rmw&_net_142)))|((((_net_170|_net_169)|_net_168)|(rmw&_net_142))&((dstx&_net_130)&_net_132)))|(((((_net_170|_net_169)|_net_168)|(rmw&_net_142))|((dstx&_net_130)&_net_132))&((dstx&_net_130)&_net_131)))|((((((_net_170|_net_169)|_net_168)|(rmw&_net_142))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))&(dsta&_net_129)))|(((((((_net_170|_net_169)|_net_168)|(rmw&_net_142))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))&(djsr&_net_75)))|((((((((_net_170|_net_169)|_net_168)|(rmw&_net_142))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|(djsr&_net_75))&(djsr&_net_74)))|(((((((((_net_170|_net_169)|_net_168)|(rmw&_net_142))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|(djsr&_net_75))|(djsr&_net_74))&((dphp&_net_69)&_net_71)))|((((((((((_net_170|_net_169)|_net_168)|(rmw&_net_142))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|(djsr&_net_75))|(djsr&_net_74))|((dphp&_net_69)&_net_71))&((dphp&_net_69)&_net_70))))? 8'bx :(((((((((((_net_170|_net_169)|_net_168)|(rmw&_net_142))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|(djsr&_net_75))|(djsr&_net_74))|((dphp&_net_69)&_net_71))|((dphp&_net_69)&_net_70)))? 
// synthesis translate_on
// synopsys translate_on
((_net_170)?(psr&({3'b111,(~(do_irq|do_nmi)),4'b1111})):8'b0)|
    ((_net_169)?PCL:8'b0)|
    ((_net_168)?PCH:8'b0)|
    (((rmw&_net_142))?_alu_out:8'b0)|
    ((((dstx&_net_130)&_net_132))?_alu_out:8'b0)|
    ((((dstx&_net_130)&_net_131))?_alu_out:8'b0)|
    (((dsta&_net_129))?_alu_out:8'b0)|
    (((djsr&_net_75))?PCH:8'b0)|
    (((djsr&_net_74))?PCL:8'b0)|
    ((((dphp&_net_69)&_net_71))?psr:8'b0)|
    ((((dphp&_net_69)&_net_70))?RA:8'b0)
// synthesis translate_off
// synopsys translate_off
:8'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  dbi = 
// synthesis translate_off
// synopsys translate_off
(read)? 
// synthesis translate_on
// synopsys translate_on
((read)?data:8'b0)
// synthesis translate_off
// synopsys translate_off
:8'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  opc = OP;

// synthesis translate_off
// synopsys translate_off
always @(posedge setpsr)
  begin
#1 if (setpsr===1'bx)
 begin
$display("Warning: control hazard(m65s:setpsr) at %d",$time);
 end
#1 if (((((dplp&_net_65)&_net_67))===1'bx) || (1'b1)===1'bx) $display("hazard (((dplp&_net_65)&_net_67) || 1'b1) line 247 at %d\n",$time);
#1 if ((((drti&_net_63))===1'bx) || (1'b1)===1'bx) $display("hazard ((drti&_net_63) || 1'b1) line 210 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  setpsr = ((dplp&_net_65)&_net_67)|
    (drti&_net_63);

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((((((((((((((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)&(((dbc&_net_156)&taken)&rdy))|(((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))&(dbc&_net_155)))|((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))&(dbc&_net_154)))|(((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))&((ddec&_net_150)&_net_152)))|((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))&((ddec&_net_150)&_net_151)))|(((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))&((dasl&_net_145)&_net_149)))|((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))&((dasl&_net_145)&_net_148)))|(((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))&((dasl&_net_145)&_net_147)))|((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))&((dasl&_net_145)&_net_146)))|(((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))&(((dldx&_net_139)&rdy)&_net_141)))|((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))&(((dldx&_net_139)&rdy)&_net_140)))|(((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))&(((dcpx&_net_136)&rdy)&_net_138)))|((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))&(((dcpx&_net_136)&rdy)&_net_137)))|(((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))&((dcmp&_net_134)&rdy)))|((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))&((dlda&_net_133)&rdy)))|(((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))&((dstx&_net_130)&_net_132)))|((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))&((dstx&_net_130)&_net_131)))|(((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))&(dsta&_net_129)))|((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))&((dbit&_net_128)&rdy)))|(((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))&((dora&_net_122)&_net_126)))|((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))&((dora&_net_122)&_net_125)))|(((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))&((dora&_net_122)&_net_124)))|((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))&((dora&_net_122)&_net_123)))|(((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))&(((ea&mzpxi)&_net_121)&rdy)))|((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))&(((ea&mzpxi)&_net_120)&rdy)))|(((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))&(((ea&mzpiy)&_net_115)&rdy)))|((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))&(((ea&mzpiy)&_net_113)&rdy)))|(((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))&((ea&mzpiy)&_net_112)))|((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))&((((ea&mzpx)&_net_108)&rdy)&_net_111)))|(((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))&((((ea&mzpx)&_net_108)&rdy)&_net_110)))|((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))&((((ea&mzpx)&_net_108)&rdy)&_net_109)))|(((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))&((((ea&maby)&_net_103)&rdy)&_net_105)))|((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))&((((ea&maby)&_net_103)&rdy)&_net_104)))|(((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))&((ea&maby)&_net_102)))|((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))&(dmisc&_net_101)))|(((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))&(dmisc&_net_100)))|((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))&(dmisc&_net_99)))|(((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))&(dmisc&_net_98)))|((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))&(dmisc&_net_97)))|(((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))&(dmisc&_net_96)))|((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))&(dmisc&_net_94)))|(((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))&(dmisc&_net_93)))|((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))&(dmisc&_net_92)))|(((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))&(dmisc&_net_89)))|((((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))&((djmp&_net_79)&rdy)))|(((((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((djmp&_net_79)&rdy))&(dplp&_net_68)))|((((((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((djmp&_net_79)&rdy))|(dplp&_net_68))&((dplp&_net_65)&_net_66)))|(((((((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((djmp&_net_79)&rdy))|(dplp&_net_68))|((dplp&_net_65)&_net_66))&(drti&_net_64)))|((((((((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((djmp&_net_79)&rdy))|(dplp&_net_68))|((dplp&_net_65)&_net_66))|(drti&_net_64))&((drti&_net_63)&rdy)))|(((((((((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((djmp&_net_79)&rdy))|(dplp&_net_68))|((dplp&_net_65)&_net_66))|(drti&_net_64))|((drti&_net_63)&rdy))&((drti&_net_62)&rdy)))|((((((((((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((djmp&_net_79)&rdy))|(dplp&_net_68))|((dplp&_net_65)&_net_66))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))&(drts&_net_60)))|(((((((((((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((djmp&_net_79)&rdy))|(dplp&_net_68))|((dplp&_net_65)&_net_66))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))|(drts&_net_60))&((drts&_net_59)&rdy)))|((((((((((((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((djmp&_net_79)&rdy))|(dplp&_net_68))|((dplp&_net_65)&_net_66))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))|(drts&_net_60))|((drts&_net_59)&rdy))&((drts&_net_57)&rdy)))|(((((((((((((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((djmp&_net_79)&rdy))|(dplp&_net_68))|((dplp&_net_65)&_net_66))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))|(drts&_net_60))|((drts&_net_59)&rdy))|((drts&_net_57)&rdy))&(drts&_net_56))))
 begin $display("Warning: assign collision(m65s:_alu_in1) at %d",$time);
if ((ift_run&_net_162)) $display("assert ((ift_run&_net_162)) line 773 at %d\n",$time);
if ((((dbc&_net_156)&taken)&rdy)) $display("assert ((((dbc&_net_156)&taken)&rdy)) line 739 at %d\n",$time);
if ((dbc&_net_155)) $display("assert ((dbc&_net_155)) line 755 at %d\n",$time);
if ((dbc&_net_154)) $display("assert ((dbc&_net_154)) line 760 at %d\n",$time);
if (((ddec&_net_150)&_net_152)) $display("assert (((ddec&_net_150)&_net_152)) line 715 at %d\n",$time);
if (((ddec&_net_150)&_net_151)) $display("assert (((ddec&_net_150)&_net_151)) line 716 at %d\n",$time);
if (((dasl&_net_145)&_net_149)) $display("assert (((dasl&_net_145)&_net_149)) line 700 at %d\n",$time);
if (((dasl&_net_145)&_net_148)) $display("assert (((dasl&_net_145)&_net_148)) line 701 at %d\n",$time);
if (((dasl&_net_145)&_net_147)) $display("assert (((dasl&_net_145)&_net_147)) line 702 at %d\n",$time);
if (((dasl&_net_145)&_net_146)) $display("assert (((dasl&_net_145)&_net_146)) line 703 at %d\n",$time);
if ((((dldx&_net_139)&rdy)&_net_141)) $display("assert ((((dldx&_net_139)&rdy)&_net_141)) line 667 at %d\n",$time);
if ((((dldx&_net_139)&rdy)&_net_140)) $display("assert ((((dldx&_net_139)&rdy)&_net_140)) line 668 at %d\n",$time);
if ((((dcpx&_net_136)&rdy)&_net_138)) $display("assert ((((dcpx&_net_136)&rdy)&_net_138)) line 651 at %d\n",$time);
if ((((dcpx&_net_136)&rdy)&_net_137)) $display("assert ((((dcpx&_net_136)&rdy)&_net_137)) line 652 at %d\n",$time);
if (((dcmp&_net_134)&rdy)) $display("assert (((dcmp&_net_134)&rdy)) line 634 at %d\n",$time);
if (((dlda&_net_133)&rdy)) $display("assert (((dlda&_net_133)&rdy)) line 624 at %d\n",$time);
if (((dstx&_net_130)&_net_132)) $display("assert (((dstx&_net_130)&_net_132)) line 610 at %d\n",$time);
if (((dstx&_net_130)&_net_131)) $display("assert (((dstx&_net_130)&_net_131)) line 611 at %d\n",$time);
if ((dsta&_net_129)) $display("assert ((dsta&_net_129)) line 601 at %d\n",$time);
if (((dbit&_net_128)&rdy)) $display("assert (((dbit&_net_128)&rdy)) line 590 at %d\n",$time);
if (((dora&_net_122)&_net_126)) $display("assert (((dora&_net_122)&_net_126)) line 572 at %d\n",$time);
if (((dora&_net_122)&_net_125)) $display("assert (((dora&_net_122)&_net_125)) line 573 at %d\n",$time);
if (((dora&_net_122)&_net_124)) $display("assert (((dora&_net_122)&_net_124)) line 574 at %d\n",$time);
if (((dora&_net_122)&_net_123)) $display("assert (((dora&_net_122)&_net_123)) line 575 at %d\n",$time);
if ((((ea&mzpxi)&_net_121)&rdy)) $display("assert ((((ea&mzpxi)&_net_121)&rdy)) line 453 at %d\n",$time);
if ((((ea&mzpxi)&_net_120)&rdy)) $display("assert ((((ea&mzpxi)&_net_120)&rdy)) line 461 at %d\n",$time);
if ((((ea&mzpiy)&_net_115)&rdy)) $display("assert ((((ea&mzpiy)&_net_115)&rdy)) line 507 at %d\n",$time);
if ((((ea&mzpiy)&_net_113)&rdy)) $display("assert ((((ea&mzpiy)&_net_113)&rdy)) line 516 at %d\n",$time);
if (((ea&mzpiy)&_net_112)) $display("assert (((ea&mzpiy)&_net_112)) line 524 at %d\n",$time);
if (((((ea&mzpx)&_net_108)&rdy)&_net_111)) $display("assert (((((ea&mzpx)&_net_108)&rdy)&_net_111)) line 533 at %d\n",$time);
if (((((ea&mzpx)&_net_108)&rdy)&_net_110)) $display("assert (((((ea&mzpx)&_net_108)&rdy)&_net_110)) line 534 at %d\n",$time);
if (((((ea&mzpx)&_net_108)&rdy)&_net_109)) $display("assert (((((ea&mzpx)&_net_108)&rdy)&_net_109)) line 535 at %d\n",$time);
if (((((ea&maby)&_net_103)&rdy)&_net_105)) $display("assert (((((ea&maby)&_net_103)&rdy)&_net_105)) line 551 at %d\n",$time);
if (((((ea&maby)&_net_103)&rdy)&_net_104)) $display("assert (((((ea&maby)&_net_103)&rdy)&_net_104)) line 552 at %d\n",$time);
if (((ea&maby)&_net_102)) $display("assert (((ea&maby)&_net_102)) line 561 at %d\n",$time);
if ((dmisc&_net_101)) $display("assert ((dmisc&_net_101)) line 369 at %d\n",$time);
if ((dmisc&_net_100)) $display("assert ((dmisc&_net_100)) line 374 at %d\n",$time);
if ((dmisc&_net_99)) $display("assert ((dmisc&_net_99)) line 379 at %d\n",$time);
if ((dmisc&_net_98)) $display("assert ((dmisc&_net_98)) line 384 at %d\n",$time);
if ((dmisc&_net_97)) $display("assert ((dmisc&_net_97)) line 388 at %d\n",$time);
if ((dmisc&_net_96)) $display("assert ((dmisc&_net_96)) line 393 at %d\n",$time);
if ((dmisc&_net_94)) $display("assert ((dmisc&_net_94)) line 399 at %d\n",$time);
if ((dmisc&_net_93)) $display("assert ((dmisc&_net_93)) line 404 at %d\n",$time);
if ((dmisc&_net_92)) $display("assert ((dmisc&_net_92)) line 409 at %d\n",$time);
if ((dmisc&_net_89)) $display("assert ((dmisc&_net_89)) line 416 at %d\n",$time);
if (((djmp&_net_79)&rdy)) $display("assert (((djmp&_net_79)&rdy)) line 342 at %d\n",$time);
if ((dplp&_net_68)) $display("assert ((dplp&_net_68)) line 239 at %d\n",$time);
if (((dplp&_net_65)&_net_66)) $display("assert (((dplp&_net_65)&_net_66)) line 248 at %d\n",$time);
if ((drti&_net_64)) $display("assert ((drti&_net_64)) line 204 at %d\n",$time);
if (((drti&_net_63)&rdy)) $display("assert (((drti&_net_63)&rdy)) line 212 at %d\n",$time);
if (((drti&_net_62)&rdy)) $display("assert (((drti&_net_62)&rdy)) line 221 at %d\n",$time);
if ((drts&_net_60)) $display("assert ((drts&_net_60)) line 172 at %d\n",$time);
if (((drts&_net_59)&rdy)) $display("assert (((drts&_net_59)&rdy)) line 179 at %d\n",$time);
if (((drts&_net_57)&rdy)) $display("assert (((drts&_net_57)&rdy)) line 188 at %d\n",$time);
if ((drts&_net_56)) $display("assert ((drts&_net_56)) line 197 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  _alu_in1 = 
// synthesis translate_off
// synopsys translate_off
((((((((((((((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)&(((dbc&_net_156)&taken)&rdy))|(((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))&(dbc&_net_155)))|((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))&(dbc&_net_154)))|(((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))&((ddec&_net_150)&_net_152)))|((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))&((ddec&_net_150)&_net_151)))|(((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))&((dasl&_net_145)&_net_149)))|((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))&((dasl&_net_145)&_net_148)))|(((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))&((dasl&_net_145)&_net_147)))|((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))&((dasl&_net_145)&_net_146)))|(((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))&(((dldx&_net_139)&rdy)&_net_141)))|((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))&(((dldx&_net_139)&rdy)&_net_140)))|(((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))&(((dcpx&_net_136)&rdy)&_net_138)))|((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))&(((dcpx&_net_136)&rdy)&_net_137)))|(((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))&((dcmp&_net_134)&rdy)))|((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))&((dlda&_net_133)&rdy)))|(((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))&((dstx&_net_130)&_net_132)))|((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))&((dstx&_net_130)&_net_131)))|(((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))&(dsta&_net_129)))|((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))&((dbit&_net_128)&rdy)))|(((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))&((dora&_net_122)&_net_126)))|((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))&((dora&_net_122)&_net_125)))|(((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))&((dora&_net_122)&_net_124)))|((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))&((dora&_net_122)&_net_123)))|(((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))&(((ea&mzpxi)&_net_121)&rdy)))|((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))&(((ea&mzpxi)&_net_120)&rdy)))|(((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))&(((ea&mzpiy)&_net_115)&rdy)))|((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))&(((ea&mzpiy)&_net_113)&rdy)))|(((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))&((ea&mzpiy)&_net_112)))|((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))&((((ea&mzpx)&_net_108)&rdy)&_net_111)))|(((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))&((((ea&mzpx)&_net_108)&rdy)&_net_110)))|((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))&((((ea&mzpx)&_net_108)&rdy)&_net_109)))|(((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))&((((ea&maby)&_net_103)&rdy)&_net_105)))|((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))&((((ea&maby)&_net_103)&rdy)&_net_104)))|(((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))&((ea&maby)&_net_102)))|((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))&(dmisc&_net_101)))|(((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))&(dmisc&_net_100)))|((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))&(dmisc&_net_99)))|(((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))&(dmisc&_net_98)))|((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))&(dmisc&_net_97)))|(((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))&(dmisc&_net_96)))|((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))&(dmisc&_net_94)))|(((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))&(dmisc&_net_93)))|((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))&(dmisc&_net_92)))|(((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))&(dmisc&_net_89)))|((((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))&((djmp&_net_79)&rdy)))|(((((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((djmp&_net_79)&rdy))&(dplp&_net_68)))|((((((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((djmp&_net_79)&rdy))|(dplp&_net_68))&((dplp&_net_65)&_net_66)))|(((((((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((djmp&_net_79)&rdy))|(dplp&_net_68))|((dplp&_net_65)&_net_66))&(drti&_net_64)))|((((((((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((djmp&_net_79)&rdy))|(dplp&_net_68))|((dplp&_net_65)&_net_66))|(drti&_net_64))&((drti&_net_63)&rdy)))|(((((((((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((djmp&_net_79)&rdy))|(dplp&_net_68))|((dplp&_net_65)&_net_66))|(drti&_net_64))|((drti&_net_63)&rdy))&((drti&_net_62)&rdy)))|((((((((((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((djmp&_net_79)&rdy))|(dplp&_net_68))|((dplp&_net_65)&_net_66))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))&(drts&_net_60)))|(((((((((((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((djmp&_net_79)&rdy))|(dplp&_net_68))|((dplp&_net_65)&_net_66))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))|(drts&_net_60))&((drts&_net_59)&rdy)))|((((((((((((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((djmp&_net_79)&rdy))|(dplp&_net_68))|((dplp&_net_65)&_net_66))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))|(drts&_net_60))|((drts&_net_59)&rdy))&((drts&_net_57)&rdy)))|(((((((((((((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((djmp&_net_79)&rdy))|(dplp&_net_68))|((dplp&_net_65)&_net_66))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))|(drts&_net_60))|((drts&_net_59)&rdy))|((drts&_net_57)&rdy))&(drts&_net_56))))? 8'bx :((((((((((((((((((((((((((((((((((((((((((((((((((((((((ift_run&_net_162)|(((dbc&_net_156)&taken)&rdy))|(dbc&_net_155))|(dbc&_net_154))|((ddec&_net_150)&_net_152))|((ddec&_net_150)&_net_151))|((dasl&_net_145)&_net_149))|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_147))|((dasl&_net_145)&_net_146))|(((dldx&_net_139)&rdy)&_net_141))|(((dldx&_net_139)&rdy)&_net_140))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dstx&_net_130)&_net_132))|((dstx&_net_130)&_net_131))|(dsta&_net_129))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_98))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((djmp&_net_79)&rdy))|(dplp&_net_68))|((dplp&_net_65)&_net_66))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))|(drts&_net_60))|((drts&_net_59)&rdy))|((drts&_net_57)&rdy))|(drts&_net_56)))? 
// synthesis translate_on
// synopsys translate_on
(((ift_run&_net_162))?dbi:8'b0)|
    (((((dbc&_net_156)&taken)&rdy))?PCL:8'b0)|
    (((dbc&_net_155))?PCH:8'b0)|
    (((dbc&_net_154))?PCH:8'b0)|
    ((((ddec&_net_150)&_net_152))?ALU1:8'b0)|
    ((((ddec&_net_150)&_net_151))?ALU1:8'b0)|
    ((((dasl&_net_145)&_net_149))?ALU1:8'b0)|
    ((((dasl&_net_145)&_net_148))?ALU1:8'b0)|
    ((((dasl&_net_145)&_net_147))?ALU1:8'b0)|
    ((((dasl&_net_145)&_net_146))?ALU1:8'b0)|
    (((((dldx&_net_139)&rdy)&_net_141))?dbi:8'b0)|
    (((((dldx&_net_139)&rdy)&_net_140))?dbi:8'b0)|
    (((((dcpx&_net_136)&rdy)&_net_138))?RX:8'b0)|
    (((((dcpx&_net_136)&rdy)&_net_137))?RY:8'b0)|
    ((((dcmp&_net_134)&rdy))?RA:8'b0)|
    ((((dlda&_net_133)&rdy))?dbi:8'b0)|
    ((((dstx&_net_130)&_net_132))?RX:8'b0)|
    ((((dstx&_net_130)&_net_131))?RY:8'b0)|
    (((dsta&_net_129))?RA:8'b0)|
    ((((dbit&_net_128)&rdy))?RA:8'b0)|
    ((((dora&_net_122)&_net_126))?RA:8'b0)|
    ((((dora&_net_122)&_net_125))?RA:8'b0)|
    ((((dora&_net_122)&_net_124))?RA:8'b0)|
    ((((dora&_net_122)&_net_123))?RA:8'b0)|
    (((((ea&mzpxi)&_net_121)&rdy))?RX:8'b0)|
    (((((ea&mzpxi)&_net_120)&rdy))?RX:8'b0)|
    (((((ea&mzpiy)&_net_115)&rdy))?DL:8'b0)|
    (((((ea&mzpiy)&_net_113)&rdy))?RY:8'b0)|
    ((((ea&mzpiy)&_net_112))?DL:8'b0)|
    ((((((ea&mzpx)&_net_108)&rdy)&_net_111))?RX:8'b0)|
    ((((((ea&mzpx)&_net_108)&rdy)&_net_110))?RY:8'b0)|
    ((((((ea&mzpx)&_net_108)&rdy)&_net_109))?dbi:8'b0)|
    ((((((ea&maby)&_net_103)&rdy)&_net_105))?RY:8'b0)|
    ((((((ea&maby)&_net_103)&rdy)&_net_104))?RX:8'b0)|
    ((((ea&maby)&_net_102))?DL:8'b0)|
    (((dmisc&_net_101))?RY:8'b0)|
    (((dmisc&_net_100))?RX:8'b0)|
    (((dmisc&_net_99))?RY:8'b0)|
    (((dmisc&_net_98))?RX:8'b0)|
    (((dmisc&_net_97))?RA:8'b0)|
    (((dmisc&_net_96))?RA:8'b0)|
    (((dmisc&_net_94))?RS:8'b0)|
    (((dmisc&_net_93))?RY:8'b0)|
    (((dmisc&_net_92))?RX:8'b0)|
    (((dmisc&_net_89))?RX:8'b0)|
    ((((djmp&_net_79)&rdy))?rABL:8'b0)|
    (((dplp&_net_68))?RS:8'b0)|
    ((((dplp&_net_65)&_net_66))?dbi:8'b0)|
    (((drti&_net_64))?RS:8'b0)|
    ((((drti&_net_63)&rdy))?RS:8'b0)|
    ((((drti&_net_62)&rdy))?RS:8'b0)|
    (((drts&_net_60))?RS:8'b0)|
    ((((drts&_net_59)&rdy))?RS:8'b0)|
    ((((drts&_net_57)&rdy))?DL:8'b0)|
    (((drts&_net_56))?DL:8'b0)
// synthesis translate_off
// synopsys translate_off
:8'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((((((((((((((((((((((_net_170&_net_169)|((_net_170|_net_169)&_net_168))|(((_net_170|_net_169)|_net_168)&(((dbc&_net_156)&taken)&rdy)))|((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))&(((dcpx&_net_136)&rdy)&_net_138)))|(((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))&(((dcpx&_net_136)&rdy)&_net_137)))|((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))&((dcmp&_net_134)&rdy)))|(((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))&((dbit&_net_128)&rdy)))|((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))&((dora&_net_122)&_net_126)))|(((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))&((dora&_net_122)&_net_125)))|((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))&((dora&_net_122)&_net_124)))|(((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))&((dora&_net_122)&_net_123)))|((((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))&(((ea&mzpxi)&_net_121)&rdy)))|(((((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))&(((ea&mzpxi)&_net_120)&rdy)))|((((((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))&(((ea&mzpiy)&_net_113)&rdy)))|(((((((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))&((((ea&mzpx)&_net_108)&rdy)&_net_111)))|((((((((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))&((((ea&mzpx)&_net_108)&rdy)&_net_110)))|(((((((((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))&((((ea&maby)&_net_103)&rdy)&_net_105)))|((((((((((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&maby)&_net_103)&rdy)&_net_105))&((((ea&maby)&_net_103)&rdy)&_net_104)))|(((((((((((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))&((djsr&_net_77)&rdy)))|((((((((((((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((djsr&_net_77)&rdy))&(djsr&_net_75)))|(((((((((((((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((djsr&_net_77)&rdy))|(djsr&_net_75))&(dphp&_net_72))))
 begin $display("Warning: assign collision(m65s:_alu_in2) at %d",$time);
if (_net_170) $display("assert (_net_170) line 816 at %d\n",$time);
if (_net_169) $display("assert (_net_169) line 809 at %d\n",$time);
if (_net_168) $display("assert (_net_168) line 802 at %d\n",$time);
if ((((dbc&_net_156)&taken)&rdy)) $display("assert ((((dbc&_net_156)&taken)&rdy)) line 739 at %d\n",$time);
if ((((dcpx&_net_136)&rdy)&_net_138)) $display("assert ((((dcpx&_net_136)&rdy)&_net_138)) line 651 at %d\n",$time);
if ((((dcpx&_net_136)&rdy)&_net_137)) $display("assert ((((dcpx&_net_136)&rdy)&_net_137)) line 652 at %d\n",$time);
if (((dcmp&_net_134)&rdy)) $display("assert (((dcmp&_net_134)&rdy)) line 634 at %d\n",$time);
if (((dbit&_net_128)&rdy)) $display("assert (((dbit&_net_128)&rdy)) line 590 at %d\n",$time);
if (((dora&_net_122)&_net_126)) $display("assert (((dora&_net_122)&_net_126)) line 572 at %d\n",$time);
if (((dora&_net_122)&_net_125)) $display("assert (((dora&_net_122)&_net_125)) line 573 at %d\n",$time);
if (((dora&_net_122)&_net_124)) $display("assert (((dora&_net_122)&_net_124)) line 574 at %d\n",$time);
if (((dora&_net_122)&_net_123)) $display("assert (((dora&_net_122)&_net_123)) line 575 at %d\n",$time);
if ((((ea&mzpxi)&_net_121)&rdy)) $display("assert ((((ea&mzpxi)&_net_121)&rdy)) line 453 at %d\n",$time);
if ((((ea&mzpxi)&_net_120)&rdy)) $display("assert ((((ea&mzpxi)&_net_120)&rdy)) line 461 at %d\n",$time);
if ((((ea&mzpiy)&_net_113)&rdy)) $display("assert ((((ea&mzpiy)&_net_113)&rdy)) line 516 at %d\n",$time);
if (((((ea&mzpx)&_net_108)&rdy)&_net_111)) $display("assert (((((ea&mzpx)&_net_108)&rdy)&_net_111)) line 533 at %d\n",$time);
if (((((ea&mzpx)&_net_108)&rdy)&_net_110)) $display("assert (((((ea&mzpx)&_net_108)&rdy)&_net_110)) line 534 at %d\n",$time);
if (((((ea&maby)&_net_103)&rdy)&_net_105)) $display("assert (((((ea&maby)&_net_103)&rdy)&_net_105)) line 551 at %d\n",$time);
if (((((ea&maby)&_net_103)&rdy)&_net_104)) $display("assert (((((ea&maby)&_net_103)&rdy)&_net_104)) line 552 at %d\n",$time);
if (((djsr&_net_77)&rdy)) $display("assert (((djsr&_net_77)&rdy)) line 276 at %d\n",$time);
if ((djsr&_net_75)) $display("assert ((djsr&_net_75)) line 292 at %d\n",$time);
if ((dphp&_net_72)) $display("assert ((dphp&_net_72)) line 257 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  _alu_in2 = 
// synthesis translate_off
// synopsys translate_off
((((((((((((((((((((((_net_170&_net_169)|((_net_170|_net_169)&_net_168))|(((_net_170|_net_169)|_net_168)&(((dbc&_net_156)&taken)&rdy)))|((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))&(((dcpx&_net_136)&rdy)&_net_138)))|(((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))&(((dcpx&_net_136)&rdy)&_net_137)))|((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))&((dcmp&_net_134)&rdy)))|(((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))&((dbit&_net_128)&rdy)))|((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))&((dora&_net_122)&_net_126)))|(((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))&((dora&_net_122)&_net_125)))|((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))&((dora&_net_122)&_net_124)))|(((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))&((dora&_net_122)&_net_123)))|((((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))&(((ea&mzpxi)&_net_121)&rdy)))|(((((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))&(((ea&mzpxi)&_net_120)&rdy)))|((((((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))&(((ea&mzpiy)&_net_113)&rdy)))|(((((((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))&((((ea&mzpx)&_net_108)&rdy)&_net_111)))|((((((((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))&((((ea&mzpx)&_net_108)&rdy)&_net_110)))|(((((((((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))&((((ea&maby)&_net_103)&rdy)&_net_105)))|((((((((((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&maby)&_net_103)&rdy)&_net_105))&((((ea&maby)&_net_103)&rdy)&_net_104)))|(((((((((((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))&((djsr&_net_77)&rdy)))|((((((((((((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((djsr&_net_77)&rdy))&(djsr&_net_75)))|(((((((((((((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((djsr&_net_77)&rdy))|(djsr&_net_75))&(dphp&_net_72))))? 8'bx :((((((((((((((((((((((_net_170|_net_169)|_net_168)|(((dbc&_net_156)&taken)&rdy))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&_net_126))|((dora&_net_122)&_net_125))|((dora&_net_122)&_net_124))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((djsr&_net_77)&rdy))|(djsr&_net_75))|(dphp&_net_72)))? 
// synthesis translate_on
// synopsys translate_on
((_net_170)?RS:8'b0)|
    ((_net_169)?RS:8'b0)|
    ((_net_168)?RS:8'b0)|
    (((((dbc&_net_156)&taken)&rdy))?dbi:8'b0)|
    (((((dcpx&_net_136)&rdy)&_net_138))?dbi:8'b0)|
    (((((dcpx&_net_136)&rdy)&_net_137))?dbi:8'b0)|
    ((((dcmp&_net_134)&rdy))?dbi:8'b0)|
    ((((dbit&_net_128)&rdy))?dbi:8'b0)|
    ((((dora&_net_122)&_net_126))?dbi:8'b0)|
    ((((dora&_net_122)&_net_125))?dbi:8'b0)|
    ((((dora&_net_122)&_net_124))?dbi:8'b0)|
    ((((dora&_net_122)&_net_123))?dbi:8'b0)|
    (((((ea&mzpxi)&_net_121)&rdy))?dbi:8'b0)|
    (((((ea&mzpxi)&_net_120)&rdy))?DL:8'b0)|
    (((((ea&mzpiy)&_net_113)&rdy))?DL:8'b0)|
    ((((((ea&mzpx)&_net_108)&rdy)&_net_111))?dbi:8'b0)|
    ((((((ea&mzpx)&_net_108)&rdy)&_net_110))?dbi:8'b0)|
    ((((((ea&maby)&_net_103)&rdy)&_net_105))?DL:8'b0)|
    ((((((ea&maby)&_net_103)&rdy)&_net_104))?DL:8'b0)|
    ((((djsr&_net_77)&rdy))?RS:8'b0)|
    (((djsr&_net_75))?RS:8'b0)|
    (((dphp&_net_72))?RS:8'b0)
// synthesis translate_off
// synopsys translate_off
:8'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((((((((((((((((((dbc&_net_156)&taken)&rdy)&((dasl&_net_145)&_net_148))|(((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))&((dasl&_net_145)&_net_146)))|((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))&(((dcpx&_net_136)&rdy)&_net_138)))|(((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))|(((dcpx&_net_136)&rdy)&_net_138))&(((dcpx&_net_136)&rdy)&_net_137)))|((((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))&((dcmp&_net_134)&rdy)))|(((((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))&((dora&_net_122)&_net_123)))|((((((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dora&_net_122)&_net_123))&(((ea&mzpxi)&_net_121)&rdy)))|(((((((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))&(((ea&mzpxi)&_net_120)&rdy)))|((((((((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))&(((ea&mzpiy)&_net_113)&rdy)))|(((((((((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))&((((ea&mzpx)&_net_108)&rdy)&_net_111)))|((((((((((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))&((((ea&mzpx)&_net_108)&rdy)&_net_110)))|(((((((((((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))&((((ea&maby)&_net_103)&rdy)&_net_105)))|((((((((((((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&maby)&_net_103)&rdy)&_net_105))&((((ea&maby)&_net_103)&rdy)&_net_104)))|(((((((((((((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))&((ea&maby)&_net_102))))
 begin $display("Warning: assign collision(m65s:_alu_ci) at %d",$time);
if ((((dbc&_net_156)&taken)&rdy)) $display("assert ((((dbc&_net_156)&taken)&rdy)) line 739 at %d\n",$time);
if (((dasl&_net_145)&_net_148)) $display("assert (((dasl&_net_145)&_net_148)) line 701 at %d\n",$time);
if (((dasl&_net_145)&_net_146)) $display("assert (((dasl&_net_145)&_net_146)) line 703 at %d\n",$time);
if ((((dcpx&_net_136)&rdy)&_net_138)) $display("assert ((((dcpx&_net_136)&rdy)&_net_138)) line 651 at %d\n",$time);
if ((((dcpx&_net_136)&rdy)&_net_137)) $display("assert ((((dcpx&_net_136)&rdy)&_net_137)) line 652 at %d\n",$time);
if (((dcmp&_net_134)&rdy)) $display("assert (((dcmp&_net_134)&rdy)) line 634 at %d\n",$time);
if (((dora&_net_122)&_net_123)) $display("assert (((dora&_net_122)&_net_123)) line 575 at %d\n",$time);
if ((((ea&mzpxi)&_net_121)&rdy)) $display("assert ((((ea&mzpxi)&_net_121)&rdy)) line 453 at %d\n",$time);
if ((((ea&mzpxi)&_net_120)&rdy)) $display("assert ((((ea&mzpxi)&_net_120)&rdy)) line 461 at %d\n",$time);
if ((((ea&mzpiy)&_net_113)&rdy)) $display("assert ((((ea&mzpiy)&_net_113)&rdy)) line 516 at %d\n",$time);
if (((((ea&mzpx)&_net_108)&rdy)&_net_111)) $display("assert (((((ea&mzpx)&_net_108)&rdy)&_net_111)) line 533 at %d\n",$time);
if (((((ea&mzpx)&_net_108)&rdy)&_net_110)) $display("assert (((((ea&mzpx)&_net_108)&rdy)&_net_110)) line 534 at %d\n",$time);
if (((((ea&maby)&_net_103)&rdy)&_net_105)) $display("assert (((((ea&maby)&_net_103)&rdy)&_net_105)) line 551 at %d\n",$time);
if (((((ea&maby)&_net_103)&rdy)&_net_104)) $display("assert (((((ea&maby)&_net_103)&rdy)&_net_104)) line 552 at %d\n",$time);
if (((ea&maby)&_net_102)) $display("assert (((ea&maby)&_net_102)) line 561 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  _alu_ci = 
// synthesis translate_off
// synopsys translate_off
((((((((((((((((((dbc&_net_156)&taken)&rdy)&((dasl&_net_145)&_net_148))|(((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))&((dasl&_net_145)&_net_146)))|((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))&(((dcpx&_net_136)&rdy)&_net_138)))|(((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))|(((dcpx&_net_136)&rdy)&_net_138))&(((dcpx&_net_136)&rdy)&_net_137)))|((((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))&((dcmp&_net_134)&rdy)))|(((((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))&((dora&_net_122)&_net_123)))|((((((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dora&_net_122)&_net_123))&(((ea&mzpxi)&_net_121)&rdy)))|(((((((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))&(((ea&mzpxi)&_net_120)&rdy)))|((((((((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))&(((ea&mzpiy)&_net_113)&rdy)))|(((((((((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))&((((ea&mzpx)&_net_108)&rdy)&_net_111)))|((((((((((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))&((((ea&mzpx)&_net_108)&rdy)&_net_110)))|(((((((((((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))&((((ea&maby)&_net_103)&rdy)&_net_105)))|((((((((((((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&maby)&_net_103)&rdy)&_net_105))&((((ea&maby)&_net_103)&rdy)&_net_104)))|(((((((((((((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))&((ea&maby)&_net_102))))? 1'bx :((((((((((((((((((dbc&_net_156)&taken)&rdy)|((dasl&_net_145)&_net_148))|((dasl&_net_145)&_net_146))|(((dcpx&_net_136)&rdy)&_net_138))|(((dcpx&_net_136)&rdy)&_net_137))|((dcmp&_net_134)&rdy))|((dora&_net_122)&_net_123))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|((ea&maby)&_net_102)))? 
// synthesis translate_on
// synopsys translate_on
(((dbc&_net_156)&taken)&rdy)|
    ((((dasl&_net_145)&_net_148))?fc:1'b0)|
    ((((dasl&_net_145)&_net_146))?fc:1'b0)|
    (((((dcpx&_net_136)&rdy)&_net_138))?1'b1:1'b0)|
    (((((dcpx&_net_136)&rdy)&_net_137))?1'b1:1'b0)|
    ((((dcmp&_net_134)&rdy))?((~(opc[5]))|fc):1'b0)|
    ((((dora&_net_122)&_net_123))?((fc|dcmp)|dcpx):1'b0)|
    (((((ea&mzpxi)&_net_121)&rdy))?1'b0:1'b0)|
    (((((ea&mzpxi)&_net_120)&rdy))?1'b1:1'b0)|
    (((((ea&mzpiy)&_net_113)&rdy))?1'b0:1'b0)|
    ((((((ea&mzpx)&_net_108)&rdy)&_net_111))?1'b0:1'b0)|
    ((((((ea&mzpx)&_net_108)&rdy)&_net_110))?1'b0:1'b0)|
    ((((((ea&maby)&_net_103)&rdy)&_net_105))?1'b0:1'b0)|
    ((((((ea&maby)&_net_103)&rdy)&_net_104))?1'b0:1'b0)|
    ((((ea&maby)&_net_102))?tc:1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge _alu_df)
  begin
#1 if (_alu_df===1'bx)
 begin
$display("Warning: control hazard(m65s:_alu_df) at %d",$time);
 end
#1 if (((((((dcmp&_net_134)&rdy)&_net_135)&fd))===1'bx) || (1'b1)===1'bx) $display("hazard (((((dcmp&_net_134)&rdy)&_net_135)&fd) || 1'b1) line 638 at %d\n",$time);
#1 if (((((dora&_net_122)&fd))===1'bx) || (1'b1)===1'bx) $display("hazard (((dora&_net_122)&fd) || 1'b1) line 569 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _alu_df = ((((dcmp&_net_134)&rdy)&_net_135)&fd)|
    ((dora&_net_122)&fd);

// synthesis translate_off
// synopsys translate_off
always @(posedge _alu_adc)
  begin
#1 if (_alu_adc===1'bx)
 begin
$display("Warning: control hazard(m65s:_alu_adc) at %d",$time);
 end
#1 if ((((((dbc&_net_156)&taken)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard ((((dbc&_net_156)&taken)&rdy) || 1'b1) line 739 at %d\n",$time);
#1 if (((((dora&_net_122)&_net_123))===1'bx) || (1'b1)===1'bx) $display("hazard (((dora&_net_122)&_net_123) || 1'b1) line 575 at %d\n",$time);
#1 if ((((((ea&mzpxi)&_net_121)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard ((((ea&mzpxi)&_net_121)&rdy) || 1'b1) line 453 at %d\n",$time);
#1 if ((((((ea&mzpxi)&_net_120)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard ((((ea&mzpxi)&_net_120)&rdy) || 1'b1) line 461 at %d\n",$time);
#1 if ((((((ea&mzpiy)&_net_113)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard ((((ea&mzpiy)&_net_113)&rdy) || 1'b1) line 516 at %d\n",$time);
#1 if (((((((ea&mzpx)&_net_108)&rdy)&_net_111))===1'bx) || (1'b1)===1'bx) $display("hazard (((((ea&mzpx)&_net_108)&rdy)&_net_111) || 1'b1) line 533 at %d\n",$time);
#1 if (((((((ea&mzpx)&_net_108)&rdy)&_net_110))===1'bx) || (1'b1)===1'bx) $display("hazard (((((ea&mzpx)&_net_108)&rdy)&_net_110) || 1'b1) line 534 at %d\n",$time);
#1 if (((((((ea&maby)&_net_103)&rdy)&_net_105))===1'bx) || (1'b1)===1'bx) $display("hazard (((((ea&maby)&_net_103)&rdy)&_net_105) || 1'b1) line 551 at %d\n",$time);
#1 if (((((((ea&maby)&_net_103)&rdy)&_net_104))===1'bx) || (1'b1)===1'bx) $display("hazard (((((ea&maby)&_net_103)&rdy)&_net_104) || 1'b1) line 552 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _alu_adc = (((dbc&_net_156)&taken)&rdy)|
    ((dora&_net_122)&_net_123)|
    (((ea&mzpxi)&_net_121)&rdy)|
    (((ea&mzpxi)&_net_120)&rdy)|
    (((ea&mzpiy)&_net_113)&rdy)|
    ((((ea&mzpx)&_net_108)&rdy)&_net_111)|
    ((((ea&mzpx)&_net_108)&rdy)&_net_110)|
    ((((ea&maby)&_net_103)&rdy)&_net_105)|
    ((((ea&maby)&_net_103)&rdy)&_net_104);

// synthesis translate_off
// synopsys translate_off
always @(posedge _alu_sbc)
  begin
#1 if (_alu_sbc===1'bx)
 begin
$display("Warning: control hazard(m65s:_alu_sbc) at %d",$time);
 end
#1 if ((((((dcpx&_net_136)&rdy)&_net_138))===1'bx) || (1'b1)===1'bx) $display("hazard ((((dcpx&_net_136)&rdy)&_net_138) || 1'b1) line 651 at %d\n",$time);
#1 if ((((((dcpx&_net_136)&rdy)&_net_137))===1'bx) || (1'b1)===1'bx) $display("hazard ((((dcpx&_net_136)&rdy)&_net_137) || 1'b1) line 652 at %d\n",$time);
#1 if (((((dcmp&_net_134)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((dcmp&_net_134)&rdy) || 1'b1) line 634 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _alu_sbc = (((dcpx&_net_136)&rdy)&_net_138)|
    (((dcpx&_net_136)&rdy)&_net_137)|
    ((dcmp&_net_134)&rdy);

// synthesis translate_off
// synopsys translate_off
always @(posedge _alu_do_and)
  begin
#1 if (_alu_do_and===1'bx)
 begin
$display("Warning: control hazard(m65s:_alu_do_and) at %d",$time);
 end
#1 if (((((dora&_net_122)&_net_125))===1'bx) || (1'b1)===1'bx) $display("hazard (((dora&_net_122)&_net_125) || 1'b1) line 573 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _alu_do_and = ((dora&_net_122)&_net_125);

// synthesis translate_off
// synopsys translate_off
always @(posedge _alu_bita)
  begin
#1 if (_alu_bita===1'bx)
 begin
$display("Warning: control hazard(m65s:_alu_bita) at %d",$time);
 end
#1 if (((((dbit&_net_128)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((dbit&_net_128)&rdy) || 1'b1) line 590 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _alu_bita = ((dbit&_net_128)&rdy);

// synthesis translate_off
// synopsys translate_off
always @(posedge _alu_do_or)
  begin
#1 if (_alu_do_or===1'bx)
 begin
$display("Warning: control hazard(m65s:_alu_do_or) at %d",$time);
 end
#1 if (((((dora&_net_122)&_net_126))===1'bx) || (1'b1)===1'bx) $display("hazard (((dora&_net_122)&_net_126) || 1'b1) line 572 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _alu_do_or = ((dora&_net_122)&_net_126);

// synthesis translate_off
// synopsys translate_off
always @(posedge _alu_eor)
  begin
#1 if (_alu_eor===1'bx)
 begin
$display("Warning: control hazard(m65s:_alu_eor) at %d",$time);
 end
#1 if (((((dora&_net_122)&_net_124))===1'bx) || (1'b1)===1'bx) $display("hazard (((dora&_net_122)&_net_124) || 1'b1) line 574 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _alu_eor = ((dora&_net_122)&_net_124);

// synthesis translate_off
// synopsys translate_off
always @(posedge _alu_inc)
  begin
#1 if (_alu_inc===1'bx)
 begin
$display("Warning: control hazard(m65s:_alu_inc) at %d",$time);
 end
#1 if ((((dbc&_net_155))===1'bx) || (1'b1)===1'bx) $display("hazard ((dbc&_net_155) || 1'b1) line 755 at %d\n",$time);
#1 if (((((ddec&_net_150)&_net_151))===1'bx) || (1'b1)===1'bx) $display("hazard (((ddec&_net_150)&_net_151) || 1'b1) line 716 at %d\n",$time);
#1 if ((((((ea&mzpiy)&_net_115)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard ((((ea&mzpiy)&_net_115)&rdy) || 1'b1) line 507 at %d\n",$time);
#1 if (((((ea&mzpiy)&_net_112))===1'bx) || (1'b1)===1'bx) $display("hazard (((ea&mzpiy)&_net_112) || 1'b1) line 524 at %d\n",$time);
#1 if ((((dmisc&_net_93))===1'bx) || (1'b1)===1'bx) $display("hazard ((dmisc&_net_93) || 1'b1) line 404 at %d\n",$time);
#1 if ((((dmisc&_net_89))===1'bx) || (1'b1)===1'bx) $display("hazard ((dmisc&_net_89) || 1'b1) line 416 at %d\n",$time);
#1 if (((((djmp&_net_79)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((djmp&_net_79)&rdy) || 1'b1) line 342 at %d\n",$time);
#1 if ((((dplp&_net_68))===1'bx) || (1'b1)===1'bx) $display("hazard ((dplp&_net_68) || 1'b1) line 239 at %d\n",$time);
#1 if ((((drti&_net_64))===1'bx) || (1'b1)===1'bx) $display("hazard ((drti&_net_64) || 1'b1) line 204 at %d\n",$time);
#1 if (((((drti&_net_63)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((drti&_net_63)&rdy) || 1'b1) line 212 at %d\n",$time);
#1 if (((((drti&_net_62)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((drti&_net_62)&rdy) || 1'b1) line 221 at %d\n",$time);
#1 if ((((drts&_net_60))===1'bx) || (1'b1)===1'bx) $display("hazard ((drts&_net_60) || 1'b1) line 172 at %d\n",$time);
#1 if (((((drts&_net_59)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((drts&_net_59)&rdy) || 1'b1) line 179 at %d\n",$time);
#1 if (((((drts&_net_57)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((drts&_net_57)&rdy) || 1'b1) line 188 at %d\n",$time);
#1 if ((((drts&_net_56))===1'bx) || (1'b1)===1'bx) $display("hazard ((drts&_net_56) || 1'b1) line 197 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _alu_inc = (dbc&_net_155)|
    ((ddec&_net_150)&_net_151)|
    (((ea&mzpiy)&_net_115)&rdy)|
    ((ea&mzpiy)&_net_112)|
    (dmisc&_net_93)|
    (dmisc&_net_89)|
    ((djmp&_net_79)&rdy)|
    (dplp&_net_68)|
    (drti&_net_64)|
    ((drti&_net_63)&rdy)|
    ((drti&_net_62)&rdy)|
    (drts&_net_60)|
    ((drts&_net_59)&rdy)|
    ((drts&_net_57)&rdy)|
    (drts&_net_56);

// synthesis translate_off
// synopsys translate_off
always @(posedge _alu_dec)
  begin
#1 if (_alu_dec===1'bx)
 begin
$display("Warning: control hazard(m65s:_alu_dec) at %d",$time);
 end
#1 if ((((dbc&_net_154))===1'bx) || (1'b1)===1'bx) $display("hazard ((dbc&_net_154) || 1'b1) line 760 at %d\n",$time);
#1 if (((((ddec&_net_150)&_net_152))===1'bx) || (1'b1)===1'bx) $display("hazard (((ddec&_net_150)&_net_152) || 1'b1) line 715 at %d\n",$time);
#1 if ((((dmisc&_net_101))===1'bx) || (1'b1)===1'bx) $display("hazard ((dmisc&_net_101) || 1'b1) line 369 at %d\n",$time);
#1 if ((((dmisc&_net_92))===1'bx) || (1'b1)===1'bx) $display("hazard ((dmisc&_net_92) || 1'b1) line 409 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _alu_dec = (dbc&_net_154)|
    ((ddec&_net_150)&_net_152)|
    (dmisc&_net_101)|
    (dmisc&_net_92);

// synthesis translate_off
// synopsys translate_off
always @(posedge _alu_dec2)
  begin
#1 if (_alu_dec2===1'bx)
 begin
$display("Warning: control hazard(m65s:_alu_dec2) at %d",$time);
 end
#1 if (((_net_170)===1'bx) || (1'b1)===1'bx) $display("hazard (_net_170 || 1'b1) line 816 at %d\n",$time);
#1 if (((_net_169)===1'bx) || (1'b1)===1'bx) $display("hazard (_net_169 || 1'b1) line 809 at %d\n",$time);
#1 if (((_net_168)===1'bx) || (1'b1)===1'bx) $display("hazard (_net_168 || 1'b1) line 802 at %d\n",$time);
#1 if (((((djsr&_net_77)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((djsr&_net_77)&rdy) || 1'b1) line 276 at %d\n",$time);
#1 if ((((djsr&_net_75))===1'bx) || (1'b1)===1'bx) $display("hazard ((djsr&_net_75) || 1'b1) line 292 at %d\n",$time);
#1 if ((((dphp&_net_72))===1'bx) || (1'b1)===1'bx) $display("hazard ((dphp&_net_72) || 1'b1) line 257 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _alu_dec2 = _net_170|
    _net_169|
    _net_168|
    ((djsr&_net_77)&rdy)|
    (djsr&_net_75)|
    (dphp&_net_72);

// synthesis translate_off
// synopsys translate_off
always @(posedge _alu_incc)
  begin
#1 if (_alu_incc===1'bx)
 begin
$display("Warning: control hazard(m65s:_alu_incc) at %d",$time);
 end
#1 if (((((ea&maby)&_net_102))===1'bx) || (1'b1)===1'bx) $display("hazard (((ea&maby)&_net_102) || 1'b1) line 561 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _alu_incc = ((ea&maby)&_net_102);

// synthesis translate_off
// synopsys translate_off
always @(posedge _alu_asl)
  begin
#1 if (_alu_asl===1'bx)
 begin
$display("Warning: control hazard(m65s:_alu_asl) at %d",$time);
 end
#1 if (((((dasl&_net_145)&_net_149))===1'bx) || (1'b1)===1'bx) $display("hazard (((dasl&_net_145)&_net_149) || 1'b1) line 700 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _alu_asl = ((dasl&_net_145)&_net_149);

// synthesis translate_off
// synopsys translate_off
always @(posedge _alu_lsr)
  begin
#1 if (_alu_lsr===1'bx)
 begin
$display("Warning: control hazard(m65s:_alu_lsr) at %d",$time);
 end
#1 if (((((dasl&_net_145)&_net_147))===1'bx) || (1'b1)===1'bx) $display("hazard (((dasl&_net_145)&_net_147) || 1'b1) line 702 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _alu_lsr = ((dasl&_net_145)&_net_147);

// synthesis translate_off
// synopsys translate_off
always @(posedge _alu_ror)
  begin
#1 if (_alu_ror===1'bx)
 begin
$display("Warning: control hazard(m65s:_alu_ror) at %d",$time);
 end
#1 if (((((dasl&_net_145)&_net_146))===1'bx) || (1'b1)===1'bx) $display("hazard (((dasl&_net_145)&_net_146) || 1'b1) line 703 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _alu_ror = ((dasl&_net_145)&_net_146);

// synthesis translate_off
// synopsys translate_off
always @(posedge _alu_rol)
  begin
#1 if (_alu_rol===1'bx)
 begin
$display("Warning: control hazard(m65s:_alu_rol) at %d",$time);
 end
#1 if (((((dasl&_net_145)&_net_148))===1'bx) || (1'b1)===1'bx) $display("hazard (((dasl&_net_145)&_net_148) || 1'b1) line 701 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _alu_rol = ((dasl&_net_145)&_net_148);

// synthesis translate_off
// synopsys translate_off
always @(posedge _alu_thr)
  begin
#1 if (_alu_thr===1'bx)
 begin
$display("Warning: control hazard(m65s:_alu_thr) at %d",$time);
 end
#1 if ((((ift_run&_net_162))===1'bx) || (1'b1)===1'bx) $display("hazard ((ift_run&_net_162) || 1'b1) line 773 at %d\n",$time);
#1 if ((((((dldx&_net_139)&rdy)&_net_141))===1'bx) || (1'b1)===1'bx) $display("hazard ((((dldx&_net_139)&rdy)&_net_141) || 1'b1) line 667 at %d\n",$time);
#1 if ((((((dldx&_net_139)&rdy)&_net_140))===1'bx) || (1'b1)===1'bx) $display("hazard ((((dldx&_net_139)&rdy)&_net_140) || 1'b1) line 668 at %d\n",$time);
#1 if (((((dlda&_net_133)&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard (((dlda&_net_133)&rdy) || 1'b1) line 624 at %d\n",$time);
#1 if (((((dstx&_net_130)&_net_132))===1'bx) || (1'b1)===1'bx) $display("hazard (((dstx&_net_130)&_net_132) || 1'b1) line 610 at %d\n",$time);
#1 if (((((dstx&_net_130)&_net_131))===1'bx) || (1'b1)===1'bx) $display("hazard (((dstx&_net_130)&_net_131) || 1'b1) line 611 at %d\n",$time);
#1 if ((((dsta&_net_129))===1'bx) || (1'b1)===1'bx) $display("hazard ((dsta&_net_129) || 1'b1) line 601 at %d\n",$time);
#1 if (((((((ea&mzpx)&_net_108)&rdy)&_net_109))===1'bx) || (1'b1)===1'bx) $display("hazard (((((ea&mzpx)&_net_108)&rdy)&_net_109) || 1'b1) line 535 at %d\n",$time);
#1 if ((((dmisc&_net_100))===1'bx) || (1'b1)===1'bx) $display("hazard ((dmisc&_net_100) || 1'b1) line 374 at %d\n",$time);
#1 if ((((dmisc&_net_99))===1'bx) || (1'b1)===1'bx) $display("hazard ((dmisc&_net_99) || 1'b1) line 379 at %d\n",$time);
#1 if ((((dmisc&_net_98))===1'bx) || (1'b1)===1'bx) $display("hazard ((dmisc&_net_98) || 1'b1) line 384 at %d\n",$time);
#1 if ((((dmisc&_net_97))===1'bx) || (1'b1)===1'bx) $display("hazard ((dmisc&_net_97) || 1'b1) line 388 at %d\n",$time);
#1 if ((((dmisc&_net_96))===1'bx) || (1'b1)===1'bx) $display("hazard ((dmisc&_net_96) || 1'b1) line 393 at %d\n",$time);
#1 if ((((dmisc&_net_94))===1'bx) || (1'b1)===1'bx) $display("hazard ((dmisc&_net_94) || 1'b1) line 399 at %d\n",$time);
#1 if (((((dplp&_net_65)&_net_66))===1'bx) || (1'b1)===1'bx) $display("hazard (((dplp&_net_65)&_net_66) || 1'b1) line 248 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _alu_thr = (ift_run&_net_162)|
    (((dldx&_net_139)&rdy)&_net_141)|
    (((dldx&_net_139)&rdy)&_net_140)|
    ((dlda&_net_133)&rdy)|
    ((dstx&_net_130)&_net_132)|
    ((dstx&_net_130)&_net_131)|
    (dsta&_net_129)|
    ((((ea&mzpx)&_net_108)&rdy)&_net_109)|
    (dmisc&_net_100)|
    (dmisc&_net_99)|
    (dmisc&_net_98)|
    (dmisc&_net_97)|
    (dmisc&_net_96)|
    (dmisc&_net_94)|
    ((dplp&_net_65)&_net_66);
   assign  _alu_p_reset = p_reset;
   assign  _alu_m_clock = m_clock;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((((nif2&nif1)|((nif2|nif1)&nif0))|(((nif2|nif1)|nif0)&(djsr&_net_76))))
 begin $display("Warning: assign collision(m65s:_incr_in) at %d",$time);
if (nif2) $display("assert (nif2) line 438 at %d\n",$time);
if (nif1) $display("assert (nif1) line 431 at %d\n",$time);
if (nif0) $display("assert (nif0) line 427 at %d\n",$time);
if ((djsr&_net_76)) $display("assert ((djsr&_net_76)) line 286 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  _incr_in = 
// synthesis translate_off
// synopsys translate_off
((((nif2&nif1)|((nif2|nif1)&nif0))|(((nif2|nif1)|nif0)&(djsr&_net_76))))? 16'bx :((((nif2|nif1)|nif0)|(djsr&_net_76)))? 
// synthesis translate_on
// synopsys translate_on
((nif2)?({PCH,PCL}):16'b0)|
    ((nif1)?({PCH,PCL}):16'b0)|
    ((nif0)?({PCH,PCL}):16'b0)|
    (((djsr&_net_76))?({PCH,PCL}):16'b0)
// synthesis translate_off
// synopsys translate_off
:16'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _incr_ci = 
// synthesis translate_off
// synopsys translate_off
((djsr&_net_76))? 
// synthesis translate_on
// synopsys translate_on
(djsr&_net_76)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge _incr_dox)
  begin
#1 if (_incr_dox===1'bx)
 begin
$display("Warning: control hazard(m65s:_incr_dox) at %d",$time);
 end
#1 if (((nif2)===1'bx) || (1'b1)===1'bx) $display("hazard (nif2 || 1'b1) line 438 at %d\n",$time);
#1 if (((nif1)===1'bx) || (1'b1)===1'bx) $display("hazard (nif1 || 1'b1) line 431 at %d\n",$time);
#1 if ((((djsr&_net_76))===1'bx) || (1'b1)===1'bx) $display("hazard ((djsr&_net_76) || 1'b1) line 286 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _incr_dox = nif2|
    nif1|
    (djsr&_net_76);

// synthesis translate_off
// synopsys translate_off
always @(posedge _incr_thr)
  begin
#1 if (_incr_thr===1'bx)
 begin
$display("Warning: control hazard(m65s:_incr_thr) at %d",$time);
 end
#1 if (((nif0)===1'bx) || (1'b1)===1'bx) $display("hazard (nif0 || 1'b1) line 427 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _incr_thr = nif0;
   assign  _incr_p_reset = p_reset;
   assign  _incr_m_clock = m_clock;

// synthesis translate_off
// synopsys translate_off
always @(posedge _proc_ift_run_set)
  begin
#1 if (_proc_ift_run_set===1'bx)
 begin
$display("Warning: control hazard(m65s:_proc_ift_run_set) at %d",$time);
 end
#1 if ((((ex&ifrun))===1'bx) || (1'b1)===1'bx) $display("hazard ((ex&ifrun) || 1'b1) line 870 at %d\n",$time);
#1 if ((((_net_173&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard ((_net_173&rdy) || 1'b1) line 851 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _proc_ift_run_set = (ex&ifrun)|
    (_net_173&rdy);

// synthesis translate_off
// synopsys translate_off
always @(posedge _proc_ift_run_reset)
  begin
#1 if (_proc_ift_run_reset===1'bx)
 begin
$display("Warning: control hazard(m65s:_proc_ift_run_reset) at %d",$time);
 end
#1 if ((((((ift_run&_net_162)&rdy)&_net_164))===1'bx) || (1'b1)===1'bx) $display("hazard ((((ift_run&_net_162)&rdy)&_net_164) || 1'b1) line 778 at %d\n",$time);
#1 if ((((((ift_run&_net_162)&rdy)&_alu_z))===1'bx) || (1'b1)===1'bx) $display("hazard ((((ift_run&_net_162)&rdy)&_alu_z) || 1'b1) line 779 at %d\n",$time);
#1 if ((((((ift_run&_net_162)&rdy)&_alu_z))===1'bx) || (1'b1)===1'bx) $display("hazard ((((ift_run&_net_162)&rdy)&_alu_z) || 1'b1) line 779 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _proc_ift_run_reset = (((ift_run&_net_162)&rdy)&_net_164)|
    (((ift_run&_net_162)&rdy)&_alu_z)|
    (((ift_run&_net_162)&rdy)&_alu_z);

// synthesis translate_off
// synopsys translate_off
always @(posedge _proc_do_nmi_set)
  begin
#1 if (_proc_do_nmi_set===1'bx)
 begin
$display("Warning: control hazard(m65s:_proc_do_nmi_set) at %d",$time);
 end
#1 if ((((nmi&_net_27))===1'bx) || (1'b1)===1'bx) $display("hazard ((nmi&_net_27) || 1'b1) line 121 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _proc_do_nmi_set = (nmi&_net_27);

// synthesis translate_off
// synopsys translate_off
always @(posedge _proc_do_nmi_reset)
  begin
#1 if (_proc_do_nmi_reset===1'bx)
 begin
$display("Warning: control hazard(m65s:_proc_do_nmi_reset) at %d",$time);
 end
#1 if (((((((_net_173&rdy)&(~do_res))&(~do_brk))&do_nmi))===1'bx) || (1'b1)===1'bx) $display("hazard (((((_net_173&rdy)&(~do_res))&(~do_brk))&do_nmi) || 1'b1) line 855 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _proc_do_nmi_reset = ((((_net_173&rdy)&(~do_res))&(~do_brk))&do_nmi);

// synthesis translate_off
// synopsys translate_off
always @(posedge _proc_do_irq_set)
  begin
#1 if (_proc_do_irq_set===1'bx)
 begin
$display("Warning: control hazard(m65s:_proc_do_irq_set) at %d",$time);
 end
#1 if ((((irq&_net_26))===1'bx) || (1'b1)===1'bx) $display("hazard ((irq&_net_26) || 1'b1) line 120 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _proc_do_irq_set = (irq&_net_26);

// synthesis translate_off
// synopsys translate_off
always @(posedge _proc_do_irq_reset)
  begin
#1 if (_proc_do_irq_reset===1'bx)
 begin
$display("Warning: control hazard(m65s:_proc_do_irq_reset) at %d",$time);
 end
#1 if ((((((((_net_173&rdy)&(~do_res))&(~do_brk))&(~do_nmi))&do_irq))===1'bx) || (1'b1)===1'bx) $display("hazard ((((((_net_173&rdy)&(~do_res))&(~do_brk))&(~do_nmi))&do_irq) || 1'b1) line 856 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _proc_do_irq_reset = (((((_net_173&rdy)&(~do_res))&(~do_brk))&(~do_nmi))&do_irq);

// synthesis translate_off
// synopsys translate_off
always @(posedge _proc_do_brk_set)
  begin
#1 if (_proc_do_brk_set===1'bx)
 begin
$display("Warning: control hazard(m65s:_proc_do_brk_set) at %d",$time);
 end
#1 if ((((((ift_run&_net_162)&rdy)&_alu_z))===1'bx) || (1'b1)===1'bx) $display("hazard ((((ift_run&_net_162)&rdy)&_alu_z) || 1'b1) line 779 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _proc_do_brk_set = (((ift_run&_net_162)&rdy)&_alu_z);

// synthesis translate_off
// synopsys translate_off
always @(posedge _proc_do_brk_reset)
  begin
#1 if (_proc_do_brk_reset===1'bx)
 begin
$display("Warning: control hazard(m65s:_proc_do_brk_reset) at %d",$time);
 end
#1 if ((((((_net_173&rdy)&(~do_res))&do_brk))===1'bx) || (1'b1)===1'bx) $display("hazard ((((_net_173&rdy)&(~do_res))&do_brk) || 1'b1) line 854 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _proc_do_brk_reset = (((_net_173&rdy)&(~do_res))&do_brk);

// synthesis translate_off
// synopsys translate_off
always @(posedge _proc_do_res_set)
  begin
#1 if (_proc_do_res_set===1'bx)
 begin
$display("Warning: control hazard(m65s:_proc_do_res_set) at %d",$time);
 end
#1 if (((start)===1'bx) || (1'b1)===1'bx) $display("hazard (start || 1'b1) line 133 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _proc_do_res_set = start;

// synthesis translate_off
// synopsys translate_off
always @(posedge _proc_do_res_reset)
  begin
#1 if (_proc_do_res_reset===1'bx)
 begin
$display("Warning: control hazard(m65s:_proc_do_res_reset) at %d",$time);
 end
#1 if (((((_net_173&rdy)&do_res))===1'bx) || (1'b1)===1'bx) $display("hazard (((_net_173&rdy)&do_res) || 1'b1) line 853 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _proc_do_res_reset = ((_net_173&rdy)&do_res);

// synthesis translate_off
// synopsys translate_off
always @(posedge _proc_int_req_set)
  begin
#1 if (_proc_int_req_set===1'bx)
 begin
$display("Warning: control hazard(m65s:_proc_int_req_set) at %d",$time);
 end
#1 if ((((((ift_run&_net_162)&rdy)&_alu_z))===1'bx) || (1'b1)===1'bx) $display("hazard ((((ift_run&_net_162)&rdy)&_alu_z) || 1'b1) line 779 at %d\n",$time);
#1 if (((start)===1'bx) || (1'b1)===1'bx) $display("hazard (start || 1'b1) line 133 at %d\n",$time);
#1 if ((((nmi&_net_27))===1'bx) || (1'b1)===1'bx) $display("hazard ((nmi&_net_27) || 1'b1) line 121 at %d\n",$time);
#1 if ((((irq&_net_26))===1'bx) || (1'b1)===1'bx) $display("hazard ((irq&_net_26) || 1'b1) line 120 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _proc_int_req_set = (((ift_run&_net_162)&rdy)&_alu_z)|
    start|
    (nmi&_net_27)|
    (irq&_net_26);

// synthesis translate_off
// synopsys translate_off
always @(posedge _proc_int_req_reset)
  begin
#1 if (_proc_int_req_reset===1'bx)
 begin
$display("Warning: control hazard(m65s:_proc_int_req_reset) at %d",$time);
 end
#1 if ((((_net_173&rdy))===1'bx) || (1'b1)===1'bx) $display("hazard ((_net_173&rdy) || 1'b1) line 851 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _proc_int_req_reset = (_net_173&rdy);

// synthesis translate_off
// synopsys translate_off
always @(posedge _proc_ex_set)
  begin
#1 if (_proc_ex_set===1'bx)
 begin
$display("Warning: control hazard(m65s:_proc_ex_set) at %d",$time);
 end
#1 if ((((ex&s1))===1'bx) || (1'b1)===1'bx) $display("hazard ((ex&s1) || 1'b1) line 865 at %d\n",$time);
#1 if ((((ex&s2))===1'bx) || (1'b1)===1'bx) $display("hazard ((ex&s2) || 1'b1) line 866 at %d\n",$time);
#1 if ((((ex&s3))===1'bx) || (1'b1)===1'bx) $display("hazard ((ex&s3) || 1'b1) line 867 at %d\n",$time);
#1 if ((((ex&s4))===1'bx) || (1'b1)===1'bx) $display("hazard ((ex&s4) || 1'b1) line 868 at %d\n",$time);
#1 if ((((ex&s5))===1'bx) || (1'b1)===1'bx) $display("hazard ((ex&s5) || 1'b1) line 869 at %d\n",$time);
#1 if ((((((ift_run&_net_162)&rdy)&_net_164))===1'bx) || (1'b1)===1'bx) $display("hazard ((((ift_run&_net_162)&rdy)&_net_164) || 1'b1) line 778 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _proc_ex_set = (ex&s1)|
    (ex&s2)|
    (ex&s3)|
    (ex&s4)|
    (ex&s5)|
    (((ift_run&_net_162)&rdy)&_net_164);

// synthesis translate_off
// synopsys translate_off
always @(posedge _proc_ex_reset)
  begin
#1 if (_proc_ex_reset===1'bx)
 begin
$display("Warning: control hazard(m65s:_proc_ex_reset) at %d",$time);
 end
#1 if (((((((((ex&(~ifrun))&(~s5))&(~s4))&(~s3))&(~s2))&(~s1)))===1'bx) || (1'b1)===1'bx) $display("hazard (((((((ex&(~ifrun))&(~s5))&(~s4))&(~s3))&(~s2))&(~s1)) || 1'b1) line 871 at %d\n",$time);
#1 if ((((ex&s1))===1'bx) || (1'b1)===1'bx) $display("hazard ((ex&s1) || 1'b1) line 865 at %d\n",$time);
#1 if ((((ex&s2))===1'bx) || (1'b1)===1'bx) $display("hazard ((ex&s2) || 1'b1) line 866 at %d\n",$time);
#1 if ((((ex&s3))===1'bx) || (1'b1)===1'bx) $display("hazard ((ex&s3) || 1'b1) line 867 at %d\n",$time);
#1 if ((((ex&s4))===1'bx) || (1'b1)===1'bx) $display("hazard ((ex&s4) || 1'b1) line 868 at %d\n",$time);
#1 if ((((ex&s5))===1'bx) || (1'b1)===1'bx) $display("hazard ((ex&s5) || 1'b1) line 869 at %d\n",$time);
#1 if ((((ex&ifrun))===1'bx) || (1'b1)===1'bx) $display("hazard ((ex&ifrun) || 1'b1) line 870 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _proc_ex_reset = ((((((ex&(~ifrun))&(~s5))&(~s4))&(~s3))&(~s2))&(~s1))|
    (ex&s1)|
    (ex&s2)|
    (ex&s3)|
    (ex&s4)|
    (ex&s5)|
    (ex&ifrun);
   assign  _net_26 = 
// synthesis translate_off
// synopsys translate_off
(irq)? 
// synthesis translate_on
// synopsys translate_on
((irq)?((~int_req)&(~fi)):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_27 = 
// synthesis translate_off
// synopsys translate_off
(nmi)? 
// synthesis translate_on
// synopsys translate_on
((nmi)?((~int_req)&(~nm1)):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_28 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?(({(opc[7]),(opc[5:0])})==7'b0101000):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_29 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?(({(opc[7]),(opc[5:0])})==7'b0001000):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_30 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?(opc==8'b01100000):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_31 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?(opc==8'b01000000):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_32 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?(opc==8'b00100000):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_33 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?(({(opc[7:6]),(opc[4:0])})==7'b0101100):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_34 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?((opc[4:0])==5'b10000):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_35 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?(({(opc[7]),(opc[3:2]),(opc[0])})==4'b1100):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_36 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?(({(opc[7]),(opc[4:0])})==6'b011000):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_37 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?(({(opc[7]),(opc[4:0])})==6'b001010):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_38 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?(({(opc[7:6]),(opc[4:0])})==7'b1100000):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_39 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?(({(opc[7:2]),(opc[0])})==7'b1010000):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_40 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?(({(opc[7:6]),(opc[2:0])})==5'b11100):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_41 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?(({(opc[7:5]),(opc[2]),(opc[0])})==5'b10110):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_42 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?(({(opc[7:5]),(opc[2]),(opc[0])})==5'b10010):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_43 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?(({(opc[7:5]),(opc[2:0])})==6'b001100):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_44 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?(({(opc[7:6]),(opc[2:0])})==5'b11110):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_45 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?(({(opc[7]),(opc[2:0])})==4'b0110):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_46 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?(({(opc[7:6]),(opc[1:0])})==4'b1101):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_47 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?(({(opc[7:5]),(opc[1:0])})==5'b10101):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_48 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?(({(opc[7:5]),(opc[1:0])})==5'b10001):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_49 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?(({(opc[7]),(opc[1:0])})==3'b001):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_50 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?((opc[4:3])==2'b11):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_51 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?((opc[3:2])==2'b01):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_52 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?((opc[4:2])==3'b100):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_53 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?((opc[4:2])==3'b011):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_54 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?((opc[4:2])==3'b010):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_55 = 
// synthesis translate_off
// synopsys translate_off
(decop)? 
// synthesis translate_on
// synopsys translate_on
((decop)?((opc[4:2])==3'b000):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_56 = 
// synthesis translate_off
// synopsys translate_off
(drts)? 
// synthesis translate_on
// synopsys translate_on
((drts)?(ex_st[3]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_57 = 
// synthesis translate_off
// synopsys translate_off
(drts)? 
// synthesis translate_on
// synopsys translate_on
((drts)?(ex_st[2]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_58 = 
// synthesis translate_off
// synopsys translate_off
(((drts&_net_57)&rdy))? 
// synthesis translate_on
// synopsys translate_on
((((drts&_net_57)&rdy))?(~_alu_c):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_59 = 
// synthesis translate_off
// synopsys translate_off
(drts)? 
// synthesis translate_on
// synopsys translate_on
((drts)?(ex_st[1]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_60 = 
// synthesis translate_off
// synopsys translate_off
(drts)? 
// synthesis translate_on
// synopsys translate_on
((drts)?(ex_st[0]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_61 = 
// synthesis translate_off
// synopsys translate_off
(drti)? 
// synthesis translate_on
// synopsys translate_on
((drti)?(ex_st[3]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_62 = 
// synthesis translate_off
// synopsys translate_off
(drti)? 
// synthesis translate_on
// synopsys translate_on
((drti)?(ex_st[2]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_63 = 
// synthesis translate_off
// synopsys translate_off
(drti)? 
// synthesis translate_on
// synopsys translate_on
((drti)?(ex_st[1]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_64 = 
// synthesis translate_off
// synopsys translate_off
(drti)? 
// synthesis translate_on
// synopsys translate_on
((drti)?(ex_st[0]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_65 = 
// synthesis translate_off
// synopsys translate_off
(dplp)? 
// synthesis translate_on
// synopsys translate_on
((dplp)?(ex_st[1]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_66 = 
// synthesis translate_off
// synopsys translate_off
((dplp&_net_65))? 
// synthesis translate_on
// synopsys translate_on
(((dplp&_net_65))?(opc[6]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_67 = 
// synthesis translate_off
// synopsys translate_off
((dplp&_net_65))? 
// synthesis translate_on
// synopsys translate_on
(((dplp&_net_65))?(~(opc[6])):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_68 = 
// synthesis translate_off
// synopsys translate_off
(dplp)? 
// synthesis translate_on
// synopsys translate_on
((dplp)?(ex_st[0]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_69 = 
// synthesis translate_off
// synopsys translate_off
(dphp)? 
// synthesis translate_on
// synopsys translate_on
((dphp)?(ex_st[1]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_70 = 
// synthesis translate_off
// synopsys translate_off
((dphp&_net_69))? 
// synthesis translate_on
// synopsys translate_on
(((dphp&_net_69))?(opc[6]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_71 = 
// synthesis translate_off
// synopsys translate_off
((dphp&_net_69))? 
// synthesis translate_on
// synopsys translate_on
(((dphp&_net_69))?(~(opc[6])):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_72 = 
// synthesis translate_off
// synopsys translate_off
(dphp)? 
// synthesis translate_on
// synopsys translate_on
((dphp)?(ex_st[0]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_73 = 
// synthesis translate_off
// synopsys translate_off
(djsr)? 
// synthesis translate_on
// synopsys translate_on
((djsr)?(ex_st[4]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_74 = 
// synthesis translate_off
// synopsys translate_off
(djsr)? 
// synthesis translate_on
// synopsys translate_on
((djsr)?(ex_st[3]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_75 = 
// synthesis translate_off
// synopsys translate_off
(djsr)? 
// synthesis translate_on
// synopsys translate_on
((djsr)?(ex_st[2]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_76 = 
// synthesis translate_off
// synopsys translate_off
(djsr)? 
// synthesis translate_on
// synopsys translate_on
((djsr)?(ex_st[1]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_77 = 
// synthesis translate_off
// synopsys translate_off
(djsr)? 
// synthesis translate_on
// synopsys translate_on
((djsr)?(ex_st[0]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_78 = 
// synthesis translate_off
// synopsys translate_off
(djmp)? 
// synthesis translate_on
// synopsys translate_on
((djmp)?(ex_st[3]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_79 = 
// synthesis translate_off
// synopsys translate_off
(djmp)? 
// synthesis translate_on
// synopsys translate_on
((djmp)?(ex_st[2]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_80 = 
// synthesis translate_off
// synopsys translate_off
(djmp)? 
// synthesis translate_on
// synopsys translate_on
((djmp)?(ex_st[1]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_81 = 
// synthesis translate_off
// synopsys translate_off
(((djmp&_net_80)&rdy))? 
// synthesis translate_on
// synopsys translate_on
((((djmp&_net_80)&rdy))?(opc[5]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_82 = 
// synthesis translate_off
// synopsys translate_off
(((djmp&_net_80)&rdy))? 
// synthesis translate_on
// synopsys translate_on
((((djmp&_net_80)&rdy))?(~(opc[5])):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_83 = 
// synthesis translate_off
// synopsys translate_off
(djmp)? 
// synthesis translate_on
// synopsys translate_on
((djmp)?(ex_st[0]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_84 = 
// synthesis translate_off
// synopsys translate_off
(dclc)? 
// synthesis translate_on
// synopsys translate_on
((dclc)?((opc[6])==1'b1):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_85 = 
// synthesis translate_off
// synopsys translate_off
(dclc)? 
// synthesis translate_on
// synopsys translate_on
((dclc)?((opc[6])==1'b0):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_86 = 
// synthesis translate_off
// synopsys translate_off
(dmisc)? 
// synthesis translate_on
// synopsys translate_on
((dmisc)?(({(opc[6:4]),(opc[1])})==4'b1111):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_87 = 
// synthesis translate_off
// synopsys translate_off
(dmisc)? 
// synthesis translate_on
// synopsys translate_on
((dmisc)?(({(opc[6:4]),(opc[1])})==4'b1110):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_88 = 
// synthesis translate_off
// synopsys translate_off
(dmisc)? 
// synthesis translate_on
// synopsys translate_on
((dmisc)?(({(opc[6:4]),(opc[1])})==4'b1101):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_89 = 
// synthesis translate_off
// synopsys translate_off
(dmisc)? 
// synthesis translate_on
// synopsys translate_on
((dmisc)?(({(opc[6:4]),(opc[1])})==4'b1100):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_90 = 
// synthesis translate_off
// synopsys translate_off
(dmisc)? 
// synthesis translate_on
// synopsys translate_on
((dmisc)?(({(opc[6:4]),(opc[1])})==4'b1011):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_91 = 
// synthesis translate_off
// synopsys translate_off
(dmisc)? 
// synthesis translate_on
// synopsys translate_on
((dmisc)?(({(opc[6:4]),(opc[1])})==4'b1010):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_92 = 
// synthesis translate_off
// synopsys translate_off
(dmisc)? 
// synthesis translate_on
// synopsys translate_on
((dmisc)?(({(opc[6:4]),(opc[1])})==4'b1001):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_93 = 
// synthesis translate_off
// synopsys translate_off
(dmisc)? 
// synthesis translate_on
// synopsys translate_on
((dmisc)?(({(opc[6:4]),(opc[1])})==4'b1000):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_94 = 
// synthesis translate_off
// synopsys translate_off
(dmisc)? 
// synthesis translate_on
// synopsys translate_on
((dmisc)?(({(opc[6:4]),(opc[1])})==4'b0111):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_95 = 
// synthesis translate_off
// synopsys translate_off
(dmisc)? 
// synthesis translate_on
// synopsys translate_on
((dmisc)?(({(opc[6:4]),(opc[1])})==4'b0110):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_96 = 
// synthesis translate_off
// synopsys translate_off
(dmisc)? 
// synthesis translate_on
// synopsys translate_on
((dmisc)?(({(opc[6:4]),(opc[1])})==4'b0101):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_97 = 
// synthesis translate_off
// synopsys translate_off
(dmisc)? 
// synthesis translate_on
// synopsys translate_on
((dmisc)?(({(opc[6:4]),(opc[1])})==4'b0100):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_98 = 
// synthesis translate_off
// synopsys translate_off
(dmisc)? 
// synthesis translate_on
// synopsys translate_on
((dmisc)?(({(opc[6:4]),(opc[1])})==4'b0011):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_99 = 
// synthesis translate_off
// synopsys translate_off
(dmisc)? 
// synthesis translate_on
// synopsys translate_on
((dmisc)?(({(opc[6:4]),(opc[1])})==4'b0010):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_100 = 
// synthesis translate_off
// synopsys translate_off
(dmisc)? 
// synthesis translate_on
// synopsys translate_on
((dmisc)?(({(opc[6:4]),(opc[1])})==4'b0001):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_101 = 
// synthesis translate_off
// synopsys translate_off
(dmisc)? 
// synthesis translate_on
// synopsys translate_on
((dmisc)?(({(opc[6:4]),(opc[1])})==4'b0000):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_102 = 
// synthesis translate_off
// synopsys translate_off
((ea&maby))? 
// synthesis translate_on
// synopsys translate_on
(((ea&maby))?(ex_st[2]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_103 = 
// synthesis translate_off
// synopsys translate_off
((ea&maby))? 
// synthesis translate_on
// synopsys translate_on
(((ea&maby))?(ex_st[1]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_104 = 
// synthesis translate_off
// synopsys translate_off
((((ea&maby)&_net_103)&rdy))? 
// synthesis translate_on
// synopsys translate_on
(((((ea&maby)&_net_103)&rdy))?((opc[2])&((~dldx)|(~(opc[1])))):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_105 = 
// synthesis translate_off
// synopsys translate_off
((((ea&maby)&_net_103)&rdy))? 
// synthesis translate_on
// synopsys translate_on
(((((ea&maby)&_net_103)&rdy))?((~(opc[2]))|(dldx&(opc[1]))):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_106 = 
// synthesis translate_off
// synopsys translate_off
((((ea&maby)&_net_103)&rdy))? 
// synthesis translate_on
// synopsys translate_on
(((((ea&maby)&_net_103)&rdy))?(~_alu_c):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_107 = 
// synthesis translate_off
// synopsys translate_off
((ea&maby))? 
// synthesis translate_on
// synopsys translate_on
(((ea&maby))?(ex_st[0]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_108 = 
// synthesis translate_off
// synopsys translate_off
((ea&mzpx))? 
// synthesis translate_on
// synopsys translate_on
(((ea&mzpx))?(ex_st[0]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_109 = 
// synthesis translate_off
// synopsys translate_off
((((ea&mzpx)&_net_108)&rdy))? 
// synthesis translate_on
// synopsys translate_on
(((((ea&mzpx)&_net_108)&rdy))?(~(opc[4])):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_110 = 
// synthesis translate_off
// synopsys translate_off
((((ea&mzpx)&_net_108)&rdy))? 
// synthesis translate_on
// synopsys translate_on
(((((ea&mzpx)&_net_108)&rdy))?(((opc[4])&(dldx|dstx))&(opc[1])):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_111 = 
// synthesis translate_off
// synopsys translate_off
((((ea&mzpx)&_net_108)&rdy))? 
// synthesis translate_on
// synopsys translate_on
(((((ea&mzpx)&_net_108)&rdy))?((opc[4])&(((~dldx)&(~dstx))|(~(opc[1])))):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_112 = 
// synthesis translate_off
// synopsys translate_off
((ea&mzpiy))? 
// synthesis translate_on
// synopsys translate_on
(((ea&mzpiy))?(ex_st[3]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_113 = 
// synthesis translate_off
// synopsys translate_off
((ea&mzpiy))? 
// synthesis translate_on
// synopsys translate_on
(((ea&mzpiy))?(ex_st[2]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_114 = 
// synthesis translate_off
// synopsys translate_off
((((ea&mzpiy)&_net_113)&rdy))? 
// synthesis translate_on
// synopsys translate_on
(((((ea&mzpiy)&_net_113)&rdy))?(~_alu_c):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_115 = 
// synthesis translate_off
// synopsys translate_off
((ea&mzpiy))? 
// synthesis translate_on
// synopsys translate_on
(((ea&mzpiy))?(ex_st[1]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_116 = 
// synthesis translate_off
// synopsys translate_off
((ea&mzpiy))? 
// synthesis translate_on
// synopsys translate_on
(((ea&mzpiy))?(ex_st[0]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_117 = 
// synthesis translate_off
// synopsys translate_off
((ea&mabs))? 
// synthesis translate_on
// synopsys translate_on
(((ea&mabs))?(ex_st[1]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_118 = 
// synthesis translate_off
// synopsys translate_off
((ea&mabs))? 
// synthesis translate_on
// synopsys translate_on
(((ea&mabs))?(ex_st[0]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_119 = 
// synthesis translate_off
// synopsys translate_off
((ea&mzpxi))? 
// synthesis translate_on
// synopsys translate_on
(((ea&mzpxi))?(ex_st[2]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_120 = 
// synthesis translate_off
// synopsys translate_off
((ea&mzpxi))? 
// synthesis translate_on
// synopsys translate_on
(((ea&mzpxi))?(ex_st[1]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_121 = 
// synthesis translate_off
// synopsys translate_off
((ea&mzpxi))? 
// synthesis translate_on
// synopsys translate_on
(((ea&mzpxi))?(ex_st[0]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_122 = 
// synthesis translate_off
// synopsys translate_off
(dora)? 
// synthesis translate_on
// synopsys translate_on
((dora)?(mimm|(ex_st[4])):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_123 = 
// synthesis translate_off
// synopsys translate_off
((dora&_net_122))? 
// synthesis translate_on
// synopsys translate_on
(((dora&_net_122))?((opc[6:5])==2'b11):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_124 = 
// synthesis translate_off
// synopsys translate_off
((dora&_net_122))? 
// synthesis translate_on
// synopsys translate_on
(((dora&_net_122))?((opc[6:5])==2'b10):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_125 = 
// synthesis translate_off
// synopsys translate_off
((dora&_net_122))? 
// synthesis translate_on
// synopsys translate_on
(((dora&_net_122))?((opc[6:5])==2'b01):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_126 = 
// synthesis translate_off
// synopsys translate_off
((dora&_net_122))? 
// synthesis translate_on
// synopsys translate_on
(((dora&_net_122))?((opc[6:5])==2'b00):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_127 = 
// synthesis translate_off
// synopsys translate_off
(((dora&_net_122)&rdy))? 
// synthesis translate_on
// synopsys translate_on
((((dora&_net_122)&rdy))?((opc[6:5])==2'b11):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_128 = 
// synthesis translate_off
// synopsys translate_off
(dbit)? 
// synthesis translate_on
// synopsys translate_on
((dbit)?(mimm|(ex_st[4])):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_129 = 
// synthesis translate_off
// synopsys translate_off
(dsta)? 
// synthesis translate_on
// synopsys translate_on
((dsta)?((ex_st[4])|(ex_st[5])):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_130 = 
// synthesis translate_off
// synopsys translate_off
(dstx)? 
// synthesis translate_on
// synopsys translate_on
((dstx)?((ex_st[4])|(ex_st[5])):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_131 = 
// synthesis translate_off
// synopsys translate_off
((dstx&_net_130))? 
// synthesis translate_on
// synopsys translate_on
(((dstx&_net_130))?(~(opc[1])):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_132 = 
// synthesis translate_off
// synopsys translate_off
((dstx&_net_130))? 
// synthesis translate_on
// synopsys translate_on
(((dstx&_net_130))?(opc[1]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_133 = 
// synthesis translate_off
// synopsys translate_off
(dlda)? 
// synthesis translate_on
// synopsys translate_on
((dlda)?(mimm|(ex_st[4])):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_134 = 
// synthesis translate_off
// synopsys translate_off
(dcmp)? 
// synthesis translate_on
// synopsys translate_on
((dcmp)?(mimm|(ex_st[4])):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_135 = 
// synthesis translate_off
// synopsys translate_off
(((dcmp&_net_134)&rdy))? 
// synthesis translate_on
// synopsys translate_on
((((dcmp&_net_134)&rdy))?(opc[5]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_136 = 
// synthesis translate_off
// synopsys translate_off
(dcpx)? 
// synthesis translate_on
// synopsys translate_on
((dcpx)?(mimm|(ex_st[4])):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_137 = 
// synthesis translate_off
// synopsys translate_off
(((dcpx&_net_136)&rdy))? 
// synthesis translate_on
// synopsys translate_on
((((dcpx&_net_136)&rdy))?(~(opc[5])):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_138 = 
// synthesis translate_off
// synopsys translate_off
(((dcpx&_net_136)&rdy))? 
// synthesis translate_on
// synopsys translate_on
((((dcpx&_net_136)&rdy))?(opc[5]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_139 = 
// synthesis translate_off
// synopsys translate_off
(dldx)? 
// synthesis translate_on
// synopsys translate_on
((dldx)?(mimm|(ex_st[4])):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_140 = 
// synthesis translate_off
// synopsys translate_off
(((dldx&_net_139)&rdy))? 
// synthesis translate_on
// synopsys translate_on
((((dldx&_net_139)&rdy))?(~(opc[1])):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_141 = 
// synthesis translate_off
// synopsys translate_off
(((dldx&_net_139)&rdy))? 
// synthesis translate_on
// synopsys translate_on
((((dldx&_net_139)&rdy))?(opc[1]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_142 = 
// synthesis translate_off
// synopsys translate_off
(rmw)? 
// synthesis translate_on
// synopsys translate_on
((rmw)?(ex_st[5]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_143 = 
// synthesis translate_off
// synopsys translate_off
(rmw)? 
// synthesis translate_on
// synopsys translate_on
((rmw)?(ex_st[4]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_144 = 
// synthesis translate_off
// synopsys translate_off
(dasl)? 
// synthesis translate_on
// synopsys translate_on
((dasl)?(ex_st[4]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_145 = 
// synthesis translate_off
// synopsys translate_off
(dasl)? 
// synthesis translate_on
// synopsys translate_on
((dasl)?(mimp|(ex_st[5])):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_146 = 
// synthesis translate_off
// synopsys translate_off
((dasl&_net_145))? 
// synthesis translate_on
// synopsys translate_on
(((dasl&_net_145))?((opc[6:5])==2'b11):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_147 = 
// synthesis translate_off
// synopsys translate_off
((dasl&_net_145))? 
// synthesis translate_on
// synopsys translate_on
(((dasl&_net_145))?((opc[6:5])==2'b10):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_148 = 
// synthesis translate_off
// synopsys translate_off
((dasl&_net_145))? 
// synthesis translate_on
// synopsys translate_on
(((dasl&_net_145))?((opc[6:5])==2'b01):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_149 = 
// synthesis translate_off
// synopsys translate_off
((dasl&_net_145))? 
// synthesis translate_on
// synopsys translate_on
(((dasl&_net_145))?((opc[6:5])==2'b00):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_150 = 
// synthesis translate_off
// synopsys translate_off
(ddec)? 
// synthesis translate_on
// synopsys translate_on
((ddec)?(ex_st[5]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_151 = 
// synthesis translate_off
// synopsys translate_off
((ddec&_net_150))? 
// synthesis translate_on
// synopsys translate_on
(((ddec&_net_150))?(opc[5]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_152 = 
// synthesis translate_off
// synopsys translate_off
((ddec&_net_150))? 
// synthesis translate_on
// synopsys translate_on
(((ddec&_net_150))?(~(opc[5])):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_153 = 
// synthesis translate_off
// synopsys translate_off
(ddec)? 
// synthesis translate_on
// synopsys translate_on
((ddec)?(ex_st[4]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_154 = 
// synthesis translate_off
// synopsys translate_off
(dbc)? 
// synthesis translate_on
// synopsys translate_on
((dbc)?(ex_st[2]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_155 = 
// synthesis translate_off
// synopsys translate_off
(dbc)? 
// synthesis translate_on
// synopsys translate_on
((dbc)?(ex_st[1]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_156 = 
// synthesis translate_off
// synopsys translate_off
(dbc)? 
// synthesis translate_on
// synopsys translate_on
((dbc)?(ex_st[0]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_157 = 
// synthesis translate_off
// synopsys translate_off
((((dbc&_net_156)&taken)&rdy))? 
// synthesis translate_on
// synopsys translate_on
(((((dbc&_net_156)&taken)&rdy))?(_alu_c^(data[7])):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_158 = 
// synthesis translate_off
// synopsys translate_off
(((((dbc&_net_156)&taken)&rdy)&_net_157))? 
// synthesis translate_on
// synopsys translate_on
((((((dbc&_net_156)&taken)&rdy)&_net_157))?(data[7]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_159 = 
// synthesis translate_off
// synopsys translate_off
(((((dbc&_net_156)&taken)&rdy)&_net_157))? 
// synthesis translate_on
// synopsys translate_on
((((((dbc&_net_156)&taken)&rdy)&_net_157))?(~(data[7])):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_160 = 
// synthesis translate_off
// synopsys translate_off
((((dbc&_net_156)&taken)&rdy))? 
// synthesis translate_on
// synopsys translate_on
(((((dbc&_net_156)&taken)&rdy))?((~_alu_c)^(data[7])):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_161 = 
// synthesis translate_off
// synopsys translate_off
((dbc&_net_156))? 
// synthesis translate_on
// synopsys translate_on
(((dbc&_net_156))?(~taken):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_162 = 
// synthesis translate_off
// synopsys translate_off
(ift_run)? 
// synthesis translate_on
// synopsys translate_on
((ift_run)?(~int_req):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_163 = 
// synthesis translate_off
// synopsys translate_off
((ift_run&_net_162))? 
// synthesis translate_on
// synopsys translate_on
(((ift_run&_net_162))?(~nmi):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_164 = 
// synthesis translate_off
// synopsys translate_off
(((ift_run&_net_162)&rdy))? 
// synthesis translate_on
// synopsys translate_on
((((ift_run&_net_162)&rdy))?(~_alu_z):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge _net_166)
  begin
#1 if (_net_166===1'bx)
 begin
$display("Warning: control hazard(m65s:_net_166) at %d",$time);
 end
#1 if (((((_reg_165==_state__reg_165_st0)&int_req))===1'bx) || (1'b1)===1'bx) $display("hazard (((_reg_165==_state__reg_165_st0)&int_req) || 1'b1) line 788 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _net_166 = ((_reg_165==_state__reg_165_st0)&int_req);
   assign  _net_167 = 
// synthesis translate_off
// synopsys translate_off
(_net_166)? 
// synthesis translate_on
// synopsys translate_on
((_net_166)?((ift_run&(do_irq|do_nmi))|do_brk):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge _net_168)
  begin
#1 if (_net_168===1'bx)
 begin
$display("Warning: control hazard(m65s:_net_168) at %d",$time);
 end
#1 if (((((_reg_165==_state__reg_165_st1)&int_req))===1'bx) || (1'b1)===1'bx) $display("hazard (((_reg_165==_state__reg_165_st1)&int_req) || 1'b1) line 799 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _net_168 = ((_reg_165==_state__reg_165_st1)&int_req);

// synthesis translate_off
// synopsys translate_off
always @(posedge _net_169)
  begin
#1 if (_net_169===1'bx)
 begin
$display("Warning: control hazard(m65s:_net_169) at %d",$time);
 end
#1 if (((((_reg_165==_state__reg_165_st2)&int_req))===1'bx) || (1'b1)===1'bx) $display("hazard (((_reg_165==_state__reg_165_st2)&int_req) || 1'b1) line 806 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _net_169 = ((_reg_165==_state__reg_165_st2)&int_req);

// synthesis translate_off
// synopsys translate_off
always @(posedge _net_170)
  begin
#1 if (_net_170===1'bx)
 begin
$display("Warning: control hazard(m65s:_net_170) at %d",$time);
 end
#1 if (((((_reg_165==_state__reg_165_st3)&int_req))===1'bx) || (1'b1)===1'bx) $display("hazard (((_reg_165==_state__reg_165_st3)&int_req) || 1'b1) line 813 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _net_170 = ((_reg_165==_state__reg_165_st3)&int_req);

// synthesis translate_off
// synopsys translate_off
always @(posedge _net_171)
  begin
#1 if (_net_171===1'bx)
 begin
$display("Warning: control hazard(m65s:_net_171) at %d",$time);
 end
#1 if (((((_reg_165==_state__reg_165_st4)&int_req))===1'bx) || (1'b1)===1'bx) $display("hazard (((_reg_165==_state__reg_165_st4)&int_req) || 1'b1) line 820 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _net_171 = ((_reg_165==_state__reg_165_st4)&int_req);

// synthesis translate_off
// synopsys translate_off
always @(posedge _net_172)
  begin
#1 if (_net_172===1'bx)
 begin
$display("Warning: control hazard(m65s:_net_172) at %d",$time);
 end
#1 if (((((_reg_165==_state__reg_165_st5)&int_req))===1'bx) || (1'b1)===1'bx) $display("hazard (((_reg_165==_state__reg_165_st5)&int_req) || 1'b1) line 834 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _net_172 = ((_reg_165==_state__reg_165_st5)&int_req);

// synthesis translate_off
// synopsys translate_off
always @(posedge _net_173)
  begin
#1 if (_net_173===1'bx)
 begin
$display("Warning: control hazard(m65s:_net_173) at %d",$time);
 end
#1 if (((((_reg_165==_state__reg_165_st6)&int_req))===1'bx) || (1'b1)===1'bx) $display("hazard (((_reg_165==_state__reg_165_st6)&int_req) || 1'b1) line 842 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _net_173 = ((_reg_165==_state__reg_165_st6)&int_req);
   assign  datao = 
// synthesis translate_off
// synopsys translate_off
(write)? 
// synthesis translate_on
// synopsys translate_on
((write)?dbo:8'b0)
// synthesis translate_off
// synopsys translate_off
:8'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  adrs = ({(rABH&8'b11111111),rABL});
   assign  debug = ({PCH,PCL});

// synthesis translate_off
// synopsys translate_off
always @(posedge rd)
  begin
#1 if (rd===1'bx)
 begin
$display("Warning: control hazard(m65s:rd) at %d",$time);
 end
#1 if (((read)===1'bx) || (1'b1)===1'bx) $display("hazard (read || 1'b1) line 113 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  rd = read;

// synthesis translate_off
// synopsys translate_off
always @(posedge wt)
  begin
#1 if (wt===1'bx)
 begin
$display("Warning: control hazard(m65s:wt) at %d",$time);
 end
#1 if (((write)===1'bx) || (1'b1)===1'bx) $display("hazard (write || 1'b1) line 116 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  wt = write;

// synthesis translate_off
// synopsys translate_off
always @(posedge sync)
  begin
#1 if (sync===1'bx)
 begin
$display("Warning: control hazard(m65s:sync) at %d",$time);
 end
#1 if ((((ift_run&_net_162))===1'bx) || (1'b1)===1'bx) $display("hazard ((ift_run&_net_162) || 1'b1) line 772 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  sync = (ift_run&_net_162);
always @(posedge m_clock)
  begin
if (~p_reset)
     fn <= 1'b0;
else 
// synthesis translate_off
// synopsys translate_off
if ((((((((((((((((((((ddec&_net_150)&(dasl&_net_145))|(((ddec&_net_150)|(dasl&_net_145))&(dldx&_net_139)))|((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))&((dcpx&_net_136)&rdy)))|(((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))&((dcmp&_net_134)&rdy)))|((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))&((dlda&_net_133)&rdy)))|(((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))&((dbit&_net_128)&rdy)))|((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))&((dora&_net_122)&rdy)))|(((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))&(dmisc&_net_101)))|((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))&(dmisc&_net_100)))|(((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))&(dmisc&_net_99)))|((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))&(dmisc&_net_97)))|(((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))&(dmisc&_net_96)))|((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))&(dmisc&_net_94)))|(((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))&(dmisc&_net_93)))|((((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))&(dmisc&_net_92)))|(((((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))&(dmisc&_net_89)))|((((((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))&((dplp&_net_65)&_net_66)))|(((((((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((dplp&_net_65)&_net_66))&setpsr)))   fn <= 1'bx; 
  else 
// synthesis translate_on
// synopsys translate_on
if ((ddec&_net_150))
      fn <= _alu_s;
else if ((dasl&_net_145))
      fn <= _alu_s;
else if ((dldx&_net_139))
      fn <= _alu_s;
else if (((dcpx&_net_136)&rdy))
      fn <= _alu_s;
else if (((dcmp&_net_134)&rdy))
      fn <= _alu_s;
else if (((dlda&_net_133)&rdy))
      fn <= _alu_s;
else if (((dbit&_net_128)&rdy))
      fn <= _alu_s;
else if (((dora&_net_122)&rdy))
      fn <= _alu_s;
else if ((dmisc&_net_101))
      fn <= _alu_s;
else if ((dmisc&_net_100))
      fn <= _alu_s;
else if ((dmisc&_net_99))
      fn <= _alu_s;
else if ((dmisc&_net_97))
      fn <= _alu_s;
else if ((dmisc&_net_96))
      fn <= _alu_s;
else if ((dmisc&_net_94))
      fn <= _alu_s;
else if ((dmisc&_net_93))
      fn <= _alu_s;
else if ((dmisc&_net_92))
      fn <= _alu_s;
else if ((dmisc&_net_89))
      fn <= _alu_s;
else if (((dplp&_net_65)&_net_66))
      fn <= _alu_s;
else if (setpsr)
      fn <= (psri[7]);
end

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if (((((((((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((dplp&_net_65)&_net_66))|setpsr)==1'b1) ||
 ((((((((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((dplp&_net_65)&_net_66))|setpsr)==1'b0) ) begin
 if ((((((((((((((((((((ddec&_net_150)&(dasl&_net_145))|(((ddec&_net_150)|(dasl&_net_145))&(dldx&_net_139)))|((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))&((dcpx&_net_136)&rdy)))|(((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))&((dcmp&_net_134)&rdy)))|((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))&((dlda&_net_133)&rdy)))|(((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))&((dbit&_net_128)&rdy)))|((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))&((dora&_net_122)&rdy)))|(((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))&(dmisc&_net_101)))|((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))&(dmisc&_net_100)))|(((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))&(dmisc&_net_99)))|((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))&(dmisc&_net_97)))|(((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))&(dmisc&_net_96)))|((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))&(dmisc&_net_94)))|(((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))&(dmisc&_net_93)))|((((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))&(dmisc&_net_92)))|(((((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))&(dmisc&_net_89)))|((((((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))&((dplp&_net_65)&_net_66)))|(((((((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((dplp&_net_65)&_net_66))&setpsr)))
 begin $display("Warning: assign collision(m65s:fn) at %d",$time);

  end
 end
 else 
 $display("Warning: register set hazard(m65s:fn) at %d",$time);

  end

// synthesis translate_on
// synopsys translate_on
always @(posedge m_clock)
  begin
if (~p_reset)
     fv <= 1'b0;
else 
// synthesis translate_off
// synopsys translate_off
if ((((((((dcmp&_net_134)&rdy)&_net_135)&((dbit&_net_128)&rdy))|(((((dcmp&_net_134)&rdy)&_net_135)|((dbit&_net_128)&rdy))&(((dora&_net_122)&rdy)&_net_127)))|((((((dcmp&_net_134)&rdy)&_net_135)|((dbit&_net_128)&rdy))|(((dora&_net_122)&rdy)&_net_127))&(dmisc&_net_95)))|(((((((dcmp&_net_134)&rdy)&_net_135)|((dbit&_net_128)&rdy))|(((dora&_net_122)&rdy)&_net_127))|(dmisc&_net_95))&setpsr)))   fv <= 1'bx; 
  else 
// synthesis translate_on
// synopsys translate_on
if ((((dcmp&_net_134)&rdy)&_net_135))
      fv <= _alu_v;
else if (((dbit&_net_128)&rdy))
      fv <= _alu_v;
else if ((((dora&_net_122)&rdy)&_net_127))
      fv <= _alu_v;
else if ((dmisc&_net_95))
      fv <= 1'b0;
else if (setpsr)
      fv <= (psri[6]);
end

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if (((((((((dcmp&_net_134)&rdy)&_net_135)|((dbit&_net_128)&rdy))|(((dora&_net_122)&rdy)&_net_127))|(dmisc&_net_95))|setpsr)==1'b1) ||
 ((((((((dcmp&_net_134)&rdy)&_net_135)|((dbit&_net_128)&rdy))|(((dora&_net_122)&rdy)&_net_127))|(dmisc&_net_95))|setpsr)==1'b0) ) begin
 if ((((((((dcmp&_net_134)&rdy)&_net_135)&((dbit&_net_128)&rdy))|(((((dcmp&_net_134)&rdy)&_net_135)|((dbit&_net_128)&rdy))&(((dora&_net_122)&rdy)&_net_127)))|((((((dcmp&_net_134)&rdy)&_net_135)|((dbit&_net_128)&rdy))|(((dora&_net_122)&rdy)&_net_127))&(dmisc&_net_95)))|(((((((dcmp&_net_134)&rdy)&_net_135)|((dbit&_net_128)&rdy))|(((dora&_net_122)&rdy)&_net_127))|(dmisc&_net_95))&setpsr)))
 begin $display("Warning: assign collision(m65s:fv) at %d",$time);

  end
 end
 else 
 $display("Warning: register set hazard(m65s:fv) at %d",$time);

  end

// synthesis translate_on
// synopsys translate_on
always @(posedge m_clock)
  begin
if (~p_reset)
     fd <= 1'b0;
else 
// synthesis translate_off
// synopsys translate_off
if ((((dmisc&_net_91)&(dmisc&_net_87))|(((dmisc&_net_91)|(dmisc&_net_87))&setpsr)))   fd <= 1'bx; 
  else 
// synthesis translate_on
// synopsys translate_on
if ((dmisc&_net_91))
      fd <= 1'b0;
else if ((dmisc&_net_87))
      fd <= 1'b1;
else if (setpsr)
      fd <= (psri[3]);
end

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if (((((dmisc&_net_91)|(dmisc&_net_87))|setpsr)==1'b1) ||
 ((((dmisc&_net_91)|(dmisc&_net_87))|setpsr)==1'b0) ) begin
 if ((((dmisc&_net_91)&(dmisc&_net_87))|(((dmisc&_net_91)|(dmisc&_net_87))&setpsr)))
 begin $display("Warning: assign collision(m65s:fd) at %d",$time);

  end
 end
 else 
 $display("Warning: register set hazard(m65s:fd) at %d",$time);

  end

// synthesis translate_on
// synopsys translate_on
always @(posedge m_clock)
  begin
if (~p_reset)
     fz <= 1'b0;
else 
// synthesis translate_off
// synopsys translate_off
if ((((((((((((((((((((ddec&_net_150)&(dasl&_net_145))|(((ddec&_net_150)|(dasl&_net_145))&(dldx&_net_139)))|((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))&((dcpx&_net_136)&rdy)))|(((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))&((dcmp&_net_134)&rdy)))|((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))&((dlda&_net_133)&rdy)))|(((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))&((dbit&_net_128)&rdy)))|((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))&((dora&_net_122)&rdy)))|(((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))&(dmisc&_net_101)))|((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))&(dmisc&_net_100)))|(((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))&(dmisc&_net_99)))|((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))&(dmisc&_net_97)))|(((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))&(dmisc&_net_96)))|((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))&(dmisc&_net_94)))|(((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))&(dmisc&_net_93)))|((((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))&(dmisc&_net_92)))|(((((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))&(dmisc&_net_89)))|((((((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))&((dplp&_net_65)&_net_66)))|(((((((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((dplp&_net_65)&_net_66))&setpsr)))   fz <= 1'bx; 
  else 
// synthesis translate_on
// synopsys translate_on
if ((ddec&_net_150))
      fz <= _alu_z;
else if ((dasl&_net_145))
      fz <= _alu_z;
else if ((dldx&_net_139))
      fz <= _alu_z;
else if (((dcpx&_net_136)&rdy))
      fz <= _alu_z;
else if (((dcmp&_net_134)&rdy))
      fz <= _alu_z;
else if (((dlda&_net_133)&rdy))
      fz <= _alu_z;
else if (((dbit&_net_128)&rdy))
      fz <= _alu_z;
else if (((dora&_net_122)&rdy))
      fz <= _alu_z;
else if ((dmisc&_net_101))
      fz <= _alu_z;
else if ((dmisc&_net_100))
      fz <= _alu_z;
else if ((dmisc&_net_99))
      fz <= _alu_z;
else if ((dmisc&_net_97))
      fz <= _alu_z;
else if ((dmisc&_net_96))
      fz <= _alu_z;
else if ((dmisc&_net_94))
      fz <= _alu_z;
else if ((dmisc&_net_93))
      fz <= _alu_z;
else if ((dmisc&_net_92))
      fz <= _alu_z;
else if ((dmisc&_net_89))
      fz <= _alu_z;
else if (((dplp&_net_65)&_net_66))
      fz <= _alu_z;
else if (setpsr)
      fz <= (psri[1]);
end

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if (((((((((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((dplp&_net_65)&_net_66))|setpsr)==1'b1) ||
 ((((((((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((dplp&_net_65)&_net_66))|setpsr)==1'b0) ) begin
 if ((((((((((((((((((((ddec&_net_150)&(dasl&_net_145))|(((ddec&_net_150)|(dasl&_net_145))&(dldx&_net_139)))|((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))&((dcpx&_net_136)&rdy)))|(((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))&((dcmp&_net_134)&rdy)))|((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))&((dlda&_net_133)&rdy)))|(((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))&((dbit&_net_128)&rdy)))|((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))&((dora&_net_122)&rdy)))|(((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))&(dmisc&_net_101)))|((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))&(dmisc&_net_100)))|(((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))&(dmisc&_net_99)))|((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))&(dmisc&_net_97)))|(((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))&(dmisc&_net_96)))|((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))&(dmisc&_net_94)))|(((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))&(dmisc&_net_93)))|((((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))&(dmisc&_net_92)))|(((((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))&(dmisc&_net_89)))|((((((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))&((dplp&_net_65)&_net_66)))|(((((((((((((((((((ddec&_net_150)|(dasl&_net_145))|(dldx&_net_139))|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|((dlda&_net_133)&rdy))|((dbit&_net_128)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_101))|(dmisc&_net_100))|(dmisc&_net_99))|(dmisc&_net_97))|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_93))|(dmisc&_net_92))|(dmisc&_net_89))|((dplp&_net_65)&_net_66))&setpsr)))
 begin $display("Warning: assign collision(m65s:fz) at %d",$time);

  end
 end
 else 
 $display("Warning: register set hazard(m65s:fz) at %d",$time);

  end

// synthesis translate_on
// synopsys translate_on
always @(posedge m_clock)
  begin
if (~p_reset)
     fc <= 1'b0;
else 
// synthesis translate_off
// synopsys translate_off
if (((((((dasl&_net_145)&((dcpx&_net_136)&rdy))|(((dasl&_net_145)|((dcpx&_net_136)&rdy))&((dcmp&_net_134)&rdy)))|((((dasl&_net_145)|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))&(((dora&_net_122)&rdy)&_net_127)))|(((((dasl&_net_145)|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|(((dora&_net_122)&rdy)&_net_127))&(dclc&_net_85)))|((((((dasl&_net_145)|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|(((dora&_net_122)&rdy)&_net_127))|(dclc&_net_85))&setpsr)))   fc <= 1'bx; 
  else 
// synthesis translate_on
// synopsys translate_on
if ((dasl&_net_145))
      fc <= _alu_c;
else if (((dcpx&_net_136)&rdy))
      fc <= _alu_c;
else if (((dcmp&_net_134)&rdy))
      fc <= _alu_c;
else if ((((dora&_net_122)&rdy)&_net_127))
      fc <= _alu_c;
else if ((dclc&_net_85))
      fc <= (opc[5]);
else if (setpsr)
      fc <= (psri[0]);
end

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((((((((dasl&_net_145)|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|(((dora&_net_122)&rdy)&_net_127))|(dclc&_net_85))|setpsr)==1'b1) ||
 (((((((dasl&_net_145)|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|(((dora&_net_122)&rdy)&_net_127))|(dclc&_net_85))|setpsr)==1'b0) ) begin
 if (((((((dasl&_net_145)&((dcpx&_net_136)&rdy))|(((dasl&_net_145)|((dcpx&_net_136)&rdy))&((dcmp&_net_134)&rdy)))|((((dasl&_net_145)|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))&(((dora&_net_122)&rdy)&_net_127)))|(((((dasl&_net_145)|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|(((dora&_net_122)&rdy)&_net_127))&(dclc&_net_85)))|((((((dasl&_net_145)|((dcpx&_net_136)&rdy))|((dcmp&_net_134)&rdy))|(((dora&_net_122)&rdy)&_net_127))|(dclc&_net_85))&setpsr)))
 begin $display("Warning: assign collision(m65s:fc) at %d",$time);

  end
 end
 else 
 $display("Warning: register set hazard(m65s:fc) at %d",$time);

  end

// synthesis translate_on
// synopsys translate_on
always @(posedge m_clock)
  begin
if (~p_reset)
     fi <= 1'b1;
else 
// synthesis translate_off
// synopsys translate_off
if ((((_net_173&rdy)&(dclc&_net_84))|(((_net_173&rdy)|(dclc&_net_84))&setpsr)))   fi <= 1'bx; 
  else 
// synthesis translate_on
// synopsys translate_on
if ((_net_173&rdy))
      fi <= 1'b1;
else if ((dclc&_net_84))
      fi <= (opc[5]);
else if (setpsr)
      fi <= (psri[2]);
end

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if (((((_net_173&rdy)|(dclc&_net_84))|setpsr)==1'b1) ||
 ((((_net_173&rdy)|(dclc&_net_84))|setpsr)==1'b0) ) begin
 if ((((_net_173&rdy)&(dclc&_net_84))|(((_net_173&rdy)|(dclc&_net_84))&setpsr)))
 begin $display("Warning: assign collision(m65s:fi) at %d",$time);

  end
 end
 else 
 $display("Warning: register set hazard(m65s:fi) at %d",$time);

  end

// synthesis translate_on
// synopsys translate_on
always @(posedge m_clock)
  begin
  swt <= 1'b0;
end
always @(posedge m_clock)
  begin
if (~p_reset)
     nm1 <= 1'b0;
else 
// synthesis translate_off
// synopsys translate_off
if ((((_net_166&_net_167)&do_nmi)&((ift_run&_net_162)&_net_163)))   nm1 <= 1'bx; 
  else 
// synthesis translate_on
// synopsys translate_on
if (((_net_166&_net_167)&do_nmi))
      nm1 <= 1'b1;
else if (((ift_run&_net_162)&_net_163))
      nm1 <= 1'b0;
end

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if (((((_net_166&_net_167)&do_nmi)|((ift_run&_net_162)&_net_163))==1'b1) ||
 ((((_net_166&_net_167)&do_nmi)|((ift_run&_net_162)&_net_163))==1'b0) ) begin
 if ((((_net_166&_net_167)&do_nmi)&((ift_run&_net_162)&_net_163)))
 begin $display("Warning: assign collision(m65s:nm1) at %d",$time);

  end
 end
 else 
 $display("Warning: register set hazard(m65s:nm1) at %d",$time);

  end

// synthesis translate_on
// synopsys translate_on
always @(posedge m_clock)
  begin
if (((ea&maby)&_net_103))
      tc <= _alu_c;
end
always @(posedge m_clock)
  begin

// synthesis translate_off
// synopsys translate_off
if (((((((dldx&_net_139)&rdy)&_net_140)&(dmisc&_net_101))|(((((dldx&_net_139)&rdy)&_net_140)|(dmisc&_net_101))&(dmisc&_net_97)))|((((((dldx&_net_139)&rdy)&_net_140)|(dmisc&_net_101))|(dmisc&_net_97))&(dmisc&_net_93))))   RY <= 8'bx; 
  else 
// synthesis translate_on
// synopsys translate_on
if ((((dldx&_net_139)&rdy)&_net_140))
      RY <= _alu_out;
else if ((dmisc&_net_101))
      RY <= _alu_out;
else if ((dmisc&_net_97))
      RY <= _alu_out;
else if ((dmisc&_net_93))
      RY <= _alu_out;
end

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((((((((dldx&_net_139)&rdy)&_net_140)|(dmisc&_net_101))|(dmisc&_net_97))|(dmisc&_net_93))==1'b1) ||
 (((((((dldx&_net_139)&rdy)&_net_140)|(dmisc&_net_101))|(dmisc&_net_97))|(dmisc&_net_93))==1'b0) ) begin
 if (((((((dldx&_net_139)&rdy)&_net_140)&(dmisc&_net_101))|(((((dldx&_net_139)&rdy)&_net_140)|(dmisc&_net_101))&(dmisc&_net_97)))|((((((dldx&_net_139)&rdy)&_net_140)|(dmisc&_net_101))|(dmisc&_net_97))&(dmisc&_net_93))))
 begin $display("Warning: assign collision(m65s:RY) at %d",$time);

  end
 end
 else 
 $display("Warning: register set hazard(m65s:RY) at %d",$time);

  end

// synthesis translate_on
// synopsys translate_on
always @(posedge m_clock)
  begin

// synthesis translate_off
// synopsys translate_off
if ((((((((dldx&_net_139)&rdy)&_net_141)&(dmisc&_net_96))|(((((dldx&_net_139)&rdy)&_net_141)|(dmisc&_net_96))&(dmisc&_net_94)))|((((((dldx&_net_139)&rdy)&_net_141)|(dmisc&_net_96))|(dmisc&_net_94))&(dmisc&_net_92)))|(((((((dldx&_net_139)&rdy)&_net_141)|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_92))&(dmisc&_net_89))))   RX <= 8'bx; 
  else 
// synthesis translate_on
// synopsys translate_on
if ((((dldx&_net_139)&rdy)&_net_141))
      RX <= _alu_out;
else if ((dmisc&_net_96))
      RX <= _alu_out;
else if ((dmisc&_net_94))
      RX <= _alu_out;
else if ((dmisc&_net_92))
      RX <= _alu_out;
else if ((dmisc&_net_89))
      RX <= _alu_out;
end

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if (((((((((dldx&_net_139)&rdy)&_net_141)|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_92))|(dmisc&_net_89))==1'b1) ||
 ((((((((dldx&_net_139)&rdy)&_net_141)|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_92))|(dmisc&_net_89))==1'b0) ) begin
 if ((((((((dldx&_net_139)&rdy)&_net_141)&(dmisc&_net_96))|(((((dldx&_net_139)&rdy)&_net_141)|(dmisc&_net_96))&(dmisc&_net_94)))|((((((dldx&_net_139)&rdy)&_net_141)|(dmisc&_net_96))|(dmisc&_net_94))&(dmisc&_net_92)))|(((((((dldx&_net_139)&rdy)&_net_141)|(dmisc&_net_96))|(dmisc&_net_94))|(dmisc&_net_92))&(dmisc&_net_89))))
 begin $display("Warning: assign collision(m65s:RX) at %d",$time);

  end
 end
 else 
 $display("Warning: register set hazard(m65s:RX) at %d",$time);

  end

// synthesis translate_on
// synopsys translate_on
always @(posedge m_clock)
  begin
if (~p_reset)
     RS <= 8'b11111111;
else 
// synthesis translate_off
// synopsys translate_off
if (((((((((((((_net_170&_net_169)|((_net_170|_net_169)&_net_168))|(((_net_170|_net_169)|_net_168)&(dmisc&_net_98)))|((((_net_170|_net_169)|_net_168)|(dmisc&_net_98))&((djsr&_net_77)&rdy)))|(((((_net_170|_net_169)|_net_168)|(dmisc&_net_98))|((djsr&_net_77)&rdy))&(djsr&_net_75)))|((((((_net_170|_net_169)|_net_168)|(dmisc&_net_98))|((djsr&_net_77)&rdy))|(djsr&_net_75))&(dphp&_net_72)))|(((((((_net_170|_net_169)|_net_168)|(dmisc&_net_98))|((djsr&_net_77)&rdy))|(djsr&_net_75))|(dphp&_net_72))&(dplp&_net_68)))|((((((((_net_170|_net_169)|_net_168)|(dmisc&_net_98))|((djsr&_net_77)&rdy))|(djsr&_net_75))|(dphp&_net_72))|(dplp&_net_68))&(drti&_net_64)))|(((((((((_net_170|_net_169)|_net_168)|(dmisc&_net_98))|((djsr&_net_77)&rdy))|(djsr&_net_75))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))&((drti&_net_63)&rdy)))|((((((((((_net_170|_net_169)|_net_168)|(dmisc&_net_98))|((djsr&_net_77)&rdy))|(djsr&_net_75))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_63)&rdy))&((drti&_net_62)&rdy)))|(((((((((((_net_170|_net_169)|_net_168)|(dmisc&_net_98))|((djsr&_net_77)&rdy))|(djsr&_net_75))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))&(drts&_net_60)))|((((((((((((_net_170|_net_169)|_net_168)|(dmisc&_net_98))|((djsr&_net_77)&rdy))|(djsr&_net_75))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))|(drts&_net_60))&((drts&_net_59)&rdy))))   RS <= 8'bx; 
  else 
// synthesis translate_on
// synopsys translate_on
if (_net_170)
      RS <= _alu_out;
else if (_net_169)
      RS <= _alu_out;
else if (_net_168)
      RS <= _alu_out;
else if ((dmisc&_net_98))
      RS <= _alu_out;
else if (((djsr&_net_77)&rdy))
      RS <= _alu_out;
else if ((djsr&_net_75))
      RS <= _alu_out;
else if ((dphp&_net_72))
      RS <= _alu_out;
else if ((dplp&_net_68))
      RS <= _alu_out;
else if ((drti&_net_64))
      RS <= _alu_out;
else if (((drti&_net_63)&rdy))
      RS <= _alu_out;
else if (((drti&_net_62)&rdy))
      RS <= _alu_out;
else if ((drts&_net_60))
      RS <= _alu_out;
else if (((drts&_net_59)&rdy))
      RS <= _alu_out;
end

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((((((((((((((_net_170|_net_169)|_net_168)|(dmisc&_net_98))|((djsr&_net_77)&rdy))|(djsr&_net_75))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))|(drts&_net_60))|((drts&_net_59)&rdy))==1'b1) ||
 (((((((((((((_net_170|_net_169)|_net_168)|(dmisc&_net_98))|((djsr&_net_77)&rdy))|(djsr&_net_75))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))|(drts&_net_60))|((drts&_net_59)&rdy))==1'b0) ) begin
 if (((((((((((((_net_170&_net_169)|((_net_170|_net_169)&_net_168))|(((_net_170|_net_169)|_net_168)&(dmisc&_net_98)))|((((_net_170|_net_169)|_net_168)|(dmisc&_net_98))&((djsr&_net_77)&rdy)))|(((((_net_170|_net_169)|_net_168)|(dmisc&_net_98))|((djsr&_net_77)&rdy))&(djsr&_net_75)))|((((((_net_170|_net_169)|_net_168)|(dmisc&_net_98))|((djsr&_net_77)&rdy))|(djsr&_net_75))&(dphp&_net_72)))|(((((((_net_170|_net_169)|_net_168)|(dmisc&_net_98))|((djsr&_net_77)&rdy))|(djsr&_net_75))|(dphp&_net_72))&(dplp&_net_68)))|((((((((_net_170|_net_169)|_net_168)|(dmisc&_net_98))|((djsr&_net_77)&rdy))|(djsr&_net_75))|(dphp&_net_72))|(dplp&_net_68))&(drti&_net_64)))|(((((((((_net_170|_net_169)|_net_168)|(dmisc&_net_98))|((djsr&_net_77)&rdy))|(djsr&_net_75))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))&((drti&_net_63)&rdy)))|((((((((((_net_170|_net_169)|_net_168)|(dmisc&_net_98))|((djsr&_net_77)&rdy))|(djsr&_net_75))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_63)&rdy))&((drti&_net_62)&rdy)))|(((((((((((_net_170|_net_169)|_net_168)|(dmisc&_net_98))|((djsr&_net_77)&rdy))|(djsr&_net_75))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))&(drts&_net_60)))|((((((((((((_net_170|_net_169)|_net_168)|(dmisc&_net_98))|((djsr&_net_77)&rdy))|(djsr&_net_75))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))|(drts&_net_60))&((drts&_net_59)&rdy))))
 begin $display("Warning: assign collision(m65s:RS) at %d",$time);

  end
 end
 else 
 $display("Warning: register set hazard(m65s:RS) at %d",$time);

  end

// synthesis translate_on
// synopsys translate_on
always @(posedge m_clock)
  begin

// synthesis translate_off
// synopsys translate_off
if ((((((((rmw&mimp)&(((dcmp&_net_134)&rdy)&_net_135))|(((rmw&mimp)|(((dcmp&_net_134)&rdy)&_net_135))&((dlda&_net_133)&rdy)))|((((rmw&mimp)|(((dcmp&_net_134)&rdy)&_net_135))|((dlda&_net_133)&rdy))&((dora&_net_122)&rdy)))|(((((rmw&mimp)|(((dcmp&_net_134)&rdy)&_net_135))|((dlda&_net_133)&rdy))|((dora&_net_122)&rdy))&(dmisc&_net_100)))|((((((rmw&mimp)|(((dcmp&_net_134)&rdy)&_net_135))|((dlda&_net_133)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_100))&(dmisc&_net_99)))|(((((((rmw&mimp)|(((dcmp&_net_134)&rdy)&_net_135))|((dlda&_net_133)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_100))|(dmisc&_net_99))&((dplp&_net_65)&_net_66))))   RA <= 8'bx; 
  else 
// synthesis translate_on
// synopsys translate_on
if ((rmw&mimp))
      RA <= _alu_out;
else if ((((dcmp&_net_134)&rdy)&_net_135))
      RA <= _alu_out;
else if (((dlda&_net_133)&rdy))
      RA <= _alu_out;
else if (((dora&_net_122)&rdy))
      RA <= _alu_out;
else if ((dmisc&_net_100))
      RA <= _alu_out;
else if ((dmisc&_net_99))
      RA <= _alu_out;
else if (((dplp&_net_65)&_net_66))
      RA <= _alu_out;
end

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if (((((((((rmw&mimp)|(((dcmp&_net_134)&rdy)&_net_135))|((dlda&_net_133)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_100))|(dmisc&_net_99))|((dplp&_net_65)&_net_66))==1'b1) ||
 ((((((((rmw&mimp)|(((dcmp&_net_134)&rdy)&_net_135))|((dlda&_net_133)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_100))|(dmisc&_net_99))|((dplp&_net_65)&_net_66))==1'b0) ) begin
 if ((((((((rmw&mimp)&(((dcmp&_net_134)&rdy)&_net_135))|(((rmw&mimp)|(((dcmp&_net_134)&rdy)&_net_135))&((dlda&_net_133)&rdy)))|((((rmw&mimp)|(((dcmp&_net_134)&rdy)&_net_135))|((dlda&_net_133)&rdy))&((dora&_net_122)&rdy)))|(((((rmw&mimp)|(((dcmp&_net_134)&rdy)&_net_135))|((dlda&_net_133)&rdy))|((dora&_net_122)&rdy))&(dmisc&_net_100)))|((((((rmw&mimp)|(((dcmp&_net_134)&rdy)&_net_135))|((dlda&_net_133)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_100))&(dmisc&_net_99)))|(((((((rmw&mimp)|(((dcmp&_net_134)&rdy)&_net_135))|((dlda&_net_133)&rdy))|((dora&_net_122)&rdy))|(dmisc&_net_100))|(dmisc&_net_99))&((dplp&_net_65)&_net_66))))
 begin $display("Warning: assign collision(m65s:RA) at %d",$time);

  end
 end
 else 
 $display("Warning: register set hazard(m65s:RA) at %d",$time);

  end

// synthesis translate_on
// synopsys translate_on
always @(posedge m_clock)
  begin

// synthesis translate_off
// synopsys translate_off
if ((((((((((((_net_173&rdy)&_net_171)|(((_net_173&rdy)|_net_171)&(((dbc&_net_156)&taken)&rdy)))|((((_net_173&rdy)|_net_171)|(((dbc&_net_156)&taken)&rdy))&nif2))|(((((_net_173&rdy)|_net_171)|(((dbc&_net_156)&taken)&rdy))|nif2)&nif1))|((((((_net_173&rdy)|_net_171)|(((dbc&_net_156)&taken)&rdy))|nif2)|nif1)&((djmp&_net_80)&rdy)))|(((((((_net_173&rdy)|_net_171)|(((dbc&_net_156)&taken)&rdy))|nif2)|nif1)|((djmp&_net_80)&rdy))&((djmp&_net_78)&rdy)))|((((((((_net_173&rdy)|_net_171)|(((dbc&_net_156)&taken)&rdy))|nif2)|nif1)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))&(djsr&_net_76)))|(((((((((_net_173&rdy)|_net_171)|(((dbc&_net_156)&taken)&rdy))|nif2)|nif1)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|(djsr&_net_76))&((djsr&_net_73)&rdy)))|((((((((((_net_173&rdy)|_net_171)|(((dbc&_net_156)&taken)&rdy))|nif2)|nif1)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|(djsr&_net_76))|((djsr&_net_73)&rdy))&((drti&_net_61)&rdy)))|(((((((((((_net_173&rdy)|_net_171)|(((dbc&_net_156)&taken)&rdy))|nif2)|nif1)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|(djsr&_net_76))|((djsr&_net_73)&rdy))|((drti&_net_61)&rdy))&((drts&_net_57)&rdy))))   PCL <= 8'bx; 
  else 
// synthesis translate_on
// synopsys translate_on
if ((_net_173&rdy))
      PCL <= DL;
else if (_net_171)
      PCL <= ABLin;
else if ((((dbc&_net_156)&taken)&rdy))
      PCL <= _alu_out;
else if (nif2)
      PCL <= (_incr_out[7:0]);
else if (nif1)
      PCL <= (_incr_out[7:0]);
else if (((djmp&_net_80)&rdy))
      PCL <= DL;
else if (((djmp&_net_78)&rdy))
      PCL <= DL;
else if ((djsr&_net_76))
      PCL <= (_incr_out[7:0]);
else if (((djsr&_net_73)&rdy))
      PCL <= DL;
else if (((drti&_net_61)&rdy))
      PCL <= DL;
else if (((drts&_net_57)&rdy))
      PCL <= _alu_out;
end

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if (((((((((((((_net_173&rdy)|_net_171)|(((dbc&_net_156)&taken)&rdy))|nif2)|nif1)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|(djsr&_net_76))|((djsr&_net_73)&rdy))|((drti&_net_61)&rdy))|((drts&_net_57)&rdy))==1'b1) ||
 ((((((((((((_net_173&rdy)|_net_171)|(((dbc&_net_156)&taken)&rdy))|nif2)|nif1)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|(djsr&_net_76))|((djsr&_net_73)&rdy))|((drti&_net_61)&rdy))|((drts&_net_57)&rdy))==1'b0) ) begin
 if ((((((((((((_net_173&rdy)&_net_171)|(((_net_173&rdy)|_net_171)&(((dbc&_net_156)&taken)&rdy)))|((((_net_173&rdy)|_net_171)|(((dbc&_net_156)&taken)&rdy))&nif2))|(((((_net_173&rdy)|_net_171)|(((dbc&_net_156)&taken)&rdy))|nif2)&nif1))|((((((_net_173&rdy)|_net_171)|(((dbc&_net_156)&taken)&rdy))|nif2)|nif1)&((djmp&_net_80)&rdy)))|(((((((_net_173&rdy)|_net_171)|(((dbc&_net_156)&taken)&rdy))|nif2)|nif1)|((djmp&_net_80)&rdy))&((djmp&_net_78)&rdy)))|((((((((_net_173&rdy)|_net_171)|(((dbc&_net_156)&taken)&rdy))|nif2)|nif1)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))&(djsr&_net_76)))|(((((((((_net_173&rdy)|_net_171)|(((dbc&_net_156)&taken)&rdy))|nif2)|nif1)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|(djsr&_net_76))&((djsr&_net_73)&rdy)))|((((((((((_net_173&rdy)|_net_171)|(((dbc&_net_156)&taken)&rdy))|nif2)|nif1)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|(djsr&_net_76))|((djsr&_net_73)&rdy))&((drti&_net_61)&rdy)))|(((((((((((_net_173&rdy)|_net_171)|(((dbc&_net_156)&taken)&rdy))|nif2)|nif1)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|(djsr&_net_76))|((djsr&_net_73)&rdy))|((drti&_net_61)&rdy))&((drts&_net_57)&rdy))))
 begin $display("Warning: assign collision(m65s:PCL) at %d",$time);

  end
 end
 else 
 $display("Warning: register set hazard(m65s:PCL) at %d",$time);

  end

// synthesis translate_on
// synopsys translate_on
always @(posedge m_clock)
  begin

// synthesis translate_off
// synopsys translate_off
if ((((((((((((((((_net_172&rdy)&((rmw&_net_143)&rdy))|(((_net_172&rdy)|((rmw&_net_143)&rdy))&(((ea&mzpxi)&_net_121)&rdy)))|((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))&(((ea&mzpxi)&_net_120)&rdy)))|(((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))&(((ea&mabs)&_net_118)&rdy)))|((((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mabs)&_net_118)&rdy))&(((ea&mzpiy)&_net_116)&rdy)))|(((((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mabs)&_net_118)&rdy))|(((ea&mzpiy)&_net_116)&rdy))&(((ea&mzpiy)&_net_115)&rdy)))|((((((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mabs)&_net_118)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))&(((ea&mzpiy)&_net_113)&rdy)))|(((((((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mabs)&_net_118)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))&(((ea&maby)&_net_103)&rdy)))|((((((((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mabs)&_net_118)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|(((ea&maby)&_net_103)&rdy))&(djmp&_net_83)))|(((((((((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mabs)&_net_118)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|(((ea&maby)&_net_103)&rdy))|(djmp&_net_83))&((djmp&_net_79)&rdy)))|((((((((((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mabs)&_net_118)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|(((ea&maby)&_net_103)&rdy))|(djmp&_net_83))|((djmp&_net_79)&rdy))&(djsr&_net_77)))|(((((((((((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mabs)&_net_118)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|(((ea&maby)&_net_103)&rdy))|(djmp&_net_83))|((djmp&_net_79)&rdy))|(djsr&_net_77))&((drti&_net_62)&rdy)))|((((((((((((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mabs)&_net_118)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|(((ea&maby)&_net_103)&rdy))|(djmp&_net_83))|((djmp&_net_79)&rdy))|(djsr&_net_77))|((drti&_net_62)&rdy))&(drts&_net_59)))|(((((((((((((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mabs)&_net_118)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|(((ea&maby)&_net_103)&rdy))|(djmp&_net_83))|((djmp&_net_79)&rdy))|(djsr&_net_77))|((drti&_net_62)&rdy))|(drts&_net_59))&((drts&_net_57)&rdy))))   DL <= 8'bx; 
  else 
// synthesis translate_on
// synopsys translate_on
if ((_net_172&rdy))
      DL <= dbi;
else if (((rmw&_net_143)&rdy))
      DL <= dbi;
else if ((((ea&mzpxi)&_net_121)&rdy))
      DL <= dbi;
else if ((((ea&mzpxi)&_net_120)&rdy))
      DL <= dbi;
else if ((((ea&mabs)&_net_118)&rdy))
      DL <= dbi;
else if ((((ea&mzpiy)&_net_116)&rdy))
      DL <= dbi;
else if ((((ea&mzpiy)&_net_115)&rdy))
      DL <= dbi;
else if ((((ea&mzpiy)&_net_113)&rdy))
      DL <= dbi;
else if ((((ea&maby)&_net_103)&rdy))
      DL <= dbi;
else if ((djmp&_net_83))
      DL <= dbi;
else if (((djmp&_net_79)&rdy))
      DL <= dbi;
else if ((djsr&_net_77))
      DL <= dbi;
else if (((drti&_net_62)&rdy))
      DL <= dbi;
else if ((drts&_net_59))
      DL <= dbi;
else if (((drts&_net_57)&rdy))
      DL <= dbi;
end

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if (((((((((((((((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mabs)&_net_118)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|(((ea&maby)&_net_103)&rdy))|(djmp&_net_83))|((djmp&_net_79)&rdy))|(djsr&_net_77))|((drti&_net_62)&rdy))|(drts&_net_59))|((drts&_net_57)&rdy))==1'b1) ||
 ((((((((((((((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mabs)&_net_118)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|(((ea&maby)&_net_103)&rdy))|(djmp&_net_83))|((djmp&_net_79)&rdy))|(djsr&_net_77))|((drti&_net_62)&rdy))|(drts&_net_59))|((drts&_net_57)&rdy))==1'b0) ) begin
 if ((((((((((((((((_net_172&rdy)&((rmw&_net_143)&rdy))|(((_net_172&rdy)|((rmw&_net_143)&rdy))&(((ea&mzpxi)&_net_121)&rdy)))|((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))&(((ea&mzpxi)&_net_120)&rdy)))|(((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))&(((ea&mabs)&_net_118)&rdy)))|((((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mabs)&_net_118)&rdy))&(((ea&mzpiy)&_net_116)&rdy)))|(((((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mabs)&_net_118)&rdy))|(((ea&mzpiy)&_net_116)&rdy))&(((ea&mzpiy)&_net_115)&rdy)))|((((((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mabs)&_net_118)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))&(((ea&mzpiy)&_net_113)&rdy)))|(((((((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mabs)&_net_118)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))&(((ea&maby)&_net_103)&rdy)))|((((((((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mabs)&_net_118)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|(((ea&maby)&_net_103)&rdy))&(djmp&_net_83)))|(((((((((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mabs)&_net_118)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|(((ea&maby)&_net_103)&rdy))|(djmp&_net_83))&((djmp&_net_79)&rdy)))|((((((((((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mabs)&_net_118)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|(((ea&maby)&_net_103)&rdy))|(djmp&_net_83))|((djmp&_net_79)&rdy))&(djsr&_net_77)))|(((((((((((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mabs)&_net_118)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|(((ea&maby)&_net_103)&rdy))|(djmp&_net_83))|((djmp&_net_79)&rdy))|(djsr&_net_77))&((drti&_net_62)&rdy)))|((((((((((((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mabs)&_net_118)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|(((ea&maby)&_net_103)&rdy))|(djmp&_net_83))|((djmp&_net_79)&rdy))|(djsr&_net_77))|((drti&_net_62)&rdy))&(drts&_net_59)))|(((((((((((((((_net_172&rdy)|((rmw&_net_143)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mabs)&_net_118)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|(((ea&maby)&_net_103)&rdy))|(djmp&_net_83))|((djmp&_net_79)&rdy))|(djsr&_net_77))|((drti&_net_62)&rdy))|(drts&_net_59))&((drts&_net_57)&rdy))))
 begin $display("Warning: assign collision(m65s:DL) at %d",$time);

  end
 end
 else 
 $display("Warning: register set hazard(m65s:DL) at %d",$time);

  end

// synthesis translate_on
// synopsys translate_on
always @(posedge m_clock)
  begin
if ((ift_run&_net_162))
      OP <= dbi;
end
always @(posedge m_clock)
  begin

// synthesis translate_off
// synopsys translate_off
if ((((((((((((((((((((((((((((((_net_173&rdy)&_net_171)|(((_net_173&rdy)|_net_171)&(_net_166&_net_167)))|((((_net_173&rdy)|_net_171)|(_net_166&_net_167))&(dbc&_net_155)))|(((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))&(dbc&_net_154)))|((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))&(((ea&mzpxi)&_net_121)&rdy)))|(((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))&(((ea&mzpxi)&_net_119)&rdy)))|((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))&(((ea&mabs)&_net_117)&rdy)))|(((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))&(((ea&mzpiy)&_net_116)&rdy)))|((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))&(((ea&mzpiy)&_net_115)&rdy)))|(((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))&(((ea&mzpiy)&_net_113)&rdy)))|((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))&((ea&mzpiy)&_net_112)))|(((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))&(((ea&mzpx)&_net_108)&rdy)))|((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))&(((ea&maby)&_net_103)&rdy)))|(((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))&((ea&maby)&_net_102)))|((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))&nif1))|(((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)&nif0))|((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)&((djmp&_net_80)&rdy)))|(((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))&((djmp&_net_78)&rdy)))|((((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))&((djsr&_net_77)&rdy)))|(((((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))&(djsr&_net_75)))|((((((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))&((djsr&_net_73)&rdy)))|(((((((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))&(dphp&_net_72)))|((((((((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))&(dplp&_net_68)))|(((((((((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))&(drti&_net_64)))|((((((((((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))&((drti&_net_61)&rdy)))|(((((((((((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_61)&rdy))&(drts&_net_60)))|((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_61)&rdy))|(drts&_net_60))&((drts&_net_57)&rdy)))|(((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_61)&rdy))|(drts&_net_60))|((drts&_net_57)&rdy))&(drts&_net_56))))   rABH <= 8'bx; 
  else 
// synthesis translate_on
// synopsys translate_on
if ((_net_173&rdy))
      rABH <= (dbi&8'b11111111);
else if (_net_171)
      rABH <= 8'b11111111;
else if ((_net_166&_net_167))
      rABH <= (8'b00000001&8'b11111111);
else if ((dbc&_net_155))
      rABH <= (_alu_out&8'b11111111);
else if ((dbc&_net_154))
      rABH <= (_alu_out&8'b11111111);
else if ((((ea&mzpxi)&_net_121)&rdy))
      rABH <= (8'b00000000&8'b11111111);
else if ((((ea&mzpxi)&_net_119)&rdy))
      rABH <= (dbi&8'b11111111);
else if ((((ea&mabs)&_net_117)&rdy))
      rABH <= (dbi&8'b11111111);
else if ((((ea&mzpiy)&_net_116)&rdy))
      rABH <= (8'b00000000&8'b11111111);
else if ((((ea&mzpiy)&_net_115)&rdy))
      rABH <= (8'b00000000&8'b11111111);
else if ((((ea&mzpiy)&_net_113)&rdy))
      rABH <= (dbi&8'b11111111);
else if (((ea&mzpiy)&_net_112))
      rABH <= (_alu_out&8'b11111111);
else if ((((ea&mzpx)&_net_108)&rdy))
      rABH <= (8'b00000000&8'b11111111);
else if ((((ea&maby)&_net_103)&rdy))
      rABH <= (dbi&8'b11111111);
else if (((ea&maby)&_net_102))
      rABH <= (_alu_out&8'b11111111);
else if (nif1)
      rABH <= ((_incr_out[15:8])&8'b11111111);
else if (nif0)
      rABH <= ((_incr_out[15:8])&8'b11111111);
else if (((djmp&_net_80)&rdy))
      rABH <= (dbi&8'b11111111);
else if (((djmp&_net_78)&rdy))
      rABH <= (dbi&8'b11111111);
else if (((djsr&_net_77)&rdy))
      rABH <= (8'b00000001&8'b11111111);
else if ((djsr&_net_75))
      rABH <= (8'b00000001&8'b11111111);
else if (((djsr&_net_73)&rdy))
      rABH <= (dbi&8'b11111111);
else if ((dphp&_net_72))
      rABH <= (8'b00000001&8'b11111111);
else if ((dplp&_net_68))
      rABH <= (8'b00000001&8'b11111111);
else if ((drti&_net_64))
      rABH <= (8'b00000001&8'b11111111);
else if (((drti&_net_61)&rdy))
      rABH <= (dbi&8'b11111111);
else if ((drts&_net_60))
      rABH <= (8'b00000001&8'b11111111);
else if (((drts&_net_57)&rdy))
      rABH <= (dbi&8'b11111111);
else if ((drts&_net_56))
      rABH <= (_alu_out&8'b11111111);
end

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if (((((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_61)&rdy))|(drts&_net_60))|((drts&_net_57)&rdy))|(drts&_net_56))==1'b1) ||
 ((((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_61)&rdy))|(drts&_net_60))|((drts&_net_57)&rdy))|(drts&_net_56))==1'b0) ) begin
 if ((((((((((((((((((((((((((((((_net_173&rdy)&_net_171)|(((_net_173&rdy)|_net_171)&(_net_166&_net_167)))|((((_net_173&rdy)|_net_171)|(_net_166&_net_167))&(dbc&_net_155)))|(((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))&(dbc&_net_154)))|((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))&(((ea&mzpxi)&_net_121)&rdy)))|(((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))&(((ea&mzpxi)&_net_119)&rdy)))|((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))&(((ea&mabs)&_net_117)&rdy)))|(((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))&(((ea&mzpiy)&_net_116)&rdy)))|((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))&(((ea&mzpiy)&_net_115)&rdy)))|(((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))&(((ea&mzpiy)&_net_113)&rdy)))|((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))&((ea&mzpiy)&_net_112)))|(((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))&(((ea&mzpx)&_net_108)&rdy)))|((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))&(((ea&maby)&_net_103)&rdy)))|(((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))&((ea&maby)&_net_102)))|((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))&nif1))|(((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)&nif0))|((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)&((djmp&_net_80)&rdy)))|(((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))&((djmp&_net_78)&rdy)))|((((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))&((djsr&_net_77)&rdy)))|(((((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))&(djsr&_net_75)))|((((((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))&((djsr&_net_73)&rdy)))|(((((((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))&(dphp&_net_72)))|((((((((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))&(dplp&_net_68)))|(((((((((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))&(drti&_net_64)))|((((((((((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))&((drti&_net_61)&rdy)))|(((((((((((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_61)&rdy))&(drts&_net_60)))|((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_61)&rdy))|(drts&_net_60))&((drts&_net_57)&rdy)))|(((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|(_net_166&_net_167))|(dbc&_net_155))|(dbc&_net_154))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((ea&mzpiy)&_net_112))|(((ea&mzpx)&_net_108)&rdy))|(((ea&maby)&_net_103)&rdy))|((ea&maby)&_net_102))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_61)&rdy))|(drts&_net_60))|((drts&_net_57)&rdy))&(drts&_net_56))))
 begin $display("Warning: assign collision(m65s:rABH) at %d",$time);

  end
 end
 else 
 $display("Warning: register set hazard(m65s:rABH) at %d",$time);

  end

// synthesis translate_on
// synopsys translate_on
always @(posedge m_clock)
  begin

// synthesis translate_off
// synopsys translate_off
if (((((((((((((((((((((((((((((((((((((_net_173&rdy)&_net_171)|(((_net_173&rdy)|_net_171)&_net_170))|((((_net_173&rdy)|_net_171)|_net_170)&_net_169))|(((((_net_173&rdy)|_net_171)|_net_170)|_net_169)&_net_168))|((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)&(_net_166&_net_167)))|(((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))&(((dbc&_net_156)&taken)&rdy)))|((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))&(((ea&mzpxi)&_net_121)&rdy)))|(((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))&(((ea&mzpxi)&_net_120)&rdy)))|((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))&(((ea&mzpxi)&_net_119)&rdy)))|(((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))&(((ea&mabs)&_net_117)&rdy)))|((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))&(((ea&mzpiy)&_net_116)&rdy)))|(((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))&(((ea&mzpiy)&_net_115)&rdy)))|((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))&(((ea&mzpiy)&_net_113)&rdy)))|(((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))&((((ea&mzpx)&_net_108)&rdy)&_net_111)))|((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))&((((ea&mzpx)&_net_108)&rdy)&_net_110)))|(((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))&((((ea&mzpx)&_net_108)&rdy)&_net_109)))|((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))&((((ea&maby)&_net_103)&rdy)&_net_105)))|(((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))&((((ea&maby)&_net_103)&rdy)&_net_104)))|((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))&nif1))|(((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)&nif0))|((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)&((djmp&_net_80)&rdy)))|(((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))&((djmp&_net_79)&rdy)))|((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))&((djmp&_net_78)&rdy)))|(((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))&((djsr&_net_77)&rdy)))|((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))&(djsr&_net_75)))|(((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))&((djsr&_net_73)&rdy)))|((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))&(dphp&_net_72)))|(((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))&(dplp&_net_68)))|((((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))&(drti&_net_64)))|(((((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))&((drti&_net_63)&rdy)))|((((((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_63)&rdy))&((drti&_net_62)&rdy)))|(((((((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))&((drti&_net_61)&rdy)))|((((((((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))|((drti&_net_61)&rdy))&(drts&_net_60)))|(((((((((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))|((drti&_net_61)&rdy))|(drts&_net_60))&((drts&_net_59)&rdy)))|((((((((((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))|((drti&_net_61)&rdy))|(drts&_net_60))|((drts&_net_59)&rdy))&((drts&_net_57)&rdy))))   rABL <= 8'bx; 
  else 
// synthesis translate_on
// synopsys translate_on
if ((_net_173&rdy))
      rABL <= DL;
else if (_net_171)
      rABL <= ABLin;
else if (_net_170)
      rABL <= _alu_out;
else if (_net_169)
      rABL <= _alu_out;
else if (_net_168)
      rABL <= _alu_out;
else if ((_net_166&_net_167))
      rABL <= RS;
else if ((((dbc&_net_156)&taken)&rdy))
      rABL <= _alu_out;
else if ((((ea&mzpxi)&_net_121)&rdy))
      rABL <= _alu_out;
else if ((((ea&mzpxi)&_net_120)&rdy))
      rABL <= _alu_out;
else if ((((ea&mzpxi)&_net_119)&rdy))
      rABL <= DL;
else if ((((ea&mabs)&_net_117)&rdy))
      rABL <= DL;
else if ((((ea&mzpiy)&_net_116)&rdy))
      rABL <= dbi;
else if ((((ea&mzpiy)&_net_115)&rdy))
      rABL <= _alu_out;
else if ((((ea&mzpiy)&_net_113)&rdy))
      rABL <= _alu_out;
else if (((((ea&mzpx)&_net_108)&rdy)&_net_111))
      rABL <= _alu_out;
else if (((((ea&mzpx)&_net_108)&rdy)&_net_110))
      rABL <= _alu_out;
else if (((((ea&mzpx)&_net_108)&rdy)&_net_109))
      rABL <= _alu_out;
else if (((((ea&maby)&_net_103)&rdy)&_net_105))
      rABL <= _alu_out;
else if (((((ea&maby)&_net_103)&rdy)&_net_104))
      rABL <= _alu_out;
else if (nif1)
      rABL <= (_incr_out[7:0]);
else if (nif0)
      rABL <= (_incr_out[7:0]);
else if (((djmp&_net_80)&rdy))
      rABL <= DL;
else if (((djmp&_net_79)&rdy))
      rABL <= _alu_out;
else if (((djmp&_net_78)&rdy))
      rABL <= DL;
else if (((djsr&_net_77)&rdy))
      rABL <= RS;
else if ((djsr&_net_75))
      rABL <= RS;
else if (((djsr&_net_73)&rdy))
      rABL <= DL;
else if ((dphp&_net_72))
      rABL <= RS;
else if ((dplp&_net_68))
      rABL <= _alu_out;
else if ((drti&_net_64))
      rABL <= _alu_out;
else if (((drti&_net_63)&rdy))
      rABL <= _alu_out;
else if (((drti&_net_62)&rdy))
      rABL <= _alu_out;
else if (((drti&_net_61)&rdy))
      rABL <= DL;
else if ((drts&_net_60))
      rABL <= _alu_out;
else if (((drts&_net_59)&rdy))
      rABL <= _alu_out;
else if (((drts&_net_57)&rdy))
      rABL <= _alu_out;
end

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((((((((((((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))|((drti&_net_61)&rdy))|(drts&_net_60))|((drts&_net_59)&rdy))|((drts&_net_57)&rdy))==1'b1) ||
 (((((((((((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))|((drti&_net_61)&rdy))|(drts&_net_60))|((drts&_net_59)&rdy))|((drts&_net_57)&rdy))==1'b0) ) begin
 if (((((((((((((((((((((((((((((((((((((_net_173&rdy)&_net_171)|(((_net_173&rdy)|_net_171)&_net_170))|((((_net_173&rdy)|_net_171)|_net_170)&_net_169))|(((((_net_173&rdy)|_net_171)|_net_170)|_net_169)&_net_168))|((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)&(_net_166&_net_167)))|(((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))&(((dbc&_net_156)&taken)&rdy)))|((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))&(((ea&mzpxi)&_net_121)&rdy)))|(((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))&(((ea&mzpxi)&_net_120)&rdy)))|((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))&(((ea&mzpxi)&_net_119)&rdy)))|(((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))&(((ea&mabs)&_net_117)&rdy)))|((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))&(((ea&mzpiy)&_net_116)&rdy)))|(((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))&(((ea&mzpiy)&_net_115)&rdy)))|((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))&(((ea&mzpiy)&_net_113)&rdy)))|(((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))&((((ea&mzpx)&_net_108)&rdy)&_net_111)))|((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))&((((ea&mzpx)&_net_108)&rdy)&_net_110)))|(((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))&((((ea&mzpx)&_net_108)&rdy)&_net_109)))|((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))&((((ea&maby)&_net_103)&rdy)&_net_105)))|(((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))&((((ea&maby)&_net_103)&rdy)&_net_104)))|((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))&nif1))|(((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)&nif0))|((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)&((djmp&_net_80)&rdy)))|(((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))&((djmp&_net_79)&rdy)))|((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))&((djmp&_net_78)&rdy)))|(((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))&((djsr&_net_77)&rdy)))|((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))&(djsr&_net_75)))|(((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))&((djsr&_net_73)&rdy)))|((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))&(dphp&_net_72)))|(((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))&(dplp&_net_68)))|((((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))&(drti&_net_64)))|(((((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))&((drti&_net_63)&rdy)))|((((((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_63)&rdy))&((drti&_net_62)&rdy)))|(((((((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))&((drti&_net_61)&rdy)))|((((((((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))|((drti&_net_61)&rdy))&(drts&_net_60)))|(((((((((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))|((drti&_net_61)&rdy))|(drts&_net_60))&((drts&_net_59)&rdy)))|((((((((((((((((((((((((((((((((((((_net_173&rdy)|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&_net_167))|(((dbc&_net_156)&taken)&rdy))|(((ea&mzpxi)&_net_121)&rdy))|(((ea&mzpxi)&_net_120)&rdy))|(((ea&mzpxi)&_net_119)&rdy))|(((ea&mabs)&_net_117)&rdy))|(((ea&mzpiy)&_net_116)&rdy))|(((ea&mzpiy)&_net_115)&rdy))|(((ea&mzpiy)&_net_113)&rdy))|((((ea&mzpx)&_net_108)&rdy)&_net_111))|((((ea&mzpx)&_net_108)&rdy)&_net_110))|((((ea&mzpx)&_net_108)&rdy)&_net_109))|((((ea&maby)&_net_103)&rdy)&_net_105))|((((ea&maby)&_net_103)&rdy)&_net_104))|nif1)|nif0)|((djmp&_net_80)&rdy))|((djmp&_net_79)&rdy))|((djmp&_net_78)&rdy))|((djsr&_net_77)&rdy))|(djsr&_net_75))|((djsr&_net_73)&rdy))|(dphp&_net_72))|(dplp&_net_68))|(drti&_net_64))|((drti&_net_63)&rdy))|((drti&_net_62)&rdy))|((drti&_net_61)&rdy))|(drts&_net_60))|((drts&_net_59)&rdy))&((drts&_net_57)&rdy))))
 begin $display("Warning: assign collision(m65s:rABL) at %d",$time);

  end
 end
 else 
 $display("Warning: register set hazard(m65s:rABL) at %d",$time);

  end

// synthesis translate_on
// synopsys translate_on
always @(posedge m_clock)
  begin

// synthesis translate_off
// synopsys translate_off
if ((((((((((((((_net_173&rdy)&_net_171)|(((_net_173&rdy)|_net_171)&(dbc&_net_155)))|((((_net_173&rdy)|_net_171)|(dbc&_net_155))&(dbc&_net_154)))|(((((_net_173&rdy)|_net_171)|(dbc&_net_155))|(dbc&_net_154))&nif2))|((((((_net_173&rdy)|_net_171)|(dbc&_net_155))|(dbc&_net_154))|nif2)&nif1))|(((((((_net_173&rdy)|_net_171)|(dbc&_net_155))|(dbc&_net_154))|nif2)|nif1)&((djmp&_net_80)&rdy)))|((((((((_net_173&rdy)|_net_171)|(dbc&_net_155))|(dbc&_net_154))|nif2)|nif1)|((djmp&_net_80)&rdy))&((djmp&_net_78)&rdy)))|(((((((((_net_173&rdy)|_net_171)|(dbc&_net_155))|(dbc&_net_154))|nif2)|nif1)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))&(djsr&_net_76)))|((((((((((_net_173&rdy)|_net_171)|(dbc&_net_155))|(dbc&_net_154))|nif2)|nif1)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|(djsr&_net_76))&((djsr&_net_73)&rdy)))|(((((((((((_net_173&rdy)|_net_171)|(dbc&_net_155))|(dbc&_net_154))|nif2)|nif1)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|(djsr&_net_76))|((djsr&_net_73)&rdy))&((drti&_net_61)&rdy)))|((((((((((((_net_173&rdy)|_net_171)|(dbc&_net_155))|(dbc&_net_154))|nif2)|nif1)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|(djsr&_net_76))|((djsr&_net_73)&rdy))|((drti&_net_61)&rdy))&((drts&_net_57)&rdy)))|(((((((((((((_net_173&rdy)|_net_171)|(dbc&_net_155))|(dbc&_net_154))|nif2)|nif1)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|(djsr&_net_76))|((djsr&_net_73)&rdy))|((drti&_net_61)&rdy))|((drts&_net_57)&rdy))&(drts&_net_56))))   PCH <= 8'bx; 
  else 
// synthesis translate_on
// synopsys translate_on
if ((_net_173&rdy))
      PCH <= (dbi&8'b11111111);
else if (_net_171)
      PCH <= 8'b11111111;
else if ((dbc&_net_155))
      PCH <= (_alu_out&8'b11111111);
else if ((dbc&_net_154))
      PCH <= (_alu_out&8'b11111111);
else if (nif2)
      PCH <= ((_incr_out[15:8])&8'b11111111);
else if (nif1)
      PCH <= ((_incr_out[15:8])&8'b11111111);
else if (((djmp&_net_80)&rdy))
      PCH <= (dbi&8'b11111111);
else if (((djmp&_net_78)&rdy))
      PCH <= (dbi&8'b11111111);
else if ((djsr&_net_76))
      PCH <= ((_incr_out[15:8])&8'b11111111);
else if (((djsr&_net_73)&rdy))
      PCH <= (dbi&8'b11111111);
else if (((drti&_net_61)&rdy))
      PCH <= (dbi&8'b11111111);
else if (((drts&_net_57)&rdy))
      PCH <= (dbi&8'b11111111);
else if ((drts&_net_56))
      PCH <= (_alu_out&8'b11111111);
end

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if (((((((((((((((_net_173&rdy)|_net_171)|(dbc&_net_155))|(dbc&_net_154))|nif2)|nif1)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|(djsr&_net_76))|((djsr&_net_73)&rdy))|((drti&_net_61)&rdy))|((drts&_net_57)&rdy))|(drts&_net_56))==1'b1) ||
 ((((((((((((((_net_173&rdy)|_net_171)|(dbc&_net_155))|(dbc&_net_154))|nif2)|nif1)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|(djsr&_net_76))|((djsr&_net_73)&rdy))|((drti&_net_61)&rdy))|((drts&_net_57)&rdy))|(drts&_net_56))==1'b0) ) begin
 if ((((((((((((((_net_173&rdy)&_net_171)|(((_net_173&rdy)|_net_171)&(dbc&_net_155)))|((((_net_173&rdy)|_net_171)|(dbc&_net_155))&(dbc&_net_154)))|(((((_net_173&rdy)|_net_171)|(dbc&_net_155))|(dbc&_net_154))&nif2))|((((((_net_173&rdy)|_net_171)|(dbc&_net_155))|(dbc&_net_154))|nif2)&nif1))|(((((((_net_173&rdy)|_net_171)|(dbc&_net_155))|(dbc&_net_154))|nif2)|nif1)&((djmp&_net_80)&rdy)))|((((((((_net_173&rdy)|_net_171)|(dbc&_net_155))|(dbc&_net_154))|nif2)|nif1)|((djmp&_net_80)&rdy))&((djmp&_net_78)&rdy)))|(((((((((_net_173&rdy)|_net_171)|(dbc&_net_155))|(dbc&_net_154))|nif2)|nif1)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))&(djsr&_net_76)))|((((((((((_net_173&rdy)|_net_171)|(dbc&_net_155))|(dbc&_net_154))|nif2)|nif1)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|(djsr&_net_76))&((djsr&_net_73)&rdy)))|(((((((((((_net_173&rdy)|_net_171)|(dbc&_net_155))|(dbc&_net_154))|nif2)|nif1)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|(djsr&_net_76))|((djsr&_net_73)&rdy))&((drti&_net_61)&rdy)))|((((((((((((_net_173&rdy)|_net_171)|(dbc&_net_155))|(dbc&_net_154))|nif2)|nif1)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|(djsr&_net_76))|((djsr&_net_73)&rdy))|((drti&_net_61)&rdy))&((drts&_net_57)&rdy)))|(((((((((((((_net_173&rdy)|_net_171)|(dbc&_net_155))|(dbc&_net_154))|nif2)|nif1)|((djmp&_net_80)&rdy))|((djmp&_net_78)&rdy))|(djsr&_net_76))|((djsr&_net_73)&rdy))|((drti&_net_61)&rdy))|((drts&_net_57)&rdy))&(drts&_net_56))))
 begin $display("Warning: assign collision(m65s:PCH) at %d",$time);

  end
 end
 else 
 $display("Warning: register set hazard(m65s:PCH) at %d",$time);

  end

// synthesis translate_on
// synopsys translate_on
always @(posedge m_clock)
  begin
if (~p_reset)
     ift_run <= 1'b0;
else if ((_proc_ift_run_set|_proc_ift_run_reset))
      ift_run <= _proc_ift_run_set;
end
always @(posedge m_clock)
  begin
if (~p_reset)
     do_nmi <= 1'b0;
else if ((_proc_do_nmi_set|_proc_do_nmi_reset))
      do_nmi <= _proc_do_nmi_set;
end
always @(posedge m_clock)
  begin
if (~p_reset)
     do_irq <= 1'b0;
else if ((_proc_do_irq_set|_proc_do_irq_reset))
      do_irq <= _proc_do_irq_set;
end
always @(posedge m_clock)
  begin
if (~p_reset)
     do_brk <= 1'b0;
else if ((_proc_do_brk_set|_proc_do_brk_reset))
      do_brk <= _proc_do_brk_set;
end
always @(posedge m_clock)
  begin
if (~p_reset)
     do_res <= 1'b0;
else if ((_proc_do_res_set|_proc_do_res_reset))
      do_res <= _proc_do_res_set;
end
always @(posedge m_clock)
  begin
if (~p_reset)
     int_req <= 1'b0;
else if ((_proc_int_req_set|_proc_int_req_reset))
      int_req <= _proc_int_req_set;
end
always @(posedge m_clock)
  begin

// synthesis translate_off
// synopsys translate_off
if (((((((ex&s1)&(ex&s2))|(((ex&s1)|(ex&s2))&(ex&s3)))|((((ex&s1)|(ex&s2))|(ex&s3))&(ex&s4)))|(((((ex&s1)|(ex&s2))|(ex&s3))|(ex&s4))&(ex&s5)))|((((((ex&s1)|(ex&s2))|(ex&s3))|(ex&s4))|(ex&s5))&(((ift_run&_net_162)&rdy)&_net_164))))   ex_st <= 6'bx; 
  else 
// synthesis translate_on
// synopsys translate_on
if ((ex&s1))
      ex_st <= 6'b000010;
else if ((ex&s2))
      ex_st <= 6'b000100;
else if ((ex&s3))
      ex_st <= 6'b001000;
else if ((ex&s4))
      ex_st <= 6'b010000;
else if ((ex&s5))
      ex_st <= 6'b100000;
else if ((((ift_run&_net_162)&rdy)&_net_164))
      ex_st <= 6'b000001;
end

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((((((((ex&s1)|(ex&s2))|(ex&s3))|(ex&s4))|(ex&s5))|(((ift_run&_net_162)&rdy)&_net_164))==1'b1) ||
 (((((((ex&s1)|(ex&s2))|(ex&s3))|(ex&s4))|(ex&s5))|(((ift_run&_net_162)&rdy)&_net_164))==1'b0) ) begin
 if (((((((ex&s1)&(ex&s2))|(((ex&s1)|(ex&s2))&(ex&s3)))|((((ex&s1)|(ex&s2))|(ex&s3))&(ex&s4)))|(((((ex&s1)|(ex&s2))|(ex&s3))|(ex&s4))&(ex&s5)))|((((((ex&s1)|(ex&s2))|(ex&s3))|(ex&s4))|(ex&s5))&(((ift_run&_net_162)&rdy)&_net_164))))
 begin $display("Warning: assign collision(m65s:ex_st) at %d",$time);

  end
 end
 else 
 $display("Warning: register set hazard(m65s:ex_st) at %d",$time);

  end

// synthesis translate_on
// synopsys translate_on
always @(posedge m_clock)
  begin
if (_net_171)
      dbgreg <= ({PCH,PCL});
end
always @(posedge m_clock)
  begin
if (~p_reset)
     rdflg <= 1'b0;
else if (start)
      rdflg <= 1'b1;
end
always @(posedge m_clock)
  begin
  dbg_datai <= data;
end
always @(posedge m_clock)
  begin
if (~p_reset)
     ex <= 1'b0;
else if ((_proc_ex_set|_proc_ex_reset))
      ex <= _proc_ex_set;
end
always @(posedge m_clock)
  begin
if (~p_reset)
     _reg_165 <= 3'b000;
else 
// synthesis translate_off
// synopsys translate_off
if (((((((((_net_173&rdy)&(_net_172&rdy))|(((_net_173&rdy)|(_net_172&rdy))&_net_171))|((((_net_173&rdy)|(_net_172&rdy))|_net_171)&_net_170))|(((((_net_173&rdy)|(_net_172&rdy))|_net_171)|_net_170)&_net_169))|((((((_net_173&rdy)|(_net_172&rdy))|_net_171)|_net_170)|_net_169)&_net_168))|(((((((_net_173&rdy)|(_net_172&rdy))|_net_171)|_net_170)|_net_169)|_net_168)&(_net_166&do_res)))|((((((((_net_173&rdy)|(_net_172&rdy))|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&do_res))&(_net_166&_net_167))))   _reg_165 <= 3'bx; 
  else 
// synthesis translate_on
// synopsys translate_on
if ((_net_173&rdy))
      _reg_165 <= _state__reg_165_st0;
else if ((_net_172&rdy))
      _reg_165 <= _state__reg_165_st6;
else if (_net_171)
      _reg_165 <= _state__reg_165_st5;
else if (_net_170)
      _reg_165 <= _state__reg_165_st4;
else if (_net_169)
      _reg_165 <= _state__reg_165_st3;
else if (_net_168)
      _reg_165 <= _state__reg_165_st2;
else if ((_net_166&do_res))
      _reg_165 <= _state__reg_165_st4;
else if ((_net_166&_net_167))
      _reg_165 <= _state__reg_165_st1;
end

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((((((((((_net_173&rdy)|(_net_172&rdy))|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&do_res))|(_net_166&_net_167))==1'b1) ||
 (((((((((_net_173&rdy)|(_net_172&rdy))|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&do_res))|(_net_166&_net_167))==1'b0) ) begin
 if (((((((((_net_173&rdy)&(_net_172&rdy))|(((_net_173&rdy)|(_net_172&rdy))&_net_171))|((((_net_173&rdy)|(_net_172&rdy))|_net_171)&_net_170))|(((((_net_173&rdy)|(_net_172&rdy))|_net_171)|_net_170)&_net_169))|((((((_net_173&rdy)|(_net_172&rdy))|_net_171)|_net_170)|_net_169)&_net_168))|(((((((_net_173&rdy)|(_net_172&rdy))|_net_171)|_net_170)|_net_169)|_net_168)&(_net_166&do_res)))|((((((((_net_173&rdy)|(_net_172&rdy))|_net_171)|_net_170)|_net_169)|_net_168)|(_net_166&do_res))&(_net_166&_net_167))))
 begin $display("Warning: assign collision(m65s:_reg_165) at %d",$time);

  end
 end
 else 
 $display("Warning: register set hazard(m65s:_reg_165) at %d",$time);

  end

// synthesis translate_on
// synopsys translate_on
endmodule
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Fri Mar 25 01:56:01 2016
 Licensed to :EVALUATION USER
*/
