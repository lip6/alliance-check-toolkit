
--Produced by NSL Core(version=20170110), IP ARCH, Inc. Wed May 24 18:20:39 2017
-- Licensed to :EVALUATION USER
--- DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. ---
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity xpu_core is 
    port(p_reset: in std_logic; m_clock: in std_logic;
 n_mwrite: out std_logic;
 n_mread: out std_logic;
 n_address: out std_logic_vector(7 downto 0);
 n_datao: out std_logic_vector(7 downto 0);
 n_datai: in std_logic_vector(7 downto 0));
end xpu_core;

architecture RTL of xpu_core is

 

component add8 
    port(p_reset: in std_logic; m_clock: in std_logic;
 n_exe: in std_logic;
 n_sum: out std_logic_vector(7 downto 0);
 n_in1: in std_logic_vector(7 downto 0);
 n_in2: in std_logic_vector(7 downto 0));
end component;

  signal n_count: std_logic_vector(4 downto 0);
  signal n_pc: std_logic_vector(7 downto 0);
  signal n_op: std_logic_vector(7 downto 0);
  signal n_im: std_logic_vector(7 downto 0);
  signal n_acc: std_logic_vector(7 downto 0);
  signal n_ift: std_logic;
  signal n_imm: std_logic;
  signal n_exe: std_logic;
  signal n_nextpc: std_logic_vector(7 downto 0);
  signal n_wop: std_logic_vector(7 downto 0);
  signal v_proc_exe_set: std_logic;
  signal v_proc_exe_reset: std_logic;
  signal v_net_0: std_logic;
  signal v_proc_imm_set: std_logic;
  signal v_proc_imm_reset: std_logic;
  signal v_net_1: std_logic;
  signal v_proc_ift_set: std_logic;
  signal v_proc_ift_reset: std_logic;
  signal v_net_2: std_logic;
  signal v_adder_in1: std_logic_vector(7 downto 0);
  signal v_adder_in2: std_logic_vector(7 downto 0);
  signal v_adder_sum: std_logic_vector(7 downto 0);
  signal v_adder_exe: std_logic;
  signal v_adder_p_reset: std_logic;
  signal v_adder_m_clock: std_logic;
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
  signal v_net_23: std_logic;
  signal v_net_24: std_logic;
  signal v_net_25: std_logic;
  signal v_net_26: std_logic;
  signal v_net_27: std_logic;
  signal v_net_29: std_logic;
  signal v_net_30: std_logic;
  signal v_net_31: std_logic;
  signal v_net_32: std_logic;
  signal v_net_33: std_logic;
  signal v_net_35: std_logic;
  signal v_net_36: std_logic;
  signal v_net_37: std_logic;
  signal v_net_39: std_logic;
  signal v_net_40: std_logic;
  signal v_net_41: std_logic;
  signal v_net_43: std_logic;
  signal v_net_44: std_logic;
  signal v_net_45: std_logic;
  signal v_net_46: std_logic;
  signal v_net_47: std_logic;
  signal v_net_48: std_logic;
  signal v_net_50: std_logic;
  signal v_net_51: std_logic;
  signal v_net_52: std_logic;
  signal v_net_53: std_logic;
  signal v_net_54: std_logic;
  signal v_net_55: std_logic;
  signal v_net_56: std_logic;
  signal v_net_58: std_logic;
  signal v_net_59: std_logic;
  signal v_net_60: std_logic;
  signal v_net_62: std_logic;
  signal v_net_63: std_logic;
  signal v_net_64: std_logic_vector(7 downto 0);
  signal v_net_65: std_logic_vector(7 downto 0);
  signal v_net_66: std_logic_vector(7 downto 0);
  signal v_net_67: std_logic_vector(7 downto 0);
  signal v_net_68: std_logic_vector(7 downto 0);
  signal v_net_69: std_logic_vector(7 downto 0);
  signal v_net_70: std_logic_vector(7 downto 0);
  signal v_net_71: std_logic_vector(7 downto 0);
  signal v_net_72: std_logic_vector(7 downto 0);
  signal v_net_73: std_logic_vector(7 downto 0);
  signal v_net_74: std_logic_vector(7 downto 0);
  signal v_net_75: std_logic_vector(7 downto 0);
  signal v_net_76: std_logic_vector(7 downto 0);
  signal v_net_77: std_logic_vector(7 downto 0);
  signal v_net_78: std_logic_vector(7 downto 0);
  signal internal_n_datao: std_logic_vector(7 downto 0);
  signal internal_n_address: std_logic_vector(7 downto 0);
  signal internal_n_mread: std_logic;
  signal internal_n_mwrite: std_logic;
  constant v_net_79: std_logic_vector(4 downto 0) := "00001";
  constant v_net_80: std_logic_vector(7 downto 0) := "01111111";
  constant v_net_81: std_logic_vector(4 downto 0) := "00010";
  constant v_net_82: std_logic_vector(4 downto 0) := "00000";
  constant v_net_83: std_logic_vector(7 downto 0) := "00000010";
  constant v_net_84: std_logic_vector(7 downto 0) := "00000111";
  constant v_net_85: std_logic_vector(7 downto 0) := "00000001";
  constant v_net_86: std_logic_vector(7 downto 0) := "00000110";
  constant v_net_87: std_logic_vector(7 downto 0) := "00000101";
  constant v_net_88: std_logic_vector(7 downto 0) := "00000000";
  constant v_net_89: std_logic_vector(7 downto 0) := "00000100";
  constant v_net_90: std_logic_vector(7 downto 0) := "00000000";
  constant v_net_91: std_logic_vector(7 downto 0) := "00000011";
  constant v_net_92: std_logic_vector(7 downto 0) := "00000000";
  constant v_net_93: std_logic_vector(7 downto 0) := "00000001";

