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
--  VHDL data flow description generated from `a3_x2`
--  

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity Declaration

ENTITY a3_x2 IS
  PORT (
          q : out   STD_LOGIC;
         i0 : in    STD_LOGIC;
         i1 : in    STD_LOGIC;
         i2 : in    STD_LOGIC
  );
END a3_x2;

-- Architecture Declaration

ARCHITECTURE RTL OF a3_x2 IS
  SIGNAL v_net1 : STD_LOGIC;

BEGIN


  v_net1 <= (not (i2) or not (i1) or not (i0));

  q <= not (v_net1);

END;
