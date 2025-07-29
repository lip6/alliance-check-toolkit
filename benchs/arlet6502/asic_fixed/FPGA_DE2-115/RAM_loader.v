/* This module is used to initialize RAMs using FPGA for example */


module RAM_loader (
	input wire rst,
	input wire clk,
	output reg  [15:0] addr,
	output reg done,
	output wire [7:0] data_out,
	output reg we,
	input wire load

);

reg [7:0] value;
reg [5:0] index;

wire [7:0] inst [0:22];
wire [15:0] fill_addr [0:22];
assign inst[0 ]=  8'h00;
assign inst[1 ]=  8'h80;
assign inst[2 ]=  8'hA9;
assign inst[3 ]=  8'h06;
assign inst[4 ]=  8'h69;
assign inst[5 ]=  8'h07;
assign inst[6 ]=  8'h8D;
assign inst[7 ]=  8'h00;
assign inst[8 ]=  8'hE2;
assign inst[9 ]=  8'h4C;
assign inst[10]=  8'h0A;
assign inst[11]=  8'h24;
assign inst[12]=  8'hAD;
assign inst[13]=  8'h00;
assign inst[14]=  8'hE2;
assign inst[15]=  8'h69;
assign inst[16]=  8'h01;
assign inst[17]=  8'h8D;
assign inst[18]=  8'h00;
assign inst[19]=  8'hE2;
assign inst[20]=  8'h4C;
assign inst[21]=  8'h0A;
assign inst[22]=  8'h24;



assign fill_addr[0 ]=  16'hFFFC;
assign fill_addr[1 ]=  16'hFFFD;
assign fill_addr[2 ]=  16'h8000;
assign fill_addr[3 ]=  16'h8001;
assign fill_addr[4 ]=  16'h8002;
assign fill_addr[5 ]=  16'h8003;
assign fill_addr[6 ]=  16'h8004;
assign fill_addr[7 ]=  16'h8005;
assign fill_addr[8 ]=  16'h8006;
assign fill_addr[9 ]=  16'h8007;
assign fill_addr[10]=  16'h8008;
assign fill_addr[11]=  16'h8009;
assign fill_addr[12]=  16'h240A;
assign fill_addr[13]=  16'h240B;
assign fill_addr[14]=  16'h240C;
assign fill_addr[15]=  16'h240D;
assign fill_addr[16]=  16'h240E;
assign fill_addr[17]=  16'h240F;
assign fill_addr[18]=  16'h2410;
assign fill_addr[19]=  16'h2411;
assign fill_addr[20]=  16'h2412;
assign fill_addr[21]=  16'h2413;
assign fill_addr[22]=  16'h2414;



always@(posedge clk) begin
	if (rst) begin 
				index <=0;
				value<= 8'b00000000;
				done <= 0;
				we <=1;
				addr <=0;
	end
	else begin

		if (load & !done ) begin
				value <=  inst[index];
				addr  <=  fill_addr[index];

			if (index ==23) begin
				done <=1;
				we <=0;
				index <=0;
			end else begin 
				index <= index +1;
				we <=1;
				done <=0;
			end


		end
		else begin
				we <=0;
				done <=1;
				index <=0;
		end 
	end
end

assign data_out = value;
endmodule 
