-- Produced by NSL Core(version=20160105), IP ARCH, Inc. Wed Mar 23 22:09:45 2016
-- Licensed to :EVALUATION USER
--- DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. ---
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity m65 is 
    port(p_reset: in std_logic; m_clock: in std_logic;
 n_sync: out std_logic;
 n_wt: out std_logic;
 n_rd: out std_logic;
 n_start: in std_logic;
 n_rdy: in std_logic;
 n_nmi: in std_logic;
 n_irq: in std_logic;
 n_debug: out std_logic_vector(15 downto 0);
 n_adrs: out std_logic_vector(15 downto 0);
 n_datao: out std_logic_vector(7 downto 0);
 n_data: in std_logic_vector(7 downto 0));
end m65;

architecture RTL of m65 is

 

component inc16 
    port(p_reset: in std_logic; m_clock: in std_logic;
 n_thr: in std_logic;
 n_dox: in std_logic;
 n_out: out std_logic_vector(15 downto 0);
 n_co: out std_logic;
 n_in: in std_logic_vector(15 downto 0);
 n_ci: in std_logic);
end component;


component alu65 
    port(p_reset: in std_logic; m_clock: in std_logic;
 n_thr: in std_logic;
 n_rol: in std_logic;
 n_ror: in std_logic;
 n_lsr: in std_logic;
 n_asl: in std_logic;
 n_incc: in std_logic;
 n_dec2: in std_logic;
 n_dec: in std_logic;
 n_inc: in std_logic;
 n_eor: in std_logic;
 n_do_or: in std_logic;
 n_bita: in std_logic;
 n_do_and: in std_logic;
 n_sbc: in std_logic;
 n_adc: in std_logic;
 n_c: out std_logic;
 n_z: out std_logic;
 n_v: out std_logic;
 n_s: out std_logic;
 n_out: out std_logic_vector(7 downto 0);
 n_df: in std_logic;
 n_ci: in std_logic;
 n_in2: in std_logic_vector(7 downto 0);
 n_in1: in std_logic_vector(7 downto 0));
end component;

  signal n_s1: std_logic;
  signal n_s2: std_logic;
  signal n_s3: std_logic;
  signal n_s4: std_logic;
  signal n_s5: std_logic;
  signal n_ifrun: std_logic;
  signal n_pf: std_logic;
  signal n_write: std_logic;
  signal n_read: std_logic;
  signal n_decop: std_logic;
  signal n_ea: std_logic;
  signal n_dasl: std_logic;
  signal n_dbit: std_logic;
  signal n_dclc: std_logic;
  signal n_dcmp: std_logic;
  signal n_dcpx: std_logic;
  signal n_ddec: std_logic;
  signal n_dmisc: std_logic;
  signal n_djmp: std_logic;
  signal n_djsr: std_logic;
  signal n_dlda: std_logic;
  signal n_dldx: std_logic;
  signal n_dnop: std_logic;
  signal n_dora: std_logic;
  signal n_dphp: std_logic;
  signal n_dplp: std_logic;
  signal n_drti: std_logic;
  signal n_drts: std_logic;
  signal n_dsta: std_logic;
  signal n_dstx: std_logic;
  signal n_dbc: std_logic;
  signal n_mimp: std_logic;
  signal n_mimm: std_logic;
  signal n_mzpx: std_logic;
  signal n_mzpxi: std_logic;
  signal n_mzpiy: std_logic;
  signal n_mabs: std_logic;
  signal n_maby: std_logic;
  signal n_rmw: std_logic;
  signal n_nif0: std_logic;
  signal n_nif1: std_logic;
  signal n_nif2: std_logic;
  signal n_fn: std_logic;
  signal n_fv: std_logic;
  signal n_fd: std_logic;
  signal n_fz: std_logic;
  signal n_fc: std_logic;
  signal n_fi: std_logic;
  signal n_swt: std_logic;
  signal n_nm1: std_logic;
  signal n_tc: std_logic;
  signal n_psr: std_logic_vector(7 downto 0);
  signal n_psri: std_logic_vector(7 downto 0);
  signal n_taken: std_logic;
  signal n_ALU1: std_logic_vector(7 downto 0);
  signal n_ABLin: std_logic_vector(7 downto 0);
  signal n_dbo: std_logic_vector(7 downto 0);
  signal n_dbi: std_logic_vector(7 downto 0);
  signal n_opc: std_logic_vector(7 downto 0);
  signal n_RY: std_logic_vector(7 downto 0);
  signal n_RX: std_logic_vector(7 downto 0);
  signal n_RS: std_logic_vector(7 downto 0);
  signal n_RA: std_logic_vector(7 downto 0);
  signal n_PCL: std_logic_vector(7 downto 0);
  signal n_DL: std_logic_vector(7 downto 0);
  signal n_OP: std_logic_vector(7 downto 0);
  signal n_rABH: std_logic_vector(7 downto 0);
  signal n_rABL: std_logic_vector(7 downto 0);
  signal n_PCH: std_logic_vector(7 downto 0);
  signal n_setpsr: std_logic;
  signal n_ift_run: std_logic;
  signal n_do_nmi: std_logic;
  signal n_do_irq: std_logic;
  signal n_do_brk: std_logic;
  signal n_do_res: std_logic;
  signal n_int_req: std_logic;
  signal n_ex_st: std_logic_vector(5 downto 0);
  signal n_dbgreg: std_logic_vector(15 downto 0);
  signal n_rdflg: std_logic;
  signal n_dbg_datai: std_logic_vector(7 downto 0);
  signal n_ex: std_logic;
  signal v_alu_in1: std_logic_vector(7 downto 0);
  signal v_alu_in2: std_logic_vector(7 downto 0);
  signal v_alu_ci: std_logic;
  signal v_alu_df: std_logic;
  signal v_alu_out: std_logic_vector(7 downto 0);
  signal v_alu_s: std_logic;
  signal v_alu_v: std_logic;
  signal v_alu_z: std_logic;
  signal v_alu_c: std_logic;
  signal v_alu_adc: std_logic;
  signal v_alu_sbc: std_logic;
  signal v_alu_do_and: std_logic;
  signal v_alu_bita: std_logic;
  signal v_alu_do_or: std_logic;
  signal v_alu_eor: std_logic;
  signal v_alu_inc: std_logic;
  signal v_alu_dec: std_logic;
  signal v_alu_dec2: std_logic;
  signal v_alu_incc: std_logic;
  signal v_alu_asl: std_logic;
  signal v_alu_lsr: std_logic;
  signal v_alu_ror: std_logic;
  signal v_alu_rol: std_logic;
  signal v_alu_thr: std_logic;
  signal v_alu_p_reset: std_logic;
  signal v_alu_m_clock: std_logic;
  signal v_incr_in: std_logic_vector(15 downto 0);
  signal v_incr_ci: std_logic;
  signal v_incr_out: std_logic_vector(15 downto 0);
  signal v_incr_co: std_logic;
  signal v_incr_dox: std_logic;
  signal v_incr_thr: std_logic;
  signal v_incr_p_reset: std_logic;
  signal v_incr_m_clock: std_logic;
  signal v_proc_ift_run_set: std_logic;
  signal v_proc_ift_run_reset: std_logic;
  signal v_proc_do_nmi_set: std_logic;
  signal v_proc_do_nmi_reset: std_logic;
  signal v_proc_do_irq_set: std_logic;
  signal v_proc_do_irq_reset: std_logic;
  signal v_proc_do_brk_set: std_logic;
  signal v_proc_do_brk_reset: std_logic;
  signal v_proc_do_res_set: std_logic;
  signal v_proc_do_res_reset: std_logic;
  signal v_proc_int_req_set: std_logic;
  signal v_proc_int_req_reset: std_logic;
  signal v_proc_ex_set: std_logic;
  signal v_proc_ex_reset: std_logic;
  signal v_net_43: std_logic;
  signal v_net_44: std_logic;
  signal v_net_45: std_logic;
  signal v_net_46: std_logic;
  signal v_net_47: std_logic;
  signal v_net_48: std_logic;
  signal v_net_49: std_logic;
  signal v_net_50: std_logic;
  signal v_net_51: std_logic;
  signal v_net_52: std_logic;
  signal v_net_53: std_logic;
  signal v_net_54: std_logic;
  signal v_net_55: std_logic;
  signal v_net_56: std_logic;
  signal v_net_57: std_logic;
  signal v_net_58: std_logic;
  signal v_net_59: std_logic;
  signal v_net_60: std_logic;
  signal v_net_61: std_logic;
  signal v_net_62: std_logic;
  signal v_net_63: std_logic;
  signal v_net_64: std_logic;
  signal v_net_65: std_logic;
  signal v_net_66: std_logic;
  signal v_net_67: std_logic;
  signal v_net_68: std_logic;
  signal v_net_69: std_logic;
  signal v_net_70: std_logic;
  signal v_net_71: std_logic;
  signal v_net_72: std_logic;
  signal v_net_73: std_logic;
  signal v_net_74: std_logic;
  signal v_net_75: std_logic;
  signal v_net_76: std_logic;
  signal v_net_77: std_logic;
  signal v_net_78: std_logic;
  signal v_net_79: std_logic;
  signal v_net_80: std_logic;
  signal v_net_81: std_logic;
  signal v_net_82: std_logic;
  signal v_net_83: std_logic;
  signal v_net_84: std_logic;
  signal v_net_85: std_logic;
  signal v_net_86: std_logic;
  signal v_net_87: std_logic;
  signal v_net_88: std_logic;
  signal v_net_89: std_logic;
  signal v_net_90: std_logic;
  signal v_net_91: std_logic;
  signal v_net_92: std_logic;
  signal v_net_93: std_logic;
  signal v_net_94: std_logic;
  signal v_net_95: std_logic;
  signal v_net_96: std_logic;
  signal v_net_97: std_logic;
  signal v_net_98: std_logic;
  signal v_net_99: std_logic;
  signal v_net_100: std_logic;
  signal v_net_101: std_logic;
  signal v_net_102: std_logic;
  signal v_net_103: std_logic;
  signal v_net_104: std_logic;
  signal v_net_105: std_logic;
  signal v_net_106: std_logic;
  signal v_net_107: std_logic;
  signal v_net_108: std_logic;
  signal v_net_109: std_logic;
  signal v_net_110: std_logic;
  signal v_net_111: std_logic;
  signal v_net_112: std_logic;
  signal v_net_113: std_logic;
  signal v_net_114: std_logic;
  signal v_net_115: std_logic;
  signal v_net_116: std_logic;
  signal v_net_117: std_logic;
  signal v_net_118: std_logic;
  signal v_net_119: std_logic;
  signal v_net_120: std_logic;
  signal v_net_121: std_logic;
  signal v_net_122: std_logic;
  signal v_net_123: std_logic;
  signal v_net_124: std_logic;
  signal v_net_125: std_logic;
  signal v_net_126: std_logic;
  signal v_net_127: std_logic;
  signal v_net_128: std_logic;
  signal v_net_129: std_logic;
  signal v_net_130: std_logic;
  signal v_net_131: std_logic;
  signal v_net_132: std_logic;
  signal v_net_133: std_logic;
  signal v_net_134: std_logic;
  signal v_net_135: std_logic;
  signal v_net_136: std_logic;
  signal v_net_137: std_logic;
  signal v_net_138: std_logic;
  signal v_net_139: std_logic;
  signal v_net_140: std_logic;
  signal v_net_141: std_logic;
  signal v_net_142: std_logic;
  signal v_net_143: std_logic;
  signal v_net_144: std_logic;
  signal v_net_145: std_logic;
  signal v_net_146: std_logic;
  signal v_net_147: std_logic;
  signal v_net_148: std_logic;
  signal v_net_149: std_logic;
  signal v_net_150: std_logic;
  signal v_net_151: std_logic;
  signal v_net_152: std_logic;
  signal v_net_153: std_logic;
  signal v_net_154: std_logic;
  signal v_net_155: std_logic;
  signal v_net_156: std_logic;
  signal v_net_157: std_logic;
  signal v_net_158: std_logic;
  signal v_net_159: std_logic;
  signal v_net_160: std_logic;
  signal v_net_161: std_logic;
  signal v_net_162: std_logic;
  signal v_net_163: std_logic;
  signal v_net_164: std_logic;
  signal v_net_165: std_logic;
  signal v_net_166: std_logic;
  signal v_net_167: std_logic;
  signal v_net_168: std_logic;
  signal v_net_169: std_logic;
  signal v_net_170: std_logic;
  signal v_net_171: std_logic;
  signal v_net_172: std_logic;
  signal v_net_173: std_logic;
  signal v_net_174: std_logic;
  signal v_net_175: std_logic;
  signal v_net_176: std_logic;
  signal v_net_177: std_logic;
  signal v_net_178: std_logic;
  signal v_net_179: std_logic;
  signal v_net_180: std_logic;
  signal v_net_181: std_logic;
  signal v_net_182: std_logic;
  signal v_net_183: std_logic;
  signal v_net_184: std_logic;
  signal v_net_185: std_logic;
  signal v_net_186: std_logic;
  signal v_net_187: std_logic;
  signal v_net_188: std_logic;
  signal v_net_189: std_logic;
  signal v_reg_190: std_logic_vector(2 downto 0);
  signal v_net_191: std_logic;
  signal v_net_192: std_logic;
  signal v_net_193: std_logic;
  signal v_net_194: std_logic;
  signal v_net_195: std_logic;
  signal v_net_196: std_logic;
  signal v_net_197: std_logic;
  signal v_net_198: std_logic;
  signal internal_n_datao: std_logic_vector(7 downto 0);
  signal internal_n_adrs: std_logic_vector(15 downto 0);
  signal internal_n_debug: std_logic_vector(15 downto 0);
  signal internal_n_rd: std_logic;
  signal internal_n_wt: std_logic;
  signal internal_n_sync: std_logic;
  constant v_state_v_reg_190_st0: std_logic_vector(2 downto 0) := "000";
  constant v_state_v_reg_190_st1: std_logic_vector(2 downto 0) := "001";
  constant v_state_v_reg_190_st2: std_logic_vector(2 downto 0) := "010";
  constant v_state_v_reg_190_st3: std_logic_vector(2 downto 0) := "011";
  constant v_state_v_reg_190_st4: std_logic_vector(2 downto 0) := "100";
  constant v_state_v_reg_190_st5: std_logic_vector(2 downto 0) := "101";
  constant v_state_v_reg_190_st6: std_logic_vector(2 downto 0) := "110";
  constant v_net_199: std_logic_vector(7 downto 0) := "11111100";
  constant v_net_200: std_logic_vector(7 downto 0) := "11111110";
  constant v_net_201: std_logic_vector(7 downto 0) := "11111010";
  constant v_net_202: std_logic_vector(7 downto 0) := "11111110";
  constant v_net_203: std_logic_vector(3 downto 0) := "1111";
  constant v_net_204: std_logic_vector(2 downto 0) := "111";
  constant v_net_205: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_206: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_207: std_logic_vector(7 downto 0) := "00000001";
  constant v_net_208: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_209: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_210: std_logic_vector(7 downto 0) := "00000001";
  constant v_net_211: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_212: std_logic_vector(7 downto 0) := "00000001";
  constant v_net_213: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_214: std_logic_vector(7 downto 0) := "00000001";
  constant v_net_215: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_216: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_217: std_logic_vector(7 downto 0) := "00000001";
  constant v_net_218: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_219: std_logic_vector(7 downto 0) := "00000001";
  constant v_net_220: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_221: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_222: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_223: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_224: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_225: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_226: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_227: std_logic_vector(7 downto 0) := "00000000";
  constant v_net_228: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_229: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_230: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_231: std_logic_vector(7 downto 0) := "00000000";
  constant v_net_232: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_233: std_logic_vector(7 downto 0) := "00000000";
  constant v_net_234: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_235: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_236: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_237: std_logic_vector(7 downto 0) := "00000000";
  constant v_net_238: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_239: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_240: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_241: std_logic_vector(7 downto 0) := "00000001";
  constant v_net_242: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_243: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_244: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_245: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_246: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_247: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_248: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_249: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_250: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_251: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_252: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_253: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_254: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_255: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_256: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_257: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_258: std_logic_vector(5 downto 0) := "000001";
  constant v_net_259: std_logic_vector(5 downto 0) := "100000";
  constant v_net_260: std_logic_vector(5 downto 0) := "010000";
  constant v_net_261: std_logic_vector(5 downto 0) := "001000";
  constant v_net_262: std_logic_vector(5 downto 0) := "000100";
  constant v_net_263: std_logic_vector(5 downto 0) := "000010";
  constant v_net_264: std_logic_vector(6 downto 0) := "0101000";
  constant v_net_265: std_logic_vector(6 downto 0) := "0001000";
  constant v_net_266: std_logic_vector(7 downto 0) := "01100000";
  constant v_net_267: std_logic_vector(7 downto 0) := "01000000";
  constant v_net_268: std_logic_vector(7 downto 0) := "00100000";
  constant v_net_269: std_logic_vector(6 downto 0) := "0101100";
  constant v_net_270: std_logic_vector(4 downto 0) := "10000";
  constant v_net_271: std_logic_vector(3 downto 0) := "1100";
  constant v_net_272: std_logic_vector(5 downto 0) := "011000";
  constant v_net_273: std_logic_vector(5 downto 0) := "001010";
  constant v_net_274: std_logic_vector(6 downto 0) := "1100000";
  constant v_net_275: std_logic_vector(6 downto 0) := "1010000";
  constant v_net_276: std_logic_vector(4 downto 0) := "11100";
  constant v_net_277: std_logic_vector(4 downto 0) := "10110";
  constant v_net_278: std_logic_vector(4 downto 0) := "10010";
  constant v_net_279: std_logic_vector(5 downto 0) := "001100";
  constant v_net_280: std_logic_vector(4 downto 0) := "11110";
  constant v_net_281: std_logic_vector(3 downto 0) := "0110";
  constant v_net_282: std_logic_vector(3 downto 0) := "1101";
  constant v_net_283: std_logic_vector(4 downto 0) := "10101";
  constant v_net_284: std_logic_vector(4 downto 0) := "10001";
  constant v_net_285: std_logic_vector(2 downto 0) := "001";
  constant v_net_286: std_logic_vector(1 downto 0) := "11";
  constant v_net_287: std_logic_vector(1 downto 0) := "01";
  constant v_net_288: std_logic_vector(2 downto 0) := "100";
  constant v_net_289: std_logic_vector(2 downto 0) := "011";
  constant v_net_290: std_logic_vector(2 downto 0) := "010";
  constant v_net_291: std_logic_vector(2 downto 0) := "000";
  constant v_net_292: std_logic_vector(3 downto 0) := "1111";
  constant v_net_293: std_logic_vector(3 downto 0) := "1110";
  constant v_net_294: std_logic_vector(3 downto 0) := "1101";
  constant v_net_295: std_logic_vector(3 downto 0) := "1100";
  constant v_net_296: std_logic_vector(3 downto 0) := "1011";
  constant v_net_297: std_logic_vector(3 downto 0) := "1010";
  constant v_net_298: std_logic_vector(3 downto 0) := "1001";
  constant v_net_299: std_logic_vector(3 downto 0) := "1000";
  constant v_net_300: std_logic_vector(3 downto 0) := "0111";
  constant v_net_301: std_logic_vector(3 downto 0) := "0110";
  constant v_net_302: std_logic_vector(3 downto 0) := "0101";
  constant v_net_303: std_logic_vector(3 downto 0) := "0100";
  constant v_net_304: std_logic_vector(3 downto 0) := "0011";
  constant v_net_305: std_logic_vector(3 downto 0) := "0010";
  constant v_net_306: std_logic_vector(3 downto 0) := "0001";
  constant v_net_307: std_logic_vector(3 downto 0) := "0000";
  constant v_net_308: std_logic_vector(1 downto 0) := "11";
  constant v_net_309: std_logic_vector(1 downto 0) := "10";
  constant v_net_310: std_logic_vector(1 downto 0) := "01";
  constant v_net_311: std_logic_vector(1 downto 0) := "00";
  constant v_net_312: std_logic_vector(1 downto 0) := "11";
  constant v_net_313: std_logic_vector(1 downto 0) := "11";
  constant v_net_314: std_logic_vector(1 downto 0) := "10";
  constant v_net_315: std_logic_vector(1 downto 0) := "01";
  constant v_net_316: std_logic_vector(1 downto 0) := "00";
  constant v_net_317: std_logic_vector(2 downto 0) := "000";
  constant v_net_318: std_logic_vector(2 downto 0) := "001";
  constant v_net_319: std_logic_vector(2 downto 0) := "010";
  constant v_net_320: std_logic_vector(2 downto 0) := "011";
  constant v_net_321: std_logic_vector(2 downto 0) := "100";
  constant v_net_322: std_logic_vector(2 downto 0) := "101";
  constant v_net_323: std_logic_vector(2 downto 0) := "110";
  constant v_net_324: std_logic_vector(2 downto 0) := "111";
  constant v_net_325: std_logic_vector(7 downto 0) := "11111111";

