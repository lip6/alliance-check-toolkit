
-- ### -------------------------------------------------------------- ###
-- # file	: mips_32_1p_mul_div.vhd				#
-- # date	: May  9 2014						#
-- # version	: v2.0							#
-- #									#
-- # origin	: this description has been developed at LIP6		#
-- #		  University Paris 6 - Pierre et Marie Curie		#
-- #		  4 Place Jussieu 75252 Paris Cedex 05 - France		#
-- #									#
-- # descr.	: data flow description of a five stage pipelined	#
-- #		  Mips-32 processor					#
-- #									#
-- # authors	: Pirouz Bazargan Sabet					#
-- ### -------------------------------------------------------------- ###

library ieee ;
use     ieee.std_logic_1164.all    ;
use     ieee.std_logic_arith.all   ;
use     ieee.std_logic_unsigned.all;

entity MIPS_32_1P_MUL_DIV is

generic
  (
  constant RESET_ADDR   : std_logic_vector ( 31 downto  0) := X"bfc00000";
  constant BOOTEXC_ADDR : std_logic_vector ( 31 downto  0) := X"bfc00380"
  );

port
  (
  signal   CK           : in    std_logic                       ;-- clock
  signal   RESET_N      : in    std_logic                       ;-- reset

  signal   IT_N         : in    std_logic_vector (  5 downto  0);-- hw it

  signal   CPU_NBR      : in    std_logic_vector (  9 downto  0);

  signal   I_A          : out   std_logic_vector ( 31 downto  2);-- adr
  signal   I_RQ         : out   std_logic                       ;-- rqst
  signal   I_MODE       : out   std_logic_vector (  1 downto  0);-- mode
  signal   I_RBERR      : in    std_logic                       ;-- bus error
  signal   I_ACCPT      : in    std_logic                       ;-- rqst acpt
  signal   I_IN         : in    std_logic_vector ( 31 downto  0);-- inst
  signal   I_ACK        : out   std_logic                       ;-- rqst ack
  signal   I_BEREN      : out   std_logic                       ;-- err  enable
  signal   I_INLINE     : out   std_logic                       ;-- in cac line

  signal   D_A          : out   std_logic_vector ( 31 downto  2);-- adr
  signal   D_BYTSEL     : out   std_logic_vector (  3 downto  0);-- byt select
  signal   D_RQ         : out   std_logic                       ;-- rqst
  signal   D_RW         : out   std_logic                       ;-- r-w
  signal   D_MODE       : out   std_logic_vector (  1 downto  0);-- mode
  signal   D_SYNC       : out   std_logic                       ;-- synchro
  signal   D_REG        : out   std_logic                       ;-- ext reg
  signal   D_LINKED     : out   std_logic                       ;-- linked acs
  signal   D_RSTLKD     : out   std_logic                       ;-- reset lnkd
  signal   D_CACHE      : out   std_logic                       ;-- cache oper
  signal   D_CACHOP     : out   std_logic_vector (  4 downto  0);-- cache oper
  signal   D_RBERR      : in    std_logic                       ;-- bus error
  signal   D_WBERR      : in    std_logic                       ;-- bus error
  signal   D_ACCPT      : in    std_logic                       ;-- rqst acpt
  signal   D_OUT        : out   std_logic_vector ( 31 downto  0);-- data
  signal   D_IN         : in    std_logic_vector ( 31 downto  0);-- data
  signal   D_ACK        : out   std_logic                       ;-- rqst ack

  signal   MCHECK_N     : in    std_logic                       ;-- machine chk

  signal   TEST         : in    std_logic                       ;-- test mode
  signal   SCIN         : in    std_logic                       ;-- scan in
  signal   SCOUT        : out   std_logic                       ;-- scan out

  signal   VDD          : in    std_logic                       ;
  signal   VSS          : in    std_logic                       ;
  signal   VDDP         : in    std_logic                       ;
  signal   VSSP         : in    std_logic
  );

end MIPS_32_1P_MUL_DIV;
--

-- ### -------------------------------------------------------------- ###
-- #   internal description - contains the following sections :		#
-- #									#
-- #     - internal signal and register declarations			#
-- #     - constant declarations					#
-- #     - instructions' table						#
-- #     - signals' and registers' assignments				#
-- #									#
-- #   Each signal or register is suffixed by two letters.		#
-- #									#
-- #   The second letter identifies the pipe stage in which the signal	#
-- #   is assigned :							#
-- #     - I : Instruction Fetch					#
-- #     - D : Instruction Decode					#
-- #     - E : Execute							#
-- #     - M : Memory Access						#
-- #     - W : Write Back						#
-- #     - X : signal not related to the execution of an instruction	#
-- #									#
-- #   The first letter identifies the type of the signal :		#
-- #     - R : a register sampling on the rising  edge of the clock	#
-- #     - F : a register sampling on the falling edge of the clock	#
-- #     - S : signal related to the normal execution			#
-- #     - X : signal related to the exception mechanism		#
-- ### -------------------------------------------------------------- ###

architecture BEHAVIOURAL of MIPS_32_1P_MUL_DIV is

signal   IMP_SX       : std_logic_vector (  1 downto  0);-- implementation
signal   IMPSTD_SX    : std_logic                       ;-- implementation
signal   IMPTSR_SX    : std_logic                       ;-- implementation

signal   COP0_SD      : std_logic_vector (  8 downto  0);-- cop0 ext
signal   COP2_SD      : std_logic_vector (  8 downto  0);-- cop2 ext
signal   OPCOD_SD     : std_logic_vector (  8 downto  0);-- ext op code
signal   OPCOD_RD     : std_logic_vector (  8 downto  0);-- ext op code
signal   OPCOD_RE     : std_logic_vector (  8 downto  0);-- ext op code
signal   OPCOD_RM     : std_logic_vector (  8 downto  0);-- ext op code

signal   I_TYPE_SD    : std_logic_vector ( 40 downto  0);-- inst type
signal   I_TYPE_RD    : std_logic_vector ( 40 downto  0);-- inst type
signal   I_TYPE_RE    : std_logic_vector ( 40 downto  0);-- inst type
signal   I_TYPE_RM    : std_logic_vector ( 40 downto  0);-- inst type

signal   I_RFMT_SD    : std_logic                       ;-- r format
signal   I_IFMT_SD    : std_logic                       ;-- i format
signal   I_ILLG_SD    : std_logic                       ;--   illegal inst
signal   I_IFMT_SE    : std_logic                       ;-- i format

signal   I_READS_SD   : std_logic                       ;-- inst uses s oper
signal   I_READT_SD   : std_logic                       ;-- inst uses t oper
signal   I_READS_SE   : std_logic                       ;-- inst uses s oper
signal   I_READT_SE   : std_logic                       ;-- inst uses t oper

signal   I_DUSES_SD   : std_logic                       ;-- dec uses s
signal   I_DUSET_SD   : std_logic                       ;-- dec uses t

signal   I_EUSES_SD   : std_logic                       ;-- exe uses s
signal   I_EUSES_SE   : std_logic                       ;-- exe uses s
signal   I_EUSET_SD   : std_logic                       ;-- exe uses t
signal   I_EUSET_SE   : std_logic                       ;-- exe uses t

signal   I_EUSEL_SE   : std_logic                       ;-- exe uses lo
signal   I_EUSEH_SE   : std_logic                       ;-- exe uses hi
signal   I_MUSEL_SM   : std_logic                       ;-- mem uses lo
signal   I_MUSEH_SM   : std_logic                       ;-- mem uses hi

signal   I_MPDC_SM    : std_logic                       ;-- mem produces res

signal   I_WPDC_SE    : std_logic                       ;-- wbk produces res
signal   I_WPDC_SM    : std_logic                       ;-- wbk produces res
signal   I_WPDC_SW    : std_logic                       ;-- wbk produces res

signal   I_OSGND_SD   : std_logic                       ;-- signed operands
signal   I_OSGND_SE   : std_logic                       ;-- signed operands

signal   I_ARITH_SE   : std_logic                       ;-- arith  result
signal   I_LOGIC_SE   : std_logic                       ;-- logic  result
signal   I_SHIFT_SE   : std_logic                       ;-- shift  result
signal   I_TEST_SE    : std_logic                       ;-- test   result
signal   I_OPER_SE    : std_logic                       ;-- oper   result
signal   I_CLEAD_SE   : std_logic                       ;-- c-lead result

signal   I_SUB_SE     : std_logic                       ;-- arith subtract

signal   I_SHR_SE     : std_logic                       ;-- shift right

signal   I_LT_SE      : std_logic                       ;-- <  sgn
signal   I_LTU_SE     : std_logic                       ;-- <  usg
signal   I_GE_SE      : std_logic                       ;-- >= sgn
signal   I_GEU_SE     : std_logic                       ;-- >= usg
signal   I_EQ_SE      : std_logic                       ;-- =
signal   I_NE_SE      : std_logic                       ;-- !=

signal   I_AND_SE     : std_logic                       ;-- logic and
signal   I_NOR_SE     : std_logic                       ;-- logic nor
signal   I_XOR_SE     : std_logic                       ;-- logic xor
signal   I_OR_SE      : std_logic                       ;-- logic or

signal   I_SOPER_SE   : std_logic                       ;-- s operand
signal   I_TOPER_SE   : std_logic                       ;-- t operand
signal   I_IOPER_SE   : std_logic                       ;-- i operand

signal   I_CLZ_SE     : std_logic                       ;-- c-leading 0

signal   I_MSUB_SE    : std_logic                       ;-- multiply-sub
signal   I_MULT_SM    : std_logic                       ;-- multiply

signal   I_MIC_SE     : std_logic_vector (  2 downto  0);-- micro-inst
signal   I_CISC_SE    : std_logic                       ;-- micro-prg  inst

signal   I_OVRF_SE    : std_logic                       ;-- overflow

signal   I_MLOAD_SE   : std_logic                       ;-- read  from mem
signal   I_MSTOR_SE   : std_logic                       ;-- write into mem

signal   I_LOAD_SE    : std_logic                       ;-- read   acs
signal   I_STOR_SE    : std_logic                       ;-- write  acs

signal   I_LINKD_SE   : std_logic                       ;-- linked acs
signal   I_LINKD_SM   : std_logic                       ;-- linked acs

signal   I_XREG_SE    : std_logic                       ;-- ext reg acs
signal   I_XREG_SM    : std_logic                       ;-- ext reg acs

signal   I_BYTE_SE    : std_logic                       ;-- acs type (byte)
signal   I_HALF_SE    : std_logic                       ;-- acs type (half)
signal   I_WORD_SE    : std_logic                       ;-- acs type (word)
signal   I_WRDL_SE    : std_logic                       ;-- acs type (word)
signal   I_WRDR_SE    : std_logic                       ;-- acs type (word)

signal   I_BRNCH_SD   : std_logic                       ;-- brch inst
signal   I_BRNCH_SE   : std_logic                       ;-- brch inst

signal   I_WREG_SD    : std_logic                       ;--     wrt int reg
signal   I_WREG_SE    : std_logic                       ;--     wrt int reg
signal   I_WREG_SM    : std_logic                       ;--     wrt int reg
signal   I_WREG_SW    : std_logic                       ;--     wrt int reg
signal   WR31_SD      : std_logic                       ;--     wrt     r31
signal   CNDWRG_SE    : std_logic                       ;-- cnd wrt int reg

signal   I_WCOP0_SM   : std_logic                       ;-- write cop0 reg

signal   I_WLO_SM     : std_logic                       ;-- write lo
signal   I_WLO_SW     : std_logic                       ;-- write lo

signal   I_WHI_SM     : std_logic                       ;-- write hi
signal   I_WHI_SW     : std_logic                       ;-- write hi

signal   RDHWR_SE     : std_logic                       ;-- read hw reg inst

signal   SEQI_SD      : std_logic                       ;-- seq   inst

signal   ERET_SD      : std_logic                       ;-- eret  inst
signal   ERET_SE      : std_logic                       ;-- eret  inst
signal   ERET_SM      : std_logic                       ;-- eret  inst

signal   MFC0_SD      : std_logic                       ;-- mfc0  inst

signal   MTC0_SD      : std_logic                       ;-- mtc0  inst
signal   MTC0_SE      : std_logic                       ;-- mtc0  inst
signal   MTC0_SM      : std_logic                       ;-- mtc0  inst

signal   MFMC0_SD     : std_logic                       ;-- di ei inst
signal   MFMC0_SE     : std_logic                       ;-- di ei inst
signal   MFMC0_SM     : std_logic                       ;-- di ei inst

signal   MFC2_SD      : std_logic                       ;-- mfc2  inst
signal   MFC2_SE      : std_logic                       ;-- mfc2  inst

signal   MTC2_SD      : std_logic                       ;-- mtc2  inst
signal   MTC2_SE      : std_logic                       ;-- mtc2  inst

signal   SYNC_SE      : std_logic                       ;-- sync  inst

signal   CACH_SE      : std_logic                       ;-- cache inst
signal   CACHOP_SE    : std_logic_vector (  4 downto  0);-- cache oper
signal   CACHOP_SM    : std_logic_vector (  4 downto  0);-- cache oper

signal   WAIT_SD      : std_logic                       ;-- wait  inst
signal   WAIT_SE      : std_logic                       ;-- wait  inst
signal   WAIT_SM      : std_logic                       ;-- wait  inst
signal   EFFWAIT_SM   : std_logic                       ;-- wait  inst

signal   I_SYSC_SD    : std_logic                       ;-- syscall
signal   SYSCALL_XD   : std_logic                       ;-- syscall
signal   SYSCALL_RD   : std_logic                       ;-- syscall
signal   SYSCALL_RE   : std_logic                       ;-- syscall

signal   I_BREK_SD    : std_logic                       ;-- break
signal   BREAK_XD     : std_logic                       ;-- break
signal   BREAK_RD     : std_logic                       ;-- break
signal   BREAK_RE     : std_logic                       ;-- break

signal   I_TRAP_SD    : std_logic                       ;-- trap
signal   TRAP_RD      : std_logic                       ;-- trap
signal   TRAP_RE      : std_logic                       ;-- trap
signal   TRAP_XE      : std_logic                       ;-- trap

signal   IRQ_SE       : std_logic                       ;-- inst rqst
signal   IRQ_RE       : std_logic                       ;-- inst rqst
signal   INOTRDY_SE   : std_logic                       ;-- inst not ready

signal   I_RI         : std_logic_vector ( 31 downto  0);-- inst reg
signal   I_RD         : std_logic_vector ( 31 downto  0);-- inst reg
signal   I_RE         : std_logic_vector ( 31 downto  0);-- inst reg
signal   I_RM         : std_logic_vector ( 31 downto  0);-- inst reg

signal   IREAD_RI     : std_logic                       ;-- new inst fetched

signal   RS_SD        : std_logic_vector (  4 downto  0);-- src reg nbr
signal   RS_RD        : std_logic_vector (  4 downto  0);-- src reg nbr reg

signal   RT_SD        : std_logic_vector (  4 downto  0);-- src reg nbr
signal   RT_RD        : std_logic_vector (  4 downto  0);-- src reg nbr reg
signal   RT_RE        : std_logic_vector (  4 downto  0);-- src reg nbr reg

signal   EXCADR_XM    : std_logic_vector ( 31 downto  0);-- nxt adr (exc)
signal   NEXTPC_XX    : std_logic_vector ( 31 downto  0);-- nxt adr (rst)
signal   NEXTPC_XM    : std_logic_vector ( 31 downto  0);-- nxt adr (exc)
signal   NEXTPC_SD    : std_logic_vector ( 31 downto  0);-- nxt adr
signal   NEXTPC_RD    : std_logic_vector ( 31 downto  0);-- nxt adr
signal   NEXTPC_RE    : std_logic_vector ( 31 downto  0);-- nxt adr

signal   PC_RI        : std_logic_vector ( 31 downto  0);-- inst adr
signal   PC_RD        : std_logic_vector ( 31 downto  0);-- inst adr
signal   PC_RE        : std_logic_vector ( 31 downto  0);-- inst adr
signal   REDOPC_RE    : std_logic_vector ( 31 downto  0);-- brch adr
signal   WREDOPC_SE   : std_logic                       ;-- brch adr wen

signal   EXCCODE_XM   : std_logic_vector (  4 downto  0);-- exc code

signal   CAUSE_XX     : std_logic_vector ( 31 downto  0);-- cause (rst)
signal   CAUSE_XM     : std_logic_vector ( 31 downto  0);-- cause (exc)
signal   CAUSE_SM     : std_logic_vector ( 31 downto  0);-- cause (sw)
signal   CAUSE_SX     : std_logic_vector ( 31 downto  0);-- cause (hw)
signal   CAUSE_RX     : std_logic_vector ( 31 downto  0);-- cause reg
signal   WCAUSE_XX    : std_logic                       ;-- cse reg wen (rst)
signal   WCAUSE_XM    : std_logic                       ;-- cse reg wen (exc)
signal   WCAUSE_SM    : std_logic                       ;-- cse reg wen (sw)

signal   STATUS_XX    : std_logic_vector ( 31 downto  0);-- status (rst)
signal   STATUS_XM    : std_logic_vector ( 31 downto  0);-- status (exc)
signal   DEISR_SM     : std_logic_vector ( 31 downto  0);-- status (sw)
signal   RSTORSR_SM   : std_logic_vector ( 31 downto  0);-- status (sw)
signal   STATUS_SM    : std_logic_vector ( 31 downto  0);-- status (sw)
signal   STATUS_RX    : std_logic_vector ( 31 downto  0);-- status reg
signal   WSR_XX       : std_logic                       ;-- sts reg wen (rst)
signal   WSR_XM       : std_logic                       ;-- sts reg wen (exc)
signal   WSR_SM       : std_logic                       ;-- sts reg wen (sw)

signal   S_SD         : std_logic_vector ( 31 downto  0);--     s oper
signal   SOPER_SD     : std_logic_vector ( 31 downto  0);-- eff s oper
signal   SOPER_RD     : std_logic_vector ( 31 downto  0);-- eff s oper
signal   SOPER_SE     : std_logic_vector ( 31 downto  0);-- eff s oper

signal   T_SD         : std_logic_vector ( 31 downto  0);--     t oper
signal   TOPER_SD     : std_logic_vector ( 31 downto  0);-- eff t oper
signal   TOPER_RD     : std_logic_vector ( 31 downto  0);-- eff t oper
signal   TOPER_SE     : std_logic_vector ( 31 downto  0);-- eff t oper

signal   COP0OP_SD    : std_logic_vector ( 31 downto  0);-- cop 0 sre  opr
signal   COP0S_SD     : std_logic_vector (  7 downto  0);-- cop 0 src  nbr
signal   COP0D_SD     : std_logic_vector (  7 downto  0);-- cop 0 dest nbr
signal   COP0D_RD     : std_logic_vector (  7 downto  0);-- cop 0 dest nbr
signal   COP0D_RE     : std_logic_vector (  7 downto  0);-- cop 0 dest nbr

signal   HWROP_SD     : std_logic_vector ( 31 downto  0);-- hw register opr

signal   IOPER_SD     : std_logic_vector ( 31 downto  0);-- eff imd oper
signal   IOPER_RD     : std_logic_vector ( 31 downto  0);-- eff imd oper
signal   IOPER_SE     : std_logic_vector ( 31 downto  0);-- eff imd oper

signal   SHAM_SD      : std_logic_vector (  4 downto  0);-- shift amount
signal   SHAM_RD      : std_logic_vector (  4 downto  0);-- shift amount

signal   CP_SDE_SD    : std_logic_vector (  4 downto  0);-- cmp s d(i-1)
signal   CP_SDM_SD    : std_logic_vector (  4 downto  0);-- cmp s d(i-2)
signal   CP_SDW_SD    : std_logic_vector (  4 downto  0);-- cmp s d(i-3)
signal   CP_TDE_SD    : std_logic_vector (  4 downto  0);-- cmp t d(i-1)
signal   CP_TDM_SD    : std_logic_vector (  4 downto  0);-- cmp t d(i-2)
signal   CP_TDW_SD    : std_logic_vector (  4 downto  0);-- cmp t d(i-3)

signal   CP_SDM_SE    : std_logic_vector (  4 downto  0);-- cmp s d(i-1)
signal   CP_SDW_SE    : std_logic_vector (  4 downto  0);-- cmp s d(i-2)
signal   CP_TDM_SE    : std_logic_vector (  4 downto  0);-- cmp t d(i-1)
signal   CP_TDW_SE    : std_logic_vector (  4 downto  0);-- cmp t d(i-2)

signal   SREADR0_SD   : std_logic                       ;-- r0 on s
signal   SREADR0_SE   : std_logic                       ;-- r0 on s
signal   TREADR0_SD   : std_logic                       ;-- r0 on t
signal   TREADR0_SE   : std_logic                       ;-- r0 on t

signal   HZ_SDE_SD    : std_logic                       ;-- eff s = d(i-1)
signal   HZ_SDM_SD    : std_logic                       ;-- eff s = d(i-2)
signal   HZ_SDW_SD    : std_logic                       ;-- eff s = d(i-3)
signal   HZ_TDE_SD    : std_logic                       ;-- eff t = d(i-1)
signal   HZ_TDM_SD    : std_logic                       ;-- eff t = d(i-2)
signal   HZ_TDW_SD    : std_logic                       ;-- eff t = d(i-3)

signal   HZ_SDM_SE    : std_logic                       ;-- eff s = d(i-1)
signal   HZ_SDW_SE    : std_logic                       ;-- eff s = d(i-2)
signal   HZ_TDM_SE    : std_logic                       ;-- eff t = d(i-1)
signal   HZ_TDW_SE    : std_logic                       ;-- eff t = d(i-2)
signal   HZ_LO_SE     : std_logic                       ;-- hazard on lo
signal   HZ_HI_SE     : std_logic                       ;-- hazard on hi

signal   HZ_LO_SM     : std_logic                       ;-- hazard on lo
signal   HZ_HI_SM     : std_logic                       ;-- hazard on hi

signal   S_CP_T_SD    : std_logic_vector ( 31 downto  0);-- cmp s and t
signal   S_EQ_T_SD    : std_logic                       ;-- s =  t
signal   S_LT_Z_SD    : std_logic                       ;-- s <  0
signal   S_LE_Z_SD    : std_logic                       ;-- s <= 0

signal   T_EQ_Z_SE    : std_logic                       ;-- t =  0
signal   X_CP_Y_SE    : std_logic_vector ( 31 downto  0);-- cmp x and y
signal   X_EQ_Y_SE    : std_logic                       ;-- x =  y
signal   X_LT_Y_SE    : std_logic                       ;-- x <  y
signal   X_LTU_Y_SE   : std_logic                       ;-- x <  y unsigned

signal   DATHZDS_SD   : std_logic                       ;-- data    hazards
signal   INSHZDS_SD   : std_logic                       ;-- inst    hazards
signal   HAZARDS_SD   : std_logic                       ;-- hazards

signal   DATHZDS_SE   : std_logic                       ;-- data    hazards
signal   HAZARDS_SE   : std_logic                       ;-- hazards

signal   DATHZDS_SM   : std_logic                       ;-- data    hazards
signal   HAZARDS_SM   : std_logic                       ;-- hazards

signal   KILL_SI      : std_logic                       ;-- kill
signal   STALL_SI     : std_logic                       ;-- stall
signal   COPY_SI      : std_logic                       ;-- duplicate
signal   EXEC_SI      : std_logic                       ;-- execute

signal   KILL_SD      : std_logic                       ;-- kill
signal   STALL_SD     : std_logic                       ;-- stall
signal   COPY_SD      : std_logic                       ;-- duplicate
signal   EXEC_SD      : std_logic                       ;-- execute

signal   KILL_SE      : std_logic                       ;-- kill
signal   STALL_SE     : std_logic                       ;-- stall
signal   COPY_SE      : std_logic                       ;-- duplicate
signal   EXEC_SE      : std_logic                       ;-- execute

signal   KILL_SM      : std_logic                       ;-- kill
signal   STALL_SM     : std_logic                       ;-- stall
signal   COPY_SM      : std_logic                       ;-- duplicate
signal   EXEC_SM      : std_logic                       ;-- execute

signal   KILL_SW      : std_logic                       ;-- kill
signal   STALL_SW     : std_logic                       ;-- stall
signal   COPY_SW      : std_logic                       ;-- duplicate
signal   EXEC_SW      : std_logic                       ;-- execute

signal   KILLED_SI    : std_logic                       ;-- killed
signal   KILLED_RI    : std_logic                       ;-- killed
signal   KILLED_SD    : std_logic                       ;-- killed
signal   KILLED_RD    : std_logic                       ;-- killed
signal   KILLED_SE    : std_logic                       ;-- killed

signal   BUBBLE_SI    : std_logic                       ;-- insert bubble
signal   HOLD_SI      : std_logic                       ;-- hold   the inst
signal   SHIFT_SI     : std_logic                       ;-- shift  new inst
signal   KEEP_SI      : std_logic                       ;-- keep   the data
signal   LOAD_SI      : std_logic                       ;-- load a new data

signal   BUBBLE_SD    : std_logic                       ;-- insert bubble
signal   HOLD_SD      : std_logic                       ;-- hold   the inst
signal   SHIFT_SD     : std_logic                       ;-- shift  new inst
signal   KEEP_SD      : std_logic                       ;-- keep   the data
signal   LOAD_SD      : std_logic                       ;-- load a new data

signal   BUBBLE_SE    : std_logic                       ;-- insert bubble
signal   HOLD_SE      : std_logic                       ;-- hold   the inst
signal   SHIFT_SE     : std_logic                       ;-- shift  new inst
signal   KEEP_SE      : std_logic                       ;-- keep   the data
signal   LOAD_SE      : std_logic                       ;-- load a new data

signal   BUBBLE_SM    : std_logic                       ;-- insert bubble
signal   HOLD_SM      : std_logic                       ;-- hold   the inst
signal   SHIFT_SM     : std_logic                       ;-- shift  new inst
signal   KEEP_SM      : std_logic                       ;-- keep   the data
signal   LOAD_SM      : std_logic                       ;-- load a new data

signal   BUBBLE_SW    : std_logic                       ;-- insert bubble
signal   HOLD_SW      : std_logic                       ;-- hold   the inst
signal   SHIFT_SW     : std_logic                       ;-- shift  new inst
signal   KEEP_SW      : std_logic                       ;-- keep   the data
signal   LOAD_SW      : std_logic                       ;-- load a new data

signal   IMDSEX_SD    : std_logic_vector ( 15 downto  0);-- imd sgn ext

signal   SEQPR0_SD    : std_logic_vector ( 31 downto  2);-- seq adr pro
signal   SEQPR1_SD    : std_logic_vector ( 31 downto  2);-- seq adr pro
signal   SEQPR2_SD    : std_logic_vector ( 31 downto  2);-- seq adr pro
signal   SEQPR3_SD    : std_logic_vector ( 31 downto  2);-- seq adr pro
signal   SEQPR4_SD    : std_logic_vector ( 31 downto  2);-- seq adr pro
signal   SEQPR5_SD    : std_logic_vector ( 31 downto  2);-- seq adr pro

signal   SEQCRY_SD    : std_logic_vector ( 31 downto  2);-- seq adr cry
signal   SEQCYI_SD    : std_logic_vector ( 31 downto  0);-- seq adr cry
signal   SEQADR_SD    : std_logic_vector ( 31 downto  0);-- seq adr

signal   IINLIN_SD    : std_logic                       ;-- in cache line

signal   BRAOFS_SD    : std_logic_vector ( 31 downto  0);-- bch adr offset

signal   BRAPR0_SD    : std_logic_vector ( 31 downto  0);-- bch adr pro
signal   BRAPR1_SD    : std_logic_vector ( 31 downto  0);-- bch adr pro
signal   BRAPR2_SD    : std_logic_vector ( 31 downto  0);-- bch adr pro
signal   BRAPR3_SD    : std_logic_vector ( 31 downto  0);-- bch adr pro
signal   BRAPR4_SD    : std_logic_vector ( 31 downto  0);-- bch adr pro
signal   BRAPR5_SD    : std_logic_vector ( 31 downto  0);-- bch adr pro
signal   BRAGN0_SD    : std_logic_vector ( 31 downto  0);-- bch adr gen
signal   BRAGN1_SD    : std_logic_vector ( 31 downto  0);-- bch adr gen
signal   BRAGN2_SD    : std_logic_vector ( 31 downto  0);-- bch adr gen
signal   BRAGN3_SD    : std_logic_vector ( 31 downto  0);-- bch adr gen
signal   BRAGN4_SD    : std_logic_vector ( 31 downto  0);-- bch adr gen
signal   BRAGN5_SD    : std_logic_vector ( 31 downto  0);-- bch adr gen

signal   BRACRY_SD    : std_logic_vector ( 31 downto  0);-- bch adr cry
signal   BRACYI_SD    : std_logic_vector ( 31 downto  0);-- bch adr cry
signal   BRAADR_SD    : std_logic_vector ( 31 downto  0);-- bch adr

signal   RETADR_SD    : std_logic_vector ( 31 downto  0);-- return adr
signal   JMPADR_SD    : std_logic_vector ( 31 downto  0);-- jump   adr

signal   RD_SD        : std_logic_vector (  4 downto  0);-- dest reg nbr
signal   EFFRD_SD     : std_logic_vector (  4 downto  0);-- dest reg nbr
signal   RD_RD        : std_logic_vector (  4 downto  0);-- dest reg nbr
signal   RD_SE        : std_logic_vector (  4 downto  0);-- dest reg nbr
signal   RD_RE        : std_logic_vector (  4 downto  0);-- dest reg nbr
signal   RD_SM        : std_logic_vector (  4 downto  0);-- dest reg nbr
signal   RD_RM        : std_logic_vector (  4 downto  0);-- dest reg nbr

signal   RDDEC_SD     : std_logic_vector ( 31 downto  0);-- dest reg nbr
signal   EFFHWRE_SD   : std_logic_vector ( 31 downto  0);-- dest reg nbr
signal   EFFHWRE_RD   : std_logic_vector ( 31 downto  0);-- dest reg nbr
signal   RDHWR_XE     : std_logic                       ;-- read hwr exc

signal   XOPER_SE     : std_logic_vector ( 31 downto  0);-- x operand
signal   YOPER_SE     : std_logic_vector ( 31 downto  0);-- y operand

signal   CLDXOP_SE    : std_logic_vector ( 31 downto  0);-- cnt lead oper

signal   CLDPR1_SE    : std_logic_vector ( 31 downto  0);-- cnt lead pro
signal   CLDPR2_SE    : std_logic_vector ( 31 downto  0);-- cnt lead pro
signal   CLDPR3_SE    : std_logic_vector ( 31 downto  0);-- cnt lead pro
signal   CLDPR4_SE    : std_logic_vector ( 31 downto  0);-- cnt lead pro
signal   CLDPR5_SE    : std_logic_vector ( 31 downto  0);-- cnt lead pro

signal   CLDMSK_SE    : std_logic_vector ( 31 downto  0);-- cnt lead maskd

signal   CLD_5_SE     : std_logic                       ;-- cnt lead result
signal   CLD_4_SE     : std_logic                       ;-- cnt lead result
signal   CLD_3_SE     : std_logic                       ;-- cnt lead result
signal   CLD_2_SE     : std_logic                       ;-- cnt lead result
signal   CLD_1_SE     : std_logic                       ;-- cnt lead result
signal   CLD_0_SE     : std_logic                       ;-- cnt lead result
signal   RCLEAD_SE    : std_logic_vector ( 31 downto  0);-- cnt lead result

signal   XARITH_SE    : std_logic_vector ( 31 downto  0);-- oper for arith
signal   YARITH_SE    : std_logic_vector ( 31 downto  0);-- oper for arith

signal   ARIPR0_SE    : std_logic_vector ( 31 downto  0);-- arith pro
signal   ARIPR1_SE    : std_logic_vector ( 31 downto  0);-- arith pro
signal   ARIPR2_SE    : std_logic_vector ( 31 downto  0);-- arith pro
signal   ARIPR3_SE    : std_logic_vector ( 31 downto  0);-- arith pro
signal   ARIPR4_SE    : std_logic_vector ( 31 downto  0);-- arith pro
signal   ARIPR5_SE    : std_logic_vector ( 31 downto  0);-- arith pro
signal   ARIGN0_SE    : std_logic_vector ( 31 downto  0);-- arith gen
signal   ARIGN1_SE    : std_logic_vector ( 31 downto  0);-- arith gen
signal   ARIGN2_SE    : std_logic_vector ( 31 downto  0);-- arith gen
signal   ARIGN3_SE    : std_logic_vector ( 31 downto  0);-- arith gen
signal   ARIGN4_SE    : std_logic_vector ( 31 downto  0);-- arith gen
signal   ARIGN5_SE    : std_logic_vector ( 31 downto  0);-- arith gen

signal   ARICRY_SE    : std_logic_vector ( 31 downto  0);-- arith cry
signal   ARICYI_SE    : std_logic_vector ( 31 downto  0);-- arith cry
signal   RARITH_SE    : std_logic_vector ( 31 downto  0);-- arith result

signal   XSHF_SE      : std_logic_vector (  4 downto  0);-- oper for shift
signal   YSHF_SE      : std_logic_vector ( 31 downto  0);-- oper for shift

signal   SHAM_SE      : std_logic_vector (  5 downto  0);-- shift amount
signal   SHSGN_SE     : std_logic_vector ( 31 downto  0);-- shift sign

signal   SHF0_T_SE    : std_logic_vector ( 31 downto  0);-- shift true
signal   SHF1_T_SE    : std_logic_vector ( 31 downto  0);-- shift true
signal   SHF2_T_SE    : std_logic_vector ( 31 downto  0);-- shift true
signal   SHF3_T_SE    : std_logic_vector ( 31 downto  0);-- shift true
signal   SHF4_T_SE    : std_logic_vector ( 31 downto  0);-- shift true
signal   SHF5_T_SE    : std_logic_vector ( 31 downto  0);-- shift true

signal   SHF0_F_SE    : std_logic_vector ( 31 downto  0);-- shift false
signal   SHF1_F_SE    : std_logic_vector ( 31 downto  0);-- shift false
signal   SHF2_F_SE    : std_logic_vector ( 31 downto  0);-- shift false
signal   SHF3_F_SE    : std_logic_vector ( 31 downto  0);-- shift false
signal   SHF4_F_SE    : std_logic_vector ( 31 downto  0);-- shift false
signal   SHF5_F_SE    : std_logic_vector ( 31 downto  0);-- shift false

signal   SHF0_SE      : std_logic_vector ( 31 downto  0);-- shift result
signal   SHF1_SE      : std_logic_vector ( 31 downto  0);-- shift result
signal   SHF2_SE      : std_logic_vector ( 31 downto  0);-- shift result
signal   SHF3_SE      : std_logic_vector ( 31 downto  0);-- shift result
signal   SHF4_SE      : std_logic_vector ( 31 downto  0);-- shift result
signal   SHF5_SE      : std_logic_vector ( 31 downto  0);-- shift result
signal   RSHIFT_SE    : std_logic_vector ( 31 downto  0);-- shift result

signal   RLOGIC_SE    : std_logic_vector ( 31 downto  0);-- logic result

signal   TESTBIT_SE   : std_logic                       ;-- test bit
signal   RTEST_SE     : std_logic_vector ( 31 downto  0);-- test result

signal   ROPER_SE     : std_logic_vector ( 31 downto  0);-- oper as result

signal   RES_SE       : std_logic_vector ( 31 downto  0);-- alu result
signal   RES_RE       : std_logic_vector ( 31 downto  0);-- alu result

signal   OVERFLW_SE   : std_logic                       ;-- overflow

signal   DATA_B_SE    : std_logic_vector ( 31 downto  0);-- output data
signal   DATA_H_SE    : std_logic_vector ( 31 downto  0);-- output data
signal   DATA_L_SE    : std_logic_vector ( 31 downto  0);-- output data
signal   DATA_0_SE    : std_logic_vector ( 31 downto  0);-- output data
signal   DATA_1_SE    : std_logic_vector ( 31 downto  0);-- output data
signal   DATA_SE      : std_logic_vector ( 31 downto  0);-- output data
signal   DATA_RE      : std_logic_vector ( 31 downto  0);-- output data reg

signal   MICCOPY_SE   : std_logic                       ;-- micro-pg continue
signal   MICBEG_SE    : std_logic                       ;-- micro-pg begin
signal   MICLST_SE    : std_logic                       ;-- last micro-inst
signal   MICLST_RE    : std_logic                       ;-- last micro-inst
signal   MICEND_SE    : std_logic                       ;-- micro-pg end
signal   MICEND_RE    : std_logic                       ;-- micro-pg end

signal   XMXPP_SE     : std_logic                       ;-- mul extra pp x
signal   YMSGN_SE     : std_logic                       ;-- mul op signed
signal   XMSGN_SE     : std_logic                       ;-- mul op signed
signal   ZMINV_SE     : std_logic                       ;-- z oper inverted
signal   ZMINV_RE     : std_logic                       ;-- z oper inverted
signal   ZMINV_RM     : std_logic                       ;-- z oper inverted

signal   XMUL_SE      : std_logic_vector ( 31 downto  0);-- mul operand
signal   XMEXT_SE     : std_logic_vector ( 31 downto  0);-- x op sign exten
signal   YMUL_SE      : std_logic_vector ( 31 downto  0);-- mul operand

signal   ZMOPR_SM     : std_logic_vector ( 63 downto  0);-- mul operand
signal   ZMUL_SM      : std_logic_vector ( 63 downto  0);-- mul operand

signal   XX00MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX01MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX02MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX03MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX04MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX05MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX06MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX07MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX08MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX09MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX10MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX11MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX12MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX13MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX14MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX15MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX16MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX17MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX18MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX19MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX20MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX21MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX22MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX23MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX24MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX25MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX26MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX27MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX28MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX29MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX30MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand
signal   XX31MUL_SE   : std_logic_vector ( 63 downto  0);-- ext operand

signal   PP00MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP01MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP02MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP03MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP04MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP05MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP06MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP07MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP08MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP09MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP10MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP11MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP12MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP13MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP14MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP15MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP16MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP17MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP18MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP19MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP20MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP21MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP22MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP23MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP24MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP25MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP26MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP27MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP28MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP29MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP30MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PP31MUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc

signal   PPXXMUL_SE   : std_logic_vector ( 63 downto  0);-- partial pdc
signal   PPZZMUL_SM   : std_logic_vector ( 63 downto  0);-- partial pdc

