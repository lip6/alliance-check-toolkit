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
--  VHDL data flow description generated from `decap_w0`
--  

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity Declaration

ENTITY decap_w0 IS
  PORT (

  );
END decap_w0;

-- Architecture Declaration

ARCHITECTURE RTL OF decap_w0 IS
  SIGNAL zero : STD_LOGIC;
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

BUX1: PROCESS (one)
BEGIN
  IF one = '1' THEN
    zero <= '0';
  ELSE
    zero <= 'Z';
  END IF;
END PROCESS;

END;