begin
incr: inc16 
     port map (m_clock => m_clock, p_reset => p_reset, n_thr => v_incr_thr, n_dox => v_incr_dox, n_out => v_incr_out, n_co => v_incr_co, n_in => v_incr_in, n_ci => v_incr_ci);
alu: alu65 
     port map (m_clock => m_clock, p_reset => p_reset, n_thr => v_alu_thr, n_rol => v_alu_rol, n_ror => v_alu_ror, n_lsr => v_alu_lsr, n_asl => v_alu_asl, n_incc => v_alu_incc, n_dec2 => v_alu_dec2, n_dec => v_alu_dec, n_inc => v_alu_inc, n_eor => v_alu_eor, n_do_or => v_alu_do_or, n_bita => v_alu_bita, n_do_and => v_alu_do_and, n_sbc => v_alu_sbc, n_adc => v_alu_adc, n_c => v_alu_c, n_z => v_alu_z, n_v => v_alu_v, n_s => v_alu_s, n_out => v_alu_out, n_df => v_alu_df, n_ci => v_alu_ci, n_in2 => v_alu_in2, n_in1 => v_alu_in1);
  n_s1 <= '1' when ((((((n_dbc and v_net_173) and n_taken) and n_rdy) and v_net_182) and v_net_184))='1'
  else '1' when ((((n_ea and n_mzpxi) and v_net_138) and n_rdy))='1'
  else '1' when ((((n_ea and n_mabs) and v_net_135) and n_rdy))='1'
  else '1' when ((((n_ea and n_mzpiy) and v_net_133) and n_rdy))='1'
  else '1' when (((n_djmp and v_net_100) and n_rdy))='1'
  else '1' when (((n_djsr and v_net_94) and n_rdy))='1'
  else '1' when ((n_dphp and v_net_89))='1'
  else '1' when ((n_dplp and v_net_85))='1'
  else '1' when ((n_drti and v_net_81))='1'
  else '1' when ((n_drts and v_net_77))='1'
  else '0' ;
  n_s2 <= '1' when ((((((n_dbc and v_net_173) and n_taken) and n_rdy) and v_net_182) and v_net_183))='1'
  else '1' when ((((n_ea and n_mzpxi) and v_net_137) and n_rdy))='1'
  else '1' when ((((n_ea and n_mzpiy) and v_net_132) and n_rdy))='1'
  else '1' when (((((n_ea and n_maby) and v_net_120) and n_rdy) and v_alu_c))='1'
  else '1' when ((((n_djmp and v_net_97) and n_rdy) and v_net_98))='1'
  else '1' when ((n_djsr and v_net_93))='1'
  else '1' when (((n_drti and v_net_80) and n_rdy))='1'
  else '1' when (((n_drts and v_net_76) and n_rdy))='1'
  else '0' ;
  n_s3 <= '1' when (((((n_ea and n_mzpiy) and v_net_130) and n_rdy) and v_alu_c))='1'
  else '1' when (((n_djmp and v_net_96) and n_rdy))='1'
  else '1' when ((n_djsr and v_net_92))='1'
  else '1' when (((n_drti and v_net_79) and n_rdy))='1'
  else '1' when ((((n_drts and v_net_74) and n_rdy) and v_alu_c))='1'
  else '0' ;
  n_s4 <= '1' when ((((n_ea and n_mzpxi) and v_net_136) and n_rdy))='1'
  else '1' when ((((n_ea and n_mabs) and v_net_134) and n_rdy))='1'
  else '1' when (((((n_ea and n_mzpiy) and v_net_130) and n_rdy) and v_net_131))='1'
  else '1' when (((n_ea and n_mzpiy) and v_net_129))='1'
  else '1' when ((((n_ea and n_mzpx) and v_net_125) and n_rdy))='1'
  else '1' when (((((n_ea and n_maby) and v_net_120) and n_rdy) and v_net_123))='1'
  else '1' when (((n_ea and n_maby) and v_net_119))='1'
  else '1' when ((n_djsr and v_net_91))='1'
  else '0' ;
  n_s5 <= '1' when (((n_rmw and v_net_160) and n_rdy))='1'
  else '0' ;
  n_ifrun <= '1' when (((((n_dbc and v_net_173) and n_taken) and n_rdy) and v_net_185))='1'
  else '1' when ((n_dbc and v_net_172))='1'
  else '1' when ((n_dbc and v_net_171))='1'
  else '1' when ((n_rmw and n_mimp))='1'
  else '1' when (n_pf)='1'
  else '1' when (n_dmisc)='1'
  else '1' when (n_dclc)='1'
  else '1' when ((((n_djmp and v_net_97) and n_rdy) and v_net_99))='1'
  else '1' when (((n_djmp and v_net_95) and n_rdy))='1'
  else '1' when (((n_djsr and v_net_90) and n_rdy))='1'
  else '1' when ((n_dphp and v_net_86))='1'
  else '1' when (((n_dplp and v_net_82) and n_rdy))='1'
  else '1' when (((n_drti and v_net_78) and n_rdy))='1'
  else '1' when ((((n_drts and v_net_74) and n_rdy) and v_net_75))='1'
  else '1' when ((n_drts and v_net_73))='1'
  else '0' ;
  n_pf <= '1' when (((n_dbc and v_net_173) and v_net_186))='1'
  else '1' when ((n_rmw and v_net_159))='1'
  else '1' when (((n_dldx and v_net_156) and n_rdy))='1'
  else '1' when (((n_dcpx and v_net_153) and n_rdy))='1'
  else '1' when (((n_dcmp and v_net_151) and n_rdy))='1'
  else '1' when (((n_dlda and v_net_150) and n_rdy))='1'
  else '1' when ((n_dstx and v_net_147))='1'
  else '1' when ((n_dsta and v_net_146))='1'
  else '1' when (((n_dbit and v_net_145) and n_rdy))='1'
  else '1' when (((n_dora and v_net_139) and n_rdy))='1'
  else '0' ;
  n_write <= '1' when (v_net_195)='1'
  else '1' when (v_net_194)='1'
  else '1' when (v_net_193)='1'
  else '1' when ((n_rmw and v_net_159))='1'
  else '1' when ((n_dstx and v_net_147))='1'
  else '1' when ((n_dsta and v_net_146))='1'
  else '1' when ((n_djsr and v_net_92))='1'
  else '1' when ((n_djsr and v_net_91))='1'
  else '1' when ((n_dphp and v_net_86))='1'
  else '0' ;
  n_read <= '1' when (v_net_198)='1'
  else '1' when (v_net_197)='1'
  else '1' when ((n_ift_run and v_net_187))='1'
  else '1' when ((n_dbc and v_net_173))='1'
  else '1' when ((n_rmw and v_net_160))='1'
  else '1' when ((n_dldx and v_net_156))='1'
  else '1' when ((n_dcpx and v_net_153))='1'
  else '1' when ((n_dcmp and v_net_151))='1'
  else '1' when ((n_dlda and v_net_150))='1'
  else '1' when ((n_dbit and v_net_145))='1'
  else '1' when ((n_dora and v_net_139))='1'
  else '1' when (((n_ea and n_mzpxi) and v_net_138))='1'
  else '1' when (((n_ea and n_mzpxi) and v_net_137))='1'
  else '1' when (((n_ea and n_mzpxi) and v_net_136))='1'
  else '1' when (((n_ea and n_mabs) and v_net_135))='1'
  else '1' when (((n_ea and n_mabs) and v_net_134))='1'
  else '1' when (((n_ea and n_mzpiy) and v_net_133))='1'
  else '1' when (((n_ea and n_mzpiy) and v_net_132))='1'
  else '1' when (((n_ea and n_mzpiy) and v_net_130))='1'
  else '1' when (((n_ea and n_mzpx) and v_net_125))='1'
  else '1' when (((n_ea and n_maby) and v_net_120))='1'
  else '1' when ((n_djmp and v_net_100))='1'
  else '1' when ((n_djmp and v_net_97))='1'
  else '1' when ((n_djmp and v_net_96))='1'
  else '1' when ((n_djmp and v_net_95))='1'
  else '1' when ((n_djsr and v_net_94))='1'
  else '1' when ((n_djsr and v_net_90))='1'
  else '1' when ((n_dplp and v_net_82))='1'
  else '1' when ((n_drti and v_net_80))='1'
  else '1' when ((n_drti and v_net_79))='1'
  else '1' when ((n_drti and v_net_78))='1'
  else '1' when ((n_drts and v_net_76))='1'
  else '1' when ((n_drts and v_net_74))='1'
  else '0' ;
  n_decop <= n_ex;
  n_ea <= '1' when (((n_ddec and ( not v_net_167)) and ( not v_net_170)))='1'
  else '1' when (((n_dasl and ( not v_net_161)) and ( not v_net_162)))='1'
  else '1' when ((n_dldx and ( not v_net_156)))='1'
  else '1' when ((n_dcpx and ( not v_net_153)))='1'
  else '1' when ((n_dcmp and ( not v_net_151)))='1'
  else '1' when ((n_dlda and ( not v_net_150)))='1'
  else '1' when ((n_dstx and ( not v_net_147)))='1'
  else '1' when ((n_dsta and ( not v_net_146)))='1'
  else '1' when ((n_dbit and ( not v_net_145)))='1'
  else '1' when ((n_dora and ( not v_net_139)))='1'
  else '0' ;
  n_dasl <= '1' when ((n_decop and v_net_62))='1'
  else '1' when ((n_decop and v_net_54))='1'
  else '0' ;
  n_dbit <= '1' when ((n_decop and v_net_60))='1'
  else '0' ;
  n_dclc <= '1' when ((n_decop and v_net_53))='1'
  else '0' ;
  n_dcmp <= '1' when ((n_decop and v_net_63))='1'
  else '0' ;
  n_dcpx <= '1' when ((n_decop and v_net_57))='1'
  else '1' when ((n_decop and v_net_55))='1'
  else '0' ;
  n_ddec <= '1' when ((n_decop and v_net_61))='1'
  else '0' ;
  n_dmisc <= '1' when ((n_decop and v_net_52))='1'
  else '0' ;
  n_djmp <= '1' when ((n_decop and v_net_50))='1'
  else '0' ;
  n_djsr <= '1' when ((n_decop and v_net_49))='1'
  else '0' ;
  n_dlda <= '1' when ((n_decop and v_net_64))='1'
  else '0' ;
  n_dldx <= '1' when ((n_decop and v_net_58))='1'
  else '1' when ((n_decop and v_net_56))='1'
  else '0' ;
  n_dnop <= '1' when ((n_dmisc and v_net_112))='1'
  else '1' when ((n_dmisc and v_net_108))='1'
  else '1' when ((n_dmisc and v_net_105))='1'
  else '1' when ((n_dmisc and v_net_104))='1'
  else '0' ;
  n_dora <= '1' when ((n_decop and v_net_66))='1'
  else '0' ;
  n_dphp <= '1' when ((n_decop and v_net_46))='1'
  else '0' ;
  n_dplp <= '1' when ((n_decop and v_net_45))='1'
  else '0' ;
  n_drti <= '1' when ((n_decop and v_net_48))='1'
  else '0' ;
  n_drts <= '1' when ((n_decop and v_net_47))='1'
  else '0' ;
  n_dsta <= '1' when ((n_decop and v_net_65))='1'
  else '0' ;
  n_dstx <= '1' when ((n_decop and v_net_59))='1'
  else '0' ;
  n_dbc <= '1' when ((n_decop and v_net_51))='1'
  else '0' ;
  n_mimp <= '1' when ((n_decop and v_net_54))='1'
  else '0' ;
  n_mimm <= '1' when ((n_decop and v_net_71))='1'
  else '1' when ((n_decop and v_net_56))='1'
  else '1' when ((n_decop and v_net_55))='1'
  else '0' ;
  n_mzpx <= '1' when ((n_decop and v_net_68))='1'
  else '0' ;
  n_mzpxi <= '1' when ((n_decop and v_net_72))='1'
  else '0' ;
  n_mzpiy <= '1' when ((n_decop and v_net_69))='1'
  else '0' ;
  n_mabs <= '1' when (((n_ea and n_maby) and v_net_124))='1'
  else '1' when ((n_decop and v_net_70))='1'
  else '0' ;
  n_maby <= '1' when ((n_decop and v_net_67))='1'
  else '0' ;
  n_rmw <= '1' when ((n_ddec and v_net_170))='1'
  else '1' when ((n_ddec and v_net_167))='1'
  else '1' when ((n_dasl and v_net_162))='1'
  else '1' when ((n_dasl and v_net_161))='1'
  else '0' ;
  n_nif0 <= '1' when (n_dmisc)='1'
  else '1' when (n_dclc)='1'
  else '1' when ((n_djsr and v_net_91))='1'
  else '1' when ((n_dphp and v_net_86))='1'
  else '1' when (((n_dplp and v_net_82) and n_rdy))='1'
  else '0' ;
  n_nif1 <= '1' when ((v_net_197 and n_rdy))='1'
  else '1' when (((n_ift_run and v_net_187) and n_rdy))='1'
  else '1' when ((((n_ea and n_mabs) and v_net_135) and n_rdy))='1'
  else '1' when (n_pf)='1'
  else '1' when (((n_djmp and v_net_100) and n_rdy))='1'
  else '0' ;
  n_nif2 <= '1' when ((v_net_191 and n_do_brk))='1'
  else '0' ;
  n_psr <= (n_fn & n_fv & '1' & '1' & n_fd & n_fi & n_fz & n_fc);
  n_psri <= n_dbi when (((n_dplp and v_net_82) and v_net_84))='1'
  else n_dbi when ((n_drti and v_net_80))='1'
  else "00000000" ;
  n_taken <= ((((((((v_net_174 and ( not n_fn)) or (v_net_175 and n_fn)) or (v_net_176 and ( not n_fv))) or (v_net_177 and n_fv)) or (v_net_178 and ( not n_fc))) or (v_net_179 and n_fc)) or (v_net_180 and ( not n_fz))) or (v_net_181 and n_fz)) when ((n_dbc and v_net_173))='1'
  else '0' ;
  n_ALU1 <= n_RA when ((n_rmw and n_mimp))='1'
  else n_DL when ((n_rmw and v_net_159))='1'
  else "00000000" ;
  n_ABLin <= v_net_202 when (((((v_net_196 and ( not n_do_res)) and ( not n_do_brk)) and ( not n_do_nmi)) and n_do_irq))='1'
  else v_net_201 when ((((v_net_196 and ( not n_do_res)) and ( not n_do_brk)) and n_do_nmi))='1'
  else v_net_200 when (((v_net_196 and ( not n_do_res)) and n_do_brk))='1'
  else v_net_199 when ((v_net_196 and n_do_res))='1'
  else "00000000" ;
  n_dbo <= (n_psr and (v_net_204 & ( not (n_do_irq or n_do_nmi)) & v_net_203)) when (v_net_195)='1'
  else n_PCL when (v_net_194)='1'
  else n_PCH when (v_net_193)='1'
  else v_alu_out when ((n_rmw and v_net_159))='1'
  else v_alu_out when (((n_dstx and v_net_147) and v_net_149))='1'
  else v_alu_out when (((n_dstx and v_net_147) and v_net_148))='1'
  else v_alu_out when ((n_dsta and v_net_146))='1'
  else n_PCH when ((n_djsr and v_net_92))='1'
  else n_PCL when ((n_djsr and v_net_91))='1'
  else n_psr when (((n_dphp and v_net_86) and v_net_88))='1'
  else n_RA when (((n_dphp and v_net_86) and v_net_87))='1'
  else "00000000" ;
  n_dbi <= n_data when (n_read)='1'
  else "00000000" ;
  n_opc <= n_OP;
  n_setpsr <= '1' when (((n_dplp and v_net_82) and v_net_84))='1'
  else '1' when ((n_drti and v_net_80))='1'
  else '0' ;
  v_alu_in1 <= n_dbi when ((n_ift_run and v_net_187))='1'
  else n_PCL when ((((n_dbc and v_net_173) and n_taken) and n_rdy))='1'
  else n_PCH when ((n_dbc and v_net_172))='1'
  else n_PCH when ((n_dbc and v_net_171))='1'
  else n_ALU1 when (((n_ddec and v_net_167) and v_net_169))='1'
  else n_ALU1 when (((n_ddec and v_net_167) and v_net_168))='1'
  else n_ALU1 when (((n_dasl and v_net_162) and v_net_166))='1'
  else n_ALU1 when (((n_dasl and v_net_162) and v_net_165))='1'
  else n_ALU1 when (((n_dasl and v_net_162) and v_net_164))='1'
  else n_ALU1 when (((n_dasl and v_net_162) and v_net_163))='1'
  else n_dbi when ((((n_dldx and v_net_156) and n_rdy) and v_net_158))='1'
  else n_dbi when ((((n_dldx and v_net_156) and n_rdy) and v_net_157))='1'
  else n_RX when ((((n_dcpx and v_net_153) and n_rdy) and v_net_155))='1'
  else n_RY when ((((n_dcpx and v_net_153) and n_rdy) and v_net_154))='1'
  else n_RA when (((n_dcmp and v_net_151) and n_rdy))='1'
  else n_dbi when (((n_dlda and v_net_150) and n_rdy))='1'
  else n_RX when (((n_dstx and v_net_147) and v_net_149))='1'
  else n_RY when (((n_dstx and v_net_147) and v_net_148))='1'
  else n_RA when ((n_dsta and v_net_146))='1'
  else n_RA when (((n_dbit and v_net_145) and n_rdy))='1'
  else n_RA when (((n_dora and v_net_139) and v_net_143))='1'
  else n_RA when (((n_dora and v_net_139) and v_net_142))='1'
  else n_RA when (((n_dora and v_net_139) and v_net_141))='1'
  else n_RA when (((n_dora and v_net_139) and v_net_140))='1'
  else n_RX when ((((n_ea and n_mzpxi) and v_net_138) and n_rdy))='1'
  else n_RX when ((((n_ea and n_mzpxi) and v_net_137) and n_rdy))='1'
  else n_DL when ((((n_ea and n_mzpiy) and v_net_132) and n_rdy))='1'
  else n_RY when ((((n_ea and n_mzpiy) and v_net_130) and n_rdy))='1'
  else n_DL when (((n_ea and n_mzpiy) and v_net_129))='1'
  else n_RX when (((((n_ea and n_mzpx) and v_net_125) and n_rdy) and v_net_128))='1'
  else n_RY when (((((n_ea and n_mzpx) and v_net_125) and n_rdy) and v_net_127))='1'
  else n_dbi when (((((n_ea and n_mzpx) and v_net_125) and n_rdy) and v_net_126))='1'
  else n_RY when (((((n_ea and n_maby) and v_net_120) and n_rdy) and v_net_122))='1'
  else n_RX when (((((n_ea and n_maby) and v_net_120) and n_rdy) and v_net_121))='1'
  else n_DL when (((n_ea and n_maby) and v_net_119))='1'
  else n_RY when ((n_dmisc and v_net_118))='1'
  else n_RX when ((n_dmisc and v_net_117))='1'
  else n_RY when ((n_dmisc and v_net_116))='1'
  else n_RX when ((n_dmisc and v_net_115))='1'
  else n_RA when ((n_dmisc and v_net_114))='1'
  else n_RA when ((n_dmisc and v_net_113))='1'
  else n_RS when ((n_dmisc and v_net_111))='1'
  else n_RY when ((n_dmisc and v_net_110))='1'
  else n_RX when ((n_dmisc and v_net_109))='1'
  else n_RX when ((n_dmisc and v_net_106))='1'
  else n_rABL when (((n_djmp and v_net_96) and n_rdy))='1'
  else n_RS when ((n_dplp and v_net_85))='1'
  else n_dbi when (((n_dplp and v_net_82) and v_net_83))='1'
  else n_RS when ((n_drti and v_net_81))='1'
  else n_RS when (((n_drti and v_net_80) and n_rdy))='1'
  else n_RS when (((n_drti and v_net_79) and n_rdy))='1'
  else n_RS when ((n_drts and v_net_77))='1'
  else n_RS when (((n_drts and v_net_76) and n_rdy))='1'
  else n_DL when (((n_drts and v_net_74) and n_rdy))='1'
  else n_DL when ((n_drts and v_net_73))='1'
  else "00000000" ;
  v_alu_in2 <= n_RS when (v_net_195)='1'
  else n_RS when (v_net_194)='1'
  else n_RS when (v_net_193)='1'
  else n_dbi when ((((n_dbc and v_net_173) and n_taken) and n_rdy))='1'
  else n_dbi when ((((n_dcpx and v_net_153) and n_rdy) and v_net_155))='1'
  else n_dbi when ((((n_dcpx and v_net_153) and n_rdy) and v_net_154))='1'
  else n_dbi when (((n_dcmp and v_net_151) and n_rdy))='1'
  else n_dbi when (((n_dbit and v_net_145) and n_rdy))='1'
  else n_dbi when (((n_dora and v_net_139) and v_net_143))='1'
  else n_dbi when (((n_dora and v_net_139) and v_net_142))='1'
  else n_dbi when (((n_dora and v_net_139) and v_net_141))='1'
  else n_dbi when (((n_dora and v_net_139) and v_net_140))='1'
  else n_dbi when ((((n_ea and n_mzpxi) and v_net_138) and n_rdy))='1'
  else n_DL when ((((n_ea and n_mzpxi) and v_net_137) and n_rdy))='1'
  else n_DL when ((((n_ea and n_mzpiy) and v_net_130) and n_rdy))='1'
  else n_dbi when (((((n_ea and n_mzpx) and v_net_125) and n_rdy) and v_net_128))='1'
  else n_dbi when (((((n_ea and n_mzpx) and v_net_125) and n_rdy) and v_net_127))='1'
  else n_DL when (((((n_ea and n_maby) and v_net_120) and n_rdy) and v_net_122))='1'
  else n_DL when (((((n_ea and n_maby) and v_net_120) and n_rdy) and v_net_121))='1'
  else n_RS when (((n_djsr and v_net_94) and n_rdy))='1'
  else n_RS when ((n_djsr and v_net_92))='1'
  else n_RS when ((n_dphp and v_net_89))='1'
  else "00000000" ;
  v_alu_ci <= '1' when ((((n_dbc and v_net_173) and n_taken) and n_rdy))='1'
  else n_fc when (((n_dasl and v_net_162) and v_net_165))='1'
  else n_fc when (((n_dasl and v_net_162) and v_net_163))='1'
  else '1' when ((((n_dcpx and v_net_153) and n_rdy) and v_net_155))='1'
  else '1' when ((((n_dcpx and v_net_153) and n_rdy) and v_net_154))='1'
  else (( not (n_opc(5))) or n_fc) when (((n_dcmp and v_net_151) and n_rdy))='1'
  else ((n_fc or n_dcmp) or n_dcpx) when (((n_dora and v_net_139) and v_net_140))='1'
  else '0' when ((((n_ea and n_mzpxi) and v_net_138) and n_rdy))='1'
  else '1' when ((((n_ea and n_mzpxi) and v_net_137) and n_rdy))='1'
  else '0' when ((((n_ea and n_mzpiy) and v_net_130) and n_rdy))='1'
  else '0' when (((((n_ea and n_mzpx) and v_net_125) and n_rdy) and v_net_128))='1'
  else '0' when (((((n_ea and n_mzpx) and v_net_125) and n_rdy) and v_net_127))='1'
  else '0' when (((((n_ea and n_maby) and v_net_120) and n_rdy) and v_net_122))='1'
  else '0' when (((((n_ea and n_maby) and v_net_120) and n_rdy) and v_net_121))='1'
  else n_tc when (((n_ea and n_maby) and v_net_119))='1'
  else '0' ;
  v_alu_df <= '1' when (((((n_dcmp and v_net_151) and n_rdy) and v_net_152) and n_fd))='1'
  else '1' when (((n_dora and v_net_139) and n_fd))='1'
  else '0' ;
  v_alu_adc <= '1' when ((((n_dbc and v_net_173) and n_taken) and n_rdy))='1'
  else '1' when (((n_dora and v_net_139) and v_net_140))='1'
  else '1' when ((((n_ea and n_mzpxi) and v_net_138) and n_rdy))='1'
  else '1' when ((((n_ea and n_mzpxi) and v_net_137) and n_rdy))='1'
  else '1' when ((((n_ea and n_mzpiy) and v_net_130) and n_rdy))='1'
  else '1' when (((((n_ea and n_mzpx) and v_net_125) and n_rdy) and v_net_128))='1'
  else '1' when (((((n_ea and n_mzpx) and v_net_125) and n_rdy) and v_net_127))='1'
  else '1' when (((((n_ea and n_maby) and v_net_120) and n_rdy) and v_net_122))='1'
  else '1' when (((((n_ea and n_maby) and v_net_120) and n_rdy) and v_net_121))='1'
  else '0' ;
  v_alu_sbc <= '1' when ((((n_dcpx and v_net_153) and n_rdy) and v_net_155))='1'
  else '1' when ((((n_dcpx and v_net_153) and n_rdy) and v_net_154))='1'
  else '1' when (((n_dcmp and v_net_151) and n_rdy))='1'
  else '0' ;
  v_alu_do_and <= '1' when (((n_dora and v_net_139) and v_net_142))='1'
  else '0' ;
  v_alu_bita <= '1' when (((n_dbit and v_net_145) and n_rdy))='1'
  else '0' ;
  v_alu_do_or <= '1' when (((n_dora and v_net_139) and v_net_143))='1'
  else '0' ;
  v_alu_eor <= '1' when (((n_dora and v_net_139) and v_net_141))='1'
  else '0' ;
  v_alu_inc <= '1' when ((n_dbc and v_net_172))='1'
  else '1' when (((n_ddec and v_net_167) and v_net_168))='1'
  else '1' when ((((n_ea and n_mzpiy) and v_net_132) and n_rdy))='1'
  else '1' when (((n_ea and n_mzpiy) and v_net_129))='1'
  else '1' when ((n_dmisc and v_net_110))='1'
  else '1' when ((n_dmisc and v_net_106))='1'
  else '1' when (((n_djmp and v_net_96) and n_rdy))='1'
  else '1' when ((n_dplp and v_net_85))='1'
  else '1' when ((n_drti and v_net_81))='1'
  else '1' when (((n_drti and v_net_80) and n_rdy))='1'
  else '1' when (((n_drti and v_net_79) and n_rdy))='1'
  else '1' when ((n_drts and v_net_77))='1'
  else '1' when (((n_drts and v_net_76) and n_rdy))='1'
  else '1' when (((n_drts and v_net_74) and n_rdy))='1'
  else '1' when ((n_drts and v_net_73))='1'
  else '0' ;
  v_alu_dec <= '1' when ((n_dbc and v_net_171))='1'
  else '1' when (((n_ddec and v_net_167) and v_net_169))='1'
  else '1' when ((n_dmisc and v_net_118))='1'
  else '1' when ((n_dmisc and v_net_109))='1'
  else '0' ;
  v_alu_dec2 <= '1' when (v_net_195)='1'
  else '1' when (v_net_194)='1'
  else '1' when (v_net_193)='1'
  else '1' when (((n_djsr and v_net_94) and n_rdy))='1'
  else '1' when ((n_djsr and v_net_92))='1'
  else '1' when ((n_dphp and v_net_89))='1'
  else '0' ;
  v_alu_incc <= '1' when (((n_ea and n_maby) and v_net_119))='1'
  else '0' ;
  v_alu_asl <= '1' when (((n_dasl and v_net_162) and v_net_166))='1'
  else '0' ;
  v_alu_lsr <= '1' when (((n_dasl and v_net_162) and v_net_164))='1'
  else '0' ;
  v_alu_ror <= '1' when (((n_dasl and v_net_162) and v_net_163))='1'
  else '0' ;
  v_alu_rol <= '1' when (((n_dasl and v_net_162) and v_net_165))='1'
  else '0' ;
  v_alu_thr <= '1' when ((n_ift_run and v_net_187))='1'
  else '1' when ((((n_dldx and v_net_156) and n_rdy) and v_net_158))='1'
  else '1' when ((((n_dldx and v_net_156) and n_rdy) and v_net_157))='1'
  else '1' when (((n_dlda and v_net_150) and n_rdy))='1'
  else '1' when (((n_dstx and v_net_147) and v_net_149))='1'
  else '1' when (((n_dstx and v_net_147) and v_net_148))='1'
  else '1' when ((n_dsta and v_net_146))='1'
  else '1' when (((((n_ea and n_mzpx) and v_net_125) and n_rdy) and v_net_126))='1'
  else '1' when ((n_dmisc and v_net_117))='1'
  else '1' when ((n_dmisc and v_net_116))='1'
  else '1' when ((n_dmisc and v_net_115))='1'
  else '1' when ((n_dmisc and v_net_114))='1'
  else '1' when ((n_dmisc and v_net_113))='1'
  else '1' when ((n_dmisc and v_net_111))='1'
  else '1' when (((n_dplp and v_net_82) and v_net_83))='1'
  else '0' ;
  v_alu_p_reset <= p_reset;
  v_alu_m_clock <= m_clock;
  v_incr_in <= (n_PCH & n_PCL) when (n_nif2)='1'
  else (n_PCH & n_PCL) when (n_nif1)='1'
  else (n_PCH & n_PCL) when (n_nif0)='1'
  else (n_PCH & n_PCL) when ((n_djsr and v_net_93))='1'
  else "0000000000000000" ;
  v_incr_ci <= '1' when ((n_djsr and v_net_93))='1'
  else '0' ;
  v_incr_dox <= '1' when (n_nif2)='1'
  else '1' when (n_nif1)='1'
  else '1' when ((n_djsr and v_net_93))='1'
  else '0' ;
  v_incr_thr <= n_nif0;
  v_incr_p_reset <= p_reset;
  v_incr_m_clock <= m_clock;
  v_proc_ift_run_set <= '1' when ((n_ex and n_ifrun))='1'
  else '1' when ((v_net_198 and n_rdy))='1'
  else '0' ;
  v_proc_ift_run_reset <= '1' when ((((n_ift_run and v_net_187) and n_rdy) and v_net_189))='1'
  else '1' when ((((n_ift_run and v_net_187) and n_rdy) and v_alu_z))='1'
  else '1' when ((((n_ift_run and v_net_187) and n_rdy) and v_alu_z))='1'
  else '0' ;
  v_proc_do_nmi_set <= '1' when ((n_nmi and v_net_44))='1'
  else '0' ;
  v_proc_do_nmi_reset <= '1' when (((((v_net_198 and n_rdy) and ( not n_do_res)) and ( not n_do_brk)) and n_do_nmi))='1'
  else '0' ;
  v_proc_do_irq_set <= '1' when ((n_irq and v_net_43))='1'
  else '0' ;
  v_proc_do_irq_reset <= '1' when ((((((v_net_198 and n_rdy) and ( not n_do_res)) and ( not n_do_brk)) and ( not n_do_nmi)) and n_do_irq))='1'
  else '0' ;
  v_proc_do_brk_set <= '1' when ((((n_ift_run and v_net_187) and n_rdy) and v_alu_z))='1'
  else '0' ;
  v_proc_do_brk_reset <= '1' when ((((v_net_198 and n_rdy) and ( not n_do_res)) and n_do_brk))='1'
  else '0' ;
  v_proc_do_res_set <= n_start;
  v_proc_do_res_reset <= '1' when (((v_net_198 and n_rdy) and n_do_res))='1'
  else '0' ;
  v_proc_int_req_set <= '1' when ((((n_ift_run and v_net_187) and n_rdy) and v_alu_z))='1'
  else '1' when (n_start)='1'
  else '1' when ((n_nmi and v_net_44))='1'
  else '1' when ((n_irq and v_net_43))='1'
  else '0' ;
  v_proc_int_req_reset <= '1' when ((v_net_198 and n_rdy))='1'
  else '0' ;
  v_proc_ex_set <= '1' when ((n_ex and n_s1))='1'
  else '1' when ((n_ex and n_s2))='1'
  else '1' when ((n_ex and n_s3))='1'
  else '1' when ((n_ex and n_s4))='1'
  else '1' when ((n_ex and n_s5))='1'
  else '1' when ((((n_ift_run and v_net_187) and n_rdy) and v_net_189))='1'
  else '0' ;
  v_proc_ex_reset <= '1' when (((((((n_ex and ( not n_ifrun)) and ( not n_s5)) and ( not n_s4)) and ( not n_s3)) and ( not n_s2)) and ( not n_s1)))='1'
  else '1' when ((n_ex and n_s1))='1'
  else '1' when ((n_ex and n_s2))='1'
  else '1' when ((n_ex and n_s3))='1'
  else '1' when ((n_ex and n_s4))='1'
  else '1' when ((n_ex and n_s5))='1'
  else '1' when ((n_ex and n_ifrun))='1'
  else '0' ;
  v_net_43 <= (( not n_int_req) and ( not n_fi)) when (n_irq)='1'
  else '0' ;
  v_net_44 <= (( not n_int_req) and ( not n_nm1)) when (n_nmi)='1'
  else '0' ;
  v_net_45 <= n_decop when ((((n_opc(7)) & (n_opc(5 downto 0))) = v_net_264))='1'
  else '0' ;
  v_net_46 <= n_decop when ((((n_opc(7)) & (n_opc(5 downto 0))) = v_net_265))='1'
  else '0' ;
  v_net_47 <= n_decop when ((n_opc = v_net_266))='1'
  else '0' ;
  v_net_48 <= n_decop when ((n_opc = v_net_267))='1'
  else '0' ;
  v_net_49 <= n_decop when ((n_opc = v_net_268))='1'
  else '0' ;
  v_net_50 <= n_decop when ((((n_opc(7 downto 6)) & (n_opc(4 downto 0))) = v_net_269))='1'
  else '0' ;
  v_net_51 <= n_decop when (((n_opc(4 downto 0)) = v_net_270))='1'
  else '0' ;
  v_net_52 <= n_decop when ((((n_opc(7)) & (n_opc(3 downto 2)) & (n_opc(0))) = v_net_271))='1'
  else '0' ;
  v_net_53 <= n_decop when ((((n_opc(7)) & (n_opc(4 downto 0))) = v_net_272))='1'
  else '0' ;
  v_net_54 <= n_decop when ((((n_opc(7)) & (n_opc(4 downto 0))) = v_net_273))='1'
  else '0' ;
  v_net_55 <= n_decop when ((((n_opc(7 downto 6)) & (n_opc(4 downto 0))) = v_net_274))='1'
  else '0' ;
  v_net_56 <= n_decop when ((((n_opc(7 downto 2)) & (n_opc(0))) = v_net_275))='1'
  else '0' ;
  v_net_57 <= n_decop when ((((n_opc(7 downto 6)) & (n_opc(2 downto 0))) = v_net_276))='1'
  else '0' ;
  v_net_58 <= n_decop when ((((n_opc(7 downto 5)) & (n_opc(2)) & (n_opc(0))) = v_net_277))='1'
  else '0' ;
  v_net_59 <= n_decop when ((((n_opc(7 downto 5)) & (n_opc(2)) & (n_opc(0))) = v_net_278))='1'
  else '0' ;
  v_net_60 <= n_decop when ((((n_opc(7 downto 5)) & (n_opc(2 downto 0))) = v_net_279))='1'
  else '0' ;
  v_net_61 <= n_decop when ((((n_opc(7 downto 6)) & (n_opc(2 downto 0))) = v_net_280))='1'
  else '0' ;
  v_net_62 <= n_decop when ((((n_opc(7)) & (n_opc(2 downto 0))) = v_net_281))='1'
  else '0' ;
  v_net_63 <= n_decop when ((((n_opc(7 downto 6)) & (n_opc(1 downto 0))) = v_net_282))='1'
  else '0' ;
  v_net_64 <= n_decop when ((((n_opc(7 downto 5)) & (n_opc(1 downto 0))) = v_net_283))='1'
  else '0' ;
  v_net_65 <= n_decop when ((((n_opc(7 downto 5)) & (n_opc(1 downto 0))) = v_net_284))='1'
  else '0' ;
  v_net_66 <= n_decop when ((((n_opc(7)) & (n_opc(1 downto 0))) = v_net_285))='1'
  else '0' ;
  v_net_67 <= n_decop when (((n_opc(4 downto 3)) = v_net_286))='1'
  else '0' ;
  v_net_68 <= n_decop when (((n_opc(3 downto 2)) = v_net_287))='1'
  else '0' ;
  v_net_69 <= n_decop when (((n_opc(4 downto 2)) = v_net_288))='1'
  else '0' ;
  v_net_70 <= n_decop when (((n_opc(4 downto 2)) = v_net_289))='1'
  else '0' ;
  v_net_71 <= n_decop when (((n_opc(4 downto 2)) = v_net_290))='1'
  else '0' ;
  v_net_72 <= n_decop when (((n_opc(4 downto 2)) = v_net_291))='1'
  else '0' ;
  v_net_73 <= (n_ex_st(3)) when (n_drts)='1'
  else '0' ;
  v_net_74 <= (n_ex_st(2)) when (n_drts)='1'
  else '0' ;
  v_net_75 <= ( not v_alu_c) when (((n_drts and v_net_74) and n_rdy))='1'
  else '0' ;
  v_net_76 <= (n_ex_st(1)) when (n_drts)='1'
  else '0' ;
  v_net_77 <= (n_ex_st(0)) when (n_drts)='1'
  else '0' ;
  v_net_78 <= (n_ex_st(3)) when (n_drti)='1'
  else '0' ;
  v_net_79 <= (n_ex_st(2)) when (n_drti)='1'
  else '0' ;
  v_net_80 <= (n_ex_st(1)) when (n_drti)='1'
  else '0' ;
  v_net_81 <= (n_ex_st(0)) when (n_drti)='1'
  else '0' ;
  v_net_82 <= (n_ex_st(1)) when (n_dplp)='1'
  else '0' ;
  v_net_83 <= (n_opc(6)) when ((n_dplp and v_net_82))='1'
  else '0' ;
  v_net_84 <= ( not (n_opc(6))) when ((n_dplp and v_net_82))='1'
  else '0' ;
  v_net_85 <= (n_ex_st(0)) when (n_dplp)='1'
  else '0' ;
  v_net_86 <= (n_ex_st(1)) when (n_dphp)='1'
  else '0' ;
  v_net_87 <= (n_opc(6)) when ((n_dphp and v_net_86))='1'
  else '0' ;
  v_net_88 <= ( not (n_opc(6))) when ((n_dphp and v_net_86))='1'
  else '0' ;
  v_net_89 <= (n_ex_st(0)) when (n_dphp)='1'
  else '0' ;
  v_net_90 <= (n_ex_st(4)) when (n_djsr)='1'
  else '0' ;
  v_net_91 <= (n_ex_st(3)) when (n_djsr)='1'
  else '0' ;
  v_net_92 <= (n_ex_st(2)) when (n_djsr)='1'
  else '0' ;
  v_net_93 <= (n_ex_st(1)) when (n_djsr)='1'
  else '0' ;
  v_net_94 <= (n_ex_st(0)) when (n_djsr)='1'
  else '0' ;
  v_net_95 <= (n_ex_st(3)) when (n_djmp)='1'
  else '0' ;
  v_net_96 <= (n_ex_st(2)) when (n_djmp)='1'
  else '0' ;
  v_net_97 <= (n_ex_st(1)) when (n_djmp)='1'
  else '0' ;
  v_net_98 <= (n_opc(5)) when (((n_djmp and v_net_97) and n_rdy))='1'
  else '0' ;
  v_net_99 <= ( not (n_opc(5))) when (((n_djmp and v_net_97) and n_rdy))='1'
  else '0' ;
  v_net_100 <= (n_ex_st(0)) when (n_djmp)='1'
  else '0' ;
  v_net_101 <= n_dclc when (((n_opc(6)) = '1'))='1'
  else '0' ;
  v_net_102 <= n_dclc when (((n_opc(6)) = '0'))='1'
  else '0' ;
  v_net_103 <= n_dmisc when ((((n_opc(6 downto 4)) & (n_opc(1))) = v_net_292))='1'
  else '0' ;
  v_net_104 <= n_dmisc when ((((n_opc(6 downto 4)) & (n_opc(1))) = v_net_293))='1'
  else '0' ;
  v_net_105 <= n_dmisc when ((((n_opc(6 downto 4)) & (n_opc(1))) = v_net_294))='1'
  else '0' ;
  v_net_106 <= n_dmisc when ((((n_opc(6 downto 4)) & (n_opc(1))) = v_net_295))='1'
  else '0' ;
  v_net_107 <= n_dmisc when ((((n_opc(6 downto 4)) & (n_opc(1))) = v_net_296))='1'
  else '0' ;
  v_net_108 <= n_dmisc when ((((n_opc(6 downto 4)) & (n_opc(1))) = v_net_297))='1'
  else '0' ;
  v_net_109 <= n_dmisc when ((((n_opc(6 downto 4)) & (n_opc(1))) = v_net_298))='1'
  else '0' ;
  v_net_110 <= n_dmisc when ((((n_opc(6 downto 4)) & (n_opc(1))) = v_net_299))='1'
  else '0' ;
  v_net_111 <= n_dmisc when ((((n_opc(6 downto 4)) & (n_opc(1))) = v_net_300))='1'
  else '0' ;
  v_net_112 <= n_dmisc when ((((n_opc(6 downto 4)) & (n_opc(1))) = v_net_301))='1'
  else '0' ;
  v_net_113 <= n_dmisc when ((((n_opc(6 downto 4)) & (n_opc(1))) = v_net_302))='1'
  else '0' ;
  v_net_114 <= n_dmisc when ((((n_opc(6 downto 4)) & (n_opc(1))) = v_net_303))='1'
  else '0' ;
  v_net_115 <= n_dmisc when ((((n_opc(6 downto 4)) & (n_opc(1))) = v_net_304))='1'
  else '0' ;
  v_net_116 <= n_dmisc when ((((n_opc(6 downto 4)) & (n_opc(1))) = v_net_305))='1'
  else '0' ;
  v_net_117 <= n_dmisc when ((((n_opc(6 downto 4)) & (n_opc(1))) = v_net_306))='1'
  else '0' ;
  v_net_118 <= n_dmisc when ((((n_opc(6 downto 4)) & (n_opc(1))) = v_net_307))='1'
  else '0' ;
  v_net_119 <= (n_ex_st(2)) when ((n_ea and n_maby))='1'
  else '0' ;
  v_net_120 <= (n_ex_st(1)) when ((n_ea and n_maby))='1'
  else '0' ;
  v_net_121 <= ((n_opc(2)) and (( not n_dldx) or ( not (n_opc(1))))) when ((((n_ea and n_maby) and v_net_120) and n_rdy))='1'
  else '0' ;
  v_net_122 <= (( not (n_opc(2))) or (n_dldx and (n_opc(1)))) when ((((n_ea and n_maby) and v_net_120) and n_rdy))='1'
  else '0' ;
  v_net_123 <= ( not v_alu_c) when ((((n_ea and n_maby) and v_net_120) and n_rdy))='1'
  else '0' ;
  v_net_124 <= (n_ex_st(0)) when ((n_ea and n_maby))='1'
  else '0' ;
  v_net_125 <= (n_ex_st(0)) when ((n_ea and n_mzpx))='1'
  else '0' ;
  v_net_126 <= ( not (n_opc(4))) when ((((n_ea and n_mzpx) and v_net_125) and n_rdy))='1'
  else '0' ;
  v_net_127 <= (((n_opc(4)) and (n_dldx or n_dstx)) and (n_opc(1))) when ((((n_ea and n_mzpx) and v_net_125) and n_rdy))='1'
  else '0' ;
  v_net_128 <= ((n_opc(4)) and ((( not n_dldx) and ( not n_dstx)) or ( not (n_opc(1))))) when ((((n_ea and n_mzpx) and v_net_125) and n_rdy))='1'
  else '0' ;
  v_net_129 <= (n_ex_st(3)) when ((n_ea and n_mzpiy))='1'
  else '0' ;
  v_net_130 <= (n_ex_st(2)) when ((n_ea and n_mzpiy))='1'
  else '0' ;
  v_net_131 <= ( not v_alu_c) when ((((n_ea and n_mzpiy) and v_net_130) and n_rdy))='1'
  else '0' ;
  v_net_132 <= (n_ex_st(1)) when ((n_ea and n_mzpiy))='1'
  else '0' ;
  v_net_133 <= (n_ex_st(0)) when ((n_ea and n_mzpiy))='1'
  else '0' ;
  v_net_134 <= (n_ex_st(1)) when ((n_ea and n_mabs))='1'
  else '0' ;
  v_net_135 <= (n_ex_st(0)) when ((n_ea and n_mabs))='1'
  else '0' ;
  v_net_136 <= (n_ex_st(2)) when ((n_ea and n_mzpxi))='1'
  else '0' ;
  v_net_137 <= (n_ex_st(1)) when ((n_ea and n_mzpxi))='1'
  else '0' ;
  v_net_138 <= (n_ex_st(0)) when ((n_ea and n_mzpxi))='1'
  else '0' ;
  v_net_139 <= (n_mimm or (n_ex_st(4))) when (n_dora)='1'
  else '0' ;
  v_net_140 <= (n_dora and v_net_139) when (((n_opc(6 downto 5)) = v_net_308))='1'
  else '0' ;
  v_net_141 <= (n_dora and v_net_139) when (((n_opc(6 downto 5)) = v_net_309))='1'
  else '0' ;
  v_net_142 <= (n_dora and v_net_139) when (((n_opc(6 downto 5)) = v_net_310))='1'
  else '0' ;
  v_net_143 <= (n_dora and v_net_139) when (((n_opc(6 downto 5)) = v_net_311))='1'
  else '0' ;
  v_net_144 <= ((n_dora and v_net_139) and n_rdy) when (((n_opc(6 downto 5)) = v_net_312))='1'
  else '0' ;
  v_net_145 <= (n_mimm or (n_ex_st(4))) when (n_dbit)='1'
  else '0' ;
  v_net_146 <= ((n_ex_st(4)) or (n_ex_st(5))) when (n_dsta)='1'
  else '0' ;
  v_net_147 <= ((n_ex_st(4)) or (n_ex_st(5))) when (n_dstx)='1'
  else '0' ;
  v_net_148 <= ( not (n_opc(1))) when ((n_dstx and v_net_147))='1'
  else '0' ;
  v_net_149 <= (n_opc(1)) when ((n_dstx and v_net_147))='1'
  else '0' ;
  v_net_150 <= (n_mimm or (n_ex_st(4))) when (n_dlda)='1'
  else '0' ;
  v_net_151 <= (n_mimm or (n_ex_st(4))) when (n_dcmp)='1'
  else '0' ;
  v_net_152 <= (n_opc(5)) when (((n_dcmp and v_net_151) and n_rdy))='1'
  else '0' ;
  v_net_153 <= (n_mimm or (n_ex_st(4))) when (n_dcpx)='1'
  else '0' ;
  v_net_154 <= ( not (n_opc(5))) when (((n_dcpx and v_net_153) and n_rdy))='1'
  else '0' ;
  v_net_155 <= (n_opc(5)) when (((n_dcpx and v_net_153) and n_rdy))='1'
  else '0' ;
  v_net_156 <= (n_mimm or (n_ex_st(4))) when (n_dldx)='1'
  else '0' ;
  v_net_157 <= ( not (n_opc(1))) when (((n_dldx and v_net_156) and n_rdy))='1'
  else '0' ;
  v_net_158 <= (n_opc(1)) when (((n_dldx and v_net_156) and n_rdy))='1'
  else '0' ;
  v_net_159 <= (n_ex_st(5)) when (n_rmw)='1'
  else '0' ;
  v_net_160 <= (n_ex_st(4)) when (n_rmw)='1'
  else '0' ;
  v_net_161 <= (n_ex_st(4)) when (n_dasl)='1'
  else '0' ;
  v_net_162 <= (n_mimp or (n_ex_st(5))) when (n_dasl)='1'
  else '0' ;
  v_net_163 <= (n_dasl and v_net_162) when (((n_opc(6 downto 5)) = v_net_313))='1'
  else '0' ;
  v_net_164 <= (n_dasl and v_net_162) when (((n_opc(6 downto 5)) = v_net_314))='1'
  else '0' ;
  v_net_165 <= (n_dasl and v_net_162) when (((n_opc(6 downto 5)) = v_net_315))='1'
  else '0' ;
  v_net_166 <= (n_dasl and v_net_162) when (((n_opc(6 downto 5)) = v_net_316))='1'
  else '0' ;
  v_net_167 <= (n_ex_st(5)) when (n_ddec)='1'
  else '0' ;
  v_net_168 <= (n_opc(5)) when ((n_ddec and v_net_167))='1'
  else '0' ;
  v_net_169 <= ( not (n_opc(5))) when ((n_ddec and v_net_167))='1'
  else '0' ;
  v_net_170 <= (n_ex_st(4)) when (n_ddec)='1'
  else '0' ;
  v_net_171 <= (n_ex_st(2)) when (n_dbc)='1'
  else '0' ;
  v_net_172 <= (n_ex_st(1)) when (n_dbc)='1'
  else '0' ;
  v_net_173 <= (n_ex_st(0)) when (n_dbc)='1'
  else '0' ;
  v_net_174 <= (n_dbc and v_net_173) when (((n_opc(7 downto 5)) = v_net_317))='1'
  else '0' ;
  v_net_175 <= (n_dbc and v_net_173) when (((n_opc(7 downto 5)) = v_net_318))='1'
  else '0' ;
  v_net_176 <= (n_dbc and v_net_173) when (((n_opc(7 downto 5)) = v_net_319))='1'
  else '0' ;
  v_net_177 <= (n_dbc and v_net_173) when (((n_opc(7 downto 5)) = v_net_320))='1'
  else '0' ;
  v_net_178 <= (n_dbc and v_net_173) when (((n_opc(7 downto 5)) = v_net_321))='1'
  else '0' ;
  v_net_179 <= (n_dbc and v_net_173) when (((n_opc(7 downto 5)) = v_net_322))='1'
  else '0' ;
  v_net_180 <= (n_dbc and v_net_173) when (((n_opc(7 downto 5)) = v_net_323))='1'
  else '0' ;
  v_net_181 <= (n_dbc and v_net_173) when (((n_opc(7 downto 5)) = v_net_324))='1'
  else '0' ;
  v_net_182 <= (v_alu_c xor (n_data(7))) when ((((n_dbc and v_net_173) and n_taken) and n_rdy))='1'
  else '0' ;
  v_net_183 <= (n_data(7)) when (((((n_dbc and v_net_173) and n_taken) and n_rdy) and v_net_182))='1'
  else '0' ;
  v_net_184 <= ( not (n_data(7))) when (((((n_dbc and v_net_173) and n_taken) and n_rdy) and v_net_182))='1'
  else '0' ;
  v_net_185 <= (( not v_alu_c) xor (n_data(7))) when ((((n_dbc and v_net_173) and n_taken) and n_rdy))='1'
  else '0' ;
  v_net_186 <= ( not n_taken) when ((n_dbc and v_net_173))='1'
  else '0' ;
  v_net_187 <= ( not n_int_req) when (n_ift_run)='1'
  else '0' ;
  v_net_188 <= ( not n_nmi) when ((n_ift_run and v_net_187))='1'
  else '0' ;
  v_net_189 <= ( not v_alu_z) when (((n_ift_run and v_net_187) and n_rdy))='1'
  else '0' ;
  v_net_191 <= '1' when (((v_reg_190 = v_state_v_reg_190_st0) and n_int_req))='1'
  else '0' ;
  v_net_192 <= ((n_ift_run and (n_do_irq or n_do_nmi)) or n_do_brk) when (v_net_191)='1'
  else '0' ;
  v_net_193 <= '1' when (((v_reg_190 = v_state_v_reg_190_st1) and n_int_req))='1'
  else '0' ;
  v_net_194 <= '1' when (((v_reg_190 = v_state_v_reg_190_st2) and n_int_req))='1'
  else '0' ;
  v_net_195 <= '1' when (((v_reg_190 = v_state_v_reg_190_st3) and n_int_req))='1'
  else '0' ;
  v_net_196 <= '1' when (((v_reg_190 = v_state_v_reg_190_st4) and n_int_req))='1'
  else '0' ;
  v_net_197 <= '1' when (((v_reg_190 = v_state_v_reg_190_st5) and n_int_req))='1'
  else '0' ;
  v_net_198 <= '1' when (((v_reg_190 = v_state_v_reg_190_st6) and n_int_req))='1'
  else '0' ;
  n_datao <= internal_n_datao;
  internal_n_datao <= n_dbo when (n_write)='1'
  else "00000000" ;
  n_adrs <= internal_n_adrs;
  internal_n_adrs <= ((n_rABH and v_net_325) & n_rABL);
  n_debug <= internal_n_debug;
  internal_n_debug <= (n_PCH & n_PCL);
  n_rd <= internal_n_rd;
  internal_n_rd <= n_read;
  n_wt <= internal_n_wt;
  internal_n_wt <= n_write;
  n_sync <= internal_n_sync;
  internal_n_sync <= '1' when ((n_ift_run and v_net_187))='1'
  else '0' ;
