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
--  VHDL data flow description generated from `nor2_x0`
--  

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity Declaration

ENTITY nor2_x0 IS
  PORT (
         nq : out   STD_LOGIC;
         i0 : in    STD_LOGIC;
         i1 : in    STD_LOGIC
  );
END nor2_x0;

-- Architecture Declaration

ARCHITECTURE RTL OF nor2_x0 IS

BEGIN


  nq <= (not (i1) and not (i0));

END;