signal   S00MUL0_SE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S01MUL0_SE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S02MUL0_SE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S03MUL0_SE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S04MUL0_SE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S05MUL0_SE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S06MUL0_SE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S07MUL0_SE   : std_logic_vector ( 63 downto  0);-- partial sum

signal   C00MUL0_SE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C01MUL0_SE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C02MUL0_SE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C03MUL0_SE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C04MUL0_SE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C05MUL0_SE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C06MUL0_SE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C07MUL0_SE   : std_logic_vector ( 63 downto  0);-- partial cry

signal   S00MUL1_SE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S01MUL1_SE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S02MUL1_SE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S03MUL1_SE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S04MUL1_SE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S05MUL1_SE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S06MUL1_SE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S07MUL1_SE   : std_logic_vector ( 63 downto  0);-- partial sum

signal   C00MUL1_SE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C01MUL1_SE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C02MUL1_SE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C03MUL1_SE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C04MUL1_SE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C05MUL1_SE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C05MUL1_RE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C05MUL1_SM   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C06MUL1_SE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C07MUL1_SE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C07MUL1_RE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C07MUL1_SM   : std_logic_vector ( 63 downto  0);-- partial cry

signal   S00MUL2_SE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S00MUL2_RE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S00MUL2_SM   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S01MUL2_SE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S01MUL2_RE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S01MUL2_SM   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S02MUL2_SE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S02MUL2_RE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S02MUL2_SM   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S03MUL2_SE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S03MUL2_RE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S03MUL2_SM   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S04MUL2_SE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S04MUL2_RE   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S04MUL2_SM   : std_logic_vector ( 63 downto  0);-- partial sum

signal   C00MUL2_SE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C00MUL2_RE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C00MUL2_SM   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C01MUL2_SE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C01MUL2_RE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C01MUL2_SM   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C02MUL2_SE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C02MUL2_RE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C02MUL2_SM   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C03MUL2_SE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C03MUL2_RE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C03MUL2_SM   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C04MUL2_SE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C04MUL2_RE   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C04MUL2_SM   : std_logic_vector ( 63 downto  0);-- partial cry

signal   S00MUL3_SM   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S01MUL3_SM   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S02MUL3_SM   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S03MUL3_SM   : std_logic_vector ( 63 downto  0);-- partial sum

signal   C00MUL3_SM   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C01MUL3_SM   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C02MUL3_SM   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C03MUL3_SM   : std_logic_vector ( 63 downto  0);-- partial cry

signal   S00MUL4_SM   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S01MUL4_SM   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S02MUL4_SM   : std_logic_vector ( 63 downto  0);-- partial sum

signal   C00MUL4_SM   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C01MUL4_SM   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C02MUL4_SM   : std_logic_vector ( 63 downto  0);-- partial cry

signal   S00MUL5_SM   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S01MUL5_SM   : std_logic_vector ( 63 downto  0);-- partial sum

signal   C00MUL5_SM   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C01MUL5_SM   : std_logic_vector ( 63 downto  0);-- partial cry

signal   S00MUL6_SM   : std_logic_vector ( 63 downto  0);-- partial sum

signal   C00MUL6_SM   : std_logic_vector ( 63 downto  0);-- partial cry

signal   S00MUL7_SM   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S00MUL7_RM   : std_logic_vector ( 63 downto  0);-- partial sum
signal   S00MUL7_SW   : std_logic_vector ( 63 downto  0);-- partial sum

signal   C00MUL7_SM   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C00MUL7_RM   : std_logic_vector ( 63 downto  0);-- partial cry
signal   C00MUL7_SW   : std_logic_vector ( 63 downto  0);-- partial cry

signal   MULPR0_SW    : std_logic_vector ( 63 downto  0);-- propagate
signal   MULPR1_SW    : std_logic_vector ( 63 downto  0);-- propagate
signal   MULPR2_SW    : std_logic_vector ( 63 downto  0);-- propagate
signal   MULPR3_SW    : std_logic_vector ( 63 downto  0);-- propagate
signal   MULPR4_SW    : std_logic_vector ( 63 downto  0);-- propagate
signal   MULPR5_SW    : std_logic_vector ( 63 downto  0);-- propagate
signal   MULPR6_SW    : std_logic_vector ( 63 downto  0);-- propagate

signal   MULGN0_SW    : std_logic_vector ( 63 downto  0);-- generate
signal   MULGN1_SW    : std_logic_vector ( 63 downto  0);-- generate
signal   MULGN2_SW    : std_logic_vector ( 63 downto  0);-- generate
signal   MULGN3_SW    : std_logic_vector ( 63 downto  0);-- generate
signal   MULGN4_SW    : std_logic_vector ( 63 downto  0);-- generate
signal   MULGN5_SW    : std_logic_vector ( 63 downto  0);-- generate
signal   MULGN6_SW    : std_logic_vector ( 63 downto  0);-- generate

signal   MULCRY_SW    : std_logic_vector ( 63 downto  0);-- cry
signal   MULCYI_SW    : std_logic_vector ( 63 downto  0);-- cry
signal   MULSUM_SW    : std_logic_vector ( 63 downto  0);-- sum

signal   RMUL_SW      : std_logic_vector ( 63 downto  0);-- result

signal   NEXTMIC_SE   : std_logic_vector (  2 downto  0);
signal   MIC_RE       : std_logic_vector (  2 downto  0);

signal   XDIV_SE      : std_logic_vector ( 31 downto  0);
signal   YDIV_SE      : std_logic_vector ( 31 downto  0);

signal   DIVXSGN_SE   : std_logic                       ;
signal   DIVYSGN_SE   : std_logic                       ;
signal   DIVQSGN_SE   : std_logic                       ;

signal   DIVRX_SE     : std_logic_vector ( 31 downto  0);

signal   DIVRPR0_SE   : std_logic_vector ( 31 downto  0);
signal   DIVRPR1_SE   : std_logic_vector ( 31 downto  0);
signal   DIVRPR2_SE   : std_logic_vector ( 31 downto  0);
signal   DIVRPR3_SE   : std_logic_vector ( 31 downto  0);
signal   DIVRPR4_SE   : std_logic_vector ( 31 downto  0);
signal   DIVRPR5_SE   : std_logic_vector ( 31 downto  0);

signal   DIVRCRY_SE   : std_logic_vector ( 31 downto  0);
signal   DIVRCYI_SE   : std_logic_vector ( 31 downto  0);
signal   DIVRNEG_SE   : std_logic_vector ( 31 downto  0);

signal   DIVREFF_SE   : std_logic_vector ( 31 downto  0);

signal   DIVQY_SE     : std_logic_vector ( 31 downto  0);

signal   DIVQPR0_SE   : std_logic_vector ( 31 downto  0);
signal   DIVQPR1_SE   : std_logic_vector ( 31 downto  0);
signal   DIVQPR2_SE   : std_logic_vector ( 31 downto  0);
signal   DIVQPR3_SE   : std_logic_vector ( 31 downto  0);
signal   DIVQPR4_SE   : std_logic_vector ( 31 downto  0);
signal   DIVQPR5_SE   : std_logic_vector ( 31 downto  0);

signal   DIVQCRY_SE   : std_logic_vector ( 31 downto  0);
signal   DIVQCYI_SE   : std_logic_vector ( 31 downto  0);
signal   DIVQNEG_SE   : std_logic_vector ( 31 downto  0);

signal   DIVQEFF_SE   : std_logic_vector ( 31 downto  0);

signal   DIVXEFF_SE   : std_logic_vector ( 31 downto  0);

signal   DIVXZP1_SE   : std_logic_vector ( 31 downto  0);
signal   DIVXZP2_SE   : std_logic_vector ( 31 downto  0);
signal   DIVXZP3_SE   : std_logic_vector ( 31 downto  0);
signal   DIVXZP4_SE   : std_logic_vector ( 31 downto  0);
signal   DIVXZP5_SE   : std_logic_vector ( 31 downto  0);

signal   DIVXZMK_SE   : std_logic_vector ( 31 downto  0);

signal   DIVXCZ5_SE   : std_logic                       ;
signal   DIVXCZ4_SE   : std_logic                       ;
signal   DIVXCZ3_SE   : std_logic                       ;
signal   DIVXCZ2_SE   : std_logic                       ;
signal   DIVXCZ1_SE   : std_logic                       ;
signal   DIVXCZ0_SE   : std_logic                       ;
signal   DIVXCZ_SE    : std_logic_vector (  5 downto  0);

signal   DIVXCLZ_SE   : std_logic_vector (  5 downto  0);
signal   DIVXCLZ_RE   : std_logic_vector (  5 downto  0);

signal   DIVYEFF_SE   : std_logic_vector ( 31 downto  0);

signal   DIVYZP1_SE   : std_logic_vector ( 31 downto  0);
signal   DIVYZP2_SE   : std_logic_vector ( 31 downto  0);
signal   DIVYZP3_SE   : std_logic_vector ( 31 downto  0);
signal   DIVYZP4_SE   : std_logic_vector ( 31 downto  0);
signal   DIVYZP5_SE   : std_logic_vector ( 31 downto  0);

signal   DIVYZMK_SE   : std_logic_vector ( 31 downto  0);

signal   DIVYCZ5_SE   : std_logic                       ;
signal   DIVYCZ4_SE   : std_logic                       ;
signal   DIVYCZ3_SE   : std_logic                       ;
signal   DIVYCZ2_SE   : std_logic                       ;
signal   DIVYCZ1_SE   : std_logic                       ;
signal   DIVYCZ0_SE   : std_logic                       ;
signal   DIVYCZ_SE    : std_logic_vector (  5 downto  0);

signal   DIVSCYI_SE   : std_logic_vector (  5 downto  0);
signal   DIVSCRY_SE   : std_logic_vector (  5 downto  0);
signal   DIVSCNT_SE   : std_logic_vector (  5 downto  0);

signal   DIVYCLZ_SE   : std_logic_vector (  5 downto  0);
signal   DIVYCLZ_RE   : std_logic_vector (  5 downto  0);
signal   DIVSCNZ_SE   : std_logic                       ;

signal   DIVYSHA_SE   : std_logic_vector (  4 downto  0);
signal   DIVYSHL_SE   : std_logic_vector ( 31 downto  0);
signal   DIVYSHR_SE   : std_logic_vector ( 31 downto  0);

signal   DIVDPR0_SE   : std_logic_vector ( 31 downto  0);
signal   DIVDPR1_SE   : std_logic_vector ( 31 downto  0);
signal   DIVDPR2_SE   : std_logic_vector ( 31 downto  0);
signal   DIVDPR3_SE   : std_logic_vector ( 31 downto  0);
signal   DIVDPR4_SE   : std_logic_vector ( 31 downto  0);
signal   DIVDPR5_SE   : std_logic_vector ( 31 downto  0);

signal   DIVDGN0_SE   : std_logic_vector ( 31 downto  0);
signal   DIVDGN1_SE   : std_logic_vector ( 31 downto  0);
signal   DIVDGN2_SE   : std_logic_vector ( 31 downto  0);
signal   DIVDGN3_SE   : std_logic_vector ( 31 downto  0);
signal   DIVDGN4_SE   : std_logic_vector ( 31 downto  0);
signal   DIVDGN5_SE   : std_logic_vector ( 31 downto  0);

signal   DIVDCRY_SE   : std_logic_vector ( 31 downto  0);
signal   DIVDCYI_SE   : std_logic_vector ( 31 downto  0);
signal   DIVDIF_SE    : std_logic_vector ( 31 downto  0);

signal   DIVLPR0_SE   : std_logic_vector ( 31 downto  0);
signal   DIVLPR1_SE   : std_logic_vector ( 31 downto  0);
signal   DIVLPR2_SE   : std_logic_vector ( 31 downto  0);
signal   DIVLPR3_SE   : std_logic_vector ( 31 downto  0);
signal   DIVLPR4_SE   : std_logic_vector ( 31 downto  0);
signal   DIVLPR5_SE   : std_logic_vector ( 31 downto  0);

signal   DIVLGN0_SE   : std_logic_vector ( 31 downto  0);
signal   DIVLGN1_SE   : std_logic_vector ( 31 downto  0);
signal   DIVLGN2_SE   : std_logic_vector ( 31 downto  0);
signal   DIVLGN3_SE   : std_logic_vector ( 31 downto  0);
signal   DIVLGN4_SE   : std_logic_vector ( 31 downto  0);
signal   DIVLGN5_SE   : std_logic_vector ( 31 downto  0);

signal   DIVLEU_SE    : std_logic                       ;

signal   DIVX_SE      : std_logic_vector ( 31 downto  0);
signal   DIVX_RE      : std_logic_vector ( 31 downto  0);
signal   DIVR_RM      : std_logic_vector ( 31 downto  0);

signal   DIVY_SE      : std_logic_vector ( 31 downto  0);
signal   DIVY_RE      : std_logic_vector ( 31 downto  0);

signal   DIVQSHL_SE   : std_logic_vector ( 31 downto  0);
signal   DIVQ_SE      : std_logic_vector ( 31 downto  0);
signal   DIVQ_RE      : std_logic_vector ( 31 downto  0);
signal   DIVQ_RM      : std_logic_vector ( 31 downto  0);

signal   DACCESS_SE   : std_logic                       ;-- data  acs
signal   WRITE_SE     : std_logic                       ;-- write acs
signal   WRITE_RE     : std_logic                       ;-- write acs
signal   READ_SE      : std_logic                       ;-- read  acs
signal   READ_RE      : std_logic                       ;-- read  acs
signal   DREAD_RM     : std_logic                       ;-- data read

signal   DRQ_SE       : std_logic                       ;-- data rqst
signal   DRQ_RE       : std_logic                       ;-- data rqst

signal   DRSTLK_SE    : std_logic                       ;-- reset linked
signal   DRSTLK_RE    : std_logic                       ;-- reset linked

signal   DSYNC_SE     : std_logic                       ;-- sync
signal   DSYNC_RE     : std_logic                       ;-- sync

signal   DCACHE_SE    : std_logic                       ;-- cache op
signal   DCACHE_RE    : std_logic                       ;-- cache op

signal   DNOTRDY_SM   : std_logic                       ;-- data not ready

signal   BYTSEL_SE    : std_logic_vector (  3 downto  0);-- byte select
signal   BYTSEL_RE    : std_logic_vector (  3 downto  0);-- byte select

signal   BYTADR_SM    : std_logic_vector (  1 downto  0);-- byte  adr
signal   DIN_SM       : std_logic_vector ( 31 downto  0);-- align data
signal   WRDIN_SM     : std_logic_vector ( 31 downto  0);-- lwr   data
signal   WLDIN_SM     : std_logic_vector ( 31 downto  0);-- lwl   data
signal   SCDIN_SM     : std_logic_vector ( 31 downto  0);-- sc    data
signal   BSEXT_SM     : std_logic_vector ( 23 downto  0);-- sign  ext byte
signal   HSEXT_SM     : std_logic_vector ( 15 downto  0);-- sign  ext half
signal   DATA_SM      : std_logic_vector ( 31 downto  0);-- read  data

signal   DATA_RM      : std_logic_vector ( 31 downto  0);-- data
signal   DATA_SW      : std_logic_vector ( 31 downto  0);-- data

signal   BADVA_RX     : std_logic_vector ( 31 downto  0);-- bad virtual adr
signal   WBADIA_XM    : std_logic                       ;-- bad inst adr
signal   WBADDA_XM    : std_logic                       ;-- bad data adr

signal   IT_XX        : std_logic_vector (  5 downto  0);-- external int

signal   GLBMSK_XX    : std_logic                       ;-- int mask
signal   ITMASK_XX    : std_logic_vector (  7 downto  0);-- int mask

signal   ENBLIT_XX    : std_logic_vector (  7 downto  0);-- enabled   it
signal   HWSWIT_XX    : std_logic                       ;-- any hw-sw it
signal   HWSWIT_RX    : std_logic                       ;-- any hw-sw it

signal   INTRQ_XX     : std_logic                       ;-- it rqst
signal   INTRQ_RX     : std_logic                       ;-- it rqst

signal   BDSLOT_XI    : std_logic                       ;-- brch delyd slot
signal   BDSLOT_XM    : std_logic                       ;-- brch delyd slot
signal   BDSLOT_RI    : std_logic                       ;-- brch delyd slot
signal   BDSLOT_RD    : std_logic                       ;-- brch delyd slot
signal   BDSLOT_RE    : std_logic                       ;-- brch delyd slot

signal   USRMOD_SX    : std_logic                       ;-- user mode

signal   RSVDINS_XD   : std_logic                       ;-- reserved inst
signal   RSVDINS_RD   : std_logic                       ;-- reserved inst
signal   RSVDINS_XE   : std_logic                       ;-- reserved inst
signal   RSVDINS_RE   : std_logic                       ;-- reserved inst

signal   CPUNUSE_XD   : std_logic                       ;-- copro unusable
signal   CPUNUSE_RD   : std_logic                       ;-- copro unusable
signal   CPUNUSE_RE   : std_logic                       ;-- copro unusable

signal   CPNBR_XD     : std_logic_vector (  1 downto  0);-- copro nbr
signal   CPNBR_RD     : std_logic_vector (  1 downto  0);-- copro nbr
signal   CPNBR_RE     : std_logic_vector (  1 downto  0);-- copro nbr

signal   IAMALGN_XI   : std_logic                       ;-- inst  adr algn
signal   IAMALGN_RI   : std_logic                       ;-- inst  adr algn
signal   IAMALGN_RD   : std_logic                       ;-- inst  adr algn
signal   IAMALGN_RE   : std_logic                       ;-- inst  adr algn

signal   DAMALGN_XE   : std_logic                       ;-- data  adr algn

signal   LAMALGN_XE   : std_logic                       ;-- load  adr algn
signal   LAMALGN_RE   : std_logic                       ;-- load  adr algn

signal   SAMALGN_XE   : std_logic                       ;-- store adr algn
signal   SAMALGN_RE   : std_logic                       ;-- store adr algn

signal   IASVIOL_XI   : std_logic                       ;-- inst  adr viol
signal   IASVIOL_RI   : std_logic                       ;-- inst  adr viol
signal   IASVIOL_RD   : std_logic                       ;-- inst  adr viol
signal   IASVIOL_RE   : std_logic                       ;-- inst  adr viol

signal   DASVIOL_XE   : std_logic                       ;-- data  adr viol

signal   LASVIOL_XE   : std_logic                       ;-- load  adr viol
signal   LASVIOL_RE   : std_logic                       ;-- load  adr viol

signal   SASVIOL_XE   : std_logic                       ;-- store adr viol
signal   SASVIOL_RE   : std_logic                       ;-- store adr viol

signal   IABUSER_XI   : std_logic                       ;-- inst adr bus err
signal   IABUSER_RI   : std_logic                       ;-- inst adr bus err
signal   IABUSER_RD   : std_logic                       ;-- inst adr bus err
signal   IABUSER_RE   : std_logic                       ;-- inst adr bus err

signal   IBEREN_SX    : std_logic                       ;-- error enable

signal   OVRF_XE      : std_logic                       ;-- overflow
signal   OVRF_RE      : std_logic                       ;-- overflow

signal   DABUSER_XM   : std_logic                       ;-- data adr bus err

signal   MCHECK_RX    : std_logic                       ;-- machine chk
signal   MCHECKX_XX   : std_logic                       ;-- machine chk exc
signal   MCHECKX_RX   : std_logic                       ;-- machine chk exc

signal   EARLYEX_XE   : std_logic                       ;-- early exc
signal   EARLYEX_RE   : std_logic                       ;-- early exc

signal   LATEEX_XM    : std_logic                       ;-- late  exc

signal   EXCRQ_XM     : std_logic                       ;-- exc   rqst

signal   EPC_XM       : std_logic_vector ( 31 downto  0);-- exc pg cntr
signal   EPC_SM       : std_logic_vector ( 31 downto  0);-- exc pg cntr
signal   EPC_RX       : std_logic_vector ( 31 downto  0);-- exc pg cntr
signal   WEPC_XM      : std_logic                       ;-- epc write en
signal   WEPC_SM      : std_logic                       ;-- epc write en

signal   EEPC_XX      : std_logic_vector ( 31 downto  0);-- err exc pg cntr
signal   EEPC_SM      : std_logic_vector ( 31 downto  0);-- err exc pg cntr
signal   EEPC_RX      : std_logic_vector ( 31 downto  0);-- err exc pg cntr
signal   WEEPC_XX     : std_logic                       ;-- err epc wen
signal   WEEPC_SM     : std_logic                       ;-- err epc wen

signal   EBASE_XX     : std_logic_vector ( 31 downto  0);-- exc base reg
signal   EBASE_SM     : std_logic_vector ( 31 downto  0);-- exc base reg
signal   EBASE_RM     : std_logic_vector ( 31 downto  0);-- exc base reg
signal   WEBASE_XX    : std_logic                       ;-- exc base wen
signal   WEBASE_SM    : std_logic                       ;-- exc base wen

signal   CNTCYI_SX    : std_logic_vector ( 31 downto  0);-- count cry
signal   CNTCRY_SX    : std_logic_vector ( 31 downto  0);-- count cry

signal   CNTPR0_SX    : std_logic_vector ( 31 downto  0);-- count pro
signal   CNTPR1_SX    : std_logic_vector ( 31 downto  0);-- count pro
signal   CNTPR2_SX    : std_logic_vector ( 31 downto  0);-- count pro
signal   CNTPR3_SX    : std_logic_vector ( 31 downto  0);-- count pro
signal   CNTPR4_SX    : std_logic_vector ( 31 downto  0);-- count pro
signal   CNTPR5_SX    : std_logic_vector ( 31 downto  0);-- count pro

signal   COUNT_SX     : std_logic_vector ( 31 downto  0);-- count
signal   COUNT_SM     : std_logic_vector ( 31 downto  0);-- count
signal   COUNT_RX     : std_logic_vector ( 31 downto  0);-- count reg
signal   WCOUNT_SX    : std_logic                       ;-- count write en
signal   WCOUNT_SM    : std_logic                       ;-- count write en

signal   TCCTX_SM     : std_logic_vector ( 31 downto  0);-- tccontext
signal   TCCTX_RM     : std_logic_vector ( 31 downto  0);-- tccontext
signal   WTCCTX_SM    : std_logic                       ;-- tccontext wen

signal   USRLCL_RM    : std_logic_vector ( 31 downto  0);-- impl def reg
signal   WUSRLCL_SM   : std_logic                       ;-- impl def reg wen

signal   HWRENA_RM    : std_logic_vector ( 31 downto  0);-- hw r enable
signal   WHWRENA_SM   : std_logic                       ;-- hw r enable wen

signal   RESET_RX     : std_logic                       ;-- reset

signal   R1_RW        : std_logic_vector ( 31 downto  0);-- int reg nbr  1
signal   R2_RW        : std_logic_vector ( 31 downto  0);-- int reg nbr  2
signal   R3_RW        : std_logic_vector ( 31 downto  0);-- int reg nbr  3
signal   R4_RW        : std_logic_vector ( 31 downto  0);-- int reg nbr  4
signal   R5_RW        : std_logic_vector ( 31 downto  0);-- int reg nbr  5
signal   R6_RW        : std_logic_vector ( 31 downto  0);-- int reg nbr  6
signal   R7_RW        : std_logic_vector ( 31 downto  0);-- int reg nbr  7
signal   R8_RW        : std_logic_vector ( 31 downto  0);-- int reg nbr  8
signal   R9_RW        : std_logic_vector ( 31 downto  0);-- int reg nbr  9
signal   R10_RW       : std_logic_vector ( 31 downto  0);-- int reg nbr 10
signal   R11_RW       : std_logic_vector ( 31 downto  0);-- int reg nbr 11
signal   R12_RW       : std_logic_vector ( 31 downto  0);-- int reg nbr 12
signal   R13_RW       : std_logic_vector ( 31 downto  0);-- int reg nbr 13
signal   R14_RW       : std_logic_vector ( 31 downto  0);-- int reg nbr 14
signal   R15_RW       : std_logic_vector ( 31 downto  0);-- int reg nbr 15
signal   R16_RW       : std_logic_vector ( 31 downto  0);-- int reg nbr 16
signal   R17_RW       : std_logic_vector ( 31 downto  0);-- int reg nbr 17
signal   R18_RW       : std_logic_vector ( 31 downto  0);-- int reg nbr 18
signal   R19_RW       : std_logic_vector ( 31 downto  0);-- int reg nbr 19
signal   R20_RW       : std_logic_vector ( 31 downto  0);-- int reg nbr 20
signal   R21_RW       : std_logic_vector ( 31 downto  0);-- int reg nbr 21
signal   R22_RW       : std_logic_vector ( 31 downto  0);-- int reg nbr 22
signal   R23_RW       : std_logic_vector ( 31 downto  0);-- int reg nbr 23
signal   R24_RW       : std_logic_vector ( 31 downto  0);-- int reg nbr 24
signal   R25_RW       : std_logic_vector ( 31 downto  0);-- int reg nbr 25
signal   R26_RW       : std_logic_vector ( 31 downto  0);-- int reg nbr 26
signal   R27_RW       : std_logic_vector ( 31 downto  0);-- int reg nbr 27
signal   R28_RW       : std_logic_vector ( 31 downto  0);-- int reg nbr 28
signal   R29_RW       : std_logic_vector ( 31 downto  0);-- int reg nbr 29
signal   R30_RW       : std_logic_vector ( 31 downto  0);-- int reg nbr 30
signal   R31_RW       : std_logic_vector ( 31 downto  0);-- int reg nbr 31

signal   LO_SW        : std_logic_vector ( 31 downto  0);-- low reg
signal   LO_RW        : std_logic_vector ( 31 downto  0);-- low reg

signal   HI_SW        : std_logic_vector ( 31 downto  0);-- high reg
signal   HI_RW        : std_logic_vector ( 31 downto  0);-- high reg
-- 

constant R0_RW        : std_logic_vector ( 31 downto  0) := X"00000000" ;
constant PRID_RX      : std_logic_vector ( 31 downto  0) := X"00000000" ;
--constant cpu_nbr      : std_logic_vector (  9 downto  0) := B"0000000000";

constant nop_i        : std_logic_vector ( 31 downto  0) := X"00000000" ;
signal   nop_type     : std_logic_vector ( 40 downto  0)                ;

constant iline_msk    : std_logic_vector ( 31 downto  0) := X"ffffffc3" ;

constant m_writ_w     : std_logic_vector (  1 downto  0) := B"00"       ;
constant m_writ_h     : std_logic_vector (  1 downto  0) := B"10"       ;
constant m_writ_b     : std_logic_vector (  1 downto  0) := B"11"       ;
constant m_read_w     : std_logic_vector (  1 downto  0) := B"01"       ;

constant bootexc_a    : std_logic_vector ( 31 downto  0) := BOOTEXC_ADDR;
constant reset_a      : std_logic_vector ( 31 downto  0) := RESET_ADDR  ;

constant c0_badva     : std_logic_vector (  7 downto  0) := B"01000000" ;
constant c0_count     : std_logic_vector (  7 downto  0) := B"01001000" ;
constant c0_status    : std_logic_vector (  7 downto  0) := B"01100000" ;
constant c0_cause     : std_logic_vector (  7 downto  0) := B"01101000" ;
constant c0_epc       : std_logic_vector (  7 downto  0) := B"01110000" ;
constant c0_prid      : std_logic_vector (  7 downto  0) := B"01111000" ;
constant c0_ebase     : std_logic_vector (  7 downto  0) := B"01111001" ;
constant c0_eepc      : std_logic_vector (  7 downto  0) := B"11110000" ;
constant c0_tcctx     : std_logic_vector (  7 downto  0) := B"00010101" ;
constant c0_usrlcl    : std_logic_vector (  7 downto  0) := B"00100010" ;
constant c0_hwrena    : std_logic_vector (  7 downto  0) := B"00111000" ;

constant hw_count     : std_logic_vector (  4 downto  0) := B"00010"    ;
constant hw_cpunbr    : std_logic_vector (  4 downto  0) := B"00000"    ;
constant hw_usrlcl    : std_logic_vector (  4 downto  0) := B"11101"    ;

constant r_fmt_o      : std_logic_vector (  3 downto  0) := B"0001"     ;
constant i_fmt_o      : std_logic_vector (  3 downto  0) := B"0010"     ;
constant j_fmt_o      : std_logic_vector (  3 downto  0) := B"0100"     ;
constant illgl_o      : std_logic_vector (  3 downto  0) := B"1000"     ;

constant du_s_o       : std_logic_vector (  1 downto  0) := B"10"       ;
constant eu_s_o       : std_logic_vector (  1 downto  0) := B"01"       ;
constant no_s_o       : std_logic_vector (  1 downto  0) := B"00"       ;

constant du_t_o       : std_logic_vector (  1 downto  0) := B"10"       ;
constant eu_t_o       : std_logic_vector (  1 downto  0) := B"01"       ;
constant no_t_o       : std_logic_vector (  1 downto  0) := B"00"       ;

constant eu_h_o       : std_logic_vector (  1 downto  0) := B"10"       ;
constant mu_h_o       : std_logic_vector (  1 downto  0) := B"01"       ;
constant no_h_o       : std_logic_vector (  1 downto  0) := B"00"       ;

constant eu_l_o       : std_logic_vector (  1 downto  0) := B"10"       ;
constant mu_l_o       : std_logic_vector (  1 downto  0) := B"01"       ;
constant no_l_o       : std_logic_vector (  1 downto  0) := B"00"       ;

constant o_sgn_o      : std_logic                        :=  '1'        ;
constant o_usg_o      : std_logic                        :=  '0'        ;

constant add_o        : std_logic_vector (  6 downto  0) := B"001_000_0";
constant sub_o        : std_logic_vector (  6 downto  0) := B"001_001_0";
constant shl_o        : std_logic_vector (  6 downto  0) := B"010_000_0";
constant shr_o        : std_logic_vector (  6 downto  0) := B"010_001_0";
constant eq_o         : std_logic_vector (  6 downto  0) := B"011_000_0";
constant ne_o         : std_logic_vector (  6 downto  0) := B"011_010_0";
constant ltu_o        : std_logic_vector (  6 downto  0) := B"011_001_0";
constant geu_o        : std_logic_vector (  6 downto  0) := B"011_011_0";
constant lt_o         : std_logic_vector (  6 downto  0) := B"011_101_0";
constant ge_o         : std_logic_vector (  6 downto  0) := B"011_111_0";
constant or_o         : std_logic_vector (  6 downto  0) := B"100_000_0";
constant and_o        : std_logic_vector (  6 downto  0) := B"100_001_0";
constant xor_o        : std_logic_vector (  6 downto  0) := B"100_010_0";
constant nor_o        : std_logic_vector (  6 downto  0) := B"100_011_0";
constant toper_o      : std_logic_vector (  6 downto  0) := B"101_001_0";
constant soper_o      : std_logic_vector (  6 downto  0) := B"101_010_0";
constant ioper_o      : std_logic_vector (  6 downto  0) := B"101_000_0";
constant clo_o        : std_logic_vector (  6 downto  0) := B"110_000_0";
constant clz_o        : std_logic_vector (  6 downto  0) := B"110_001_0";
constant msub_o       : std_logic_vector (  6 downto  0) := B"000_001_0";
constant madd_o       : std_logic_vector (  6 downto  0) := B"000_010_0";
constant mult_o       : std_logic_vector (  6 downto  0) := B"000_000_0";
constant div_o        : std_logic_vector (  6 downto  0) := B"000001_1" ;

constant ovr_o        : std_logic_vector (  3 downto  0) := B"0001"     ;
constant trp_o        : std_logic_vector (  3 downto  0) := B"0010"     ;
constant sys_o        : std_logic_vector (  3 downto  0) := B"0100"     ;
constant brk_o        : std_logic_vector (  3 downto  0) := B"1000"     ;
constant nox_o        : std_logic_vector (  3 downto  0) := B"0000"     ;

constant e_pd_o       : std_logic_vector (  2 downto  0) := B"100"      ;
constant m_pd_o       : std_logic_vector (  2 downto  0) := B"010"      ;
constant w_pd_o       : std_logic_vector (  2 downto  0) := B"001"      ;
constant no_pd_o      : std_logic_vector (  2 downto  0) := B"000"      ;

constant s_i_o        : std_logic_vector (  3 downto  0) := B"0001"     ;
constant s_l_o        : std_logic_vector (  3 downto  0) := B"0010"     ;
constant s_h_o        : std_logic_vector (  3 downto  0) := B"0100"     ;
constant s_hl_o       : std_logic_vector (  3 downto  0) := B"0110"     ;
constant s_c_o        : std_logic_vector (  3 downto  0) := B"1000"     ;
constant no_sv_o      : std_logic_vector (  3 downto  0) := B"0000"     ;

constant no_br_o      : std_logic                        :=  '0'        ;
constant brnch_o      : std_logic                        :=  '1'        ;

constant m_lwd_o      : std_logic_vector (  8 downto  0) := B"100000100";
constant m_lwl_o      : std_logic_vector (  8 downto  0) := B"100000001";
constant m_lwr_o      : std_logic_vector (  8 downto  0) := B"100000010";
constant m_lhf_o      : std_logic_vector (  8 downto  0) := B"100001000";
constant m_lby_o      : std_logic_vector (  8 downto  0) := B"100010000";
constant m_swd_o      : std_logic_vector (  8 downto  0) := B"010000100";
constant m_swl_o      : std_logic_vector (  8 downto  0) := B"010000001";
constant m_swr_o      : std_logic_vector (  8 downto  0) := B"010000010";
constant m_shf_o      : std_logic_vector (  8 downto  0) := B"010001000";
constant m_sby_o      : std_logic_vector (  8 downto  0) := B"010010000";
constant m_llk_o      : std_logic_vector (  8 downto  0) := B"101000100";
constant m_slk_o      : std_logic_vector (  8 downto  0) := B"111000100";
constant m_lrg_o      : std_logic_vector (  8 downto  0) := B"100100100";
constant m_srg_o      : std_logic_vector (  8 downto  0) := B"010100100";
constant no_m_o       : std_logic_vector (  8 downto  0) := B"000000000";

constant imp_std      : std_logic_vector (  1 downto  0) := B"00"       ;
constant imp_tsr      : std_logic_vector (  1 downto  0) := B"01"       ;

constant exe_end      : std_logic_vector (  2 downto  0) := B"000"      ;
constant div_clz      : std_logic_vector (  2 downto  0) := B"001"      ;
constant div_cnt      : std_logic_vector (  2 downto  0) := B"010"      ;
constant div_shl      : std_logic_vector (  2 downto  0) := B"011"      ;
constant div_dif      : std_logic_vector (  2 downto  0) := B"100"      ;
constant div_lst      : std_logic_vector (  2 downto  0) := B"101"      ;

-- 

	-- ### ------------------------------------------------------ ###
	-- #   instruction set table :					#
	-- #								#
	-- #   Opcods in lower case are Mips-32 instructions		#
	-- #   Opcods in upper case are application specific		#
	-- #								#
	-- #								#
	-- #   primary opcod (31 downto 26) :				#
	-- #     |  0     1     2     3     4     5     6     7		#
	-- #   --+-----+-----+-----+-----+-----+-----+-----+-----+	#
	-- #   0 |speci|bcond|  j  | jal | beq | bne |blez |bgtz |	#
	-- #   1 |addi |addiu|slti |sltiu|andi | ori |xori | lui |	#
	-- #   2 |cop0 |  +  |cop2 |  +  |  +  |  +  |  +  |  +  |	#
	-- #   3 |     |     |     |     |spec2|  +  |     |spec3|	#
	-- #   4 | lb  | lh  | lwl | lw  | lbu | lhu | lwr |     |	#
	-- #   5 | sb  | sh  | swl | sw  |     |     | swr |cache|	#
	-- #   6 | ll  |  +  |  +  |pref |     |  +  |  +  |     |	#
	-- #   7 | sc  |  +  |  +  |  +  |     |  +  |  +  |     |	#
	-- #								#
	-- #								#
	-- #   special opcod extension (5 downto 0) :			#
	-- #     |  0     1     2     3     4     5     6     7		#
	-- #   --+-----+-----+-----+-----+-----+-----+-----+-----+	#
	-- #   0 | *** |  +  | srl | sra |sllv |     |srlv |srav |	#
	-- #   1 | jr  |jalr |movz |movn |sysca|break|     |sync |	#
	-- #   2 |mfhi |mthi |mflo |mtlo |     |     |     |     |	#
	-- #   3 |mult |multu| div |divu |     |     |     |     |	#
	-- #   4 | add |addu | sub |subu | and | or  | xor | nor |	#
	-- #   5 |     |     | slt |sltu |     |     |     |     |	#
	-- #   6 | tge |tgeu | tlt |tltu | teq |     | tne |     |	#
	-- #   7 |     |     |     |     |  +  |  +  |  +  |  +  |	#
	-- #								#
	-- #   *** : Specific rt, rd, and sham make the distinction	#
	-- #         between sll					#
	-- #         and     nop : sll r0, r0, 0			#
	-- #         and     ehb : sll r0, r0, 3			#
	-- #								#
	-- #								#
	-- #   special2 opcod extension (5 downto 0) :			#
	-- #     |  0     1     2     3     4     5     6     7		#
	-- #   --+-----+-----+-----+-----+-----+-----+-----+-----+	#
	-- #   0 |madd |maddu| mul |     |msub |msubu|     |     |	#
	-- #   1 |     |     |     |     |     |     |     |     |	#
	-- #   2 |     |     |     |     |     |     |     |     |	#
	-- #   3 |     |     |     |     |     |     |     |     |	#
	-- #   4 | clz | clo |     |     |     |     |     |     |	#
	-- #   5 |     |     |     |     |     |     |     |     |	#
	-- #   6 |     |     |     |     |     |     |     |     |	#
	-- #   7 |     |     |     |     |     |     |     |  +  |	#
	-- #								#
	-- #								#
	-- #   special3 opcod extension (5 downto 0) :			#
	-- #     |  0     1     2     3     4     5     6     7		#
	-- #   --+-----+-----+-----+-----+-----+-----+-----+-----+	#
	-- #   0 |  +  |     |     |     |  +  |     |     |     |	#
	-- #   1 |     |     |     |     |     |     |     |     |	#
	-- #   2 |     |     |     |     |     |     |     |     |	#
	-- #   3 |     |     |     |     |     |     |     |     |	#
	-- #   4 |  +  |     |     |     |     |     |     |     |	#
	-- #   5 |     |     |     |     |     |     |     |     |	#
	-- #   6 |     |     |     |     |     |     |     |     |	#
	-- #   7 |     |     |     |rdhwr|     |     |     |     |	#
	-- #								#
	-- #								#
	-- #   bcond opcod extension (20 downto 16) :			#
	-- #     |  0     1     2     3     4     5     6     7		#
	-- #   --+-----+-----+-----+-----+-----+-----+-----+-----+	#
	-- #   0 |bltz |bgez |  +  |  +  |     |     |     |     |	#
	-- #   1 |tgei |tgeiu|tlti |tltiu|teqi |     |tnei |     |	#
	-- #   2 |bltza|bgeza|  +  |  +  |     |     |     |     |	#
	-- #   3 |     |     |     |     |     |     |     |  +  |	#
	-- #								#
	-- #								#
	-- #   cop0 opcod extension (25 downto 21) :			#
	-- #     |  0     1     2     3     4     5     6     7		#
	-- #   --+-----+-----+-----+-----+-----+-----+-----+-----+	#
	-- #   0 |mfc0 |     |  +  |  +  |mtc0 |     |  +  |  +  |	#
	-- #   1 |  +  |  +  |  +  |mfmc0|  +  |  +  |  +  |  +  |	#
	-- #   2 | c0  | c0  | c0  | c0  | c0  | c0  | c0  | c0  |	#
	-- #   3 | c0  | c0  | c0  | c0  | c0  | c0  | c0  | c0  |	#
	-- #								#
	-- #								#
	-- #   mfmc0 cop0 extension extension (5) :			#
	-- #     |  0     1						#
	-- #   --+-----+-----+						#
	-- #     | di  | ei  |						#
	-- #								#
	-- #								#
	-- #   c0 cop0 extension extension (5 downto 0) :		#
	-- #     |  0     1     2     3     4     5     6     7		#
	-- #   --+-----+-----+-----+-----+-----+-----+-----+-----+	#
	-- #   0 |     |  +  |  +  |     |     |     |  +  |     |	#
	-- #   1 |  +  |     |     |     |     |     |     |     |	#
	-- #   2 |  +  |     |     |     |     |     |     |     |	#
	-- #   3 |eret |     |     |     |     |     |     |  +  |	#
	-- #   4 |wait |     |     |     |     |     |     |     |	#
	-- #   5 |     |     |     |     |     |     |     |     |	#
	-- #   6 |     |     |     |     |     |     |     |     |	#
	-- #   7 |     |     |     |     |     |     |     |     |	#
	-- #								#
	-- #								#
	-- #   cop2 opcod extension (25 downto 21) :			#
	-- #     |  0     1     2     3     4     5     6     7		#
	-- #   --+-----+-----+-----+-----+-----+-----+-----+-----+	#
	-- #   0 |mfc2 |     |  +  |  +  |mtc2 |     |  +  |  +  |	#
	-- #   1 |  +  |  +  |  +  |  +  |  +  |  +  |  +  |  +  |	#
	-- #   2 |  +  |  +  |  +  |  +  |  +  |  +  |  +  |  +  |	#
	-- #   3 |  +  |  +  |  +  |  +  |  +  |  +  |  +  |  +  |	#
	-- #								#
	-- ### ------------------------------------------------------ ###

