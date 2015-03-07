-- Produced by NSL Core(version=20141105), IP ARCH, Inc. Thu Mar 05 14:16:41 2015
-- Licensed to :EVALUATION USER
--- DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. ---
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity alu16 is 
    port(p_reset: in std_logic; m_clock: in std_logic;
 n_exe: in std_logic;
 n_q: out std_logic_vector(15 downto 0);
 n_f: in std_logic_vector(5 downto 0);
 n_b: in std_logic_vector(15 downto 0);
 n_a: in std_logic_vector(15 downto 0));
end alu16;

architecture RTL of alu16 is

 

component cla16 
    port(p_reset: in std_logic; m_clock: in std_logic;
 n_do: in std_logic;
 n_out: out std_logic_vector(15 downto 0);
 n_in2: in std_logic_vector(15 downto 0);
 n_in1: in std_logic_vector(15 downto 0);
 n_cin: in std_logic);
end component;

  signal v_cla_cin: std_logic;
  signal v_cla_in1: std_logic_vector(15 downto 0);
  signal v_cla_in2: std_logic_vector(15 downto 0);
  signal v_cla_out: std_logic_vector(15 downto 0);
  signal v_cla_do: std_logic;
  signal v_net_68: std_logic;
  signal v_net_69: std_logic;
  signal v_net_70: std_logic;
  signal v_net_71: std_logic;
  signal v_net_72: std_logic;
  signal v_net_73: std_logic;
  signal internal_n_q: std_logic_vector(15 downto 0);
  constant v_net_74: std_logic_vector(5 downto 0) := "000110";
  constant v_net_75: std_logic_vector(5 downto 0) := "000100";
  constant v_net_76: std_logic_vector(5 downto 0) := "000011";
  constant v_net_77: std_logic_vector(5 downto 0) := "000001";
  constant v_net_78: std_logic_vector(5 downto 0) := "000000";
  constant v_net_79: std_logic_vector(14 downto 0) := "000000000000000";

begin
cla: cla16 
     port map (p_reset => p_reset, m_clock => m_clock, n_do => v_cla_do, n_out => v_cla_out, n_in2 => v_cla_in2, n_in1 => v_cla_in1, n_cin => v_cla_cin);
  v_cla_cin <= '0' when ((n_exe and v_net_73))='1'
  else '1' when ((n_exe and v_net_70))='1'
  else '0' ;
  v_cla_in1 <= n_a when ((n_exe and v_net_73))='1'
  else n_a when ((n_exe and v_net_70))='1'
  else "0000000000000000" ;
  v_cla_in2 <= n_b when ((n_exe and v_net_73))='1'
  else ( not n_b) when ((n_exe and v_net_70))='1'
  else "0000000000000000" ;
  v_cla_do <= '1' when ((n_exe and v_net_73))='1'
  else '1' when ((n_exe and v_net_70))='1'
  else '0' ;
  v_net_68 <= n_exe when ((n_f = v_net_74))
  else '0' ;
  v_net_69 <= n_exe when ((n_f = v_net_75))
  else '0' ;
  v_net_70 <= n_exe when ((n_f = v_net_76))
  else '0' ;
  v_net_71 <= ((((n_a(15)) and ( not (n_b(15)))) or (((v_cla_out(15)) and ( not (n_a(15)))) and ( not (n_b(15))))) or (((v_cla_out(15)) and (n_a(15))) and (n_b(15))));
  v_net_72 <= n_exe when ((n_f = v_net_77))
  else '0' ;
  v_net_73 <= n_exe when ((n_f = v_net_78))
  else '0' ;
  n_q <= internal_n_q;
  internal_n_q <= v_cla_out when ((n_exe and v_net_73))='1'
  else (n_a and n_b) when ((n_exe and v_net_72))='1'
  else (v_net_79 & v_net_71) when ((n_exe and v_net_70))='1'
  else ( not n_a) when ((n_exe and v_net_69))='1'
  else ('0' & (n_a(15 downto 1))) when ((n_exe and v_net_68))='1'
  else "0000000000000000" ;
end RTL;


-- Produced by NSL Core(version=20141105), IP ARCH, Inc. Thu Mar 05 14:16:41 2015
-- Licensed to :EVALUATION USER
