-- Produced by NSL Core(version=20140312), IP ARCH, Inc. Thu Aug 14 16:10:25 2014
-- Licensed to :EVALUATION USER
--- DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. ---
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity snx is 
    port(p_reset: in std_logic; m_clock: in std_logic;
 n_hlt: out std_logic;
 n_wb: out std_logic;
 n_IntAck: out std_logic;
 n_memory_write: out std_logic;
 n_memory_read: out std_logic;
 n_memory_adr: out std_logic;
 n_inst_read: out std_logic;
 n_inst_adr: out std_logic;
 n_mem_ok: in std_logic;
 n_inst_ok: in std_logic;
 n_IntReq: in std_logic;
 n_start: in std_logic;
 n_adrs: out std_logic_vector(15 downto 0);
 n_iadrs: out std_logic_vector(15 downto 0);
 n_datao: out std_logic_vector(15 downto 0);
 n_datai: in std_logic_vector(15 downto 0);
 n_inst: in std_logic_vector(15 downto 0));
end snx;

architecture RTL of snx is

 

component inc16 
    port(p_reset: in std_logic; m_clock: in std_logic;
 n_do: in std_logic;
 n_out: out std_logic_vector(15 downto 0);
 n_in: in std_logic_vector(15 downto 0));
end component;


component reg4 
    port(p_reset: in std_logic; m_clock: in std_logic;
 n_readb: in std_logic;
 n_reada: in std_logic;
 n_write: in std_logic;
 n_n_regoutb: in std_logic_vector(1 downto 0);
 n_n_regouta: in std_logic_vector(1 downto 0);
 n_n_regin: in std_logic_vector(1 downto 0);
 n_regoutb: out std_logic_vector(15 downto 0);
 n_regouta: out std_logic_vector(15 downto 0);
 n_regin: in std_logic_vector(15 downto 0));
end component;


component alu16 
    port(p_reset: in std_logic; m_clock: in std_logic;
 n_exe: in std_logic;
 n_q: out std_logic_vector(15 downto 0);
 n_f: in std_logic_vector(5 downto 0);
 n_b: in std_logic_vector(15 downto 0);
 n_a: in std_logic_vector(15 downto 0));
end component;


component type_dec 
    port(p_reset: in std_logic; m_clock: in std_logic;
 n_dec: in std_logic;
 n_ctype: out std_logic;
 n_rtype: out std_logic;
 n_itype: out std_logic;
 n_op: in std_logic_vector(3 downto 0));
