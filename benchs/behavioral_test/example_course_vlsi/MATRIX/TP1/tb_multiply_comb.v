module tb_multiply ();
 localparam Nbits = 4;
 localparam Ndata = 8;

   reg [Ndata*Nbits-1:0] multiplier;
   reg [Ndata*Nbits-1:0] multiplicand;
   wire [Ndata*2*Nbits-1:0] mult_out;

   multiply # (.Nbits(Nbits),.Ndata(Ndata)) multiply_inst (.multiplier(multiplier),.multiplicand(multiplicand),.mult_out(mult_out));

initial begin
    $dumpfile("dump_multiply_comb.vcd"); $dumpvars(0, tb_multiply);
    multiplier <=0;
    multiplicand <=0;

    #40
    multiplier   <= {4'd7,4'd6,4'd5,4'd4,4'd3,4'd2,4'd1,4'd0};   // MSB→LSB =[7][6][5][4][3][2][1][0]
    multiplicand <= {4'd0,4'd1,4'd2,4'd3,4'd4,4'd5,4'd6,4'd7};   // MSB→LSB =[0][1][2][3][4][5][6][7]

    #40

    $display("Test Complete");
    $finish();
  end

endmodule
