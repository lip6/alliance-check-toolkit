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
--  VHDL data flow description generated from `o4_x2`
--  

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity Declaration

ENTITY o4_x2 IS
  PORT (
          q : out   STD_LOGIC;
         i0 : in    STD_LOGIC;
         i1 : in    STD_LOGIC;
         i2 : in    STD_LOGIC;
         i3 : in    STD_LOGIC
  );
END o4_x2;

-- Architecture Declaration

ARCHITECTURE RTL OF o4_x2 IS
  SIGNAL v_net2 : STD_LOGIC;

BEGIN


  v_net2 <= (not (i3) and not (i1) and not (i0) and not (i2));

  q <= not (v_net2);

END;
