module tb_scalar_product_pipe ();
  localparam Nbits = 4;
  localparam Ndata = 4;
   reg clk= 1'b0;
   reg reset;
   always #2 clk <= !clk;

   reg [Ndata*Nbits-1:0] A;
   reg [Ndata*Nbits-1:0] B;
   wire [2*Nbits -1:0] out;

   scalar_product #(
    .Nbits (Nbits))scalar_product_inst (.clk(clk),.reset(reset),.A(A),.B(B),.out(out));
 reg [5*Ndata*Nbits-1:0] A_full;
 reg [5*Ndata*Nbits-1:0] A_tmp;
 reg [5*Ndata*Nbits-1:0] B_full;
 reg [5*Ndata*Nbits-1:0] B_tmp;

always @(posedge clk)
	if (reset) begin
		A_tmp<=A_full;
		B_tmp<=B_full;
		A <= A_tmp[Ndata*Nbits-1:0];
		B <= B_tmp[Ndata*Nbits-1:0];
        end else 
	begin
		A_tmp<= (A_tmp>>Ndata*Nbits);
		B_tmp<= (B_tmp>>Ndata*Nbits);
		A <= A_tmp[Ndata*Nbits-1:0];
		B <= B_tmp[Ndata*Nbits-1:0];

	end


initial begin
    $dumpfile("dump_scalar_product_pipe.vcd"); $dumpvars(0, tb_scalar_product_pipe);
    A_full <= {4'd2,4'd2,4'd3,4'd3, 4'd5,4'd4,4'd3,4'd2,   4'd2,4'd3,4'd4,4'd2    ,4'd7,4'd6,4'd5,4'd4    ,4'd3,4'd2,4'd1,4'd0};
    B_full <= {4'd3,4'd3,4'd2,4'd1, 4'd1,4'd2,4'd3,4'd4,   4'd3,4'd3,4'd4,4'd2    ,4'd7,4'd6,4'd5,4'd4    ,4'd3,4'd2,4'd1,4'd0};
    reset <=1;




    #80
    reset <=0;
    #160
    $display("Test Complete");
    $finish();
  end

endmodule
