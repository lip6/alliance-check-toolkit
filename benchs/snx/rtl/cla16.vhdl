-- Produced by NSL Core(version=20141105), IP ARCH, Inc. Thu Mar 05 14:16:41 2015
-- Licensed to :EVALUATION USER
--- DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. ---
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity cla16 is 
    port(p_reset: in std_logic; m_clock: in std_logic;
 n_do: in std_logic;
 n_out: out std_logic_vector(15 downto 0);
 n_in2: in std_logic_vector(15 downto 0);
 n_in1: in std_logic_vector(15 downto 0);
 n_cin: in std_logic);
end cla16;

architecture RTL of cla16 is

 
  signal v_net_80: std_logic;
  signal internal_n_out: std_logic_vector(15 downto 0);
  constant v_net_81: std_logic_vector(14 downto 0) := "000000000000000";

begin
  v_net_80 <= n_cin;
  n_out <= internal_n_out;
  internal_n_out <= ((n_in1 + n_in2) + (v_net_81 & v_net_80)) when (n_do)='1'
  else "0000000000000000" ;
end RTL;


-- Produced by NSL Core(version=20141105), IP ARCH, Inc. Thu Mar 05 14:16:41 2015
-- Licensed to :EVALUATION USER
