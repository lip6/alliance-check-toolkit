--  
--  Avertec Release v3.4p5 (64 bits on Linux 5.10.0-15-amd64)
--  [AVT_only] host: fsdev
--  [AVT_only] arch: x86_64
--  [AVT_only] path: /opt/tasyag-3.4p5/bin/avt_shell
--  argv: 
--  
--  User: verhaegs
--  Generation date Mon Jul 25 16:04:02 2022
--  
--  VHDL data flow description generated from `inv_x0`
--  

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity Declaration

ENTITY inv_x0 IS
  PORT (
          i : in    STD_LOGIC;
         nq : out   STD_LOGIC
  );
END inv_x0;

-- Architecture Declaration

ARCHITECTURE RTL OF inv_x0 IS

BEGIN


  nq <= not (i);

END;
