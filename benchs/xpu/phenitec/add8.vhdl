
--Produced by NSL Core(version=20170110), IP ARCH, Inc. Wed May 24 18:20:39 2017
-- Licensed to :EVALUATION USER
--- DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. ---
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity add8 is 
    port(p_reset: in std_logic; m_clock: in std_logic;
 n_exe: in std_logic;
 n_sum: out std_logic_vector(7 downto 0);
 n_in1: in std_logic_vector(7 downto 0);
 n_in2: in std_logic_vector(7 downto 0));
end add8;

architecture RTL of add8 is

 
  signal internal_n_sum: std_logic_vector(7 downto 0);

begin
  n_sum <= internal_n_sum;
  internal_n_sum <= (n_in1 + n_in2);
end RTL;



--Produced by NSL Core(version=20170110), IP ARCH, Inc. Wed May 24 18:20:39 2017
-- Licensed to :EVALUATION USER