constant special_g    : std_logic_vector (  2 downto  0) := B"000"       ;
constant special2_g   : std_logic_vector (  2 downto  0) := B"010"       ;
constant special3_g   : std_logic_vector (  2 downto  0) := B"011"       ;
constant others_g     : std_logic_vector (  2 downto  0) := B"001"       ;
constant bcond_g      : std_logic_vector (  3 downto  0) := B"1000"      ;
constant cop0_g       : std_logic_vector (  1 downto  0) := B"10"        ;
constant cop2_g       : std_logic_vector (  1 downto  0) := B"11"        ;

constant special_i    : std_logic_vector (  5 downto  0) := B"000_000"   ;
constant special2_i   : std_logic_vector (  5 downto  0) := B"011_100"   ;
constant special3_i   : std_logic_vector (  5 downto  0) := B"011_111"   ;
constant bcond_i      : std_logic_vector (  5 downto  0) := B"000_001"   ;
constant cop0_i       : std_logic_vector (  5 downto  0) := B"010_000"   ;
constant cop2_i       : std_logic_vector (  5 downto  0) := B"010_010"   ;

constant add_i        : std_logic_vector (  8 downto  0) := B"000_100000";
constant addi_i       : std_logic_vector (  8 downto  0) := B"001_001000";
constant addiu_i      : std_logic_vector (  8 downto  0) := B"001_001001";
constant addu_i       : std_logic_vector (  8 downto  0) := B"000_100001";
constant and_i        : std_logic_vector (  8 downto  0) := B"000_100100";
constant andi_i       : std_logic_vector (  8 downto  0) := B"001_001100";
constant beq_i        : std_logic_vector (  8 downto  0) := B"001_000100";
constant bgez_i       : std_logic_vector (  8 downto  0) := B"1000_00001";
constant bgezal_i     : std_logic_vector (  8 downto  0) := B"1000_10001";
constant bgtz_i       : std_logic_vector (  8 downto  0) := B"001_000111";
constant blez_i       : std_logic_vector (  8 downto  0) := B"001_000110";
constant bltz_i       : std_logic_vector (  8 downto  0) := B"1000_00000";
constant bltzal_i     : std_logic_vector (  8 downto  0) := B"1000_10000";
constant bne_i        : std_logic_vector (  8 downto  0) := B"001_000101";
constant break_i      : std_logic_vector (  8 downto  0) := B"000_001101";
constant cache_i      : std_logic_vector (  8 downto  0) := B"001_101111";
constant clo_i        : std_logic_vector (  8 downto  0) := B"010_100001";
constant clz_i        : std_logic_vector (  8 downto  0) := B"010_100000";
constant div_i        : std_logic_vector (  8 downto  0) := B"000_011010";
constant divu_i       : std_logic_vector (  8 downto  0) := B"000_011011";
constant eret_i       : std_logic_vector (  8 downto  0) := B"10_1011000";
constant j_i          : std_logic_vector (  8 downto  0) := B"001_000010";
constant jal_i        : std_logic_vector (  8 downto  0) := B"001_000011";
constant jalr_i       : std_logic_vector (  8 downto  0) := B"000_001001";
constant jr_i         : std_logic_vector (  8 downto  0) := B"000_001000";
constant lb_i         : std_logic_vector (  8 downto  0) := B"001_100000";
constant lbu_i        : std_logic_vector (  8 downto  0) := B"001_100100";
constant ll_i         : std_logic_vector (  8 downto  0) := B"001_110000";
constant lh_i         : std_logic_vector (  8 downto  0) := B"001_100001";
constant lhu_i        : std_logic_vector (  8 downto  0) := B"001_100101";
constant lui_i        : std_logic_vector (  8 downto  0) := B"001_001111";
constant lw_i         : std_logic_vector (  8 downto  0) := B"001_100011";
constant lwl_i        : std_logic_vector (  8 downto  0) := B"001_100010";
constant lwr_i        : std_logic_vector (  8 downto  0) := B"001_100110";
constant madd_i       : std_logic_vector (  8 downto  0) := B"010_000000";
constant maddu_i      : std_logic_vector (  8 downto  0) := B"010_000001";
constant mfc0_i       : std_logic_vector (  8 downto  0) := B"10_0100000";
constant mfc2_i       : std_logic_vector (  8 downto  0) := B"11_0100000";
constant mflo_i       : std_logic_vector (  8 downto  0) := B"000_010010";
constant mfhi_i       : std_logic_vector (  8 downto  0) := B"000_010000";
constant mfmc0_i      : std_logic_vector (  8 downto  0) := B"10_0101011";
constant movn_i       : std_logic_vector (  8 downto  0) := B"000_001011";
constant movz_i       : std_logic_vector (  8 downto  0) := B"000_001010";
constant msub_i       : std_logic_vector (  8 downto  0) := B"010_000100";
constant msubu_i      : std_logic_vector (  8 downto  0) := B"010_000101";
constant mtc0_i       : std_logic_vector (  8 downto  0) := B"10_0100100";
constant mtc2_i       : std_logic_vector (  8 downto  0) := B"11_0100100";
constant mtlo_i       : std_logic_vector (  8 downto  0) := B"000_010011";
constant mthi_i       : std_logic_vector (  8 downto  0) := B"000_010001";
constant mul_i        : std_logic_vector (  8 downto  0) := B"010_000010";
constant mult_i       : std_logic_vector (  8 downto  0) := B"000_011000";
constant multu_i      : std_logic_vector (  8 downto  0) := B"000_011001";
constant nor_i        : std_logic_vector (  8 downto  0) := B"000_100111";
constant or_i         : std_logic_vector (  8 downto  0) := B"000_100101";
constant ori_i        : std_logic_vector (  8 downto  0) := B"001_001101";
constant pref_i       : std_logic_vector (  8 downto  0) := B"001_110011";
constant rdhwr_i      : std_logic_vector (  8 downto  0) := B"011_111011";
constant sb_i         : std_logic_vector (  8 downto  0) := B"001_101000";
constant sc_i         : std_logic_vector (  8 downto  0) := B"001_111000";
constant sh_i         : std_logic_vector (  8 downto  0) := B"001_101001";
constant sll_i        : std_logic_vector (  8 downto  0) := B"000_000000";
constant sllv_i       : std_logic_vector (  8 downto  0) := B"000_000100";
constant slt_i        : std_logic_vector (  8 downto  0) := B"000_101010";
constant slti_i       : std_logic_vector (  8 downto  0) := B"001_001010";
constant sltiu_i      : std_logic_vector (  8 downto  0) := B"001_001011";
constant sltu_i       : std_logic_vector (  8 downto  0) := B"000_101011";
constant srl_i        : std_logic_vector (  8 downto  0) := B"000_000010";
constant srlv_i       : std_logic_vector (  8 downto  0) := B"000_000110";
constant sra_i        : std_logic_vector (  8 downto  0) := B"000_000011";
constant srav_i       : std_logic_vector (  8 downto  0) := B"000_000111";
constant sub_i        : std_logic_vector (  8 downto  0) := B"000_100010";
constant subu_i       : std_logic_vector (  8 downto  0) := B"000_100011";
constant sw_i         : std_logic_vector (  8 downto  0) := B"001_101011";
constant swl_i        : std_logic_vector (  8 downto  0) := B"001_101010";
constant swr_i        : std_logic_vector (  8 downto  0) := B"001_101110";
constant sync_i       : std_logic_vector (  8 downto  0) := B"000_001111";
constant syscall_i    : std_logic_vector (  8 downto  0) := B"000_001100";
constant teq_i        : std_logic_vector (  8 downto  0) := B"000_110100";
constant teqi_i       : std_logic_vector (  8 downto  0) := B"1000_01100";
constant tge_i        : std_logic_vector (  8 downto  0) := B"000_110000";
constant tgei_i       : std_logic_vector (  8 downto  0) := B"1000_01000";
constant tgeiu_i      : std_logic_vector (  8 downto  0) := B"1000_01001";
constant tgeu_i       : std_logic_vector (  8 downto  0) := B"000_110001";
constant tlt_i        : std_logic_vector (  8 downto  0) := B"000_110010";
constant tlti_i       : std_logic_vector (  8 downto  0) := B"1000_01010";
constant tltiu_i      : std_logic_vector (  8 downto  0) := B"1000_01011";
constant tltu_i       : std_logic_vector (  8 downto  0) := B"000_110011";
constant tne_i        : std_logic_vector (  8 downto  0) := B"000_110110";
constant tnei_i       : std_logic_vector (  8 downto  0) := B"1000_01110";
constant wait_i       : std_logic_vector (  8 downto  0) := B"10_1100000";
constant xor_i        : std_logic_vector (  8 downto  0) := B"000_100110";
constant xori_i       : std_logic_vector (  8 downto  0) := B"001_001110";
--

begin

-- ### -------------------------------------------------------------- ###
-- #   internal description :						#
-- #									#
-- #   The following lines describes in details an implementation of	#
-- #   the Mips-32 Risc architecture.					#
-- #									#
-- #   The description does not include cache memories, nor virtual	#
-- #   to real address translation mechanism (virtual memory not	#
-- #   supported).							#
-- #									#
-- #   The description covers only integer instructions.		#
-- #									#
-- #   The implementation includes :					#
-- #     o R0 ... R31 : 32 integer registers organized as a register	#
-- #                    file (2 read and 1 write access)		#
-- #     o Hi and Lo  : 2 named integer registers			#
-- #									#
-- #   and the following coprocessor zero's registers :			#
-- #     o Badva      : Bad Virtual Address Register			#
-- #     o Count      : Count Register					#
-- #     o Status     : Status Register					#
-- #     o Cause      : Cause Register					#
-- #     o Epc        : Exception Program Counter			#
-- #     o Prid       : Processor Revision Identifier Register		#
-- #     o Ebase      : Exception Base Register				#
-- #     o Eepc       : Error Exception Program Counter			#
-- #     o Tcctx      : Thread Control Context				#
-- #     o Usrlcl     : User Local - Implemenatation dependent Register	#
-- #     o Hwrena     : Harware Registers Enable Register		#
-- #									#
-- #   The other registers of the coprocessor zero are not implemented.	#
-- #									#
-- #   Instructions are executed in a 5 stage pipeline :		#
-- #     o  IFC       : Instruction Fetch				#
-- #     o  DEC       : Instruction Decode				#
-- #     o  EXE       : Execute						#
-- #     o  MEM       : Memory Access					#
-- #     o  WBK       : Write Back					#
-- #									#
-- #   All the instructions are executed following the same scheme :	#
-- #     o in IFC, the instruction is fetched from the memory		#
-- #     o in DEC, operands are prepared and the next instruction	#
-- #               address is computed					#
-- #     o in EXE, the operation is performed				#
-- #     o in MEM, the data memory is accessed (read or write access)	#
-- #     o in WBK, integer registers are modified.			#
-- #									#
-- #   The multiply operation is performed in the three last stages	#
-- #   (EXE, MEM adn WBK) by a piplined multiplier.			#
-- #									#
-- #   Integer            registers are written in Write Back stage.	#
-- #   Coprocessor zero's registers are written in Memory     stage.	#
-- #									#
-- #   A global pipeline control mechanism guaranties the correct	#
-- #   execution of dependent instructions. Most of data hazards on	#
-- #   integer registers are resolved by bypasses. Data hazards that	#
-- #   cannot be resolved by bypass produce pipeline stall cycles (one	#
-- #   or two cycles).							#
-- #									#
-- #   The data dependency control mechanism covers Lo and Hi registers	#
-- #   as well as the coprocessor zero's registers.			#
-- #									#
-- #   Registers are synchronized on the rising edge of the clock.	#
-- ### -------------------------------------------------------------- ###

-- ### -------------------------------------------------------------- ###
-- #   Notes :								#
-- #									#
-- #     Eret, Mfmc0 (Di, Ei)     :					#
-- #        Coprocessor zero's registers are read in MEM		#
-- #     Mfc0, Mfmc0 (Di, Ei)     :					#
-- #        Coprocessor zero's registers are read in DEC		#
-- #     Mflo, Mfhi               :					#
-- #        Lo, Hi registers             are read in EXE		#
-- #     Madd, Maddu, Msub, Msubu :					#
-- #        Lo, Hi registers             are read in MEM		#
-- ### -------------------------------------------------------------- ###
--

	-- ### ------------------------------------------------------ ###
	-- #   check power supplies					#
	-- ### ------------------------------------------------------ ###

CHECK_POWER : assert  (((VDD and VDDP) = '1') and ((VSS or VSSP) = '0'))
              report  "missing power supply on processor"
              severity WARNING;

	-- ### ------------------------------------------------------ ###
	-- #   external (hardware) interrupts :				#
	-- #     convert to positive logic				#
	-- ### ------------------------------------------------------ ###

IT_XX      <= not IT_N     ;

	-- ### ------------------------------------------------------ ###
	-- #   external exception :					#
	-- #     - machine check					#
	-- ### ------------------------------------------------------ ###

MCHECKX_XX <= not MCHECK_N and not MCHECK_RX ;

	-- ### ------------------------------------------------------ ###
	-- #   implementation :						#
	-- #     - standard						#
	-- #     - tsar							#
	-- ### ------------------------------------------------------ ###

IMP_SX     <= imp_tsr ;

IMPSTD_SX  <= '1'     when (IMP_SX = imp_std) else '0';
IMPTSR_SX  <= '1'     when (IMP_SX = imp_tsr) else '0';

	-- ### ------------------------------------------------------ ###
	-- #   extract the opcode from instruction register		#
	-- ### ------------------------------------------------------ ###

with I_RI (25          ) select
COP0_SD    <= cop0_g & B"01" & I_RI (25 downto 21) when '0'       ,
              cop0_g &   '1' & I_RI ( 5 downto  0) when others    ;

with I_RI (25          ) select
COP2_SD    <= cop2_g & B"01" & I_RI (25 downto 21) when '0'       ,
              cop2_g &   '1' & I_RI ( 5 downto  0) when others    ;

with I_RI (31 downto 26) select
OPCOD_SD   <= special_g      & I_RI ( 5 downto  0) when special_i ,
              special2_g     & I_RI ( 5 downto  0) when special2_i,
              special3_g     & I_RI ( 5 downto  0) when special3_i,
              bcond_g        & I_RI (20 downto 16) when bcond_i   ,
              COP0_SD                              when cop0_i    ,
              COP2_SD                              when cop2_i    ,
              others_g       & I_RI (31 downto 26) when others    ;

	-- ### ------------------------------------------------------ ###
	-- #   decode the instruction's opcode				#
	-- #								#
	-- #     - instruction format              4 bits (40 - 37)	#
	-- #     - integer s register usage        2 bits (36 - 35)	#
	-- #     - integer t register usage        2 bits (34 - 33)	#
	-- #     - Hi        register usage        2 bits (32 - 31)	#
	-- #     - Lo        register usage        2 bits (30 - 29)	#
	-- #     - signed/unsigned source operands 1 bit  (     28)	#
	-- #     - operation type                  7 bits (27 - 21)	#
	-- #     - conditional exception           4 bits (20 - 17)	#
	-- #     - which stage produces the result 3 bits (16 - 14)	#
	-- #     - save result in i, Lo, Hi, c     4 bits (13 - 10)	#
	-- #     - type of instruction (branch)    1 bit  (      9)	#
	-- #     - type of memory access           9 bits ( 8 -  0)	#
	-- ### ------------------------------------------------------ ###

nop_type   <=
  r_fmt_o & no_s_o  & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  shl_o   & nox_o   & no_pd_o & no_sv_o & no_br_o & no_m_o                 ;

with OPCOD_SD select
I_TYPE_SD  <=
  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  add_o   & ovr_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when add_i    ,

  i_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  add_o   & ovr_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when addi_i   ,

  i_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  add_o   & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when addiu_i  ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  add_o   & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when addu_i   ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_usg_o &
  and_o   & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when and_i    ,

  i_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_usg_o &
  and_o   & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when andi_i   ,

  i_fmt_o & du_s_o & du_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ioper_o & nox_o  & no_pd_o & no_sv_o & brnch_o & no_m_o    when beq_i    ,

  i_fmt_o & du_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ioper_o & nox_o  & no_pd_o & no_sv_o & brnch_o & no_m_o    when blez_i   ,

  i_fmt_o & du_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ioper_o & nox_o  & no_pd_o & no_sv_o & brnch_o & no_m_o    when bgez_i   ,

  i_fmt_o & du_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ioper_o & nox_o  & e_pd_o  & s_i_o   & brnch_o & no_m_o    when bgezal_i ,

  i_fmt_o & du_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ioper_o & nox_o  & no_pd_o & no_sv_o & brnch_o & no_m_o    when bgtz_i   ,

  i_fmt_o & du_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ioper_o & nox_o  & no_pd_o & no_sv_o & brnch_o & no_m_o    when bltz_i   ,

  i_fmt_o & du_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ioper_o & nox_o  & e_pd_o  & s_i_o   & brnch_o & no_m_o    when bltzal_i ,

  i_fmt_o & du_s_o & du_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ioper_o & nox_o  & no_pd_o & no_sv_o & brnch_o & no_m_o    when bne_i    ,

  r_fmt_o & no_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ioper_o & brk_o  & no_pd_o & no_sv_o & no_br_o & no_m_o    when break_i  ,

  i_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  add_o   & nox_o  & no_pd_o & no_sv_o & no_br_o & no_m_o    when cache_i  ,

  r_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  clo_o   & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when clo_i    ,

  r_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  clz_o   & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when clz_i    ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  div_o   & nox_o  & w_pd_o  & s_hl_o  & no_br_o & no_m_o    when div_i    ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_usg_o &
  div_o   & nox_o  & w_pd_o  & s_hl_o  & no_br_o & no_m_o    when divu_i   ,

  i_fmt_o & no_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ioper_o & nox_o  & no_pd_o & no_sv_o & no_br_o & no_m_o    when eret_i   ,

  j_fmt_o & no_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ioper_o & nox_o  & no_pd_o & no_sv_o & brnch_o & no_m_o    when j_i      ,

  j_fmt_o & no_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ioper_o & nox_o  & e_pd_o  & s_i_o   & brnch_o & no_m_o    when jal_i    ,

  r_fmt_o & du_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ioper_o & nox_o  & e_pd_o  & s_i_o   & brnch_o & no_m_o    when jalr_i   ,

  r_fmt_o & du_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ioper_o & nox_o  & no_pd_o & no_sv_o & brnch_o & no_m_o    when jr_i     ,

  i_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  add_o   & nox_o  & m_pd_o  & s_i_o   & no_br_o & m_lby_o   when lb_i     ,

  i_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  add_o   & nox_o  & m_pd_o  & s_i_o   & no_br_o & m_lby_o   when lbu_i    ,

  i_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  add_o   & nox_o  & m_pd_o  & s_i_o   & no_br_o & m_lhf_o   when lh_i     ,

  i_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  add_o   & nox_o  & m_pd_o  & s_i_o   & no_br_o & m_lhf_o   when lhu_i    ,

  i_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  add_o   & nox_o  & m_pd_o  & s_i_o   & no_br_o & m_llk_o   when ll_i     ,

  i_fmt_o & no_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ioper_o & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when lui_i    ,

  i_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  add_o   & nox_o  & m_pd_o  & s_i_o   & no_br_o & m_lwd_o   when lw_i     ,

  i_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  add_o   & nox_o  & m_pd_o  & s_i_o   & no_br_o & m_lwl_o   when lwl_i    ,

  i_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  add_o   & nox_o  & m_pd_o  & s_i_o   & no_br_o & m_lwr_o   when lwr_i    ,

  r_fmt_o & eu_s_o & eu_t_o  & mu_h_o  & mu_l_o  & o_sgn_o &
  madd_o  & nox_o  & w_pd_o  & s_hl_o  & no_br_o & no_m_o    when madd_i   ,

  r_fmt_o & eu_s_o & eu_t_o  & mu_h_o  & mu_l_o  & o_usg_o &
  madd_o  & nox_o  & w_pd_o  & s_hl_o  & no_br_o & no_m_o    when maddu_i  ,

  i_fmt_o & no_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ioper_o & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when mfc0_i   ,

  i_fmt_o & no_s_o & no_t_o  & no_h_o  & no_l_o  & o_usg_o &
  add_o   & nox_o  & m_pd_o  & s_i_o   & no_br_o & m_lrg_o   when mfc2_i   ,

  r_fmt_o & no_s_o & no_t_o  & no_h_o  & eu_l_o  & o_sgn_o &
  ioper_o & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when mflo_i   ,

  r_fmt_o & no_s_o & no_t_o  & eu_h_o  & no_l_o  & o_sgn_o &
  ioper_o & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when mfhi_i   ,

  i_fmt_o & no_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ioper_o & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when mfmc0_i  ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  soper_o & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when movn_i   ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  soper_o & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when movz_i   ,

  r_fmt_o & eu_s_o & eu_t_o  & mu_h_o  & mu_l_o  & o_sgn_o &
  msub_o  & nox_o  & w_pd_o  & s_hl_o  & no_br_o & no_m_o    when msub_i   ,

  r_fmt_o & eu_s_o & eu_t_o  & mu_h_o  & mu_l_o  & o_usg_o &
  msub_o  & nox_o  & w_pd_o  & s_hl_o  & no_br_o & no_m_o    when msubu_i  ,

  i_fmt_o & no_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  toper_o & nox_o  & e_pd_o  & s_c_o   & no_br_o & no_m_o    when mtc0_i   ,

  i_fmt_o & no_s_o & eu_t_o  & no_h_o  & no_l_o  & o_usg_o &
  add_o   & nox_o  & no_pd_o & no_sv_o & no_br_o & m_srg_o   when mtc2_i   ,

  r_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  soper_o & nox_o  & e_pd_o  & s_h_o   & no_br_o & no_m_o    when mthi_i   ,

  r_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  soper_o & nox_o  & e_pd_o  & s_l_o   & no_br_o & no_m_o    when mtlo_i   ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  mult_o  & nox_o  & w_pd_o  & s_i_o   & no_br_o & no_m_o    when mul_i    ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  mult_o  & nox_o  & w_pd_o  & s_hl_o  & no_br_o & no_m_o    when mult_i   ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_usg_o &
  mult_o  & nox_o  & w_pd_o  & s_hl_o  & no_br_o & no_m_o    when multu_i  ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_usg_o &
  nor_o   & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when nor_i    ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_usg_o &
  or_o    & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when or_i     ,

  i_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_usg_o &
  or_o    & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when ori_i    ,

  i_fmt_o & no_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  shl_o   & nox_o  & no_pd_o & no_sv_o & no_br_o & no_m_o    when pref_i   ,

  i_fmt_o & no_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ioper_o & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when rdhwr_i  ,

  i_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  add_o   & nox_o  & no_pd_o & no_sv_o & no_br_o & m_sby_o   when sb_i     ,

  i_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  add_o   & nox_o  & m_pd_o  & s_i_o   & no_br_o & m_slk_o   when sc_i     ,

  i_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  add_o   & nox_o  & no_pd_o & no_sv_o & no_br_o & m_shf_o   when sh_i     ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  shl_o   & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when sllv_i   ,

  r_fmt_o & no_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  shl_o   & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when sll_i    ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  lt_o    & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when slt_i    ,

  i_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  lt_o    & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when slti_i   ,

  i_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ltu_o   & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when sltiu_i  ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ltu_o   & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when sltu_i   ,

  r_fmt_o & no_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  shr_o   & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when sra_i    ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  shr_o   & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when srav_i   ,

  r_fmt_o & no_s_o & eu_t_o  & no_h_o  & no_l_o  & o_usg_o &
  shr_o   & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when srl_i    ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_usg_o &
  shr_o   & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when srlv_i   ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  sub_o   & ovr_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when sub_i    ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  sub_o   & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when subu_i   ,

  i_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  add_o   & nox_o  & no_pd_o & no_sv_o & no_br_o & m_swd_o   when sw_i     ,

  i_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  add_o   & nox_o  & no_pd_o & no_sv_o & no_br_o & m_swl_o   when swl_i    ,

  i_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  add_o   & nox_o  & no_pd_o & no_sv_o & no_br_o & m_swr_o   when swr_i    ,

  i_fmt_o & no_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ioper_o & nox_o  & no_pd_o & no_sv_o & no_br_o & no_m_o    when sync_i   ,

  r_fmt_o & no_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ioper_o & sys_o  & no_pd_o & no_sv_o & no_br_o & no_m_o    when syscall_i,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  eq_o    & trp_o  & no_pd_o & no_sv_o & no_br_o & no_m_o    when teq_i    ,

  i_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  eq_o    & trp_o  & no_pd_o & no_sv_o & no_br_o & no_m_o    when teqi_i   ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ge_o    & trp_o  & no_pd_o & no_sv_o & no_br_o & no_m_o    when tge_i    ,

  i_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ge_o    & trp_o  & no_pd_o & no_sv_o & no_br_o & no_m_o    when tgei_i   ,

  i_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  geu_o   & trp_o  & no_pd_o & no_sv_o & no_br_o & no_m_o    when tgeiu_i  ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  geu_o   & trp_o  & no_pd_o & no_sv_o & no_br_o & no_m_o    when tgeu_i   ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  lt_o    & trp_o  & no_pd_o & no_sv_o & no_br_o & no_m_o    when tlt_i    ,

  i_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  lt_o    & trp_o  & no_pd_o & no_sv_o & no_br_o & no_m_o    when tlti_i   ,

  i_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ltu_o   & trp_o  & no_pd_o & no_sv_o & no_br_o & no_m_o    when tltiu_i  ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ltu_o   & trp_o  & no_pd_o & no_sv_o & no_br_o & no_m_o    when tltu_i   ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ne_o    & trp_o  & no_pd_o & no_sv_o & no_br_o & no_m_o    when tne_i    ,

  i_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ne_o    & trp_o  & no_pd_o & no_sv_o & no_br_o & no_m_o    when tnei_i   ,

  r_fmt_o & no_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ioper_o & nox_o  & no_pd_o & no_sv_o & no_br_o & no_m_o    when wait_i   ,

  r_fmt_o & eu_s_o & eu_t_o  & no_h_o  & no_l_o  & o_usg_o &
  xor_o   & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when xor_i    ,

  i_fmt_o & eu_s_o & no_t_o  & no_h_o  & no_l_o  & o_usg_o &
  xor_o   & nox_o  & e_pd_o  & s_i_o   & no_br_o & no_m_o    when xori_i   ,

  illgl_o & no_s_o & no_t_o  & no_h_o  & no_l_o  & o_sgn_o &
  ioper_o & nox_o  & no_pd_o & no_sv_o & no_br_o & no_m_o    when others   ;

	-- ### ------------------------------------------------------ ###
	-- #   decode the instruction's opcode				#
	-- #     - signals for Instruction Decode stage			#
	-- ### ------------------------------------------------------ ###

I_ILLG_SD  <=     I_TYPE_SD (40)                       ;
I_IFMT_SD  <=     I_TYPE_SD (38)                       ;
I_RFMT_SD  <=     I_TYPE_SD (37)                       ;

I_DUSES_SD <=     I_TYPE_SD (36)                       ;
I_EUSES_SD <=     I_TYPE_SD (35)                       ;
I_DUSET_SD <=     I_TYPE_SD (34)                       ;
I_EUSET_SD <=     I_TYPE_SD (33)                       ;
I_READS_SD <=     I_TYPE_SD (36) or      I_TYPE_SD (35);
I_READT_SD <=     I_TYPE_SD (34) or      I_TYPE_SD (33);

I_OSGND_SD <=     I_TYPE_SD (28)                       ;

I_BREK_SD  <=     I_TYPE_SD (20)                       ;
I_SYSC_SD  <=     I_TYPE_SD (19)                       ;
I_TRAP_SD  <=     I_TYPE_SD (18)                       ;

I_WREG_SD  <=     I_TYPE_SD (10)                       ;

I_BRNCH_SD <=     I_TYPE_SD ( 9)                       ;

	-- ### ------------------------------------------------------ ###
	-- #   decode the instruction's opcode				#
	-- #     - signals for Execute stage				#
	-- ### ------------------------------------------------------ ###

I_IFMT_SE  <=     I_TYPE_RD (38)                                              ;

I_EUSES_SE <=     I_TYPE_RD (35)                                              ;
I_EUSET_SE <=     I_TYPE_RD (33)                                              ;
I_READS_SE <=     I_TYPE_RD (36) or      I_TYPE_RD (35)                       ;
I_READT_SE <=     I_TYPE_RD (34) or      I_TYPE_RD (33)                       ;

I_EUSEH_SE <=     I_TYPE_RD (32)                                              ;
I_EUSEL_SE <=     I_TYPE_RD (30)                                              ;

I_OSGND_SE <=     I_TYPE_RD (28)                                              ;

I_ARITH_SE <= not I_TYPE_RD (27) and not I_TYPE_RD (26) and     I_TYPE_RD (25);
I_SHIFT_SE <= not I_TYPE_RD (27) and     I_TYPE_RD (26) and not I_TYPE_RD (25);
I_TEST_SE  <= not I_TYPE_RD (27) and     I_TYPE_RD (26) and     I_TYPE_RD (25);
I_LOGIC_SE <=     I_TYPE_RD (27) and not I_TYPE_RD (26) and not I_TYPE_RD (25);
I_OPER_SE  <=     I_TYPE_RD (27) and not I_TYPE_RD (26) and     I_TYPE_RD (25);
I_CLEAD_SE <=     I_TYPE_RD (27) and     I_TYPE_RD (26) and not I_TYPE_RD (25);

I_SUB_SE   <=                                                   I_TYPE_RD (22);
I_SHR_SE   <=                                                   I_TYPE_RD (22);
I_EQ_SE    <=                        not I_TYPE_RD (23) and not I_TYPE_RD (22);
I_NE_SE    <=                            I_TYPE_RD (23) and not I_TYPE_RD (22);
I_LTU_SE   <= not I_TYPE_RD (24) and not I_TYPE_RD (23) and     I_TYPE_RD (22);
I_LT_SE    <=     I_TYPE_RD (24) and not I_TYPE_RD (23) and     I_TYPE_RD (22);
I_GEU_SE   <= not I_TYPE_RD (24) and     I_TYPE_RD (23) and     I_TYPE_RD (22);
I_GE_SE    <=     I_TYPE_RD (24) and     I_TYPE_RD (23) and     I_TYPE_RD (22);
I_AND_SE   <=                        not I_TYPE_RD (23) and     I_TYPE_RD (22);
I_NOR_SE   <=                            I_TYPE_RD (23) and     I_TYPE_RD (22);
I_XOR_SE   <=                            I_TYPE_RD (23) and not I_TYPE_RD (22);
I_OR_SE    <=                        not I_TYPE_RD (23) and not I_TYPE_RD (22);
I_SOPER_SE <=                            I_TYPE_RD (23) and not I_TYPE_RD (22);
I_TOPER_SE <=                        not I_TYPE_RD (23) and     I_TYPE_RD (22);
I_IOPER_SE <=                        not I_TYPE_RD (23) and not I_TYPE_RD (22);
I_CLZ_SE   <=                                                   I_TYPE_RD (22);
I_MSUB_SE  <=                                                   I_TYPE_RD (22);

I_MIC_SE   <=     I_TYPE_RD (24 downto 22);
I_CISC_SE  <=     I_TYPE_RD (21)                                              ;

I_OVRF_SE  <=     I_TYPE_RD (17)                                              ;

I_WPDC_SE  <=     I_TYPE_RD (14)                                              ;

I_WREG_SE  <=     I_TYPE_RD (10)                                              ;

I_BRNCH_SE <=     I_TYPE_RD ( 9)                                              ;

I_MLOAD_SE <=     I_TYPE_RD ( 8) and not I_TYPE_RD ( 5)                       ;
I_MSTOR_SE <=     I_TYPE_RD ( 7) and not I_TYPE_RD ( 5)                       ;

I_LOAD_SE  <=     I_TYPE_RD ( 8)                                              ;
I_STOR_SE  <=     I_TYPE_RD ( 7)                                              ;
I_LINKD_SE <=     I_TYPE_RD ( 6)                                              ;
I_XREG_SE  <=     I_TYPE_RD ( 5)                                              ;

I_BYTE_SE  <=     I_TYPE_RD ( 4)                                              ;
I_HALF_SE  <=     I_TYPE_RD ( 3)                                              ;
I_WORD_SE  <=     I_TYPE_RD ( 2)                                              ;
I_WRDR_SE  <=     I_TYPE_RD ( 1)                                              ;
I_WRDL_SE  <=     I_TYPE_RD ( 0)                                              ;

	-- ### ------------------------------------------------------ ###
	-- #   decode the instruction's opcode				#
	-- #     - signals for the Memory Access stage			#
	-- ### ------------------------------------------------------ ###

I_MUSEH_SM <=     I_TYPE_RE (31)                       ;
I_MUSEL_SM <=     I_TYPE_RE (29)                       ;

I_MULT_SM  <= not I_TYPE_RE (23) and not I_TYPE_RE (22);

I_MPDC_SM  <=     I_TYPE_RE (15)                       ;
I_WPDC_SM  <=     I_TYPE_RE (14)                       ;

I_WCOP0_SM <=     I_TYPE_RE (13)                       ;
I_WHI_SM   <=     I_TYPE_RE (12)                       ;
I_WLO_SM   <=     I_TYPE_RE (11)                       ;
I_WREG_SM  <=     I_TYPE_RE (10)                       ;

I_LINKD_SM <=     I_TYPE_RE ( 6)                       ;
I_XREG_SM  <=     I_TYPE_RE ( 5)                       ;

	-- ### ------------------------------------------------------ ###
	-- #   decode the instruction's opcode				#
	-- #     - signals for the Write Back stage			#
	-- ### ------------------------------------------------------ ###

I_WPDC_SW  <=     I_TYPE_RM (14)                       ;

I_WHI_SW   <=     I_TYPE_RM (12)                       ;
I_WLO_SW   <=     I_TYPE_RM (11)                       ;
I_WREG_SW  <=     I_TYPE_RM (10)                       ;

	-- ### ------------------------------------------------------ ###
	-- #   the incoming instruction is a branch delayed slot if the	#
	-- #   instruction in Instruction Decode stage is a branch	#
	-- ### ------------------------------------------------------ ###

BDSLOT_XI  <= I_BRNCH_SD ;

	-- ### ------------------------------------------------------ ###
	-- #   detecting particular instructions :			#
	-- #								#
	-- #     - Eret    : Exception return				#
	-- #     - Mfc0    : Move from coprocessor zero			#
	-- #     - Mtc0    : Move to coprocessor zero			#
	-- #     - Mfmc0   : Di and Ei - disable and enable interrupts	#
	-- #     - Mfc2    : Move from coprocessor two			#
	-- #     - Mtc2    : Move to coprocessor two			#
	-- #     - Wait    : Wait (stall the pipeline)			#
	-- #     - Sync    : Synchronize shared memory			#
	-- #     - Cache   : Cache					#
	-- #     - Rdhwr   : Read hardware registers			#
	-- ### ------------------------------------------------------ ###

ERET_SD    <= '1' when (OPCOD_SD  = eret_i   ) else '0' ;
ERET_SE    <= '1' when (OPCOD_RD  = eret_i   ) else '0' ;
ERET_SM    <= '1' when (OPCOD_RE  = eret_i   ) else '0' ;

MFC0_SD    <= '1' when (OPCOD_SD  = mfc0_i   ) else '0' ;

