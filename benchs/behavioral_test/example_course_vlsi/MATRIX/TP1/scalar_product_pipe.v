
module scalar_product #
(
  parameter Nbits = 4
)(
  input clk,
  input reset,
  input  wire [4*Nbits-1:0] A,
  input  wire [4*Nbits-1:0] B,
  output wire [2*Nbits - 1:0] out
);
wire [2*Nbits - 1:0] product_0;
wire [2*Nbits - 1:0] product_1;
wire [2*Nbits - 1:0] product_2;
wire [2*Nbits - 1:0] product_3;
reg [2*Nbits - 1:0] product_00;
reg [2*Nbits - 1:0] product_11;
reg [2*Nbits - 1:0] product_22;
reg [2*Nbits - 1:0] product_33;

reg  [4*Nbits-1:0] A_r;
reg  [4*Nbits-1:0] A_rr;
reg  [4*Nbits-1:0] A_rrr;
reg  [4*Nbits-1:0] B_r;
reg  [4*Nbits-1:0] B_rr;
reg  [4*Nbits-1:0] B_rrr;

always @(posedge clk)
	if (reset) begin
	        A_r<=0;
		B_r <=0;
	        A_rr<=0;
	        B_rr<=0;
		A_rrr <=0;
		B_rrr <=0;
		end else begin
		A_r<=A;
		B_r <=B;
	        A_rr<=A_r;
	        B_rr<=B_r;
		A_rrr <=A_rr;
		B_rrr <=B_rr;
	end



multiply_unitary #(
                    .Nbits (Nbits)
                ) u_multiply_unitary_0 (
                    .multiplier_u   (A[3:0]),
                    .multiplicand_u   (B[3:0]),
                    .mult_out_u (product_0)
                );


always @(posedge clk)
	if (reset) begin
		product_00 <= 0;
		end else begin
		product_00<=product_0;
	end







multiply_unitary #(
                    .Nbits (Nbits)
                ) u_multiply_unitary_1 (
                    .multiplier_u   (A_r[7:4]),
                    .multiplicand_u   (B_r[7:4]),
                    .mult_out_u (product_1)
                );


always @(posedge clk)
	if (reset)begin
		product_11 <= 0;
		end else begin
		product_11<=product_00+product_1;
	end


multiply_unitary #(
                    .Nbits (Nbits)
                ) u_multiply_unitary_2 (
                    .multiplier_u   (A_rr[11:8]),
                    .multiplicand_u   (B_rr[11:8]),
                    .mult_out_u (product_2)
                );
always @(posedge clk)
	if (reset)begin
		product_22 <= 0;
	end 	else  begin
		product_22<=product_11+product_2;

	end


multiply_unitary #(
                    .Nbits (Nbits)
                ) u_multiply_unitary_3 (
                    .multiplier_u   (A_rrr[15:12]),
                    .multiplicand_u   (B_rrr[15:12]),
                    .mult_out_u (product_3)
                );


always @(posedge clk)
	if (reset) begin 
		product_33 <= 0;
	end	else begin
		product_33<=product_22+product_3;


	end


assign out = product_33;	
endmodule
