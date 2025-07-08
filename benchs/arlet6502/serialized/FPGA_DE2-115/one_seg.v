/* Module used to instantiate the 7 segement present in FPGAs, in this case
* the 7 segment can output only 0 or 1 */
module one_seg(
     	input wire  sw,        
   	output reg [6:0] seg );
	always @(*) begin
        case (sw)
            1'b0: seg    = 7'b1000000; // 0
            1'b1: seg    = 7'b1111001; // 1
            default: seg = 7'b1111111; // Éteint (si jamais autre chose)
        endcase
    end 
    endmodule 