MTC0_SD    <= '1' when (OPCOD_SD  = mtc0_i   ) else '0' ;
MTC0_SE    <= '1' when (OPCOD_RD  = mtc0_i   ) else '0' ;
MTC0_SM    <= '1' when (OPCOD_RE  = mtc0_i   ) else '0' ;

MFMC0_SD   <= '1' when (OPCOD_SD  = mfmc0_i  ) else '0' ;
MFMC0_SE   <= '1' when (OPCOD_RD  = mfmc0_i  ) else '0' ;
MFMC0_SM   <= '1' when (OPCOD_RE  = mfmc0_i  ) else '0' ;

MFC2_SD    <= '1' when (OPCOD_SD  = mfc2_i   ) else '0' ;
MFC2_SE    <= '1' when (OPCOD_RD  = mfc2_i   ) else '0' ;

MTC2_SD    <= '1' when (OPCOD_SD  = mtc2_i   ) else '0' ;
MTC2_SE    <= '1' when (OPCOD_RD  = mtc2_i   ) else '0' ;

WAIT_SD    <= '1' when (OPCOD_SD  = wait_i   ) else '0' ;
WAIT_SE    <= '1' when (OPCOD_RD  = wait_i   ) else '0' ;
WAIT_SM    <= '1' when (OPCOD_RE  = wait_i   ) else '0' ;

SYNC_SE    <= '1' when (OPCOD_RD  = sync_i   ) else '0' ;

CACH_SE    <= '1' when (OPCOD_RD  = cache_i  ) else '0' ;

RDHWR_SE   <= '1' when (OPCOD_RD  = rdhwr_i  ) else '0' ;

	-- ### ------------------------------------------------------ ###
	-- #   exceptions detected during Instruction Fetch stage :	#
	-- #								#
	-- #     - instruction address bus error			#
	-- #     - instruction address miss aligned			#
	-- #     - instruction address violating segment space		#
	-- ### ------------------------------------------------------ ###

IABUSER_XI <= I_RBERR        and IRQ_RE        ;

IAMALGN_XI <= NEXTPC_RD ( 0) or  NEXTPC_RD (1) ;

IASVIOL_XI <= NEXTPC_RD (31) and USRMOD_SX     when (IMPSTD_SX = '1') else '0';

	-- ### ------------------------------------------------------ ###
	-- #   disable Instuction Bus Error detections when another	#
	-- #   instruction bus error is in the pipeline			#
	-- ### ------------------------------------------------------ ###

IBEREN_SX  <= '0' when (IABUSER_RI = '1' or
                        IABUSER_RD = '1' or
                        IABUSER_RE = '1'   ) else
              '1' ;

	-- ### ------------------------------------------------------ ###
	-- #   coprocessor zero's source and destination registers'	#
	-- #   numbers							#
	-- ### ------------------------------------------------------ ###

COP0S_SD   <= I_RI (15 downto 11) & I_RI (2 downto 0);
COP0D_SD   <= I_RI (15 downto 11) & I_RI (2 downto 0);

	-- ### ------------------------------------------------------ ###
	-- #   write the result into r31 instead of the regular		#
	-- #   integer destination register				#
	-- ### ------------------------------------------------------ ###

WR31_SD    <= '1' when (OPCOD_SD = jal_i   ) else
              '1' when (OPCOD_SD = bltzal_i) else
              '1' when (OPCOD_SD = bgezal_i) else
              '0';

	-- ### ------------------------------------------------------ ###
	-- #   source register numbers					#
	-- ### ------------------------------------------------------ ###

RS_SD      <= I_RI (25 downto 21) ;
RT_SD      <= I_RI (20 downto 16) ;

	-- ### ------------------------------------------------------ ###
	-- #   read source registers from the register bank		#
	-- ### ------------------------------------------------------ ###

with RS_SD select
S_SD       <= R0_RW        when B"00000",
              R1_RW        when B"00001",
              R2_RW        when B"00010",
              R3_RW        when B"00011",
              R4_RW        when B"00100",
              R5_RW        when B"00101",
              R6_RW        when B"00110",
              R7_RW        when B"00111",
              R8_RW        when B"01000",
              R9_RW        when B"01001",
              R10_RW       when B"01010",
              R11_RW       when B"01011",
              R12_RW       when B"01100",
              R13_RW       when B"01101",
              R14_RW       when B"01110",
              R15_RW       when B"01111",
              R16_RW       when B"10000",
              R17_RW       when B"10001",
              R18_RW       when B"10010",
              R19_RW       when B"10011",
              R20_RW       when B"10100",
              R21_RW       when B"10101",
              R22_RW       when B"10110",
              R23_RW       when B"10111",
              R24_RW       when B"11000",
              R25_RW       when B"11001",
              R26_RW       when B"11010",
              R27_RW       when B"11011",
              R28_RW       when B"11100",
              R29_RW       when B"11101",
              R30_RW       when B"11110",
              R31_RW       when B"11111",
              X"0000_0000" when others  ;

with RT_SD select
T_SD       <= R0_RW        when B"00000",
              R1_RW        when B"00001",
              R2_RW        when B"00010",
              R3_RW        when B"00011",
              R4_RW        when B"00100",
              R5_RW        when B"00101",
              R6_RW        when B"00110",
              R7_RW        when B"00111",
              R8_RW        when B"01000",
              R9_RW        when B"01001",
              R10_RW       when B"01010",
              R11_RW       when B"01011",
              R12_RW       when B"01100",
              R13_RW       when B"01101",
              R14_RW       when B"01110",
              R15_RW       when B"01111",
              R16_RW       when B"10000",
              R17_RW       when B"10001",
              R18_RW       when B"10010",
              R19_RW       when B"10011",
              R20_RW       when B"10100",
              R21_RW       when B"10101",
              R22_RW       when B"10110",
              R23_RW       when B"10111",
              R24_RW       when B"11000",
              R25_RW       when B"11001",
              R26_RW       when B"11010",
              R27_RW       when B"11011",
              R28_RW       when B"11100",
              R29_RW       when B"11101",
              R30_RW       when B"11110",
              R31_RW       when B"11111",
              X"0000_0000" when others  ;

	-- ### ------------------------------------------------------ ###
	-- #   data hazards in Instruction Decode stage :		#
	-- #								#
	-- #   compare source registers of the current instruction	#
	-- #   with the destination register of previous instructions	#
	-- ### ------------------------------------------------------ ###

CP_SDE_SD  <= RS_SD xor RD_RD;
CP_SDM_SD  <= RS_SD xor RD_RE;
CP_SDW_SD  <= RS_SD xor RD_RM;

CP_TDE_SD  <= RT_SD xor RD_RD;
CP_TDM_SD  <= RT_SD xor RD_RE;
CP_TDW_SD  <= RT_SD xor RD_RM;

SREADR0_SD <= '1' when (RS_SD = B"00000") else '0' ;
TREADR0_SD <= '1' when (RT_SD = B"00000") else '0' ;

	-- ### ------------------------------------------------------ ###
	-- #   data hazards in Instruction Decode stage :		#
	-- #								#
	-- #   effective comparisons :					#
	-- #     the destination register number of a previous		#
	-- #     instruction matches a source register number and the	#
	-- #     the registers are effectively used (comparisons fail	#
	-- #     when r0 is used)					#
	-- ### ------------------------------------------------------ ###

HZ_SDE_SD  <= '1' when (CP_SDE_SD  = B"00000" and SREADR0_SD = '0' and
                        I_READS_SD =  '1'     and I_WREG_SE  = '1'    ) else
              '0' ;
HZ_SDM_SD  <= '1' when (CP_SDM_SD  = B"00000" and SREADR0_SD = '0' and
                        I_READS_SD =  '1'     and I_WREG_SM  = '1'    ) else
              '0' ;
HZ_SDW_SD  <= '1' when (CP_SDW_SD  = B"00000" and SREADR0_SD = '0' and
                        I_READS_SD =  '1'     and I_WREG_SW  = '1'    ) else
              '0' ;

HZ_TDE_SD  <= '1' when (CP_TDE_SD  = B"00000" and TREADR0_SD = '0' and
                        I_READT_SD =  '1'     and I_WREG_SE  = '1'    ) else
              '0' ;
HZ_TDM_SD  <= '1' when (CP_TDM_SD  = B"00000" and TREADR0_SD = '0' and
                        I_READT_SD =  '1'     and I_WREG_SM  = '1'    ) else
              '0' ;
HZ_TDW_SD  <= '1' when (CP_TDW_SD  = B"00000" and TREADR0_SD = '0' and
                        I_READT_SD =  '1'     and I_WREG_SW  = '1'    ) else
              '0' ;

	-- ### ------------------------------------------------------ ###
	-- #   stall due to data hazards in Instruction Decode stage :	#
	-- #								#
	-- #   Examples :						#
	-- #      Add  Ri, --, --          Lw   Ri, --, --		#
	-- #      Beq  Ri, --              --   --, --, --		#
	-- #                               Beq  Ri, --			#
	-- #      Lw   Ri, --, --					#
	-- #      Beq  Ri, --						#
	-- #								#
	-- #   - s or t operand are used by Instruction Decode stage	#
	-- #     and the result is produced by Execute, Memory Access,	#
	-- #     or Write Back stages of the previous instruction	#
	-- #								#
	-- #   - s or t operand are used by Instruction Decode stage	#
	-- #     and the result is produced by Memory Access, or Write	#
	-- #     Back stages of the second previous instruction		#
	-- #								#
	-- #   - s or t operand are used by Instruction Decode or	#
	-- #     Execute stages and the result is produced by Write	#
	-- #     Back stage of the third previous instruction		#
	-- ### ------------------------------------------------------ ###

DATHZDS_SD <= (I_DUSES_SD and HZ_SDE_SD                             ) or
              (I_DUSES_SD and HZ_SDM_SD and (I_MPDC_SM or I_WPDC_SM)) or
              (I_DUSES_SD and HZ_SDW_SD and (             I_WPDC_SW)) or
              (I_EUSES_SD and HZ_SDE_SD and (             I_WPDC_SE)) or
              (I_EUSES_SD and HZ_SDM_SD and (             I_WPDC_SM)) or
              (I_EUSES_SD and HZ_SDW_SD and (             I_WPDC_SW)) or

              (I_DUSET_SD and HZ_TDE_SD                             ) or
              (I_DUSET_SD and HZ_TDM_SD and (I_MPDC_SM or I_WPDC_SM)) or
              (I_DUSET_SD and HZ_TDW_SD and (             I_WPDC_SW)) or
              (I_EUSET_SD and HZ_TDE_SD and (             I_WPDC_SE)) or
              (I_EUSET_SD and HZ_TDM_SD and (             I_WPDC_SM)) or
              (I_EUSET_SD and HZ_TDW_SD and (             I_WPDC_SW))   ;

	-- ### ------------------------------------------------------ ###
	-- #   stall due to instruction hazards in Instruction Decode	#
	-- #   stage :							#
	-- #								#
	-- #   - when the instruction in Execute stage is :		#
	-- #     Mtc0, Mfmc0 (Di, Ei) or Eret				#
	-- #								#
	-- #   - when the instruction in Memory Access stage is :	#
	-- #     Mtc0, Mfmc0 (Di, Ei) or Eret				#
	-- ### ------------------------------------------------------ ###

INSHZDS_SD <= '1' when (MTC0_SE  = '1' or MTC0_SM  = '1') else
              '1' when (MFMC0_SE = '1' or MFMC0_SM = '1') else
              '1' when (ERET_SE  = '1' or ERET_SM  = '1') else
              '0' ;

	-- ### ------------------------------------------------------ ###
	-- #   stall due to hazards in Instruction Decode stage :	#
	-- #     - data        hazards					#
	-- #     - instruction hazards					#
	-- ### ------------------------------------------------------ ###

HAZARDS_SD <= DATHZDS_SD or INSHZDS_SD;

	-- ### ------------------------------------------------------ ###
	-- #   effective operands (bypasses)				#
	-- ### ------------------------------------------------------ ###

SOPER_SD   <= RES_RE   when (HZ_SDM_SD = '1'   ) else
              DATA_RM  when (HZ_SDW_SD = '1'   ) else
              S_SD     ;

TOPER_SD   <= RES_RE   when (HZ_TDM_SD = '1'   ) else
              DATA_RM  when (HZ_TDW_SD = '1'   ) else
              T_SD     ;

	-- ### ------------------------------------------------------ ###
	-- #   read the coprocessor zero's register to be transfered	#
	-- #   into an integer register (Mfc0, Di and Ei instructions)	#
	-- ### ------------------------------------------------------ ###

with COP0S_SD select
COP0OP_SD  <= BADVA_RX     when c0_badva   ,
              COUNT_RX     when c0_count   ,
              STATUS_RX    when c0_status  ,
              EPC_RX       when c0_epc     ,
              CAUSE_RX     when c0_cause   ,
              PRID_RX      when c0_prid    ,
              EBASE_RM     when c0_ebase   ,
              EEPC_RX      when c0_eepc    ,
              TCCTX_RM     when c0_tcctx   ,
              USRLCL_RM    when c0_usrlcl  ,
              HWRENA_RM    when c0_hwrena  ,
              X"0000_0000" when others     ;

	-- ### ------------------------------------------------------ ###
	-- #   read the coprocessor zero's register to be transfered	#
	-- #   into an integer register (Rdhwr instruction)		#
	-- ### ------------------------------------------------------ ###

with RD_SD    select
HWROP_SD   <= COUNT_RX                                     when hw_count  ,
              X"0000_0"    & B"00" & EBASE_RM (9 downto 0) when hw_cpunbr ,
              USRLCL_RM                                    when hw_usrlcl ,
              X"0000_0000"                                 when others    ;

	-- ### ------------------------------------------------------ ###
	-- #   immediate operand					#
	-- ### ------------------------------------------------------ ###

IMDSEX_SD  <= X"ffff" when (I_RI (15) = '1' and I_OSGND_SD = '1') else X"0000";

with OPCOD_SD select
IOPER_SD   <= SEQADR_SD                               when bltzal_i ,
              SEQADR_SD                               when bgezal_i ,
              SEQADR_SD                               when jalr_i   ,
              SEQADR_SD                               when jal_i    ,
              I_RI (15 downto 0) & X"0000"            when lui_i    ,
              COP0OP_SD                               when mfc0_i   ,
              COP0OP_SD                               when mfmc0_i  ,
              HWROP_SD                                when rdhwr_i  ,
              IMDSEX_SD          & I_RI (15 downto 0) when others   ;

	-- ### ------------------------------------------------------ ###
	-- #   shift amount						#
	-- ### ------------------------------------------------------ ###

SHAM_SD    <= I_RI (10 downto 6);

	-- ### ------------------------------------------------------ ###
	-- #   next instruction address :				#
	-- #     - Eret : Error Exception Program Counter or		#
	-- #              Exception Program Counter			#
	-- ### ------------------------------------------------------ ###

RETADR_SD  <= EEPC_RX when (STATUS_RX (2) = '1') else EPC_RX;

	-- ### ------------------------------------------------------ ###
	-- #   next instruction address :				#
	-- #     - replace low order bits for jumps			#
	-- ### ------------------------------------------------------ ###

JMPADR_SD  <= NEXTPC_RD (31 downto 28) & I_RI (25 downto  0) & B"00";

	-- ### ------------------------------------------------------ ###
	-- #   next instruction address :				#
	-- #     - add the offset         for branches			#
	-- #     - propagate-generate					#
	-- ### ------------------------------------------------------ ###

BRAOFS_SD  <= IMDSEX_SD (13 downto  0) & I_RI (15 downto  0) & B"00";

BRAPR0_SD  <= BRAOFS_SD or  NEXTPC_RD ;
BRAGN0_SD  <= BRAOFS_SD and NEXTPC_RD ;

	-- ### ------------------------------------------------------ ###
	-- #   next instruction address :				#
	-- #     - add the offset         for branches			#
	-- #     - 5 layers of propagate-generate			#
	-- ### ------------------------------------------------------ ###

BRAPR1_SD  <= BRAPR0_SD and  (BRAPR0_SD (30 downto 0) &  '1'   )     ;
BRAPR2_SD  <= BRAPR1_SD and  (BRAPR1_SD (29 downto 0) & B"11"  )     ;
BRAPR3_SD  <= BRAPR2_SD and  (BRAPR2_SD (27 downto 0) & X"f"   )     ;
BRAPR4_SD  <= BRAPR3_SD and  (BRAPR3_SD (23 downto 0) & X"ff"  )     ;
BRAPR5_SD  <= BRAPR4_SD and  (BRAPR4_SD (15 downto 0) & X"ffff")     ;

BRAGN1_SD  <= BRAGN0_SD or  ( BRAPR0_SD                          and
                             (BRAGN0_SD (30 downto 0) &  '0'   )    );
BRAGN2_SD  <= BRAGN1_SD or  ( BRAPR1_SD                          and
                             (BRAGN1_SD (29 downto 0) & B"00"  )    );
BRAGN3_SD  <= BRAGN2_SD or  ( BRAPR2_SD                          and
                             (BRAGN2_SD (27 downto 0) & X"0"   )    );
BRAGN4_SD  <= BRAGN3_SD or  ( BRAPR3_SD                          and
                             (BRAGN3_SD (23 downto 0) & X"00"  )    );
BRAGN5_SD  <= BRAGN4_SD or  ( BRAPR4_SD                          and
                             (BRAGN4_SD (15 downto 0) & X"0000")    );

	-- ### ------------------------------------------------------ ###
	-- #   next instruction address :				#
	-- #     - add the offset         for branches			#
	-- #     - sum and carry					#
	-- ### ------------------------------------------------------ ###

BRACRY_SD  <= BRAGN5_SD ;
BRACYI_SD  <= BRACRY_SD (30 downto  0) & '0';
BRAADR_SD  <= BRACYI_SD xor BRAOFS_SD xor NEXTPC_RD ;

	-- ### ------------------------------------------------------ ###
	-- #   next instruction address :				#
	-- #     - add 4                  for sequential instructions	#
	-- #     - propagate						#
	-- ### ------------------------------------------------------ ###

SEQPR0_SD  <= NEXTPC_RD (31 downto 2) ;

	-- ### ------------------------------------------------------ ###
	-- #   next instruction address :				#
	-- #     - add 4                  for sequential instructions	#
	-- #     - 5 layers of propagate				#
	-- ### ------------------------------------------------------ ###

SEQPR1_SD  <= SEQPR0_SD and  (SEQPR0_SD (30 downto 2) &  '1'   )     ;
SEQPR2_SD  <= SEQPR1_SD and  (SEQPR1_SD (29 downto 2) & B"11"  )     ;
SEQPR3_SD  <= SEQPR2_SD and  (SEQPR2_SD (27 downto 2) & X"f"   )     ;
SEQPR4_SD  <= SEQPR3_SD and  (SEQPR3_SD (23 downto 2) & X"ff"  )     ;
SEQPR5_SD  <= SEQPR4_SD and  (SEQPR4_SD (15 downto 2) & X"ffff")     ;

	-- ### ------------------------------------------------------ ###
	-- #   next instruction address :				#
	-- #     - add 4                  for sequential instructions	#
	-- #     - sum and carry					#
	-- ### ------------------------------------------------------ ###

SEQCRY_SD  <= SEQPR5_SD                         ;
SEQCYI_SD  <= SEQCRY_SD (30 downto  2) & B"100" ;
SEQADR_SD  <= SEQCYI_SD xor NEXTPC_RD           ;

	-- ### ------------------------------------------------------ ###
	-- #   conditional branches' condition				#
	-- ### ------------------------------------------------------ ###

S_CP_T_SD  <= SOPER_SD xor TOPER_SD;

S_EQ_T_SD  <= '1' when ( S_CP_T_SD     = X"00000000"    ) else '0' ;
S_LT_Z_SD  <= '1' when ( SOPER_SD (31) =  '1'           ) else '0' ;
S_LE_Z_SD  <= '1' when ((SOPER_SD (31) =  '1'       ) or
                        (SOPER_SD      = X"00000000")   ) else '0' ;

	-- ### ------------------------------------------------------ ###
	-- #   next instruction's address				#
	-- ### ------------------------------------------------------ ###

NEXTPC_SD  <=
  RETADR_SD when ( ERET_SD  = '1'                                ) else
  NEXTPC_RD when ( MTC0_SD  = '1'                                ) else
  SOPER_SD  when ( OPCOD_SD = jr_i     or  OPCOD_SD  = jalr_i    ) else
  JMPADR_SD when ( OPCOD_SD = j_i      or  OPCOD_SD  = jal_i     ) else
  BRAADR_SD when ((OPCOD_SD = beq_i    and S_EQ_T_SD = '1'   ) or
                  (OPCOD_SD = bne_i    and S_EQ_T_SD = '0'   ) or
                  (OPCOD_SD = bltz_i   and S_LT_Z_SD = '1'   ) or
                  (OPCOD_SD = bltzal_i and S_LT_Z_SD = '1'   ) or
                  (OPCOD_SD = blez_i   and S_LE_Z_SD = '1'   ) or
                  (OPCOD_SD = bgtz_i   and S_LE_Z_SD = '0'   ) or
                  (OPCOD_SD = bgez_i   and S_LT_Z_SD = '0'   ) or
                  (OPCOD_SD = bgezal_i and S_LT_Z_SD = '0'   )   ) else
  SEQADR_SD ;

	-- ### ------------------------------------------------------ ###
	-- #   fetch instruction in cache line				#
	-- ### ------------------------------------------------------ ###

SEQI_SD    <= not (I_BRNCH_SD or ERET_SD) ;

IINLIN_SD  <= '0'     when ((NEXTPC_RD or iline_msk) = X"ffffffff") else
              SEQI_SD ;    

	-- ### ------------------------------------------------------ ###
	-- #   destination register number				#
	-- #   effective destination register number			#
	-- #								#
	-- #   the destination register number is set to 0 when the	#
	-- #   instruction does not write into a register		#
	-- ### ------------------------------------------------------ ###

RD_SD      <= I_RI (15 downto 11) ;

EFFRD_SD   <= B"11111" when ((I_WREG_SD and WR31_SD  ) = '1') else
              RD_SD    when ((I_WREG_SD and I_RFMT_SD) = '1') else
              RT_SD    when ((I_WREG_SD and I_IFMT_SD) = '1') else
              B"00000" ;

	-- ### ------------------------------------------------------ ###
	-- #   destination register number				#
	-- #   decoded destination register number			# 
	-- #								#
	-- #   the decoded destination register number is used to	#
	-- #   check if a hardware (coprocessor zero's) register can	#
	-- #   be read by a Rdhwr instruction				#
	-- ### ------------------------------------------------------ ###

with RD_SD select
RDDEC_SD   <= X"0000_0001" when B"00000" ,
              X"0000_0002" when B"00001" ,
              X"0000_0004" when B"00010" ,
              X"0000_0008" when B"00011" ,
              X"0000_0010" when B"00100" ,
              X"0000_0020" when B"00101" ,
              X"0000_0040" when B"00110" ,
              X"0000_0080" when B"00111" ,
              X"0000_0100" when B"01000" ,
              X"0000_0200" when B"01001" ,
              X"0000_0400" when B"01010" ,
              X"0000_0800" when B"01011" ,
              X"0000_1000" when B"01100" ,
              X"0000_2000" when B"01101" ,
              X"0000_4000" when B"01110" ,
              X"0000_8000" when B"01111" ,
              X"0001_0000" when B"10000" ,
              X"0002_0000" when B"10001" ,
              X"0004_0000" when B"10010" ,
              X"0008_0000" when B"10011" ,
              X"0010_0000" when B"10100" ,
              X"0020_0000" when B"10101" ,
              X"0040_0000" when B"10110" ,
              X"0080_0000" when B"10111" ,
              X"0100_0000" when B"11000" ,
              X"0200_0000" when B"11001" ,
              X"0400_0000" when B"11010" ,
              X"0800_0000" when B"11011" ,
              X"1000_0000" when B"11100" ,
              X"2000_0000" when B"11101" ,
              X"4000_0000" when B"11110" ,
              X"8000_0000" when B"11111" ,
              X"0000_0000" when others   ;

	-- ### ------------------------------------------------------ ###
	-- #   effective hardware registers enbale			#
	-- ### ------------------------------------------------------ ###

EFFHWRE_SD <= RDDEC_SD and HWRENA_RM ;

	-- ### ------------------------------------------------------ ###
	-- #   user mode :						#
	-- #       - Kernel, Supervisor, User bits (Status 4, 3) = 10	#
	-- #   and - Error     Level          bit  (Status    2) =  0	#
	-- #   and - Exception Level          bit  (Status    1) =  0	#
	-- ### ------------------------------------------------------ ###

USRMOD_SX  <= '1' when (STATUS_RX (4 downto 1) = B"1000") else '0';

	-- ### ------------------------------------------------------ ###
	-- #   exceptions detected during Instruction Decode stage :	#
	-- #								#
	-- #     - reserved instruction					#
	-- #     - Break    instruction					#
	-- #     - Syscall  instruction					#
	-- #     - coprocessor zero unusable				#
	-- #     - coprocessor two  unusable				#
	-- ### ------------------------------------------------------ ###

RSVDINS_XD <= I_ILLG_SD ;

BREAK_XD   <= I_BREK_SD ;
SYSCALL_XD <= I_SYSC_SD ;

CPUNUSE_XD <= not STATUS_RX (28) and USRMOD_SX when (ERET_SD  = '1') else
              not STATUS_RX (28) and USRMOD_SX when (MFC0_SD  = '1') else
              not STATUS_RX (28) and USRMOD_SX when (MTC0_SD  = '1') else
              not STATUS_RX (28) and USRMOD_SX when (MFMC0_SD = '1') else
              not STATUS_RX (28) and USRMOD_SX when (WAIT_SD  = '1') else
              not STATUS_RX (30) and USRMOD_SX when (MFC2_SD  = '1') else
              not STATUS_RX (30) and USRMOD_SX when (MTC2_SD  = '1') else
              '0'                              ;

CPNBR_XD   <= B"10"                            when (MFC2_SD  = '1') else
              B"10"                            when (MTC2_SD  = '1') else
              B"00"                            ;

	-- ### ------------------------------------------------------ ###
	-- #   instruction access request				#
	-- #								#
	-- #     - disable instruction fetch when the instruction in	#
	-- #       Execute stage is a Wait.				#
	-- #								#
	-- #       This is to reduce the power consumption in the	#
	-- #       instruction cache.					#
	-- #								#
	-- #       Since I_RQ is a critical signal, it does not depend	#
	-- #       on the instruction in Instruction Decode stage. The	#
	-- #       Decode phase is used to detect the Wait instruction.	#
	-- #       The instruction fetch will be disabled in the next	#
	-- #       cycle.						#
	-- ### ------------------------------------------------------ ###

IRQ_SE     <= '0'    when (WAIT_SE    = '1') else '1';

	-- ### ------------------------------------------------------ ###
	-- #   instruction access not ready				#
	-- ### ------------------------------------------------------ ###

INOTRDY_SE <= (not I_ACCPT) or (not IRQ_RE) ;

	-- ### ------------------------------------------------------ ###
	-- #   data hazards in Execute stage :				#
	-- #								#
	-- #   compare source registers of the current instruction	#
	-- #   with the destination register of previous instructions	#
	-- ### ------------------------------------------------------ ###

CP_SDM_SE  <= RS_RD xor RD_RE;
CP_SDW_SE  <= RS_RD xor RD_RM;

CP_TDM_SE  <= RT_RD xor RD_RE;
CP_TDW_SE  <= RT_RD xor RD_RM;

SREADR0_SE <= '1' when (RS_RD = B"00000") else '0' ;
TREADR0_SE <= '1' when (RT_RD = B"00000") else '0' ;

	-- ### ------------------------------------------------------ ###
	-- #   data hazards in Execute stage :				#
	-- #								#
	-- #   - hazard on integer registers - effective comparisons :	#
	-- #       the destination register number of a previous	#
	-- #       instruction matches a source register number and the	#
	-- #       the registers are effectively used (comparisons fail	#
	-- #       when R0 is used)					#
	-- #								#
	-- #   - hazard on Lo register :				#
	-- #       the instruction present in Memory Access stage or	#
	-- #       in Write Back stage is writing into Lo Register	#
	-- #								#
	-- #   - hazard on Hi register :				#
	-- #       the instruction present in Memory Access stage or	#
	-- #       in Write Back stage is writing into Hi Register	#
	-- ### ------------------------------------------------------ ###

HZ_SDM_SE  <= '1' when (CP_SDM_SE  = B"00000" and SREADR0_SE = '0' and
                        I_READS_SE =  '1'     and I_WREG_SM  = '1'    ) else
              '0' ;
HZ_SDW_SE  <= '1' when (CP_SDW_SE  = B"00000" and SREADR0_SE = '0' and
                        I_READS_SE =  '1'     and I_WREG_SW  = '1'    ) else
              '0' ;

HZ_TDM_SE  <= '1' when (CP_TDM_SE  = B"00000" and TREADR0_SE = '0' and
                        I_READT_SE =  '1'     and I_WREG_SM  = '1'    ) else
              '0' ;
HZ_TDW_SE  <= '1' when (CP_TDW_SE  = B"00000" and TREADR0_SE = '0' and
                        I_READT_SE =  '1'     and I_WREG_SW  = '1'    ) else
              '0' ;

HZ_LO_SE   <= '1' when (I_EUSEL_SE =  '1'     and I_WLO_SM   = '1'    ) else
              '1' when (I_EUSEL_SE =  '1'     and I_WLO_SW   = '1'    ) else
              '0' ;
HZ_HI_SE   <= '1' when (I_EUSEH_SE =  '1'     and I_WHI_SM   = '1'    ) else
              '1' when (I_EUSEH_SE =  '1'     and I_WHI_SW   = '1'    ) else
              '0' ;

	-- ### ------------------------------------------------------ ###
	-- #   stall due to data hazards in Execute stage :		#
	-- #								#
	-- #   Examples :						#
	-- #      Lw   Ri, --, --          Mtlo Ri, --, --		#
	-- #      Add  --, Ri, --          Mflo Ri, --, --		#
	-- #								#
	-- #   - s or t operand are used by Execute stage and the	#
	-- #     result is produced by the Memory Access stage of the	#
	-- #     previous instruction					#
	-- #								#
	-- #   - using Lo Register in Execute stage when Lo is being	#
	-- #     written by the instruction present in Memory Access	#
	-- #     or in Write Back stage					#
	-- #								#
	-- #   - using Hi Register in Execute stage when Hi is being	#
	-- #     written by the instruction present in Memory Access	#
	-- #     or in Write Back stage					#
	-- ### ------------------------------------------------------ ###

DATHZDS_SE <= (I_EUSES_SE and HZ_SDM_SE and I_MPDC_SM) or
              (I_EUSET_SE and HZ_TDM_SE and I_MPDC_SM) or

              (               HZ_LO_SE               ) or
              (               HZ_HI_SE               )    ;

	-- ### ------------------------------------------------------ ###
	-- #   stall due to hazards in Execute stage :			#
	-- #     - data        hazards					#
	-- ### ------------------------------------------------------ ###

HAZARDS_SE <= DATHZDS_SE;

	-- ### ------------------------------------------------------ ###
	-- #   effective operands (bypasses)				#
	-- ### ------------------------------------------------------ ###

SOPER_SE   <= RES_RE   when (HZ_SDM_SE = '1'   ) else
              DATA_RM  when (HZ_SDW_SE = '1'   ) else
              SOPER_RD ;

TOPER_SE   <= RES_RE   when (HZ_TDM_SE = '1'   ) else
              DATA_RM  when (HZ_TDW_SE = '1'   ) else
              TOPER_RD ;

IOPER_SE   <= LO_RW    when (OPCOD_RD  = mflo_i) else
              HI_RW    when (OPCOD_RD  = mfhi_i) else
              IOPER_RD ;

	-- ### ------------------------------------------------------ ###
	-- #   destination register number				#
	-- #   conditional write (Movz, Movn) :				#
	-- #								#
	-- #   the destination register number is set to 0 when the	#
	-- #   condition is false					#
	-- ### ------------------------------------------------------ ###

T_EQ_Z_SE  <= '1'           when (TOPER_SE = X"00000000") else  '0'     ;
CNDWRG_SE  <= not T_EQ_Z_SE when (OPCOD_RD =   movn_i   ) else
                  T_EQ_Z_SE when (OPCOD_RD =   movz_i   ) else  '1'     ;

RD_SE      <=     RD_RD     when (CNDWRG_SE =  '1'      ) else B"00000" ;

	-- ### ------------------------------------------------------ ###
	-- #   operands							#
	-- ### ------------------------------------------------------ ###

XOPER_SE   <=     SOPER_SE ;
YOPER_SE   <=     IOPER_RD when (I_IFMT_SE = '1') else TOPER_SE ;

	-- ### ------------------------------------------------------ ###
	-- #   count leading - first cycle (Execute stage)		#
	-- #     - effective operands					#
	-- ### ------------------------------------------------------ ###

CLDXOP_SE  <= not SOPER_SE when (I_CLZ_SE  = '1') else SOPER_SE ;

	-- ### ------------------------------------------------------ ###
	-- #   count leading - first cycle (Execute stage)		#
	-- #     - increment						#
	-- #     - 5 layers of propagate				#
	-- ### ------------------------------------------------------ ###

CLDPR1_SE  <=     CLDXOP_SE and ( '1'    & CLDXOP_SE (31 downto  1)) ;
CLDPR2_SE  <=     CLDPR1_SE and (B"11"   & CLDPR1_SE (31 downto  2)) ;
CLDPR3_SE  <=     CLDPR2_SE and (B"1111" & CLDPR2_SE (31 downto  4)) ;
CLDPR4_SE  <=     CLDPR3_SE and (X"ff"   & CLDPR3_SE (31 downto  8)) ;
CLDPR5_SE  <=     CLDPR4_SE and (X"ffff" & CLDPR4_SE (31 downto 16)) ;

CLDMSK_SE  <= not CLDXOP_SE and ( '1'    & CLDPR5_SE (31 downto  1)) ;

	-- ### ------------------------------------------------------ ###
	-- #   count leading - first cycle (Execute stage)		#
	-- #     - encode						#
	-- ### ------------------------------------------------------ ###

CLD_5_SE   <=     CLDPR5_SE ( 0)                     ;

CLD_4_SE   <=     CLDMSK_SE (15) or CLDMSK_SE (14) or
                  CLDMSK_SE (13) or CLDMSK_SE (12) or
                  CLDMSK_SE (11) or CLDMSK_SE (10) or
                  CLDMSK_SE ( 9) or CLDMSK_SE ( 8) or
                  CLDMSK_SE ( 7) or CLDMSK_SE ( 6) or
                  CLDMSK_SE ( 5) or CLDMSK_SE ( 4) or
                  CLDMSK_SE ( 3) or CLDMSK_SE ( 2) or
                  CLDMSK_SE ( 1) or CLDMSK_SE ( 0)   ;

CLD_3_SE   <=     CLDMSK_SE (23) or CLDMSK_SE (22) or
                  CLDMSK_SE (21) or CLDMSK_SE (20) or
                  CLDMSK_SE (19) or CLDMSK_SE (18) or
                  CLDMSK_SE (17) or CLDMSK_SE (16) or
                  CLDMSK_SE ( 7) or CLDMSK_SE ( 6) or
                  CLDMSK_SE ( 5) or CLDMSK_SE ( 4) or
                  CLDMSK_SE ( 3) or CLDMSK_SE ( 2) or
                  CLDMSK_SE ( 1) or CLDMSK_SE ( 0)   ;

CLD_2_SE   <=     CLDMSK_SE (27) or CLDMSK_SE (26) or
                  CLDMSK_SE (25) or CLDMSK_SE (24) or
                  CLDMSK_SE (19) or CLDMSK_SE (18) or
                  CLDMSK_SE (17) or CLDMSK_SE (16) or
                  CLDMSK_SE (11) or CLDMSK_SE (10) or
                  CLDMSK_SE ( 9) or CLDMSK_SE ( 8) or
                  CLDMSK_SE ( 3) or CLDMSK_SE ( 2) or
                  CLDMSK_SE ( 1) or CLDMSK_SE ( 0)   ;

CLD_1_SE   <=     CLDMSK_SE (29) or CLDMSK_SE (28) or
                  CLDMSK_SE (25) or CLDMSK_SE (24) or
                  CLDMSK_SE (21) or CLDMSK_SE (20) or
                  CLDMSK_SE (17) or CLDMSK_SE (16) or
                  CLDMSK_SE (13) or CLDMSK_SE (12) or
                  CLDMSK_SE ( 9) or CLDMSK_SE ( 8) or
                  CLDMSK_SE ( 5) or CLDMSK_SE ( 4) or
                  CLDMSK_SE ( 1) or CLDMSK_SE ( 0)   ;

CLD_0_SE   <=     CLDMSK_SE (30) or CLDMSK_SE (28) or
                  CLDMSK_SE (26) or CLDMSK_SE (24) or
                  CLDMSK_SE (22) or CLDMSK_SE (20) or
                  CLDMSK_SE (18) or CLDMSK_SE (16) or
                  CLDMSK_SE (14) or CLDMSK_SE (12) or
                  CLDMSK_SE (10) or CLDMSK_SE ( 8) or
                  CLDMSK_SE ( 6) or CLDMSK_SE ( 4) or
                  CLDMSK_SE ( 2) or CLDMSK_SE ( 0)   ;

RCLEAD_SE  <= X"0000_00" & B"00" & CLD_5_SE & CLD_4_SE & CLD_3_SE &
                                   CLD_2_SE & CLD_1_SE & CLD_0_SE  ;

	-- ### ------------------------------------------------------ ###
	-- #   operands for arithmetic operations			#
	-- ### ------------------------------------------------------ ###

XARITH_SE  <= X"0000_0000" when ((MTC2_SE or MFC2_SE) = '1') else XOPER_SE ;
YARITH_SE  <= not YOPER_SE when ( I_SUB_SE            = '1') else YOPER_SE ;

	-- ### ------------------------------------------------------ ###
	-- #   arithmetic result					#
	-- #     - propagate-generate					#
	-- ### ------------------------------------------------------ ###

ARIPR0_SE  <= XARITH_SE or  YARITH_SE ;
ARIGN0_SE  <= XARITH_SE and YARITH_SE ;

	-- ### ------------------------------------------------------ ###
	-- #   arithmetic result					#
	-- #     - 5 layers of propagate-generate			#
	-- ### ------------------------------------------------------ ###

