// Module used to simulate the arlet6502 on FPGA
module tb_top_cpu_fpga();
reg clk = 1'b0;
always #2 clk <= !clk;
reg start;
wire [6:0] seg0;       
wire [6:0] seg1;       
wire [6:0] seg2;       
wire [6:0] seg3;       
wire [6:0] seg4;       
wire [6:0] seg5;       
wire [6:0] seg6; 
wire [6:0] seg7;
top_cpu_fpga top_cpu_inst (.clk(clk),.start(start),.seg0(seg0),.seg1(seg1),.seg2(seg2),.seg3(seg3),.seg4(seg4),.seg5(seg5),.seg6(seg6),.seg7(seg7));
initial begin
	$dumpfile("dump.vcd"); $dumpvars(0, tb_top_cpu_fpga);
start =0;

repeat(1000) @(posedge clk);
start =1;

repeat(2000) @(posedge clk);
start =0;
repeat(200) @(posedge clk);
start =1;
repeat(2000) @(posedge clk)

$display("Test Complete");
$finish();
end
endmodule