p_0: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_fn <= '0';
  elsif ((n_ddec and v_net_167))='1' then
    n_fn <= v_alu_s;
  elsif ((n_dasl and v_net_162))='1' then
    n_fn <= v_alu_s;
  elsif ((n_dldx and v_net_156))='1' then
    n_fn <= v_alu_s;
  elsif (((n_dcpx and v_net_153) and n_rdy))='1' then
    n_fn <= v_alu_s;
  elsif (((n_dcmp and v_net_151) and n_rdy))='1' then
    n_fn <= v_alu_s;
  elsif (((n_dlda and v_net_150) and n_rdy))='1' then
    n_fn <= v_alu_s;
  elsif (((n_dbit and v_net_145) and n_rdy))='1' then
    n_fn <= v_alu_s;
  elsif (((n_dora and v_net_139) and n_rdy))='1' then
    n_fn <= v_alu_s;
  elsif ((n_dmisc and v_net_118))='1' then
    n_fn <= v_alu_s;
  elsif ((n_dmisc and v_net_117))='1' then
    n_fn <= v_alu_s;
  elsif ((n_dmisc and v_net_116))='1' then
    n_fn <= v_alu_s;
  elsif ((n_dmisc and v_net_114))='1' then
    n_fn <= v_alu_s;
  elsif ((n_dmisc and v_net_113))='1' then
    n_fn <= v_alu_s;
  elsif ((n_dmisc and v_net_111))='1' then
    n_fn <= v_alu_s;
  elsif ((n_dmisc and v_net_110))='1' then
    n_fn <= v_alu_s;
  elsif ((n_dmisc and v_net_109))='1' then
    n_fn <= v_alu_s;
  elsif ((n_dmisc and v_net_106))='1' then
    n_fn <= v_alu_s;
  elsif (((n_dplp and v_net_82) and v_net_83))='1' then
    n_fn <= v_alu_s;
  elsif (n_setpsr)='1' then
    n_fn <= (n_psri(7));
  end if;
 end if;
 end process;
