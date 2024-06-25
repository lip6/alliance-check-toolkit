module adder (p_reset, m_clock, f, a, b, vdd, vss);

  input  	p_reset;
  input  	m_clock;
  output [3:0]	f;
  input  [3:0]	a;
  input  [3:0]	b;
  input  	vdd;
  input  	vss;

  reg 	[3:0]  r1;
  reg 	[3:0]  r2;
  reg 	[3:0]  r3;
  reg 	[3:0]  r4;
  reg 	[3:0]  r5;
  reg 	[3:0]  r6;
  reg 	[3:0]  r7;
  reg 	[3:0]  r8;
  reg 	[3:0]  r9;
  wire	  aux0;
  wire	  aux1;
  wire	  aux3;
  wire	  aux4;
  wire	  aux5;
  wire	  aux6;
  assign	f[3] = r9[3];
  assign	f[2] = r9[2];
  assign	f[1] = r9[1];
  assign	f[0] = r9[0];

  always @ ( posedge m_clock )
    begin
      r1 = {((((((((aux5 | b[1]) | a[0]) & aux6) ^ aux4) & b[0]) | ((((a[2] & (b[2] | b[1]
)) | (b[2] & b[1])) ^ aux4) & ~(b[0]))) & a[1]) | (((((((aux6 & b[1]) & a[0]) | aux5
) ^ aux4) & b[0]) | ((aux5 ^ aux4) & ~(b[0]))) & ~(a[1]))) , ((((aux1 & aux0) | 
(aux3 & ~(aux0))) & a[1]) | (((aux3 & aux0) | (~(aux1) & ~(aux0))) & ~(a[1]))) ,
 ((b[1] ^ aux0) ^ a[1]) , (a[0] ^ b[0])};
    end

  always @ ( posedge m_clock )
    begin
      r2 = r1;
    end

  always @ ( posedge m_clock )
    begin
      r3 = r2;
    end

  always @ ( posedge m_clock )
    begin
      r4 = r3;
    end

  always @ ( posedge m_clock )
    begin
      r5 = r4;
    end

  always @ ( posedge m_clock )
    begin
      r6 = r5;
    end

  always @ ( posedge m_clock )
    begin
      r7 = r6;
    end

  always @ ( posedge m_clock )
    begin
      r8 = r7;
    end

  always @ ( posedge m_clock )
    begin
      r9 = r8;
    end
  assign	aux0 = (a[0] & b[0]);
  assign	aux1 = ~((a[2] ^ b[2]));
  assign	aux3 = (a[2] ^ (b[1] ^ b[2]));
  assign	aux4 = (a[3] ^ b[3]);
  assign	aux5 = (a[2] & b[2]);
  assign	aux6 = (a[2] | b[2]);

endmodule
