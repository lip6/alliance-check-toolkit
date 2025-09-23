module mac_TB ();
  localparam Nbits = 4;
  reg clk = 1'b0;
  reg reset;
  always #2 clk <= !clk;
  reg [Nbits-1:0] multiplier;
  reg [Nbits-1:0] multiplicand;
  wire [2*Nbits-1:0] accumulator_out;





  mac # (.Nbits (Nbits)) UUT 
  (
    .clk(clk),
    .reset(reset),
    .multiplier(multiplier),
    .multiplicand(multiplicand),
    .accumulator_out(accumulator_out));   
    
    
   initial begin
    $dumpfile("dump_mac.vcd"); $dumpvars(0, mac_TB);
    reset <= 1'b1;
    multiplier <= 1;
    multiplicand <= 1;
    #40
    reset <= 1'b0;
    #40
    multiplier <= 2;
    multiplicand <= 2;
    #40


    repeat(400) @(posedge clk);
    $display("Test Complete");
    $finish();
  end

endmodule
