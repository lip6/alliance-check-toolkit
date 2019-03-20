// Generator : SpinalHDL v1.1.5    git head : 94fd271a3c6d4340f29c7e33b041afca9ff96240
// Date      : 12/06/2018, 18:19:15
// Component : VexRiscv


`define ShiftCtrlEnum_binary_sequancial_type [1:0]
`define ShiftCtrlEnum_binary_sequancial_DISABLE_1 2'b00
`define ShiftCtrlEnum_binary_sequancial_SLL_1 2'b01
`define ShiftCtrlEnum_binary_sequancial_SRL_1 2'b10
`define ShiftCtrlEnum_binary_sequancial_SRA_1 2'b11

`define Src1CtrlEnum_binary_sequancial_type [1:0]
`define Src1CtrlEnum_binary_sequancial_RS 2'b00
`define Src1CtrlEnum_binary_sequancial_IMU 2'b01
`define Src1CtrlEnum_binary_sequancial_FOUR 2'b10

`define AluBitwiseCtrlEnum_binary_sequancial_type [1:0]
`define AluBitwiseCtrlEnum_binary_sequancial_XOR_1 2'b00
`define AluBitwiseCtrlEnum_binary_sequancial_OR_1 2'b01
`define AluBitwiseCtrlEnum_binary_sequancial_AND_1 2'b10
`define AluBitwiseCtrlEnum_binary_sequancial_SRC1 2'b11

`define AluCtrlEnum_binary_sequancial_type [1:0]
`define AluCtrlEnum_binary_sequancial_ADD_SUB 2'b00
`define AluCtrlEnum_binary_sequancial_SLT_SLTU 2'b01
`define AluCtrlEnum_binary_sequancial_BITWISE 2'b10

`define BranchCtrlEnum_binary_sequancial_type [1:0]
`define BranchCtrlEnum_binary_sequancial_INC 2'b00
`define BranchCtrlEnum_binary_sequancial_B 2'b01
`define BranchCtrlEnum_binary_sequancial_JAL 2'b10
`define BranchCtrlEnum_binary_sequancial_JALR 2'b11

`define Src2CtrlEnum_binary_sequancial_type [1:0]
`define Src2CtrlEnum_binary_sequancial_RS 2'b00
`define Src2CtrlEnum_binary_sequancial_IMI 2'b01
`define Src2CtrlEnum_binary_sequancial_IMS 2'b10
`define Src2CtrlEnum_binary_sequancial_PC 2'b11

