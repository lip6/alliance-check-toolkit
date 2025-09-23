module tb_multiply_unitary_seq();
localparam Nbits = 4;
   localparam Ndata = 8;
   reg clk = 1'b0;
   always #2 clk <= !clk;
   reg reset;
   reg [Ndata*Nbits-1:0] A;
   reg [Ndata*Nbits-1:0] B;
   reg [Nbits-1:0] multiplier;
   reg [Nbits-1:0] multiplicand;
   wire [2*Nbits-1:0] mult_out;
   reg [Ndata*Nbits-1:0] A_tmp;
   reg [Ndata*Nbits-1:0] B_tmp;
   reg [Ndata*2*Nbits-1:0]    out;

multiply_unitary # (.Nbits(4)) mult_tb (.multiplier_u(multiplier),.multiplicand_u(multiplicand),.mult_out_u(mult_out));
reg [3:0]index;
always @ (posedge clk)
	if (reset) begin
	A_tmp <=A;
        B_tmp <=B;
        multiplier<=0;
        multiplicand<=0;
	out<=0;
	index <=0;
	end
	else  if (index < Ndata+1) begin  
	multiplier  <= A_tmp[Nbits-1:0];	
	multiplicand<= B_tmp[Nbits-1:0];	
        A_tmp   <=  (A_tmp   >> Nbits) ;
	B_tmp   <=  (B_tmp >> Nbits) ;
       out <= {mult_out,out[Ndata*2*Nbits-1 : 2*Nbits]};
       index <= index+1;
	end





initial
begin
    $dumpfile("dump_multiply_unitary_seq.vcd"); $dumpvars(0, tb_multiply_unitary_seq);
    reset <= 1;
    A   <= {4'd7,4'd6,4'd5,4'd4,4'd3,4'd2,4'd1,4'd0};   // MSB→LSB =[7][6][5][4][3][2][1][0]
    B   <= {4'd0,4'd1,4'd2,4'd3,4'd4,4'd5,4'd6,4'd7};   // MSB→LSB =[0][1][2][3][4][5][6][7]
    #40
    reset <= 1'b0;


    repeat(400) @(posedge clk);
    $display("Test Complete");
    $finish();	
end
endmodule
