
/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Fri May 10 16:56:14 2024
 Licensed to :EVALUATION USER*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module adder ( p_reset , m_clock , a , b , f );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [7:0] a;
  wire [7:0] a;
  input [7:0] b;
  wire [7:0] b;
  output [7:0] f;
  wire [7:0] f;
  reg [7:0] r;

   assign  f = r;
always @(posedge m_clock or posedge p_reset)
  begin
if (p_reset)
     r <= 8'b00000000;
else   r <= (a&b);
end
endmodule

/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Fri May 10 16:56:14 2024
 Licensed to :EVALUATION USER*/
