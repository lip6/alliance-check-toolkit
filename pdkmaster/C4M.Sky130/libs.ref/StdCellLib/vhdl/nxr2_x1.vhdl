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
--  VHDL data flow description generated from `nxr2_x1`
--  

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity Declaration

ENTITY nxr2_x1 IS
  PORT (
         nq : out   STD_LOGIC;
         i0 : in    STD_LOGIC;
         i1 : in    STD_LOGIC
  );
END nxr2_x1;

-- Architecture Declaration

ARCHITECTURE RTL OF nxr2_x1 IS
  SIGNAL v_net3 : STD_LOGIC;
  SIGNAL v_net0 : STD_LOGIC;

BEGIN


  v_net0 <= not (i0);
  v_net3 <= not (i1);

  nq <= ((not (i1) and not (i0)) or (not (i1) and not (v_net3)) or (not (v_net0)
and not (i0)) or (not (v_net0) and not (v_net3)));

END;
