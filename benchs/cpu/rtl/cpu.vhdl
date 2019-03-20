-- Produced by NSL Core(version=20160105), IP ARCH, Inc. Tue Mar 15 01:46:49 2016
-- Licensed to :EVALUATION USER
--- DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. ---
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity cpu is 
    port(p_reset: in std_logic; m_clock: in std_logic;
 mwrite: out std_logic;
 mread: out std_logic;
 adder: out std_logic_vector(7 downto 0);
 dbuso: out std_logic_vector(7 downto 0);
 dbusi: in std_logic_vector(7 downto 0));
end cpu;

architecture RTL of cpu is

 
  signal pc: std_logic_vector(7 downto 0);
  signal ins: std_logic_vector(7 downto 0);
  signal op: std_logic_vector(7 downto 0);
  signal count: std_logic_vector(7 downto 0);
  signal a: std_logic_vector(7 downto 0);
  signal i: std_logic_vector(7 downto 0);
  signal ifetch: std_logic;
  signal ofetch: std_logic;
  signal exop: std_logic;
  signal exec: std_logic;
  signal op1: std_logic_vector(7 downto 0);
  signal op2: std_logic_vector(7 downto 0);
  signal res: std_logic_vector(7 downto 0);
  signal pco: std_logic_vector(7 downto 0);
  signal pcinc: std_logic;
  signal add: std_logic;
  signal br_taken: std_logic;
  signal v_proc_exec_set: std_logic;
  signal v_proc_exec_reset: std_logic;
  signal v_net_0: std_logic;
  signal v_proc_exop_set: std_logic;
  signal v_proc_exop_reset: std_logic;
  signal v_net_1: std_logic;
  signal v_proc_ofetch_set: std_logic;
  signal v_proc_ofetch_reset: std_logic;
  signal v_net_2: std_logic;
  signal v_proc_ifetch_set: std_logic;
  signal v_proc_ifetch_reset: std_logic;
  signal v_net_3: std_logic;
  signal v_net_4: std_logic;
  signal v_net_5: std_logic;
  signal v_net_6: std_logic;
  signal v_net_7: std_logic;
  signal v_net_8: std_logic;
  signal v_net_9: std_logic;
  signal v_net_10: std_logic;
  signal v_net_11: std_logic;
  signal v_net_12: std_logic;
  signal v_net_13: std_logic;
  signal v_net_14: std_logic;
  signal v_net_15: std_logic;
  signal v_net_16: std_logic;
  signal v_net_17: std_logic;
  signal v_net_18: std_logic;
  signal v_net_19: std_logic;
  signal v_net_20: std_logic;
  signal v_net_21: std_logic;
  signal v_net_22: std_logic;
  signal v_net_23: std_logic;
  signal v_net_24: std_logic;
  signal v_net_25: std_logic;
  signal v_net_26: std_logic;
  signal v_net_27: std_logic;
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
  signal v_net_41: std_logic;
  signal v_net_42: std_logic;
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
  signal v_net_101: std_logic_vector(7 downto 0);
  signal v_net_102: std_logic_vector(7 downto 0);
  signal v_net_103: std_logic_vector(7 downto 0);
  signal v_net_104: std_logic_vector(7 downto 0);
  signal v_net_105: std_logic_vector(7 downto 0);
  signal v_net_106: std_logic_vector(7 downto 0);
  signal v_net_107: std_logic_vector(7 downto 0);
  signal v_net_108: std_logic_vector(7 downto 0);
  signal v_net_109: std_logic_vector(7 downto 0);
  signal v_net_110: std_logic_vector(7 downto 0);
  signal v_net_111: std_logic_vector(7 downto 0);
  signal v_net_112: std_logic_vector(7 downto 0);
  signal v_net_113: std_logic_vector(7 downto 0);
  signal v_net_114: std_logic_vector(7 downto 0);
  signal v_net_115: std_logic_vector(7 downto 0);
  signal v_net_116: std_logic_vector(7 downto 0);
  signal v_net_117: std_logic_vector(7 downto 0);
  signal v_net_118: std_logic_vector(7 downto 0);
  signal v_net_119: std_logic_vector(7 downto 0);
  signal v_net_120: std_logic_vector(7 downto 0);
  signal v_net_121: std_logic_vector(7 downto 0);
  signal v_net_122: std_logic_vector(7 downto 0);
  signal v_net_123: std_logic_vector(7 downto 0);
  signal v_net_124: std_logic_vector(7 downto 0);
  signal internal_dbuso: std_logic_vector(7 downto 0);
  signal internal_adder: std_logic_vector(7 downto 0);
  signal internal_mread: std_logic;
  signal internal_mwrite: std_logic;
  constant v_net_125: std_logic_vector(7 downto 0) := "00000001";
  constant v_net_126: std_logic_vector(7 downto 0) := "00000000";
  constant v_net_127: std_logic_vector(7 downto 0) := "00000001";
  constant v_net_128: std_logic_vector(7 downto 0) := "10101010";
  constant v_net_129: std_logic_vector(7 downto 0) := "10101001";
  constant v_net_130: std_logic_vector(7 downto 0) := "10101000";
  constant v_net_131: std_logic_vector(7 downto 0) := "10011010";
  constant v_net_132: std_logic_vector(7 downto 0) := "10011001";
  constant v_net_133: std_logic_vector(7 downto 0) := "10011000";
  constant v_net_134: std_logic_vector(7 downto 0) := "10001010";
  constant v_net_135: std_logic_vector(7 downto 0) := "10001001";
  constant v_net_136: std_logic_vector(7 downto 0) := "10001000";
  constant v_net_137: std_logic_vector(7 downto 0) := "10000101";
  constant v_net_138: std_logic_vector(7 downto 0) := "00000000";
  constant v_net_139: std_logic_vector(7 downto 0) := "10000100";
  constant v_net_140: std_logic_vector(7 downto 0) := "10000010";
  constant v_net_141: std_logic_vector(7 downto 0) := "10000001";
  constant v_net_142: std_logic_vector(7 downto 0) := "00001010";
  constant v_net_143: std_logic_vector(7 downto 0) := "00001001";
  constant v_net_144: std_logic_vector(7 downto 0) := "00001000";
  constant v_net_145: std_logic_vector(7 downto 0) := "00000111";
  constant v_net_146: std_logic_vector(7 downto 0) := "00000110";
  constant v_net_147: std_logic_vector(7 downto 0) := "00000101";
  constant v_net_148: std_logic_vector(7 downto 0) := "00000100";
  constant v_net_149: std_logic_vector(7 downto 0) := "00000011";
  constant v_net_150: std_logic_vector(7 downto 0) := "00000010";
  constant v_net_151: std_logic_vector(7 downto 0) := "00000001";
  constant v_net_152: std_logic_vector(7 downto 0) := "00000000";
  constant v_net_153: std_logic_vector(7 downto 0) := "00000001";
  constant v_net_154: std_logic_vector(7 downto 0) := "00000001";
  constant v_net_155: std_logic_vector(7 downto 0) := "11111111";

