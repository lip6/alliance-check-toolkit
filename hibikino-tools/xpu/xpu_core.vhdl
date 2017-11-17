-- Produced by NSL Core(version=20160829), IP ARCH, Inc. Tue Mar  7 23:45:47 2017
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
 n_address: out std_logic_vector(3 downto 0);
 n_datao: out std_logic_vector(3 downto 0);
 n_datai: in std_logic_vector(3 downto 0));
end xpu_core;

architecture RTL of xpu_core is

 
  signal n_count: std_logic_vector(4 downto 0);
  signal n_pc: std_logic_vector(3 downto 0);
  signal n_op: std_logic_vector(3 downto 0);
  signal n_im: std_logic_vector(3 downto 0);
  signal n_acc: std_logic_vector(3 downto 0);
  signal n_ift: std_logic;
  signal n_imm: std_logic;
  signal n_exe: std_logic;
  signal n_nextpc: std_logic_vector(3 downto 0);
  signal v_proc_exe_set: std_logic;
  signal v_proc_exe_reset: std_logic;
  signal v_net_0: std_logic;
  signal v_proc_imm_set: std_logic;
  signal v_proc_imm_reset: std_logic;
  signal v_net_1: std_logic;
  signal v_proc_ift_set: std_logic;
  signal v_proc_ift_reset: std_logic;
  signal v_net_2: std_logic;
  signal v_net_3: std_logic;
  signal v_net_4: std_logic;
  signal v_net_5: std_logic;
  signal v_net_6: std_logic;
  signal v_net_7: std_logic;
  signal v_net_8: std_logic;
  signal v_net_10: std_logic;
  signal v_net_11: std_logic;
  signal v_net_12: std_logic;
  signal v_net_13: std_logic;
  signal v_net_14: std_logic;
  signal v_net_16: std_logic;
  signal v_net_17: std_logic;
  signal v_net_18: std_logic;
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
  signal v_net_32: std_logic;
  signal v_net_33: std_logic;
  signal v_net_34: std_logic_vector(3 downto 0);
  signal v_net_35: std_logic_vector(3 downto 0);
  signal v_net_36: std_logic_vector(3 downto 0);
  signal v_net_37: std_logic_vector(3 downto 0);
  signal v_net_38: std_logic_vector(3 downto 0);
  signal v_net_39: std_logic_vector(3 downto 0);
  signal v_net_40: std_logic_vector(3 downto 0);
  signal internal_n_datao: std_logic_vector(3 downto 0);
  signal internal_n_address: std_logic_vector(3 downto 0);
  signal internal_n_mread: std_logic;
  signal internal_n_mwrite: std_logic;
  constant v_net_41: std_logic_vector(4 downto 0) := "00001";
  constant v_net_42: std_logic_vector(4 downto 0) := "00010";
  constant v_net_43: std_logic_vector(4 downto 0) := "00000";
  constant v_net_44: std_logic_vector(3 downto 0) := "0010";
  constant v_net_45: std_logic_vector(3 downto 0) := "0001";
  constant v_net_46: std_logic_vector(3 downto 0) := "0000";
  constant v_net_47: std_logic_vector(3 downto 0) := "0100";
  constant v_net_48: std_logic_vector(3 downto 0) := "0000";
  constant v_net_49: std_logic_vector(3 downto 0) := "0011";
  constant v_net_50: std_logic_vector(3 downto 0) := "0001";
  constant v_net_51: std_logic_vector(3 downto 0) := "0000";

