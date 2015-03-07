-- Produced by NSL Core(version=20141105), IP ARCH, Inc. Thu Mar 05 14:16:40 2015
-- Licensed to :EVALUATION USER
--- DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. ---
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity type_dec is 
    port(p_reset: in std_logic; m_clock: in std_logic;
 n_dec: in std_logic;
 n_ctype: out std_logic;
 n_rtype: out std_logic;
 n_itype: out std_logic;
 n_op: in std_logic_vector(3 downto 0));
end type_dec;

architecture RTL of type_dec is

 
  signal v_net_0: std_logic;
  signal v_net_1: std_logic;
  signal internal_n_itype: std_logic;
  signal internal_n_rtype: std_logic;
  signal internal_n_ctype: std_logic;
  constant v_net_2: std_logic_vector(3 downto 0) := "0001";
  constant v_net_3: std_logic_vector(3 downto 0) := "0000";

begin
  v_net_0 <= n_dec when ((n_op = v_net_2))
  else '0' ;
  v_net_1 <= n_dec when ((n_op = v_net_3))
  else '0' ;
  n_itype <= internal_n_itype;
  internal_n_itype <= '1' when (((n_dec and ( not v_net_0)) and ( not v_net_1)))='1'
  else '0' ;
  n_rtype <= internal_n_rtype;
  internal_n_rtype <= '1' when ((n_dec and v_net_1))='1'
  else '0' ;
  n_ctype <= internal_n_ctype;
  internal_n_ctype <= '1' when ((n_dec and v_net_0))='1'
  else '0' ;
end RTL;


-- Produced by NSL Core(version=20141105), IP ARCH, Inc. Thu Mar 05 14:16:40 2015
-- Licensed to :EVALUATION USER
