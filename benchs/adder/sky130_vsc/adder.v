
/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Mon Jun 24 17:52:36 2024
 Licensed to :EVALUATION USER*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module adder ( p_reset , m_clock , a , b , f );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [3:0] a;
  wire [3:0] a;
  input [3:0] b;
  wire [3:0] b;
  output [3:0] f;
  wire [3:0] f;
  reg [3:0] r1;
  reg [3:0] r2;
  reg [3:0] r3;
  reg [3:0] r4;
  reg [3:0] r5;
  reg [3:0] r6;
  reg [3:0] r7;
  reg [3:0] r8;
  reg [3:0] r9;

   assign  f = r9;
always @(posedge m_clock)
  begin
  r1 <= (a+b);
end
always @(posedge m_clock)
  begin
  r2 <= r1;
end
always @(posedge m_clock)
  begin
  r3 <= r2;
end
always @(posedge m_clock)
  begin
  r4 <= r3;
end
always @(posedge m_clock)
  begin
  r5 <= r4;
end
always @(posedge m_clock)
  begin
  r6 <= r5;
end
always @(posedge m_clock)
  begin
  r7 <= r6;
end
always @(posedge m_clock)
  begin
  r8 <= r7;
end
always @(posedge m_clock)
  begin
  r9 <= r8;
end
endmodule

/*Produced by NSL Core(version=20230222), IP ARCH, Inc. Mon Jun 24 17:52:36 2024
 Licensed to :EVALUATION USER*/