end component;

  signal n_pc: std_logic_vector(15 downto 0);
  signal n_isr: std_logic;
  signal v_opreg_fn: std_logic_vector(5 downto 0);
  signal v_opreg_r1: std_logic_vector(1 downto 0);
  signal v_opreg_r3: std_logic_vector(1 downto 0);
  signal v_opreg_r2: std_logic_vector(1 downto 0);
  signal v_opreg_op: std_logic_vector(3 downto 0);
  signal n_mar: std_logic_vector(15 downto 0);
  signal n_regnum: std_logic_vector(1 downto 0);
  signal n_cr0: std_logic_vector(15 downto 0);
  signal n_cr1: std_logic_vector(15 downto 0);
  signal n_cr2: std_logic_vector(15 downto 0);
  signal n_cr3: std_logic_vector(15 downto 0);
  signal n_int0: std_logic;
  signal n_int1: std_logic;
  signal n_npc: std_logic_vector(15 downto 0);
  signal n_nmar: std_logic_vector(15 downto 0);
  signal n_nregnum: std_logic_vector(1 downto 0);
  signal n_crnum: std_logic_vector(7 downto 0);
  signal n_crwdat: std_logic_vector(15 downto 0);
  signal n_crrdat: std_logic_vector(15 downto 0);
  signal n_iset: std_logic;
  signal n_msetld: std_logic;
  signal n_crwrite: std_logic;
  signal n_crread: std_logic;
  signal n_ifetch: std_logic;
  signal n_exec: std_logic;
  signal n_mstore: std_logic;
  signal n_mstore2: std_logic;
  signal n_mload: std_logic;
  signal v_opitype_I: std_logic_vector(7 downto 0);
  signal v_opitype_r2: std_logic_vector(1 downto 0);
  signal v_opitype_r1: std_logic_vector(1 downto 0);
  signal v_opitype_op: std_logic_vector(3 downto 0);
  signal n_opr1: std_logic_vector(15 downto 0);
  signal n_opr2: std_logic_vector(15 downto 0);
  signal n_aluq: std_logic_vector(15 downto 0);
  signal n_wdata: std_logic_vector(15 downto 0);
  signal v_alu_a: std_logic_vector(15 downto 0);
  signal v_alu_b: std_logic_vector(15 downto 0);
  signal v_alu_f: std_logic_vector(5 downto 0);
  signal v_alu_q: std_logic_vector(15 downto 0);
  signal v_alu_exe: std_logic;
  signal v_alu_p_reset: std_logic;
  signal v_alu_m_clock: std_logic;
  signal v_gr_regin: std_logic_vector(15 downto 0);
  signal v_gr_regouta: std_logic_vector(15 downto 0);
  signal v_gr_regoutb: std_logic_vector(15 downto 0);
  signal v_gr_n_regin: std_logic_vector(1 downto 0);
  signal v_gr_n_regouta: std_logic_vector(1 downto 0);
  signal v_gr_n_regoutb: std_logic_vector(1 downto 0);
  signal v_gr_write: std_logic;
  signal v_gr_reada: std_logic;
  signal v_gr_readb: std_logic;
  signal v_gr_p_reset: std_logic;
  signal v_gr_m_clock: std_logic;
  signal v_inc_in: std_logic_vector(15 downto 0);
  signal v_inc_out: std_logic_vector(15 downto 0);
  signal v_inc_do: std_logic;
  signal v_inc_p_reset: std_logic;
  signal v_inc_m_clock: std_logic;
  signal v_proc_ifetch_set: std_logic;
  signal v_proc_ifetch_reset: std_logic;
  signal v_proc_exec_set: std_logic;
  signal v_proc_exec_reset: std_logic;
  signal v_proc_mstore_set: std_logic;
  signal v_proc_mstore_reset: std_logic;
  signal v_proc_mstore2_set: std_logic;
  signal v_proc_mstore2_reset: std_logic;
  signal v_proc_mload_set: std_logic;
  signal v_proc_mload_reset: std_logic;
  signal v_net_4: std_logic;
  signal v_reg_5: std_logic;
  signal v_reg_6: std_logic;
  signal v_net_7: std_logic;
  signal v_net_8: std_logic;
  signal v_net_9: std_logic;
  signal v_net_10: std_logic;
  signal v_net_11: std_logic;
  signal v_net_12: std_logic;
  signal v_net_13: std_logic;
  signal v_net_14: std_logic;
  signal v_net_15: std_logic_vector(15 downto 0);
  signal v_tdec_op: std_logic_vector(3 downto 0);
  signal v_tdec_itype: std_logic;
  signal v_tdec_rtype: std_logic;
  signal v_tdec_ctype: std_logic;
  signal v_tdec_dec: std_logic;
  signal v_tdec_p_reset: std_logic;
  signal v_tdec_m_clock: std_logic;
  signal v_net_17: std_logic_vector(15 downto 0);
  signal v_net_18: std_logic_vector(15 downto 0);
  signal v_net_19: std_logic;
  signal v_net_20: std_logic;
  signal v_net_21: std_logic;
  signal v_net_22: std_logic;
  signal v_net_23: std_logic;
  signal v_net_24: std_logic;
  signal v_net_25: std_logic;
  signal v_net_26: std_logic;
  signal v_net_28: std_logic;
  signal v_net_29: std_logic;
  signal v_net_30: std_logic;
  signal v_net_31: std_logic;
  signal v_net_32: std_logic;
  signal v_net_33: std_logic;
  signal v_net_34: std_logic;
  signal v_net_35: std_logic;
  signal v_net_36: std_logic;
  signal v_net_37: std_logic;
  signal v_net_38: std_logic;
  signal v_net_39: std_logic;
  signal v_net_40: std_logic;
  signal internal_n_datao: std_logic_vector(15 downto 0);
  signal internal_n_iadrs: std_logic_vector(15 downto 0);
  signal internal_n_adrs: std_logic_vector(15 downto 0);
  signal internal_n_inst_adr: std_logic;
  signal internal_n_inst_read: std_logic;
  signal internal_n_memory_adr: std_logic;
  signal internal_n_memory_read: std_logic;
  signal internal_n_memory_write: std_logic;
  signal internal_n_IntAck: std_logic;
  signal internal_n_wb: std_logic;
  signal internal_n_hlt: std_logic;
  constant v_net_41: std_logic_vector(15 downto 0) := "0000000000000000";
  constant v_net_42: std_logic_vector(15 downto 0) := "0000000000000000";
  constant v_net_43: std_logic_vector(7 downto 0) := "00000000";
  constant v_net_44: std_logic_vector(5 downto 0) := "000000";
  constant v_net_45: std_logic_vector(5 downto 0) := "000000";
  constant v_net_46: std_logic_vector(7 downto 0) := "00000011";
  constant v_net_47: std_logic_vector(7 downto 0) := "00000010";
  constant v_net_48: std_logic_vector(7 downto 0) := "00000001";
  constant v_net_49: std_logic_vector(7 downto 0) := "00000000";
  constant v_net_50: std_logic_vector(7 downto 0) := "00000011";
  constant v_net_51: std_logic_vector(7 downto 0) := "00000010";
  constant v_net_52: std_logic_vector(7 downto 0) := "00000001";
  constant v_net_53: std_logic_vector(7 downto 0) := "00000000";
  constant v_net_54: std_logic_vector(1 downto 0) := "00";
  constant v_net_55: std_logic_vector(3 downto 0) := "1011";
  constant v_net_56: std_logic_vector(3 downto 0) := "1001";
  constant v_net_57: std_logic_vector(3 downto 0) := "1000";
  constant v_net_58: std_logic_vector(5 downto 0) := "000111";
  constant v_net_59: std_logic_vector(5 downto 0) := "000110";
  constant v_net_60: std_logic_vector(3 downto 0) := "1111";
  constant v_net_61: std_logic_vector(3 downto 0) := "1110";
  constant v_net_62: std_logic_vector(15 downto 0) := "0000000000000000";
  constant v_net_63: std_logic_vector(3 downto 0) := "1111";
  constant v_net_64: std_logic_vector(3 downto 0) := "1010";
  constant v_net_65: std_logic_vector(3 downto 0) := "1011";
  constant v_net_66: std_logic_vector(7 downto 0) := "11111111";
  constant v_net_67: std_logic_vector(7 downto 0) := "11111111";

