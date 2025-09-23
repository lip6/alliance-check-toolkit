module tb_scalar_product_comb();
   localparam Nbits =4;
   localparam Ndata =4;
   reg [Ndata*Nbits-1:0] A;
   reg [Ndata*Nbits-1:0] B;
   wire [2*Nbits -1:0] out;

   scalar_product #(
    .Nbits (4),.Ndata (4))scalar_product_inst (.A(A),.B(B),.out(out));

initial begin
    $dumpfile("dump_scalar_product_comb.vcd"); $dumpvars(0, tb_scalar_product_comb);
    A <=0;
    B <=0;

    #40
    A   <= {4'd2,4'd3, 4'd2, 4'd1};   
    B <= {4'd1,4'd4, 4'd5, 4'd6};   
    #40
    A   <= {4'd1,4'd15, 4'd15, 4'd15};
    B <= {4'd1,4'd15, 4'd15, 4'd15};  



    #80
    $display("Test Complete");
    $finish();
  end

endmodule
