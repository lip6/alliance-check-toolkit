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
--  VHDL data flow description generated from `inv_x4`
--  

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity Declaration

ENTITY inv_x4 IS
  PORT (
          i : in    STD_LOGIC;
         nq : out   STD_LOGIC
  );
END inv_x4;

-- Architecture Declaration

ARCHITECTURE RTL OF inv_x4 IS

BEGIN


  nq <= not (i);

END;