begin
inc: inc16 
     port map (p_reset => v_inc_p_reset, m_clock => v_inc_m_clock, n_do => v_inc_do, n_out => v_inc_out, n_in => v_inc_in);
gr: reg4 
     port map (p_reset => v_gr_p_reset, m_clock => v_gr_m_clock, n_readb => v_gr_readb, n_reada => v_gr_reada, n_write => v_gr_write, n_n_regoutb => v_gr_n_regoutb, n_n_regouta => v_gr_n_regouta, n_n_regin => v_gr_n_regin, n_regoutb => v_gr_regoutb, n_regouta => v_gr_regouta, n_regin => v_gr_regin);
alu: alu16 
     port map (p_reset => v_alu_p_reset, m_clock => v_alu_m_clock, n_exe => v_alu_exe, n_q => v_alu_q, n_f => v_alu_f, n_b => v_alu_b, n_a => v_alu_a);
tdec: type_dec 
     port map (p_reset => v_tdec_p_reset, m_clock => v_tdec_m_clock, n_dec => v_tdec_dec, n_ctype => v_tdec_ctype, n_rtype => v_tdec_rtype, n_itype => v_tdec_itype, n_op => v_tdec_op);
  n_npc <= n_pc when (((n_mload and ( not v_net_40)) and n_mem_ok))='1'
  else n_pc when ((n_mload and v_net_40))='1'
  else n_pc when (n_mstore2)='1'
  else n_pc when ((n_mstore and v_net_39))='1'
  else v_inc_out when (((((n_exec and ( not v_net_24)) and ( not v_net_25)) and ( not v_tdec_ctype)) and ( not v_net_32)))='1'
  else n_aluq when ((n_exec and v_net_32))='1'
  else n_cr3 when (((n_exec and v_tdec_ctype) and v_net_28))='1'
  else n_cr2 when (v_reg_5)='1'
  else v_net_41 when (n_start)='1'
  else "0000000000000000" ;
  n_nmar <= n_aluq when ((n_exec and v_net_25))='1'
  else "0000000000000000" ;
  n_nregnum <= v_opitype_r1 when ((n_exec and v_net_25))='1'
  else "00" ;
  n_crnum <= (n_mar(7 downto 0)) when ((n_mload and v_net_40))='1'
  else (n_mar(7 downto 0)) when ((n_mstore and v_net_39))='1'
  else "00000000" ;
  n_crwdat <= n_wdata when ((n_mstore and v_net_39))='1'
  else "0000000000000000" ;
  n_crrdat <= n_cr0 when ((n_crread and v_net_14))='1'
  else n_cr1 when ((n_crread and v_net_13))='1'
  else n_cr2 when ((n_crread and v_net_12))='1'
  else n_cr3 when ((n_crread and v_net_11))='1'
  else "0000000000000000" ;
  n_iset <= '1' when (((n_mload and ( not v_net_40)) and n_mem_ok))='1'
  else '1' when ((n_mload and v_net_40))='1'
  else '1' when (n_mstore2)='1'
  else '1' when ((n_mstore and v_net_39))='1'
  else '1' when (((((n_exec and ( not v_net_24)) and ( not v_net_25)) and ( not v_tdec_ctype)) and ( not v_net_32)))='1'
  else '1' when ((n_exec and v_net_32))='1'
  else '1' when (((n_exec and v_tdec_ctype) and v_net_28))='1'
  else '1' when (v_reg_5)='1'
  else n_start;
  n_msetld <= '1' when ((n_exec and v_net_25))='1'
  else '0' ;
  n_crwrite <= '1' when ((n_mstore and v_net_39))='1'
  else '0' ;
  n_crread <= '1' when ((n_mload and v_net_40))='1'
  else '0' ;
  v_opitype_I <= (v_net_18(7 downto 0)) when (n_exec)='1'
  else "00000000" ;
  v_opitype_r2 <= (v_net_18(9 downto 8)) when (n_exec)='1'
  else "00" ;
  v_opitype_r1 <= (v_net_18(11 downto 10)) when (n_exec)='1'
  else "00" ;
  v_opitype_op <= (v_net_18(15 downto 12)) when (n_exec)='1'
  else "0000" ;
  n_opr1 <= v_gr_regouta when (n_exec)='1'
  else "0000000000000000" ;
  n_opr2 <= v_gr_regoutb when ((n_exec and ( not v_net_22)))='1'
  else v_net_42 when ((n_exec and v_net_22))='1'
  else "0000000000000000" ;
  n_aluq <= v_alu_q when (((n_exec and v_tdec_itype) and ( not v_net_23)))='1'
  else v_alu_q when (((n_exec and v_tdec_itype) and v_net_23))='1'
  else v_alu_q when ((n_exec and v_tdec_rtype))='1'
  else "0000000000000000" ;
  n_wdata <= v_gr_regouta when ((n_mstore and v_net_39))='1'
  else "0000000000000000" ;
  v_alu_a <= (((v_opitype_I(7)) & (v_opitype_I(7)) & (v_opitype_I(7)) & (v_opitype_I(7)) & (v_opitype_I(7)) & (v_opitype_I(7)) & (v_opitype_I(7)) & (v_opitype_I(7))) & v_opitype_I) when (((n_exec and v_tdec_itype) and ( not v_net_23)))='1'
  else (v_opitype_I & v_net_43) when (((n_exec and v_tdec_itype) and v_net_23))='1'
  else n_opr1 when ((n_exec and v_tdec_rtype))='1'
  else "0000000000000000" ;
  v_alu_b <= n_opr2 when (((n_exec and v_tdec_itype) and ( not v_net_23)))='1'
  else n_opr2 when (((n_exec and v_tdec_itype) and v_net_23))='1'
  else n_opr2 when ((n_exec and v_tdec_rtype))='1'
  else "0000000000000000" ;
  v_alu_f <= v_net_45 when (((n_exec and v_tdec_itype) and ( not v_net_23)))='1'
  else v_net_44 when (((n_exec and v_tdec_itype) and v_net_23))='1'
  else v_opreg_fn when ((n_exec and v_tdec_rtype))='1'
  else "000000" ;
  v_alu_exe <= '1' when (((n_exec and v_tdec_itype) and ( not v_net_23)))='1'
  else '1' when (((n_exec and v_tdec_itype) and v_net_23))='1'
  else '1' when ((n_exec and v_tdec_rtype))='1'
  else '0' ;
  v_alu_p_reset <= p_reset;
  v_alu_m_clock <= m_clock;
  v_gr_regin <= n_datai when (((n_mload and ( not v_net_40)) and n_mem_ok))='1'
  else n_crrdat when ((n_mload and v_net_40))='1'
  else n_aluq when ((n_exec and v_tdec_rtype))='1'
  else n_aluq when ((n_exec and v_net_38))='1'
  else v_inc_out when ((n_exec and v_net_33))='1'
  else "0000000000000000" ;
  v_gr_n_regin <= n_regnum when (((n_mload and ( not v_net_40)) and n_mem_ok))='1'
  else n_regnum when ((n_mload and v_net_40))='1'
  else v_opreg_r1 when ((n_exec and v_tdec_rtype))='1'
  else v_opitype_r1 when ((n_exec and v_net_38))='1'
  else v_opitype_r1 when ((n_exec and v_net_33))='1'
  else "00" ;
  v_gr_n_regouta <= n_regnum when ((n_mstore and ( not v_net_39)))='1'
  else n_regnum when ((n_mstore and v_net_39))='1'
  else v_opreg_r2 when (n_exec)='1'
  else "00" ;
  v_gr_n_regoutb <= v_opreg_r3 when ((n_exec and ( not v_net_22)))='1'
  else "00" ;
  v_gr_write <= '1' when (((n_mload and ( not v_net_40)) and n_mem_ok))='1'
  else '1' when ((n_mload and v_net_40))='1'
  else '1' when ((n_exec and v_tdec_rtype))='1'
  else '1' when ((n_exec and v_net_38))='1'
  else '1' when ((n_exec and v_net_33))='1'
  else '0' ;
  v_gr_reada <= '1' when ((n_mstore and ( not v_net_39)))='1'
  else '1' when ((n_mstore and v_net_39))='1'
  else n_exec;
  v_gr_readb <= '1' when ((n_exec and ( not v_net_22)))='1'
  else '0' ;
  v_gr_p_reset <= p_reset;
  v_gr_m_clock <= m_clock;
  v_inc_in <= n_pc when ((n_exec and v_net_33))='1'
  else n_pc when (((((n_exec and ( not v_net_24)) and ( not v_net_25)) and ( not v_tdec_ctype)) and ( not v_net_32)))='1'
  else n_pc when ((n_exec and v_net_25))='1'
  else n_pc when ((n_exec and v_net_24))='1'
  else "0000000000000000" ;
  v_inc_do <= '1' when ((n_exec and v_net_33))='1'
  else '1' when (((((n_exec and ( not v_net_24)) and ( not v_net_25)) and ( not v_tdec_ctype)) and ( not v_net_32)))='1'
  else '1' when ((n_exec and v_net_25))='1'
  else '1' when ((n_exec and v_net_24))='1'
  else '0' ;
  v_inc_p_reset <= p_reset;
  v_inc_m_clock <= m_clock;
  v_proc_ifetch_set <= '1' when ((n_iset and ( not v_net_4)))='1'
  else '0' ;
  v_proc_ifetch_reset <= '1' when ((n_ifetch and n_inst_ok))='1'
  else '0' ;
  v_proc_exec_set <= '1' when ((n_ifetch and n_inst_ok))='1'
  else '0' ;
  v_proc_exec_reset <= '1' when (n_exec)='1'
  else '1' when ((n_exec and v_net_24))='1'
  else '0' ;
  v_proc_mstore_set <= '1' when ((n_exec and v_net_24))='1'
  else '0' ;
  v_proc_mstore_reset <= '1' when (((n_mstore and ( not v_net_39)) and n_mem_ok))='1'
  else '1' when (((n_mstore and ( not v_net_39)) and n_mem_ok))='1'
  else '1' when ((n_mstore and v_net_39))='1'
  else '0' ;
  v_proc_mstore2_set <= '1' when (((n_mstore and ( not v_net_39)) and n_mem_ok))='1'
  else '0' ;
  v_proc_mstore2_reset <= n_mstore2;
  v_proc_mload_set <= n_msetld;
  v_proc_mload_reset <= '1' when (((n_mload and ( not v_net_40)) and n_mem_ok))='1'
  else '1' when ((n_mload and v_net_40))='1'
  else '0' ;
  v_net_4 <= (((n_cr0(0)) and ( not n_isr)) and n_int1) when (n_iset)='1'
  else '0' ;
  v_net_7 <= n_crwrite when ((n_crnum = v_net_46))
  else '0' ;
  v_net_8 <= n_crwrite when ((n_crnum = v_net_47))
  else '0' ;
  v_net_9 <= n_crwrite when ((n_crnum = v_net_48))
  else '0' ;
  v_net_10 <= n_crwrite when ((n_crnum = v_net_49))
  else '0' ;
  v_net_11 <= n_crread when ((n_crnum = v_net_50))
  else '0' ;
  v_net_12 <= n_crread when ((n_crnum = v_net_51))
  else '0' ;
  v_net_13 <= n_crread when ((n_crnum = v_net_52))
  else '0' ;
  v_net_14 <= n_crread when ((n_crnum = v_net_53))
  else '0' ;
  v_net_15 <= n_inst when ((n_ifetch and n_inst_ok))='1'
  else "0000000000000000" ;
  v_tdec_op <= v_opreg_op when (n_exec)='1'
  else "0000" ;
  v_tdec_dec <= n_exec;
  v_tdec_p_reset <= p_reset;
  v_tdec_m_clock <= m_clock;
  v_net_17 <= ((v_opreg_op & v_opreg_r2 & v_opreg_r3 & v_opreg_r1 & v_opreg_fn));
  v_net_18 <= (v_opreg_op & v_opreg_r2 & v_opreg_r3 & v_opreg_r1 & v_opreg_fn) when (n_exec)='1'
  else "0000000000000000" ;
  v_net_19 <= v_tdec_itype when (n_exec)='1'
  else '0' ;
  v_net_20 <= n_exec when ((v_opreg_r3 = v_net_54))
  else '0' ;
  v_net_21 <= v_net_20 when (n_exec)='1'
  else '0' ;
  v_net_22 <= (v_tdec_itype and v_net_20) when (n_exec)='1'
  else '0' ;
  v_net_23 <= (n_exec and v_tdec_itype) when ((v_opreg_op = v_net_55))
  else '0' ;
  v_net_24 <= n_exec when ((v_opitype_op = v_net_56))
  else '0' ;
  v_net_25 <= n_exec when ((v_opitype_op = v_net_57))
  else '0' ;
  v_net_26 <= (n_exec and v_tdec_ctype) when ((v_opreg_fn = v_net_58))
  else '0' ;
  v_net_28 <= (n_exec and v_tdec_ctype) when ((v_opreg_fn = v_net_59))
  else '0' ;
  v_net_29 <= n_exec when ((v_opitype_op = v_net_60))
  else '0' ;
  v_net_30 <= n_exec when ((v_opitype_op = v_net_61))
  else '0' ;
  v_net_31 <= n_exec when ((n_opr1 = v_net_62))
  else '0' ;
  v_net_32 <= (v_net_29 or (v_net_30 and v_net_31)) when (n_exec)='1'
  else '0' ;
  v_net_33 <= n_exec when ((v_opitype_op = v_net_63))
  else '0' ;
  v_net_34 <= n_exec when ((v_opitype_op = v_net_64))
  else '0' ;
  v_net_35 <= v_net_34 when (n_exec)='1'
  else '0' ;
  v_net_36 <= n_exec when ((v_opitype_op = v_net_65))
  else '0' ;
  v_net_37 <= v_net_36 when (n_exec)='1'
  else '0' ;
  v_net_38 <= (v_net_34 or v_net_36) when (n_exec)='1'
  else '0' ;
  v_net_39 <= n_mstore when (((n_mar(15 downto 8)) = v_net_66))
  else '0' ;
  v_net_40 <= n_mload when (((n_mar(15 downto 8)) = v_net_67))
  else '0' ;
  n_datao <= internal_n_datao;
  internal_n_datao <= v_gr_regouta when ((n_mstore and ( not v_net_39)))='1'
  else "0000000000000000" ;
  n_iadrs <= internal_n_iadrs;
  internal_n_iadrs <= n_npc when ((n_iset and ( not v_net_4)))='1'
  else "0000000000000000" ;
  n_adrs <= internal_n_adrs;
  internal_n_adrs <= n_mar when ((n_mstore and ( not v_net_39)))='1'
  else n_nmar when (n_msetld)='1'
  else "0000000000000000" ;
  n_inst_adr <= internal_n_inst_adr;
  internal_n_inst_adr <= '1' when ((n_iset and ( not v_net_4)))='1'
  else '0' ;
  n_inst_read <= internal_n_inst_read;
  internal_n_inst_read <= n_ifetch;
  n_memory_adr <= internal_n_memory_adr;
  internal_n_memory_adr <= n_msetld;
  n_memory_read <= internal_n_memory_read;
  internal_n_memory_read <= '1' when ((n_mload and ( not v_net_40)))='1'
  else '0' ;
  n_memory_write <= internal_n_memory_write;
  internal_n_memory_write <= '1' when ((n_mstore and ( not v_net_39)))='1'
  else '0' ;
  n_IntAck <= internal_n_IntAck;
  internal_n_IntAck <= v_reg_5;
  n_wb <= internal_n_wb;
  internal_n_wb <= '1' when (((n_mload and ( not v_net_40)) and n_mem_ok))='1'
  else '1' when ((n_mload and v_net_40))='1'
  else '1' when (((n_mstore and ( not v_net_39)) and n_mem_ok))='1'
  else '1' when ((n_mstore and v_net_39))='1'
  else '1' when (((((n_exec and ( not v_net_24)) and ( not v_net_25)) and ( not v_tdec_ctype)) and ( not v_net_32)))='1'
  else '1' when ((n_exec and v_net_32))='1'
  else '1' when (((n_exec and v_tdec_ctype) and v_net_28))='1'
  else '1' when (((n_exec and v_tdec_ctype) and v_net_26))='1'
  else '0' ;
  n_hlt <= internal_n_hlt;
  internal_n_hlt <= '1' when (((n_exec and v_tdec_ctype) and v_net_26))='1'
  else '0' ;
