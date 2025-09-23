
//iverilog -o test -P   tb_multiply_comb_Npar.Npar=1      tb_multiply_comb_Npar.v  multiply_comb.v multiply_unitary.v
module tb_multiply_comb_Npar # (parameter Npar=2);
localparam Nbits = 4;
localparam Ndata = 8;
reg clk = 1'b0;
always #2 clk <= !clk;
reg reset;
reg [Ndata/Npar*Nbits-1:0] multiplier;
reg [Ndata/Npar*Nbits-1:0] multiplicand;
wire [Ndata/Npar*2*Nbits-1:0] mult_out;
reg  [Ndata*2*Nbits-1:0] out;
reg [Ndata*Nbits-1:0] A;
reg [Ndata*Nbits-1:0] B;
reg [Ndata*Nbits-1:0] A_tmp;
reg [Ndata*Nbits-1:0] B_tmp;



   multiply # (.Nbits(Nbits),.Ndata(Ndata/Npar)) multiply_inst (.multiplier(multiplier),.multiplicand(multiplicand),.mult_out(mult_out));

generate
  if (Npar != 1) begin  
    reg [3:0] index;
    always @(posedge clk) begin
      if (reset) begin
        A_tmp <= A;
        B_tmp <= B;
        multiplier   <= 0;
        multiplicand <= 0;
        out          <= 0;
        index        <= 0;
      end else if (index < (Npar+1)) begin  
        multiplier   <= A_tmp[Ndata/Npar*Nbits-1:0];	
        multiplicand <= B_tmp[Ndata/Npar*Nbits-1:0];	
        A_tmp        <= A_tmp >> (Ndata/Npar*Nbits);
        B_tmp        <= B_tmp >> (Ndata/Npar*Nbits);
        out          <= {mult_out,out[Ndata*2*Nbits-1 : Ndata/Npar*2*Nbits]};
        index        <= index+1;
      end
    end
  end else begin 
    always @(posedge clk) begin
      if (reset) begin
        multiplier   <= 0;
        multiplicand <= 0;
      end else begin
        multiplier   <= A;
        multiplicand <= B;
      end
    end
  end
endgenerate

initial
begin
    $dumpfile("dump_multiply_comb_Npar.vcd"); $dumpvars(0, tb_multiply_comb_Npar);
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


