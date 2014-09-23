-- Produced by NSL Core(version=20140312), IP ARCH, Inc. Thu Aug 14 16:10:25 2014
-- Licensed to :EVALUATION USER
--- DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. ---
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity reg4 is 
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
end reg4;

architecture RTL of reg4 is

 
  signal n_r0: std_logic_vector(15 downto 0);
  signal n_r1: std_logic_vector(15 downto 0);
  signal n_r2: std_logic_vector(15 downto 0);
  signal n_r3: std_logic_vector(15 downto 0);
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
  signal internal_n_regouta: std_logic_vector(15 downto 0);
  signal internal_n_regoutb: std_logic_vector(15 downto 0);
  constant v_net_95: std_logic_vector(1 downto 0) := "11";
  constant v_net_96: std_logic_vector(1 downto 0) := "10";
  constant v_net_97: std_logic_vector(1 downto 0) := "01";
  constant v_net_98: std_logic_vector(1 downto 0) := "00";
  constant v_net_99: std_logic_vector(1 downto 0) := "11";
  constant v_net_100: std_logic_vector(1 downto 0) := "10";
  constant v_net_101: std_logic_vector(1 downto 0) := "01";
  constant v_net_102: std_logic_vector(1 downto 0) := "00";
  constant v_net_103: std_logic_vector(1 downto 0) := "11";
  constant v_net_104: std_logic_vector(1 downto 0) := "10";
  constant v_net_105: std_logic_vector(1 downto 0) := "01";
  constant v_net_106: std_logic_vector(1 downto 0) := "00";

begin
  v_net_83 <= n_write when ((n_n_regin = v_net_95))
  else '0' ;
  v_net_84 <= n_write when ((n_n_regin = v_net_96))
  else '0' ;
  v_net_85 <= n_write when ((n_n_regin = v_net_97))
  else '0' ;
  v_net_86 <= n_write when ((n_n_regin = v_net_98))
  else '0' ;
  v_net_87 <= n_reada when ((n_n_regouta = v_net_99))
  else '0' ;
  v_net_88 <= n_reada when ((n_n_regouta = v_net_100))
  else '0' ;
  v_net_89 <= n_reada when ((n_n_regouta = v_net_101))
  else '0' ;
  v_net_90 <= n_reada when ((n_n_regouta = v_net_102))
  else '0' ;
  v_net_91 <= n_readb when ((n_n_regoutb = v_net_103))
  else '0' ;
  v_net_92 <= n_readb when ((n_n_regoutb = v_net_104))
  else '0' ;
  v_net_93 <= n_readb when ((n_n_regoutb = v_net_105))
  else '0' ;
  v_net_94 <= n_readb when ((n_n_regoutb = v_net_106))
  else '0' ;
  n_regouta <= internal_n_regouta;
  internal_n_regouta <= n_r0 when ((n_reada and v_net_90))='1'
  else n_r1 when ((n_reada and v_net_89))='1'
  else n_r2 when ((n_reada and v_net_88))='1'
  else n_r3 when ((n_reada and v_net_87))='1'
  else "0000000000000000" ;
  n_regoutb <= internal_n_regoutb;
  internal_n_regoutb <= n_r0 when ((n_readb and v_net_94))='1'
  else n_r1 when ((n_readb and v_net_93))='1'
  else n_r2 when ((n_readb and v_net_92))='1'
  else n_r3 when ((n_readb and v_net_91))='1'
  else "0000000000000000" ;
p_22: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if ((n_write and v_net_86))='1' then
    n_r0 <= n_regin;
  end if;
end if;
end process;
p_23: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if ((n_write and v_net_85))='1' then
    n_r1 <= n_regin;
  end if;
end if;
end process;
p_24: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if ((n_write and v_net_84))='1' then
    n_r2 <= n_regin;
  end if;
end if;
end process;
p_25: process(m_clock)
begin
if m_clock'event and m_clock='1' then

if ((n_write and v_net_83))='1' then
    n_r3 <= n_regin;
  end if;
end if;
end process;
end RTL;


-- Produced by NSL Core(version=20140312), IP ARCH, Inc. Thu Aug 14 16:10:25 2014
-- Licensed to :EVALUATION USER