ARIPR1_SE  <= ARIPR0_SE and  (ARIPR0_SE (30 downto 0) &  '1'   )     ;
ARIPR2_SE  <= ARIPR1_SE and  (ARIPR1_SE (29 downto 0) & B"11"  )     ;
ARIPR3_SE  <= ARIPR2_SE and  (ARIPR2_SE (27 downto 0) & X"f"   )     ;
ARIPR4_SE  <= ARIPR3_SE and  (ARIPR3_SE (23 downto 0) & X"ff"  )     ;
ARIPR5_SE  <= ARIPR4_SE and  (ARIPR4_SE (15 downto 0) & X"ffff")     ;

ARIGN1_SE  <= ARIGN0_SE or  ( ARIPR0_SE                          and
                             (ARIGN0_SE (30 downto 0) &  '0'   )    );
ARIGN2_SE  <= ARIGN1_SE or  ( ARIPR1_SE                          and
                             (ARIGN1_SE (29 downto 0) & B"00"  )    );
ARIGN3_SE  <= ARIGN2_SE or  ( ARIPR2_SE                          and
                             (ARIGN2_SE (27 downto 0) & X"0"   )    );
ARIGN4_SE  <= ARIGN3_SE or  ( ARIPR3_SE                          and
                             (ARIGN3_SE (23 downto 0) & X"00"  )    );
ARIGN5_SE  <= ARIGN4_SE or  ( ARIPR4_SE                          and
                             (ARIGN4_SE (15 downto 0) & X"0000")    );

	-- ### ------------------------------------------------------ ###
	-- #   arithmetic result					#
	-- #     - sum and carry					#
	-- ### ------------------------------------------------------ ###

ARICRY_SE  <= ARIGN5_SE or ARIPR5_SE when (I_SUB_SE = '1') else ARIGN5_SE ;
ARICYI_SE  <= ARICRY_SE (30 downto 0)   &  I_SUB_SE                       ;

RARITH_SE  <= XARITH_SE xor YARITH_SE xor ARICYI_SE ;

	-- ### ------------------------------------------------------ ###
	-- #   arithmetic overflow					#
	-- ### ------------------------------------------------------ ###

OVERFLW_SE <= ARICRY_SE (31) xor ARICRY_SE (30);

	-- ### ------------------------------------------------------ ###
	-- #   test and set unit					#
	-- ### ------------------------------------------------------ ###

X_CP_Y_SE  <= XOPER_SE xor YOPER_SE;

X_EQ_Y_SE  <= '1' when ( X_CP_Y_SE                      = X"00000000") else '0';
X_LT_Y_SE  <= '1' when ((RARITH_SE (31) xor OVERFLW_SE) =  '1'       ) else '0';
X_LTU_Y_SE <= '1' when ( ARICRY_SE (31)                 =  '0'       ) else '0';

	-- ### ------------------------------------------------------ ###
	-- #   test and set unit's result				#
	-- ### ------------------------------------------------------ ###

TESTBIT_SE <=     X_LT_Y_SE  when (I_LT_SE  = '1') else
                  X_LTU_Y_SE when (I_LTU_SE = '1') else
              not X_LT_Y_SE  when (I_GE_SE  = '1') else
              not X_LTU_Y_SE when (I_GEU_SE = '1') else
                  X_EQ_Y_SE  when (I_EQ_SE  = '1') else
              not X_EQ_Y_SE  when (I_NE_SE  = '1') else
              '0'            ;

RTEST_SE   <= X"0000000" & B"000" & TESTBIT_SE;

	-- ### ------------------------------------------------------ ###
	-- #   operands for shift operations				#
	-- ### ------------------------------------------------------ ###

with OPCOD_RD select
XSHF_SE    <= SHAM_RD               when sll_i  | srl_i | sra_i,
              SOPER_SE (4 downto 0) when others ;

YSHF_SE    <= TOPER_SE ;

	-- ### ------------------------------------------------------ ###
	-- #   shifter							#
	-- ### ------------------------------------------------------ ###

SHSGN_SE   <= X"0000_0000" when ((I_OSGND_SE and YSHF_SE (31)) = '0') else
              X"ffff_ffff" ;

	-- ### ------------------------------------------------------ ###
	-- #   shifter							#
	-- ### ------------------------------------------------------ ###

SHF0_T_SE  <=
  YSHF_SE (30 downto  0) &  '0'                    when (I_SHR_SE = '0') else
  YSHF_SE (30 downto  0) & YSHF_SE  (31          ) ;
SHF1_T_SE  <=
  SHF0_SE (29 downto  0) & B"00"                   when (I_SHR_SE = '0') else
  SHF0_SE (29 downto  0) & SHF0_SE  (31 downto 30) ;
SHF2_T_SE  <=
  SHF1_SE (27 downto  0) & X"0"                    when (I_SHR_SE = '0') else
  SHF1_SE (27 downto  0) & SHF1_SE  (31 downto 28) ;
SHF3_T_SE  <=
  SHF2_SE (23 downto  0) & X"00"                   when (I_SHR_SE = '0') else
  SHF2_SE (23 downto  0) & SHF2_SE  (31 downto 24) ;
SHF4_T_SE  <=
  SHF3_SE (15 downto  0) & X"0000"                 when (I_SHR_SE = '0') else
  SHF3_SE (15 downto  0) & SHF3_SE  (31 downto 16) ;
SHF5_T_SE  <=
  SHF4_SE (30 downto  0) & SHF4_SE  (31          ) ;

SHF0_F_SE  <=
  YSHF_SE (31 downto  1) & SHSGN_SE (           0) when (I_SHR_SE = '1') else
  YSHF_SE (31 downto  0)                           ;
SHF1_F_SE  <=
  SHF0_SE (31 downto  3) & SHSGN_SE ( 2 downto  1) &
  SHF0_SE (           0)                           when (I_SHR_SE = '1') else
  SHF0_SE (31 downto  0)                           ;
SHF2_F_SE  <=
  SHF1_SE (31 downto  7) & SHSGN_SE ( 6 downto  3) &
  SHF1_SE ( 2 downto  0)                           when (I_SHR_SE = '1') else
  SHF1_SE (31 downto  0)                           ;
SHF3_F_SE  <=
  SHF2_SE (31 downto 15) & SHSGN_SE (14 downto  7) &
  SHF2_SE ( 6 downto  0)                           when (I_SHR_SE = '1') else
  SHF2_SE (31 downto  0)                           ;
SHF4_F_SE  <=
  SHF3_SE (31          ) & SHSGN_SE (30 downto 15) &
  SHF3_SE (14 downto  0)                           when (I_SHR_SE = '1') else
  SHF3_SE (31 downto  0)                           ;
SHF5_F_SE  <=
  SHF4_SE (31 downto  0)                           ;

	-- ### ------------------------------------------------------ ###
	-- #   shifter							#
	-- ### ------------------------------------------------------ ###

SHAM_SE    <= '0' &     XSHF_SE when (I_SHR_SE = '0') else
              '1' & not XSHF_SE ;

SHF0_SE    <= SHF0_T_SE when (SHAM_SE (0) = '1') else SHF0_F_SE ;
SHF1_SE    <= SHF1_T_SE when (SHAM_SE (1) = '1') else SHF1_F_SE ;
SHF2_SE    <= SHF2_T_SE when (SHAM_SE (2) = '1') else SHF2_F_SE ;
SHF3_SE    <= SHF3_T_SE when (SHAM_SE (3) = '1') else SHF3_F_SE ;
SHF4_SE    <= SHF4_T_SE when (SHAM_SE (4) = '1') else SHF4_F_SE ;
SHF5_SE    <= SHF5_T_SE when (SHAM_SE (5) = '1') else SHF5_F_SE ;

RSHIFT_SE  <= SHF5_SE   ;

	-- ### ------------------------------------------------------ ###
	-- #   logic unit						#
	-- ### ------------------------------------------------------ ###

RLOGIC_SE  <= XOPER_SE and YOPER_SE when (I_AND_SE   = '1') else
              XOPER_SE nor YOPER_SE when (I_NOR_SE   = '1') else
              XOPER_SE xor YOPER_SE when (I_XOR_SE   = '1') else
              XOPER_SE or  YOPER_SE ;

	-- ### ------------------------------------------------------ ###
	-- #   transparent result					#
	-- ### ------------------------------------------------------ ###

ROPER_SE   <= SOPER_SE              when (I_SOPER_SE = '1') else
              TOPER_SE              when (I_TOPER_SE = '1') else
              IOPER_SE              ;

	-- ### ------------------------------------------------------ ###
	-- #   result out of alu					#
	-- ### ------------------------------------------------------ ###

RES_SE     <= RARITH_SE             when (I_ARITH_SE = '1') else
              RLOGIC_SE             when (I_LOGIC_SE = '1') else
              RSHIFT_SE             when (I_SHIFT_SE = '1') else
              RTEST_SE              when (I_TEST_SE  = '1') else
              RCLEAD_SE             when (I_CLEAD_SE = '1') else
              ROPER_SE              ;

	-- ### ------------------------------------------------------ ###
	-- #   multiplier-accumulator					#
	-- #								#
	-- #   The following lines describes the implementation of	#
	-- #   the 32-bit by 32-bit parallel multiplier-accumulator.	#
	-- #								#
	-- #   It can perform signed / unsigned multiplications.	#
	-- #   The result of the multiplication may be add to or	#
	-- #   subtracted from a third operand.				#
	-- #								#
	-- #   Unsigned multiplication-add :				#
	-- #     The final result is    R = Z + (X * Y)			#
	-- #								#
	-- #     Proceed to a unsigned multiplication of X by Y. The X	#
	-- #     operand is zero extended.				#
	-- #								#
	-- #   Signed multiplication-add :				#
	-- #     The final result is    R = Z + (X * Y)			#
	-- #     Two situations may happen.				#
	-- #								#
	-- #     if Y >= 0 :						#
	-- #       proceed to an unsigned multiplication X by Y.	#
	-- #       The X operand is sign extended.			#
	-- #								#
	-- #     if Y <  0 :						#
	-- #       R =           Z      + (X *      Y          )	#
	-- #       R =           Z      - (X * (   -Y    )     )	#
	-- #       R =  -  ((   -Z    ) + (X * (   -Y    )     ))	#
	-- #       R =  -  ((not Z + 1) + (X * (   -Y    )     ))	#
	-- #       R =  -  ((not Z + 1) + (X * (   -Y    )     ))	#
	-- #       R =  -  ((not Z + 1) + (X * (not Y + 1)     ))	#
	-- #       R =  -  ((not Z + 1) + (X * (not Y    )  + X))	#
	-- #       R =  -  ((not Z + 1) + (X * (not Y    )) + X )	#
	-- #       R =  -  ((not Z    ) + (X * (not Y    )) + X ) - 1	#
	-- #								#
	-- #       R = not ((not Z    ) + (X * (not Y    )) + X )	#
	-- #								#
	-- #       Proceed to an unsigned multiplication of X by	#
	-- #       (not Y). The X operand is sign extended.		#
	-- #       Two extra partial products are created : (not Z)	#
	-- #       and X.						#
	-- #								#
	-- #   Unsigned multiplication-subtract :			#
	-- #     The final result is    R = Z - (X * Y)			#
	-- #								#
	-- #       R =           Z      - (X *      Y          )	#
	-- #       R =  -  ((   -Z    ) + (X *      Y          ))	#
	-- #       R =  -  ((not Z + 1) + (X *      Y          ))	#
	-- #       R =  -  ((not Z    ) + (X *      Y     )     ) - 1	#
	-- #								#
	-- #       R = not ((not Z    ) + (X *      Y     )     )	#
	-- #								#
	-- #       Proceed to an unsigned multiplication of X by	#
	-- #       Y      . The X operand is sign extended.		#
	-- #       An  extra partial product  is  created : (not Z).	#
	-- #								#
	-- #   Signed multiplication-subtract :				#
	-- #     The final result is    R = Z - (X * Y)			#
	-- #     Two situations may happen.				#
	-- #								#
	-- #     if Y >= 0 :						#
	-- #       R =           Z      - (X *      Y          )	#
	-- #       R =  -  ((   -Z    ) + (X *      Y          ))	#
	-- #       R =  -  ((not Z + 1) + (X *      Y          ))	#
	-- #       R =  -  ((not Z    ) + (X *      Y     )     ) - 1	#
	-- #								#
	-- #       R = not ((not Z    ) + (X *      Y     )     )	#
	-- #								#
	-- #       Proceed to an unsigned multiplication of X by	#
	-- #       Y      . The X operand is sign extended.		#
	-- #       An  extra partial product  is  created : (not Z).	#
	-- #								#
	-- #     if Y < 0  :						#
	-- #       R =           Z      - (X *      Y          )	#
	-- #       R =           Z      + (X * (   -Y    )     )	#
	-- #       R =           Z      + (X * (not Y + 1)     )	#
	-- #       R =           Z      + (X * (not Y    )  + X)	#
	-- #								#
	-- #       R =           Z      + (X * (not Y    )) + X		#
	-- #								#
	-- #       Proceed to an unsigned multiplication of X by	#
	-- #       (not Y). The X operand is sign extended.		#
	-- #       Two extra partial products are created :      Z	#
	-- #       and X.						#
	-- #								#
	-- #   Unsigned multiplication :				#
	-- #     Let P be the multiplication's result : P = A * B	#
	-- #								#
	-- #     First, the A operand is extended to 64 bits. Then, 32	#
	-- #     partial products are produced. The partial product Pi	#
	-- #     is either the extended A operand shifted by i		#
	-- #     positions to the right if the corresponding weight of	#
	-- #     the B operand is 1 or, 0 if the corresponding weight	#
	-- #     of the B operand is 0.					#
	-- #								#
	-- #   Then, these 32 partial products and the two potential	#
	-- #   extra partial products are summed through a tree of	#
	-- #   Carry Save Adders. Each layer of Carry Save Adder makes	#
	-- #   a 3 to 2 reduction.					#
	-- #								#
	-- #   Eight layer of Carry Save Adders are required to reduce	#
	-- #   the number of partial products to 2.			#
	-- #								#
	-- #   Then, the two resulting numbers are reduced to the	#
	-- #   final result through a classic adder and inverted if	#
	-- #   necessary.						#
	-- ### ------------------------------------------------------ ###

	-- ### ------------------------------------------------------ ###
	-- #   multiplication's patial products reduction scheme :	#
	-- #								#
	-- #   P : partial product					#
	-- #   X : extra partial product				#
	-- #   Z : third operand					#
	-- #   | : transmition						#
	-- #								#
	-- #   PPPP  PPPP  PPPP  PPPP    PPPP  PPPP  PPPP  PPPP X   Z	#
	-- #   ------------------------------------------------------	#
	-- #   xxxx  xxxx  xxxx  xxxx    xxxx  xxxx  xxxx  xxxx x   x	#
	-- #   | xx  | xx  | xx  | xx    | xx  | xx  | xx  | xx |   |	#
	-- #    xx    xx    xx    xx      xx    xx    xx    xx  |   |	#
	-- #    |   xx      |   xx           xx    xx         xx    |	#
	-- #      xx          xx                 xx      xx         |	#
	-- #            xx            xx                      xx	#
	-- #                  xx                  xx			#
	-- #                  |         xx				#
	-- #                       xx					#
	-- ### ------------------------------------------------------ ###

	-- ### ------------------------------------------------------ ###
	-- #   multiply - first cycle (Execute stage)			#
	-- #     - effective operands					#
	-- ### ------------------------------------------------------ ###

XMXPP_SE   <=                   I_OSGND_SE and  TOPER_SE (31)  ;

XMSGN_SE   <=                   I_OSGND_SE and  SOPER_SE (31)  ;
YMSGN_SE   <=                   I_OSGND_SE and  TOPER_SE (31)  ;
ZMINV_SE   <= I_MSUB_SE   xor  (I_OSGND_SE and  TOPER_SE (31)) ;

XMEXT_SE   <= X"00000000" when (XMSGN_SE = '0') else X"ffffffff" ;

XMUL_SE    <= SOPER_SE                                           ;
YMUL_SE    <= TOPER_SE    when (YMSGN_SE = '0') else not TOPER_SE;

	-- ### ------------------------------------------------------ ###
	-- #   multiply - first cycle (Execute stage)			#
	-- #     - extended operands					#
	-- ### ------------------------------------------------------ ###

XX00MUL_SE <= XMEXT_SE (31 downto 0) & XMUL_SE                       ;
XX01MUL_SE <= XMEXT_SE (30 downto 0) & XMUL_SE &               B"0"  ;
XX02MUL_SE <= XMEXT_SE (29 downto 0) & XMUL_SE &               B"00" ;
XX03MUL_SE <= XMEXT_SE (28 downto 0) & XMUL_SE &               B"000";
XX04MUL_SE <= XMEXT_SE (27 downto 0) & XMUL_SE & X"0"                ;
XX05MUL_SE <= XMEXT_SE (26 downto 0) & XMUL_SE & X"0"        & B"0"  ;
XX06MUL_SE <= XMEXT_SE (25 downto 0) & XMUL_SE & X"0"        & B"00" ;
XX07MUL_SE <= XMEXT_SE (24 downto 0) & XMUL_SE & X"0"        & B"000";
XX08MUL_SE <= XMEXT_SE (23 downto 0) & XMUL_SE & X"00"               ;
XX09MUL_SE <= XMEXT_SE (22 downto 0) & XMUL_SE & X"00"       & B"0"  ;
XX10MUL_SE <= XMEXT_SE (21 downto 0) & XMUL_SE & X"00"       & B"00" ;
XX11MUL_SE <= XMEXT_SE (20 downto 0) & XMUL_SE & X"00"       & B"000";
XX12MUL_SE <= XMEXT_SE (19 downto 0) & XMUL_SE & X"000"              ;
XX13MUL_SE <= XMEXT_SE (18 downto 0) & XMUL_SE & X"000"      & B"0"  ;
XX14MUL_SE <= XMEXT_SE (17 downto 0) & XMUL_SE & X"000"      & B"00" ;
XX15MUL_SE <= XMEXT_SE (16 downto 0) & XMUL_SE & X"000"      & B"000";
XX16MUL_SE <= XMEXT_SE (15 downto 0) & XMUL_SE & X"0000"             ;
XX17MUL_SE <= XMEXT_SE (14 downto 0) & XMUL_SE & X"0000"     & B"0"  ;
XX18MUL_SE <= XMEXT_SE (13 downto 0) & XMUL_SE & X"0000"     & B"00" ;
XX19MUL_SE <= XMEXT_SE (12 downto 0) & XMUL_SE & X"0000"     & B"000";
XX20MUL_SE <= XMEXT_SE (11 downto 0) & XMUL_SE & X"00000"            ;
XX21MUL_SE <= XMEXT_SE (10 downto 0) & XMUL_SE & X"00000"    & B"0"  ;
XX22MUL_SE <= XMEXT_SE ( 9 downto 0) & XMUL_SE & X"00000"    & B"00" ;
XX23MUL_SE <= XMEXT_SE ( 8 downto 0) & XMUL_SE & X"00000"    & B"000";
XX24MUL_SE <= XMEXT_SE ( 7 downto 0) & XMUL_SE & X"000000"           ;
XX25MUL_SE <= XMEXT_SE ( 6 downto 0) & XMUL_SE & X"000000"   & B"0"  ;
XX26MUL_SE <= XMEXT_SE ( 5 downto 0) & XMUL_SE & X"000000"   & B"00" ;
XX27MUL_SE <= XMEXT_SE ( 4 downto 0) & XMUL_SE & X"000000"   & B"000";
XX28MUL_SE <= XMEXT_SE ( 3 downto 0) & XMUL_SE & X"0000000"          ;
XX29MUL_SE <= XMEXT_SE ( 2 downto 0) & XMUL_SE & X"0000000"  & B"0"  ;
XX30MUL_SE <= XMEXT_SE ( 1 downto 0) & XMUL_SE & X"0000000"  & B"00" ;
XX31MUL_SE <= XMEXT_SE (          0) & XMUL_SE & X"0000000"  & B"000";

	-- ### ------------------------------------------------------ ###
	-- #   multiply - first cycle (Execute stage)			#
	-- #     - partial products					#
	-- ### ------------------------------------------------------ ###

PP00MUL_SE <= XX00MUL_SE when (YMUL_SE ( 0) = '1') else X"00000000_00000000";
PP01MUL_SE <= XX01MUL_SE when (YMUL_SE ( 1) = '1') else X"00000000_00000000";
PP02MUL_SE <= XX02MUL_SE when (YMUL_SE ( 2) = '1') else X"00000000_00000000";
PP03MUL_SE <= XX03MUL_SE when (YMUL_SE ( 3) = '1') else X"00000000_00000000";
PP04MUL_SE <= XX04MUL_SE when (YMUL_SE ( 4) = '1') else X"00000000_00000000";
PP05MUL_SE <= XX05MUL_SE when (YMUL_SE ( 5) = '1') else X"00000000_00000000";
PP06MUL_SE <= XX06MUL_SE when (YMUL_SE ( 6) = '1') else X"00000000_00000000";
PP07MUL_SE <= XX07MUL_SE when (YMUL_SE ( 7) = '1') else X"00000000_00000000";
PP08MUL_SE <= XX08MUL_SE when (YMUL_SE ( 8) = '1') else X"00000000_00000000";
PP09MUL_SE <= XX09MUL_SE when (YMUL_SE ( 9) = '1') else X"00000000_00000000";
PP10MUL_SE <= XX10MUL_SE when (YMUL_SE (10) = '1') else X"00000000_00000000";
PP11MUL_SE <= XX11MUL_SE when (YMUL_SE (11) = '1') else X"00000000_00000000";
PP12MUL_SE <= XX12MUL_SE when (YMUL_SE (12) = '1') else X"00000000_00000000";
PP13MUL_SE <= XX13MUL_SE when (YMUL_SE (13) = '1') else X"00000000_00000000";
PP14MUL_SE <= XX14MUL_SE when (YMUL_SE (14) = '1') else X"00000000_00000000";
PP15MUL_SE <= XX15MUL_SE when (YMUL_SE (15) = '1') else X"00000000_00000000";
PP16MUL_SE <= XX16MUL_SE when (YMUL_SE (16) = '1') else X"00000000_00000000";
PP17MUL_SE <= XX17MUL_SE when (YMUL_SE (17) = '1') else X"00000000_00000000";
PP18MUL_SE <= XX18MUL_SE when (YMUL_SE (18) = '1') else X"00000000_00000000";
PP19MUL_SE <= XX19MUL_SE when (YMUL_SE (19) = '1') else X"00000000_00000000";
PP20MUL_SE <= XX20MUL_SE when (YMUL_SE (20) = '1') else X"00000000_00000000";
PP21MUL_SE <= XX21MUL_SE when (YMUL_SE (21) = '1') else X"00000000_00000000";
PP22MUL_SE <= XX22MUL_SE when (YMUL_SE (22) = '1') else X"00000000_00000000";
PP23MUL_SE <= XX23MUL_SE when (YMUL_SE (23) = '1') else X"00000000_00000000";
PP24MUL_SE <= XX24MUL_SE when (YMUL_SE (24) = '1') else X"00000000_00000000";
PP25MUL_SE <= XX25MUL_SE when (YMUL_SE (25) = '1') else X"00000000_00000000";
PP26MUL_SE <= XX26MUL_SE when (YMUL_SE (26) = '1') else X"00000000_00000000";
PP27MUL_SE <= XX27MUL_SE when (YMUL_SE (27) = '1') else X"00000000_00000000";
PP28MUL_SE <= XX28MUL_SE when (YMUL_SE (28) = '1') else X"00000000_00000000";
PP29MUL_SE <= XX29MUL_SE when (YMUL_SE (29) = '1') else X"00000000_00000000";
PP30MUL_SE <= XX30MUL_SE when (YMUL_SE (30) = '1') else X"00000000_00000000";
PP31MUL_SE <= XX31MUL_SE when (YMUL_SE (31) = '1') else X"00000000_00000000";

	-- ### ------------------------------------------------------ ###
	-- #   multiply - first cycle (Execute stage)			#
	-- #     - extra partial products				#
	-- ### ------------------------------------------------------ ###

PPXXMUL_SE <= XX00MUL_SE when (XMXPP_SE     = '1') else X"00000000_00000000";

	-- ### ------------------------------------------------------ ###
	-- #   multiply - first cycle (Execute stage)			#
	-- #								#
	-- #     - carry save adders - first layer			#
	-- #       32           partial products reduced to 24		#
	-- #        2 extra     partial products not modified		#
	-- ### ------------------------------------------------------ ###

S00MUL0_SE <=   PP00MUL_SE (63 downto 0) xor PP01MUL_SE (63 downto 0) xor
                PP02MUL_SE (63 downto 0) ;
S01MUL0_SE <=   PP04MUL_SE (63 downto 0) xor PP05MUL_SE (63 downto 0) xor
                PP06MUL_SE (63 downto 0) ;
S02MUL0_SE <=   PP08MUL_SE (63 downto 0) xor PP09MUL_SE (63 downto 0) xor
                PP10MUL_SE (63 downto 0) ;
S03MUL0_SE <=   PP12MUL_SE (63 downto 0) xor PP13MUL_SE (63 downto 0) xor
                PP14MUL_SE (63 downto 0) ;
S04MUL0_SE <=   PP16MUL_SE (63 downto 0) xor PP17MUL_SE (63 downto 0) xor
                PP18MUL_SE (63 downto 0) ;
S05MUL0_SE <=   PP20MUL_SE (63 downto 0) xor PP21MUL_SE (63 downto 0) xor
                PP22MUL_SE (63 downto 0) ;
S06MUL0_SE <=   PP24MUL_SE (63 downto 0) xor PP25MUL_SE (63 downto 0) xor
                PP26MUL_SE (63 downto 0) ;
S07MUL0_SE <=   PP28MUL_SE (63 downto 0) xor PP29MUL_SE (63 downto 0) xor
                PP30MUL_SE (63 downto 0) ;

C00MUL0_SE <= ((PP00MUL_SE (62 downto 0) and PP01MUL_SE (62 downto 0)) or
               (PP00MUL_SE (62 downto 0) and PP02MUL_SE (62 downto 0)) or
               (PP01MUL_SE (62 downto 0) and PP02MUL_SE (62 downto 0))) & '0';

C01MUL0_SE <= ((PP04MUL_SE (62 downto 0) and PP05MUL_SE (62 downto 0)) or
               (PP04MUL_SE (62 downto 0) and PP06MUL_SE (62 downto 0)) or
               (PP05MUL_SE (62 downto 0) and PP06MUL_SE (62 downto 0))) & '0';

C02MUL0_SE <= ((PP08MUL_SE (62 downto 0) and PP09MUL_SE (62 downto 0)) or
               (PP08MUL_SE (62 downto 0) and PP10MUL_SE (62 downto 0)) or
               (PP09MUL_SE (62 downto 0) and PP10MUL_SE (62 downto 0))) & '0';

C03MUL0_SE <= ((PP12MUL_SE (62 downto 0) and PP13MUL_SE (62 downto 0)) or
               (PP12MUL_SE (62 downto 0) and PP14MUL_SE (62 downto 0)) or
               (PP13MUL_SE (62 downto 0) and PP14MUL_SE (62 downto 0))) & '0';

C04MUL0_SE <= ((PP16MUL_SE (62 downto 0) and PP17MUL_SE (62 downto 0)) or
               (PP16MUL_SE (62 downto 0) and PP18MUL_SE (62 downto 0)) or
               (PP17MUL_SE (62 downto 0) and PP18MUL_SE (62 downto 0))) & '0';

C05MUL0_SE <= ((PP20MUL_SE (62 downto 0) and PP21MUL_SE (62 downto 0)) or
               (PP20MUL_SE (62 downto 0) and PP22MUL_SE (62 downto 0)) or
               (PP21MUL_SE (62 downto 0) and PP22MUL_SE (62 downto 0))) & '0';

C06MUL0_SE <= ((PP24MUL_SE (62 downto 0) and PP25MUL_SE (62 downto 0)) or
               (PP24MUL_SE (62 downto 0) and PP26MUL_SE (62 downto 0)) or
               (PP25MUL_SE (62 downto 0) and PP26MUL_SE (62 downto 0))) & '0';

C07MUL0_SE <= ((PP28MUL_SE (62 downto 0) and PP29MUL_SE (62 downto 0)) or
               (PP28MUL_SE (62 downto 0) and PP30MUL_SE (62 downto 0)) or
               (PP29MUL_SE (62 downto 0) and PP30MUL_SE (62 downto 0))) & '0';

	-- ### ------------------------------------------------------ ###
	-- #   multiply - first cycle (Execute stage)			#
	-- #								#
	-- #     - carry save adders - second layer			#
	-- #       24           partial products reduced to 16		#
	-- #        2 extra     partial products not modified		#
	-- ### ------------------------------------------------------ ###

S00MUL1_SE <=   S00MUL0_SE (63 downto 0) xor C00MUL0_SE (63 downto 0) xor
                PP03MUL_SE (63 downto 0) ;
S01MUL1_SE <=   S01MUL0_SE (63 downto 0) xor C01MUL0_SE (63 downto 0) xor
                PP07MUL_SE (63 downto 0) ;
S02MUL1_SE <=   S02MUL0_SE (63 downto 0) xor C02MUL0_SE (63 downto 0) xor
                PP11MUL_SE (63 downto 0) ;
S03MUL1_SE <=   S03MUL0_SE (63 downto 0) xor C03MUL0_SE (63 downto 0) xor
                PP15MUL_SE (63 downto 0) ;
S04MUL1_SE <=   S04MUL0_SE (63 downto 0) xor C04MUL0_SE (63 downto 0) xor
                PP19MUL_SE (63 downto 0) ;
S05MUL1_SE <=   S05MUL0_SE (63 downto 0) xor C05MUL0_SE (63 downto 0) xor
                PP23MUL_SE (63 downto 0) ;
S06MUL1_SE <=   S06MUL0_SE (63 downto 0) xor C06MUL0_SE (63 downto 0) xor
                PP27MUL_SE (63 downto 0) ;
S07MUL1_SE <=   S07MUL0_SE (63 downto 0) xor C07MUL0_SE (63 downto 0) xor
                PP31MUL_SE (63 downto 0) ;

C00MUL1_SE <= ((S00MUL0_SE (62 downto 0) and C00MUL0_SE (62 downto 0)) or
               (S00MUL0_SE (62 downto 0) and PP03MUL_SE (62 downto 0)) or
               (C00MUL0_SE (62 downto 0) and PP03MUL_SE (62 downto 0))) & '0';

C01MUL1_SE <= ((S01MUL0_SE (62 downto 0) and C01MUL0_SE (62 downto 0)) or
               (S01MUL0_SE (62 downto 0) and PP07MUL_SE (62 downto 0)) or
               (C01MUL0_SE (62 downto 0) and PP07MUL_SE (62 downto 0))) & '0';

C02MUL1_SE <= ((S02MUL0_SE (62 downto 0) and C02MUL0_SE (62 downto 0)) or
               (S02MUL0_SE (62 downto 0) and PP11MUL_SE (62 downto 0)) or
               (C02MUL0_SE (62 downto 0) and PP11MUL_SE (62 downto 0))) & '0';

C03MUL1_SE <= ((S03MUL0_SE (62 downto 0) and C03MUL0_SE (62 downto 0)) or
               (S03MUL0_SE (62 downto 0) and PP15MUL_SE (62 downto 0)) or
               (C03MUL0_SE (62 downto 0) and PP15MUL_SE (62 downto 0))) & '0';

C04MUL1_SE <= ((S04MUL0_SE (62 downto 0) and C04MUL0_SE (62 downto 0)) or
               (S04MUL0_SE (62 downto 0) and PP19MUL_SE (62 downto 0)) or
               (C04MUL0_SE (62 downto 0) and PP19MUL_SE (62 downto 0))) & '0';

C05MUL1_SE <= ((S05MUL0_SE (62 downto 0) and C05MUL0_SE (62 downto 0)) or
               (S05MUL0_SE (62 downto 0) and PP23MUL_SE (62 downto 0)) or
               (C05MUL0_SE (62 downto 0) and PP23MUL_SE (62 downto 0))) & '0';

C06MUL1_SE <= ((S06MUL0_SE (62 downto 0) and C06MUL0_SE (62 downto 0)) or
               (S06MUL0_SE (62 downto 0) and PP27MUL_SE (62 downto 0)) or
               (C06MUL0_SE (62 downto 0) and PP27MUL_SE (62 downto 0))) & '0';

C07MUL1_SE <= ((S07MUL0_SE (62 downto 0) and C07MUL0_SE (62 downto 0)) or
               (S07MUL0_SE (62 downto 0) and PP31MUL_SE (62 downto 0)) or
               (C07MUL0_SE (62 downto 0) and PP31MUL_SE (62 downto 0))) & '0';

	-- ### ------------------------------------------------------ ###
	-- #   multiply - first cycle (Execute stage)			#
	-- #								#
	-- #     - carry save adders - third layer			#
	-- #       16 + 1 extra partial products reduced to 12		#
	-- #        1     extra partial product  not modified		#
	-- ### ------------------------------------------------------ ###

S00MUL2_SE <=   S00MUL1_SE (63 downto 0) xor C00MUL1_SE (63 downto 0) xor
                PPXXMUL_SE (63 downto 0) ;
S01MUL2_SE <=   S01MUL1_SE (63 downto 0) xor C01MUL1_SE (63 downto 0) xor
                S02MUL1_SE (63 downto 0) ;
S02MUL2_SE <=   S03MUL1_SE (63 downto 0) xor C03MUL1_SE (63 downto 0) xor
                C02MUL1_SE (63 downto 0) ;

S03MUL2_SE <=   S04MUL1_SE (63 downto 0) xor C04MUL1_SE (63 downto 0) xor
                S05MUL1_SE (63 downto 0) ;
S04MUL2_SE <=   S06MUL1_SE (63 downto 0) xor C06MUL1_SE (63 downto 0) xor
                S07MUL1_SE (63 downto 0) ;

C00MUL2_SE <= ((S00MUL1_SE (62 downto 0) and C00MUL1_SE (62 downto 0)) or
               (S00MUL1_SE (62 downto 0) and PPXXMUL_SE (62 downto 0)) or
               (C00MUL1_SE (62 downto 0) and PPXXMUL_SE (62 downto 0))) & '0';

C01MUL2_SE <= ((S01MUL1_SE (62 downto 0) and C01MUL1_SE (62 downto 0)) or
               (S01MUL1_SE (62 downto 0) and S02MUL1_SE (62 downto 0)) or
               (C01MUL1_SE (62 downto 0) and S02MUL1_SE (62 downto 0))) & '0';

C02MUL2_SE <= ((S03MUL1_SE (62 downto 0) and C03MUL1_SE (62 downto 0)) or
               (S03MUL1_SE (62 downto 0) and C02MUL1_SE (62 downto 0)) or
               (C03MUL1_SE (62 downto 0) and C02MUL1_SE (62 downto 0))) & '0';

C03MUL2_SE <= ((S04MUL1_SE (62 downto 0) and C04MUL1_SE (62 downto 0)) or
               (S04MUL1_SE (62 downto 0) and S05MUL1_SE (62 downto 0)) or
               (C04MUL1_SE (62 downto 0) and S05MUL1_SE (62 downto 0))) & '0';

C04MUL2_SE <= ((S06MUL1_SE (62 downto 0) and C06MUL1_SE (62 downto 0)) or
               (S06MUL1_SE (62 downto 0) and S07MUL1_SE (62 downto 0)) or
               (C06MUL1_SE (62 downto 0) and S07MUL1_SE (62 downto 0))) & '0';

	-- ### ------------------------------------------------------ ###
	-- #   multiply - second cycle (Memory Access stage)		#
	-- #     - operands						#
	-- ### ------------------------------------------------------ ###

ZMOPR_SM   <= HI_RW   & LO_RW ;
ZMUL_SM    <= ZMOPR_SM        when (I_MULT_SM = '0') else X"00000000_00000000";
PPZZMUL_SM <= ZMUL_SM         when (ZMINV_RE  = '0') else not ZMUL_SM         ;

	-- ### ------------------------------------------------------ ###
	-- #   multiply - second cycle (Memory Access stage)		#
	-- #     - partial products					#
	-- ### ------------------------------------------------------ ###

C05MUL1_SM <=   C05MUL1_RE ;
C07MUL1_SM <=   C07MUL1_RE ;

S00MUL2_SM <=   S00MUL2_RE ;
S01MUL2_SM <=   S01MUL2_RE ;
S02MUL2_SM <=   S02MUL2_RE ;

S03MUL2_SM <=   S03MUL2_RE ;
S04MUL2_SM <=   S04MUL2_RE ;

C00MUL2_SM <=   C00MUL2_RE ;
C01MUL2_SM <=   C01MUL2_RE ;
C02MUL2_SM <=   C02MUL2_RE ;

C03MUL2_SM <=   C03MUL2_RE ;
C04MUL2_SM <=   C04MUL2_RE ;

	-- ### ------------------------------------------------------ ###
	-- #   multiply - second cycle (Memory Access stage)		#
	-- #								#
	-- #     - carry save adders - fourth layer			#
	-- #       12           partial products reduced to 8		#
	-- #        1 extra     partial product  not modified		#
	-- ### ------------------------------------------------------ ###

S00MUL3_SM <=   S00MUL2_SM (63 downto 0) xor C00MUL2_SM (63 downto 0) xor
                S01MUL2_SM (63 downto 0) ;
S01MUL3_SM <=   S02MUL2_SM (63 downto 0) xor C02MUL2_SM (63 downto 0) xor
                C01MUL2_SM (63 downto 0) ;
S02MUL3_SM <=   S03MUL2_SM (63 downto 0) xor C03MUL2_SM (63 downto 0) xor
                C05MUL1_SM (63 downto 0) ;
S03MUL3_SM <=   S04MUL2_SM (63 downto 0) xor C04MUL2_SM (63 downto 0) xor
                C07MUL1_SM (63 downto 0) ;

C00MUL3_SM <= ((S00MUL2_SM (62 downto 0) and C00MUL2_SM (62 downto 0)) or
               (S00MUL2_SM (62 downto 0) and S01MUL2_SM (62 downto 0)) or
               (C00MUL2_SM (62 downto 0) and S01MUL2_SM (62 downto 0))) & '0';

C01MUL3_SM <= ((S02MUL2_SM (62 downto 0) and C02MUL2_SM (62 downto 0)) or
               (S02MUL2_SM (62 downto 0) and C01MUL2_SM (62 downto 0)) or
               (C02MUL2_SM (62 downto 0) and C01MUL2_SM (62 downto 0))) & '0';

