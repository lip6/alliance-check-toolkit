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
--  VHDL data flow description generated from `nsnrlatch_x1`
--  

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity Declaration

ENTITY nsnrlatch_x1 IS
  PORT (
           nq : inout STD_LOGIC;
            q : inout STD_LOGIC;
         nrst : in    STD_LOGIC;
         nset : in    STD_LOGIC
  );
END nsnrlatch_x1;

-- Architecture Declaration

ARCHITECTURE RTL OF nsnrlatch_x1 IS

BEGIN


  q <= (not (nset) or not (nq));
  nq <= (not (q) or not (nrst));

END;
