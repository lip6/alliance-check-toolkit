--  
--  Avertec Release v3.4p5 (64 bits on Linux 6.7.12+bpo-amd64)
--  [AVT_only] host: fsdev
--  [AVT_only] arch: x86_64
--  [AVT_only] path: /opt/tasyag-3.4p5/bin/avt_shell
--  argv: 
--  
--  User: verhaegs
--  Generation date Tue Sep 24 13:35:36 2024
--  
--  VHDL data flow description generated from `IOPadTriOut`
--  

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity Declaration

ENTITY IOPadTriOut IS
  PORT (
            c2p : in    STD_LOGIC;
         c2p_en : in    STD_LOGIC;
            pad : out   STD_LOGIC
  );
END IOPadTriOut;

-- Architecture Declaration

ARCHITECTURE RTL OF IOPadTriOut IS
  SIGNAL gatedec_ngate_levelup_lvld_n : STD_LOGIC;
  SIGNAL gatedec_ngate_levelup_lvld : STD_LOGIC;
  SIGNAL gatedec_pgate_levelup_lvld_n : STD_LOGIC;
  SIGNAL gatedec_pgate_levelup_lvld : STD_LOGIC;
  SIGNAL pgate : STD_LOGIC;
  SIGNAL ngate : STD_LOGIC;
  SIGNAL gatedec_en_n : STD_LOGIC;
  SIGNAL gatedec_ngate_core : STD_LOGIC;
  SIGNAL gatedec_pgate_core : STD_LOGIC;
  SIGNAL gatedec_ngate_levelup_i_n : STD_LOGIC;
  SIGNAL gatedec_pgate_levelup_i_n : STD_LOGIC;
  SIGNAL yag_zero : STD_LOGIC;
  SIGNAL yag_one : STD_LOGIC;

BEGIN


  yag_one <= '1';
  yag_zero <= '0';
  gatedec_pgate_levelup_i_n <= not (gatedec_pgate_core);
  gatedec_ngate_levelup_i_n <= not (gatedec_ngate_core);
  gatedec_pgate_core <= (not (c2p_en) or not (c2p));
  gatedec_ngate_core <= (not (gatedec_en_n) and not (c2p));
  gatedec_en_n <= not (c2p_en);
  ngate <= not (gatedec_ngate_levelup_lvld_n);
  pgate <= not (gatedec_pgate_levelup_lvld_n);

BUX0: PROCESS (gatedec_pgate_levelup_i_n, gatedec_pgate_levelup_lvld_n)
BEGIN
  IF gatedec_pgate_levelup_i_n = '1' THEN
    gatedec_pgate_levelup_lvld <= '0';
  ELSIF gatedec_pgate_levelup_lvld_n = '0' THEN
    gatedec_pgate_levelup_lvld <= '1';
  ELSE
    gatedec_pgate_levelup_lvld <= 'Z';
  END IF;
END PROCESS;

BUX1: PROCESS (gatedec_pgate_core, gatedec_pgate_levelup_lvld)
BEGIN
  IF gatedec_pgate_core = '1' THEN
    gatedec_pgate_levelup_lvld_n <= '0';
  ELSIF gatedec_pgate_levelup_lvld = '0' THEN
    gatedec_pgate_levelup_lvld_n <= '1';
  ELSE
    gatedec_pgate_levelup_lvld_n <= 'Z';
  END IF;
END PROCESS;

BUX2: PROCESS (gatedec_ngate_levelup_i_n, gatedec_ngate_levelup_lvld_n)
BEGIN
  IF gatedec_ngate_levelup_i_n = '1' THEN
    gatedec_ngate_levelup_lvld <= '0';
  ELSIF gatedec_ngate_levelup_lvld_n = '0' THEN
    gatedec_ngate_levelup_lvld <= '1';
  ELSE
    gatedec_ngate_levelup_lvld <= 'Z';
  END IF;
END PROCESS;

BUX3: PROCESS (gatedec_ngate_core, gatedec_ngate_levelup_lvld)
BEGIN
  IF gatedec_ngate_core = '1' THEN
    gatedec_ngate_levelup_lvld_n <= '0';
  ELSIF gatedec_ngate_levelup_lvld = '0' THEN
    gatedec_ngate_levelup_lvld_n <= '1';
  ELSE
    gatedec_ngate_levelup_lvld_n <= 'Z';
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