begin
adder: add8 
     port map (m_clock => m_clock, p_reset => m_clock, n_exe => v_adder_exe, n_sum => v_adder_sum, n_in1 => v_adder_in1, n_in2 => v_adder_in2);
  n_nextpc <= (v_net_73 or v_net_74) when ((v_net_63 or (v_net_60 or v_net_56)))='1'
  else "00000000" ;
  n_wop <= (n_op and v_net_80);
  v_proc_exe_set <= '1' when ((v_net_10 or v_net_7))='1'
  else '0' ;
  v_proc_exe_reset <= n_exe;
  v_net_0 <= (v_proc_exe_set or v_proc_exe_reset);
  v_proc_imm_set <= n_ift;
  v_proc_imm_reset <= '1' when ((v_net_9 or v_net_6))='1'
  else '0' ;
  v_net_1 <= (v_proc_imm_set or v_proc_imm_reset);
  v_proc_ift_set <= '1' when ((n_exe or v_net_3))='1'
  else '0' ;
  v_proc_ift_reset <= n_ift;
  v_net_2 <= (v_proc_ift_set or v_proc_ift_reset);
  v_adder_in1 <= (v_net_75 or v_net_76) when ((v_net_47 or (v_net_16 or n_ift)))='1'
  else "00000000" ;
  v_adder_in2 <= (v_net_77 or v_net_78) when ((v_net_46 or (v_net_15 or n_ift)))='1'
  else "00000000" ;
  v_adder_exe <= '1' when ((v_net_45 or (v_net_14 or n_ift)))='1'
  else '0' ;
  v_adder_p_reset <= p_reset;
  v_adder_m_clock <= m_clock;
  v_net_3 <= '1' when ((n_count = v_net_81))='1'
  else '0' ;
  v_net_4 <= '1' when ((n_count /= v_net_82))='1'
  else '0' ;
  v_net_5 <= (n_op(7));
  v_net_6 <= (n_imm and v_net_5);
  v_net_7 <= (n_imm and v_net_5);
  v_net_8 <= (n_imm and v_net_5);
  v_net_9 <= (n_imm and ( not v_net_5));
  v_net_10 <= (n_imm and ( not v_net_5));
  v_net_11 <= (n_imm and ( not v_net_5));
  v_net_12 <= (n_imm and ( not v_net_5));
  v_net_13 <= (n_imm and ( not v_net_5));
  v_net_14 <= (n_imm and ( not v_net_5));
  v_net_15 <= (n_imm and ( not v_net_5));
  v_net_16 <= (n_imm and ( not v_net_5));
  v_net_17 <= (n_imm and ( not v_net_5));
  v_net_18 <= n_exe when ((n_wop = v_net_83))='1'
  else '0' ;
  v_net_19 <= (n_exe and v_net_18);
  v_net_20 <= (n_exe and v_net_18);
  v_net_21 <= (n_exe and v_net_18);
  v_net_23 <= (n_exe and v_net_18);
  v_net_24 <= n_exe when ((n_wop = v_net_84))='1'
  else '0' ;
  v_net_25 <= (n_exe and v_net_24);
  v_net_26 <= (n_exe and v_net_24);
  v_net_27 <= (n_exe and v_net_24);
  v_net_29 <= (n_exe and v_net_24);
  v_net_30 <= n_exe when ((n_wop = v_net_85))='1'
  else '0' ;
  v_net_31 <= (n_exe and v_net_30);
  v_net_32 <= (n_exe and v_net_30);
  v_net_33 <= (n_exe and v_net_30);
  v_net_35 <= (n_exe and v_net_30);
  v_net_36 <= n_exe when ((n_wop = v_net_86))='1'
  else '0' ;
  v_net_37 <= (n_exe and v_net_36);
  v_net_39 <= (n_exe and v_net_36);
  v_net_40 <= n_exe when ((n_wop = v_net_87))='1'
  else '0' ;
  v_net_41 <= (n_exe and v_net_40);
  v_net_43 <= (n_exe and v_net_40);
  v_net_44 <= n_exe when ((n_wop = v_net_88))='1'
  else '0' ;
  v_net_45 <= (n_exe and v_net_44);
  v_net_46 <= (n_exe and v_net_44);
  v_net_47 <= (n_exe and v_net_44);
  v_net_48 <= (n_exe and v_net_44);
  v_net_50 <= (n_exe and v_net_44);
  v_net_51 <= n_exe when ((n_wop = v_net_89))='1'
  else '0' ;
  v_net_52 <= v_net_51;
  v_net_53 <= n_exe when ((n_acc = v_net_90))='1'
  else '0' ;
  v_net_54 <= v_net_53;
  v_net_55 <= (v_net_51 and v_net_53);
  v_net_56 <= (n_exe and v_net_55);
  v_net_58 <= (n_exe and v_net_55);
  v_net_59 <= n_exe when ((n_wop = v_net_91))='1'
  else '0' ;
  v_net_60 <= (n_exe and v_net_59);
  v_net_62 <= (n_exe and v_net_59);
  v_net_63 <= ((n_exe and ( not v_net_55)) and ( not v_net_59));
  v_net_64 <= n_nextpc when (n_exe)='1'
  else "00000000" ;
  v_net_65 <= v_adder_sum when ((v_net_17 or n_ift))='1'
  else "00000000" ;
  v_net_66 <= v_net_92 when (v_net_3)='1'
  else "00000000" ;
  v_net_67 <= n_datai when ((v_net_27 or v_net_13))='1'
  else "00000000" ;
  v_net_68 <= n_im when (v_net_8)='1'
  else "00000000" ;
  v_net_69 <= v_adder_sum when (v_net_48)='1'
  else "00000000" ;
  v_net_70 <= (n_acc and n_im) when (v_net_41)='1'
  else "00000000" ;
  v_net_71 <= (n_acc xor n_im) when (v_net_37)='1'
  else "00000000" ;
  v_net_72 <= n_datai when (v_net_33)='1'
  else "00000000" ;
  v_net_73 <= n_pc when (v_net_63)='1'
  else "00000000" ;
  v_net_74 <= n_im when ((v_net_60 or v_net_56))='1'
  else "00000000" ;
  v_net_75 <= n_acc when (v_net_47)='1'
  else "00000000" ;
  v_net_76 <= n_pc when ((v_net_16 or n_ift))='1'
  else "00000000" ;
  v_net_77 <= n_im when (v_net_46)='1'
  else "00000000" ;
  v_net_78 <= v_net_93 when ((v_net_15 or n_ift))='1'
  else "00000000" ;
  n_datao <= internal_n_datao;
  internal_n_datao <= n_acc;
  n_address <= internal_n_address;
  internal_n_address <= n_im when ((v_net_32 or (v_net_26 or v_net_21)))='1'
  else n_pc when ((v_net_12 or n_ift))='1'
  else "00000000" ;
  n_mread <= internal_n_mread;
  internal_n_mread <= '1' when ((v_net_31 or (v_net_25 or (v_net_11 or n_ift))))='1'
  else '0' ;
  n_mwrite <= internal_n_mwrite;
  internal_n_mwrite <= v_net_19;