p_1: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_fv <= '0';
  elsif ((((n_dcmp and v_net_151) and n_rdy) and v_net_152))='1' then
    n_fv <= v_alu_v;
  elsif (((n_dbit and v_net_145) and n_rdy))='1' then
    n_fv <= v_alu_v;
  elsif ((((n_dora and v_net_139) and n_rdy) and v_net_144))='1' then
    n_fv <= v_alu_v;
  elsif ((n_dmisc and v_net_112))='1' then
    n_fv <= '0';
  elsif (n_setpsr)='1' then
    n_fv <= (n_psri(6));
  end if;
 end if;
 end process;
p_2: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_fd <= '0';
  elsif ((n_dmisc and v_net_108))='1' then
    n_fd <= '0';
  elsif ((n_dmisc and v_net_104))='1' then
    n_fd <= '1';
  elsif (n_setpsr)='1' then
    n_fd <= (n_psri(3));
  end if;
 end if;
 end process;
p_3: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_fz <= '0';
  elsif ((n_ddec and v_net_167))='1' then
    n_fz <= v_alu_z;
  elsif ((n_dasl and v_net_162))='1' then
    n_fz <= v_alu_z;
  elsif ((n_dldx and v_net_156))='1' then
    n_fz <= v_alu_z;
  elsif (((n_dcpx and v_net_153) and n_rdy))='1' then
    n_fz <= v_alu_z;
  elsif (((n_dcmp and v_net_151) and n_rdy))='1' then
    n_fz <= v_alu_z;
  elsif (((n_dlda and v_net_150) and n_rdy))='1' then
    n_fz <= v_alu_z;
  elsif (((n_dbit and v_net_145) and n_rdy))='1' then
    n_fz <= v_alu_z;
  elsif (((n_dora and v_net_139) and n_rdy))='1' then
    n_fz <= v_alu_z;
  elsif ((n_dmisc and v_net_118))='1' then
    n_fz <= v_alu_z;
  elsif ((n_dmisc and v_net_117))='1' then
    n_fz <= v_alu_z;
  elsif ((n_dmisc and v_net_116))='1' then
    n_fz <= v_alu_z;
  elsif ((n_dmisc and v_net_114))='1' then
    n_fz <= v_alu_z;
  elsif ((n_dmisc and v_net_113))='1' then
    n_fz <= v_alu_z;
  elsif ((n_dmisc and v_net_111))='1' then
    n_fz <= v_alu_z;
  elsif ((n_dmisc and v_net_110))='1' then
    n_fz <= v_alu_z;
  elsif ((n_dmisc and v_net_109))='1' then
    n_fz <= v_alu_z;
  elsif ((n_dmisc and v_net_106))='1' then
    n_fz <= v_alu_z;
  elsif (((n_dplp and v_net_82) and v_net_83))='1' then
    n_fz <= v_alu_z;
  elsif (n_setpsr)='1' then
    n_fz <= (n_psri(1));
  end if;
 end if;
 end process;