begin
  op1 <= ((v_net_118 or v_net_119) or v_net_120) when ((((v_net_94 or v_net_84) or v_net_29) or (v_net_99 or (v_net_89 or (v_net_73 or v_net_22)))))='1'
  else "00000000" ;
  op2 <= (((v_net_121 or v_net_122) or v_net_123) or v_net_124) when (((((v_net_98 or v_net_93) or (v_net_88 or v_net_83)) or (v_net_72 or v_net_28)) or v_net_21))='1'
  else "00000000" ;
  res <= (op1 + op2);
  pco <= pc;
  pcinc <= '1' when ((v_net_9 or ifetch))='1'
  else '0' ;
  add <= '1' when ((v_net_97 or (v_net_92 or (v_net_87 or (v_net_82 or (v_net_71 or (v_net_27 or v_net_20)))))))='1'
  else '0' ;
  br_taken <= '1' when ((v_net_55 or v_net_53))='1'
  else '0' ;
  v_proc_exec_set <= v_net_14;
  v_proc_exec_reset <= exec;
  v_net_0 <= (v_proc_exec_set or v_proc_exec_reset);
  v_proc_exop_set <= v_net_8;
  v_proc_exop_reset <= '1' when ((v_net_63 or v_net_60))='1'
  else '0' ;
  v_net_1 <= (v_proc_exop_set or v_proc_exop_reset);
  v_proc_ofetch_set <= ifetch;
  v_proc_ofetch_reset <= '1' when ((v_net_13 or v_net_7))='1'
  else '0' ;
  v_net_2 <= (v_proc_ofetch_set or v_proc_ofetch_reset);
  v_proc_ifetch_set <= '1' when ((exec or (v_net_64 or (v_net_61 or v_net_5))))='1'
  else '0' ;
  v_proc_ifetch_reset <= ifetch;
  v_net_3 <= (v_proc_ifetch_set or v_proc_ifetch_reset);
  v_net_4 <= '1' when ((count /= v_net_126))='1'
  else '0' ;
  v_net_5 <= '1' when ((count = v_net_127))='1'
  else '0' ;
  v_net_6 <= (ins(7));
  v_net_7 <= (ofetch and v_net_6);
  v_net_8 <= (ofetch and v_net_6);
  v_net_9 <= (ofetch and v_net_6);
  v_net_10 <= (ofetch and v_net_6);
  v_net_11 <= (ofetch and v_net_6);
  v_net_12 <= (ofetch and v_net_6);
  v_net_13 <= (ofetch and ( not v_net_6));
  v_net_14 <= (ofetch and ( not v_net_6));
  v_net_15 <= exop when ((ins = v_net_128))='1'
  else '0' ;
  v_net_16 <= (exop and v_net_15);
  v_net_17 <= exop when ((ins = v_net_129))='1'
  else '0' ;
  v_net_18 <= (exop and v_net_17);
  v_net_19 <= exop when ((ins = v_net_130))='1'
  else '0' ;
  v_net_20 <= (exop and v_net_19);
  v_net_21 <= (exop and v_net_19);
  v_net_22 <= (exop and v_net_19);
  v_net_23 <= (exop and v_net_19);
  v_net_24 <= exop when ((ins = v_net_131))='1'
  else '0' ;
  v_net_25 <= (exop and v_net_24);
  v_net_26 <= (exop and v_net_24);
  v_net_27 <= (exop and v_net_24);
  v_net_28 <= (exop and v_net_24);
  v_net_29 <= (exop and v_net_24);
  v_net_30 <= (exop and v_net_24);
  v_net_31 <= exop when ((ins = v_net_132))='1'
  else '0' ;
  v_net_32 <= (exop and v_net_31);
  v_net_33 <= (exop and v_net_31);
  v_net_34 <= (exop and v_net_31);
  v_net_35 <= exop when ((ins = v_net_133))='1'
  else '0' ;
  v_net_36 <= (exop and v_net_35);
  v_net_37 <= (exop and v_net_35);
  v_net_38 <= (exop and v_net_35);
  v_net_39 <= exop when ((ins = v_net_134))='1'
  else '0' ;
  v_net_40 <= (exop and v_net_39);
  v_net_41 <= (exop and v_net_39);
  v_net_42 <= (exop and v_net_39);
  v_net_43 <= exop when ((ins = v_net_135))='1'
  else '0' ;
  v_net_44 <= (exop and v_net_43);
  v_net_45 <= (exop and v_net_43);
  v_net_46 <= (exop and v_net_43);
  v_net_47 <= exop when ((ins = v_net_136))='1'
  else '0' ;
  v_net_48 <= (exop and v_net_47);
  v_net_49 <= (exop and v_net_47);
  v_net_50 <= (exop and v_net_47);
  v_net_51 <= exop when ((ins = v_net_137))='1'
  else '0' ;
  v_net_52 <= (exop and v_net_51) when ((a = v_net_138))='1'
  else '0' ;
  v_net_53 <= ((exop and v_net_51) and v_net_52);
  v_net_54 <= exop when ((ins = v_net_139))='1'
  else '0' ;
  v_net_55 <= (exop and v_net_54);
  v_net_56 <= exop when ((ins = v_net_140))='1'
  else '0' ;
  v_net_57 <= (exop and v_net_56);
  v_net_58 <= exop when ((ins = v_net_141))='1'
  else '0' ;
  v_net_59 <= (exop and v_net_58);
  v_net_60 <= (exop and br_taken);
  v_net_61 <= (exop and br_taken);
  v_net_62 <= (exop and br_taken);
  v_net_63 <= (exop and ( not br_taken));
  v_net_64 <= (exop and ( not br_taken));
  v_net_65 <= (exop and ( not br_taken));
  v_net_66 <= exec when ((ins = v_net_142))='1'
  else '0' ;
  v_net_67 <= (exec and v_net_66);
  v_net_68 <= exec when ((ins = v_net_143))='1'
  else '0' ;
  v_net_69 <= (exec and v_net_68);
  v_net_70 <= exec when ((ins = v_net_144))='1'
  else '0' ;
  v_net_71 <= (exec and v_net_70);
  v_net_72 <= (exec and v_net_70);
  v_net_73 <= (exec and v_net_70);
  v_net_74 <= (exec and v_net_70);
  v_net_75 <= exec when ((ins = v_net_145))='1'
  else '0' ;
  v_net_76 <= (exec and v_net_75);
  v_net_77 <= exec when ((ins = v_net_146))='1'
  else '0' ;
  v_net_78 <= (exec and v_net_77);
  v_net_79 <= exec when ((ins = v_net_147))='1'
  else '0' ;
  v_net_80 <= (exec and v_net_79);
  v_net_81 <= exec when ((ins = v_net_148))='1'
  else '0' ;
  v_net_82 <= (exec and v_net_81);
  v_net_83 <= (exec and v_net_81);
  v_net_84 <= (exec and v_net_81);
  v_net_85 <= (exec and v_net_81);
  v_net_86 <= exec when ((ins = v_net_149))='1'
  else '0' ;
  v_net_87 <= (exec and v_net_86);
  v_net_88 <= (exec and v_net_86);
  v_net_89 <= (exec and v_net_86);
  v_net_90 <= (exec and v_net_86);
  v_net_91 <= exec when ((ins = v_net_150))='1'
  else '0' ;
  v_net_92 <= (exec and v_net_91);
  v_net_93 <= (exec and v_net_91);
  v_net_94 <= (exec and v_net_91);
  v_net_95 <= (exec and v_net_91);
  v_net_96 <= exec when ((ins = v_net_151))='1'
  else '0' ;
  v_net_97 <= (exec and v_net_96);
  v_net_98 <= (exec and v_net_96);
  v_net_99 <= (exec and v_net_96);
  v_net_100 <= (exec and v_net_96);
  v_net_101 <= pc when ((exec or v_net_65))='1'
  else "00000000" ;
  v_net_102 <= op when (v_net_62)='1'
  else "00000000" ;
  v_net_103 <= v_net_152 when (v_net_5)='1'
  else "00000000" ;
  v_net_104 <= (pc + v_net_153) when (pcinc)='1'
  else "00000000" ;
  v_net_105 <= ('0' & (a(7 downto 1))) when (v_net_80)='1'
  else "00000000" ;
  v_net_106 <= ((a(6 downto 0)) & '0') when (v_net_78)='1'
  else "00000000" ;
  v_net_107 <= ((a(7)) & (a(7 downto 1))) when (v_net_76)='1'
  else "00000000" ;
  v_net_108 <= (a and i) when (v_net_69)='1'
  else "00000000" ;
  v_net_109 <= (a xor i) when (v_net_67)='1'
  else "00000000" ;
  v_net_110 <= op when (v_net_59)='1'
  else "00000000" ;
  v_net_111 <= dbusi when ((v_net_50 or v_net_42))='1'
  else "00000000" ;
  v_net_112 <= res when ((v_net_100 or (v_net_90 or (v_net_74 or v_net_23))))='1'
  else "00000000" ;
  v_net_113 <= (a and op) when (v_net_18)='1'
  else "00000000" ;
  v_net_114 <= (a xor op) when (v_net_16)='1'
  else "00000000" ;
  v_net_115 <= res when ((v_net_95 or v_net_85))='1'
  else "00000000" ;
  v_net_116 <= op when (v_net_57)='1'
  else "00000000" ;
  v_net_117 <= dbusi when (v_net_46)='1'
  else "00000000" ;
  v_net_118 <= i when ((v_net_94 or v_net_84))='1'
  else "00000000" ;
  v_net_119 <= op when (v_net_29)='1'
  else "00000000" ;
  v_net_120 <= a when ((v_net_99 or (v_net_89 or (v_net_73 or v_net_22))))='1'
  else "00000000" ;
  v_net_121 <= v_net_154 when ((v_net_98 or v_net_93))='1'
  else "00000000" ;
  v_net_122 <= v_net_155 when ((v_net_88 or v_net_83))='1'
  else "00000000" ;
  v_net_123 <= i when ((v_net_72 or v_net_28))='1'
  else "00000000" ;
  v_net_124 <= op when (v_net_21)='1'
  else "00000000" ;
  dbuso <= internal_dbuso;
  internal_dbuso <= i when (v_net_33)='1'
  else a when ((v_net_37 or v_net_26))='1'
  else "00000000" ;
  adder <= internal_adder;
  internal_adder <= (op + i) when (v_net_41)='1'
  else op when ((v_net_49 or (v_net_45 or (v_net_38 or v_net_34))))='1'
  else res when (v_net_30)='1'
  else pco when ((v_net_11 or ifetch))='1'
  else "00000000" ;
  mread <= internal_mread;
  internal_mread <= '1' when ((v_net_48 or (v_net_44 or (v_net_40 or (v_net_10 or ifetch)))))='1'
  else '0' ;
  mwrite <= internal_mwrite;
  internal_mwrite <= '1' when ((v_net_36 or (v_net_32 or v_net_25)))='1'
  else '0' ;
