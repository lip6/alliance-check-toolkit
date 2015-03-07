-- Produced by NSL Core(version=20141105), IP ARCH, Inc. Thu Mar 05 14:16:42 2015
-- Licensed to :EVALUATION USER
--- DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. ---
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity inc16 is 
    port(p_reset: in std_logic; m_clock: in std_logic;
 n_do: in std_logic;
 n_out: out std_logic_vector(15 downto 0);
 n_in: in std_logic_vector(15 downto 0));
end inc16;

architecture RTL of inc16 is

 
  signal internal_n_out: std_logic_vector(15 downto 0);
  constant v_net_107: std_logic_vector(15 downto 0) := "0000000000000001";

begin
  n_out <= internal_n_out;
  internal_n_out <= (n_in + v_net_107) when (n_do)='1'
  else "0000000000000000" ;
end RTL;


-- Produced by NSL Core(version=20141105), IP ARCH, Inc. Thu Mar 05 14:16:42 2015
-- Licensed to :EVALUATION USER