p_0: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if ((n_exec and v_net_25))='1' then
    n_pc <= v_inc_out;
  elsif ((n_exec and v_net_24))='1' then
    n_pc <= v_inc_out;
  elsif ((n_iset and ( not v_net_4)))='1' then
    n_pc <= n_npc;
  end if;
end if;
end process;
p_1: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_isr <= '0';
  elsif (((n_exec and v_tdec_ctype) and v_net_28))='1' then
    n_isr <= '0';
  elsif (((n_iset and v_net_4) or v_reg_6))='1' then
    n_isr <= '1';
  end if;
end if;
end process;
p_2: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if ((n_ifetch and n_inst_ok))='1' then
    v_opreg_fn <= (v_net_15(5 downto 0));
  end if;
end if;
end process;
p_3: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if ((n_ifetch and n_inst_ok))='1' then
    v_opreg_r1 <= (v_net_15(7 downto 6));
  end if;
end if;
end process;
p_4: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if ((n_ifetch and n_inst_ok))='1' then
    v_opreg_r3 <= (v_net_15(9 downto 8));
  end if;
end if;
end process;
p_5: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if ((n_ifetch and n_inst_ok))='1' then
    v_opreg_r2 <= (v_net_15(11 downto 10));
  end if;
end if;
end process;
p_6: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if ((n_ifetch and n_inst_ok))='1' then
    v_opreg_op <= (v_net_15(15 downto 12));
  end if;