C02MUL3_SM <= ((S03MUL2_SM (62 downto 0) and C03MUL2_SM (62 downto 0)) or
               (S03MUL2_SM (62 downto 0) and C05MUL1_SM (62 downto 0)) or
               (C03MUL2_SM (62 downto 0) and C05MUL1_SM (62 downto 0))) & '0';

C03MUL3_SM <= ((S04MUL2_SM (62 downto 0) and C04MUL2_SM (62 downto 0)) or
               (S04MUL2_SM (62 downto 0) and C07MUL1_SM (62 downto 0)) or
               (C04MUL2_SM (62 downto 0) and C07MUL1_SM (62 downto 0))) & '0';

	-- ### ------------------------------------------------------ ###
	-- #   multiply - second cycle (Memory Access stage)		#
	-- #								#
	-- #     - carry save adders - fifth layer			#
	-- #        8 + 1 extra partial products reduced to 6		#
	-- ### ------------------------------------------------------ ###

S00MUL4_SM <=   S00MUL3_SM (63 downto 0) xor C00MUL3_SM (63 downto 0) xor
                PPZZMUL_SM (63 downto 0) ;

S01MUL4_SM <=   S01MUL3_SM (63 downto 0) xor C01MUL3_SM (63 downto 0) xor
                S02MUL3_SM (63 downto 0) ;
S02MUL4_SM <=   S03MUL3_SM (63 downto 0) xor C03MUL3_SM (63 downto 0) xor
                C02MUL3_SM (63 downto 0) ;

C00MUL4_SM <= ((S00MUL3_SM (62 downto 0) and C00MUL3_SM (62 downto 0)) or
               (S00MUL3_SM (62 downto 0) and PPZZMUL_SM (62 downto 0)) or
               (C00MUL3_SM (62 downto 0) and PPZZMUL_SM (62 downto 0))) & '0';

C01MUL4_SM <= ((S01MUL3_SM (62 downto 0) and C01MUL3_SM (62 downto 0)) or
               (S01MUL3_SM (62 downto 0) and S02MUL3_SM (62 downto 0)) or
               (C01MUL3_SM (62 downto 0) and S02MUL3_SM (62 downto 0))) & '0';

C02MUL4_SM <= ((S03MUL3_SM (62 downto 0) and C03MUL3_SM (62 downto 0)) or
               (S03MUL3_SM (62 downto 0) and C02MUL3_SM (62 downto 0)) or
               (C03MUL3_SM (62 downto 0) and C02MUL3_SM (62 downto 0))) & '0';

	-- ### ------------------------------------------------------ ###
	-- #   multiply - second cycle (Memory Access stage)		#
	-- #								#
	-- #     - carry save adders - sixth layer			#
	-- #        6           partial products reduced to 4		#
	-- ### ------------------------------------------------------ ###

S00MUL5_SM <=   S00MUL4_SM (63 downto 0) xor C00MUL4_SM (63 downto 0) xor
                S01MUL4_SM (63 downto 0) ;
S01MUL5_SM <=   S02MUL4_SM (63 downto 0) xor C02MUL4_SM (63 downto 0) xor
                C01MUL4_SM (63 downto 0) ;

C00MUL5_SM <= ((S00MUL4_SM (62 downto 0) and C00MUL4_SM (62 downto 0)) or
               (S00MUL4_SM (62 downto 0) and S01MUL4_SM (62 downto 0)) or
               (C00MUL4_SM (62 downto 0) and S01MUL4_SM (62 downto 0))) & '0';

C01MUL5_SM <= ((S02MUL4_SM (62 downto 0) and C02MUL4_SM (62 downto 0)) or
               (S02MUL4_SM (62 downto 0) and C01MUL4_SM (62 downto 0)) or
               (C02MUL4_SM (62 downto 0) and C01MUL4_SM (62 downto 0))) & '0';

	-- ### ------------------------------------------------------ ###
	-- #   multiply - second cycle (Memory Access stage)		#
	-- #								#
	-- #     - carry save adders - seventh layer			#
	-- #        4           partial products reduced to 3		#
	-- ### ------------------------------------------------------ ###

S00MUL6_SM <=   S00MUL5_SM (63 downto 0) xor C00MUL5_SM (63 downto 0) xor
                S01MUL5_SM (63 downto 0) ;

C00MUL6_SM <= ((S00MUL5_SM (62 downto 0) and C00MUL5_SM (62 downto 0)) or
               (S00MUL5_SM (62 downto 0) and S01MUL5_SM (62 downto 0)) or
               (C00MUL5_SM (62 downto 0) and S01MUL5_SM (62 downto 0))) & '0';

	-- ### ------------------------------------------------------ ###
	-- #   multiply - second cycle (Memory Access stage)		#
	-- #								#
	-- #     - carry save adders - eighth layer			#
	-- #        3           partial products reduced to 2		#
	-- ### ------------------------------------------------------ ###

S00MUL7_SM <=   S00MUL6_SM (63 downto 0) xor C00MUL6_SM (63 downto 0) xor
                C01MUL5_SM (63 downto 0) ;

C00MUL7_SM <= ((S00MUL6_SM (62 downto 0) and C00MUL6_SM (62 downto 0)) or
               (S00MUL6_SM (62 downto 0) and C01MUL5_SM (62 downto 0)) or
               (C00MUL6_SM (62 downto 0) and C01MUL5_SM (62 downto 0))) & '0';

	-- ### ------------------------------------------------------ ###
	-- #   multiply - third cycle (Write Back stage)		#
	-- #     - partial products					#
	-- ### ------------------------------------------------------ ###

S00MUL7_SW <= S00MUL7_RM ;
C00MUL7_SW <= C00MUL7_RM ;

	-- ### ------------------------------------------------------ ###
	-- #   multiply - third cycle (Write Back stage)		#
	-- #     - final adder						#
	-- #     - propagate-generate					#
	-- ### ------------------------------------------------------ ###

MULPR0_SW  <= S00MUL7_SW or  C00MUL7_SW ;
MULGN0_SW  <= S00MUL7_SW and C00MUL7_SW ;

	-- ### ------------------------------------------------------ ###
	-- #   multiply - third cycle (Write Back stage)		#
	-- #     - final adder						#
	-- #     - 6 layers of propagate-generate			#
	-- ### ------------------------------------------------------ ###

MULPR1_SW  <= MULPR0_SW and  (MULPR0_SW (62 downto 0) &  '1'        )     ;
MULPR2_SW  <= MULPR1_SW and  (MULPR1_SW (61 downto 0) & B"11"       )     ;
MULPR3_SW  <= MULPR2_SW and  (MULPR2_SW (59 downto 0) & X"f"        )     ;
MULPR4_SW  <= MULPR3_SW and  (MULPR3_SW (55 downto 0) & X"ff"       )     ;
MULPR5_SW  <= MULPR4_SW and  (MULPR4_SW (47 downto 0) & X"ffff"     )     ;
MULPR6_SW  <= MULPR5_SW and  (MULPR5_SW (31 downto 0) & X"ffff_ffff")     ;

MULGN1_SW  <= MULGN0_SW or  ( MULPR0_SW                               and
                             (MULGN0_SW (62 downto 0) &  '0'        )    );
MULGN2_SW  <= MULGN1_SW or  ( MULPR1_SW                               and
                             (MULGN1_SW (61 downto 0) & B"00"       )    );
MULGN3_SW  <= MULGN2_SW or  ( MULPR2_SW                               and
                             (MULGN2_SW (59 downto 0) & X"0"        )    );
MULGN4_SW  <= MULGN3_SW or  ( MULPR3_SW                               and
                             (MULGN3_SW (55 downto 0) & X"00"       )    );
MULGN5_SW  <= MULGN4_SW or  ( MULPR4_SW                               and
                             (MULGN4_SW (47 downto 0) & X"0000"     )    );
MULGN6_SW  <= MULGN5_SW or  ( MULPR5_SW                               and
                             (MULGN5_SW (31 downto 0) & X"0000_0000")    );

	-- ### ------------------------------------------------------ ###
	-- #   multiply - third cycle (Write Back stage)		#
	-- #     - final adder						#
	-- #     - sum and carry					#
	-- ### ------------------------------------------------------ ###

MULCRY_SW  <= MULGN6_SW                              ;
MULCYI_SW  <= MULCRY_SW (62 downto  0) & '0'         ;
MULSUM_SW  <= MULCYI_SW xor S00MUL7_SW xor C00MUL7_SW;

	-- ### ------------------------------------------------------ ###
	-- #   multiply - third cycle (Write Back stage)		#
	-- #     - final inverter					#
	-- ### ------------------------------------------------------ ###

RMUL_SW    <= MULSUM_SW when (ZMINV_RM = '0') else not MULSUM_SW;

	-- ### ------------------------------------------------------ ###
	-- ### ------------------------------------------------------ ###

MICBEG_SE  <= I_CISC_SE and     MICEND_RE;
MICCOPY_SE <= I_CISC_SE and not MICLST_RE;

	-- ### ------------------------------------------------------ ###
	-- ### ------------------------------------------------------ ###

XDIV_SE    <=  SOPER_SE ;
YDIV_SE    <=  TOPER_SE ;

	-- ### ------------------------------------------------------ ###
	-- ### ------------------------------------------------------ ###

NEXTMIC_SE <=
  I_MIC_SE  when (MICBEG_SE = '1'                              ) else
  div_cnt   when (MIC_RE    = div_clz                          ) else
  div_shl   when (MIC_RE    = div_cnt  and DIVSCNT_SE (5) = '0') else
  div_lst   when (MIC_RE    = div_cnt  and DIVSCNT_SE (5) = '1') else
  div_dif   when (MIC_RE    = div_shl                          ) else
  div_dif   when (MIC_RE    = div_dif  and DIVSCNZ_SE     = '0') else
  div_lst   when (MIC_RE    = div_dif  and DIVSCNZ_SE     = '1') else
  exe_end   when (MIC_RE    = div_lst                          ) else
  exe_end   ;

	-- ### ------------------------------------------------------ ###
	-- ### ------------------------------------------------------ ###

MICEND_SE  <= '1' when (NEXTMIC_SE = exe_end) else '0';
MICLST_SE  <= '1' when (NEXTMIC_SE = div_lst) else '0';

	-- ### ------------------------------------------------------ ###
	-- ### ------------------------------------------------------ ###

DIVRX_SE   <= XDIV_SE      when (MICBEG_SE = '1'                      ) else
              DIVX_RE      ;

DIVQY_SE   <= YDIV_SE      when (MICBEG_SE = '1'                        ) else
              DIVQ_RE      ;

DIVX_SE    <= DIVXEFF_SE   when (MICBEG_SE = '1'                        ) else
              DIVX_RE      when (MIC_RE    = div_clz                    ) else
              DIVX_RE      when (MIC_RE    = div_cnt                    ) else
              DIVX_RE      when (MIC_RE    = div_shl                    ) else
              DIVX_RE      when (MIC_RE    = div_dif and DIVLEU_SE = '0') else
              DIVDIF_SE    when (MIC_RE    = div_dif and DIVLEU_SE = '1') else
              DIVREFF_SE   when (MIC_RE    = div_lst                    ) else
              DIVX_RE      ;

DIVY_SE    <= DIVYEFF_SE   when (MICBEG_SE = '1'                        ) else
              DIVY_RE      when (MIC_RE    = div_clz                    ) else
              DIVY_RE      when (MIC_RE    = div_cnt                    ) else
              DIVYSHL_SE   when (MIC_RE    = div_shl                    ) else
              DIVYSHR_SE   when (MIC_RE    = div_dif                    ) else
              DIVY_RE      ;

DIVQ_SE    <= X"0000_0000" when (MICBEG_SE = '1'                        ) else
              DIVQ_RE      when (MIC_RE    = div_clz                    ) else
              DIVQ_RE      when (MIC_RE    = div_cnt                    ) else
              DIVQ_RE      when (MIC_RE    = div_shl                    ) else
              DIVQSHL_SE   when (MIC_RE    = div_dif                    ) else
              DIVQEFF_SE   when (MIC_RE    = div_lst                    ) else
              DIVQ_RE      ;

DIVXCLZ_SE <= DIVXCLZ_RE   when (MICBEG_SE = '1'                        ) else
              DIVXCZ_SE    when (MIC_RE    = div_clz                    ) else
              B"000001"    when (MIC_RE    = div_cnt                    ) else
              DIVXCLZ_RE   ;

DIVYCLZ_SE <= DIVYCLZ_RE   when (MICBEG_SE = '1'                        ) else
              DIVYCZ_SE    when (MIC_RE    = div_clz                    ) else
              DIVSCNT_SE   when (MIC_RE    = div_cnt                    ) else
              DIVSCNT_SE   when (MIC_RE    = div_dif                    ) else
              DIVYCLZ_RE   ;

	-- ### ------------------------------------------------------ ###
	-- ### ------------------------------------------------------ ###

DIVRPR0_SE <= not DIVRX_SE;

	-- ### ------------------------------------------------------ ###
	-- ### ------------------------------------------------------ ###

DIVRPR1_SE <= DIVRPR0_SE and (DIVRPR0_SE (30 downto 0) &  '1'   ) ;
DIVRPR2_SE <= DIVRPR1_SE and (DIVRPR1_SE (29 downto 0) & B"11"  ) ;
DIVRPR3_SE <= DIVRPR2_SE and (DIVRPR2_SE (27 downto 0) & B"1111") ;
DIVRPR4_SE <= DIVRPR3_SE and (DIVRPR3_SE (23 downto 0) & X"ff"  ) ;
DIVRPR5_SE <= DIVRPR4_SE and (DIVRPR4_SE (15 downto 0) & X"ffff") ;

	-- ### ------------------------------------------------------ ###
	-- ### ------------------------------------------------------ ###

DIVRCRY_SE <= DIVRPR5_SE ;

DIVRCYI_SE <=                  DIVRCRY_SE (30 downto  0) & '1';
DIVRNEG_SE <= not DIVRX_SE xor DIVRCYI_SE (31 downto  0)      ;

	-- ### ------------------------------------------------------ ###
	-- ### ------------------------------------------------------ ###

DIVQPR0_SE <= not DIVQY_SE;

	-- ### ------------------------------------------------------ ###
	-- ### ------------------------------------------------------ ###

DIVQPR1_SE <= DIVQPR0_SE and (DIVQPR0_SE (30 downto 0) &  '1'   ) ;
DIVQPR2_SE <= DIVQPR1_SE and (DIVQPR1_SE (29 downto 0) & B"11"  ) ;
DIVQPR3_SE <= DIVQPR2_SE and (DIVQPR2_SE (27 downto 0) & B"1111") ;
DIVQPR4_SE <= DIVQPR3_SE and (DIVQPR3_SE (23 downto 0) & X"ff"  ) ;
DIVQPR5_SE <= DIVQPR4_SE and (DIVQPR4_SE (15 downto 0) & X"ffff") ;

	-- ### ------------------------------------------------------ ###
	-- ### ------------------------------------------------------ ###

DIVQCRY_SE <= DIVQPR5_SE ;

DIVQCYI_SE <=                  DIVQCRY_SE (30 downto 0) & '1';
DIVQNEG_SE <= not DIVQY_SE xor DIVQCYI_SE (31 downto 0)      ;

	-- ### ------------------------------------------------------ ###
	-- ### ------------------------------------------------------ ###

DIVXSGN_SE <= XDIV_SE (31)                 ;
DIVYSGN_SE <=                  YDIV_SE (31);
DIVQSGN_SE <= XDIV_SE (31) xor YDIV_SE (31);

	-- ### ------------------------------------------------------ ###
	-- ### ------------------------------------------------------ ###

DIVXEFF_SE <= DIVRNEG_SE when (I_OSGND_SE = '1' and DIVXSGN_SE = '1') else
              XDIV_SE    ;
DIVYEFF_SE <= DIVQNEG_SE when (I_OSGND_SE = '1' and DIVYSGN_SE = '1') else
              YDIV_SE    ;

DIVREFF_SE <= DIVRNEG_SE when (I_OSGND_SE = '1' and DIVXSGN_SE = '1') else
              DIVRX_SE   ;
DIVQEFF_SE <= DIVQNEG_SE when (I_OSGND_SE = '1' and DIVQSGN_SE = '1') else
              DIVQ_RE    ;

	-- ### ------------------------------------------------------ ###
	-- #   increment and mask					#
	-- ### ------------------------------------------------------ ###

DIVYZP1_SE <= not DIVY_RE    and ( '1'    & not DIVY_RE    (31 downto  1)) ;
DIVYZP2_SE <=     DIVYZP1_SE and (B"11"   &     DIVYZP1_SE (31 downto  2)) ;
DIVYZP3_SE <=     DIVYZP2_SE and (B"1111" &     DIVYZP2_SE (31 downto  4)) ;
DIVYZP4_SE <=     DIVYZP3_SE and (X"ff"   &     DIVYZP3_SE (31 downto  8)) ;
DIVYZP5_SE <=     DIVYZP4_SE and (X"ffff" &     DIVYZP4_SE (31 downto 16)) ;

DIVYZMK_SE <=     DIVY_RE    and ( '1'    &     DIVYZP5_SE (31 downto  1)) ;

	-- ### ------------------------------------------------------ ###
	-- #   count leading						#
	-- ### ------------------------------------------------------ ###

DIVYCZ5_SE <= DIVYZP5_SE ( 0)                      ;

DIVYCZ4_SE <= DIVYZMK_SE (15) or DIVYZMK_SE (14) or
              DIVYZMK_SE (13) or DIVYZMK_SE (12) or
              DIVYZMK_SE (11) or DIVYZMK_SE (10) or
              DIVYZMK_SE ( 9) or DIVYZMK_SE ( 8) or
              DIVYZMK_SE ( 7) or DIVYZMK_SE ( 6) or
              DIVYZMK_SE ( 5) or DIVYZMK_SE ( 4) or
              DIVYZMK_SE ( 3) or DIVYZMK_SE ( 2) or
              DIVYZMK_SE ( 1) or DIVYZMK_SE ( 0)   ;

DIVYCZ3_SE <= DIVYZMK_SE (23) or DIVYZMK_SE (22) or
              DIVYZMK_SE (21) or DIVYZMK_SE (20) or
              DIVYZMK_SE (19) or DIVYZMK_SE (18) or
              DIVYZMK_SE (17) or DIVYZMK_SE (16) or
              DIVYZMK_SE ( 7) or DIVYZMK_SE ( 6) or
              DIVYZMK_SE ( 5) or DIVYZMK_SE ( 4) or
              DIVYZMK_SE ( 3) or DIVYZMK_SE ( 2) or
              DIVYZMK_SE ( 1) or DIVYZMK_SE ( 0)   ;

DIVYCZ2_SE <= DIVYZMK_SE (27) or DIVYZMK_SE (26) or
              DIVYZMK_SE (25) or DIVYZMK_SE (24) or
              DIVYZMK_SE (19) or DIVYZMK_SE (18) or
              DIVYZMK_SE (17) or DIVYZMK_SE (16) or
              DIVYZMK_SE (11) or DIVYZMK_SE (10) or
              DIVYZMK_SE ( 9) or DIVYZMK_SE ( 8) or
              DIVYZMK_SE ( 3) or DIVYZMK_SE ( 2) or
              DIVYZMK_SE ( 1) or DIVYZMK_SE ( 0)   ;

DIVYCZ1_SE <= DIVYZMK_SE (29) or DIVYZMK_SE (28) or
              DIVYZMK_SE (25) or DIVYZMK_SE (24) or
              DIVYZMK_SE (21) or DIVYZMK_SE (20) or
              DIVYZMK_SE (17) or DIVYZMK_SE (16) or
              DIVYZMK_SE (13) or DIVYZMK_SE (12) or
              DIVYZMK_SE ( 9) or DIVYZMK_SE ( 8) or
              DIVYZMK_SE ( 5) or DIVYZMK_SE ( 4) or
              DIVYZMK_SE ( 1) or DIVYZMK_SE ( 0)   ;

DIVYCZ0_SE <= DIVYZMK_SE (30) or DIVYZMK_SE (28) or
              DIVYZMK_SE (26) or DIVYZMK_SE (24) or
              DIVYZMK_SE (22) or DIVYZMK_SE (20) or
              DIVYZMK_SE (18) or DIVYZMK_SE (16) or
              DIVYZMK_SE (14) or DIVYZMK_SE (12) or
              DIVYZMK_SE (10) or DIVYZMK_SE ( 8) or
              DIVYZMK_SE ( 6) or DIVYZMK_SE ( 4) or
              DIVYZMK_SE ( 2) or DIVYZMK_SE ( 0)   ;

	-- ### ------------------------------------------------------ ###
	-- #   outputs :						#
	-- ### ------------------------------------------------------ ###

DIVYCZ_SE  <= DIVYCZ5_SE & DIVYCZ4_SE & DIVYCZ3_SE &
              DIVYCZ2_SE & DIVYCZ1_SE & DIVYCZ0_SE  ;

	-- ### ------------------------------------------------------ ###
	-- #   increment and mask					#
	-- ### ------------------------------------------------------ ###

DIVXZP1_SE <= not DIVX_RE    and ( '1'    & not DIVX_RE    (31 downto  1)) ;
DIVXZP2_SE <=     DIVXZP1_SE and (B"11"   &     DIVXZP1_SE (31 downto  2)) ;
DIVXZP3_SE <=     DIVXZP2_SE and (B"1111" &     DIVXZP2_SE (31 downto  4)) ;
DIVXZP4_SE <=     DIVXZP3_SE and (X"ff"   &     DIVXZP3_SE (31 downto  8)) ;
DIVXZP5_SE <=     DIVXZP4_SE and (X"ffff" &     DIVXZP4_SE (31 downto 16)) ;

DIVXZMK_SE <=     DIVX_RE    and ( '1'    &     DIVXZP5_SE (31 downto  1)) ;

	-- ### ------------------------------------------------------ ###
	-- #   count leading						#
	-- ### ------------------------------------------------------ ###

DIVXCZ5_SE <= DIVXZP5_SE ( 0)                      ;

DIVXCZ4_SE <= DIVXZMK_SE (15) or DIVXZMK_SE (14) or
              DIVXZMK_SE (13) or DIVXZMK_SE (12) or
              DIVXZMK_SE (11) or DIVXZMK_SE (10) or
              DIVXZMK_SE ( 9) or DIVXZMK_SE ( 8) or
              DIVXZMK_SE ( 7) or DIVXZMK_SE ( 6) or
              DIVXZMK_SE ( 5) or DIVXZMK_SE ( 4) or
              DIVXZMK_SE ( 3) or DIVXZMK_SE ( 2) or
              DIVXZMK_SE ( 1) or DIVXZMK_SE ( 0)   ;

DIVXCZ3_SE <= DIVXZMK_SE (23) or DIVXZMK_SE (22) or
              DIVXZMK_SE (21) or DIVXZMK_SE (20) or
              DIVXZMK_SE (19) or DIVXZMK_SE (18) or
              DIVXZMK_SE (17) or DIVXZMK_SE (16) or
              DIVXZMK_SE ( 7) or DIVXZMK_SE ( 6) or
              DIVXZMK_SE ( 5) or DIVXZMK_SE ( 4) or
              DIVXZMK_SE ( 3) or DIVXZMK_SE ( 2) or
              DIVXZMK_SE ( 1) or DIVXZMK_SE ( 0)   ;

DIVXCZ2_SE <= DIVXZMK_SE (27) or DIVXZMK_SE (26) or
              DIVXZMK_SE (25) or DIVXZMK_SE (24) or
              DIVXZMK_SE (19) or DIVXZMK_SE (18) or
              DIVXZMK_SE (17) or DIVXZMK_SE (16) or
              DIVXZMK_SE (11) or DIVXZMK_SE (10) or
              DIVXZMK_SE ( 9) or DIVXZMK_SE ( 8) or
              DIVXZMK_SE ( 3) or DIVXZMK_SE ( 2) or
              DIVXZMK_SE ( 1) or DIVXZMK_SE ( 0)   ;

DIVXCZ1_SE <= DIVXZMK_SE (29) or DIVXZMK_SE (28) or
              DIVXZMK_SE (25) or DIVXZMK_SE (24) or
              DIVXZMK_SE (21) or DIVXZMK_SE (20) or
              DIVXZMK_SE (17) or DIVXZMK_SE (16) or
              DIVXZMK_SE (13) or DIVXZMK_SE (12) or
              DIVXZMK_SE ( 9) or DIVXZMK_SE ( 8) or
              DIVXZMK_SE ( 5) or DIVXZMK_SE ( 4) or
              DIVXZMK_SE ( 1) or DIVXZMK_SE ( 0)   ;

DIVXCZ0_SE <= DIVXZMK_SE (30) or DIVXZMK_SE (28) or
              DIVXZMK_SE (26) or DIVXZMK_SE (24) or
              DIVXZMK_SE (22) or DIVXZMK_SE (20) or
              DIVXZMK_SE (18) or DIVXZMK_SE (16) or
              DIVXZMK_SE (14) or DIVXZMK_SE (12) or
              DIVXZMK_SE (10) or DIVXZMK_SE ( 8) or
              DIVXZMK_SE ( 6) or DIVXZMK_SE ( 4) or
              DIVXZMK_SE ( 2) or DIVXZMK_SE ( 0)   ;

	-- ### ------------------------------------------------------ ###
	-- ### ------------------------------------------------------ ###

DIVXCZ_SE  <= DIVXCZ5_SE & DIVXCZ4_SE & DIVXCZ3_SE &
              DIVXCZ2_SE & DIVXCZ1_SE & DIVXCZ0_SE  ;

	-- ### ------------------------------------------------------ ###
	-- ### ------------------------------------------------------ ###

DIVSCYI_SE <=                     DIVSCRY_SE (4 downto 0) & '1';

DIVSCRY_SE <= (not DIVXCLZ_RE and DIVYCLZ_RE) or
              (not DIVXCLZ_RE and DIVSCYI_SE) or
              (    DIVYCLZ_RE and DIVSCYI_SE)               ;
DIVSCNT_SE <=  not DIVXCLZ_RE xor DIVYCLZ_RE  xor DIVSCYI_SE;

DIVSCNZ_SE <= '1' when (DIVYCLZ_RE = B"00_0000") else '0';

	-- ### ------------------------------------------------------ ###
	-- ### ------------------------------------------------------ ###

DIVYSHR_SE  <= '0' & DIVY_RE    (31 downto 1);
DIVYSHA_SE  <=       DIVYCLZ_RE ( 4 downto 0);

with DIVYSHA_SE select
DIVYSHL_SE  <=
  DIVY_RE  (31 downto  0)                               when B"00000",
  DIVY_RE  (30 downto  0)               & "0"           when B"00001",
  DIVY_RE  (29 downto  0)               & "00"          when B"00010",
  DIVY_RE  (28 downto  0)               & "000"         when B"00011",
  DIVY_RE  (27 downto  0) & X"0"                        when B"00100",
  DIVY_RE  (26 downto  0) & X"0"        & "0"           when B"00101",
  DIVY_RE  (25 downto  0) & X"0"        & "00"          when B"00110",
  DIVY_RE  (24 downto  0) & X"0"        & "000"         when B"00111",
  DIVY_RE  (23 downto  0) & X"00"                       when B"01000",
  DIVY_RE  (22 downto  0) & X"00"       & "0"           when B"01001",
  DIVY_RE  (21 downto  0) & X"00"       & "00"          when B"01010",
  DIVY_RE  (20 downto  0) & X"00"       & "000"         when B"01011",
  DIVY_RE  (19 downto  0) & X"000"                      when B"01100",
  DIVY_RE  (18 downto  0) & X"000"      & "0"           when B"01101",
  DIVY_RE  (17 downto  0) & X"000"      & "00"          when B"01110",
  DIVY_RE  (16 downto  0) & X"000"      & "000"         when B"01111",
  DIVY_RE  (15 downto  0) & X"0000"                     when B"10000",
  DIVY_RE  (14 downto  0) & X"0000"     & "0"           when B"10001",
  DIVY_RE  (13 downto  0) & X"0000"     & "00"          when B"10010",
  DIVY_RE  (12 downto  0) & X"0000"     & "000"         when B"10011",
  DIVY_RE  (11 downto  0) & X"00000"                    when B"10100",
  DIVY_RE  (10 downto  0) & X"00000"    & "0"           when B"10101",
  DIVY_RE  (9  downto  0) & X"00000"    & "00"          when B"10110",
  DIVY_RE  (8  downto  0) & X"00000"    & "000"         when B"10111",
  DIVY_RE  (7  downto  0) & X"000000"                   when B"11000",
  DIVY_RE  (6  downto  0) & X"000000"   & "0"           when B"11001",
  DIVY_RE  (5  downto  0) & X"000000"   & "00"          when B"11010",
  DIVY_RE  (4  downto  0) & X"000000"   & "000"         when B"11011",
  DIVY_RE  (3  downto  0) & X"0000000"                  when B"11100",
  DIVY_RE  (2  downto  0) & X"0000000"  & "0"           when B"11101",
  DIVY_RE  (1  downto  0) & X"0000000"  & "00"          when B"11110",
  DIVY_RE  (           0) & X"0000000"  & "000"         when B"11111",
                            X"00000000"                 when others  ;

	-- ### ------------------------------------------------------ ###
	-- ### ------------------------------------------------------ ###

DIVDPR0_SE <= DIVX_RE or  not DIVY_RE ;
DIVDGN0_SE <= DIVX_RE and not DIVY_RE ;

	-- ### ------------------------------------------------------ ###
	-- ### ------------------------------------------------------ ###

DIVDPR1_SE <=  DIVDPR0_SE and (DIVDPR0_SE (30 downto 0) &  '1'   ) ;
DIVDPR2_SE <=  DIVDPR1_SE and (DIVDPR1_SE (29 downto 0) & B"11"  ) ;
DIVDPR3_SE <=  DIVDPR2_SE and (DIVDPR2_SE (27 downto 0) & B"1111") ;
DIVDPR4_SE <=  DIVDPR3_SE and (DIVDPR3_SE (23 downto 0) & X"ff"  ) ;
DIVDPR5_SE <=  DIVDPR4_SE and (DIVDPR4_SE (15 downto 0) & X"ffff") ;

DIVDGN1_SE <=  DIVDGN0_SE or
              (DIVDPR0_SE and (DIVDGN0_SE (30 downto 0) &  '0'   ));
DIVDGN2_SE <=  DIVDGN1_SE or
              (DIVDPR1_SE and (DIVDGN1_SE (29 downto 0) & B"00"  ));
DIVDGN3_SE <=  DIVDGN2_SE or
              (DIVDPR2_SE and (DIVDGN2_SE (27 downto 0) & B"0000"));
DIVDGN4_SE <=  DIVDGN3_SE or
              (DIVDPR3_SE and (DIVDGN3_SE (23 downto 0) & X"00"  ));
DIVDGN5_SE <=  DIVDGN4_SE or
              (DIVDPR4_SE and (DIVDGN4_SE (15 downto 0) & X"0000"));

	-- ### ------------------------------------------------------ ###
	-- #   carries							#
	-- ### ------------------------------------------------------ ###

DIVDCRY_SE <= DIVDGN5_SE or DIVDPR5_SE ;

	-- ### ------------------------------------------------------ ###
	-- #   sum and output carry					#
	-- ### ------------------------------------------------------ ###

DIVDCYI_SE <=                             DIVDCRY_SE (30 downto  0) & '1';
DIVDIF_SE  <= DIVX_RE xor not DIVY_RE xor DIVDCYI_SE (31 downto  0)      ;

	-- ### ------------------------------------------------------ ###
	-- ### ------------------------------------------------------ ###

DIVLPR0_SE <= DIVX_RE xor not DIVY_RE ;
DIVLGN0_SE <= DIVX_RE and not DIVY_RE ;

	-- ### ------------------------------------------------------ ###
	-- ### ------------------------------------------------------ ###

DIVLPR1_SE <=  DIVLPR0_SE and (DIVLPR0_SE (30 downto 0) &  '1'   ) ;
DIVLPR2_SE <=  DIVLPR1_SE and (DIVLPR1_SE (29 downto 0) & B"11"  ) ;
DIVLPR3_SE <=  DIVLPR2_SE and (DIVLPR2_SE (27 downto 0) & B"1111") ;
DIVLPR4_SE <=  DIVLPR3_SE and (DIVLPR3_SE (23 downto 0) & X"ff"  ) ;
DIVLPR5_SE <=  DIVLPR4_SE and (DIVLPR4_SE (15 downto 0) & X"ffff") ;

DIVLGN1_SE <=  DIVLGN0_SE or
              (DIVLPR0_SE and (DIVLGN0_SE (30 downto 0) &  '0'   ));
DIVLGN2_SE <=  DIVLGN1_SE or
              (DIVLPR1_SE and (DIVLGN1_SE (29 downto 0) & B"00"  ));
DIVLGN3_SE <=  DIVLGN2_SE or
              (DIVLPR2_SE and (DIVLGN2_SE (27 downto 0) & B"0000"));
DIVLGN4_SE <=  DIVLGN3_SE or
              (DIVLPR3_SE and (DIVLGN3_SE (23 downto 0) & X"00"  ));
DIVLGN5_SE <=  DIVLGN4_SE or
              (DIVLPR4_SE and (DIVLGN4_SE (15 downto 0) & X"0000"));

	-- ### ------------------------------------------------------ ###
	-- #   unsigned less or equal comparison			#
	-- ### ------------------------------------------------------ ###

DIVLEU_SE  <= DIVLGN5_SE (31) or DIVLPR5_SE (31);

	-- ### ------------------------------------------------------ ###
	-- ### ------------------------------------------------------ ###

DIVQSHL_SE <= DIVQ_RE (30 downto 0) & DIVLEU_SE;

	-- ### ------------------------------------------------------ ###
	-- #   data memory access control lines :			#
	-- #								#
	-- #     L : I_LOAD_SE						#
	-- #     S : I_STOR_SE						#
	-- #								#
	-- #     R : READ_SE						#
	-- #     W : WRITE_SE						#
	-- #     A : DACCESS_SE						#
	-- #								#
	-- #   L   S           operation               R   W   A	#
	-- # +---+---+-------------------------------+---+---+---+	#
	-- # | 1 | 0 | load  instruction             | 1 | 0 | 1 |	#
	-- # | 0 | 1 | store instruction             | 0 | 1 | 1 |	#
	-- # | 1 | 1 | store conditional instruction | 1 | 1 | 1 |	#
	-- # | 0 | 0 | no access                     | 0 | 0 | 0 |	#
	-- #								#
	-- ### ------------------------------------------------------ ###

DACCESS_SE <= I_STOR_SE  or I_LOAD_SE ;
READ_SE    <=               I_LOAD_SE ;
WRITE_SE   <= I_STOR_SE               ;

	-- ### ------------------------------------------------------ ###
	-- #   data access request					#
	-- #     - disable data accesses in case of early exception	#
	-- #       or reset						#
	-- ### ------------------------------------------------------ ###

DRQ_SE     <= DACCESS_SE  when (EARLYEX_XE = '0' and RESET_RX = '0') else '0';
DRSTLK_SE  <= ERET_SE     when (EARLYEX_XE = '0' and RESET_RX = '0') else '0';
DSYNC_SE   <= SYNC_SE     when (EARLYEX_XE = '0' and RESET_RX = '0') else '0';
DCACHE_SE  <= CACH_SE     when (EARLYEX_XE = '0' and RESET_RX = '0') else '0';

	-- ### ------------------------------------------------------ ###
	-- #   select bytes						#
	-- ### ------------------------------------------------------ ###

BYTSEL_SE  <=
  B"0001" when (I_BYTE_SE = '1' and RARITH_SE (1 downto 0) = B"00") else
  B"0010" when (I_BYTE_SE = '1' and RARITH_SE (1 downto 0) = B"01") else
  B"0100" when (I_BYTE_SE = '1' and RARITH_SE (1 downto 0) = B"10") else
  B"1000" when (I_BYTE_SE = '1' and RARITH_SE (1 downto 0) = B"11") else

  B"0011" when (I_HALF_SE = '1' and RARITH_SE (1         ) =  '0' ) else
  B"1100" when (I_HALF_SE = '1' and RARITH_SE (1         ) =  '1' ) else

  B"1111" when (I_WORD_SE = '1'                                   ) else

  B"1111" when (I_WRDR_SE = '1' and RARITH_SE (1 downto 0) = B"00") else
  B"1110" when (I_WRDR_SE = '1' and RARITH_SE (1 downto 0) = B"01") else
  B"1100" when (I_WRDR_SE = '1' and RARITH_SE (1 downto 0) = B"10") else
  B"1000" when (I_WRDR_SE = '1' and RARITH_SE (1 downto 0) = B"11") else

  B"0001" when (I_WRDL_SE = '1' and RARITH_SE (1 downto 0) = B"00") else
  B"0011" when (I_WRDL_SE = '1' and RARITH_SE (1 downto 0) = B"01") else
  B"0111" when (I_WRDL_SE = '1' and RARITH_SE (1 downto 0) = B"10") else
  B"1111" when (I_WRDL_SE = '1' and RARITH_SE (1 downto 0) = B"11") else

  B"0000" ;

	-- ### ------------------------------------------------------ ###
	-- #   byte shifters for output data				#
	-- ### ------------------------------------------------------ ###

DATA_B_SE  <= TOPER_SE  (31 downto 16) &
              TOPER_SE  ( 7 downto  0) &
              TOPER_SE  ( 7 downto  0)   when (I_BYTE_SE     = '1') else
              TOPER_SE  (31 downto  0)   ;

DATA_H_SE  <= DATA_B_SE (15 downto  0) &
              DATA_B_SE (15 downto  0)   when (I_BYTE_SE     = '1') else
              DATA_B_SE (15 downto  0) &
              DATA_B_SE (15 downto  0)   when (I_HALF_SE     = '1') else
              DATA_B_SE (31 downto  0)   ;

DATA_L_SE  <= DATA_H_SE (23 downto  0) &
              DATA_H_SE (31 downto 24)   when (I_WRDL_SE     = '1') else
              DATA_H_SE (31 downto  0)   ;

DATA_0_SE  <= DATA_L_SE (23 downto  0) &
              DATA_L_SE (31 downto 24)   when (RARITH_SE (0) = '1') else
              DATA_L_SE (31 downto  0)   ;

DATA_1_SE  <= DATA_0_SE (15 downto  0) &
              DATA_0_SE (31 downto 16)   when (RARITH_SE (1) = '1') else
              DATA_0_SE (31 downto  0)   ;

