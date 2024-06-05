--  
--  Avertec Release v3.4p5 (64 bits on Linux 6.6.13+bpo-amd64)
--  [AVT_only] host: fsdev
--  [AVT_only] arch: x86_64
--  [AVT_only] path: /opt/tasyag-3.4p5/bin/avt_shell
--  argv: 
--  
--  User: verhaegs
--  Generation date Wed May 29 11:26:56 2024
--  
--  VHDL data flow description generated from `IOPadOut`
--  

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity Declaration

ENTITY IOPadOut IS
  PORT (
         c2p : in    STD_LOGIC;
         pad : out   STD_LOGIC
  );
END IOPadOut;

-- Architecture Declaration

ARCHITECTURE RTL OF IOPadOut IS
  SIGNAL gatelu_ngate_levelup_lvld_n : STD_LOGIC;
  SIGNAL gatelu_ngate_levelup_lvld : STD_LOGIC;
  SIGNAL gatelu_pgate_levelup_lvld_n : STD_LOGIC;
  SIGNAL gatelu_pgate_levelup_lvld : STD_LOGIC;
  SIGNAL pgate : STD_LOGIC;
  SIGNAL ngate : STD_LOGIC;
  SIGNAL gatelu_ngate_levelup_i_n : STD_LOGIC;
  SIGNAL gatelu_pgate_levelup_i_n : STD_LOGIC;
  SIGNAL yag_zero : STD_LOGIC;
  SIGNAL yag_one : STD_LOGIC;

BEGIN


  yag_one <= '1';
  yag_zero <= '0';
  gatelu_pgate_levelup_i_n <= not (c2p);
  gatelu_ngate_levelup_i_n <= not (c2p);
  ngate <= not (gatelu_ngate_levelup_lvld_n);
  pgate <= not (gatelu_pgate_levelup_lvld_n);

BUX0: PROCESS (c2p, gatelu_pgate_levelup_lvld_n)
BEGIN
  IF c2p = '1' THEN
    gatelu_pgate_levelup_lvld <= '0';
  ELSIF gatelu_pgate_levelup_lvld_n = '0' THEN
    gatelu_pgate_levelup_lvld <= '1';
  ELSE
    gatelu_pgate_levelup_lvld <= 'Z';
  END IF;
END PROCESS;

BUX1: PROCESS (gatelu_pgate_levelup_i_n, gatelu_pgate_levelup_lvld)
BEGIN
  IF gatelu_pgate_levelup_i_n = '1' THEN
    gatelu_pgate_levelup_lvld_n <= '0';
  ELSIF gatelu_pgate_levelup_lvld = '0' THEN
    gatelu_pgate_levelup_lvld_n <= '1';
  ELSE
    gatelu_pgate_levelup_lvld_n <= 'Z';
  END IF;
END PROCESS;

BUX2: PROCESS (c2p, gatelu_ngate_levelup_lvld_n)
BEGIN
  IF c2p = '1' THEN
    gatelu_ngate_levelup_lvld <= '0';
  ELSIF gatelu_ngate_levelup_lvld_n = '0' THEN
    gatelu_ngate_levelup_lvld <= '1';
  ELSE
    gatelu_ngate_levelup_lvld <= 'Z';
  END IF;
END PROCESS;

BUX3: PROCESS (gatelu_ngate_levelup_i_n, gatelu_ngate_levelup_lvld)
BEGIN
  IF gatelu_ngate_levelup_i_n = '1' THEN
    gatelu_ngate_levelup_lvld_n <= '0';
  ELSIF gatelu_ngate_levelup_lvld = '0' THEN
    gatelu_ngate_levelup_lvld_n <= '1';
  ELSE
    gatelu_ngate_levelup_lvld_n <= 'Z';
  END IF;
END PROCESS;

BUS0: PROCESS (ngate, pgate)
BEGIN
  IF ngate = '1' THEN
    pad <= '0';
  ELSIF pgate = '0' THEN
    pad <= '1';
  ELSE
    pad <= 'Z';
  END IF;
END PROCESS;

END;