p_0: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='0' then
    n_count <= "11111";
  elsif (v_net_4)='1' then
    n_count <= (n_count - v_net_79);
  end if;
 end if;
 end process;
p_1: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if (((n_exe or (v_net_17 or n_ift)) or v_net_3))='1' then
    n_pc <= ((v_net_64 or v_net_65) or v_net_66);
  end if;
 end if;
 end process;
p_2: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if (n_ift)='1' then
    n_op <= n_datai;
  end if;
 end if;
 end process;
p_3: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if (((v_net_27 or v_net_13) or v_net_8))='1' then
    n_im <= (v_net_67 or v_net_68);
  end if;
 end if;
 end process;
p_4: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='0' then
    n_acc <= "00000000";
  elsif ((((v_net_48 or v_net_41) or v_net_37) or v_net_33))='1' then
    n_acc <= (((v_net_69 or v_net_70) or v_net_71) or v_net_72);
  end if;
 end if;
 end process;
p_5: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='0' then
    n_ift <= '0';
  elsif (v_net_2)='1' then
    n_ift <= v_proc_ift_set;
  end if;
 end if;
 end process;
p_6: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='0' then
    n_imm <= '0';
  elsif (v_net_1)='1' then
    n_imm <= v_proc_imm_set;
  end if;
 end if;
 end process;
p_7: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='0' then
    n_exe <= '0';
  elsif (v_net_0)='1' then
    n_exe <= v_proc_exe_set;
  end if;
 end if;
 end process;
end RTL;



--Produced by NSL Core(version=20170110), IP ARCH, Inc. Wed May 24 18:20:39 2017
-- Licensed to :EVALUATION USER
