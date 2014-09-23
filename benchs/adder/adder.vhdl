-- Produced by NSL Core(version=20140312), IP ARCH, Inc. Fri Sep  5 15:24:23 2014
-- Licensed to :EVALUATION USER
--- DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. ---
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity adder is 
    port(p_reset: in std_logic; m_clock: in std_logic;
 f: out std_logic_vector(3 downto 0);
 a: in std_logic_vector(3 downto 0);
 b: in std_logic_vector(3 downto 0));
end adder;

architecture RTL of adder is

 
  signal r1: std_logic_vector(3 downto 0);
  signal r2: std_logic_vector(3 downto 0);
  signal r3: std_logic_vector(3 downto 0);
  signal r4: std_logic_vector(3 downto 0);
  signal r5: std_logic_vector(3 downto 0);
  signal r6: std_logic_vector(3 downto 0);
  signal r7: std_logic_vector(3 downto 0);
  signal r8: std_logic_vector(3 downto 0);
  signal r9: std_logic_vector(3 downto 0);
  signal internal_f: std_logic_vector(3 downto 0);

begin
  f <= internal_f;
  internal_f <= r9;
p_0: process(m_clock)
begin
if m_clock'event and m_clock='1' then
    r1 <= (a + b);
end if;
end process;
p_1: process(m_clock)
begin
if m_clock'event and m_clock='1' then
    r2 <= r1;
end if;
end process;
p_2: process(m_clock)
begin
if m_clock'event and m_clock='1' then
    r3 <= r2;
end if;
end process;
p_3: process(m_clock)
begin
if m_clock'event and m_clock='1' then
    r4 <= r3;
end if;
end process;
p_4: process(m_clock)
begin
if m_clock'event and m_clock='1' then
    r5 <= r4;
end if;
end process;
p_5: process(m_clock)
begin
if m_clock'event and m_clock='1' then
    r6 <= r5;
end if;
end process;
p_6: process(m_clock)
begin
if m_clock'event and m_clock='1' then
    r7 <= r6;
end if;
end process;
p_7: process(m_clock)
begin
if m_clock'event and m_clock='1' then
    r8 <= r7;
end if;
end process;
p_8: process(m_clock)
begin
if m_clock'event and m_clock='1' then
    r9 <= r8;
end if;
end process;
end RTL;


-- Produced by NSL Core(version=20140312), IP ARCH, Inc. Fri Sep  5 15:24:23 2014
-- Licensed to :EVALUATION USER
