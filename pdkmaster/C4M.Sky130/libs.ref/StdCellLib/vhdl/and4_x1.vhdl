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
--  VHDL data flow description generated from `and4_x1`
--  

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity Declaration

ENTITY and4_x1 IS
  PORT (
          q : out   STD_LOGIC;
         i0 : in    STD_LOGIC;
         i1 : in    STD_LOGIC;
         i2 : in    STD_LOGIC;
         i3 : in    STD_LOGIC
  );
END and4_x1;

-- Architecture Declaration

ARCHITECTURE RTL OF and4_x1 IS
  SIGNAL nq : STD_LOGIC;

BEGIN


  nq <= (not (i3) or not (i2) or not (i1) or not (i0));

  q <= not (nq);

END;