module VexRiscv (
      output  iBus_cmd_valid,
      input   iBus_cmd_ready,
      output [31:0] iBus_cmd_payload_pc,
      input   iBus_rsp_ready,
      input   iBus_rsp_error,
      input  [31:0] iBus_rsp_inst,
      output  dBus_cmd_valid,
      input   dBus_cmd_ready,
      output  dBus_cmd_payload_wr,
      output [31:0] dBus_cmd_payload_address,
      output [31:0] dBus_cmd_payload_data,
      output [1:0] dBus_cmd_payload_size,
      input   dBus_rsp_ready,
      input   dBus_rsp_error,
      input  [31:0] dBus_rsp_data,
      input   clk,
      input   reset);
  reg [31:0] _zz_145;
  reg [31:0] _zz_146;
  wire  _zz_147;
  wire [1:0] _zz_148;
  wire [31:0] _zz_149;
  wire  _zz_150;
  wire  _zz_151;
  wire [1:0] _zz_152;
  wire [2:0] _zz_153;
  wire [31:0] _zz_154;
  wire [0:0] _zz_155;
  wire [0:0] _zz_156;
  wire [0:0] _zz_157;
  wire [0:0] _zz_158;
  wire [0:0] _zz_159;
  wire [0:0] _zz_160;
  wire [0:0] _zz_161;
  wire [0:0] _zz_162;
  wire [0:0] _zz_163;
  wire [11:0] _zz_164;
  wire [11:0] _zz_165;
  wire [31:0] _zz_166;
  wire [31:0] _zz_167;
  wire [31:0] _zz_168;
  wire [31:0] _zz_169;
  wire [1:0] _zz_170;
  wire [31:0] _zz_171;
  wire [1:0] _zz_172;
  wire [1:0] _zz_173;
  wire [31:0] _zz_174;
  wire [32:0] _zz_175;
  wire [19:0] _zz_176;
  wire [11:0] _zz_177;
  wire [11:0] _zz_178;
  wire [31:0] _zz_179;
  wire [31:0] _zz_180;
  wire [0:0] _zz_181;
  wire [0:0] _zz_182;
  wire [0:0] _zz_183;
  wire [0:0] _zz_184;
  wire [1:0] _zz_185;
  wire [1:0] _zz_186;
  wire  _zz_187;
  wire [0:0] _zz_188;
  wire [13:0] _zz_189;
  wire [31:0] _zz_190;
  wire [31:0] _zz_191;
  wire [31:0] _zz_192;
  wire [31:0] _zz_193;
  wire [31:0] _zz_194;
  wire [31:0] _zz_195;
  wire [31:0] _zz_196;
  wire [31:0] _zz_197;
  wire [0:0] _zz_198;
  wire [1:0] _zz_199;
  wire [2:0] _zz_200;
  wire [2:0] _zz_201;
  wire  _zz_202;
  wire [0:0] _zz_203;
  wire [10:0] _zz_204;
  wire [31:0] _zz_205;
  wire [31:0] _zz_206;
  wire [31:0] _zz_207;
  wire [31:0] _zz_208;
  wire [31:0] _zz_209;
  wire  _zz_210;
  wire [0:0] _zz_211;
  wire [0:0] _zz_212;
  wire  _zz_213;
  wire [1:0] _zz_214;
  wire [1:0] _zz_215;
  wire  _zz_216;
  wire [0:0] _zz_217;
  wire [7:0] _zz_218;
  wire [31:0] _zz_219;
  wire [31:0] _zz_220;
  wire [31:0] _zz_221;
  wire [31:0] _zz_222;
  wire  _zz_223;
  wire [0:0] _zz_224;
  wire [0:0] _zz_225;
  wire  _zz_226;
  wire [0:0] _zz_227;
  wire [4:0] _zz_228;
  wire [31:0] _zz_229;
  wire [31:0] _zz_230;
  wire [31:0] _zz_231;
  wire [31:0] _zz_232;
  wire [0:0] _zz_233;
  wire [0:0] _zz_234;
  wire  _zz_235;
  wire [0:0] _zz_236;
  wire [0:0] _zz_237;
  wire  execute_BYPASSABLE_MEMORY_STAGE;
  wire  decode_BYPASSABLE_MEMORY_STAGE;
  wire  decode_BYPASSABLE_EXECUTE_STAGE;
  wire  decode_SRC_LESS_UNSIGNED;
  wire [31:0] writeBack_REGFILE_WRITE_DATA;
  wire [31:0] execute_REGFILE_WRITE_DATA;
  wire [31:0] memory_MEMORY_READ_DATA;
  wire `ShiftCtrlEnum_binary_sequancial_type decode_SHIFT_CTRL;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_1;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_2;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_3;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type decode_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_4;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_5;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_6;
  wire [31:0] decode_SRC2;
  wire [31:0] memory_PC;
  wire [31:0] fetch_PC;
  wire  decode_MEMORY_ENABLE;
  wire [1:0] memory_MEMORY_ADDRESS_LOW;
  wire [1:0] execute_MEMORY_ADDRESS_LOW;
  wire `BranchCtrlEnum_binary_sequancial_type decode_BRANCH_CTRL;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_7;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_8;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_9;
  wire [31:0] decode_RS2;
  wire [31:0] fetch_INSTRUCTION;
  wire `AluCtrlEnum_binary_sequancial_type decode_ALU_CTRL;
  wire `AluCtrlEnum_binary_sequancial_type _zz_10;
  wire `AluCtrlEnum_binary_sequancial_type _zz_11;
  wire `AluCtrlEnum_binary_sequancial_type _zz_12;
  wire  execute_BRANCH_DO;
  wire  decode_SRC_USE_SUB_LESS;
  wire [31:0] decode_RS1;
  wire [31:0] memory_FORMAL_PC_NEXT;
  wire [31:0] execute_FORMAL_PC_NEXT;
  wire [31:0] decode_FORMAL_PC_NEXT;
  wire [31:0] fetch_FORMAL_PC_NEXT;
  wire [31:0] prefetch_FORMAL_PC_NEXT;
  wire [31:0] execute_BRANCH_CALC;
  wire [31:0] decode_SRC1;
  wire [31:0] memory_BRANCH_CALC;
  wire  memory_BRANCH_DO;
  wire [31:0] _zz_13;
  wire [31:0] execute_PC;
  wire [31:0] execute_RS1;
  wire `BranchCtrlEnum_binary_sequancial_type execute_BRANCH_CTRL;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_14;
  wire  _zz_15;
  wire  decode_RS2_USE;
  wire  decode_RS1_USE;
  wire  execute_REGFILE_WRITE_VALID;
  wire  execute_BYPASSABLE_EXECUTE_STAGE;
  wire  memory_REGFILE_WRITE_VALID;
  wire  memory_BYPASSABLE_MEMORY_STAGE;
  wire  writeBack_REGFILE_WRITE_VALID;
  reg [31:0] _zz_16;
  wire [31:0] memory_REGFILE_WRITE_DATA;
  wire `ShiftCtrlEnum_binary_sequancial_type execute_SHIFT_CTRL;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_17;
  wire  _zz_18;
  wire [31:0] _zz_19;
  wire [31:0] _zz_20;
  wire  execute_SRC_LESS_UNSIGNED;
  wire  execute_SRC_USE_SUB_LESS;
  wire [31:0] _zz_21;
  wire [31:0] _zz_22;
  wire `Src2CtrlEnum_binary_sequancial_type decode_SRC2_CTRL;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_23;
  wire [31:0] _zz_24;
  wire [31:0] _zz_25;
  wire `Src1CtrlEnum_binary_sequancial_type decode_SRC1_CTRL;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_26;
  wire [31:0] _zz_27;
  wire [31:0] execute_SRC_ADD_SUB;
  wire  execute_SRC_LESS;
  wire `AluCtrlEnum_binary_sequancial_type execute_ALU_CTRL;
  wire `AluCtrlEnum_binary_sequancial_type _zz_28;
  wire [31:0] _zz_29;
  wire [31:0] execute_SRC2;
  wire [31:0] execute_SRC1;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type execute_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_30;
  wire [31:0] _zz_31;
  wire  _zz_32;
  reg  _zz_33;
  wire [31:0] _zz_34;
  wire [31:0] _zz_35;
  wire [31:0] decode_INSTRUCTION_ANTICIPATED;
  reg  decode_REGFILE_WRITE_VALID;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_36;
  wire  _zz_37;
  wire  _zz_38;
  wire  _zz_39;
  wire  _zz_40;
  wire  _zz_41;
  wire `AluCtrlEnum_binary_sequancial_type _zz_42;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_43;
  wire  _zz_44;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_45;
  wire  _zz_46;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_47;
  wire  _zz_48;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_49;
  reg [31:0] _zz_50;
  wire  writeBack_MEMORY_ENABLE;
  wire [1:0] writeBack_MEMORY_ADDRESS_LOW;
  wire [31:0] writeBack_MEMORY_READ_DATA;
  wire [31:0] memory_INSTRUCTION;
  wire  memory_MEMORY_ENABLE;
  wire [31:0] _zz_51;
  wire [1:0] _zz_52;
  wire [31:0] execute_RS2;
  wire [31:0] execute_SRC_ADD;
  wire [31:0] execute_INSTRUCTION;
  wire  execute_ALIGNEMENT_FAULT;
  wire  execute_MEMORY_ENABLE;
  wire  _zz_53;
  wire [31:0] _zz_54;
  wire [31:0] _zz_55;
  reg [31:0] _zz_56;
  wire [31:0] _zz_57;
  wire [31:0] prefetch_PC;
  wire [31:0] _zz_58;
  wire [31:0] _zz_59;
  wire [31:0] prefetch_PC_CALC_WITHOUT_JUMP;
  wire [31:0] _zz_60;
  wire [31:0] writeBack_PC /* verilator public */ ;
  wire [31:0] writeBack_INSTRUCTION /* verilator public */ ;
  wire [31:0] decode_PC /* verilator public */ ;
  wire [31:0] decode_INSTRUCTION /* verilator public */ ;
  reg  prefetch_arbitration_haltItself;
  wire  prefetch_arbitration_haltByOther;
  wire  prefetch_arbitration_removeIt;
  wire  prefetch_arbitration_flushAll;
  wire  prefetch_arbitration_redoIt;
  reg  prefetch_arbitration_isValid;
  wire  prefetch_arbitration_isStuck;
  wire  prefetch_arbitration_isStuckByOthers;
  wire  prefetch_arbitration_isFlushed;
  wire  prefetch_arbitration_isMoving;
  wire  prefetch_arbitration_isFiring;
  reg  fetch_arbitration_haltItself;
  wire  fetch_arbitration_haltByOther;
  reg  fetch_arbitration_removeIt;
  wire  fetch_arbitration_flushAll;
  wire  fetch_arbitration_redoIt;
  reg  fetch_arbitration_isValid;
  wire  fetch_arbitration_isStuck;
  wire  fetch_arbitration_isStuckByOthers;
  wire  fetch_arbitration_isFlushed;
  wire  fetch_arbitration_isMoving;
  wire  fetch_arbitration_isFiring;
  reg  decode_arbitration_haltItself /* verilator public */ ;
  wire  decode_arbitration_haltByOther;
  reg  decode_arbitration_removeIt;
  wire  decode_arbitration_flushAll /* verilator public */ ;
  wire  decode_arbitration_redoIt;
  reg  decode_arbitration_isValid /* verilator public */ ;
  wire  decode_arbitration_isStuck;
  wire  decode_arbitration_isStuckByOthers;
  wire  decode_arbitration_isFlushed;
  wire  decode_arbitration_isMoving;
  wire  decode_arbitration_isFiring;
  reg  execute_arbitration_haltItself;
  wire  execute_arbitration_haltByOther;
  reg  execute_arbitration_removeIt;
  reg  execute_arbitration_flushAll;
  wire  execute_arbitration_redoIt;
  reg  execute_arbitration_isValid;
  wire  execute_arbitration_isStuck;
  wire  execute_arbitration_isStuckByOthers;
  wire  execute_arbitration_isFlushed;
  wire  execute_arbitration_isMoving;
  wire  execute_arbitration_isFiring;
  reg  memory_arbitration_haltItself;
  wire  memory_arbitration_haltByOther;
  reg  memory_arbitration_removeIt;
  wire  memory_arbitration_flushAll;
  wire  memory_arbitration_redoIt;
  reg  memory_arbitration_isValid;
  wire  memory_arbitration_isStuck;
  wire  memory_arbitration_isStuckByOthers;
  wire  memory_arbitration_isFlushed;
  wire  memory_arbitration_isMoving;
  wire  memory_arbitration_isFiring;
  wire  writeBack_arbitration_haltItself;
  wire  writeBack_arbitration_haltByOther;
  reg  writeBack_arbitration_removeIt;
  wire  writeBack_arbitration_flushAll;
  wire  writeBack_arbitration_redoIt;
  reg  writeBack_arbitration_isValid /* verilator public */ ;
  wire  writeBack_arbitration_isStuck;
  wire  writeBack_arbitration_isStuckByOthers;
  wire  writeBack_arbitration_isFlushed;
  wire  writeBack_arbitration_isMoving;
  wire  writeBack_arbitration_isFiring /* verilator public */ ;
  wire  _zz_61;
  reg [31:0] prefetch_PcManagerSimplePlugin_pcReg /* verilator public */ ;
  reg  prefetch_PcManagerSimplePlugin_inc;
  wire [31:0] prefetch_PcManagerSimplePlugin_pcBeforeJumps;
  reg [31:0] prefetch_PcManagerSimplePlugin_pc;
  reg  prefetch_PcManagerSimplePlugin_samplePcNext;
  wire  prefetch_PcManagerSimplePlugin_jump_pcLoad_valid;
  wire [31:0] prefetch_PcManagerSimplePlugin_jump_pcLoad_payload;
  reg  prefetch_IBusSimplePlugin_pendingCmd;
  reg  _zz_62;
  reg [31:0] _zz_63;
  reg [31:0] _zz_64;
  reg [3:0] _zz_65;
  wire [3:0] execute_DBusSimplePlugin_formalMask;
  reg [31:0] writeBack_DBusSimplePlugin_rspShifted;
  wire  _zz_66;
  reg [31:0] _zz_67;
  wire  _zz_68;
  reg [31:0] _zz_69;
  reg [31:0] writeBack_DBusSimplePlugin_rspFormated;
  wire [19:0] _zz_70;
  wire  _zz_71;
  wire  _zz_72;
  wire  _zz_73;
  wire  _zz_74;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_75;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_76;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_77;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_78;
  wire `AluCtrlEnum_binary_sequancial_type _zz_79;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_80;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress1;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress2;
  wire [31:0] decode_RegFilePlugin_rs1Data;
  wire  _zz_81;
  wire [31:0] decode_RegFilePlugin_rs2Data;
  wire  _zz_82;
  reg  writeBack_RegFilePlugin_regFileWrite_valid /* verilator public */ ;
  wire [4:0] writeBack_RegFilePlugin_regFileWrite_payload_address /* verilator public */ ;
  wire [31:0] writeBack_RegFilePlugin_regFileWrite_payload_data /* verilator public */ ;
  reg  _zz_83;
  reg [31:0] execute_IntAluPlugin_bitwise;
  reg [31:0] _zz_84;
  reg [31:0] _zz_85;
  wire  _zz_86;
  reg [19:0] _zz_87;
  wire  _zz_88;
  reg [19:0] _zz_89;
  reg [31:0] _zz_90;
  wire [31:0] execute_SrcPlugin_addSub;
  wire  execute_SrcPlugin_less;
  reg  execute_LightShifterPlugin_isActive;
  wire  execute_LightShifterPlugin_isShift;
  reg [4:0] execute_LightShifterPlugin_amplitudeReg;
  wire [4:0] execute_LightShifterPlugin_amplitude;
  wire [31:0] execute_LightShifterPlugin_shiftInput;
  wire  execute_LightShifterPlugin_done;
  reg [31:0] _zz_91;
  reg  _zz_92;
  reg  _zz_93;
  reg  _zz_94;
  reg [4:0] _zz_95;
  wire  execute_BranchPlugin_eq;
  wire [2:0] _zz_96;
  reg  _zz_97;
  reg  _zz_98;
  wire [31:0] execute_BranchPlugin_branch_src1;
  wire  _zz_99;
  reg [10:0] _zz_100;
  wire  _zz_101;
  reg [19:0] _zz_102;
  wire  _zz_103;
  reg [18:0] _zz_104;
  reg [31:0] _zz_105;
  wire [31:0] execute_BranchPlugin_branch_src2;
  wire [31:0] execute_BranchPlugin_branchAdder;
  reg [31:0] _zz_106;
  reg [31:0] _zz_107;
  reg [31:0] _zz_108;
  reg [31:0] _zz_109;
  reg [31:0] _zz_110;
  reg [31:0] _zz_111;
  reg [31:0] _zz_112;
  reg  _zz_113;
  reg  _zz_114;
  reg `AluCtrlEnum_binary_sequancial_type _zz_115;
  reg [31:0] _zz_116;
  reg [31:0] _zz_117;
  reg [31:0] _zz_118;
  reg [31:0] _zz_119;
  reg  _zz_120;
  reg  _zz_121;
  reg  _zz_122;
  reg [31:0] _zz_123;
  reg `BranchCtrlEnum_binary_sequancial_type _zz_124;
  reg [1:0] _zz_125;
  reg [1:0] _zz_126;
  reg  _zz_127;
  reg  _zz_128;
  reg  _zz_129;
  reg [31:0] _zz_130;
  reg [31:0] _zz_131;
  reg [31:0] _zz_132;
  reg [31:0] _zz_133;
  reg [31:0] _zz_134;
  reg [31:0] _zz_135;
  reg `AluBitwiseCtrlEnum_binary_sequancial_type _zz_136;
  reg `ShiftCtrlEnum_binary_sequancial_type _zz_137;
  reg [31:0] _zz_138;
  reg [31:0] _zz_139;
  reg [31:0] _zz_140;
  reg  _zz_141;
  reg  _zz_142;
  reg  _zz_143;
  reg  _zz_144;
  reg [31:0] RegFilePlugin_regFile [0:31] /* verilator public */ ;
  assign iBus_cmd_valid = _zz_147;
  assign dBus_cmd_payload_size = _zz_148;
  assign dBus_cmd_payload_address = _zz_149;
  assign _zz_150 = (! execute_arbitration_isStuckByOthers);
  assign _zz_151 = ((execute_arbitration_isValid && execute_LightShifterPlugin_isShift) && (execute_SRC2[4 : 0] != (5'b00000)));
  assign _zz_152 = writeBack_INSTRUCTION[13 : 12];
  assign _zz_153 = {prefetch_PcManagerSimplePlugin_inc,(2'b00)};
  assign _zz_154 = {29'd0, _zz_153};
  assign _zz_155 = _zz_70[2 : 2];
  assign _zz_156 = _zz_70[5 : 5];
  assign _zz_157 = _zz_70[8 : 8];
  assign _zz_158 = _zz_70[13 : 13];
  assign _zz_159 = _zz_70[14 : 14];
  assign _zz_160 = _zz_70[15 : 15];
  assign _zz_161 = _zz_70[16 : 16];
  assign _zz_162 = _zz_70[17 : 17];
  assign _zz_163 = execute_SRC_LESS;
  assign _zz_164 = decode_INSTRUCTION[31 : 20];
  assign _zz_165 = {decode_INSTRUCTION[31 : 25],decode_INSTRUCTION[11 : 7]};
  assign _zz_166 = ($signed(_zz_167) + $signed(_zz_171));
  assign _zz_167 = ($signed(_zz_168) + $signed(_zz_169));
  assign _zz_168 = execute_SRC1;
  assign _zz_169 = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign _zz_170 = (execute_SRC_USE_SUB_LESS ? _zz_172 : _zz_173);
  assign _zz_171 = {{30{_zz_170[1]}}, _zz_170};
  assign _zz_172 = (2'b01);
  assign _zz_173 = (2'b00);
  assign _zz_174 = (_zz_175 >>> 1);
  assign _zz_175 = {((execute_SHIFT_CTRL == `ShiftCtrlEnum_binary_sequancial_SRA_1) && execute_LightShifterPlugin_shiftInput[31]),execute_LightShifterPlugin_shiftInput};
  assign _zz_176 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign _zz_177 = execute_INSTRUCTION[31 : 20];
  assign _zz_178 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz_179 = (decode_INSTRUCTION & (32'b00000000000000000001000000000000));
  assign _zz_180 = (32'b00000000000000000001000000000000);
  assign _zz_181 = ((decode_INSTRUCTION & _zz_190) == (32'b00000000000000000001000000000000));
  assign _zz_182 = ((decode_INSTRUCTION & _zz_191) == (32'b00000000000000000010000000000000));
  assign _zz_183 = ((decode_INSTRUCTION & _zz_192) == (32'b00000000000000000010000000000000));
  assign _zz_184 = ((decode_INSTRUCTION & _zz_193) == (32'b00000000000000000001000000000000));
  assign _zz_185 = {(_zz_194 == _zz_195),(_zz_196 == _zz_197)};
  assign _zz_186 = (2'b00);
  assign _zz_187 = (_zz_72 != (1'b0));
  assign _zz_188 = ({_zz_198,_zz_199} != (3'b000));
  assign _zz_189 = {(_zz_200 != _zz_201),{_zz_202,{_zz_203,_zz_204}}};
  assign _zz_190 = (32'b00000000000000000011000000000000);
  assign _zz_191 = (32'b00000000000000000011000000000000);
  assign _zz_192 = (32'b00000000000000000010000000010000);
  assign _zz_193 = (32'b00000000000000000101000000000000);
  assign _zz_194 = (decode_INSTRUCTION & (32'b00000000000000000000000000000100));
  assign _zz_195 = (32'b00000000000000000000000000000000);
  assign _zz_196 = (decode_INSTRUCTION & (32'b00000000000000000000000000011000));
  assign _zz_197 = (32'b00000000000000000000000000000000);
  assign _zz_198 = ((decode_INSTRUCTION & _zz_205) == (32'b00000000000000000000000001000000));
  assign _zz_199 = {(_zz_206 == _zz_207),(_zz_208 == _zz_209)};
  assign _zz_200 = {_zz_72,{_zz_74,_zz_73}};
  assign _zz_201 = (3'b000);
  assign _zz_202 = ({_zz_210,{_zz_211,_zz_212}} != (3'b000));
  assign _zz_203 = (_zz_213 != (1'b0));
  assign _zz_204 = {(_zz_214 != _zz_215),{_zz_216,{_zz_217,_zz_218}}};
  assign _zz_205 = (32'b00000000000000000000000001000100);
  assign _zz_206 = (decode_INSTRUCTION & (32'b01000000000000000000000000110000));
  assign _zz_207 = (32'b01000000000000000000000000110000);
  assign _zz_208 = (decode_INSTRUCTION & (32'b00000000000000000010000000010100));
  assign _zz_209 = (32'b00000000000000000010000000010000);
  assign _zz_210 = ((decode_INSTRUCTION & (32'b00000000000000000100000000000100)) == (32'b00000000000000000100000000000000));
  assign _zz_211 = ((decode_INSTRUCTION & _zz_219) == (32'b00000000000000000000000000100100));
  assign _zz_212 = ((decode_INSTRUCTION & _zz_220) == (32'b00000000000000000001000000000000));
  assign _zz_213 = ((decode_INSTRUCTION & (32'b00000000000000000110000000000100)) == (32'b00000000000000000010000000000000));
  assign _zz_214 = {_zz_74,(_zz_221 == _zz_222)};
  assign _zz_215 = (2'b00);
  assign _zz_216 = ({_zz_74,_zz_73} != (2'b00));
  assign _zz_217 = (_zz_223 != (1'b0));
  assign _zz_218 = {(_zz_224 != _zz_225),{_zz_226,{_zz_227,_zz_228}}};
  assign _zz_219 = (32'b00000000000000000000000001100100);
  assign _zz_220 = (32'b00000000000000000011000000000100);
  assign _zz_221 = (decode_INSTRUCTION & (32'b00000000000000000000000001110000));
  assign _zz_222 = (32'b00000000000000000000000000100000);
  assign _zz_223 = ((decode_INSTRUCTION & (32'b00000000000000000000000001010000)) == (32'b00000000000000000000000000000000));
  assign _zz_224 = ((decode_INSTRUCTION & (32'b00000000000000000111000000010100)) == (32'b00000000000000000101000000010000));
  assign _zz_225 = (1'b0);
  assign _zz_226 = ({(_zz_229 == _zz_230),(_zz_231 == _zz_232)} != (2'b00));
  assign _zz_227 = (_zz_72 != (1'b0));
  assign _zz_228 = {(_zz_71 != (1'b0)),{(_zz_233 != _zz_234),{_zz_235,{_zz_236,_zz_237}}}};
  assign _zz_229 = (decode_INSTRUCTION & (32'b01000000000000000011000000010100));
  assign _zz_230 = (32'b01000000000000000001000000010000);
  assign _zz_231 = (decode_INSTRUCTION & (32'b00000000000000000111000000010100));
  assign _zz_232 = (32'b00000000000000000001000000010000);
  assign _zz_233 = ((decode_INSTRUCTION & (32'b00000000000000000000000001001000)) == (32'b00000000000000000000000001000000));
  assign _zz_234 = (1'b0);
  assign _zz_235 = (((decode_INSTRUCTION & (32'b00000000000000000000000000100100)) == (32'b00000000000000000000000000100000)) != (1'b0));
  assign _zz_236 = (_zz_71 != (1'b0));
  assign _zz_237 = (((decode_INSTRUCTION & (32'b00000000000000000000000001000100)) == (32'b00000000000000000000000000000100)) != (1'b0));
  always @ (posedge clk) begin
    if(_zz_33) begin
      RegFilePlugin_regFile[writeBack_RegFilePlugin_regFileWrite_payload_address] <= writeBack_RegFilePlugin_regFileWrite_payload_data;
    end
  end

  always @ (posedge clk) begin
    if(_zz_81) begin
      _zz_145 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress1];
    end
  end

  always @ (posedge clk) begin
    if(_zz_82) begin
      _zz_146 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress2];
    end
  end

  assign execute_BYPASSABLE_MEMORY_STAGE = _zz_143;
  assign decode_BYPASSABLE_MEMORY_STAGE = _zz_46;
  assign decode_BYPASSABLE_EXECUTE_STAGE = _zz_39;
  assign decode_SRC_LESS_UNSIGNED = _zz_37;
  assign writeBack_REGFILE_WRITE_DATA = _zz_140;
  assign execute_REGFILE_WRITE_DATA = _zz_29;
  assign memory_MEMORY_READ_DATA = _zz_51;
  assign decode_SHIFT_CTRL = _zz_1;
  assign _zz_2 = _zz_3;
  assign decode_ALU_BITWISE_CTRL = _zz_4;
  assign _zz_5 = _zz_6;
  assign decode_SRC2 = _zz_24;
  assign memory_PC = _zz_133;
  assign fetch_PC = _zz_130;
  assign decode_MEMORY_ENABLE = _zz_44;
  assign memory_MEMORY_ADDRESS_LOW = _zz_125;
  assign execute_MEMORY_ADDRESS_LOW = _zz_52;
  assign decode_BRANCH_CTRL = _zz_7;
  assign _zz_8 = _zz_9;
  assign decode_RS2 = _zz_34;
  assign fetch_INSTRUCTION = _zz_56;
  assign decode_ALU_CTRL = _zz_10;
  assign _zz_11 = _zz_12;
  assign execute_BRANCH_DO = _zz_15;
  assign decode_SRC_USE_SUB_LESS = _zz_40;
  assign decode_RS1 = _zz_35;
  assign memory_FORMAL_PC_NEXT = _zz_111;
  assign execute_FORMAL_PC_NEXT = _zz_110;
  assign decode_FORMAL_PC_NEXT = _zz_109;
  assign fetch_FORMAL_PC_NEXT = _zz_108;
  assign prefetch_FORMAL_PC_NEXT = _zz_58;
  assign execute_BRANCH_CALC = _zz_13;
  assign decode_SRC1 = _zz_27;
  assign memory_BRANCH_CALC = _zz_107;
  assign memory_BRANCH_DO = _zz_114;
  assign execute_PC = _zz_132;
  assign execute_RS1 = _zz_112;
  assign execute_BRANCH_CTRL = _zz_14;
  assign decode_RS2_USE = _zz_48;
  assign decode_RS1_USE = _zz_38;
  assign execute_REGFILE_WRITE_VALID = _zz_120;
  assign execute_BYPASSABLE_EXECUTE_STAGE = _zz_142;
  assign memory_REGFILE_WRITE_VALID = _zz_121;
  assign memory_BYPASSABLE_MEMORY_STAGE = _zz_144;
  assign writeBack_REGFILE_WRITE_VALID = _zz_122;
  always @ (*) begin
    _zz_16 = execute_REGFILE_WRITE_DATA;
    execute_arbitration_haltItself = 1'b0;
    if((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! dBus_cmd_ready)) && (! execute_ALIGNEMENT_FAULT)))begin
      execute_arbitration_haltItself = 1'b1;
    end
    if(_zz_151)begin
      _zz_16 = _zz_91;
      if(_zz_150)begin
        if(! execute_LightShifterPlugin_done) begin
          execute_arbitration_haltItself = 1'b1;
        end
      end
    end
  end

  assign memory_REGFILE_WRITE_DATA = _zz_139;
  assign execute_SHIFT_CTRL = _zz_17;
  assign execute_SRC_LESS_UNSIGNED = _zz_141;
  assign execute_SRC_USE_SUB_LESS = _zz_113;
  assign _zz_21 = decode_PC;
  assign _zz_22 = decode_RS2;
  assign decode_SRC2_CTRL = _zz_23;
  assign _zz_25 = decode_RS1;
  assign decode_SRC1_CTRL = _zz_26;
  assign execute_SRC_ADD_SUB = _zz_20;
  assign execute_SRC_LESS = _zz_18;
  assign execute_ALU_CTRL = _zz_28;
  assign execute_SRC2 = _zz_135;
  assign execute_SRC1 = _zz_106;
  assign execute_ALU_BITWISE_CTRL = _zz_30;
  assign _zz_31 = writeBack_INSTRUCTION;
  assign _zz_32 = writeBack_REGFILE_WRITE_VALID;
  always @ (*) begin
    _zz_33 = 1'b0;
    if(writeBack_RegFilePlugin_regFileWrite_valid)begin
      _zz_33 = 1'b1;
    end
  end

  assign decode_INSTRUCTION_ANTICIPATED = _zz_55;
  always @ (*) begin
    decode_REGFILE_WRITE_VALID = _zz_41;
    if((decode_INSTRUCTION[11 : 7] == (5'b00000)))begin
      decode_REGFILE_WRITE_VALID = 1'b0;
    end
  end

  always @ (*) begin
    _zz_50 = writeBack_REGFILE_WRITE_DATA;
    if((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE))begin
      _zz_50 = writeBack_DBusSimplePlugin_rspFormated;
    end
  end

  assign writeBack_MEMORY_ENABLE = _zz_129;
  assign writeBack_MEMORY_ADDRESS_LOW = _zz_126;
  assign writeBack_MEMORY_READ_DATA = _zz_138;
  assign memory_INSTRUCTION = _zz_118;
  assign memory_MEMORY_ENABLE = _zz_128;
  assign execute_RS2 = _zz_123;
  assign execute_SRC_ADD = _zz_19;
  assign execute_INSTRUCTION = _zz_117;
  assign execute_ALIGNEMENT_FAULT = _zz_53;
  assign execute_MEMORY_ENABLE = _zz_127;
  assign _zz_54 = fetch_INSTRUCTION;
  assign _zz_57 = prefetch_PC;
  assign prefetch_PC = _zz_59;
  assign prefetch_PC_CALC_WITHOUT_JUMP = _zz_60;
  assign writeBack_PC = _zz_134;
  assign writeBack_INSTRUCTION = _zz_119;
  assign decode_PC = _zz_131;
  assign decode_INSTRUCTION = _zz_116;
  always @ (*) begin
    prefetch_arbitration_haltItself = 1'b0;
    if(((! iBus_cmd_ready) || (prefetch_IBusSimplePlugin_pendingCmd && (! iBus_rsp_ready))))begin
      prefetch_arbitration_haltItself = 1'b1;
    end
  end

  assign prefetch_arbitration_haltByOther = 1'b0;
  assign prefetch_arbitration_removeIt = 1'b0;
  assign prefetch_arbitration_flushAll = 1'b0;
  assign prefetch_arbitration_redoIt = 1'b0;
  always @ (*) begin
    fetch_arbitration_haltItself = 1'b0;
    if(((fetch_arbitration_isValid && (! iBus_rsp_ready)) && (! _zz_62)))begin
      fetch_arbitration_haltItself = 1'b1;
    end
  end

  assign fetch_arbitration_haltByOther = 1'b0;
  always @ (*) begin
    fetch_arbitration_removeIt = 1'b0;
    if(fetch_arbitration_isFlushed)begin
      fetch_arbitration_removeIt = 1'b1;
    end
  end

  assign fetch_arbitration_flushAll = 1'b0;
  assign fetch_arbitration_redoIt = 1'b0;
  always @ (*) begin
    decode_arbitration_haltItself = 1'b0;
    if((decode_arbitration_isValid && (_zz_92 || _zz_93)))begin
      decode_arbitration_haltItself = 1'b1;
    end
  end

  assign decode_arbitration_haltByOther = 1'b0;
  always @ (*) begin
    decode_arbitration_removeIt = 1'b0;
    if(decode_arbitration_isFlushed)begin
      decode_arbitration_removeIt = 1'b1;
    end
  end

  assign decode_arbitration_flushAll = 1'b0;
  assign decode_arbitration_redoIt = 1'b0;
  assign execute_arbitration_haltByOther = 1'b0;
  always @ (*) begin
    execute_arbitration_removeIt = 1'b0;
    if(execute_arbitration_isFlushed)begin
      execute_arbitration_removeIt = 1'b1;
    end
  end

  always @ (*) begin
    execute_arbitration_flushAll = 1'b0;
    if(_zz_61)begin
      execute_arbitration_flushAll = 1'b1;
    end
  end

  assign execute_arbitration_redoIt = 1'b0;
  always @ (*) begin
    memory_arbitration_haltItself = 1'b0;
    if((((memory_arbitration_isValid && memory_MEMORY_ENABLE) && (! memory_INSTRUCTION[5])) && (! dBus_rsp_ready)))begin
      memory_arbitration_haltItself = 1'b1;
    end
  end

  assign memory_arbitration_haltByOther = 1'b0;
  always @ (*) begin
    memory_arbitration_removeIt = 1'b0;
    if(memory_arbitration_isFlushed)begin
      memory_arbitration_removeIt = 1'b1;
    end
  end

  assign memory_arbitration_flushAll = 1'b0;
  assign memory_arbitration_redoIt = 1'b0;
  assign writeBack_arbitration_haltItself = 1'b0;
  assign writeBack_arbitration_haltByOther = 1'b0;
  always @ (*) begin
    writeBack_arbitration_removeIt = 1'b0;
    if(writeBack_arbitration_isFlushed)begin
      writeBack_arbitration_removeIt = 1'b1;
    end
  end

  assign writeBack_arbitration_flushAll = 1'b0;
  assign writeBack_arbitration_redoIt = 1'b0;
  assign prefetch_PcManagerSimplePlugin_pcBeforeJumps = (prefetch_PcManagerSimplePlugin_pcReg + _zz_154);
  assign _zz_60 = prefetch_PcManagerSimplePlugin_pcBeforeJumps;
  always @ (*) begin
    prefetch_PcManagerSimplePlugin_pc = prefetch_PC_CALC_WITHOUT_JUMP;
    prefetch_PcManagerSimplePlugin_samplePcNext = 1'b0;
    if(prefetch_PcManagerSimplePlugin_jump_pcLoad_valid)begin
      prefetch_PcManagerSimplePlugin_samplePcNext = 1'b1;
      prefetch_PcManagerSimplePlugin_pc = prefetch_PcManagerSimplePlugin_jump_pcLoad_payload;
    end
    if(prefetch_arbitration_isFiring)begin
      prefetch_PcManagerSimplePlugin_samplePcNext = 1'b1;
    end
  end

  assign prefetch_PcManagerSimplePlugin_jump_pcLoad_valid = _zz_61;
  assign prefetch_PcManagerSimplePlugin_jump_pcLoad_payload = memory_BRANCH_CALC;
  assign _zz_59 = prefetch_PcManagerSimplePlugin_pc;
  assign _zz_58 = (prefetch_PC + (32'b00000000000000000000000000000100));
  assign _zz_147 = (((prefetch_arbitration_isValid && (! prefetch_arbitration_removeIt)) && (! prefetch_arbitration_isStuckByOthers)) && (! (prefetch_IBusSimplePlugin_pendingCmd && (! iBus_rsp_ready))));
  assign iBus_cmd_payload_pc = _zz_57;
  always @ (*) begin
    _zz_56 = iBus_rsp_inst;
    if(_zz_62)begin
      _zz_56 = _zz_63;
    end
  end

  assign _zz_55 = (decode_arbitration_isStuck ? decode_INSTRUCTION : _zz_54);
  assign _zz_53 = 1'b0;
  assign dBus_cmd_valid = ((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! execute_arbitration_isStuckByOthers)) && (! execute_arbitration_removeIt)) && (! execute_ALIGNEMENT_FAULT));
  assign dBus_cmd_payload_wr = execute_INSTRUCTION[5];
  assign _zz_149 = execute_SRC_ADD;
  assign _zz_148 = execute_INSTRUCTION[13 : 12];
  always @ (*) begin
    case(_zz_148)
      2'b00 : begin
        _zz_64 = {{{execute_RS2[7 : 0],execute_RS2[7 : 0]},execute_RS2[7 : 0]},execute_RS2[7 : 0]};
      end
      2'b01 : begin
        _zz_64 = {execute_RS2[15 : 0],execute_RS2[15 : 0]};
      end
      default : begin
        _zz_64 = execute_RS2[31 : 0];
      end
    endcase
  end

  assign dBus_cmd_payload_data = _zz_64;
  assign _zz_52 = _zz_149[1 : 0];
  always @ (*) begin
    case(_zz_148)
      2'b00 : begin
        _zz_65 = (4'b0001);
      end
      2'b01 : begin
        _zz_65 = (4'b0011);
      end
      default : begin
        _zz_65 = (4'b1111);
      end
    endcase
  end

  assign execute_DBusSimplePlugin_formalMask = (_zz_65 <<< _zz_149[1 : 0]);
  assign _zz_51 = dBus_rsp_data;
  always @ (*) begin
    writeBack_DBusSimplePlugin_rspShifted = writeBack_MEMORY_READ_DATA;
    case(writeBack_MEMORY_ADDRESS_LOW)
      2'b01 : begin
        writeBack_DBusSimplePlugin_rspShifted[7 : 0] = writeBack_MEMORY_READ_DATA[15 : 8];
      end
      2'b10 : begin
        writeBack_DBusSimplePlugin_rspShifted[15 : 0] = writeBack_MEMORY_READ_DATA[31 : 16];
      end
      2'b11 : begin
        writeBack_DBusSimplePlugin_rspShifted[7 : 0] = writeBack_MEMORY_READ_DATA[31 : 24];
      end
      default : begin
      end
    endcase
  end

  assign _zz_66 = (writeBack_DBusSimplePlugin_rspShifted[7] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_67[31] = _zz_66;
    _zz_67[30] = _zz_66;
    _zz_67[29] = _zz_66;
    _zz_67[28] = _zz_66;
    _zz_67[27] = _zz_66;
    _zz_67[26] = _zz_66;
    _zz_67[25] = _zz_66;
    _zz_67[24] = _zz_66;
    _zz_67[23] = _zz_66;
    _zz_67[22] = _zz_66;
    _zz_67[21] = _zz_66;
    _zz_67[20] = _zz_66;
    _zz_67[19] = _zz_66;
    _zz_67[18] = _zz_66;
    _zz_67[17] = _zz_66;
    _zz_67[16] = _zz_66;
    _zz_67[15] = _zz_66;
    _zz_67[14] = _zz_66;
    _zz_67[13] = _zz_66;
    _zz_67[12] = _zz_66;
    _zz_67[11] = _zz_66;
    _zz_67[10] = _zz_66;
    _zz_67[9] = _zz_66;
    _zz_67[8] = _zz_66;
    _zz_67[7 : 0] = writeBack_DBusSimplePlugin_rspShifted[7 : 0];
  end

  assign _zz_68 = (writeBack_DBusSimplePlugin_rspShifted[15] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_69[31] = _zz_68;
    _zz_69[30] = _zz_68;
    _zz_69[29] = _zz_68;
    _zz_69[28] = _zz_68;
    _zz_69[27] = _zz_68;
    _zz_69[26] = _zz_68;
    _zz_69[25] = _zz_68;
    _zz_69[24] = _zz_68;
    _zz_69[23] = _zz_68;
    _zz_69[22] = _zz_68;
    _zz_69[21] = _zz_68;
    _zz_69[20] = _zz_68;
    _zz_69[19] = _zz_68;
    _zz_69[18] = _zz_68;
    _zz_69[17] = _zz_68;
    _zz_69[16] = _zz_68;
    _zz_69[15 : 0] = writeBack_DBusSimplePlugin_rspShifted[15 : 0];
  end

  always @ (*) begin
    case(_zz_152)
      2'b00 : begin
        writeBack_DBusSimplePlugin_rspFormated = _zz_67;
      end
      2'b01 : begin
        writeBack_DBusSimplePlugin_rspFormated = _zz_69;
      end
      default : begin
        writeBack_DBusSimplePlugin_rspFormated = writeBack_DBusSimplePlugin_rspShifted;
      end
    endcase
  end

  assign _zz_71 = ((decode_INSTRUCTION & (32'b00000000000000000000000000010100)) == (32'b00000000000000000000000000000100));
  assign _zz_72 = ((decode_INSTRUCTION & (32'b00000000000000000000000000010000)) == (32'b00000000000000000000000000010000));
  assign _zz_73 = ((decode_INSTRUCTION & (32'b00000000000000000000000000100000)) == (32'b00000000000000000000000000000000));
  assign _zz_74 = ((decode_INSTRUCTION & (32'b00000000000000000000000000000100)) == (32'b00000000000000000000000000000100));
  assign _zz_70 = {({(_zz_179 == _zz_180),_zz_74} != (2'b00)),{({_zz_74,{_zz_181,_zz_182}} != (3'b000)),{({_zz_183,_zz_184} != (2'b00)),{(_zz_185 != _zz_186),{_zz_187,{_zz_188,_zz_189}}}}}};
  assign _zz_75 = _zz_70[1 : 0];
  assign _zz_49 = _zz_75;
  assign _zz_48 = _zz_155[0];
  assign _zz_76 = _zz_70[4 : 3];
  assign _zz_47 = _zz_76;
  assign _zz_46 = _zz_156[0];
  assign _zz_77 = _zz_70[7 : 6];
  assign _zz_45 = _zz_77;
  assign _zz_44 = _zz_157[0];
  assign _zz_78 = _zz_70[10 : 9];
  assign _zz_43 = _zz_78;
  assign _zz_79 = _zz_70[12 : 11];
  assign _zz_42 = _zz_79;
  assign _zz_41 = _zz_158[0];
  assign _zz_40 = _zz_159[0];
  assign _zz_39 = _zz_160[0];
  assign _zz_38 = _zz_161[0];
  assign _zz_37 = _zz_162[0];
  assign _zz_80 = _zz_70[19 : 18];
  assign _zz_36 = _zz_80;
  assign decode_RegFilePlugin_regFileReadAddress1 = decode_INSTRUCTION_ANTICIPATED[19 : 15];
  assign decode_RegFilePlugin_regFileReadAddress2 = decode_INSTRUCTION_ANTICIPATED[24 : 20];
  assign _zz_81 = 1'b1;
  assign decode_RegFilePlugin_rs1Data = _zz_145;
  assign _zz_82 = 1'b1;
  assign decode_RegFilePlugin_rs2Data = _zz_146;
  assign _zz_35 = decode_RegFilePlugin_rs1Data;
  assign _zz_34 = decode_RegFilePlugin_rs2Data;
  always @ (*) begin
    writeBack_RegFilePlugin_regFileWrite_valid = (_zz_32 && writeBack_arbitration_isFiring);
    if(_zz_83)begin
      writeBack_RegFilePlugin_regFileWrite_valid = 1'b1;
    end
  end

  assign writeBack_RegFilePlugin_regFileWrite_payload_address = _zz_31[11 : 7];
  assign writeBack_RegFilePlugin_regFileWrite_payload_data = _zz_50;
  always @ (*) begin
    case(execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_binary_sequancial_AND_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 & execute_SRC2);
      end
      `AluBitwiseCtrlEnum_binary_sequancial_OR_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 | execute_SRC2);
      end
      `AluBitwiseCtrlEnum_binary_sequancial_XOR_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 ^ execute_SRC2);
      end
      default : begin
        execute_IntAluPlugin_bitwise = execute_SRC1;
      end
    endcase
  end

  always @ (*) begin
    case(execute_ALU_CTRL)
      `AluCtrlEnum_binary_sequancial_BITWISE : begin
        _zz_84 = execute_IntAluPlugin_bitwise;
      end
      `AluCtrlEnum_binary_sequancial_SLT_SLTU : begin
        _zz_84 = {31'd0, _zz_163};
      end
      default : begin
        _zz_84 = execute_SRC_ADD_SUB;
      end
    endcase
  end

  assign _zz_29 = _zz_84;
  always @ (*) begin
    case(decode_SRC1_CTRL)
      `Src1CtrlEnum_binary_sequancial_RS : begin
        _zz_85 = _zz_25;
      end
      `Src1CtrlEnum_binary_sequancial_FOUR : begin
        _zz_85 = (32'b00000000000000000000000000000100);
      end
      default : begin
        _zz_85 = {decode_INSTRUCTION[31 : 12],(12'b000000000000)};
      end
    endcase
  end

  assign _zz_27 = _zz_85;
  assign _zz_86 = _zz_164[11];
  always @ (*) begin
    _zz_87[19] = _zz_86;
    _zz_87[18] = _zz_86;
    _zz_87[17] = _zz_86;
    _zz_87[16] = _zz_86;
    _zz_87[15] = _zz_86;
    _zz_87[14] = _zz_86;
    _zz_87[13] = _zz_86;
    _zz_87[12] = _zz_86;
    _zz_87[11] = _zz_86;
    _zz_87[10] = _zz_86;
    _zz_87[9] = _zz_86;
    _zz_87[8] = _zz_86;
    _zz_87[7] = _zz_86;
    _zz_87[6] = _zz_86;
    _zz_87[5] = _zz_86;
    _zz_87[4] = _zz_86;
    _zz_87[3] = _zz_86;
    _zz_87[2] = _zz_86;
    _zz_87[1] = _zz_86;
    _zz_87[0] = _zz_86;
  end

  assign _zz_88 = _zz_165[11];
  always @ (*) begin
    _zz_89[19] = _zz_88;
    _zz_89[18] = _zz_88;
    _zz_89[17] = _zz_88;
    _zz_89[16] = _zz_88;
    _zz_89[15] = _zz_88;
    _zz_89[14] = _zz_88;
    _zz_89[13] = _zz_88;
    _zz_89[12] = _zz_88;
    _zz_89[11] = _zz_88;
    _zz_89[10] = _zz_88;
    _zz_89[9] = _zz_88;
    _zz_89[8] = _zz_88;
    _zz_89[7] = _zz_88;
    _zz_89[6] = _zz_88;
    _zz_89[5] = _zz_88;
    _zz_89[4] = _zz_88;
    _zz_89[3] = _zz_88;
    _zz_89[2] = _zz_88;
    _zz_89[1] = _zz_88;
    _zz_89[0] = _zz_88;
  end

  always @ (*) begin
    case(decode_SRC2_CTRL)
      `Src2CtrlEnum_binary_sequancial_RS : begin
        _zz_90 = _zz_22;
      end
      `Src2CtrlEnum_binary_sequancial_IMI : begin
        _zz_90 = {_zz_87,decode_INSTRUCTION[31 : 20]};
      end
      `Src2CtrlEnum_binary_sequancial_IMS : begin
        _zz_90 = {_zz_89,{decode_INSTRUCTION[31 : 25],decode_INSTRUCTION[11 : 7]}};
      end
      default : begin
        _zz_90 = _zz_21;
      end
    endcase
  end

  assign _zz_24 = _zz_90;
  assign execute_SrcPlugin_addSub = _zz_166;
  assign execute_SrcPlugin_less = ((execute_SRC1[31] == execute_SRC2[31]) ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31]));
  assign _zz_20 = execute_SrcPlugin_addSub;
  assign _zz_19 = execute_SrcPlugin_addSub;
  assign _zz_18 = execute_SrcPlugin_less;
  assign execute_LightShifterPlugin_isShift = (execute_SHIFT_CTRL != `ShiftCtrlEnum_binary_sequancial_DISABLE_1);
  assign execute_LightShifterPlugin_amplitude = (execute_LightShifterPlugin_isActive ? execute_LightShifterPlugin_amplitudeReg : execute_SRC2[4 : 0]);
  assign execute_LightShifterPlugin_shiftInput = (execute_LightShifterPlugin_isActive ? memory_REGFILE_WRITE_DATA : execute_SRC1);
  assign execute_LightShifterPlugin_done = (execute_LightShifterPlugin_amplitude[4 : 1] == (4'b0000));
  always @ (*) begin
    case(execute_SHIFT_CTRL)
      `ShiftCtrlEnum_binary_sequancial_SLL_1 : begin
        _zz_91 = (execute_LightShifterPlugin_shiftInput <<< 1);
      end
      default : begin
        _zz_91 = _zz_174;
      end
    endcase
  end

  always @ (*) begin
    _zz_92 = 1'b0;
    _zz_93 = 1'b0;
    if(_zz_94)begin
      if((_zz_95 == decode_INSTRUCTION[19 : 15]))begin
        _zz_92 = 1'b1;
      end
      if((_zz_95 == decode_INSTRUCTION[24 : 20]))begin
        _zz_93 = 1'b1;
      end
    end
    if((writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID))begin
      if((1'b1 || (! 1'b1)))begin
        if((writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]))begin
          _zz_92 = 1'b1;
        end
        if((writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]))begin
          _zz_93 = 1'b1;
        end
      end
    end
    if((memory_arbitration_isValid && memory_REGFILE_WRITE_VALID))begin
      if((1'b1 || (! memory_BYPASSABLE_MEMORY_STAGE)))begin
        if((memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]))begin
          _zz_92 = 1'b1;
        end
        if((memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]))begin
          _zz_93 = 1'b1;
        end
      end
    end
    if((execute_arbitration_isValid && execute_REGFILE_WRITE_VALID))begin
      if((1'b1 || (! execute_BYPASSABLE_EXECUTE_STAGE)))begin
        if((execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]))begin
          _zz_92 = 1'b1;
        end
        if((execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]))begin
          _zz_93 = 1'b1;
        end
      end
    end
    if((! decode_RS1_USE))begin
      _zz_92 = 1'b0;
    end
    if((! decode_RS2_USE))begin
      _zz_93 = 1'b0;
    end
  end

  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2);
  assign _zz_96 = execute_INSTRUCTION[14 : 12];
  always @ (*) begin
    if((_zz_96 == (3'b000))) begin
        _zz_97 = execute_BranchPlugin_eq;
    end else if((_zz_96 == (3'b001))) begin
        _zz_97 = (! execute_BranchPlugin_eq);
    end else if((((_zz_96 & (3'b101)) == (3'b101)))) begin
        _zz_97 = (! execute_SRC_LESS);
    end else begin
        _zz_97 = execute_SRC_LESS;
    end
  end

  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequancial_INC : begin
        _zz_98 = 1'b0;
      end
      `BranchCtrlEnum_binary_sequancial_JAL : begin
        _zz_98 = 1'b1;
      end
      `BranchCtrlEnum_binary_sequancial_JALR : begin
        _zz_98 = 1'b1;
      end
      default : begin
        _zz_98 = _zz_97;
      end
    endcase
  end

  assign _zz_15 = _zz_98;
  assign execute_BranchPlugin_branch_src1 = ((execute_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_JALR) ? execute_RS1 : execute_PC);
  assign _zz_99 = _zz_176[19];
  always @ (*) begin
    _zz_100[10] = _zz_99;
    _zz_100[9] = _zz_99;
    _zz_100[8] = _zz_99;
    _zz_100[7] = _zz_99;
    _zz_100[6] = _zz_99;
    _zz_100[5] = _zz_99;
    _zz_100[4] = _zz_99;
    _zz_100[3] = _zz_99;
    _zz_100[2] = _zz_99;
    _zz_100[1] = _zz_99;
    _zz_100[0] = _zz_99;
  end

  assign _zz_101 = _zz_177[11];
  always @ (*) begin
    _zz_102[19] = _zz_101;
    _zz_102[18] = _zz_101;
    _zz_102[17] = _zz_101;
    _zz_102[16] = _zz_101;
    _zz_102[15] = _zz_101;
    _zz_102[14] = _zz_101;
    _zz_102[13] = _zz_101;
    _zz_102[12] = _zz_101;
    _zz_102[11] = _zz_101;
    _zz_102[10] = _zz_101;
    _zz_102[9] = _zz_101;
    _zz_102[8] = _zz_101;
    _zz_102[7] = _zz_101;
    _zz_102[6] = _zz_101;
    _zz_102[5] = _zz_101;
    _zz_102[4] = _zz_101;
    _zz_102[3] = _zz_101;
    _zz_102[2] = _zz_101;
    _zz_102[1] = _zz_101;
    _zz_102[0] = _zz_101;
  end

  assign _zz_103 = _zz_178[11];
  always @ (*) begin
    _zz_104[18] = _zz_103;
    _zz_104[17] = _zz_103;
    _zz_104[16] = _zz_103;
    _zz_104[15] = _zz_103;
    _zz_104[14] = _zz_103;
    _zz_104[13] = _zz_103;
    _zz_104[12] = _zz_103;
    _zz_104[11] = _zz_103;
    _zz_104[10] = _zz_103;
    _zz_104[9] = _zz_103;
    _zz_104[8] = _zz_103;
    _zz_104[7] = _zz_103;
    _zz_104[6] = _zz_103;
    _zz_104[5] = _zz_103;
    _zz_104[4] = _zz_103;
    _zz_104[3] = _zz_103;
    _zz_104[2] = _zz_103;
    _zz_104[1] = _zz_103;
    _zz_104[0] = _zz_103;
  end

  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequancial_JAL : begin
        _zz_105 = {{_zz_100,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]}},1'b0};
      end
      `BranchCtrlEnum_binary_sequancial_JALR : begin
        _zz_105 = {_zz_102,execute_INSTRUCTION[31 : 20]};
      end
      default : begin
        _zz_105 = {{_zz_104,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0};
      end
    endcase
  end

  assign execute_BranchPlugin_branch_src2 = _zz_105;
  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2);
  assign _zz_13 = {execute_BranchPlugin_branchAdder[31 : 1],((execute_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_JALR) ? 1'b0 : execute_BranchPlugin_branchAdder[0])};
  assign _zz_61 = (memory_arbitration_isFiring && memory_BRANCH_DO);
  assign _zz_12 = decode_ALU_CTRL;
  assign _zz_10 = _zz_42;
  assign _zz_28 = _zz_115;
  assign _zz_26 = _zz_49;
  assign _zz_9 = decode_BRANCH_CTRL;
  assign _zz_7 = _zz_47;
  assign _zz_14 = _zz_124;
  assign _zz_6 = decode_ALU_BITWISE_CTRL;
  assign _zz_4 = _zz_36;
  assign _zz_30 = _zz_136;
  assign _zz_3 = decode_SHIFT_CTRL;
  assign _zz_1 = _zz_45;
  assign _zz_17 = _zz_137;
  assign _zz_23 = _zz_43;
  assign prefetch_arbitration_isFlushed = (((((prefetch_arbitration_flushAll || fetch_arbitration_flushAll) || decode_arbitration_flushAll) || execute_arbitration_flushAll) || memory_arbitration_flushAll) || writeBack_arbitration_flushAll);
  assign fetch_arbitration_isFlushed = ((((fetch_arbitration_flushAll || decode_arbitration_flushAll) || execute_arbitration_flushAll) || memory_arbitration_flushAll) || writeBack_arbitration_flushAll);
  assign decode_arbitration_isFlushed = (((decode_arbitration_flushAll || execute_arbitration_flushAll) || memory_arbitration_flushAll) || writeBack_arbitration_flushAll);
  assign execute_arbitration_isFlushed = ((execute_arbitration_flushAll || memory_arbitration_flushAll) || writeBack_arbitration_flushAll);
  assign memory_arbitration_isFlushed = (memory_arbitration_flushAll || writeBack_arbitration_flushAll);
  assign writeBack_arbitration_isFlushed = writeBack_arbitration_flushAll;
  assign prefetch_arbitration_isStuckByOthers = (prefetch_arbitration_haltByOther || (((((1'b0 || fetch_arbitration_haltItself) || decode_arbitration_haltItself) || execute_arbitration_haltItself) || memory_arbitration_haltItself) || writeBack_arbitration_haltItself));
  assign prefetch_arbitration_isStuck = (prefetch_arbitration_haltItself || prefetch_arbitration_isStuckByOthers);
  assign prefetch_arbitration_isMoving = ((! prefetch_arbitration_isStuck) && (! prefetch_arbitration_removeIt));
  assign prefetch_arbitration_isFiring = ((prefetch_arbitration_isValid && (! prefetch_arbitration_isStuck)) && (! prefetch_arbitration_removeIt));
  assign fetch_arbitration_isStuckByOthers = (fetch_arbitration_haltByOther || ((((1'b0 || decode_arbitration_haltItself) || execute_arbitration_haltItself) || memory_arbitration_haltItself) || writeBack_arbitration_haltItself));
  assign fetch_arbitration_isStuck = (fetch_arbitration_haltItself || fetch_arbitration_isStuckByOthers);
  assign fetch_arbitration_isMoving = ((! fetch_arbitration_isStuck) && (! fetch_arbitration_removeIt));
  assign fetch_arbitration_isFiring = ((fetch_arbitration_isValid && (! fetch_arbitration_isStuck)) && (! fetch_arbitration_removeIt));
  assign decode_arbitration_isStuckByOthers = (decode_arbitration_haltByOther || (((1'b0 || execute_arbitration_haltItself) || memory_arbitration_haltItself) || writeBack_arbitration_haltItself));
  assign decode_arbitration_isStuck = (decode_arbitration_haltItself || decode_arbitration_isStuckByOthers);
  assign decode_arbitration_isMoving = ((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt));
  assign decode_arbitration_isFiring = ((decode_arbitration_isValid && (! decode_arbitration_isStuck)) && (! decode_arbitration_removeIt));
  assign execute_arbitration_isStuckByOthers = (execute_arbitration_haltByOther || ((1'b0 || memory_arbitration_haltItself) || writeBack_arbitration_haltItself));
  assign execute_arbitration_isStuck = (execute_arbitration_haltItself || execute_arbitration_isStuckByOthers);
  assign execute_arbitration_isMoving = ((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt));
  assign execute_arbitration_isFiring = ((execute_arbitration_isValid && (! execute_arbitration_isStuck)) && (! execute_arbitration_removeIt));
  assign memory_arbitration_isStuckByOthers = (memory_arbitration_haltByOther || (1'b0 || writeBack_arbitration_haltItself));
  assign memory_arbitration_isStuck = (memory_arbitration_haltItself || memory_arbitration_isStuckByOthers);
  assign memory_arbitration_isMoving = ((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt));
  assign memory_arbitration_isFiring = ((memory_arbitration_isValid && (! memory_arbitration_isStuck)) && (! memory_arbitration_removeIt));
  assign writeBack_arbitration_isStuckByOthers = (writeBack_arbitration_haltByOther || 1'b0);
  assign writeBack_arbitration_isStuck = (writeBack_arbitration_haltItself || writeBack_arbitration_isStuckByOthers);
  assign writeBack_arbitration_isMoving = ((! writeBack_arbitration_isStuck) && (! writeBack_arbitration_removeIt));
  assign writeBack_arbitration_isFiring = ((writeBack_arbitration_isValid && (! writeBack_arbitration_isStuck)) && (! writeBack_arbitration_removeIt));
  always @ (posedge clk) begin
    if(reset) begin
      prefetch_arbitration_isValid <= 1'b0;
      fetch_arbitration_isValid <= 1'b0;
      decode_arbitration_isValid <= 1'b0;
      execute_arbitration_isValid <= 1'b0;
      memory_arbitration_isValid <= 1'b0;
      writeBack_arbitration_isValid <= 1'b0;
      prefetch_PcManagerSimplePlugin_pcReg <= (32'b00000000000000000000000000000000);
      prefetch_PcManagerSimplePlugin_inc <= 1'b0;
      prefetch_IBusSimplePlugin_pendingCmd <= 1'b0;
      _zz_62 <= 1'b0;
      _zz_83 <= 1'b1;
      execute_LightShifterPlugin_isActive <= 1'b0;
      _zz_94 <= 1'b0;
      _zz_140 <= (32'b00000000000000000000000000000000);
      _zz_119 <= (32'b00000000000000000000000000000000);
    end else begin
      prefetch_arbitration_isValid <= 1'b1;
      if(prefetch_PcManagerSimplePlugin_jump_pcLoad_valid)begin
        prefetch_PcManagerSimplePlugin_inc <= 1'b0;
      end
      if(prefetch_arbitration_isFiring)begin
        prefetch_PcManagerSimplePlugin_inc <= 1'b1;
      end
      if(prefetch_PcManagerSimplePlugin_samplePcNext)begin
        prefetch_PcManagerSimplePlugin_pcReg <= prefetch_PcManagerSimplePlugin_pc;
      end
      if(iBus_rsp_ready)begin
        prefetch_IBusSimplePlugin_pendingCmd <= 1'b0;
      end
      if((_zz_147 && iBus_cmd_ready))begin
        prefetch_IBusSimplePlugin_pendingCmd <= 1'b1;
      end
      if(iBus_rsp_ready)begin
        _zz_62 <= 1'b1;
      end
      if((! fetch_arbitration_isStuck))begin
        _zz_62 <= 1'b0;
      end
      _zz_83 <= 1'b0;
      if(_zz_151)begin
        if(_zz_150)begin
          execute_LightShifterPlugin_isActive <= 1'b1;
          if(execute_LightShifterPlugin_done)begin
            execute_LightShifterPlugin_isActive <= 1'b0;
          end
        end
      end
      if(execute_arbitration_removeIt)begin
        execute_LightShifterPlugin_isActive <= 1'b0;
      end
      _zz_94 <= (_zz_32 && writeBack_arbitration_isFiring);
      if((! writeBack_arbitration_isStuck))begin
        _zz_119 <= memory_INSTRUCTION;
      end
      if((! writeBack_arbitration_isStuck))begin
        _zz_140 <= memory_REGFILE_WRITE_DATA;
      end
      if(((! fetch_arbitration_isStuck) || fetch_arbitration_removeIt))begin
        fetch_arbitration_isValid <= 1'b0;
      end
      if(((! prefetch_arbitration_isStuck) && (! prefetch_arbitration_removeIt)))begin
        fetch_arbitration_isValid <= prefetch_arbitration_isValid;
      end
      if(((! decode_arbitration_isStuck) || decode_arbitration_removeIt))begin
        decode_arbitration_isValid <= 1'b0;
      end
      if(((! fetch_arbitration_isStuck) && (! fetch_arbitration_removeIt)))begin
        decode_arbitration_isValid <= fetch_arbitration_isValid;
      end
      if(((! execute_arbitration_isStuck) || execute_arbitration_removeIt))begin
        execute_arbitration_isValid <= 1'b0;
      end
      if(((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt)))begin
        execute_arbitration_isValid <= decode_arbitration_isValid;
      end
      if(((! memory_arbitration_isStuck) || memory_arbitration_removeIt))begin
        memory_arbitration_isValid <= 1'b0;
      end
      if(((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt)))begin
        memory_arbitration_isValid <= execute_arbitration_isValid;
      end
      if(((! writeBack_arbitration_isStuck) || writeBack_arbitration_removeIt))begin
        writeBack_arbitration_isValid <= 1'b0;
      end
      if(((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt)))begin
        writeBack_arbitration_isValid <= memory_arbitration_isValid;
      end
    end
  end

  always @ (posedge clk) begin
    if((! _zz_62))begin
      _zz_63 <= iBus_rsp_inst;
    end
    if (!(! (((dBus_rsp_ready && memory_MEMORY_ENABLE) && memory_arbitration_isValid) && memory_arbitration_isStuck))) begin
      $display("ERROR DBusSimplePlugin doesn't allow memory stage stall when read happend");
    end
    if (!(! (((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE) && (! writeBack_INSTRUCTION[5])) && writeBack_arbitration_isStuck))) begin
      $display("ERROR DBusSimplePlugin doesn't allow memory stage stall when read happend");
    end
    if(_zz_151)begin
      if(_zz_150)begin
        execute_LightShifterPlugin_amplitudeReg <= (execute_LightShifterPlugin_amplitude - (5'b00001));
      end
    end
    _zz_95 <= _zz_31[11 : 7];
    if((! execute_arbitration_isStuck))begin
      _zz_106 <= decode_SRC1;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_107 <= execute_BRANCH_CALC;
    end
    if((! fetch_arbitration_isStuck))begin
      _zz_108 <= prefetch_FORMAL_PC_NEXT;
    end
    if((! decode_arbitration_isStuck))begin
      _zz_109 <= fetch_FORMAL_PC_NEXT;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_110 <= decode_FORMAL_PC_NEXT;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_111 <= execute_FORMAL_PC_NEXT;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_112 <= _zz_25;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_113 <= decode_SRC_USE_SUB_LESS;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_114 <= execute_BRANCH_DO;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_115 <= _zz_11;
    end
    if((! decode_arbitration_isStuck))begin
      _zz_116 <= _zz_54;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_117 <= decode_INSTRUCTION;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_118 <= execute_INSTRUCTION;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_120 <= decode_REGFILE_WRITE_VALID;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_121 <= execute_REGFILE_WRITE_VALID;
    end
    if((! writeBack_arbitration_isStuck))begin
      _zz_122 <= memory_REGFILE_WRITE_VALID;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_123 <= _zz_22;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_124 <= _zz_8;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_125 <= execute_MEMORY_ADDRESS_LOW;
    end
    if((! writeBack_arbitration_isStuck))begin
      _zz_126 <= memory_MEMORY_ADDRESS_LOW;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_127 <= decode_MEMORY_ENABLE;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_128 <= execute_MEMORY_ENABLE;
    end
    if((! writeBack_arbitration_isStuck))begin
      _zz_129 <= memory_MEMORY_ENABLE;
    end
    if((! fetch_arbitration_isStuck))begin
      _zz_130 <= _zz_57;
    end
    if((! decode_arbitration_isStuck))begin
      _zz_131 <= fetch_PC;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_132 <= _zz_21;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_133 <= execute_PC;
    end
    if((! writeBack_arbitration_isStuck))begin
      _zz_134 <= memory_PC;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_135 <= decode_SRC2;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_136 <= _zz_5;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_137 <= _zz_2;
    end
    if((! writeBack_arbitration_isStuck))begin
      _zz_138 <= memory_MEMORY_READ_DATA;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_139 <= _zz_16;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_141 <= decode_SRC_LESS_UNSIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_142 <= decode_BYPASSABLE_EXECUTE_STAGE;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_143 <= decode_BYPASSABLE_MEMORY_STAGE;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_144 <= execute_BYPASSABLE_MEMORY_STAGE;
    end
    if (!(prefetch_arbitration_removeIt == 1'b0)) begin
      $display("ERROR removeIt should never be asserted on this stage");
    end
  end

endmodule

