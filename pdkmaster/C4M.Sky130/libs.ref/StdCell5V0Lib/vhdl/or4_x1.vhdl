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
--  VHDL data flow description generated from `or4_x1`
--  

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity Declaration

ENTITY or4_x1 IS
  PORT (
          q : out   STD_LOGIC;
         i0 : in    STD_LOGIC;
         i1 : in    STD_LOGIC;
         i2 : in    STD_LOGIC;
         i3 : in    STD_LOGIC
  );
END or4_x1;

-- Architecture Declaration

ARCHITECTURE RTL OF or4_x1 IS
  SIGNAL nq : STD_LOGIC;

BEGIN


  nq <= (not (i0) and not (i1) and not (i2) and not (i3));

  q <= not (nq);

END;