DATA_SE    <= DATA_1_SE                  ;

	-- ### ------------------------------------------------------ ###
	-- #   Cache instruction : operation code			#
	-- ### ------------------------------------------------------ ###

CACHOP_SE  <= RT_RD ;
CACHOP_SM  <= RT_RE ;

	-- ### ------------------------------------------------------ ###
	-- #   save the address of the branch instruction		#
	-- ### ------------------------------------------------------ ###

WREDOPC_SE <= I_BRNCH_SE;

	-- ### ------------------------------------------------------ ###
	-- #   data hazards in the Memory Access stage :		#
	-- ### ------------------------------------------------------ ###

HZ_LO_SM   <= '1' when (I_MUSEL_SM = '1'     and I_WLO_SW   = '1'    ) else
              '0' ;

HZ_HI_SM   <= '1' when (I_MUSEH_SM = '1'     and I_WHI_SW   = '1'    ) else
              '0' ;

	-- ### ------------------------------------------------------ ###
	-- #   stall due to hazards in Memory Access stage :		#
	-- #								#
	-- #   Examples :						#
	-- #      Mtlo Ri						#
	-- #      Madd Rj, Rk						#
	-- #								#
	-- #   - using Lo Register in Memory Access stage when Lo is	#
	-- #     being written by the instruction present in Write	#
	-- #     Back stage						#
	-- #								#
	-- #   - using Hi Register in Memory Access stage when Hi is	#
	-- #     being written by the instruction present in Write	#
	-- #     Back stage						#
	-- ### ------------------------------------------------------ ###

DATHZDS_SM <=                 HZ_LO_SM  or HZ_HI_SM                   ;

	-- ### ------------------------------------------------------ ###
	-- #   stall due to hazards in Memory Access stage :		#
	-- #     - data        hazards					#
	-- ### ------------------------------------------------------ ###

HAZARDS_SM <= DATHZDS_SM;

	-- ### ------------------------------------------------------ ###
	-- #   exceptions detected during Execute stage :		#
	-- #								#
	-- #     - reserved instruction					#
	-- ### ------------------------------------------------------ ###

RDHWR_XE   <= '1' when (EFFHWRE_RD     = X"0000_0000" and
                        RDHWR_SE       =  '1'         and
                        USRMOD_SX      =  '1'         and
                        STATUS_RX (28) =  '0'            ) else '0' ;

RSVDINS_XE <= RDHWR_XE  or RSVDINS_RD ;

	-- ### ------------------------------------------------------ ###
	-- #   exceptions detected during Execute stage :		#
	-- #								#
	-- #     - load  address miss aligned				#
	-- #     - store address miss aligned				#
	-- #     - load  address violating system space			#
	-- #     - store address violating system space			#
	-- #     - detecting an overflow				#
	-- #     - detecting a  trap condition				#
	-- ### ------------------------------------------------------ ###

DAMALGN_XE <= RARITH_SE ( 0) or  RARITH_SE (1) when (I_WORD_SE = '1') else
              RARITH_SE ( 0)                   when (I_HALF_SE = '1') else
              '0'                              ;

DASVIOL_XE <= RARITH_SE (31) and USRMOD_SX     when (IMPSTD_SX = '1') else '0';

LAMALGN_XE <= DAMALGN_XE     and I_MLOAD_SE    ;
LASVIOL_XE <= DASVIOL_XE     and I_MLOAD_SE    ;

SAMALGN_XE <= DAMALGN_XE     and I_MSTOR_SE    ;
SASVIOL_XE <= DASVIOL_XE     and I_MSTOR_SE    ;

OVRF_XE    <= OVERFLW_SE                       when (I_OVRF_SE = '1') else '0';
TRAP_XE    <= TESTBIT_SE                       when (TRAP_RD   = '1') else '0';

	-- ### ------------------------------------------------------ ###
	-- #   effective Wait instruction				#
	-- ### ------------------------------------------------------ ###

EFFWAIT_SM <= WAIT_SM and not HWSWIT_RX;

	-- ### ------------------------------------------------------ ###
	-- #   data access not ready					#
	-- ### ------------------------------------------------------ ###

DNOTRDY_SM <= not D_ACCPT and (DRQ_RE    or
                               DRSTLK_RE or
                               DSYNC_RE  or
                               DCACHE_RE   );

	-- ### ------------------------------------------------------ ###
	-- #   destination integer register's number			#
	-- ### ------------------------------------------------------ ###

RD_SM      <= RD_RE  ;

	-- ### ------------------------------------------------------ ###
	-- #   byte address to align the data read from the memory	#
	-- ### ------------------------------------------------------ ###

BYTADR_SM  <= RES_RE (1 downto 0) ;

	-- ### ------------------------------------------------------ ###
	-- #   align data read from memory				#
	-- ### ------------------------------------------------------ ###

DIN_SM     <=
                           D_IN    (31 downto  0) when (BYTADR_SM = B"00") else
  X"00"                  & D_IN    (31 downto  8) when (BYTADR_SM = B"01") else
  X"0000"                & D_IN    (31 downto 16) when (BYTADR_SM = B"10") else
  X"000000"              & D_IN    (31 downto 24) ;

	-- ### ------------------------------------------------------ ###
	-- #   misaligned load word right				#
	-- #     shift right the data received from the memory and	#
	-- #     merge							#
	-- ### ------------------------------------------------------ ###

WRDIN_SM   <=
                           D_IN    (31 downto  0) when (BYTADR_SM = B"00") else
  DATA_RE ( 7 downto  0) & D_IN    (31 downto  8) when (BYTADR_SM = B"01") else
  DATA_RE (15 downto  0) & D_IN    (31 downto 16) when (BYTADR_SM = B"10") else
  DATA_RE (23 downto  0) & D_IN    (31 downto 24) ;

	-- ### ------------------------------------------------------ ###
	-- #   misaligned load word left				#
	-- #     shift left the data received from the memory and	#
	-- #     merge							#
	-- ### ------------------------------------------------------ ###

WLDIN_SM   <=
  D_IN    (31 downto  0)                          when (BYTADR_SM = B"11") else
  D_IN    (23 downto  0) & DATA_RE (31 downto 24) when (BYTADR_SM = B"10") else
  D_IN    (15 downto  0) & DATA_RE (31 downto 16) when (BYTADR_SM = B"01") else
  D_IN    ( 7 downto  0) & DATA_RE (31 downto  8) ;

	-- ### ------------------------------------------------------ ###
	-- #   receiving the result of a Store Conditional (Sc)		#
	-- ### ------------------------------------------------------ ###

SCDIN_SM   <= DIN_SM (31 downto 0) ;

	-- ### ------------------------------------------------------ ###
	-- #   extend the sign when loading a byte or a half word in	#
	-- #   signed mode						#
	-- ### ------------------------------------------------------ ###

BSEXT_SM   <= X"ffffff" when (DIN_SM ( 7) = '1') else X"000000" ;
HSEXT_SM   <= X"ffff"   when (DIN_SM (15) = '1') else X"0000"   ;

with OPCOD_RE select
DATA_SM    <= DIN_SM                           when lw_i   ,
              WLDIN_SM                         when lwl_i  ,
              WRDIN_SM                         when lwr_i  ,
              HSEXT_SM  & DIN_SM (15 downto 0) when lh_i   ,
              X"0000"   & DIN_SM (15 downto 0) when lhu_i  ,
              BSEXT_SM  & DIN_SM ( 7 downto 0) when lb_i   ,
              X"000000" & DIN_SM ( 7 downto 0) when lbu_i  ,
              DIN_SM                           when ll_i   ,
              SCDIN_SM                         when sc_i   ,
              DIN_SM                           when mfc2_i ,
              RES_RE                           when others ;

	-- ### ------------------------------------------------------ ###
	-- #   value written into HI or LO registers			#
	-- ### ------------------------------------------------------ ###

LO_SW      <= DIVQ_RM                when (OPCOD_RM = div_i  ) else
              DIVQ_RM                when (OPCOD_RM = divu_i ) else
              DATA_RM                when (OPCOD_RM = mtlo_i ) else
              RMUL_SW (31 downto  0) ;

HI_SW      <= DIVR_RM                when (OPCOD_RM = div_i  ) else
              DIVR_RM                when (OPCOD_RM = divu_i ) else
              DATA_RM                when (OPCOD_RM = mthi_i ) else
              RMUL_SW (63 downto 32) ;

	-- ### ------------------------------------------------------ ###
	-- #   value written into integer registers			#
	-- ### ------------------------------------------------------ ###

DATA_SW    <= RMUL_SW (31 downto  0) when (OPCOD_RM = mul_i  ) else
              DATA_RM                ;

	-- ### ------------------------------------------------------ ###
	-- #   exceptions detected during Memory Access stage :		#
	-- #								#
	-- #     - data address bus error				#
	-- #       Bus error on read operation is checked only on	#
	-- #       an effective access					#
	-- ### ------------------------------------------------------ ###

DABUSER_XM <= (D_RBERR and DRQ_RE) or D_WBERR;

	-- ### ------------------------------------------------------ ###
	-- #   exceptions relative to data address (in such a case	#
	-- #   the data address is saved into Bad Virtual Address	#
	-- #   register)						#
	-- #								#
	-- #   exceptions relative to instruction address (in such	#
	-- #   a case the instruction address is saved into Bad		#
	-- #   Virtual Address register)				#
	-- ### ------------------------------------------------------ ###

WBADDA_XM  <= SASVIOL_RE or LASVIOL_RE or LAMALGN_RE or SAMALGN_RE;
WBADIA_XM  <= IASVIOL_RE or IAMALGN_RE                            ;

	-- ### ------------------------------------------------------ ###
	-- #   data written into Count Register :			#
	-- #								#
	-- #     - increment at each cycle				#
	-- #     - propagate						#
	-- ### ------------------------------------------------------ ###

CNTPR0_SX  <= COUNT_RX ;

	-- ### ------------------------------------------------------ ###
	-- #   data written into Count Register :			#
	-- #								#
	-- #     - increment at each cycle				#
	-- #     - 5 layers of propagate				#
	-- ### ------------------------------------------------------ ###

CNTPR1_SX  <= CNTPR0_SX and  (CNTPR0_SX (30 downto 0) &  '1'   )     ;
CNTPR2_SX  <= CNTPR1_SX and  (CNTPR1_SX (29 downto 0) & B"11"  )     ;
CNTPR3_SX  <= CNTPR2_SX and  (CNTPR2_SX (27 downto 0) & X"f"   )     ;
CNTPR4_SX  <= CNTPR3_SX and  (CNTPR3_SX (23 downto 0) & X"ff"  )     ;
CNTPR5_SX  <= CNTPR4_SX and  (CNTPR4_SX (15 downto 0) & X"ffff")     ;

	-- ### ------------------------------------------------------ ###
	-- #   data written into Count Register :			#
	-- #								#
	-- #     - increment at each cycle				#
	-- #     - sum and carry					#
	-- ### ------------------------------------------------------ ###

CNTCRY_SX  <= CNTPR5_SX                        ;
CNTCYI_SX  <= CNTCRY_SX (30 downto  0) & '1'   ;
COUNT_SX   <= CNTCYI_SX xor COUNT_RX           ;

	-- ### ------------------------------------------------------ ###
	-- #   data written into Count Register :			#
	-- #     - Mtc0 instruction					#
	-- ### ------------------------------------------------------ ###

COUNT_SM   <= RES_RE ;

	-- ### ------------------------------------------------------ ###
	-- #   write enable into Count Register :			#
	-- #								#
	-- #     - increment at each cycle				#
	-- #     - Mtc0 instruction					#
	-- ### ------------------------------------------------------ ###

WCOUNT_SX  <= '1'        ;
WCOUNT_SM  <= I_WCOP0_SM when (COP0D_RE = c0_count) else '0';

	-- ### ------------------------------------------------------ ###
	-- #   data written into Exception Base Register :		#
	-- #								#
	-- #     - reset						#
	-- #     - Mtc0 instruction					#
	-- #         standard implementation : "10" on two most		#
	-- #                                   significant bits		#
	-- #         tsar     implementation : any value on the two	#
	-- #                                   most significant bits	#
	-- ### ------------------------------------------------------ ###

EBASE_XX   <= X"8000_0" & B"00" & cpu_nbr;

EBASE_SM   <=
          RES_RE (31 downto 12) & B"00" & cpu_nbr when (IMPTSR_SX = '1') else
  B"10" & RES_RE (29 downto 12) & B"00" & cpu_nbr ;

	-- ### ------------------------------------------------------ ###
	-- #   write enable into Exception Base Register :		#
	-- #								#
	-- #     - reset						#
	-- #     - Mtc0 instruction					#
	-- ### ------------------------------------------------------ ###

WEBASE_XX  <= RESET_RX   ;
WEBASE_SM  <= I_WCOP0_SM when (COP0D_RE = c0_ebase) else '0';

	-- ### ------------------------------------------------------ ###
	-- #   data written into Thread Control Context Register :	#
	-- #								#
	-- #     - Mtc0 instruction					#
	-- ### ------------------------------------------------------ ###

TCCTX_SM   <= RES_RE ;

	-- ### ------------------------------------------------------ ###
	-- #   write enable into Thread Control Context Register :	#
	-- #								#
	-- #     - Mtc0 instruction					#
	-- ### ------------------------------------------------------ ###

WTCCTX_SM  <= I_WCOP0_SM when (COP0D_RE = c0_tcctx ) else '0';

	-- ### ------------------------------------------------------ ###
	-- #   write enable into User Local (Coprocessor Zero's		#
	-- #   Implementation Dependent) Register :			#
	-- #								#
	-- #     - Mtc0 instruction					#
	-- ### ------------------------------------------------------ ###

WUSRLCL_SM <= I_WCOP0_SM when (COP0D_RE = c0_usrlcl) else '0';

	-- ### ------------------------------------------------------ ###
	-- #   write enable into Hardware Registers Enable Register :	#
	-- #								#
	-- #     - Mtc0 instruction					#
	-- ### ------------------------------------------------------ ###

WHWRENA_SM <= I_WCOP0_SM when (COP0D_RE = c0_hwrena) else '0';

	-- ### ------------------------------------------------------ ###
	-- #   Cause Register is written in the following cases		#
	-- #   (decreasing order of priority) :				#
	-- #								#
	-- #     BD   : Branch Delayed Slot				#
	-- #     CE   : Coprocessor Unit Number				#
	-- #     HWIP : Hardware Interrupt Pending			#
	-- #     SWIP : Software Interrupt Pending			#
	-- #     EXC  : Exception Code					#
	-- #								#
	-- #                       BD    CE   HWIP   SWIP   EXC		#
	-- #   -----------------+-----+-----+------+------+-----+	#
	-- #   exception        | New | New | New  | Old  | New |	#
	-- #   interrupt        | New | New | New  | New  | New |	#
	-- #   Mtc0 instruction | Old | Old | New  | New  | Old |	#
	-- #   at each cycle    | Old | Old | New  | Old  | Old |	#
	-- ### ------------------------------------------------------ ###

	-- ### ------------------------------------------------------ ###
	-- #   data written into Cause Register :			#
	-- #								#
	-- #     - the Branch Delayed Slot bit				#
	-- #								#
	-- #     - the Exception Code depends on the type of the	#
	-- #       exception						#
	-- #								#
	-- #     - Instruction Bus Error has a higher priority over	#
	-- #       execution exceptions.				#
	-- #								#
	-- #     - Execution exceptions have a higher priority over	#
	-- #       Data Bus Error.					#
	-- ### ------------------------------------------------------ ###

BDSLOT_XM  <= BDSLOT_RE when (STATUS_RX (1) = '0') else CAUSE_RX (31);

EXCCODE_XM <= B"1_1000" when ( MCHECKX_RX                = '1') else
              B"0_0110" when ( IABUSER_RE                = '1') else
              B"0_0100" when ((IAMALGN_RE or IASVIOL_RE) = '1') else
              B"0_0100" when ((LAMALGN_RE or LASVIOL_RE) = '1') else
              B"0_0101" when ((SAMALGN_RE or SASVIOL_RE) = '1') else
              B"0_1000" when ( SYSCALL_RE                = '1') else
              B"0_1001" when ( BREAK_RE                  = '1') else
              B"0_1010" when ( RSVDINS_RE                = '1') else
              B"0_1011" when ( CPUNUSE_RE                = '1') else
              B"0_1100" when ( OVRF_RE                   = '1') else
              B"0_1101" when ( TRAP_RE                   = '1') else
              B"0_0111" when ( DABUSER_XM                = '1') else
              B"0_0000" ;

	-- ### ------------------------------------------------------ ###
	-- #   data written into Cause Register :			#
	-- #								#
	-- #     - reset :						#
	-- #         All bits are set to 0 except			#
	-- #								#
	-- #     - exception or interrupt :				#
	-- #         in case of exception almost all the fileds are	#
	-- #         updated. The Branch Delayed Slot (only if the	#
	-- #         Exception Level bit in the Status Register is 0),	#
	-- #         the Coprocessor Error and the Exception Code are	#
	-- #         modified to report the processor's state.		#
	-- #         The Software Interrupt Pending bits remain		#
	-- #         unchanged (the Hardware Interrupts Pending bits	#
	-- #         are updated at each cycle).			#
	-- #								#
	-- #     - Mtc0 :						#
	-- #         the execution of a Mtc0 instruction updates the	#
	-- #         Software Interrupt Pending bits (this case hapens	#
	-- #         when software interrupts are masked) (the Hardware	#
	-- #         Interrupt Pending is updated at each cycle).	#
	-- #								#
	-- #     - at each cycle, the Hardware Interrupt Pending bits	#
	-- #       are updated						#
	-- ### ------------------------------------------------------ ###

CAUSE_XX   <=  X"0000"                & IT_XX                     & B"00"    &
               X"00"                                              ;

CAUSE_XM   <= BDSLOT_XM               & CAUSE_RX   (30          ) & CPNBR_RE &
              CAUSE_RX (27 downto 16) & IT_XX                     &
              CAUSE_RX ( 9 downto  7) & EXCCODE_XM                &
              CAUSE_RX ( 1 downto  0)                             ;

CAUSE_SM   <= CAUSE_RX (31 downto 28) & RES_RE     (27          ) &
              CAUSE_RX (26 downto 24) & RES_RE     (23 downto 22) &
              CAUSE_RX (21 downto 16) & IT_XX                     &
                                        RES_RE     ( 9 downto  8) &
              CAUSE_RX ( 7 downto  0)                             ;

CAUSE_SX   <= CAUSE_RX (31 downto 16) & IT_XX                     &
              CAUSE_RX ( 9 downto  0)                             ;

	-- ### ------------------------------------------------------ ###
	-- #   write enable into Cause Register :			#
	-- #								#
	-- #     - reset						#
	-- #     - exception or interrupt				#
	-- #     - Mtc0 instruction					#
	-- ### ------------------------------------------------------ ###

WCAUSE_XX  <= RESET_RX   ;
WCAUSE_XM  <= EXCRQ_XM   ;
WCAUSE_SM  <= I_WCOP0_SM when (COP0D_RE = c0_cause) else '0';

	-- ### ------------------------------------------------------ ###
	-- #   data written into Status Register :			#
	-- #								#
	-- #     - reset :						#
	-- #         All bits are set to 0 except :			#
	-- #         Bootstrap Exception Vector bit  <- 1		#
	-- #         Kernel, Supervisor, User   bits <- 01 (Kernel)	#
	-- #								#
	-- #     - exception or interrupt :				#
	-- #         Exception Level            bit  <- 1		#
	-- #								#
	-- #     - Eret instruction :					#
	-- #         the Error Level bit is cleared if set. Otherwise	#
	-- #         the Exception Level bit is cleared			#
	-- #								#
	-- #     - Mtc0 instruction :					#
	-- #         the value of an integer register is loaded into	#
	-- #         the register					#
	-- #								#
	-- #     - Di or Ei instruction :				#
	-- #         Set or reset Enable Interrupts bit			#
	-- ### ------------------------------------------------------ ###

STATUS_XX  <=                X"00400004" ;
STATUS_XM  <= STATUS_RX  or  X"00000002" ;

RSTORSR_SM <= STATUS_RX  and X"fffffffb" when (STATUS_RX (2) = '1') else
              STATUS_RX  and X"fffffff9" ;

DEISR_SM   <= STATUS_RX (31 downto 1) & I_RE (5);

STATUS_SM  <= RSTORSR_SM                 when (ERET_SM       = '1') else
              DEISR_SM                   when (MFMC0_SM      = '1') else
              RES_RE                     ;

	-- ### ------------------------------------------------------ ###
	-- #   write enable into Status Register :			#
	-- #								#
	-- #     - reset						#
	-- #     - exception or interrupt				#
	-- #     - Eret, Mtc0, Di and Ei instructions			#
	-- ### ------------------------------------------------------ ###

WSR_XX     <= RESET_RX ;
WSR_XM     <= EXCRQ_XM ;

WSR_SM     <= '1'      when (ERET_SM  = '1'                         ) else
              '1'      when (MFMC0_SM = '1'                         ) else
              '1'      when (MTC0_SM  = '1' and COP0D_RE = c0_status) else
              '0'      ;

	-- ### ------------------------------------------------------ ###
	-- #   data written into Exception Program Counter :		#
	-- #								#
	-- #     - interrupt :						#
	-- #         the address of the first unexecuted instruction is	#
	-- #         saved unless the first unexecuted instruction is	#
	-- #         in the delayed slot of a branch instruction in	#
	-- #         which case the address of the branch instruction	#
	-- #         is saved.						#
	-- #								#
	-- #     - exception :						#
	-- #         the address of the faulty instruction is saved	#
	-- #         unless the faulty instruction is in the delayed	#
	-- #         slot of a branch instruction in which case the	#
	-- #         address of the branch instruction is saved.	#
	-- #								#
	-- #     - Mtc0 instruction :					#
	-- #         the value of an integer register is loaded into	#
	-- #         the register					#
	-- ### ------------------------------------------------------ ###

EPC_XM     <= PC_RE      when (BDSLOT_RE = '0') else REDOPC_RE ;
EPC_SM     <= RES_RE     ;

	-- ### ------------------------------------------------------ ###
	-- #   write enable into Exception Program Counter :		#
	-- #								#
	-- #     - exception or interrupt :				#
	-- #         if the Exception Level bit of Status Register	#
	-- #         is 0						#
	-- #								#
	-- #     - Mtc0 instruction :					#
	-- #         if the destination register is EPC			#
	-- ### ------------------------------------------------------ ###

WEPC_XM    <= EXCRQ_XM   when (STATUS_RX (1) = '0'    ) else '0';
WEPC_SM    <= I_WCOP0_SM when (COP0D_RE      = c0_epc ) else '0';

	-- ### ------------------------------------------------------ ###
	-- #   data written into Error Exception Program Counter :	#
	-- #								#
	-- #     - reset :						#
	-- #         the address of the first unexecuted instruction is	#
	-- #         saved unless the first unexecuted instruction is	#
	-- #         in the delayed slot of a branch instruction in	#
	-- #         which case the address of the branch instruction	#
	-- #         is saved.						#
	-- #								#
	-- #     - Mtc0 instruction :					#
	-- #         the value of an integer register is loaded into	#
	-- #         the register					#
	-- ### ------------------------------------------------------ ###

EEPC_XX    <= PC_RE      when (BDSLOT_RE = '0') else REDOPC_RE ;
EEPC_SM    <= RES_RE     ;

	-- ### ------------------------------------------------------ ###
	-- #   write enable into Error Exception Program Counter :	#
	-- #								#
	-- #     - reset						#
	-- #     - Mtc0 instruction					#
	-- ### ------------------------------------------------------ ###

WEEPC_XX   <= RESET_RX   ;
WEEPC_SM   <= I_WCOP0_SM when (COP0D_RE = c0_eepc ) else '0';

	-- ### ------------------------------------------------------ ###
	-- #   compute the next instruction address :			#
	-- #								#
	-- #    - in case of reset					#
	-- #    - in case of interrupt or exception during the boot	#
	-- #    - in case of interrupt or exception			#
	-- ### ------------------------------------------------------ ###

NEXTPC_XX  <= reset_a                          ;
EXCADR_XM  <= EBASE_RM (31 downto 12) & X"180" ;

NEXTPC_XM  <= bootexc_a when (STATUS_RX (22) = '1') else
              EXCADR_XM ;

	-- ### ------------------------------------------------------ ###
	-- #   exception request :					#
	-- #								#
	-- #     - early exceptions : those that inhibit the memory	#
	-- #       access request during Memory Access stage		#
	-- #								#
	-- #     - late exceptions  : those that have no effect on	#
	-- #       the current memory access				#
	-- ### ------------------------------------------------------ ###

EARLYEX_XE <= CPUNUSE_RD               or
              BREAK_RD   or SYSCALL_RD or
              TRAP_XE                  or
              IABUSER_RD               or
              IAMALGN_RD or IASVIOL_RD or
              RSVDINS_XE               or
              LAMALGN_XE or LASVIOL_XE or
              SAMALGN_XE or SASVIOL_XE or
              OVRF_XE                  or
              MCHECKX_XX               or
              INTRQ_RX                   ;

LATEEX_XM  <= DABUSER_XM                 ;
EXCRQ_XM   <= EARLYEX_RE or LATEEX_XM    ;

	-- ### ------------------------------------------------------ ###
	-- #   interrupt request					#
	-- #     - check hardware and software interrupts		#
	-- ### ------------------------------------------------------ ###

HWSWIT_XX  <= '0' when (CAUSE_RX (15 downto 8) = X"00") else '1';

	-- ### ------------------------------------------------------ ###
	-- #   interrupt request					#
	-- #     - check enabled hardware and software interrupts	#
	-- #     - an interrupt cannot be attached to a killed		#
	-- #       instruction						#
	-- ### ------------------------------------------------------ ###

ITMASK_XX  <=                     STATUS_RX (15 downto 8)                   ;
ENBLIT_XX  <=     ITMASK_XX and   CAUSE_RX  (15 downto 8)                   ;

GLBMSK_XX  <= not KILLED_SE when (STATUS_RX ( 2 downto 0) = B"001") else '0';

INTRQ_XX   <= '0'           when (ENBLIT_XX               = X"00" ) else
                  GLBMSK_XX ;

	-- ### ------------------------------------------------------ ###
	-- #   instruction flow control :				#
	-- #								#
	-- #   four cases can happen :					#
	-- #   (1) Kill :  the instruction in the corresponding stage	#
	-- #               is killed					#
	-- #   (2) Stall : the instruction is not allowed to pass to	#
	-- #               the next pipe stage				#
	-- #   (3) Copy  : the instruction is duplicated. A copy	#
	-- #               remains in the current stage and the other	#
	-- #               goes down the pipe				#
	-- #   (4) Exec :  the instruction can be executed		#
	-- #								#
	-- #   Here follows a summary of different situations.		#
	-- #								#
	-- #                               | I | D | E | M | W |	#
	-- #     --------------------------+---+---+---+---+---|	#
	-- #     reset                     | K | K | K | K | E |	#
	-- #     exception                 | K | K | K | K | E |	#
	-- #     interrupt                 | K | K | K | K | E |	#
	-- #     instruction not ready     | S | S | E | E | E |	#
	-- #     data access not ready     | S | S | S | S | E |	#
	-- #     hazard in DEC             | S | S | E | E | E |	#
	-- #     hazard in EXE             | S | S | S | E | E |	#
	-- #     Eret                      | K | E | E | E | E |	#
	-- #     Mtc0                      | K | E | E | E | E |	#
	-- #     Wait                      | S | S | C | E | E |	#
	-- #     Div                       | S | S | C | E | E |	#
	-- #								#
	-- #   Note that if more than one situation occur in the same	#
	-- #   time, Kill is prior to Stall which is prior to Exec	#
	-- ### ------------------------------------------------------ ###

	-- ### ------------------------------------------------------ ###
	-- #   the instruction in Instruction Fetch stage :		#
	-- #								#
	-- #   It is never copied					#
	-- #								#
	-- #   It is stalled (the fetch must be retried) if :		#
	-- #     - the next stage (Instruction Decode) is occupied	#
	-- #     - the instruction memory is not able to answer the	#
	-- #       instruction fetch request				#
	-- #								#
	-- #   It is killed if :					#
	-- #     - the third previous instruction causes an exception	#
	-- #     - a hardware or software interrupt occurs		#
	-- #     - a hardware reset is detected				#
	-- #     - the previous instruction is an Eret			#
	-- #     - the previous instruction is a  Mtc0			#
	-- ### ------------------------------------------------------ ###

KILL_SI    <=      EXCRQ_XM   or RESET_RX   or MTC0_SD or ERET_SD           ;

STALL_SI   <= not (KILL_SI                                             ) and
                  (COPY_SD    or STALL_SD   or INOTRDY_SE              )    ;
COPY_SI    <= '0'                                                           ;
EXEC_SI    <= not (KILL_SI    or STALL_SI   or COPY_SI                 )    ;

	-- ### ------------------------------------------------------ ###
	-- #   the instruction in Instruction Decode stage :		#
	-- #								#
	-- #   It is never copied					#
	-- #								#
	-- #   It is stalled if :					#
	-- #     - the next stage (Execute) is occupied			#
	-- #     - there is a data hazard that cannot be resolved by	#
	-- #       bypasses						#
	-- #     - the instruction memory cannot answer the instruction	#
	-- #       fetch (the instruction cannot be executed because it	#
	-- #       may change the instruction stream)			#
	-- #								#
	-- #   It is killed if  :					#
	-- #     - the second previous instruction causes an exception	#
	-- #     - a hardware reset is detected				#
	-- #     - a hardware or a software interrupt occurs		#
	-- ### ------------------------------------------------------ ###

KILL_SD    <=      EXCRQ_XM   or RESET_RX                                   ;

STALL_SD   <= not (KILL_SD                                             ) and
                  (COPY_SE    or STALL_SE   or HAZARDS_SD or INOTRDY_SE)    ;
COPY_SD    <= '0'                                                           ;
EXEC_SD    <= not (KILL_SD    or STALL_SD   or COPY_SD                 )    ;

	-- ### ------------------------------------------------------ ###
	-- #   the instruction in Execute stage :			#
	-- #								#
	-- #   It is copied if  :					#
	-- #     - the current instruction is micro-programmed and	#
	-- #       the micro-instruction is not the last one		#
	-- #								#
	-- #   It is stalled if :					#
	-- #     - the next stage (Memory Access) is occupied		#
	-- #     - there is a data hazard that cannot be resolved by	#
	-- #       bypasses						#
	-- #								#
	-- #   It is killed if :					#
	-- #     - the previous instruction causes an exception		#
	-- #     - a hardware reset is detected				#
	-- #     - a hardware or a software interrupt occurs		#
	-- ### ------------------------------------------------------ ###

KILL_SE    <=      EXCRQ_XM   or RESET_RX                                   ;

STALL_SE   <= not (KILL_SE                                             ) and
                  (COPY_SM    or STALL_SM   or HAZARDS_SE              )    ;
COPY_SE    <= not (KILL_SE    or STALL_SE                              ) and
                  (MICCOPY_SE                                          )    ;
EXEC_SE    <= not (KILL_SE    or STALL_SE   or COPY_SE                 )    ;

	-- ### ------------------------------------------------------ ###
	-- #   the instruction in the Memory Access stage :		#
	-- #								#
	-- #   It is copied if  :					#
	-- #     - the current instruction is a Wait			#
	-- #								#
	-- #   It is stalled if :					#
	-- #     - the data memory is not able to answer the request	#
	-- #     - there is a data hazard that cannot be resolved by	#
	-- #       bypasses						#
	-- #								#
	-- #   It is killed if :					#
	-- #     - it causes an exception				#
	-- #     - a hardware reset is detected				#
	-- ### ------------------------------------------------------ ###

KILL_SM    <=      EXCRQ_XM   or RESET_RX                                   ;

STALL_SM   <= not (KILL_SM                                             ) and
                  (COPY_SW    or STALL_SW   or HAZARDS_SM or DNOTRDY_SM)    ;
COPY_SM    <= not (KILL_SM    or STALL_SM                              ) and
                  (EFFWAIT_SM                                          )    ;
EXEC_SM    <= not (KILL_SM    or STALL_SM   or COPY_SM                 )    ;

	-- ### ------------------------------------------------------ ###
	-- #   the instruction in the Write Back stage :		#
	-- #								#
	-- #   It is always executed					#
	-- ### ------------------------------------------------------ ###

KILL_SW    <= '0'                                                           ;
STALL_SW   <= '0'                                                           ;
COPY_SW    <= '0'                                                           ;
EXEC_SW    <= not (KILL_SW    or STALL_SW   or COPY_SW                 )    ;

	-- ### ------------------------------------------------------ ###
	-- #   killed intruction :					#
	-- #								#
	-- #   no exception or interrupt can be attached to a killed	#
	-- #   instruction						#
	-- ### ------------------------------------------------------ ###

KILLED_SI  <= KILL_SI              ;
KILLED_SD  <= KILL_SD or KILLED_RI ;
KILLED_SE  <= KILL_SE or KILLED_RD ;

	-- ### ------------------------------------------------------ ###
	-- #   actions on registers :					#
	-- #								#
	-- #   Three actions may be made on control registers :		#
	-- #      (1) bubble : insert a bubble (nop) into the pipe	#
	-- #      (2) hold   : hold the instruction			#
	-- #      (3) shift  : shift a new instruction into the stage	#
	-- #								#
	-- #   In each stage the action can be defined by the following	#
	-- #   table :							#
	-- #								#
	-- #   stage   next stage   action in stage			#
	-- #   ------+------------+----------------			#
	-- #     K   |     K      |    bubble				#
	-- #     K   |     S      |     hold				#
	-- #     K   |     C      |     hold				#
	-- #     K   |     E      |    bubble				#
	-- #    -----+------------+----------------			#
	-- #     S   |     S      |     hold				#
	-- #     S   |     C      |     hold				#
	-- #     S   |     E      |    bubble				#
	-- #    -----+------------+----------------			#
	-- #     C   |     E      |    shift				#
	-- #    -----+------------+----------------			#
	-- #     E   |     E      |    shift				#
	-- ### ------------------------------------------------------ ###

BUBBLE_SI  <= (KILL_SI or STALL_SI) and (KILL_SD  or EXEC_SD);
HOLD_SI    <=                           (STALL_SD or COPY_SD);
SHIFT_SI   <= (COPY_SI or EXEC_SI ) and (            EXEC_SD);

BUBBLE_SD  <= (KILL_SD or STALL_SD) and (KILL_SE  or EXEC_SE);
HOLD_SD    <=                           (STALL_SE or COPY_SE);
SHIFT_SD   <= (COPY_SD or EXEC_SD ) and (            EXEC_SE);

BUBBLE_SE  <= (Kill_SE or STALL_SE) and (KILL_SM  or EXEC_SM);
HOLD_SE    <=                           (STALL_SM or COPY_SM);
SHIFT_SE   <= (COPY_SE or EXEC_SE ) and (            EXEC_SM);

BUBBLE_SM  <= (KILL_SM or STALL_SM) and (KILL_SW  or EXEC_SW);
HOLD_SM    <=                           (STALL_SW or COPY_SW);
SHIFT_SM   <= (COPY_SM or EXEC_SM ) and (            EXEC_SW);

BUBBLE_SW  <= (KILL_SW or STALL_SW) and ('0'      or '1'    );
HOLD_SW    <=                           ('0'      or '0'    );
SHIFT_SW   <= (COPY_SW or EXEC_SW ) and (            '1'    );

	-- ### ------------------------------------------------------ ###
	-- #   actions on registers :					#
	-- #								#
	-- #   Two actions may be made on data registers (note that	#
	-- #   Write Back is always loading) :				#
	-- #								#
	-- #      (1) load : load a new data into  the reg. (C or E)	#
	-- #      (2) keep : hold the same data in the reg. (K or S)	#
	-- ### ------------------------------------------------------ ###

LOAD_SI    <= COPY_SI or EXEC_SI ;
KEEP_SI    <= KILL_SI or STALL_SI;

LOAD_SD    <= COPY_SD or EXEC_SD ;
KEEP_SD    <= KILL_SD or STALL_SD;

LOAD_SE    <= COPY_SE or EXEC_SE ;
KEEP_SE    <= KILL_SE or STALL_SE;

LOAD_SM    <= COPY_SM or EXEC_SM ;
KEEP_SM    <= KILL_SM or STALL_SM;

LOAD_SW    <= COPY_SW or EXEC_SW ;
KEEP_SW    <= KILL_SW or STALL_SW;

	-- ### ------------------------------------------------------ ###
	-- #   assign registers (those related to a pipeline stage)	#
	-- #   Instruction Fetch stage					#
	-- ### ------------------------------------------------------ ###

