
/*Produced by NSL Core(version=20240708), IP ARCH, Inc. Thu Aug  8 13:52:17 2024
 Licensed to :EVALUATION USER*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module adder ( p_reset , m_clock , a , b , f );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [1:0] a;
  wire [1:0] a;
  input [1:0] b;
  wire [1:0] b;
  output [1:0] f;
  wire [1:0] f;
  reg [1:0] r1;

   assign  f = r1;
always @(posedge m_clock or negedge p_reset)
  begin
if (~p_reset)
     r1 <= 2'b00;
else   r1 <= (a+b);
end
endmodule

/*Produced by NSL Core(version=20240708), IP ARCH, Inc. Thu Aug  8 13:52:17 2024
 Licensed to :EVALUATION USER*/
