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
--  VHDL data flow description generated from `sff1_x4`
--  

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity Declaration

ENTITY sff1_x4 IS
  PORT (
        ck : in    STD_LOGIC;
         i : in    STD_LOGIC;
         q : out   STD_LOGIC
  );
END sff1_x4;

-- Architecture Declaration

ARCHITECTURE RTL OF sff1_x4 IS
  SIGNAL sff_m : STD_LOGIC;
  SIGNAL u : STD_LOGIC;
  SIGNAL ck_delayed : STD_LOGIC;

BEGIN


  ck'delayed <= 'U';
  u <= not (i);

REG0: PROCESS (ck, u)
BEGIN
  IF (ck = '1' and ck'EVENT) THEN
    sff_m <= not (u);
  END IF;
END PROCESS;

  q <= sff_m;

END;
