//Top level instantiated the arlet6502 and its serializer, RAM model, RAM
//loader and the 7 segmets. It is the top level used for FPGA
module top_arlet6502_serialized_fpga (
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
reg [31:0]cycle_counter;
wire we_loader;
reg we_RAM;
wire [15:0] addr_loader;
wire [15:0] addr_muxed;
reg [15:0] addr_RAM;
wire [7:0] data_out_loader;
reg [7:0]  data_in_RAM;
wire WE;
wire done;
reg NMI;
reg IRQ;
reg  load;
wire [7:0] DI;
wire [7:0] data_out_RAM;
wire [7:0] DO;
reg [7:0] memory [0:65535];
reg RST;
wire [2:0] lh;
reg [7:0] ABH ;
reg [7:0] ABL ;
wire [15:0] ABF;
assign ABF = {ABH, ABL};
//addr reconstition based on the serializer states (given by lh)
always @(posedge clk) begin
	if (reset)begin
			ABL<=0;
			ABH<=0;
	end 
	else begin
	     if (lh == 3'b000  ) 
		        ABL <= DO;
     	     if (lh ==3'b010  ) 
		       	ABH <= DO; end
end
// read enable defined when the address is valid, the write enable has the
// priority

reg re; //overall read enable
wire re_arlet6502;
assign re_arlet6502 = (!(WE_gated) && (lh ==3 && RDY));
// Write enable valid when the output is valid
wire WE_gated;
assign WE_gated = WE && lh == 3'b101 && RDY;
reg finish; // When finish is 1, we read the output of the cpu
always @(*)
	if (!finish) begin
		if (load) begin 		// we load the RAM with the instructions
			addr_RAM = addr_loader;
			we_RAM = we_loader;
			data_in_RAM = data_out_loader ;
			re=0;
		end else begin
			addr_RAM= addr_muxed; 	// Use the RAM for cpu executions
			we_RAM= WE_gated;
			data_in_RAM = DO;
			re = re_arlet6502 ;
		end
	end
	else begin 				// read the output
		addr_RAM= 16'hE200;
		we_RAM=0;
		data_in_RAM = DO;
		re = 1 ;
	end


assign DI = data_out_RAM;
assign addr_muxed = ABF;
RAM_model SRAM (.clk(clk),.addr(addr_RAM),.we(we_RAM),.data_in(data_in_RAM),.data_out(data_out_RAM),.re(re));

//RAM_model_1 SRAM (.clock(clk),.address(addr_RAM),.wren(we_RAM),.data(data_in_RAM),.q(data_out_RAM),.rden(re));
RAM_loader LOAD(.clk(clk),.rst(reset),.addr(addr_loader),.we(we_loader),.load(load),.data_out(data_out_loader),.done(done));
serialized_arlet6502 arlet6502_inst  (.clk(clk),.reset(reset),.DI(DI),.DO(DO),.WE(WE),.IRQ(IRQ),.NMI(NMI),.RDY(RDY),.lh(lh)  );
one_seg one_seg_inst0(.sw(data_out_RAM[0]),.seg(seg0));
one_seg one_seg_inst1(.sw(data_out_RAM[1]),.seg(seg1));
one_seg one_seg_inst2(.sw(data_out_RAM[2]),.seg(seg2));
one_seg one_seg_inst3(.sw(data_out_RAM[3]),.seg(seg3));
one_seg one_seg_inst4(.sw(data_out_RAM[4]),.seg(seg4));
one_seg one_seg_inst5(.sw(data_out_RAM[5]),.seg(seg5));
one_seg one_seg_inst6(.sw(data_out_RAM[6]),.seg(seg6));
one_seg one_seg_inst7(.sw(data_out_RAM[7]),.seg(seg7));
always@(posedge clk)begin
	if (cycle_counter == 2) begin 
	reset <=1'b1;
	finish <=0;
	RDY <=1'b0;
	IRQ <=1;
	NMI<=1;
	load <=1'b0;
	end ;
	if (cycle_counter == 10) begin reset <= 1'b0; load <= 1'b1; end ;
	if (cycle_counter == 50) begin
	load <=1'b0 ;finish <=0; end ;
	if (cycle_counter == 54) begin  reset <=1'b0 ; end ;
	if (cycle_counter == 56) begin  RDY <=1'b1 ; end ;
	if (cycle_counter == 2500) begin  RDY <=1'b0; finish <=1 ; end ;


end
always @(posedge clk)
begin 
if (!start)
        cycle_counter <=0;
else 
        cycle_counter <= cycle_counter + 1;
end
endmodule	
