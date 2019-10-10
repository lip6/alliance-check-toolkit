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
    output [31:0] An_output,

    output reg [31:0] usp,

    input [2:0] Dn_address,
    input [31:0] Dn_input,
    input Dn_write_enable,
    // 001: byte, 010: word, 100: long
    input [2:0] Dn_size,
    output [31:0] Dn_output,

    input [8:0] micro_pc,
    output [87:0] micro_data
);

wire An_ram_write_enable    = (An_address == 4'b0111) ? 1'b0 : An_write_enable;

wire [31:0] An_ram_output;
assign An_output            = (An_address == 4'b0111) ? usp : An_ram_output;

wire [3:0] dn_byteena       = (Dn_size[0] == 1'b1) ? 4'b0001 :
                              (Dn_size[1] == 1'b1) ? 4'b0011 :
                              (Dn_size[2] == 1'b1) ? 4'b1111 :
                              4'b0000;

always @(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0)                                 usp <= 32'd0;
    else if(An_address == 4'b0111 && An_write_enable)   usp <= An_input;
end

// Register set An implemented as RAM.
altsyncram an_ram_inst(
    .clock0     (clock),

    .address_a  (An_address[2:0]),    
    .byteena_a  (4'b1111),
    .wren_a     (An_ram_write_enable),
    .data_a     (An_input),
    .q_a        (An_ram_output)
);
defparam 
    an_ram_inst.operation_mode      = "SINGLE_PORT",
    an_ram_inst.width_a             = 32,
    an_ram_inst.widthad_a           = 3,
    an_ram_inst.width_byteena_a     = 4;

// Register set Dn implemented as RAM.
altsyncram dn_ram_inst(
    .clock0     (clock),

    .address_a  (Dn_address),    
    .byteena_a  (dn_byteena),
    .wren_a     (Dn_write_enable),
    .data_a     (Dn_input),
    .q_a        (Dn_output)
);
defparam 
    dn_ram_inst.operation_mode      = "SINGLE_PORT",
    dn_ram_inst.width_a             = 32,
    dn_ram_inst.widthad_a           = 3,
    dn_ram_inst.width_byteena_a     = 4;

// Microcode ROM
altsyncram micro_rom_inst(
    .clock0     (clock),

    .address_a  (micro_pc),
    .q_a        (micro_data)
);
defparam
    micro_rom_inst.operation_mode   = "ROM",
    micro_rom_inst.width_a          = 88,
    micro_rom_inst.widthad_a        = 9,
    micro_rom_inst.init_file        = "ao68000_microcode.mif";

endmodule