end if;
end process;
p_7: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if ((n_exec and v_net_24))='1' then
    n_mar <= n_aluq;
  elsif (n_msetld)='1' then
    n_mar <= n_nmar;
  end if;
end if;
end process;
p_8: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if ((n_exec and v_net_24))='1' then
    n_regnum <= v_opitype_r1;
  elsif (n_msetld)='1' then
    n_regnum <= n_nregnum;
  end if;
end if;
end process;
p_9: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_cr0 <= "0000000000000000";
  elsif ((n_crwrite and v_net_10))='1' then
    n_cr0 <= n_crwdat;
  end if;
end if;
end process;
p_10: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_cr1 <= "0000000000000000";
  elsif ((n_crwrite and v_net_9))='1' then
    n_cr1 <= n_crwdat;
  end if;
end if;
end process;
p_11: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_cr2 <= "0000000000000000";
  elsif ((n_crwrite and v_net_8))='1' then
    n_cr2 <= n_crwdat;
  end if;
end if;
end process;
p_12: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_cr3 <= "0000000000000000";
  elsif ((n_crwrite and v_net_7))='1' then
    n_cr3 <= n_crwdat;
  elsif (((n_iset and v_net_4) or v_reg_6))='1' then
    n_cr3 <= n_npc;
  end if;
