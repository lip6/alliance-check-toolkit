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
--  VHDL data flow description generated from `dff_x1`
--  

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity Declaration

ENTITY dff_x1 IS
  PORT (
           i : in    STD_LOGIC;
         clk : in    STD_LOGIC;
           q : out   STD_LOGIC
  );
END dff_x1;

-- Architecture Declaration

ARCHITECTURE RTL OF dff_x1 IS
  SIGNAL v_dff_m : STD_LOGIC;
  SIGNAL v_dff_s : STD_LOGIC;
  SIGNAL v_y : STD_LOGIC;
  SIGNAL v_u : STD_LOGIC;
  SIGNAL v_clk_buf : STD_LOGIC;
  SIGNAL v_clk_n : STD_LOGIC;

BEGIN


  v_clk_n <= not (clk);
  v_clk_buf <= not (v_clk_n);
  v_u <= not (i);
  v_y <= not (v_dff_m);

REG0: PROCESS (v_clk_n, v_dff_m)
BEGIN
  IF v_clk_n = '0' THEN
    v_dff_s <= not (v_dff_m);
  END IF;
END PROCESS;

REG1: PROCESS (v_clk_n, v_u)
BEGIN
  IF v_clk_n = '1' THEN
    v_dff_m <= not (v_u);
  END IF;
END PROCESS;

  q <= not (v_dff_s);

END;
