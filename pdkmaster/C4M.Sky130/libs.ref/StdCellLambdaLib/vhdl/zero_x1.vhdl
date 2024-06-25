--  
--  Avertec Release v3.4p5 (64 bits on Linux 6.6.13+bpo-amd64)
--  [AVT_only] host: fsdev
--  [AVT_only] arch: x86_64
--  [AVT_only] path: /opt/tasyag-3.4p5/bin/avt_shell
--  argv: 
--  
--  User: verhaegs
--  Generation date Wed May 29 11:26:51 2024
--  
--  VHDL data flow description generated from `zero_x1`
--  

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity Declaration

ENTITY zero_x1 IS
  PORT (
    zero : inout STD_LOGIC
  );
END zero_x1;

-- Architecture Declaration

ARCHITECTURE RTL OF zero_x1 IS
  SIGNAL one : STD_LOGIC;

BEGIN


BUX0: PROCESS (zero)
BEGIN
  IF zero = '0' THEN
    one <= '1';
  ELSE
    one <= 'Z';
  END IF;
END PROCESS;

BUS0: PROCESS (one)
BEGIN
  IF one = '1' THEN
    zero <= '0';
  ELSE
    zero <= 'Z';
  END IF;
END PROCESS;

END;
