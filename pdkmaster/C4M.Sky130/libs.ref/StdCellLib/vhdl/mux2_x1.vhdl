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
--  VHDL data flow description generated from `mux2_x1`
--  

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity Declaration

ENTITY mux2_x1 IS
  PORT (
          i0 : in    STD_LOGIC;
          i1 : in    STD_LOGIC;
         cmd : in    STD_LOGIC;
           q : out   STD_LOGIC
  );
END mux2_x1;

-- Architecture Declaration

ARCHITECTURE RTL OF mux2_x1 IS
  SIGNAL v_q_n : STD_LOGIC;
  SIGNAL cmd_n : STD_LOGIC;

BEGIN


  cmd_n <= not (cmd);
  v_q_n <= ((not (cmd_n) and not (i1)) or (not (cmd) and not (i0)));

  q <= not (v_q_n);

END;
