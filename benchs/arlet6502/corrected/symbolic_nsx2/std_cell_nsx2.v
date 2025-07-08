module a2_x2 (i0, i1, q, vdd, vss);

  input  	i0;
  input  	i1;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = (i0 & i1);

endmodule
module a2_x4 (i0, i1, q, vdd, vss);

  input  	i0;
  input  	i1;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = (i0 & i1);

endmodule
module a3_x2 (i0, i1, i2, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = ((i0 & i1) & i2);

endmodule
module a3_x4 (i0, i1, i2, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = ((i0 & i1) & i2);

endmodule
module a4_x2 (i0, i1, i2, i3, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = (((i0 & i1) & i2) & i3);

endmodule
module a4_x4 (i0, i1, i2, i3, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = (((i0 & i1) & i2) & i3);

endmodule
module an12_x1 (i0, i1, q, vdd, vss);

  input  	i0;
  input  	i1;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = (~(i0) & i1);

endmodule
module an12_x4 (i0, i1, q, vdd, vss);

  input  	i0;
  input  	i1;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = (~(i0) & i1);

endmodule
module ao22_x2 (i0, i1, i2, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = ((i0 | i1) & i2);

endmodule
module ao22_x4 (i0, i1, i2, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = ((i0 | i1) & i2);

endmodule
module ao2o22_x2 (i0, i1, i2, i3, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = ((i0 | i1) & (i2 | i3));

endmodule
module ao2o22_x4 (i0, i1, i2, i3, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = ((i0 | i1) & (i2 | i3));

endmodule
module buf_x2 (i, q, vdd, vss);

  input  	i;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = i;

endmodule
module buf_x4 (i, q, vdd, vss);

  input  	i;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = i;

endmodule
module buf_x8 (i, q, vdd, vss);

  input  	i;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = i;

endmodule
module inv_x1 (i, nq, vdd, vss);

  input  	i;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~(i);

endmodule
module inv_x2 (i, nq, vdd, vss);

  input  	i;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~(i);

endmodule
module inv_x4 (i, nq, vdd, vss);

  input  	i;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~(i);

endmodule
module inv_x8 (i, nq, vdd, vss);

  input  	i;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~(i);

endmodule
module mx2_x2 (cmd, i0, i1, q, vdd, vss);

  input  	cmd;
  input  	i0;
  input  	i1;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = ((i1 & cmd) | (~(cmd) & i0));

endmodule
module mx2_x4 (cmd, i0, i1, q, vdd, vss);

  input  	cmd;
  input  	i0;
  input  	i1;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = ((i1 & cmd) | (~(cmd) & i0));

endmodule
module mx3_x2 (cmd0, cmd1, i0, i1, i2, q, vdd, vss);

  input  	cmd0;
  input  	cmd1;
  input  	i0;
  input  	i1;
  input  	i2;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = ((~(cmd0) & i0) | (cmd0 & ((cmd1 & i1) | (~(cmd1) & i2))));

endmodule
module mx3_x4 (cmd0, cmd1, i0, i1, i2, q, vdd, vss);

  input  	cmd0;
  input  	cmd1;
  input  	i0;
  input  	i1;
  input  	i2;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = ((~(cmd0) & i0) | (cmd0 & ((cmd1 & i1) | (~(cmd1) & i2))));

endmodule
module na2_x1 (i0, i1, nq, vdd, vss);

  input  	i0;
  input  	i1;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~((i0 & i1));

endmodule
module na2_x4 (i0, i1, nq, vdd, vss);

  input  	i0;
  input  	i1;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~((i0 & i1));

endmodule
module na3_x1 (i0, i1, i2, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~(((i0 & i1) & i2));

endmodule
module na3_x4 (i0, i1, i2, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~(((i0 & i1) & i2));

endmodule
module na4_x1 (i0, i1, i2, i3, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~((((i0 & i1) & i2) & i3));

endmodule
module na4_x4 (i0, i1, i2, i3, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~((((i0 & i1) & i2) & i3));

endmodule
module nao22_x1 (i0, i1, i2, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~(((i0 | i1) & i2));

endmodule
module nao22_x4 (i0, i1, i2, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~(((i0 | i1) & i2));

endmodule
module nao2o22_x1 (i0, i1, i2, i3, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~(((i0 | i1) & (i2 | i3)));

endmodule
module nao2o22_x4 (i0, i1, i2, i3, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~(((i0 | i1) & (i2 | i3)));

endmodule
module nmx2_x1 (cmd, i0, i1, nq, vdd, vss);

  input  	cmd;
  input  	i0;
  input  	i1;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~(((i0 & ~(cmd)) | (i1 & cmd)));

endmodule
module nmx2_x4 (cmd, i0, i1, nq, vdd, vss);

  input  	cmd;
  input  	i0;
  input  	i1;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~(((i0 & ~(cmd)) | (i1 & cmd)));

endmodule
module nmx3_x1 (cmd0, cmd1, i0, i1, i2, nq, vdd, vss);

  input  	cmd0;
  input  	cmd1;
  input  	i0;
  input  	i1;
  input  	i2;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~(((~(cmd0) & i0) | (cmd0 & ((cmd1 & i1) | (~(cmd1) & i2)))));

endmodule
module no2_x1 (i0, i1, nq, vdd, vss);

  input  	i0;
  input  	i1;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~((i0 | i1));

endmodule
module no2_x4 (i0, i1, nq, vdd, vss);

  input  	i0;
  input  	i1;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~((i0 | i1));

endmodule
module no3_x1 (i0, i1, i2, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~(((i0 | i1) | i2));

endmodule
module no3_x4 (i0, i1, i2, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~(((i0 | i1) | i2));

endmodule
module no4_x1 (i0, i1, i2, i3, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~((((i0 | i1) | i2) | i3));

endmodule
module no4_x4 (i0, i1, i2, i3, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~((((i0 | i1) | i2) | i3));

endmodule
module noa22_x1 (i0, i1, i2, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~(((i0 & i1) | i2));

endmodule
module noa22_x4 (i0, i1, i2, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~(((i0 & i1) | i2));

endmodule
module noa2a22_x1 (i0, i1, i2, i3, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~(((i0 & i1) | (i2 & i3)));

endmodule
module noa2a22_x4 (i0, i1, i2, i3, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~(((i0 & i1) | (i2 & i3)));

endmodule
module noa2a2a23_x1 (i0, i1, i2, i3, i4, i5, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  input  	i4;
  input  	i5;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~((((i0 & i1) | (i2 & i3)) | (i4 & i5)));

endmodule
module noa2a2a23_x4 (i0, i1, i2, i3, i4, i5, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  input  	i4;
  input  	i5;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~((((i0 & i1) | (i2 & i3)) | (i4 & i5)));

endmodule
module noa2a2a2a24_x1 (i0, i1, i2, i3, i4, i5, i6, i7, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  input  	i4;
  input  	i5;
  input  	i6;
  input  	i7;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~(((((i0 & i1) | (i2 & i3)) | (i4 & i5)) | (i6 & i7)));

endmodule
module noa2a2a2a24_x4 (i0, i1, i2, i3, i4, i5, i6, i7, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  input  	i4;
  input  	i5;
  input  	i6;
  input  	i7;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~(((((i0 & i1) | (i2 & i3)) | (i4 & i5)) | (i6 & i7)));

endmodule
module noa2ao222_x1 (i0, i1, i2, i3, i4, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  input  	i4;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~(((i0 & i1) | ((i2 | i3) & i4)));

endmodule
module noa2ao222_x4 (i0, i1, i2, i3, i4, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  input  	i4;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~(((i0 & i1) | ((i2 | i3) & i4)));

endmodule
module noa3ao322_x1 (i0, i1, i2, i3, i4, i5, i6, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  input  	i4;
  input  	i5;
  input  	i6;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~((((i0 & i1) & i2) | (((i3 | i4) | i5) & i6)));

endmodule
module noa3ao322_x4 (i0, i1, i2, i3, i4, i5, i6, nq, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  input  	i4;
  input  	i5;
  input  	i6;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~((((i0 & i1) & i2) | (((i3 | i4) | i5) & i6)));

endmodule
module nts_x1 (cmd, i, nq, vdd, vss);

  input  	cmd;
  input  	i;
  output 	nq;
  input  	vdd;
  input  	vss;
  reg    	nq;


  always @ ( i or cmd )
    if (cmd == 1'b1) nq = ~(i);
    else nq = 1'bz;

endmodule
module nts_x2 (cmd, i, nq, vdd, vss);

  input  	cmd;
  input  	i;
  output 	nq;
  input  	vdd;
  input  	vss;
  reg    	nq;


  always @ ( i or cmd )
    if (cmd == 1'b1) nq = ~(i);
    else nq = 1'bz;

endmodule
module nxr2_x1 (i0, i1, nq, vdd, vss);

  input  	i0;
  input  	i1;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~((i0 ^ i1));

endmodule
module nxr2_x4 (i0, i1, nq, vdd, vss);

  input  	i0;
  input  	i1;
  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = ~((i0 ^ i1));

endmodule
module o2_x2 (i0, i1, q, vdd, vss);

  input  	i0;
  input  	i1;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = (i0 | i1);

endmodule
module o2_x4 (i0, i1, q, vdd, vss);

  input  	i0;
  input  	i1;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = (i0 | i1);

endmodule
module o3_x2 (i0, i1, i2, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = ((i0 | i1) | i2);

endmodule
module o3_x4 (i0, i1, i2, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = ((i0 | i1) | i2);

endmodule
module o4_x2 (i0, i1, i2, i3, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = (((i0 | i1) | i2) | i3);

endmodule
module o4_x4 (i0, i1, i2, i3, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = (((i0 | i1) | i2) | i3);

endmodule
module oa22_x2 (i0, i1, i2, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = ((i0 & i1) | i2);

endmodule
module oa22_x4 (i0, i1, i2, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = ((i0 & i1) | i2);

endmodule
module oa2a22_x2 (i0, i1, i2, i3, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = ((i0 & i1) | (i2 & i3));

endmodule
module oa2a22_x4 (i0, i1, i2, i3, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = ((i0 & i1) | (i2 & i3));

endmodule
module oa2a2a23_x2 (i0, i1, i2, i3, i4, i5, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  input  	i4;
  input  	i5;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = (((i0 & i1) | (i2 & i3)) | (i4 & i5));

endmodule
module oa2a2a23_x4 (i0, i1, i2, i3, i4, i5, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  input  	i4;
  input  	i5;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = (((i0 & i1) | (i2 & i3)) | (i4 & i5));

endmodule
module oa2a2a2a24_x2 (i0, i1, i2, i3, i4, i5, i6, i7, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  input  	i4;
  input  	i5;
  input  	i6;
  input  	i7;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = ((((i0 & i1) | (i2 & i3)) | (i4 & i5)) | (i6 & i7));

endmodule
module oa2a2a2a24_x4 (i0, i1, i2, i3, i4, i5, i6, i7, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  input  	i4;
  input  	i5;
  input  	i6;
  input  	i7;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = ((((i0 & i1) | (i2 & i3)) | (i4 & i5)) | (i6 & i7));

endmodule
module oa2ao222_x2 (i0, i1, i2, i3, i4, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  input  	i4;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = ((i0 & i1) | (i4 & (i2 | i3)));

endmodule
module oa2ao222_x4 (i0, i1, i2, i3, i4, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  input  	i4;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = ((i0 & i1) | (i4 & (i2 | i3)));

endmodule
module oa3ao322_x2 (i0, i1, i2, i3, i4, i5, i6, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  input  	i4;
  input  	i5;
  input  	i6;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = (((i0 & i1) & i2) | (i6 & ((i3 | i4) | i5)));

endmodule
module oa3ao322_x4 (i0, i1, i2, i3, i4, i5, i6, q, vdd, vss);

  input  	i0;
  input  	i1;
  input  	i2;
  input  	i3;
  input  	i4;
  input  	i5;
  input  	i6;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = (((i0 & i1) & i2) | (i6 & ((i3 | i4) | i5)));

endmodule
module on12_x1 (i0, i1, q, vdd, vss);

  input  	i0;
  input  	i1;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = (~(i0) | i1);

endmodule
module on12_x4 (i0, i1, q, vdd, vss);

  input  	i0;
  input  	i1;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = (~(i0) | i1);

endmodule
module one_x0 (q, vdd, vss);

  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = 1'b1;

endmodule
module powmid_x0 (vdd, vss);

  input  	vdd;
  input  	vss;


endmodule
module rowend_x0 (vdd, vss);

  input  	vdd;
  input  	vss;


endmodule
//modified r flipflop
//
module sff1r_x4 (ck, i, rst, q, vdd, vss);

  input  	ck;
  input  	i;
  input  	rst;
  output 	q;
  input  	vdd;
  input  	vss;

  reg 	  sff_m;
  reg 	  sff_s;
  assign	q = ~(sff_s);

  always @ ( i or ck )
    if (ck == 1'b0) sff_m = i;

  always @ ( sff_m or rst or ck )
    if (ck == 1'b1) sff_s = ((rst) | ~(sff_m));

endmodule
//module sff1r_x4 (ck, i, nrst, q, vdd, vss);
//
//  input  	ck;
//  input  	i;
//  input  	nrst;
//  output 	q;
//  input  	vdd;
//  input  	vss;
//
//  reg 	  sff_m;
//  reg 	  sff_s;
//  assign	q = ~(sff_s);
//
//  always @ ( i or ck )
//    if (ck == 1'b0) sff_m = i;
//
//  always @ ( sff_m or nrst or ck )
//    if (ck == 1'b1) sff_s = (~(nrst) | ~(sff_m));
//
//endmodule




module sff1_x4 (ck, i, q, vdd, vss);

  input  	ck;
  input  	i;
  output 	q;
  input  	vdd;
  input  	vss;

  reg 	  sff_m;
  assign	q = sff_m;

  always @ ( posedge ck )
    begin
      sff_m = i;
    end

endmodule
module sff2_x4 (ck, cmd, i0, i1, q, vdd, vss);

  input  	ck;
  input  	cmd;
  input  	i0;
  input  	i1;
  output 	q;
  input  	vdd;
  input  	vss;

  reg 	  sff_m;
  assign	q = sff_m;

  always @ ( posedge ck )
    begin
      sff_m = ((i1 & cmd) | (i0 & ~(cmd)));
    end

endmodule
module tie_x0 (vdd, vss);

  input  	vdd;
  input  	vss;


endmodule
module ts_x4 (cmd, i, q, vdd, vss);

  input  	cmd;
  input  	i;
  output 	q;
  input  	vdd;
  input  	vss;
  reg    	q;


  always @ ( i or cmd )
    if (cmd == 1'b1) q = i;
    else q = 1'bz;

endmodule
module ts_x8 (cmd, i, q, vdd, vss);

  input  	cmd;
  input  	i;
  output 	q;
  input  	vdd;
  input  	vss;
  reg    	q;


  always @ ( i or cmd )
    if (cmd == 1'b1) q = i;
    else q = 1'bz;

endmodule
module xr2_x1 (i0, i1, q, vdd, vss);

  input  	i0;
  input  	i1;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = (i0 ^ i1);

endmodule
module xr2_x4 (i0, i1, q, vdd, vss);

  input  	i0;
  input  	i1;
  output 	q;
  input  	vdd;
  input  	vss;

  assign	q = (i0 ^ i1);

endmodule
module zero_x0 (nq, vdd, vss);

  output 	nq;
  input  	vdd;
  input  	vss;

  assign	nq = 1'b0;

endmodule