begin
  n_nextpc <= (v_net_39 or v_net_40) when ((v_net_33 or (v_net_30 or v_net_26)))='1'
  else "0000" ;
  v_proc_exe_set <= n_imm;
  v_proc_exe_reset <= n_exe;
  v_net_0 <= (v_proc_exe_set or v_proc_exe_reset);
  v_proc_imm_set <= n_ift;
  v_proc_imm_reset <= n_imm;
  v_net_1 <= (v_proc_imm_set or v_proc_imm_reset);
  v_proc_ift_set <= '1' when ((n_exe or v_net_3))='1'
  else '0' ;
  v_proc_ift_reset <= n_ift;
  v_net_2 <= (v_proc_ift_set or v_proc_ift_reset);
  v_net_3 <= '1' when ((n_count = v_net_42))='1'
  else '0' ;
  v_net_4 <= '1' when ((n_count /= v_net_43))='1'
  else '0' ;
  v_net_5 <= n_exe when ((n_op = v_net_44))='1'
  else '0' ;
  v_net_6 <= (n_exe and v_net_5);
  v_net_7 <= (n_exe and v_net_5);
  v_net_8 <= (n_exe and v_net_5);
  v_net_10 <= (n_exe and v_net_5);
  v_net_11 <= n_exe when ((n_op = v_net_45))='1'
  else '0' ;
  v_net_12 <= (n_exe and v_net_11);
  v_net_13 <= (n_exe and v_net_11);
  v_net_14 <= (n_exe and v_net_11);
  v_net_16 <= (n_exe and v_net_11);
  v_net_17 <= n_exe when ((n_op = v_net_46))='1'
  else '0' ;
  v_net_18 <= (n_exe and v_net_17);
  v_net_20 <= (n_exe and v_net_17);
  v_net_21 <= n_exe when ((n_op = v_net_47))='1'
  else '0' ;
  v_net_22 <= v_net_21;
  v_net_23 <= n_exe when ((n_acc = v_net_48))='1'
  else '0' ;
  v_net_24 <= v_net_23;
  v_net_25 <= (v_net_21 and v_net_23);
  v_net_26 <= (n_exe and v_net_25);
  v_net_28 <= (n_exe and v_net_25);
  v_net_29 <= n_exe when ((n_op = v_net_49))='1'
  else '0' ;
  v_net_30 <= (n_exe and v_net_29);
  v_net_32 <= (n_exe and v_net_29);
  v_net_33 <= ((n_exe and ( not v_net_25)) and ( not v_net_29));
  v_net_34 <= n_nextpc when (n_exe)='1'
  else "0000" ;
  v_net_35 <= (n_pc + v_net_50) when ((n_imm or n_ift))='1'
  else "0000" ;
  v_net_36 <= v_net_51 when (v_net_3)='1'
  else "0000" ;
  v_net_37 <= (n_acc + n_im) when (v_net_18)='1'
  else "0000" ;
  v_net_38 <= n_datai when (v_net_14)='1'
  else "0000" ;
  v_net_39 <= n_pc when (v_net_33)='1'
  else "0000" ;
  v_net_40 <= n_im when ((v_net_30 or v_net_26))='1'
  else "0000" ;
  n_datao <= internal_n_datao;
  internal_n_datao <= n_acc;
  n_address <= internal_n_address;
  internal_n_address <= n_im when ((v_net_13 or v_net_8))='1'
  else n_pc when ((n_imm or n_ift))='1'
  else "0000" ;
  n_mread <= internal_n_mread;
  internal_n_mread <= '1' when ((v_net_12 or (n_imm or n_ift)))='1'
  else '0' ;
  n_mwrite <= internal_n_mwrite;
  internal_n_mwrite <= v_net_6;
p_0: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='0' then
    n_count <= "11110";
  elsif (v_net_4)='1' then
    n_count <= (n_count - v_net_41);
  end if;
 end if;
 end process;
p_1: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if (((n_exe or (n_imm or n_ift)) or v_net_3))='1' then
    n_pc <= ((v_net_34 or v_net_35) or v_net_36);
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

if (n_imm)='1' then
    n_im <= n_datai;
  end if;
 end if;
 end process;
p_4: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='0' then
    n_acc <= "0000";
  elsif ((v_net_18 or v_net_14))='1' then
    n_acc <= (v_net_37 or v_net_38);
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


-- Produced by NSL Core(version=20160829), IP ARCH, Inc. Tue Mar  7 23:45:47 2017
-- Licensed to :EVALUATION USER
