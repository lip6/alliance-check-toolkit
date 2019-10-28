/***********************************************************************************************************************
 * Memory registers
 **********************************************************************************************************************/

/*! \brief Contains the microcode ROM and D0-D7, A0-A7 registers.
 *
 * The memory_registers module contains:
 *  - data and address registers (D0-D7, A0-A7) implemented as an on-chip RAM.
 *  - the microcode implemented as an on-chip ROM.
 *
 * Currently this module contains <em>altsyncram</em> instantiations
 * from Altera Megafunction/LPM library.
 */
module memory_registers(
    input clock,
    input reset_n,

    // 0000,0001,0010,0011,0100,0101,0110: A0-A6, 0111: USP, 1111: SSP
    input [3:0] An_address,
    input [31:0] An_input,
    input An_write_enable,
    output reg [31:0] An_output,

    output reg [31:0] usp,

    input [2:0] Dn_address,
    input [31:0] Dn_input,
    input Dn_write_enable,
    // 001: byte, 010: word, 100: long
    input [2:0] Dn_size,
    output reg [31:0] Dn_output,

    input [8:0] micro_pc,
    output reg [87:0] micro_data
);


// Generic version of A register bank
reg [31:0] An[0:7];
wire [2:0] An_mem_address;
assign An_mem_address = An_address[2:0];

always @(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        usp <= 32'd0;
    end
    else if(An_address == 4'b0111) begin
        if(An_write_enable) begin
            usp <= An_input;
        end
    end
end
always @(posedge clock) begin
    if(An_address != 4'b0111) begin
        if(An_write_enable) begin
            An[An_mem_address] <= An_input;
            An_output <= An_input;
        end
        else begin
            An_output <= An[An_mem_address];
        end
    end
    else begin // An_address == 4'b0111 => usp
        if(An_write_enable) begin
            An_output <= An_input;
        end
        else begin
            An_output <= usp;
        end
    end
end


// Generic version of D register bank
reg [31:0] Dn[0:7];

always @(posedge clock) begin
    if(Dn_write_enable) begin
        if(Dn_size[0] == 1'b1) begin
            Dn[Dn_address][7:0] <= Dn_input[7:0];
            Dn_output <= {"UUUUUUUUUUUUUUUUUUUUUUUU", Dn_input[7:0]};
        end
        else if(Dn_size[1] == 1'b1) begin
            Dn[Dn_address][15:0] <= Dn_input[15:0];
            Dn_output <= {"UUUUUUUUUUUUUUUU", Dn_input[15:0]};
        end
        else if(Dn_size[2] == 1'b1) begin
            Dn[Dn_address] <= Dn_input;
            Dn_output <= Dn_input[31:0];
        end
        // Do nothing if Dn_size == 3'b000
    end
    else begin
        Dn_output <= Dn[Dn_address];
    end // else: !if(Dn_write_enable)
end // always @ (posedge clock)


// Generic microcode ROM
reg [87:0] microcode[0:511];

initial $readmemb("ao68000_microcode_b", microcode, 0, 491);

always @(posedge clock) begin
    micro_data <= microcode[micro_pc];
end

endmodule