p_4: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_fc <= '0';
  elsif ((n_dasl and v_net_162))='1' then
    n_fc <= v_alu_c;
  elsif (((n_dcpx and v_net_153) and n_rdy))='1' then
    n_fc <= v_alu_c;
  elsif (((n_dcmp and v_net_151) and n_rdy))='1' then
    n_fc <= v_alu_c;
  elsif ((((n_dora and v_net_139) and n_rdy) and v_net_144))='1' then
    n_fc <= v_alu_c;
  elsif ((n_dclc and v_net_102))='1' then
    n_fc <= (n_opc(5));
  elsif (n_setpsr)='1' then
    n_fc <= (n_psri(0));
  end if;
 end if;
 end process;
p_5: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_fi <= '1';
  elsif ((v_net_198 and n_rdy))='1' then
    n_fi <= '1';
  elsif ((n_dclc and v_net_101))='1' then
    n_fi <= (n_opc(5));
  elsif (n_setpsr)='1' then
    n_fi <= (n_psri(2));
  end if;
 end if;
 end process;
p_6: process(m_clock)
begin
if m_clock'event and m_clock='1' then
    n_swt <= '0';
 end if;
 end process;
p_7: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_nm1 <= '0';
  elsif (((v_net_191 and v_net_192) and n_do_nmi))='1' then
    n_nm1 <= '1';
  elsif (((n_ift_run and v_net_187) and v_net_188))='1' then
    n_nm1 <= '0';
  end if;
 end if;
 end process;
