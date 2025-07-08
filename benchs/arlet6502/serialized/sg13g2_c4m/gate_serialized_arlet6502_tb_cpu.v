// Testbench of the 6502 after place and route, the instructions correspond to a load, add, store,
// jump and then jump --> it corresponds to a counter

module cpu_TB ();
  reg r_Clk ;
  always #5 r_Clk <= !r_Clk;
  
  reg [7:0] DI;
  wire [7:0] DO;
  wire WE;
  reg [7:0] memory [0:65535];
  wire [7:0] disp;
  reg RDY;
  reg RST;
  wire [2:0] lh;

assign disp = memory[16'hE200]; 
  serialized_arlet6502_cts_r UUT
  (
    .clk(r_Clk),
    .reset(RST),
    .di(DI),
    .do(DO),
    .we(WE),
    .irq(1'b1),
    .nmi(1'b1),
    .rdy(RDY),
    .lh(lh)
  );

//Address reconstruction is done based on serializer state
reg [7:0] ABH ;
reg [7:0] ABL ;
wire [15:0] ABF;
assign ABF = {ABH, ABL};
always @(posedge r_Clk) begin
	if (RST) begin
			ABH <=0;
			ABL <=0;
	end else begin
		if (lh == 3'b000) 
			ABL <= DO;
		if (lh ==3'b010) 
			ABH <= DO;
	end
end


//Read memory when the addr is valid (lh =3) and write into the memory when
// the output is valid lh=5 
always @(posedge r_Clk) begin
	if (!WE && lh ==3) 
		DI <= memory[ABF];  
	else begin if (WE && lh == 5)
		memory[ABF] <= DO; end
	end


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
	    r_Clk <=1'b0;
	    RDY <=1'b1;
	    RST <=1'b1;
	    DI  <= 8'hEA;
	    $dumpfile("dump.vcd"); $dumpvars(0, cpu_TB);
	    repeat(50) @(posedge r_Clk);
	    RST <= ~RST;
	    repeat(9) @(posedge r_Clk);
	    RDY <=1;
	    repeat(1) @(posedge r_Clk);
	    RDY <=1;
	    repeat(2400) @(posedge r_Clk);
	    $display("Test Complete");
	    $finish();
    end

endmodule
