
--Produced by NSL Core(version=20230222), IP ARCH, Inc. Mon May 13 11:34:35 2024
-- Licensed to :EVALUATION USER
--- DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. ---
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity adder is 
    port(p_reset: in std_logic; m_clock: in std_logic;
 f: out std_logic_vector(7 downto 0);
 a: in std_logic_vector(7 downto 0);
 b: in std_logic_vector(7 downto 0));
end adder;

architecture RTL of adder is

 
  signal r: std_logic_vector(7 downto 0);
  signal internal_f: std_logic_vector(7 downto 0);

begin
  f <= internal_f;
  internal_f <= r;
p_0: process(m_clock)
begin
if m_clock'event and m_clock='1' then
  if p_reset='1' then
    r <= "00000000";
  else     r <= (a and b);
  end if;
 end if;
 end process;
end RTL;



--Produced by NSL Core(version=20230222), IP ARCH, Inc. Mon May 13 11:34:35 2024
-- Licensed to :EVALUATION USER