end if;
end process;
p_13: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_int0 <= '0';
  else     n_int0 <= n_IntReq;
  end if;
end if;
end process;
p_14: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_int1 <= '0';
  else     n_int1 <= n_int0;
  end if;
end if;
end process;
p_15: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_ifetch <= '0';
  elsif ((v_proc_ifetch_set or v_proc_ifetch_reset))='1' then
    n_ifetch <= v_proc_ifetch_set;
  end if;
end if;
end process;
p_16: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_exec <= '0';
  elsif ((v_proc_exec_set or v_proc_exec_reset))='1' then
    n_exec <= v_proc_exec_set;
  end if;
end if;
end process;
p_17: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_mstore <= '0';
  elsif ((v_proc_mstore_set or v_proc_mstore_reset))='1' then
    n_mstore <= v_proc_mstore_set;
  end if;
end if;
end process;
p_18: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_mstore2 <= '0';
  elsif ((v_proc_mstore2_set or v_proc_mstore2_reset))='1' then
    n_mstore2 <= v_proc_mstore2_set;
  end if;
end if;
end process;
p_19: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    n_mload <= '0';
  elsif ((v_proc_mload_set or v_proc_mload_reset))='1' then
    n_mload <= v_proc_mload_set;
  end if;
end if;
end process;
p_20: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    v_reg_5 <= '0';
  elsif (((n_iset and v_net_4) or (v_reg_5 or v_reg_6)))='1' then
    v_reg_5 <= (v_reg_6 or (n_iset and v_net_4));
  end if;
end if;
end process;
p_21: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    v_reg_6 <= '0';
  elsif (v_reg_6)='1' then
    v_reg_6 <= '0';
  end if;
end if;
end process;
end RTL;


-- Produced by NSL Core(version=20140312), IP ARCH, Inc. Thu Aug 14 16:10:25 2014
-- Licensed to :EVALUATION USER
