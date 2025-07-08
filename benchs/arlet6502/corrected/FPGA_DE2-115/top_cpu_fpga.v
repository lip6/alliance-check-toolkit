//Top level instantiated the arlet6502 and its serializer, RAM model, RAM
//loader and the 7 segmets. It is the top level used for FPGA
module top_cpu_fpga (
    input clk,
    input start,
    output wire [6:0] seg0,       
    output wire [6:0] seg1,       
    output wire [6:0] seg2,       
    output wire [6:0] seg3,       
    output wire [6:0] seg4,       
    output wire [6:0] seg5,       
    output wire [6:0] seg6, 
    output wire [6:0] seg7    
);
reg reset;
reg RDY;
reg [15:0]cycle_counter;
wire we_loader;
reg we_RAM;
wire [15:0] addr_loader;
wire [15:0] addr_muxed;
reg [15:0] addr_RAM;
wire [7:0] data_out_loader;
reg [7:0]  data_in_RAM;
wire WE;
reg  load;
wire [7:0] DI;
wire [7:0] DO;
reg [7:0] memory [0:65535];
wire [15:0] AB;



always @(*)
	if (reset) begin
		addr_RAM = 0;
		we_RAM = 0;
		data_in_RAM = 0;
	end
	else begin 	//laod RAM with the instuctions
		if (load) begin
		addr_RAM = addr_loader;
		we_RAM = we_loader;
		data_in_RAM = data_out_loader ;

	end else begin // use the RAM for cpu executions
		addr_RAM= AB;
		we_RAM= WE;
		data_in_RAM = DO;
	end
end



RAM_model SRAM (.clk(clk),.addr(addr_RAM),.we(we_RAM),.data_in(data_in_RAM),.data_out(DI));
RAM_loader LOAD(.clk(clk),.rst(reset),.addr(addr_loader),.we(we_loader),.load(load),.data_out(data_out_loader),.done(done));
cpu cpu_inst (
    .clk(clk),
    .reset(reset),
    .AB(AB),
    .DI(DI),
    .DO(DO),
    .WE(WE),
    .IRQ(1'b1),
    .NMI(1'b1),
    .RDY(RDY)
  );
wire [23:0] real_stop;
assign real_stop = 1500 ;
one_seg one_seg_inst0(.sw(DO[0]),.seg(seg0));
one_seg one_seg_inst1(.sw(DO[1]),.seg(seg1));
one_seg one_seg_inst2(.sw(DO[2]),.seg(seg2));
one_seg one_seg_inst3(.sw(DO[3]),.seg(seg3));
one_seg one_seg_inst4(.sw(DO[4]),.seg(seg4));
one_seg one_seg_inst5(.sw(DO[5]),.seg(seg5));
one_seg one_seg_inst6(.sw(DO[6]),.seg(seg6));
one_seg one_seg_inst7(.sw(DO[7]),.seg(seg7));
always@(posedge clk)begin
	if (cycle_counter == 2) begin 
	reset <=1'b1;
	RDY <=1'b0;
	load <=1'b0;
	end ;
	if (cycle_counter == 10) begin reset <= 1'b0; load <= 1'b1; end ;
	if (cycle_counter == 50) begin
	load <=1'b0 ; end ;
	if (cycle_counter == 100) begin
	reset <=1'b1;
	RDY <=1'b0;end ;
	if (cycle_counter == 110) begin  reset <=1'b0 ; end ;
	if (cycle_counter == 120) begin  RDY <=1'b1 ; end ;
	if (cycle_counter == real_stop) begin  RDY <=1'b0 ; end ;


end
always @(posedge clk)
begin 
if (!start)
	cycle_counter <=0;
else 
	cycle_counter <= cycle_counter + 1;
end
endmodule	