p_8: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if (((n_ea and n_maby) and v_net_120))='1' then
    n_tc <= v_alu_c;
  end if;
 end if;
 end process;
p_9: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if ((((n_dldx and v_net_156) and n_rdy) and v_net_157))='1' then
    n_RY <= v_alu_out;
  elsif ((n_dmisc and v_net_118))='1' then
    n_RY <= v_alu_out;
  elsif ((n_dmisc and v_net_114))='1' then
    n_RY <= v_alu_out;
  elsif ((n_dmisc and v_net_110))='1' then
    n_RY <= v_alu_out;
  end if;
 end if;
 end process;
p_10: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if ((((n_dldx and v_net_156) and n_rdy) and v_net_158))='1' then
    n_RX <= v_alu_out;
  elsif ((n_dmisc and v_net_113))='1' then
    n_RX <= v_alu_out;
  elsif ((n_dmisc and v_net_111))='1' then
    n_RX <= v_alu_out;
  elsif ((n_dmisc and v_net_109))='1' then
    n_RX <= v_alu_out;
  elsif ((n_dmisc and v_net_106))='1' then
    n_RX <= v_alu_out;
  end if;
 end if;
 end process;
p_11: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_RS <= "11111111";
  elsif (v_net_195)='1' then
    n_RS <= v_alu_out;
  elsif (v_net_194)='1' then
    n_RS <= v_alu_out;
  elsif (v_net_193)='1' then
    n_RS <= v_alu_out;
  elsif ((n_dmisc and v_net_115))='1' then
    n_RS <= v_alu_out;
  elsif (((n_djsr and v_net_94) and n_rdy))='1' then
    n_RS <= v_alu_out;
  elsif ((n_djsr and v_net_92))='1' then
    n_RS <= v_alu_out;
  elsif ((n_dphp and v_net_89))='1' then
    n_RS <= v_alu_out;
  elsif ((n_dplp and v_net_85))='1' then
    n_RS <= v_alu_out;
  elsif ((n_drti and v_net_81))='1' then
    n_RS <= v_alu_out;
  elsif (((n_drti and v_net_80) and n_rdy))='1' then
    n_RS <= v_alu_out;
  elsif (((n_drti and v_net_79) and n_rdy))='1' then
    n_RS <= v_alu_out;
  elsif ((n_drts and v_net_77))='1' then
    n_RS <= v_alu_out;
  elsif (((n_drts and v_net_76) and n_rdy))='1' then
    n_RS <= v_alu_out;
  end if;
 end if;
 end process;
