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
--  VHDL data flow description generated from `nsnrlatch_x0`
--  

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity Declaration

ENTITY nsnrlatch_x0 IS
  PORT (
         nset : in    STD_LOGIC;
         nrst : in    STD_LOGIC;
            q : inout STD_LOGIC;
           nq : inout STD_LOGIC
  );
END nsnrlatch_x0;

-- Architecture Declaration

ARCHITECTURE RTL OF nsnrlatch_x0 IS

BEGIN


  nq <= (not (nrst) or not (q));
  q <= (not (nq) or not (nset));

END;
