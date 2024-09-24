--  
--  Avertec Release v3.4p5 (64 bits on Linux 5.10.0-0.bpo.9-amd64)
--  [AVT_only] host: fsdev
--  [AVT_only] arch: x86_64
--  [AVT_only] path: /opt/tasyag-3.4p5/bin/avt_shell
--  argv: 
--  
--  User: verhaegs
--  Generation date Thu Feb 10 12:59:02 2022
--  
--  VHDL data flow description generated from `zero_x1`
--  

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity Declaration

ENTITY zero_x1 IS
  PORT (
    zero : out STD_LOGIC
  );
END zero_x1;

-- Architecture Declaration

ARCHITECTURE RTL OF zero_x1 IS
  SIGNAL one : STD_LOGIC;

BEGIN

  zero <= '0';

END;