p_12: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if ((n_rmw and n_mimp))='1' then
    n_RA <= v_alu_out;
  elsif ((((n_dcmp and v_net_151) and n_rdy) and v_net_152))='1' then
    n_RA <= v_alu_out;
  elsif (((n_dlda and v_net_150) and n_rdy))='1' then
    n_RA <= v_alu_out;
  elsif (((n_dora and v_net_139) and n_rdy))='1' then
    n_RA <= v_alu_out;
  elsif ((n_dmisc and v_net_117))='1' then
    n_RA <= v_alu_out;
  elsif ((n_dmisc and v_net_116))='1' then
    n_RA <= v_alu_out;
  elsif (((n_dplp and v_net_82) and v_net_83))='1' then
    n_RA <= v_alu_out;
  end if;
 end if;
 end process;
p_13: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if ((v_net_198 and n_rdy))='1' then
    n_PCL <= n_DL;
  elsif (v_net_196)='1' then
    n_PCL <= n_ABLin;
  elsif ((((n_dbc and v_net_173) and n_taken) and n_rdy))='1' then
    n_PCL <= v_alu_out;
  elsif (n_nif2)='1' then
    n_PCL <= (v_incr_out(7 downto 0));
  elsif (n_nif1)='1' then
    n_PCL <= (v_incr_out(7 downto 0));
  elsif (((n_djmp and v_net_97) and n_rdy))='1' then
    n_PCL <= n_DL;
  elsif (((n_djmp and v_net_95) and n_rdy))='1' then
    n_PCL <= n_DL;
  elsif ((n_djsr and v_net_93))='1' then
    n_PCL <= (v_incr_out(7 downto 0));
  elsif (((n_djsr and v_net_90) and n_rdy))='1' then
    n_PCL <= n_DL;
  elsif (((n_drti and v_net_78) and n_rdy))='1' then
    n_PCL <= n_DL;
  elsif (((n_drts and v_net_74) and n_rdy))='1' then
    n_PCL <= v_alu_out;
  end if;
 end if;
 end process;
p_14: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if ((v_net_197 and n_rdy))='1' then
    n_DL <= n_dbi;
  elsif (((n_rmw and v_net_160) and n_rdy))='1' then
    n_DL <= n_dbi;
  elsif ((((n_ea and n_mzpxi) and v_net_138) and n_rdy))='1' then
    n_DL <= n_dbi;
  elsif ((((n_ea and n_mzpxi) and v_net_137) and n_rdy))='1' then
    n_DL <= n_dbi;
  elsif ((((n_ea and n_mabs) and v_net_135) and n_rdy))='1' then
    n_DL <= n_dbi;
  elsif ((((n_ea and n_mzpiy) and v_net_133) and n_rdy))='1' then
    n_DL <= n_dbi;
  elsif ((((n_ea and n_mzpiy) and v_net_132) and n_rdy))='1' then
    n_DL <= n_dbi;
  elsif ((((n_ea and n_mzpiy) and v_net_130) and n_rdy))='1' then
    n_DL <= n_dbi;
  elsif ((((n_ea and n_maby) and v_net_120) and n_rdy))='1' then
    n_DL <= n_dbi;
  elsif ((n_djmp and v_net_100))='1' then
    n_DL <= n_dbi;
  elsif (((n_djmp and v_net_96) and n_rdy))='1' then
    n_DL <= n_dbi;
  elsif ((n_djsr and v_net_94))='1' then
    n_DL <= n_dbi;
  elsif (((n_drti and v_net_79) and n_rdy))='1' then
    n_DL <= n_dbi;
  elsif ((n_drts and v_net_76))='1' then
    n_DL <= n_dbi;
  elsif (((n_drts and v_net_74) and n_rdy))='1' then
    n_DL <= n_dbi;
  end if;
 end if;
 end process;
p_15: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if ((n_ift_run and v_net_187))='1' then
    n_OP <= n_dbi;
  end if;
 end if;
 end process;
