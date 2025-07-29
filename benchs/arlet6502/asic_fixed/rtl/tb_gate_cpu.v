// Testbench of the 6502, the instructions correspond to a load, add, store,
// jump and then jump --> it corresponds to a counter.
module tb_arlet6502_gate ();
reg r_Clk = 1'b0;
always #5 r_Clk <= !r_Clk;

wire [15:0] AB;
reg [7:0] DI = 8'hEA;
wire [7:0] DO;
wire WE;
reg RST = 1'b1;
reg [7:0] memory [0:65535];
wire [7:0] disp;
reg RDY = 1;
arlet6502_cts_r UUT
(
  .clk(r_Clk),
  .reset(RST),
  .a(AB),
  .di(DI),
  .do(DO),
  .we(WE),
  .irq(1'b1),
  .nmi(1'b1),
  .rdy(RDY)
);


always @(posedge r_Clk) begin
	if (!RST)  
		$display(" DI: %h, DO: %h ,AB: %h,STA E200: %h,WE: %b", DI,DO,AB,memory[16'hE200],WE);
		memory[16'h0093] <= 8'h11;
end

 //Memory read and write     
always @(posedge r_Clk) begin
	if (!WE && RDY) 
		DI <= memory[AB];  
	else begin if (WE)
		memory[AB] <= DO; end
	end
	assign disp = memory[16'hE200]; 


    initial begin
    memory[16'hFFFC] <= 8'h00; // Starting addr LSB 
    memory[16'hFFFD] <= 8'h80; // Starting addr MSB 
    memory[16'h8000] <= 8'hA9; // Opcode LDA: immediate load in Acc register 
    memory[16'h8001] <= 8'h06; // Value to load
    memory[16'h8002] <= 8'h69; // Opcode add to Acc register
    memory[16'h8003] <= 8'h07;  // Value to ADD
    memory[16'h8004] <= 8'h8D; // Opcode STA: store at the addr to be defined
    memory[16'h8005] <= 8'h00; // LSB of the addr 
    memory[16'h8006] <= 8'hE2; // MSB of the addr
    memory[16'h8007] <= 8'h4C; // Opcode jump to the addr to be defined
    memory[16'h8008] <= 8'h0A; // LSB of the addr
    memory[16'h8009] <= 8'h24; // MSB of the addr
    memory[16'h240A] <= 8'hAD; // Read from the addr to be defined 
    memory[16'h240B] <= 8'h00; // LSB of the addr
    memory[16'h240C] <= 8'hE2; // MSB of the addr
    memory[16'h240D] <= 8'h69;
    memory[16'h240E] <= 8'h01;
    memory[16'h240F] <= 8'h8D;  
    memory[16'h2410] <= 8'h00;  
    memory[16'h2411] <= 8'hE2;
    memory[16'h2412] <= 8'h4C;
    memory[16'h2413] <= 8'h0A;
    memory[16'h2414] <= 8'h24;
    end

   initial begin
    $dumpfile("dump.vcd"); $dumpvars(0, tb_arlet6502_gate);
    repeat(50) @(posedge r_Clk);
    RST <= ~RST;
    repeat(9) @(posedge r_Clk);
    RDY <=0;
    repeat(5) @(posedge r_Clk);
    RDY <=1;


    repeat(400) @(posedge r_Clk);
    $display("Test Complete");
    $finish();
  end

endmodule
