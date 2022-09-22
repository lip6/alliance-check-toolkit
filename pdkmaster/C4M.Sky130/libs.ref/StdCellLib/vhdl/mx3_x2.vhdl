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
--  VHDL data flow description generated from `mx3_x2`
--  

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity Declaration

ENTITY mx3_x2 IS
  PORT (
            q : out   STD_LOGIC;
         cmd0 : in    STD_LOGIC;
         cmd1 : in    STD_LOGIC;
           i0 : in    STD_LOGIC;
           i1 : in    STD_LOGIC;
           i2 : in    STD_LOGIC
  );
END mx3_x2;

-- Architecture Declaration

ARCHITECTURE RTL OF mx3_x2 IS
  SIGNAL v_net4 : STD_LOGIC;
  SIGNAL v_net3 : STD_LOGIC;
  SIGNAL v_net5 : STD_LOGIC;

BEGIN


  v_net5 <= ((not (i0) and not (cmd0)) or (not (cmd1) and not (i2) and not (v_net4))
or (not (v_net3) and not (i1) and not (v_net4)));
  v_net3 <= not (cmd1);
  v_net4 <= not (cmd0);

  q <= not (v_net5);

END;