p_0: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    pc <= "00000000";
  elsif (((((exec or v_net_65) or v_net_62) or v_net_5) or pcinc))='1' then
    pc <= (((v_net_101 or v_net_102) or v_net_103) or v_net_104);
  end if;
 end if;
 end process;
p_1: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    ins <= "00000000";
  elsif (ifetch)='1' then
    ins <= dbusi;
  end if;
 end if;
 end process;
p_2: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if (v_net_12)='1' then
    op <= dbusi;
  end if;
 end if;
 end process;
p_3: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    count <= "11111111";
  elsif (v_net_4)='1' then
    count <= (count - v_net_125);
  end if;
 end if;
 end process;
p_4: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    a <= "00000000";
  elsif ((((((((((v_net_80 or v_net_78) or v_net_76) or v_net_69) or v_net_67) or v_net_59) or (v_net_50 or v_net_42)) or (v_net_100 or (v_net_90 or (v_net_74 or v_net_23)))) or v_net_18) or v_net_16))='1' then
    a <= (((((((((v_net_105 or v_net_106) or v_net_107) or v_net_108) or v_net_109) or v_net_110) or v_net_111) or v_net_112) or v_net_113) or v_net_114);
  end if;
 end if;
 end process;
p_5: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    i <= "00000000";
  elsif ((((v_net_95 or v_net_85) or v_net_57) or v_net_46))='1' then
    i <= ((v_net_115 or v_net_116) or v_net_117);
  end if;
 end if;
 end process;
p_6: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    ifetch <= '0';
  elsif (v_net_3)='1' then
    ifetch <= v_proc_ifetch_set;
  end if;
 end if;
 end process;
p_7: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    ofetch <= '0';
  elsif (v_net_2)='1' then
    ofetch <= v_proc_ofetch_set;
  end if;
 end if;
 end process;
p_8: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    exop <= '0';
  elsif (v_net_1)='1' then
    exop <= v_proc_exop_set;
  end if;
 end if;
 end process;
p_9: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    exec <= '0';
  elsif (v_net_0)='1' then
    exec <= v_proc_exec_set;
  end if;
 end if;
 end process;
end RTL;


-- Produced by NSL Core(version=20160105), IP ARCH, Inc. Tue Mar 15 01:46:49 2016
-- Licensed to :EVALUATION USER
