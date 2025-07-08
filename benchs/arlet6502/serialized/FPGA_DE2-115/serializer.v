/* This module adapts the arlet6502 (with 24 output pins) to an 8-bit output interface.
   The address bus AB[15:0] and data bus DO[7:0] are multiplexed into DO_pad[7:0].

   RDY_in is used to freeze the processor during cycles where the full address is not yet valid.

   - In states ADL and WAIT0: DO_pad outputs AB[7:0] (low byte); RDY is low (incomplete address).
   - In states ADH and WAIT1: DO_pad outputs AB[15:8] (high byte); RDY is high at the end(full address valid).
   - In states WAIT2 and SDO: DO_pad outputs DO[7:0] (data to write); RDY is high at the end.
*/
module serializer (clk,reset,WE,RDY_in,lh, DO_pad,AB,DO);
input [15:0] AB;
input [7:0] DO;
input clk;
input WE;
input reset;
output reg RDY_in;
output reg [2:0] lh;
output reg [7:0] DO_pad;
reg [4:0] counter;
reg [2:0] state;
reg [2:0] state_next;
reg [3:0]wait_count;
parameter
	ADL      = 3'b000,
	WAIT0 	 = 3'b001,
	ADH      = 3'b010,
	WAIT1 	 = 3'b011,
	WAIT2 	 = 3'b100,
	SDO      = 3'b101; 

always @(posedge clk )begin
        if (reset) 
            state <= ADL;
        else 
	    state <= state_next;
        end


always @(*) begin
        case (state)
            ADL: begin
                DO_pad = AB[7:0];
                lh = 3'b000;
		RDY_in = 0;
		state_next = WAIT0;
            end

            WAIT0: begin
                DO_pad = AB[7:0];
                lh = 3'b001;
		RDY_in = 0;
		state_next=ADH;
            end

            ADH: begin
                DO_pad = AB[15:8];
                lh = 3'b010;
		RDY_in = 0;
		if (WE)
	        state_next=WAIT2;
	else 	
	        state_next=WAIT1;
            end


            WAIT1: begin
                DO_pad = AB[15:8];
                lh = 3'b011;
		RDY_in = 1;
		state_next=ADL;
            end




            WAIT2: begin
                DO_pad = DO;
                lh = 3'b100;
		RDY_in = 0;
		state_next=SDO;
            end


            SDO: begin
                DO_pad = DO;
                lh = 3'b101;
		RDY_in = 1;
	        state_next=ADL;	
            end




            default: begin
        	DO_pad = 8'h00;
        	lh = 3'b00;
		RDY_in = 0;
 		state_next = ADL;

            end
        endcase
    end
 endmodule