IFC_CYCLE : process (CK)
begin

  if (CK = '1' and CK'EVENT) then

    if    (BUBBLE_SI = '1') then I_RI       <= nop_i      ;
    elsif (HOLD_SI   = '1') then I_RI       <= I_RI       ;
    else                         I_RI       <= I_IN       ;
    end if;

    if    (BUBBLE_SI = '1') then IREAD_RI   <= '0'        ;
    elsif (HOLD_SI   = '1') then IREAD_RI   <= '0'        ;
    else                         IREAD_RI   <= '1'        ;
    end if;

    if    (BUBBLE_SI = '1') then BDSLOT_RI  <= BDSLOT_XI  ;
    elsif (HOLD_SI   = '1') then BDSLOT_RI  <= BDSLOT_RI  ;
    else                         BDSLOT_RI  <= BDSLOT_XI  ;
    end if;

    if    (BUBBLE_SI = '1') then KILLED_RI  <= KILLED_SI  ;
    elsif (HOLD_SI   = '1') then KILLED_RI  <= KILLED_RI  ;
    else                         KILLED_RI  <= KILLED_SI  ;
    end if;

    if    (BUBBLE_SI = '1') then IABUSER_RI <= '0'        ;
    elsif (HOLD_SI   = '1') then IABUSER_RI <= IABUSER_RI ;
    else                         IABUSER_RI <= IABUSER_XI ;
    end if;

    if    (BUBBLE_SI = '1') then IAMALGN_RI <= '0'        ;
    elsif (HOLD_SI   = '1') then IAMALGN_RI <= IAMALGN_RI ;
    else                         IAMALGN_RI <= IAMALGN_XI ;
    end if;

    if    (BUBBLE_SI = '1') then IASVIOL_RI <= '0'        ;
    elsif (HOLD_SI   = '1') then IASVIOL_RI <= IASVIOL_RI ;
    else                         IASVIOL_RI <= IASVIOL_XI ;
    end if;

    if    (HOLD_SI   = '1') then PC_RI      <= PC_RI      ;
    else                         PC_RI      <= NEXTPC_RD  ;
    end if;

  end if;

end process;

	-- ### ------------------------------------------------------ ###
	-- #   assign registers (those related to a pipeline stage)	#
	-- #   Instruction Decode stage					#
	-- #								#
	-- #   nextpc :							#
	-- #     - in case of hardware events (reset, exception or	#
	-- #       interrupt) set the next address to a known value	#
	-- #       (reset or interrupt handler address). In other cases	#
	-- #       nextpc is considered as a data register.		#
	-- ### ------------------------------------------------------ ###

DEC_CYCLE : process (CK)
begin

  if (CK = '1' and CK'EVENT) then

    if    (BUBBLE_SD = '1') then I_RD       <= nop_i      ;
    elsif (HOLD_SD   = '1') then I_RD       <= I_RD       ;
    else                         I_RD       <= I_RI       ;
    end if;

    if    (BUBBLE_SD = '1') then I_TYPE_RD  <= nop_type   ;
    elsif (HOLD_SD   = '1') then I_TYPE_RD  <= I_TYPE_RD  ;
    else                         I_TYPE_RD  <= I_TYPE_SD  ;
    end if;

    if    (BUBBLE_SD = '1') then OPCOD_RD   <= sll_i      ;
    elsif (HOLD_SD   = '1') then OPCOD_RD   <= OPCOD_RD   ;
    else                         OPCOD_RD   <= OPCOD_SD   ;
    end if;

    if    (BUBBLE_SD = '1') then BDSLOT_RD  <= BDSLOT_RI  ;
    elsif (HOLD_SD   = '1') then BDSLOT_RD  <= BDSLOT_RD  ;
    else                         BDSLOT_RD  <= BDSLOT_RI  ;
    end if;

    if    (BUBBLE_SD = '1') then KILLED_RD  <= KILLED_SD  ;
    elsif (HOLD_SD   = '1') then KILLED_RD  <= KILLED_RD  ;
    else                         KILLED_RD  <= KILLED_SD  ;
    end if;

    if    (BUBBLE_SD = '1') then RS_RD      <= B"00000"   ;
    elsif (HOLD_SD   = '1') then RS_RD      <= RS_RD      ;
    else                         RS_RD      <= RS_SD      ;
    end if;

    if    (BUBBLE_SD = '1') then RT_RD      <= B"00000"   ;
    elsif (HOLD_SD   = '1') then RT_RD      <= RT_RD      ;
    else                         RT_RD      <= RT_SD      ;
    end if;

    if    (BUBBLE_SD = '1') then RD_RD      <= B"00000"   ;
    elsif (HOLD_SD   = '1') then RD_RD      <= RD_RD      ;
    else                         RD_RD      <= EFFRD_SD   ;
    end if;

    if    (BUBBLE_SD = '1') then EFFHWRE_RD <= X"00000000";
    elsif (HOLD_SD   = '1') then EFFHWRE_RD <= EFFHWRE_RD ;
    else                         EFFHWRE_RD <= EFFHWRE_SD ;
    end if;

    if    (BUBBLE_SD = '1') then COP0D_RD   <= B"00000000";
    elsif (HOLD_SD   = '1') then COP0D_RD   <= COP0D_RD   ;
    else                         COP0D_RD   <= COP0D_SD   ;
    end if;

    if    (BUBBLE_SD = '1') then TRAP_RD    <= '0'        ;
    elsif (HOLD_SD   = '1') then TRAP_RD    <= TRAP_RD    ;
    else                         TRAP_RD    <= I_TRAP_SD  ;
    end if;

    if    (BUBBLE_SD = '1') then BREAK_RD   <= '0'        ;
    elsif (HOLD_SD   = '1') then BREAK_RD   <= BREAK_RD   ;
    else                         BREAK_RD   <= BREAK_XD   ;
    end if;

    if    (BUBBLE_SD = '1') then SYSCALL_RD <= '0'        ;
    elsif (HOLD_SD   = '1') then SYSCALL_RD <= SYSCALL_RD ;
    else                         SYSCALL_RD <= SYSCALL_XD ;
    end if;

    if    (BUBBLE_SD = '1') then RSVDINS_RD <= '0'        ;
    elsif (HOLD_SD   = '1') then RSVDINS_RD <= RSVDINS_RD ;
    else                         RSVDINS_RD <= RSVDINS_XD ;
    end if;

    if    (BUBBLE_SD = '1') then CPUNUSE_RD <= '0'        ;
    elsif (HOLD_SD   = '1') then CPUNUSE_RD <= CPUNUSE_RD ;
    else                         CPUNUSE_RD <= CPUNUSE_XD ;
    end if;

    if    (BUBBLE_SD = '1') then IABUSER_RD <= '0'        ;
    elsif (HOLD_SD   = '1') then IABUSER_RD <= IABUSER_RD ;
    else                         IABUSER_RD <= IABUSER_RI ;
    end if;

    if    (BUBBLE_SD = '1') then IAMALGN_RD <= '0'        ;
    elsif (HOLD_SD   = '1') then IAMALGN_RD <= IAMALGN_RD ;
    else                         IAMALGN_RD <= IAMALGN_RI ;
    end if;

    if    (BUBBLE_SD = '1') then IASVIOL_RD <= '0'        ;
    elsif (HOLD_SD   = '1') then IASVIOL_RD <= IASVIOL_RD ;
    else                         IASVIOL_RD <= IASVIOL_RI ;
    end if;

    if    (RESET_RX  = '1') then NEXTPC_RD  <= NEXTPC_XX  ;
    elsif (EXCRQ_XM  = '1') then NEXTPC_RD  <= NEXTPC_XM  ;
    elsif (KEEP_SD   = '1') then NEXTPC_RD  <= NEXTPC_RD  ;
    else                         NEXTPC_RD  <= NEXTPC_SD  ;
    end if;

    if    (HOLD_SD   = '1') then PC_RD      <= PC_RD      ;
    else                         PC_RD      <= PC_RI      ;
    end if;

    if    (KEEP_SD   = '1') then SOPER_RD   <= SOPER_SE   ;
    else                         SOPER_RD   <= SOPER_SD   ;
    end if;

    if    (KEEP_SD   = '1') then TOPER_RD   <= TOPER_SE   ;
    else                         TOPER_RD   <= TOPER_SD   ;
    end if;

    if    (KEEP_SD   = '1') then IOPER_RD   <= IOPER_RD   ;
    else                         IOPER_RD   <= IOPER_SD   ;
    end if;

    if    (KEEP_SD   = '1') then SHAM_RD    <= SHAM_RD    ;
    else                         SHAM_RD    <= SHAM_SD    ;
    end if;

    if    (KEEP_SD   = '1') then CPNBR_RD   <= CPNBR_RD   ;
    else                         CPNBR_RD   <= CPNBR_XD   ;
    end if;

  end if;

end process;

	-- ### ------------------------------------------------------ ###
	-- #   assign registers (those related to a pipeline stage)	#
	-- #   Execute stage						#
	-- ### ------------------------------------------------------ ###

EXE_CYCLE : process (CK)
begin

  if (CK = '1' and CK'EVENT) then

    if    (BUBBLE_SE = '1') then I_RE       <= nop_i      ;
    elsif (HOLD_SE   = '1') then I_RE       <= I_RE       ;
    else                         I_RE       <= I_RD       ;
    end if;

    if    (BUBBLE_SE = '1') then I_TYPE_RE  <= nop_type   ;
    elsif (HOLD_SE   = '1') then I_TYPE_RE  <= I_TYPE_RE  ;
    else                         I_TYPE_RE  <= I_TYPE_RD  ;
    end if;

    if    (BUBBLE_SE = '1') then OPCOD_RE   <= sll_i      ;
    elsif (HOLD_SE   = '1') then OPCOD_RE   <= OPCOD_RE   ;
    else                         OPCOD_RE   <= OPCOD_RD   ;
    end if;

    if    (BUBBLE_SE = '1') then BDSLOT_RE  <= BDSLOT_RD  ;
    elsif (HOLD_SE   = '1') then BDSLOT_RE  <= BDSLOT_RE  ;
    else                         BDSLOT_RE  <= BDSLOT_RD  ;
    end if;

    if    (BUBBLE_SE = '1') then RT_RE      <= B"00000"   ;
    elsif (HOLD_SE   = '1') then RT_RE      <= RT_RE      ;
    else                         RT_RE      <= RT_RD      ;
    end if;

    if    (BUBBLE_SE = '1') then RD_RE      <= B"00000"   ;
    elsif (HOLD_SE   = '1') then RD_RE      <= RD_RE      ;
    else                         RD_RE      <= RD_SE      ;
    end if;

    if    (BUBBLE_SE = '1') then COP0D_RE   <= B"00000000";
    elsif (HOLD_SE   = '1') then COP0D_RE   <= COP0D_RE   ;
    else                         COP0D_RE   <= COP0D_RD   ;
    end if;

    if    (BUBBLE_SE = '1') then OVRF_RE    <= '0'        ;
    elsif (HOLD_SE   = '1') then OVRF_RE    <= OVRF_RE    ;
    else                         OVRF_RE    <= OVRF_XE    ;
    end if;

    if    (BUBBLE_SE = '1') then IRQ_RE     <= '1'        ;
    elsif (HOLD_SE   = '1') then IRQ_RE     <= IRQ_RE     ;
    else                         IRQ_RE     <= IRQ_SE     ;
    end if;

    if    (BUBBLE_SE = '1') then DRQ_RE     <= '0'        ;
    elsif (HOLD_SE   = '1') then DRQ_RE     <= DRQ_RE     ;
    else                         DRQ_RE     <= DRQ_SE     ;
    end if;

    if    (BUBBLE_SE = '1') then DRSTLK_RE  <= '0'        ;
    elsif (HOLD_SE   = '1') then DRSTLK_RE  <= DRSTLK_RE  ;
    else                         DRSTLK_RE  <= DRSTLK_SE  ;
    end if;

    if    (BUBBLE_SE = '1') then DSYNC_RE   <= '0'        ;
    elsif (HOLD_SE   = '1') then DSYNC_RE   <= DSYNC_RE   ;
    else                         DSYNC_RE   <= DSYNC_SE   ;
    end if;

    if    (BUBBLE_SE = '1') then DCACHE_RE  <= '0'        ;
    elsif (HOLD_SE   = '1') then DCACHE_RE  <= DCACHE_RE  ;
    else                         DCACHE_RE  <= DCACHE_SE  ;
    end if;

    if    (BUBBLE_SE = '1') then BYTSEL_RE  <= B"0000"    ;
    elsif (HOLD_SE   = '1') then BYTSEL_RE  <= BYTSEL_RE  ;
    else                         BYTSEL_RE  <= BYTSEL_SE  ;
    end if;

    if    (BUBBLE_SE = '1') then WRITE_RE   <= '0'        ;
    elsif (HOLD_SE   = '1') then WRITE_RE   <= WRITE_RE   ;
    else                         WRITE_RE   <= WRITE_SE   ;
    end if;

    if    (BUBBLE_SE = '1') then READ_RE    <= '0'        ;
    elsif (HOLD_SE   = '1') then READ_RE    <= READ_RE    ;
    else                         READ_RE    <= READ_SE    ;
    end if;

    if    (BUBBLE_SE = '1') then IAMALGN_RE <= '0'        ;
    elsif (HOLD_SE   = '1') then IAMALGN_RE <= IAMALGN_RE ;
    else                         IAMALGN_RE <= IAMALGN_RD ;
    end if;

    if    (BUBBLE_SE = '1') then IASVIOL_RE <= '0'        ;
    elsif (HOLD_SE   = '1') then IASVIOL_RE <= IASVIOL_RE ;
    else                         IASVIOL_RE <= IASVIOL_RD ;
    end if;

    if    (BUBBLE_SE = '1') then LAMALGN_RE <= '0'        ;
    elsif (HOLD_SE   = '1') then LAMALGN_RE <= LAMALGN_RE ;
    else                         LAMALGN_RE <= LAMALGN_XE ;
    end if;

    if    (BUBBLE_SE = '1') then LASVIOL_RE <= '0'        ;
    elsif (HOLD_SE   = '1') then LASVIOL_RE <= LASVIOL_RE ;
    else                         LASVIOL_RE <= LASVIOL_XE ;
    end if;

    if    (BUBBLE_SE = '1') then SAMALGN_RE <= '0'        ;
    elsif (HOLD_SE   = '1') then SAMALGN_RE <= SAMALGN_RE ;
    else                         SAMALGN_RE <= SAMALGN_XE ;
    end if;

    if    (BUBBLE_SE = '1') then SASVIOL_RE <= '0'        ;
    elsif (HOLD_SE   = '1') then SASVIOL_RE <= SASVIOL_RE ;
    else                         SASVIOL_RE <= SASVIOL_XE ;
    end if;

    if    (BUBBLE_SE = '1') then IABUSER_RE <= '0'        ;
    elsif (HOLD_SE   = '1') then IABUSER_RE <= IABUSER_RE ;
    else                         IABUSER_RE <= IABUSER_RD ;
    end if;

    if    (BUBBLE_SE = '1') then TRAP_RE    <= '0'        ;
    elsif (HOLD_SE   = '1') then TRAP_RE    <= TRAP_RE    ;
    else                         TRAP_RE    <= TRAP_XE    ;
    end if;

    if    (BUBBLE_SE = '1') then BREAK_RE   <= '0'        ;
    elsif (HOLD_SE   = '1') then BREAK_RE   <= BREAK_RE   ;
    else                         BREAK_RE   <= BREAK_RD   ;
    end if;

    if    (BUBBLE_SE = '1') then SYSCALL_RE <= '0'        ;
    elsif (HOLD_SE   = '1') then SYSCALL_RE <= SYSCALL_RE ;
    else                         SYSCALL_RE <= SYSCALL_RD ;
    end if;

    if    (BUBBLE_SE = '1') then RSVDINS_RE <= '0'        ;
    elsif (HOLD_SE   = '1') then RSVDINS_RE <= RSVDINS_RE ;
    else                         RSVDINS_RE <= RSVDINS_RD ;
    end if;

    if    (BUBBLE_SE = '1') then CPUNUSE_RE <= '0'        ;
    elsif (HOLD_SE   = '1') then CPUNUSE_RE <= CPUNUSE_RE ;
    else                         CPUNUSE_RE <= CPUNUSE_RD ;
    end if;

    if    (BUBBLE_SE = '1') then EARLYEX_RE <= '0'        ;
    elsif (HOLD_SE   = '1') then EARLYEX_RE <= EARLYEX_RE ;
    else                         EARLYEX_RE <= EARLYEX_XE ;
    end if;

    if    (BUBBLE_SE = '1') then ZMINV_RE   <= '0'        ;
    elsif (HOLD_SE   = '1') then ZMINV_RE   <= ZMINV_RE   ;
    else                         ZMINV_RE   <= ZMINV_SE   ;
    end if;

    if    (BUBBLE_SE = '1') then MIC_RE     <= exe_end    ;
    elsif (HOLD_SE   = '1') then MIC_RE     <= MIC_RE     ;
    else                         MIC_RE     <= NEXTMIC_SE ;
    end if;

    if    (BUBBLE_SE = '1') then MICEND_RE  <= '1'        ;
    elsif (HOLD_SE   = '1') then MICEND_RE  <= MICEND_RE  ;
    else                         MICEND_RE  <= MICEND_SE  ;
    end if;

    if    (BUBBLE_SE = '1') then MICLST_RE  <= '0'        ;
    elsif (HOLD_SE   = '1') then MICLST_RE  <= MICLST_RE  ;
    else                         MICLST_RE  <= MICLST_SE  ;
    end if;

    if    (HOLD_SE   = '1') then PC_RE      <= PC_RE      ;
    else                         PC_RE      <= PC_RD      ;
    end if;

    if    (KEEP_SE   = '1') then NEXTPC_RE  <= NEXTPC_RE  ;
    else                         NEXTPC_RE  <= NEXTPC_RD  ;
    end if;

    if    (KEEP_SE   = '1') then RES_RE     <= RES_RE     ;
    else                         RES_RE     <= RES_SE     ;
    end if;

    if    (KEEP_SE   = '1') then DATA_RE    <= DATA_RE    ;
    else                         DATA_RE    <= DATA_SE    ;
    end if;

    if    (KEEP_SE   = '1') then CPNBR_RE   <= CPNBR_RE   ;
    else                         CPNBR_RE   <= CPNBR_RD   ;
    end if;

    if    (KEEP_SE   = '1') then C05MUL1_RE <= C05MUL1_RE ;
    else                         C05MUL1_RE <= C05MUL1_SE ;
    end if;

    if    (KEEP_SE   = '1') then C07MUL1_RE <= C07MUL1_RE ;
    else                         C07MUL1_RE <= C07MUL1_SE ;
    end if;

    if    (KEEP_SE   = '1') then S00MUL2_RE <= S00MUL2_RE ;
    else                         S00MUL2_RE <= S00MUL2_SE ;
    end if;

    if    (KEEP_SE   = '1') then S01MUL2_RE <= S01MUL2_RE ;
    else                         S01MUL2_RE <= S01MUL2_SE ;
    end if;

    if    (KEEP_SE   = '1') then S02MUL2_RE <= S02MUL2_RE ;
    else                         S02MUL2_RE <= S02MUL2_SE ;
    end if;

    if    (KEEP_SE   = '1') then S03MUL2_RE <= S03MUL2_RE ;
    else                         S03MUL2_RE <= S03MUL2_SE ;
    end if;

    if    (KEEP_SE   = '1') then S04MUL2_RE <= S04MUL2_RE ;
    else                         S04MUL2_RE <= S04MUL2_SE ;
    end if;

    if    (KEEP_SE   = '1') then C00MUL2_RE <= C00MUL2_RE ;
    else                         C00MUL2_RE <= C00MUL2_SE ;
    end if;

    if    (KEEP_SE   = '1') then C01MUL2_RE <= C01MUL2_RE ;
    else                         C01MUL2_RE <= C01MUL2_SE ;
    end if;

    if    (KEEP_SE   = '1') then C02MUL2_RE <= C02MUL2_RE ;
    else                         C02MUL2_RE <= C02MUL2_SE ;
    end if;

    if    (KEEP_SE   = '1') then C03MUL2_RE <= C03MUL2_RE ;
    else                         C03MUL2_RE <= C03MUL2_SE ;
    end if;

    if    (KEEP_SE   = '1') then C04MUL2_RE <= C04MUL2_RE ;
    else                         C04MUL2_RE <= C04MUL2_SE ;
    end if;

    if    (KEEP_SE   = '1') then DIVX_RE    <= DIVX_RE    ;
    else                         DIVX_RE    <= DIVX_SE    ;
    end if;

    if    (KEEP_SE   = '1') then DIVXCLZ_RE <= DIVXCLZ_RE ;
    else                         DIVXCLZ_RE <= DIVXCLZ_SE ;
    end if;

    if    (KEEP_SE   = '1') then DIVY_RE    <= DIVY_RE    ;
    else                         DIVY_RE    <= DIVY_SE    ;
    end if;

    if    (KEEP_SE   = '1') then DIVYCLZ_RE <= DIVYCLZ_RE ;
    else                         DIVYCLZ_RE <= DIVYCLZ_SE ;
    end if;

    if    (KEEP_SE   = '1') then DIVQ_RE    <= DIVQ_RE    ;
    else                         DIVQ_RE    <= DIVQ_SE    ;
    end if;

  end if;

end process;

REDOPC : process (CK)
begin

  if (CK = '1' and CK'EVENT) then

    if    (KEEP_SE     = '1') then REDOPC_RE  <= REDOPC_RE   ;
    elsif (WREDOPC_SE  = '0') then REDOPC_RE  <= REDOPC_RE   ;
    else                           REDOPC_RE  <= PC_RD       ;
    end if;

  end if;

end process;

	-- ### ------------------------------------------------------ ###
	-- #   assign registers (those related to a pipeline stage)	#
	-- #   Memory Access stage					#
	-- ### ------------------------------------------------------ ###

MEM_CYCLE : process (CK)
begin

  if (CK = '1' and CK'EVENT) then

    if    (BUBBLE_SM = '1') then I_RM       <= nop_i      ;
    elsif (HOLD_SM   = '1') then I_RM       <= I_RM       ;
    else                         I_RM       <= I_RE       ;
    end if;

    if    (BUBBLE_SM = '1') then DREAD_RM   <= '0'        ;
    elsif (HOLD_SM   = '1') then DREAD_RM   <= '0'        ;
    else                         DREAD_RM   <= READ_RE    ;
    end if;

    if    (BUBBLE_SM = '1') then I_TYPE_RM  <= nop_type   ;
    elsif (HOLD_SM   = '1') then I_TYPE_RM  <= I_TYPE_RM  ;
    else                         I_TYPE_RM  <= I_TYPE_RE  ;
    end if;

    if    (BUBBLE_SM = '1') then RD_RM      <= B"00000"   ;
    elsif (HOLD_SM   = '1') then RD_RM      <= RD_RM      ;
    else                         RD_RM      <= RD_SM      ;
    end if;

    if    (BUBBLE_SM = '1') then OPCOD_RM   <= sll_i      ;
    elsif (HOLD_SM   = '1') then OPCOD_RM   <= OPCOD_RM   ;
    else                         OPCOD_RM   <= OPCOD_RE   ;
    end if;

    if    (BUBBLE_SM = '1') then ZMINV_RM   <= '0'        ;
    elsif (HOLD_SM   = '1') then ZMINV_RM   <= ZMINV_RM   ;
    else                         ZMINV_RM   <= ZMINV_RE   ;
    end if;

    if    (KEEP_SM   = '1') then S00MUL7_RM <= S00MUL7_RM ;
    else                         S00MUL7_RM <= S00MUL7_SM ;
    end if;

    if    (KEEP_SM   = '1') then C00MUL7_RM <= C00MUL7_RM ;
    else                         C00MUL7_RM <= C00MUL7_SM ;
    end if;

    if    (KEEP_SM   = '1') then DATA_RM    <= DATA_RM    ;
    else                         DATA_RM    <= DATA_SM    ;
    end if;

    if    (KEEP_SM   = '1') then DIVQ_RM    <= DIVQ_RM    ;
    else                         DIVQ_RM    <= DIVQ_RE    ;
    end if;

    if    (KEEP_SM   = '1') then DIVR_RM    <= DIVR_RM    ;
    else                         DIVR_RM    <= DIVX_RE    ;
    end if;

  end if;

end process;

	-- ### ------------------------------------------------------ ###
	-- #   assign the coprocessor zero's registers :		#
	-- #								#
	-- #     -  Bad Virtual Address register			#
	-- #     -  Exception Base register				#
	-- #     -  Cause register					#
	-- #     -  Exception Program Counter				#
	-- #     -  Error Exception Program Counter			#
	-- #     -  Status register					#
	-- ### ------------------------------------------------------ ###

COP0_REGISTERS : process (CK)
begin

  if (CK = '1' and CK'EVENT) then

    if    (WBADDA_XM  = '1'                  ) then BADVA_RX   <= RES_RE    ;
    elsif (WBADIA_XM  = '1'                  ) then BADVA_RX   <= NEXTPC_RE ;
    else                                            BADVA_RX   <= BADVA_RX  ;
    end if;

    if    (WEBASE_XX  = '1'                  ) then EBASE_RM   <= EBASE_XX  ;
    elsif (WEBASE_SM  = '1' and KEEP_SM = '0') then EBASE_RM   <= EBASE_SM  ;
    else                                            EBASE_RM   <= EBASE_RM  ;
    end if;

    if    (WCAUSE_XX  = '1'                  ) then CAUSE_RX   <= CAUSE_XX  ;
    elsif (WCAUSE_XM  = '1'                  ) then CAUSE_RX   <= CAUSE_XM  ;
    elsif (WCAUSE_SM  = '1' and KEEP_SM = '0') then CAUSE_RX   <= CAUSE_SM  ;
    else                                            CAUSE_RX   <= CAUSE_SX  ;
    end if;

    if    (WEPC_XM    = '1'                  ) then EPC_RX     <= EPC_XM    ;
    elsif (WEPC_SM    = '1' and KEEP_SM = '0') then EPC_RX     <= EPC_SM    ;
    else                                            EPC_RX     <= EPC_RX    ;
    end if;

    if    (WEEPC_XX   = '1'                  ) then EEPC_RX    <= EEPC_XX   ;
    elsif (WEEPC_SM   = '1' and KEEP_SM = '0') then EEPC_RX    <= EEPC_SM   ;
    else                                            EEPC_RX    <= EEPC_RX   ;
    end if;

    if    (WCOUNT_SM  = '1' and KEEP_SM = '0') then COUNT_RX   <= COUNT_SM  ;
    elsif (WCOUNT_SX  = '1'                  ) then COUNT_RX   <= COUNT_SX  ;
    else                                            COUNT_RX   <= COUNT_RX  ;
    end if;

    if    (WTCCTX_SM  = '1' and KEEP_SM = '0') then TCCTX_RM   <= TCCTX_SM  ;
    else                                            TCCTX_RM   <= TCCTX_RM  ;
    end if;

    if    (WUSRLCL_SM = '1' and KEEP_SM = '0') then USRLCL_RM  <= RES_RE    ;
    else                                            USRLCL_RM  <= USRLCL_RM ;
    end if;

    if    (WHWRENA_SM = '1' and KEEP_SM = '0') then HWRENA_RM  <= RES_RE    ;
    else                                            HWRENA_RM  <= HWRENA_RM ;
    end if;

    if    (WSR_XX     = '1'                  ) then STATUS_RX  <= STATUS_XX ;
    elsif (WSR_XM     = '1'                  ) then STATUS_RX  <= STATUS_XM ;
    elsif (WSR_SM     = '1' and KEEP_SM = '0') then STATUS_RX  <= STATUS_SM ;
    else                                            STATUS_RX  <= STATUS_RX ;
    end if;

  end if;

end process;

	-- ### ------------------------------------------------------ ###
	-- #   assign registers (those related to a pipeline stage)	#
	-- #   Write Back stage						#
	-- #								#
	-- #     - LO      register					#
	-- #     - HI      register					#
	-- #     - integer registers					#
	-- ### ------------------------------------------------------ ###

WBK_CYCLE : process (CK)
begin

  if (CK = '1' and CK'EVENT) then

    if    (I_WLO_SW = '1'     and KEEP_SW = '0') then LO_RW      <= LO_SW   ;
    else                                              LO_RW      <= LO_RW   ;
    end if;

    if    (I_WHI_SW = '1'     and KEEP_SW = '0') then HI_RW      <= HI_SW   ;
    else                                              HI_RW      <= HI_RW   ;
    end if;

    if    (RD_RM    = "00001" and KEEP_SW = '0') then R1_RW      <= DATA_SW ;
    else                                              R1_RW      <= R1_RW   ;
    end if;

    if    (RD_RM    = "00010" and KEEP_SW = '0') then R2_RW      <= DATA_SW ;
    else                                              R2_RW      <= R2_RW   ;
    end if;

    if    (RD_RM    = "00011" and KEEP_SW = '0') then R3_RW      <= DATA_SW ;
    else                                              R3_RW      <= R3_RW   ;
    end if;

    if    (RD_RM    = "00100" and KEEP_SW = '0') then R4_RW      <= DATA_SW ;
    else                                              R4_RW      <= R4_RW   ;
    end if;

    if    (RD_RM    = "00101" and KEEP_SW = '0') then R5_RW      <= DATA_SW ;
    else                                              R5_RW      <= R5_RW   ;
    end if;

    if    (RD_RM    = "00110" and KEEP_SW = '0') then R6_RW      <= DATA_SW ;
    else                                              R6_RW      <= R6_RW   ;
    end if;

    if    (RD_RM    = "00111" and KEEP_SW = '0') then R7_RW      <= DATA_SW ;
    else                                              R7_RW      <= R7_RW   ;
    end if;

    if    (RD_RM    = "01000" and KEEP_SW = '0') then R8_RW      <= DATA_SW ;
    else                                              R8_RW      <= R8_RW   ;
    end if;

    if    (RD_RM    = "01001" and KEEP_SW = '0') then R9_RW      <= DATA_SW ;
    else                                              R9_RW      <= R9_RW   ;
    end if;

    if    (RD_RM    = "01010" and KEEP_SW = '0') then R10_RW     <= DATA_SW ;
    else                                              R10_RW     <= R10_RW  ;
    end if;

    if    (RD_RM    = "01011" and KEEP_SW = '0') then R11_RW     <= DATA_SW ;
    else                                              R11_RW     <= R11_RW  ;
    end if;

    if    (RD_RM    = "01100" and KEEP_SW = '0') then R12_RW     <= DATA_SW ;
    else                                              R12_RW     <= R12_RW  ;
    end if;

    if    (RD_RM    = "01101" and KEEP_SW = '0') then R13_RW     <= DATA_SW ;
    else                                              R13_RW     <= R13_RW  ;
    end if;

    if    (RD_RM    = "01110" and KEEP_SW = '0') then R14_RW     <= DATA_SW ;
    else                                              R14_RW     <= R14_RW  ;
    end if;

    if    (RD_RM    = "01111" and KEEP_SW = '0') then R15_RW     <= DATA_SW ;
    else                                              R15_RW     <= R15_RW  ;
    end if;

    if    (RD_RM    = "10000" and KEEP_SW = '0') then R16_RW     <= DATA_SW ;
    else                                              R16_RW     <= R16_RW  ;
    end if;

    if    (RD_RM    = "10001" and KEEP_SW = '0') then R17_RW     <= DATA_SW ;
    else                                              R17_RW     <= R17_RW  ;
    end if;

    if    (RD_RM    = "10010" and KEEP_SW = '0') then R18_RW     <= DATA_SW ;
    else                                              R18_RW     <= R18_RW  ;
    end if;

    if    (RD_RM    = "10011" and KEEP_SW = '0') then R19_RW     <= DATA_SW ;
    else                                              R19_RW     <= R19_RW  ;
    end if;

    if    (RD_RM    = "10100" and KEEP_SW = '0') then R20_RW     <= DATA_SW ;
    else                                              R20_RW     <= R20_RW  ;
    end if;

    if    (RD_RM    = "10101" and KEEP_SW = '0') then R21_RW     <= DATA_SW ;
    else                                              R21_RW     <= R21_RW  ;
    end if;

    if    (RD_RM    = "10110" and KEEP_SW = '0') then R22_RW     <= DATA_SW ;
    else                                              R22_RW     <= R22_RW  ;
    end if;

    if    (RD_RM    = "10111" and KEEP_SW = '0') then R23_RW     <= DATA_SW ;
    else                                              R23_RW     <= R23_RW  ;
    end if;

    if    (RD_RM    = "11000" and KEEP_SW = '0') then R24_RW     <= DATA_SW ;
    else                                              R24_RW     <= R24_RW  ;
    end if;

    if    (RD_RM    = "11001" and KEEP_SW = '0') then R25_RW     <= DATA_SW ;
    else                                              R25_RW     <= R25_RW  ;
    end if;

    if    (RD_RM    = "11010" and KEEP_SW = '0') then R26_RW     <= DATA_SW ;
    else                                              R26_RW     <= R26_RW  ;
    end if;

    if    (RD_RM    = "11011" and KEEP_SW = '0') then R27_RW     <= DATA_SW ;
    else                                              R27_RW     <= R27_RW  ;
    end if;

    if    (RD_RM    = "11100" and KEEP_SW = '0') then R28_RW     <= DATA_SW ;
    else                                              R28_RW     <= R28_RW  ;
    end if;

    if    (RD_RM    = "11101" and KEEP_SW = '0') then R29_RW     <= DATA_SW ;
    else                                              R29_RW     <= R29_RW  ;
    end if;

    if    (RD_RM    = "11110" and KEEP_SW = '0') then R30_RW     <= DATA_SW ;
    else                                              R30_RW     <= R30_RW  ;
    end if;

    if    (RD_RM    = "11111" and KEEP_SW = '0') then R31_RW     <= DATA_SW ;
    else                                              R31_RW     <= R31_RW  ;
    end if;

  end if;

end process;

	-- ### ------------------------------------------------------ ###
	-- #   assign registers (those directly controled by hardware)	#
	-- ### ------------------------------------------------------ ###

MISCELLANEOUS : process (CK)
begin

  if (CK = '1' and CK'EVENT) then

    RESET_RX   <= not RESET_N   ;
    HWSWIT_RX  <=     HWSWIT_XX ;
    INTRQ_RX   <=     INTRQ_XX  ;

    if    (RESET_RX = '0') then MCHECK_RX  <= not MCHECK_N ;
    else                        MCHECK_RX  <= '0'          ;
    end if;

    MCHECKX_RX <=     MCHECKX_XX ;
  end if;

end process;

	-- ### ------------------------------------------------------ ###
	-- #   assign outputs (instruction access) :			#
        -- #     - access request					#
        -- #     - bus error enable					#
	-- ### ------------------------------------------------------ ###

I_RQ       <= '1'                     when (BUBBLE_SE     = '1') else
              IRQ_RE                  when (HOLD_SE       = '1') else
              IRQ_SE                  ;

I_BEREN    <= IBEREN_SX ;

	-- ### ------------------------------------------------------ ###
	-- #   assign outputs (instruction access) :			#
	-- #     - address						#
	-- ### ------------------------------------------------------ ###

I_A        <= NEXTPC_XX (31 downto 2) when (RESET_RX      = '1') else
              NEXTPC_XM (31 downto 2) when (EXCRQ_XM      = '1') else
              NEXTPC_RD (31 downto 2) when (KEEP_SD       = '1') else
              NEXTPC_SD (31 downto 2) ;

	-- ### ------------------------------------------------------ ###
	-- #   assign outputs (instruction access) :			#
        -- #     - in cache line access					#
	-- ### ------------------------------------------------------ ###

I_INLINE   <= '0'                     when (RESET_RX      = '1') else
              '0'                     when (EXCRQ_XM      = '1') else
              '0'                     when (KEEP_SD       = '1') else
              IINLIN_SD               ;

	-- ### ------------------------------------------------------ ###
	-- #   assign outputs (instruction access) :			#
	-- #     - access mode : 00 : Kernel				#
	-- #                     01 : Supervisor			#
	-- #                     10 : User				#
	-- ### ------------------------------------------------------ ###

I_MODE     <= B"00"                   when (STATUS_RX (1) = '1') else
              B"00"                   when (STATUS_RX (2) = '1') else
              STATUS_RX ( 4 downto 3) ;

	-- ### ------------------------------------------------------ ###
	-- #   assign outputs (instruction access)			#
	-- #								#
	-- #     - the acknowledge signals to the cache that the	#
	-- #       instruction send by the memory has been received by	#
	-- #       processor						#
	-- ### ------------------------------------------------------ ###

I_ACK      <= IREAD_RI;

	-- ### ------------------------------------------------------ ###
	-- #   assign outputs (data access)				#
	-- #     - address						#
	-- #     - output data to the memory				#
	-- #     - read or write access					#
	-- #     - byte select						#
	-- ### ------------------------------------------------------ ###

D_A        <= RES_RE    (31 downto 2) when (KEEP_SE       = '1') else
              RARITH_SE (31 downto 2) ;

D_OUT      <= DATA_RE                 when (KEEP_SE       = '1') else
              DATA_SE                 ;

D_RW       <= '1'                     when (BUBBLE_SE     = '1') else
              not WRITE_RE            when (HOLD_SE       = '1') else
              not WRITE_SE            ;

D_BYTSEL   <= B"0000"                 when (BUBBLE_SE     = '1') else
              BYTSEL_RE               when (HOLD_SE       = '1') else
              BYTSEL_SE               ;

	-- ### ------------------------------------------------------ ###
	-- #   assign outputs (data access) :				#
        -- #     - data access request					#
	-- #     - reset "load linked" reservations			#
	-- #     - synchronize						#
	-- #     - cache operation					#
	-- ### ------------------------------------------------------ ###

D_RQ       <= '0'                     when (BUBBLE_SE     = '1') else
              DRQ_RE                  when (HOLD_SE       = '1') else
              DRQ_SE                  ;

D_RSTLKD   <= '0'                     when (BUBBLE_SE     = '1') else
              DRSTLK_RE               when (HOLD_SE       = '1') else
              DRSTLK_SE               ;

D_SYNC     <= '0'                     when (BUBBLE_SE     = '1') else
              DSYNC_RE                when (HOLD_SE       = '1') else
              DSYNC_SE                ;

D_CACHE    <= '0'                     when (BUBBLE_SE     = '1') else
              DCACHE_RE               when (HOLD_SE       = '1') else
              DCACHE_SE               ;

	-- ### ------------------------------------------------------ ###
	-- #   assign outputs (data access) :				#
	-- #								#
	-- #     - "load linked" access					#
	-- #     - external registers' access				#
	-- #     - cache operation's code				#
	-- ### ------------------------------------------------------ ###

D_LINKED   <= '0'                     when (BUBBLE_SE     = '1') else
              I_LINKD_SM              when (HOLD_SE       = '1') else
              I_LINKD_SE              ;

D_REG      <= '0'                     when (BUBBLE_SE     = '1') else
              I_XREG_SM               when (HOLD_SE       = '1') else
              I_XREG_SE               ;

D_CACHOP   <= CACHOP_SM               when (KEEP_SE       = '1') else
              CACHOP_SE               ;

	-- ### ------------------------------------------------------ ###
	-- #   assign outputs (data access) :				#
	-- #								#
	-- #     - access mode : 00 : Kernel				#
	-- #                     01 : Supervisor			#
	-- #                     10 : User				#
	-- ### ------------------------------------------------------ ###

D_MODE     <= B"00"                   when (STATUS_RX (1) = '1') else
              B"00"                   when (STATUS_RX (2) = '1') else
              STATUS_RX ( 4 downto 3) ;

	-- ### ------------------------------------------------------ ###
	-- #   assign outputs (data access - read acknowledge)		#
	-- #								#
	-- #     - the acknowledge signals to the memory that the data	#
	-- #       send by the memory has been received by the		#
	-- #       processor						#
	-- ### ------------------------------------------------------ ###

D_ACK      <= DREAD_RM;

	-- ### ------------------------------------------------------ ###
	-- #   assign outputs (miscellaneous)				#
	-- ### ------------------------------------------------------ ###

SCOUT      <= '0';

end;
