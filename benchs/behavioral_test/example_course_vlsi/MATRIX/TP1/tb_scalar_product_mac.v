module tb_scalar_product_mac ();
  localparam Nbits = 4;
  localparam Ndata = 4;
   reg clk = 1'b0;
   always #2 clk <= !clk;

   reg reset;
   reg [Ndata*Nbits-1:0] A;
   reg [Ndata*Nbits-1:0] B;
   wire [2*Nbits -1:0] out;

   scalar_product_mac #(
    .Nbits (4),.Ndata (4))scalar_product_inst (.A(A),.B(B),.out(out),.clk(clk),.reset(reset));

initial begin
    $dumpfile("dump_scalar_product_mac.vcd"); $dumpvars(0, tb_scalar_product_mac);
    reset <= 1;

    A   <= {4'd2,4'd3, 4'd2, 4'd1};   
    B <= {4'd1,4'd4, 4'd5, 4'd6};   
    #40
    reset <= 1'b0;
    #40
    A   <= {4'd1,4'd15, 4'd15, 4'd15};
    B <= {4'd1,4'd15, 4'd15, 4'd15};  
    #40
    reset <= 1'b1;
    #40
    reset <= 1'b0;


    repeat(400) @(posedge clk);
    $display("Test Complete");
    $finish();
  end

endmodule