p_16: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if ((v_net_198 and n_rdy))='1' then
    n_rABH <= (n_dbi and v_net_244);
  elsif (v_net_196)='1' then
    n_rABH <= v_net_243;
  elsif ((v_net_191 and v_net_192))='1' then
    n_rABH <= (v_net_241 and v_net_242);
  elsif ((n_dbc and v_net_172))='1' then
    n_rABH <= (v_alu_out and v_net_240);
  elsif ((n_dbc and v_net_171))='1' then
    n_rABH <= (v_alu_out and v_net_239);
  elsif ((((n_ea and n_mzpxi) and v_net_138) and n_rdy))='1' then
    n_rABH <= (v_net_237 and v_net_238);
  elsif ((((n_ea and n_mzpxi) and v_net_136) and n_rdy))='1' then
    n_rABH <= (n_dbi and v_net_236);
  elsif ((((n_ea and n_mabs) and v_net_134) and n_rdy))='1' then
    n_rABH <= (n_dbi and v_net_235);
  elsif ((((n_ea and n_mzpiy) and v_net_133) and n_rdy))='1' then
    n_rABH <= (v_net_233 and v_net_234);
  elsif ((((n_ea and n_mzpiy) and v_net_132) and n_rdy))='1' then
    n_rABH <= (v_net_231 and v_net_232);
  elsif ((((n_ea and n_mzpiy) and v_net_130) and n_rdy))='1' then
    n_rABH <= (n_dbi and v_net_230);
  elsif (((n_ea and n_mzpiy) and v_net_129))='1' then
    n_rABH <= (v_alu_out and v_net_229);
  elsif ((((n_ea and n_mzpx) and v_net_125) and n_rdy))='1' then
    n_rABH <= (v_net_227 and v_net_228);
  elsif ((((n_ea and n_maby) and v_net_120) and n_rdy))='1' then
    n_rABH <= (n_dbi and v_net_226);
  elsif (((n_ea and n_maby) and v_net_119))='1' then
    n_rABH <= (v_alu_out and v_net_225);
  elsif (n_nif1)='1' then
    n_rABH <= ((v_incr_out(15 downto 8)) and v_net_224);
  elsif (n_nif0)='1' then
    n_rABH <= ((v_incr_out(15 downto 8)) and v_net_223);
  elsif (((n_djmp and v_net_97) and n_rdy))='1' then
    n_rABH <= (n_dbi and v_net_222);
  elsif (((n_djmp and v_net_95) and n_rdy))='1' then
    n_rABH <= (n_dbi and v_net_221);
  elsif (((n_djsr and v_net_94) and n_rdy))='1' then
    n_rABH <= (v_net_219 and v_net_220);
  elsif ((n_djsr and v_net_92))='1' then
    n_rABH <= (v_net_217 and v_net_218);
  elsif (((n_djsr and v_net_90) and n_rdy))='1' then
    n_rABH <= (n_dbi and v_net_216);
  elsif ((n_dphp and v_net_89))='1' then
    n_rABH <= (v_net_214 and v_net_215);
  elsif ((n_dplp and v_net_85))='1' then
    n_rABH <= (v_net_212 and v_net_213);
  elsif ((n_drti and v_net_81))='1' then
    n_rABH <= (v_net_210 and v_net_211);
  elsif (((n_drti and v_net_78) and n_rdy))='1' then
    n_rABH <= (n_dbi and v_net_209);
  elsif ((n_drts and v_net_77))='1' then
    n_rABH <= (v_net_207 and v_net_208);
  elsif (((n_drts and v_net_74) and n_rdy))='1' then
    n_rABH <= (n_dbi and v_net_206);
  elsif ((n_drts and v_net_73))='1' then
    n_rABH <= (v_alu_out and v_net_205);
  end if;
 end if;
 end process;
p_17: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if ((v_net_198 and n_rdy))='1' then
    n_rABL <= n_DL;
  elsif (v_net_196)='1' then
    n_rABL <= n_ABLin;
  elsif (v_net_195)='1' then
    n_rABL <= v_alu_out;
  elsif (v_net_194)='1' then
    n_rABL <= v_alu_out;
  elsif (v_net_193)='1' then
    n_rABL <= v_alu_out;
  elsif ((v_net_191 and v_net_192))='1' then
    n_rABL <= n_RS;
  elsif ((((n_dbc and v_net_173) and n_taken) and n_rdy))='1' then
    n_rABL <= v_alu_out;
  elsif ((((n_ea and n_mzpxi) and v_net_138) and n_rdy))='1' then
    n_rABL <= v_alu_out;
  elsif ((((n_ea and n_mzpxi) and v_net_137) and n_rdy))='1' then
    n_rABL <= v_alu_out;
  elsif ((((n_ea and n_mzpxi) and v_net_136) and n_rdy))='1' then
    n_rABL <= n_DL;
  elsif ((((n_ea and n_mabs) and v_net_134) and n_rdy))='1' then
    n_rABL <= n_DL;
  elsif ((((n_ea and n_mzpiy) and v_net_133) and n_rdy))='1' then
    n_rABL <= n_dbi;
  elsif ((((n_ea and n_mzpiy) and v_net_132) and n_rdy))='1' then
    n_rABL <= v_alu_out;
  elsif ((((n_ea and n_mzpiy) and v_net_130) and n_rdy))='1' then
    n_rABL <= v_alu_out;
  elsif (((((n_ea and n_mzpx) and v_net_125) and n_rdy) and v_net_128))='1' then
    n_rABL <= v_alu_out;
  elsif (((((n_ea and n_mzpx) and v_net_125) and n_rdy) and v_net_127))='1' then
    n_rABL <= v_alu_out;
  elsif (((((n_ea and n_mzpx) and v_net_125) and n_rdy) and v_net_126))='1' then
    n_rABL <= v_alu_out;
  elsif (((((n_ea and n_maby) and v_net_120) and n_rdy) and v_net_122))='1' then
    n_rABL <= v_alu_out;
  elsif (((((n_ea and n_maby) and v_net_120) and n_rdy) and v_net_121))='1' then
    n_rABL <= v_alu_out;
  elsif (n_nif1)='1' then
    n_rABL <= (v_incr_out(7 downto 0));
  elsif (n_nif0)='1' then
    n_rABL <= (v_incr_out(7 downto 0));
  elsif (((n_djmp and v_net_97) and n_rdy))='1' then
    n_rABL <= n_DL;
  elsif (((n_djmp and v_net_96) and n_rdy))='1' then
    n_rABL <= v_alu_out;
  elsif (((n_djmp and v_net_95) and n_rdy))='1' then
    n_rABL <= n_DL;
  elsif (((n_djsr and v_net_94) and n_rdy))='1' then
    n_rABL <= n_RS;
  elsif ((n_djsr and v_net_92))='1' then
    n_rABL <= n_RS;
  elsif (((n_djsr and v_net_90) and n_rdy))='1' then
    n_rABL <= n_DL;
  elsif ((n_dphp and v_net_89))='1' then
    n_rABL <= n_RS;
  elsif ((n_dplp and v_net_85))='1' then
    n_rABL <= v_alu_out;
  elsif ((n_drti and v_net_81))='1' then
    n_rABL <= v_alu_out;
  elsif (((n_drti and v_net_80) and n_rdy))='1' then
    n_rABL <= v_alu_out;
  elsif (((n_drti and v_net_79) and n_rdy))='1' then
    n_rABL <= v_alu_out;
  elsif (((n_drti and v_net_78) and n_rdy))='1' then
    n_rABL <= n_DL;
  elsif ((n_drts and v_net_77))='1' then
    n_rABL <= v_alu_out;
  elsif (((n_drts and v_net_76) and n_rdy))='1' then
    n_rABL <= v_alu_out;
  elsif (((n_drts and v_net_74) and n_rdy))='1' then
    n_rABL <= v_alu_out;
  end if;
 end if;
 end process;
p_18: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if ((v_net_198 and n_rdy))='1' then
    n_PCH <= (n_dbi and v_net_257);
  elsif (v_net_196)='1' then
    n_PCH <= v_net_256;
  elsif ((n_dbc and v_net_172))='1' then
    n_PCH <= (v_alu_out and v_net_255);
  elsif ((n_dbc and v_net_171))='1' then
    n_PCH <= (v_alu_out and v_net_254);
  elsif (n_nif2)='1' then
    n_PCH <= ((v_incr_out(15 downto 8)) and v_net_253);
  elsif (n_nif1)='1' then
    n_PCH <= ((v_incr_out(15 downto 8)) and v_net_252);
  elsif (((n_djmp and v_net_97) and n_rdy))='1' then
    n_PCH <= (n_dbi and v_net_251);
  elsif (((n_djmp and v_net_95) and n_rdy))='1' then
    n_PCH <= (n_dbi and v_net_250);
  elsif ((n_djsr and v_net_93))='1' then
    n_PCH <= ((v_incr_out(15 downto 8)) and v_net_249);
  elsif (((n_djsr and v_net_90) and n_rdy))='1' then
    n_PCH <= (n_dbi and v_net_248);
  elsif (((n_drti and v_net_78) and n_rdy))='1' then
    n_PCH <= (n_dbi and v_net_247);
  elsif (((n_drts and v_net_74) and n_rdy))='1' then
    n_PCH <= (n_dbi and v_net_246);
  elsif ((n_drts and v_net_73))='1' then
    n_PCH <= (v_alu_out and v_net_245);
  end if;
 end if;
 end process;
p_19: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_ift_run <= '0';
  elsif ((v_proc_ift_run_set or v_proc_ift_run_reset))='1' then
    n_ift_run <= v_proc_ift_run_set;
  end if;
 end if;
 end process;
p_20: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_do_nmi <= '0';
  elsif ((v_proc_do_nmi_set or v_proc_do_nmi_reset))='1' then
    n_do_nmi <= v_proc_do_nmi_set;
  end if;
 end if;
 end process;
p_21: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_do_irq <= '0';
  elsif ((v_proc_do_irq_set or v_proc_do_irq_reset))='1' then
    n_do_irq <= v_proc_do_irq_set;
  end if;
 end if;
 end process;
p_22: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_do_brk <= '0';
  elsif ((v_proc_do_brk_set or v_proc_do_brk_reset))='1' then
    n_do_brk <= v_proc_do_brk_set;
  end if;
 end if;
 end process;
p_23: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_do_res <= '0';
  elsif ((v_proc_do_res_set or v_proc_do_res_reset))='1' then
    n_do_res <= v_proc_do_res_set;
  end if;
 end if;
 end process;
p_24: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_int_req <= '0';
  elsif ((v_proc_int_req_set or v_proc_int_req_reset))='1' then
    n_int_req <= v_proc_int_req_set;
  end if;
 end if;
 end process;
p_25: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if ((n_ex and n_s1))='1' then
    n_ex_st <= v_net_263;
  elsif ((n_ex and n_s2))='1' then
    n_ex_st <= v_net_262;
  elsif ((n_ex and n_s3))='1' then
    n_ex_st <= v_net_261;
  elsif ((n_ex and n_s4))='1' then
    n_ex_st <= v_net_260;
  elsif ((n_ex and n_s5))='1' then
    n_ex_st <= v_net_259;
  elsif ((((n_ift_run and v_net_187) and n_rdy) and v_net_189))='1' then
    n_ex_st <= v_net_258;
  end if;
 end if;
 end process;
p_26: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if (v_net_196)='1' then
    n_dbgreg <= (n_PCH & n_PCL);
  end if;
 end if;
 end process;
p_27: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_rdflg <= '0';
  elsif (n_start)='1' then
    n_rdflg <= '1';
  end if;
 end if;
 end process;
p_28: process(m_clock)
begin
if m_clock'event and m_clock='1' then
    n_dbg_datai <= n_data;
 end if;
 end process;
p_29: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_ex <= '0';
  elsif ((v_proc_ex_set or v_proc_ex_reset))='1' then
    n_ex <= v_proc_ex_set;
  end if;
 end if;
 end process;
p_30: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    v_reg_190 <= "000";
  elsif ((v_net_198 and n_rdy))='1' then
    v_reg_190 <= v_state_v_reg_190_st0;
  elsif ((v_net_197 and n_rdy))='1' then
    v_reg_190 <= v_state_v_reg_190_st6;
  elsif (v_net_196)='1' then
    v_reg_190 <= v_state_v_reg_190_st5;
  elsif (v_net_195)='1' then
    v_reg_190 <= v_state_v_reg_190_st4;
  elsif (v_net_194)='1' then
    v_reg_190 <= v_state_v_reg_190_st3;
  elsif (v_net_193)='1' then
    v_reg_190 <= v_state_v_reg_190_st2;
  elsif ((v_net_191 and n_do_res))='1' then
    v_reg_190 <= v_state_v_reg_190_st4;
  elsif ((v_net_191 and v_net_192))='1' then
    v_reg_190 <= v_state_v_reg_190_st1;
  end if;
 end if;
 end process;
end RTL;


-- Produced by NSL Core(version=20160105), IP ARCH, Inc. Wed Mar 23 22:09:45 2016
-- Licensed to :EVALUATION USER
