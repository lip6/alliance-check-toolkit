--  
--  Avertec Release v3.4p5 (64 bits on Linux 6.7.12+bpo-amd64)
--  [AVT_only] host: fsdev
--  [AVT_only] arch: x86_64
--  [AVT_only] path: /opt/tasyag-3.4p5/bin/avt_shell
--  argv: 
--  
--  User: verhaegs
--  Generation date Tue Sep 24 13:35:35 2024
--  
--  VHDL data flow description generated from `or21nand_x0`
--  

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity Declaration

ENTITY or21nand_x0 IS
  PORT (
         nq : out   STD_LOGIC;
         i0 : in    STD_LOGIC;
         i1 : in    STD_LOGIC;
         i2 : in    STD_LOGIC
  );
END or21nand_x0;

-- Architecture Declaration

ARCHITECTURE RTL OF or21nand_x0 IS

BEGIN


  nq <= (not (i2) or (not (i1) and not (i0)));

END;
