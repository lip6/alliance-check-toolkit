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
--  VHDL data flow description generated from `buf_x2`
--  

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity Declaration

ENTITY buf_x2 IS
  PORT (
         i : in    STD_LOGIC;
         q : out   STD_LOGIC
  );
END buf_x2;

-- Architecture Declaration

ARCHITECTURE RTL OF buf_x2 IS
  SIGNAL v_i_n : STD_LOGIC;

BEGIN


  v_i_n <= not (i);

  q <= not (v_i_n);

END;
