/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Wed Mar 16 01:27:09 2016
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
  wire _proc_exop_set;
  wire _proc_exop_reset;
  wire _proc_ofetch_set;
  wire _proc_ofetch_reset;
  wire _proc_ifetch_set;
  wire _proc_ifetch_reset;
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


// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock or posedge p_reset)
  begin
if ((((((((exec&_net_26)&(exec&_net_25))|(((exec&_net_26)|(exec&_net_25))&(exec&_net_24)))|((((exec&_net_26)|(exec&_net_25))|(exec&_net_24))&(exec&_net_23)))|(((((exec&_net_26)|(exec&_net_25))|(exec&_net_24))|(exec&_net_23))&(exec&_net_19)))|((((((exec&_net_26)|(exec&_net_25))|(exec&_net_24))|(exec&_net_23))|(exec&_net_19))&(exop&_net_6)))|(((((((exec&_net_26)|(exec&_net_25))|(exec&_net_24))|(exec&_net_23))|(exec&_net_19))|(exop&_net_6))&(exop&_net_5))))
 begin $display("Warning: assign collision(cpu:op1) at %d",$time);
if ((exec&_net_26)) $display("assert ((exec&_net_26)) line 85 at %d\n",$time);
if ((exec&_net_25)) $display("assert ((exec&_net_25)) line 86 at %d\n",$time);
if ((exec&_net_24)) $display("assert ((exec&_net_24)) line 87 at %d\n",$time);
if ((exec&_net_23)) $display("assert ((exec&_net_23)) line 88 at %d\n",$time);
if ((exec&_net_19)) $display("assert ((exec&_net_19)) line 92 at %d\n",$time);
if ((exop&_net_6)) $display("assert ((exop&_net_6)) line 73 at %d\n",$time);
if ((exop&_net_5)) $display("assert ((exop&_net_5)) line 74 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  op1 = 
// synthesis translate_off
// synopsys translate_off
((((((((exec&_net_26)&(exec&_net_25))|(((exec&_net_26)|(exec&_net_25))&(exec&_net_24)))|((((exec&_net_26)|(exec&_net_25))|(exec&_net_24))&(exec&_net_23)))|(((((exec&_net_26)|(exec&_net_25))|(exec&_net_24))|(exec&_net_23))&(exec&_net_19)))|((((((exec&_net_26)|(exec&_net_25))|(exec&_net_24))|(exec&_net_23))|(exec&_net_19))&(exop&_net_6)))|(((((((exec&_net_26)|(exec&_net_25))|(exec&_net_24))|(exec&_net_23))|(exec&_net_19))|(exop&_net_6))&(exop&_net_5))))? 8'bx :((((((((exec&_net_26)|(exec&_net_25))|(exec&_net_24))|(exec&_net_23))|(exec&_net_19))|(exop&_net_6))|(exop&_net_5)))? 
// synthesis translate_on
// synopsys translate_on
(((exec&_net_26))?a:8'b0)|
    (((exec&_net_25))?i:8'b0)|
    (((exec&_net_24))?a:8'b0)|
    (((exec&_net_23))?i:8'b0)|
    (((exec&_net_19))?a:8'b0)|
    (((exop&_net_6))?op:8'b0)|
    (((exop&_net_5))?a:8'b0)
// synthesis translate_off
// synopsys translate_off
:8'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock or posedge p_reset)
  begin
if ((((((((exec&_net_26)&(exec&_net_25))|(((exec&_net_26)|(exec&_net_25))&(exec&_net_24)))|((((exec&_net_26)|(exec&_net_25))|(exec&_net_24))&(exec&_net_23)))|(((((exec&_net_26)|(exec&_net_25))|(exec&_net_24))|(exec&_net_23))&(exec&_net_19)))|((((((exec&_net_26)|(exec&_net_25))|(exec&_net_24))|(exec&_net_23))|(exec&_net_19))&(exop&_net_6)))|(((((((exec&_net_26)|(exec&_net_25))|(exec&_net_24))|(exec&_net_23))|(exec&_net_19))|(exop&_net_6))&(exop&_net_5))))
 begin $display("Warning: assign collision(cpu:op2) at %d",$time);
if ((exec&_net_26)) $display("assert ((exec&_net_26)) line 85 at %d\n",$time);
if ((exec&_net_25)) $display("assert ((exec&_net_25)) line 86 at %d\n",$time);
if ((exec&_net_24)) $display("assert ((exec&_net_24)) line 87 at %d\n",$time);
if ((exec&_net_23)) $display("assert ((exec&_net_23)) line 88 at %d\n",$time);
if ((exec&_net_19)) $display("assert ((exec&_net_19)) line 92 at %d\n",$time);
if ((exop&_net_6)) $display("assert ((exop&_net_6)) line 73 at %d\n",$time);
if ((exop&_net_5)) $display("assert ((exop&_net_5)) line 74 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  op2 = 
// synthesis translate_off
// synopsys translate_off
((((((((exec&_net_26)&(exec&_net_25))|(((exec&_net_26)|(exec&_net_25))&(exec&_net_24)))|((((exec&_net_26)|(exec&_net_25))|(exec&_net_24))&(exec&_net_23)))|(((((exec&_net_26)|(exec&_net_25))|(exec&_net_24))|(exec&_net_23))&(exec&_net_19)))|((((((exec&_net_26)|(exec&_net_25))|(exec&_net_24))|(exec&_net_23))|(exec&_net_19))&(exop&_net_6)))|(((((((exec&_net_26)|(exec&_net_25))|(exec&_net_24))|(exec&_net_23))|(exec&_net_19))|(exop&_net_6))&(exop&_net_5))))? 8'bx :((((((((exec&_net_26)|(exec&_net_25))|(exec&_net_24))|(exec&_net_23))|(exec&_net_19))|(exop&_net_6))|(exop&_net_5)))? 
// synthesis translate_on
// synopsys translate_on
(((exec&_net_26))?8'b00000001:8'b0)|
    (((exec&_net_25))?8'b00000001:8'b0)|
    (((exec&_net_24))?8'b11111111:8'b0)|
    (((exec&_net_23))?8'b11111111:8'b0)|
    (((exec&_net_19))?i:8'b0)|
    (((exop&_net_6))?i:8'b0)|
    (((exop&_net_5))?op:8'b0)
// synthesis translate_off
// synopsys translate_off
:8'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  res = 
// synthesis translate_off
// synopsys translate_off
(add)? 
// synthesis translate_on
// synopsys translate_on
((add)?(op1+op2):8'b0)
// synthesis translate_off
// synopsys translate_off
:8'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  pco = 
// synthesis translate_off
// synopsys translate_off
(pcinc)? 
// synthesis translate_on
// synopsys translate_on
((pcinc)?pc:8'b0)
// synthesis translate_off
// synopsys translate_off
:8'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge pcinc)
  begin
#1 if (pcinc===1'bx)
 begin
$display("Warning: control hazard(cpu:pcinc) at %d",$time);
 end
#1 if ((((ofetch&_net_2))===1'bx) || (1'b1)===1'bx) $display("hazard ((ofetch&_net_2) || 1'b1) line 55 at %d\n",$time);
#1 if (((ifetch)===1'bx) || (1'b1)===1'bx) $display("hazard (ifetch || 1'b1) line 50 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  pcinc = (ofetch&_net_2)|
    ifetch;

// synthesis translate_off
// synopsys translate_off
always @(posedge add)
  begin
#1 if (add===1'bx)
 begin
$display("Warning: control hazard(cpu:add) at %d",$time);
 end
#1 if ((((exec&_net_26))===1'bx) || (1'b1)===1'bx) $display("hazard ((exec&_net_26) || 1'b1) line 85 at %d\n",$time);
#1 if ((((exec&_net_25))===1'bx) || (1'b1)===1'bx) $display("hazard ((exec&_net_25) || 1'b1) line 86 at %d\n",$time);
#1 if ((((exec&_net_24))===1'bx) || (1'b1)===1'bx) $display("hazard ((exec&_net_24) || 1'b1) line 87 at %d\n",$time);
#1 if ((((exec&_net_23))===1'bx) || (1'b1)===1'bx) $display("hazard ((exec&_net_23) || 1'b1) line 88 at %d\n",$time);
#1 if ((((exec&_net_19))===1'bx) || (1'b1)===1'bx) $display("hazard ((exec&_net_19) || 1'b1) line 92 at %d\n",$time);
#1 if ((((exop&_net_6))===1'bx) || (1'b1)===1'bx) $display("hazard ((exop&_net_6) || 1'b1) line 73 at %d\n",$time);
#1 if ((((exop&_net_5))===1'bx) || (1'b1)===1'bx) $display("hazard ((exop&_net_5) || 1'b1) line 74 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  add = (exec&_net_26)|
    (exec&_net_25)|
    (exec&_net_24)|
    (exec&_net_23)|
    (exec&_net_19)|
    (exop&_net_6)|
    (exop&_net_5);

// synthesis translate_off
// synopsys translate_off
always @(posedge br_taken)
  begin
#1 if (br_taken===1'bx)
 begin
$display("Warning: control hazard(cpu:br_taken) at %d",$time);
 end
#1 if ((((exop&_net_14))===1'bx) || (1'b1)===1'bx) $display("hazard ((exop&_net_14) || 1'b1) line 66 at %d\n",$time);
#1 if (((((exop&_net_12)&_net_13))===1'bx) || (1'b1)===1'bx) $display("hazard (((exop&_net_12)&_net_13) || 1'b1) line 67 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  br_taken = (exop&_net_14)|
    ((exop&_net_12)&_net_13);

// synthesis translate_off
// synopsys translate_off
always @(posedge _proc_exec_set)
  begin
#1 if (_proc_exec_set===1'bx)
 begin
$display("Warning: control hazard(cpu:_proc_exec_set) at %d",$time);
 end
#1 if ((((ofetch&(~_net_2)))===1'bx) || (1'b1)===1'bx) $display("hazard ((ofetch&(~_net_2)) || 1'b1) line 56 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _proc_exec_set = (ofetch&(~_net_2));

// synthesis translate_off
// synopsys translate_off
always @(posedge _proc_exec_reset)
  begin
#1 if (_proc_exec_reset===1'bx)
 begin
$display("Warning: control hazard(cpu:_proc_exec_reset) at %d",$time);
 end
#1 if (((exec)===1'bx) || (1'b1)===1'bx) $display("hazard (exec || 1'b1) line 96 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _proc_exec_reset = exec;

// synthesis translate_off
// synopsys translate_off
always @(posedge _proc_exop_set)
  begin
#1 if (_proc_exop_set===1'bx)
 begin
$display("Warning: control hazard(cpu:_proc_exop_set) at %d",$time);
 end
#1 if ((((ofetch&_net_2))===1'bx) || (1'b1)===1'bx) $display("hazard ((ofetch&_net_2) || 1'b1) line 55 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _proc_exop_set = (ofetch&_net_2);

// synthesis translate_off
// synopsys translate_off
always @(posedge _proc_exop_reset)
  begin
#1 if (_proc_exop_reset===1'bx)
 begin
$display("Warning: control hazard(cpu:_proc_exop_reset) at %d",$time);
 end
#1 if ((((exop&(~br_taken)))===1'bx) || (1'b1)===1'bx) $display("hazard ((exop&(~br_taken)) || 1'b1) line 79 at %d\n",$time);
#1 if ((((exop&br_taken))===1'bx) || (1'b1)===1'bx) $display("hazard ((exop&br_taken) || 1'b1) line 78 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _proc_exop_reset = (exop&(~br_taken))|
    (exop&br_taken);

// synthesis translate_off
// synopsys translate_off
always @(posedge _proc_ofetch_set)
  begin
#1 if (_proc_ofetch_set===1'bx)
 begin
$display("Warning: control hazard(cpu:_proc_ofetch_set) at %d",$time);
 end
#1 if (((ifetch)===1'bx) || (1'b1)===1'bx) $display("hazard (ifetch || 1'b1) line 50 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _proc_ofetch_set = ifetch;

// synthesis translate_off
// synopsys translate_off
always @(posedge _proc_ofetch_reset)
  begin
#1 if (_proc_ofetch_reset===1'bx)
 begin
$display("Warning: control hazard(cpu:_proc_ofetch_reset) at %d",$time);
 end
#1 if ((((ofetch&(~_net_2)))===1'bx) || (1'b1)===1'bx) $display("hazard ((ofetch&(~_net_2)) || 1'b1) line 56 at %d\n",$time);
#1 if ((((ofetch&_net_2))===1'bx) || (1'b1)===1'bx) $display("hazard ((ofetch&_net_2) || 1'b1) line 55 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _proc_ofetch_reset = (ofetch&(~_net_2))|
    (ofetch&_net_2);

// synthesis translate_off
// synopsys translate_off
always @(posedge _proc_ifetch_set)
  begin
#1 if (_proc_ifetch_set===1'bx)
 begin
$display("Warning: control hazard(cpu:_proc_ifetch_set) at %d",$time);
 end
#1 if (((exec)===1'bx) || (1'b1)===1'bx) $display("hazard (exec || 1'b1) line 96 at %d\n",$time);
#1 if ((((exop&(~br_taken)))===1'bx) || (1'b1)===1'bx) $display("hazard ((exop&(~br_taken)) || 1'b1) line 79 at %d\n",$time);
#1 if ((((exop&br_taken))===1'bx) || (1'b1)===1'bx) $display("hazard ((exop&br_taken) || 1'b1) line 78 at %d\n",$time);
#1 if (((_net_1)===1'bx) || (1'b1)===1'bx) $display("hazard (_net_1 || 1'b1) line 47 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _proc_ifetch_set = exec|
    (exop&(~br_taken))|
    (exop&br_taken)|
    _net_1;

// synthesis translate_off
// synopsys translate_off
always @(posedge _proc_ifetch_reset)
  begin
#1 if (_proc_ifetch_reset===1'bx)
 begin
$display("Warning: control hazard(cpu:_proc_ifetch_reset) at %d",$time);
 end
#1 if (((ifetch)===1'bx) || (1'b1)===1'bx) $display("hazard (ifetch || 1'b1) line 50 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  _proc_ifetch_reset = ifetch;
   assign  _net_0 = (count != 8'b00000000);
   assign  _net_1 = (count==8'b00000001);
   assign  _net_2 = 
// synthesis translate_off
// synopsys translate_off
(ofetch)? 
// synthesis translate_on
// synopsys translate_on
((ofetch)?(ins[7]):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_3 = 
// synthesis translate_off
// synopsys translate_off
(exop)? 
// synthesis translate_on
// synopsys translate_on
((exop)?(ins==8'b10101010):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_4 = 
// synthesis translate_off
// synopsys translate_off
(exop)? 
// synthesis translate_on
// synopsys translate_on
((exop)?(ins==8'b10101001):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_5 = 
// synthesis translate_off
// synopsys translate_off
(exop)? 
// synthesis translate_on
// synopsys translate_on
((exop)?(ins==8'b10101000):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_6 = 
// synthesis translate_off
// synopsys translate_off
(exop)? 
// synthesis translate_on
// synopsys translate_on
((exop)?(ins==8'b10011010):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_7 = 
// synthesis translate_off
// synopsys translate_off
(exop)? 
// synthesis translate_on
// synopsys translate_on
((exop)?(ins==8'b10011001):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_8 = 
// synthesis translate_off
// synopsys translate_off
(exop)? 
// synthesis translate_on
// synopsys translate_on
((exop)?(ins==8'b10011000):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_9 = 
// synthesis translate_off
// synopsys translate_off
(exop)? 
// synthesis translate_on
// synopsys translate_on
((exop)?(ins==8'b10001010):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_10 = 
// synthesis translate_off
// synopsys translate_off
(exop)? 
// synthesis translate_on
// synopsys translate_on
((exop)?(ins==8'b10001001):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_11 = 
// synthesis translate_off
// synopsys translate_off
(exop)? 
// synthesis translate_on
// synopsys translate_on
((exop)?(ins==8'b10001000):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_12 = 
// synthesis translate_off
// synopsys translate_off
(exop)? 
// synthesis translate_on
// synopsys translate_on
((exop)?(ins==8'b10000101):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_13 = 
// synthesis translate_off
// synopsys translate_off
((exop&_net_12))? 
// synthesis translate_on
// synopsys translate_on
(((exop&_net_12))?(a==8'b00000000):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_14 = 
// synthesis translate_off
// synopsys translate_off
(exop)? 
// synthesis translate_on
// synopsys translate_on
((exop)?(ins==8'b10000100):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_15 = 
// synthesis translate_off
// synopsys translate_off
(exop)? 
// synthesis translate_on
// synopsys translate_on
((exop)?(ins==8'b10000010):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_16 = 
// synthesis translate_off
// synopsys translate_off
(exop)? 
// synthesis translate_on
// synopsys translate_on
((exop)?(ins==8'b10000001):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_17 = 
// synthesis translate_off
// synopsys translate_off
(exec)? 
// synthesis translate_on
// synopsys translate_on
((exec)?(ins==8'b00001010):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_18 = 
// synthesis translate_off
// synopsys translate_off
(exec)? 
// synthesis translate_on
// synopsys translate_on
((exec)?(ins==8'b00001001):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_19 = 
// synthesis translate_off
// synopsys translate_off
(exec)? 
// synthesis translate_on
// synopsys translate_on
((exec)?(ins==8'b00001000):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_20 = 
// synthesis translate_off
// synopsys translate_off
(exec)? 
// synthesis translate_on
// synopsys translate_on
((exec)?(ins==8'b00000111):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_21 = 
// synthesis translate_off
// synopsys translate_off
(exec)? 
// synthesis translate_on
// synopsys translate_on
((exec)?(ins==8'b00000110):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_22 = 
// synthesis translate_off
// synopsys translate_off
(exec)? 
// synthesis translate_on
// synopsys translate_on
((exec)?(ins==8'b00000101):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_23 = 
// synthesis translate_off
// synopsys translate_off
(exec)? 
// synthesis translate_on
// synopsys translate_on
((exec)?(ins==8'b00000100):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_24 = 
// synthesis translate_off
// synopsys translate_off
(exec)? 
// synthesis translate_on
// synopsys translate_on
((exec)?(ins==8'b00000011):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_25 = 
// synthesis translate_off
// synopsys translate_off
(exec)? 
// synthesis translate_on
// synopsys translate_on
((exec)?(ins==8'b00000010):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;
   assign  _net_26 = 
// synthesis translate_off
// synopsys translate_off
(exec)? 
// synthesis translate_on
// synopsys translate_on
((exec)?(ins==8'b00000001):1'b0)
// synthesis translate_off
// synopsys translate_off
:1'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock or posedge p_reset)
  begin
if ((((exop&_net_8)&(exop&_net_7))|(((exop&_net_8)|(exop&_net_7))&(exop&_net_6))))
 begin $display("Warning: assign collision(cpu:dbuso) at %d",$time);
if ((exop&_net_8)) $display("assert ((exop&_net_8)) line 71 at %d\n",$time);
if ((exop&_net_7)) $display("assert ((exop&_net_7)) line 72 at %d\n",$time);
if ((exop&_net_6)) $display("assert ((exop&_net_6)) line 73 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  dbuso = 
// synthesis translate_off
// synopsys translate_off
((((exop&_net_8)&(exop&_net_7))|(((exop&_net_8)|(exop&_net_7))&(exop&_net_6))))? 8'bx :((((exop&_net_8)|(exop&_net_7))|(exop&_net_6)))? 
// synthesis translate_on
// synopsys translate_on
(((exop&_net_8))?a:8'b0)|
    (((exop&_net_7))?i:8'b0)|
    (((exop&_net_6))?a:8'b0)
// synthesis translate_off
// synopsys translate_off
:8'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock or posedge p_reset)
  begin
if (((((((((exop&_net_11)&(exop&_net_10))|(((exop&_net_11)|(exop&_net_10))&(exop&_net_9)))|((((exop&_net_11)|(exop&_net_10))|(exop&_net_9))&(exop&_net_8)))|(((((exop&_net_11)|(exop&_net_10))|(exop&_net_9))|(exop&_net_8))&(exop&_net_7)))|((((((exop&_net_11)|(exop&_net_10))|(exop&_net_9))|(exop&_net_8))|(exop&_net_7))&(exop&_net_6)))|(((((((exop&_net_11)|(exop&_net_10))|(exop&_net_9))|(exop&_net_8))|(exop&_net_7))|(exop&_net_6))&(ofetch&_net_2)))|((((((((exop&_net_11)|(exop&_net_10))|(exop&_net_9))|(exop&_net_8))|(exop&_net_7))|(exop&_net_6))|(ofetch&_net_2))&ifetch)))
 begin $display("Warning: assign collision(cpu:adder) at %d",$time);
if ((exop&_net_11)) $display("assert ((exop&_net_11)) line 68 at %d\n",$time);
if ((exop&_net_10)) $display("assert ((exop&_net_10)) line 69 at %d\n",$time);
if ((exop&_net_9)) $display("assert ((exop&_net_9)) line 70 at %d\n",$time);
if ((exop&_net_8)) $display("assert ((exop&_net_8)) line 71 at %d\n",$time);
if ((exop&_net_7)) $display("assert ((exop&_net_7)) line 72 at %d\n",$time);
if ((exop&_net_6)) $display("assert ((exop&_net_6)) line 73 at %d\n",$time);
if ((ofetch&_net_2)) $display("assert ((ofetch&_net_2)) line 55 at %d\n",$time);
if (ifetch) $display("assert (ifetch) line 50 at %d\n",$time);
 end
 end

// synthesis translate_on
// synopsys translate_on
   assign  adder = 
// synthesis translate_off
// synopsys translate_off
(((((((((exop&_net_11)&(exop&_net_10))|(((exop&_net_11)|(exop&_net_10))&(exop&_net_9)))|((((exop&_net_11)|(exop&_net_10))|(exop&_net_9))&(exop&_net_8)))|(((((exop&_net_11)|(exop&_net_10))|(exop&_net_9))|(exop&_net_8))&(exop&_net_7)))|((((((exop&_net_11)|(exop&_net_10))|(exop&_net_9))|(exop&_net_8))|(exop&_net_7))&(exop&_net_6)))|(((((((exop&_net_11)|(exop&_net_10))|(exop&_net_9))|(exop&_net_8))|(exop&_net_7))|(exop&_net_6))&(ofetch&_net_2)))|((((((((exop&_net_11)|(exop&_net_10))|(exop&_net_9))|(exop&_net_8))|(exop&_net_7))|(exop&_net_6))|(ofetch&_net_2))&ifetch)))? 8'bx :(((((((((exop&_net_11)|(exop&_net_10))|(exop&_net_9))|(exop&_net_8))|(exop&_net_7))|(exop&_net_6))|(ofetch&_net_2))|ifetch))? 
// synthesis translate_on
// synopsys translate_on
(((exop&_net_11))?op:8'b0)|
    (((exop&_net_10))?op:8'b0)|
    (((exop&_net_9))?(op+i):8'b0)|
    (((exop&_net_8))?op:8'b0)|
    (((exop&_net_7))?op:8'b0)|
    (((exop&_net_6))?res:8'b0)|
    (((ofetch&_net_2))?pco:8'b0)|
    ((ifetch)?pco:8'b0)
// synthesis translate_off
// synopsys translate_off
:8'bx
// synthesis translate_on
// synopsys translate_on
;

// synthesis translate_off
// synopsys translate_off
always @(posedge mread)
  begin
#1 if (mread===1'bx)
 begin
$display("Warning: control hazard(cpu:mread) at %d",$time);
 end
#1 if ((((exop&_net_11))===1'bx) || (1'b1)===1'bx) $display("hazard ((exop&_net_11) || 1'b1) line 68 at %d\n",$time);
#1 if ((((exop&_net_10))===1'bx) || (1'b1)===1'bx) $display("hazard ((exop&_net_10) || 1'b1) line 69 at %d\n",$time);
#1 if ((((exop&_net_9))===1'bx) || (1'b1)===1'bx) $display("hazard ((exop&_net_9) || 1'b1) line 70 at %d\n",$time);
#1 if ((((ofetch&_net_2))===1'bx) || (1'b1)===1'bx) $display("hazard ((ofetch&_net_2) || 1'b1) line 55 at %d\n",$time);
#1 if (((ifetch)===1'bx) || (1'b1)===1'bx) $display("hazard (ifetch || 1'b1) line 50 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  mread = (exop&_net_11)|
    (exop&_net_10)|
    (exop&_net_9)|
    (ofetch&_net_2)|
    ifetch;

// synthesis translate_off
// synopsys translate_off
always @(posedge mwrite)
  begin
#1 if (mwrite===1'bx)
 begin
$display("Warning: control hazard(cpu:mwrite) at %d",$time);
 end
#1 if ((((exop&_net_8))===1'bx) || (1'b1)===1'bx) $display("hazard ((exop&_net_8) || 1'b1) line 71 at %d\n",$time);
#1 if ((((exop&_net_7))===1'bx) || (1'b1)===1'bx) $display("hazard ((exop&_net_7) || 1'b1) line 72 at %d\n",$time);
#1 if ((((exop&_net_6))===1'bx) || (1'b1)===1'bx) $display("hazard ((exop&_net_6) || 1'b1) line 73 at %d\n",$time);
 end

// synthesis translate_on
// synopsys translate_on
   assign  mwrite = (exop&_net_8)|
    (exop&_net_7)|
    (exop&_net_6);
always @(posedge m_clock or posedge p_reset)
  begin
if (p_reset)
     pc <= 8'b00000000;
else 
// synthesis translate_off
// synopsys translate_off
if (((((exec&(exop&(~br_taken)))|((exec|(exop&(~br_taken)))&(exop&br_taken)))|(((exec|(exop&(~br_taken)))|(exop&br_taken))&_net_1))|((((exec|(exop&(~br_taken)))|(exop&br_taken))|_net_1)&pcinc)))   pc <= 8'bx; 
  else 
// synthesis translate_on
// synopsys translate_on
if (exec)
      pc <= pc;
else if ((exop&(~br_taken)))
      pc <= pc;
else if ((exop&br_taken))
      pc <= op;
else if (_net_1)
      pc <= 8'b00000000;
else if (pcinc)
      pc <= (pc+8'b00000001);
end

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((((((exec|(exop&(~br_taken)))|(exop&br_taken))|_net_1)|pcinc)==1'b1) ||
 (((((exec|(exop&(~br_taken)))|(exop&br_taken))|_net_1)|pcinc)==1'b0) ) begin
 if (((((exec&(exop&(~br_taken)))|((exec|(exop&(~br_taken)))&(exop&br_taken)))|(((exec|(exop&(~br_taken)))|(exop&br_taken))&_net_1))|((((exec|(exop&(~br_taken)))|(exop&br_taken))|_net_1)&pcinc)))
 begin $display("Warning: assign collision(cpu:pc) at %d",$time);

  end
 end
 else 
 $display("Warning: register set hazard(cpu:pc) at %d",$time);

  end

// synthesis translate_on
// synopsys translate_on
always @(posedge m_clock or posedge p_reset)
  begin
if (p_reset)
     ins <= 8'b00000000;
else if (ifetch)
      ins <= dbusi;
end
always @(posedge m_clock)
  begin
if ((ofetch&_net_2))
      op <= dbusi;
end
always @(posedge m_clock or posedge p_reset)
  begin
if (p_reset)
     count <= 8'b11111111;
else if (_net_0)
      count <= (count-8'b00000001);
end
always @(posedge m_clock or posedge p_reset)
  begin
if (p_reset)
     a <= 8'b00000000;
else 
// synthesis translate_off
// synopsys translate_off
if (((((((((((((((exec&_net_26)&(exec&_net_24))|(((exec&_net_26)|(exec&_net_24))&(exec&_net_22)))|((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))&(exec&_net_21)))|(((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))|(exec&_net_21))&(exec&_net_20)))|((((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))|(exec&_net_21))|(exec&_net_20))&(exec&_net_19)))|(((((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))|(exec&_net_21))|(exec&_net_20))|(exec&_net_19))&(exec&_net_18)))|((((((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))|(exec&_net_21))|(exec&_net_20))|(exec&_net_19))|(exec&_net_18))&(exec&_net_17)))|(((((((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))|(exec&_net_21))|(exec&_net_20))|(exec&_net_19))|(exec&_net_18))|(exec&_net_17))&(exop&_net_16)))|((((((((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))|(exec&_net_21))|(exec&_net_20))|(exec&_net_19))|(exec&_net_18))|(exec&_net_17))|(exop&_net_16))&(exop&_net_11)))|(((((((((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))|(exec&_net_21))|(exec&_net_20))|(exec&_net_19))|(exec&_net_18))|(exec&_net_17))|(exop&_net_16))|(exop&_net_11))&(exop&_net_9)))|((((((((((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))|(exec&_net_21))|(exec&_net_20))|(exec&_net_19))|(exec&_net_18))|(exec&_net_17))|(exop&_net_16))|(exop&_net_11))|(exop&_net_9))&(exop&_net_5)))|(((((((((((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))|(exec&_net_21))|(exec&_net_20))|(exec&_net_19))|(exec&_net_18))|(exec&_net_17))|(exop&_net_16))|(exop&_net_11))|(exop&_net_9))|(exop&_net_5))&(exop&_net_4)))|((((((((((((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))|(exec&_net_21))|(exec&_net_20))|(exec&_net_19))|(exec&_net_18))|(exec&_net_17))|(exop&_net_16))|(exop&_net_11))|(exop&_net_9))|(exop&_net_5))|(exop&_net_4))&(exop&_net_3))))   a <= 8'bx; 
  else 
// synthesis translate_on
// synopsys translate_on
if ((exec&_net_26))
      a <= res;
else if ((exec&_net_24))
      a <= res;
else if ((exec&_net_22))
      a <= ({1'b0,(a[7:1])});
else if ((exec&_net_21))
      a <= ({(a[6:0]),1'b0});
else if ((exec&_net_20))
      a <= ({(a[7]),(a[7:1])});
else if ((exec&_net_19))
      a <= res;
else if ((exec&_net_18))
      a <= (a&i);
else if ((exec&_net_17))
      a <= (a^i);
else if ((exop&_net_16))
      a <= op;
else if ((exop&_net_11))
      a <= dbusi;
else if ((exop&_net_9))
      a <= dbusi;
else if ((exop&_net_5))
      a <= res;
else if ((exop&_net_4))
      a <= (a&op);
else if ((exop&_net_3))
      a <= (a^op);
end

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((((((((((((((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))|(exec&_net_21))|(exec&_net_20))|(exec&_net_19))|(exec&_net_18))|(exec&_net_17))|(exop&_net_16))|(exop&_net_11))|(exop&_net_9))|(exop&_net_5))|(exop&_net_4))|(exop&_net_3))==1'b1) ||
 (((((((((((((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))|(exec&_net_21))|(exec&_net_20))|(exec&_net_19))|(exec&_net_18))|(exec&_net_17))|(exop&_net_16))|(exop&_net_11))|(exop&_net_9))|(exop&_net_5))|(exop&_net_4))|(exop&_net_3))==1'b0) ) begin
 if (((((((((((((((exec&_net_26)&(exec&_net_24))|(((exec&_net_26)|(exec&_net_24))&(exec&_net_22)))|((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))&(exec&_net_21)))|(((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))|(exec&_net_21))&(exec&_net_20)))|((((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))|(exec&_net_21))|(exec&_net_20))&(exec&_net_19)))|(((((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))|(exec&_net_21))|(exec&_net_20))|(exec&_net_19))&(exec&_net_18)))|((((((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))|(exec&_net_21))|(exec&_net_20))|(exec&_net_19))|(exec&_net_18))&(exec&_net_17)))|(((((((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))|(exec&_net_21))|(exec&_net_20))|(exec&_net_19))|(exec&_net_18))|(exec&_net_17))&(exop&_net_16)))|((((((((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))|(exec&_net_21))|(exec&_net_20))|(exec&_net_19))|(exec&_net_18))|(exec&_net_17))|(exop&_net_16))&(exop&_net_11)))|(((((((((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))|(exec&_net_21))|(exec&_net_20))|(exec&_net_19))|(exec&_net_18))|(exec&_net_17))|(exop&_net_16))|(exop&_net_11))&(exop&_net_9)))|((((((((((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))|(exec&_net_21))|(exec&_net_20))|(exec&_net_19))|(exec&_net_18))|(exec&_net_17))|(exop&_net_16))|(exop&_net_11))|(exop&_net_9))&(exop&_net_5)))|(((((((((((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))|(exec&_net_21))|(exec&_net_20))|(exec&_net_19))|(exec&_net_18))|(exec&_net_17))|(exop&_net_16))|(exop&_net_11))|(exop&_net_9))|(exop&_net_5))&(exop&_net_4)))|((((((((((((((exec&_net_26)|(exec&_net_24))|(exec&_net_22))|(exec&_net_21))|(exec&_net_20))|(exec&_net_19))|(exec&_net_18))|(exec&_net_17))|(exop&_net_16))|(exop&_net_11))|(exop&_net_9))|(exop&_net_5))|(exop&_net_4))&(exop&_net_3))))
 begin $display("Warning: assign collision(cpu:a) at %d",$time);

  end
 end
 else 
 $display("Warning: register set hazard(cpu:a) at %d",$time);

  end

// synthesis translate_on
// synopsys translate_on
always @(posedge m_clock or posedge p_reset)
  begin
if (p_reset)
     i <= 8'b00000000;
else 
// synthesis translate_off
// synopsys translate_off
if (((((exec&_net_25)&(exec&_net_23))|(((exec&_net_25)|(exec&_net_23))&(exop&_net_15)))|((((exec&_net_25)|(exec&_net_23))|(exop&_net_15))&(exop&_net_10))))   i <= 8'bx; 
  else 
// synthesis translate_on
// synopsys translate_on
if ((exec&_net_25))
      i <= res;
else if ((exec&_net_23))
      i <= res;
else if ((exop&_net_15))
      i <= op;
else if ((exop&_net_10))
      i <= dbusi;
end

// synthesis translate_off
// synopsys translate_off
always @(posedge m_clock)
  begin
if ((((((exec&_net_25)|(exec&_net_23))|(exop&_net_15))|(exop&_net_10))==1'b1) ||
 (((((exec&_net_25)|(exec&_net_23))|(exop&_net_15))|(exop&_net_10))==1'b0) ) begin
 if (((((exec&_net_25)&(exec&_net_23))|(((exec&_net_25)|(exec&_net_23))&(exop&_net_15)))|((((exec&_net_25)|(exec&_net_23))|(exop&_net_15))&(exop&_net_10))))
 begin $display("Warning: assign collision(cpu:i) at %d",$time);

  end
 end
 else 
 $display("Warning: register set hazard(cpu:i) at %d",$time);

  end

// synthesis translate_on
// synopsys translate_on
always @(posedge m_clock or posedge p_reset)
  begin
if (p_reset)
     ifetch <= 1'b0;
else if ((_proc_ifetch_set|_proc_ifetch_reset))
      ifetch <= _proc_ifetch_set;
end
always @(posedge m_clock or posedge p_reset)
  begin
if (p_reset)
     ofetch <= 1'b0;
else if ((_proc_ofetch_set|_proc_ofetch_reset))
      ofetch <= _proc_ofetch_set;
end
always @(posedge m_clock or posedge p_reset)
  begin
if (p_reset)
     exop <= 1'b0;
else if ((_proc_exop_set|_proc_exop_reset))
      exop <= _proc_exop_set;
end
always @(posedge m_clock or posedge p_reset)
  begin
if (p_reset)
     exec <= 1'b0;
else if ((_proc_exec_set|_proc_exec_reset))
      exec <= _proc_exec_set;
end
endmodule
/*
 Produced by NSL Core(version=20160105), IP ARCH, Inc. Wed Mar 16 01:27:09 2016
 Licensed to :EVALUATION USER
*/
