#!/usr/bin/env python

from stratus import *

class mips_r3000_1m_dp ( Model ):

  def Interface (self) :

    self.ck          = SignalIn("ck",            1)  # external clock
    
   #self.i_a         = SignalOut("i_a",         32)  # inst address
    self.i           = SignalIn("i",            32)  # instruction
     
   #self.d_a         = SignalOut("d_a",         32)  # data address
    self.d_in        = SignalIn("d_in",         32)  # data (input )
    self.d_out       = SignalOut("d_out",       32)  # data (output)
                             
    self.addr        = SignalOut("addr",        32)  # data (outaddr)
    
    self.rsdnbr_sd   = SignalIn("rsdnbr_sd",    32)  # source reg nbr
    self.rtdnbr_sd   = SignalIn("rtdnbr_sd",    32)  # source reg nbr
    
    self.hz_sdm_sd   = SignalIn("hz_sdm_sd",     1)  # s = d(i-2)
    self.hz_sdmw_sd  = SignalIn("hz_sdmw_sd",    1)  # s = d(i-3,i-2)
    self.hz_tdm_sd   = SignalIn("hz_tdm_sd",     1)  # t = d(i-2)
    self.hz_tdmw_sd  = SignalIn("hz_tdmw_sd",    1)  # t = d(i-3,i-2)
    self.hz_sdm_se   = SignalIn("hz_sdm_se",     1)  # s = d(i-1)
    self.hz_sdmw_se  = SignalIn("hz_sdmw_se",    1)  # s = d(i-2,i-1)
    self.hz_tdm_se   = SignalIn("hz_tdm_se",     1)  # t = d(i-1)
    self.hz_tdmw_se  = SignalIn("hz_tdmw_se",    1)  # t = d(i-2,i-1)
                          
    self.i_jr_sd     = SignalIn("i_jr_sd",       1)  # jump register
    self.btaken_sd   = SignalIn("btaken_sd",     1)  # branch taken
    self.i_allj_sd   = SignalIn("i_allj_sd",     1)  # all jumps
    self.i_link_sd   = SignalIn("i_link_sd",     1)  # link inst
                            
    self.iopsel_sd   = SignalIn("iopsel_sd",     4)  # i oper select
                             
    self.imdsgn_sd   = SignalIn("imdsgn_sd",     1)  # signed operands
    self.i_rsgnd_se  = SignalIn("i_rsgnd_se",    1)  # signed result
                            
    self.i_ifmt_se   = SignalIn("i_ifmt_se",     1)  # i format
    self.i_oper_se   = SignalIn("i_oper_se",     7)  # alu operation
    self.i_logic_se  = SignalIn("i_logic_se",    2)  # logic operation
    self.i_sub_se    = SignalIn("i_sub_se",      1)  # subtract
    self.i_right_se  = SignalIn("i_right_se",    1)  # shift right
                            
    self.setbit_se   = SignalIn("setbit_se",     1)  # result for set
                            
    self.datext_sm   = SignalIn("datext_sm",     1)  # data extension
    self.bytsub_sm   = SignalIn("bytsub_sm",  3, 1)  # byte substitute
    self.daccess_sm  = SignalIn("daccess_sm",    1)  # data access
    self.read_sm     = SignalIn("read_sm",       1)  # read operation
                            
    self.bubble_si   = SignalIn("bubble_si",     1)  # introduce  bubble
    self.hold_si     = SignalIn("hold_si",       1)  # hold   the inst
    self.nothold_si  = SignalIn("nothold_si",    1)  # don't hold   the inst
    self.shift_si    = SignalIn("shift_si",      1)  # shift  new inst
    self.keep_si     = SignalIn("keep_si",       1)  # keep   the data
    self.load_si     = SignalIn("load_si",       1)  # load a new data
                            
    self.notstall_sd = SignalIn("notstall_sd",   1)  # 
    self.bubble_sd   = SignalIn("bubble_sd",     1)  # introduce bubble
    self.hold_sd     = SignalIn("hold_sd",       1)  # hold   the inst
    self.nothold_sd  = SignalIn("nothold_sd",    1)  # don't hold   the inst
    self.shift_sd    = SignalIn("shift_sd",      1)  # shift  new inst
    self.keep_sd     = SignalIn("keep_sd",       1)  # keep   the data
    self.load_sd     = SignalIn("load_sd",       1)  # load a new data
                            
    self.bubble_se   = SignalIn("bubble_se",     1)  # introduce bubble
    self.hold_se     = SignalIn("hold_se",       1)  # hold   the inst
    self.nothold_se  = SignalIn("nothold_se",    1)  # don't hold   the inst
    self.shift_se    = SignalIn("shift_se",      1)  # shift  new inst
    self.keep_se     = SignalIn("keep_se",       1)  # keep   the data
    self.load_se     = SignalIn("load_se",       1)  # load a new data
                            
    self.bubble_sm   = SignalIn("bubble_sm",     1)  # introduce bubble
    self.hold_sm     = SignalIn("hold_sm",       1)  # hold   the inst
    self.nothold_sm  = SignalIn("nothold_sm",    1)  # don't hold   the inst
    self.shift_sm    = SignalIn("shift_sm",      1)  # shift  new inst
    self.keep_sm     = SignalIn("keep_sm",       1)  # keep   the data
    self.load_sm     = SignalIn("load_sm",       1)  # load a new data
                            
    self.wreg_sw     = SignalIn("wreg_sw",      32)  # integer reg wen
    self.wredopc_se  = SignalIn("wredopc_se",    1)  # redopc write en
                            
    self.wlo_sw      = SignalIn("wlo_sw",        1)  # low reg write en
    self.whi_sw      = SignalIn("whi_sw",        1)  # high reg write en
                            
    self.wepc_xx     = SignalIn("wepc_xx",       1)  # epc write en
    self.wepc_xm     = SignalIn("wepc_xm",       1)  # epc write en
                            
    self.bootev_xx   = SignalIn("bootev_xx",     1)  # bootstrap exc
                             
    self.badia_xm    = SignalIn("badia_xm",      1)  # bad inst adr
    self.badda_xm    = SignalIn("badda_xm",      1)  # bad data adr
                            
    self.lui_sd      = SignalIn("lui_sd",        1)  # lui inst
                            
    self.shamt_se    = SignalIn("shamt_se",      5)  # shift amount
                            
    self.reset_xx    = SignalIn("reset_xx",      1)  # synchro reset
    self.wnxtpc_xx   = SignalIn("wnxtpc_xx",     1)  # nxt inst ad wen
                            
    self.sr_cr_sd    = SignalIn("sr_cr_sd",     32)  # status/cause
    self.be_sd       = SignalIn("be_sd",         1)  # bad ad reg/epc
    self.scbe_sd     = SignalIn("scbe_sd",       1)  # c0 reg selection
                            
    self.bdslot_se   = SignalIn("bdslot_se",     1)
    self.bdslot_sm   = SignalIn("bdslot_sm",     1)
                            
    self.carith_32_se= SignalOut("carith_32_se", 1)
    self.carith_31_se= SignalOut("carith_31_se", 1)
    self.rarith_31_se= SignalOut("rarith_31_se", 1)
    self.nextpc_1_se = SignalOut("nextpc_1_se",  1)
    self.nextpc_0_se = SignalOut("nextpc_0_se",  1)
    self.nextpc_31_se= SignalOut("nextpc_31_se", 1)
                            
    self.res_sm      = SignalOut("res_sm",      32)  #
                            
    self.s_31_sd     = SignalOut("s_31_sd",      1)  # s (31)
    self.s_eq_t_sd   = SignalOut("s_eq_t_sd",    1)  # s =  t
    self.s_eq_z_sd   = SignalOut("s_eq_z_sd",    1)  # s = 0
                            
    self.s_4_0_se    = SignalOut("s_4_0_se",     5)  # s (4 downto 0)
                            
    self.test        = SignalIn("test",          1)  # test mode
    self.scin        = SignalIn("scin",          1)  # scan in
    self.scout       = SignalOut("scout",        1)  # scan out
                            
    self.vdd         = VddIn("vdd")
    self.vss         = VssIn("vss")  
    return


  ### -------------------------------------------------------------- ###
  #   internal description - contains the following sections:          #
  #                                                                    #
  #      - internal Signal and register declarations                   #
  #      - constant declarations                                       #
  #      - instructions' table                                         #
  #      - Signals and registers expression                            #
  #                                                                    #
  #   note : each Signal or register is suffixed by two letters. the   #
  #          second letter identifies the pipe stage in which the      #
  #          Signal or the register is assigned:                       #
  #            - i : instruction fetch                                 #
  #            - d : instruction decode                                #
  #            - e : execute                                           #
  #            - m : memory access                                     #
  #            - w : write back                                        #
  #            - x : unknown - Signal not related to the execution of  #
  #                  an instruction                                    #
  #                                                                    #
  #         the first letter identifies the type of the Signal:        #
  #            - r : a register                                        #
  #            - s : Signal related to the normal execution            #
  #            - x : Signal related to the interrupt or exception      #
  #                  mechanisms                                        #
  ### -------------------------------------------------------------- ###

  def Netlist (self) :

   # Signal declaration
    i_ri        = Signal("i_ri",            32)    # reg_vector (31 downto 0) register #-- instruction reg
                                                                                       
    jadr_sd     = Signal("jadr_sd",         32)    # bit_vector (31 downto 0)          #-- next inst address
    badr_sd     = Signal("badr_sd",         32)    # bit_vector (31 downto 0)          #-- next inst address
    nextpc_sd   = Signal("nextpc_sd",       32)    # bit_vector (31 downto 0)          #-- next inst address
    nextpc_xx   = Signal("nextpc_xx",       32)    # bit_vector (31 downto 0)          #-- next inst adr (hw)
    nextpc_rd   = Signal("nextpc_rd",       32)    # reg_vector (31 downto 0) register #-- next inst address
    nextpc_re   = Signal("nextpc_re",       32)    # reg_vector (31 downto 0) register #-- next inst address
                                                                                       
    pc_ri       = Signal("pc_ri",           32)    # reg_vector (31 downto 0) register #-- instruction address
    pc_rd       = Signal("pc_rd",           32)    # reg_vector (31 downto 0) register #-- instruction address
    pc_re       = Signal("pc_re",           32)    # reg_vector (31 downto 0) register #-- instruction address
    redopc_re   = Signal("redopc_re",       32)    # reg_vector (31 downto 0) register #-- old inst address
                                                                                       
    s_sd        = Signal("s_sd",            32)    # bit_vector (31 downto 0)          #-- s from reg bank
    s_mw_sd     = Signal("s_mw_sd",         32)    # bit_vector (31 downto 0)          #-- effective s oper
    soper_sd    = Signal("soper_sd",        32)    # bit_vector (31 downto 0)          #-- effective s oper
    soper_rd    = Signal("soper_rd",        32)    # reg_vector (31 downto 0) register #-- effective s oper
                                                                                       
    t_sd        = Signal("t_sd",            32)    # bit_vector (31 downto 0)          #-- t from reg bank
    t_mw_sd     = Signal("t_mw_sd",         32)    # bit_vector (31 downto 0)          #-- effective t oper
    toper_sd    = Signal("toper_sd",        32)    # bit_vector (31 downto 0)          #-- effective t oper
    effto_sd    = Signal("effto_sd",        32)    # bit_vector (31 downto 0)          #-- effective t oper
    toper_rd    = Signal("toper_rd",        32)    # reg_vector (31 downto 0) register #-- effective t oper
                                                                                       
    s_mw_se     = Signal("s_mw_se",         32)    # bit_vector (31 downto 0)          #-- s operand
    soper_se    = Signal("soper_se",        32)    # bit_vector (31 downto 0)          #-- s operand
    t_mw_se     = Signal("t_mw_se",         32)    # bit_vector (31 downto 0)          #-- t operand
    toper_se    = Signal("toper_se",        32)    # bit_vector (31 downto 0)          #-- t operand
                                                                                       
    cop0op_sd   = Signal("cop0op_sd",       32)    # bit_vector (31 downto 0)          #-- cop 0 source opr
    br_epc_sd   = Signal("br_epc_sd",       32)    # bit_vector (31 downto 0)          #-- bad ad reg/epc
                                                                                       
    otheri_sd   = Signal("otheri_sd",       32)    # bit_vector (31 downto 0)          #-- immediate oper
    ioper_sd    = Signal("ioper_sd",        32)    # bit_vector (31 downto 0)          #-- eff immediate oper
    ioper_rd    = Signal("ioper_rd",        32)    # reg_vector (31 downto 0) register #-- eff immediate oper
                                                                                       
    s_cp_t_sd   = Signal("s_cp_t_sd",       32)    # bit_vector (31 downto 0)          #-- compare s & t
                                                                                       
    imdsex_sd   = Signal("imdsex_sd",       16)    # bit_vector (15 downto 0)          #-- offset extension
                                                                                       
    seqadr_sd   = Signal("seqadr_sd",       32)    # bit_vector (31 downto 0)          #-- sequential inst adr
                                                                                       
    braadr_sd   = Signal("braadr_sd",       32)    # bit_vector (31 downto 0)          #-- branch address
                                                                                       
    lo_rw       = Signal("lo_rw",           32)    # reg_vector (31 downto 0) register #-- low register
    hi_rw       = Signal("hi_rw",           32)    # reg_vector (31 downto 0) register #-- high register
    rarith_se   = Signal("rarith_se",       32)    # bit_vector (31 downto 0)          #-- result of arithm
                                                                                       
   #xoper_se    = Signal("xoper_se",        32)    # bit_vector (31 downto 0)          #-- effective x operand VBE
    yoper_se    = Signal("yoper_se",        32)    # bit_vector (31 downto 0)          #-- effective y operand
                                                                                       
    rshift_se   = Signal("rshift_se",       32)    # bit_vector (31 downto 0)          #-- shifter's result
                                                                                       
    and_se      = Signal("and_se",          32)    # bit_vector (31 downto 0)          #-- logic oper. result
    or_se       = Signal("or_se",           32)    # bit_vector (31 downto 0)          #-- logic oper. result
    xor_se      = Signal("xor_se",          32)    # bit_vector (31 downto 0)          #-- logic oper. result
    ornor_se    = Signal("ornor_se",        32)    # bit_vector (31 downto 0)          #-- logic oper. result
    andxor_se   = Signal("andxor_se",       32)    # bit_vector (31 downto 0)          #-- logic oper. result
    rlogic_se   = Signal("rlogic_se",       32)    # bit_vector (31 downto 0)          #-- logic oper. result
                                                                                       
    ra_rt_se    = Signal("ra_rt_se",        32)    # bit_vector (31 downto 0)          #-- arith/test result
    so_to_se    = Signal("so_to_se",        32)    # bit_vector (31 downto 0)          #-- soper/toper
    i_s_t_se    = Signal("i_s_t_se",        32)    # bit_vector (31 downto 0)          #-- ioper/soper/toper
                                                                                       
    res_se      = Signal("res_se",          32)    # bit_vector (31 downto 0)          #-- result out of alu
    res_re      = Signal("res_re",          32)    # reg_vector (31 downto 0) register #-- result out of alu
                                                                                       
    wdata_re    = Signal("wdata_re",        32)    # reg_vector (31 downto 0) register #-- data bus output reg
                                                                                       
   #d_15x_sm    = Signal("d_15x_sm",        24, 8) # bit_vector (31 downto 8)          #-- read data
   #d_31x_sm    = Signal("d_31x_sm",        24, 8) # bit_vector (31 downto 8)          #-- read data
   #d_ext_sm    = Signal("d_ext_sm",        24, 8) # bit_vector (31 downto 8)          #-- read data
    data_e_sm   = Signal("data_e_sm",       32)    # bit_vector (31 downto 0)          #-- read data
    data_o_sm   = Signal("data_o_sm",       32)    # bit_vector (31 downto 0)          #-- read data
    data_x_sm   = Signal("data_x_sm",       32)    # bit_vector (31 downto 0)          #-- read data
                                                                                       
    reddat_sm   = Signal("reddat_sm",       32)    # bit_vector (31 downto 0)          #-- aligned data
                                                                                       
    data_sm     = Signal("data_sm",         32)    # bit_vector (31 downto 0)          #-- data bus / res
    data_rm     = Signal("data_rm",         32)    # reg_vector (31 downto 0) register #-- data bus input reg
                                                                                       
    badvadr_rm  = Signal("badvadr_rm",      32)    # reg_vector (31 downto 0) register #-- bad virtual adr reg
                                                                                       
    epc_xx      = Signal("epc_xx",          32)    # bit_vector (31 downto 0)          #-- exc pg counter
    epc_xm      = Signal("epc_xm",          32)    # bit_vector (31 downto 0)          #-- exc pg counter
    epc_rx      = Signal("epc_rx",          32)    # reg_vector (31 downto 0) register #-- exc pg counter reg
                                             
    nop_i       = Signal("nop_i",           32)    # bit_vector (31 downto 0) "= x"00000021" ;-- addu 0,0,0
                                                 
    excphnd_a   = Signal("excphnd_a",       32)    # bit_vector (31 downto 0) "= x"80000080" ;-- handler adr
    boothnd_a   = Signal("boothnd_a",       32)    # bit_vector (31 downto 0) "= x"bfc00180" ;-- handler adr
    reset_a     = Signal("reset_a",         32)    # bit_vector (31 downto 0) "= x"bfc00000" ;-- reset   adr
                         
    imdsgn_sd0  = Signal("imdsgn_sd0",       1)    # added
   #imdsex_sd1  = Signal("imdsex_sd1",      16)    # added
    i_osgnd_sd0 = Signal("i_osgnd_sd0",      1)    # added
   #const0_24   = Signal("const0_24",       24)    # added
    const0_31   = Signal("const0_31",       31)    # added
    const0_2    = Signal("const0_2",         2)    # added
    const0_1a   = Signal("const0_1a",        1)    # added
    const0_1b   = Signal("const0_1b",        1)    # added
    const0_1c   = Signal("const0_1c",        1)    # added
    const0_1d   = Signal("const0_1d",        1)    # added
   #const1_24   = Signal("const1_24",       24)    # added
    const1_1a   = Signal("const1_1a",        1)    # added
    const1_1b   = Signal("const1_1b",        1)    # added
    const1_1c   = Signal("const1_1c",        1)    # added
    const1_1d   = Signal("const1_1d",        1)    # added
    const4_32   = Signal("const4_32",       32)    # added
    bracry_32_sd = Signal("bracry_32_sd",    1)    # added
    bracry_31_sd = Signal("bracry_31_sd",    1)    # added
    seqcry_32_sd = Signal("seqcry_32_sd",    1)    # added
    seqcry_31_sd = Signal("seqcry_31_sd",    1)    # added
    or_se_not    = Signal("or_se_not",      32)    # added
    nextpc_xx0   = Signal("nextpc_xx0",     32)    # added
    i_ri1        = Signal("i_ri1",          32)    # added
    pc_ri0       = Signal("pc_ri0",         32)    # added
    nextpc_rd1   = Signal("nextpc_rd1",     32)    # added
   #nextpc_rd0   = Signal("nextpc_rd0",     32)    # added
    pc_rd0       = Signal("pc_rd0",         32)    # added
    soper_rd0    = Signal("soper_rd0",      32)    # added
    toper_rd0    = Signal("toper_rd0",      32)    # added
    pc_re0       = Signal("pc_re0",         32)    # added
    nextpc_re0   = Signal("nextpc_re0",     32)    # added
    res_re0      = Signal("res_re0",        32)    # added
    wdata_re0    = Signal("wdata_re0",      32)    # added
    redopc_re0   = Signal("redopc_re0",     32)    # added
    redopc_re1   = Signal("redopc_re1",     32)    # added
    data_rm0     = Signal("data_rm0",       32)    # added
    badvadr_rm0  = Signal("badvadr_rm0",    32)    # added
    badvadr_rm1  = Signal("badvadr_rm1",    32)    # added
    epc_rx1      = Signal("epc_rx1",        32)    # added
    epc_rx0      = Signal("epc_rx0",        32)    # added

   ### ------------------------------------------------------ ###
   #   instruction set table:                                   #
   #     opcods in lower case are mips r3000 instructions       #
   #     opcods in upper case are application specific          #
   #                                                            #
   #                                                            #
   #   primary opcod (31 downto 26):                            #
   #    |  0     1     2     3     4     5     6     7          #
   #  --+-----+-----+-----+-----+-----+-----+-----+-----+       #
   #  0 |speci|bcond|  j  | jal | beq | bne |blez |bgtz |       #
   #  1 |addi |addui|slti |sltui|andi | ori |xori | lui |       #
   #  2 |cop0 |  +  |  +  |  +  |     |  +  |     |     |       #
   #  3 |  +  |  +  |     |     |     |     |     |     |       #
   #  4 | lb  | lh  |  +  | lw  | lbu | lhu |  +  |swap |       #
   #  5 | sb  | sh  |  +  | sw  |     |     |  +  |     |       #
   #  6 |  +  |  +  |  +  |  +  |  +  |  +  |  +  |  +  |       #
   #  7 |  +  |  +  |  +  |  +  |  +  |  +  |  +  |  +  |       #
   #                                                            #
   #                                                            #
   # special opcod extension (5 downto 0):                      #
   #    |  0     1     2     3     4     5     6     7          #
   #  --+-----+-----+-----+-----+-----+-----+-----+-----+       #
   #  0 | sll |     | srl | sra |sllv |     |srlv |srav |       #
   #  1 | jr  |jalr |     |     |sysca|break|     |sleep|       #
   #  2 |mfhi |mthi |mflo |mtlo |     |     |     |     |       #
   #  3 |  +  |  +  |  +  |  +  |     |     |     |     |       #
   #  4 | add |addu | sub |subu | and | or  | xor | nor |       #
   #  5 |     |     | slt |sltu |     |     |     |     |       #
   #  6 |     |     |     |     |  +  |  +  |  +  |  +  |       #
   #  7 |     |     |     |     |  +  |  +  |  +  |  +  |       #
   #                                                            #
   #                                                            #
   # bcond opcod extension (20 downto 16):                      #
   #    |  0     1     2     3     4     5     6     7          #
   #  --+-----+-----+-----+-----+-----+-----+-----+-----+       #
   #  0 |bltz |bgez |     |     |     |     |     |     |       #
   #  1 |     |     |     |     |     |     |     |     |       #
   #  2 |bltza|bgeza|     |     |     |     |     |     |       #
   #  3 |     |     |     |     |     |     |     |     |       #
   #                                                            #
   #                                                            #
   # cop0 opcod extension (22, 21, 16 / 25, 24, 23):            #
   #    |  0     1     2     3     4     5     6     7          #
   #  --+-----+-----+-----+-----+-----+-----+-----+-----+       #
   #  0 | mf  | mt  |  +  |  +  | c0  | c0  | c0  | c0  |       #
   #  1 | mf  | mt  |  +  |  +  | c0  | c0  | c0  | c0  |       #
   #  2 |     |     |     |     | c0  | c0  | c0  | c0  |       #
   #  3 |     |     |     |     | c0  | c0  | c0  | c0  |       #
   #  4 |  +  |  +  |     |     | c0  | c0  | c0  | c0  |       #
   #  5 |  +  |  +  |     |     | c0  | c0  | c0  | c0  |       #
   #  6 |     |     |     |     | c0  | c0  | c0  | c0  |       #
   #  7 |     |     |     |     | c0  | c0  | c0  | c0  |       #
   #                                                            #
   #                                                            #
   # c0 cop0 extension extension (4 downto 0):                  #
   #    |  0     1     2     3     4     5     6     7          #
   #  --+-----+-----+-----+-----+-----+-----+-----+-----+       #
   #  0 |  +  |  +  |  +  |     |     |     |  +  |     |       #
   #  1 |  +  |     |     |     |     |     |     |     |       #
   #  2 | rfe |     |     |     |     |     |     |     |       #
   #  3 |  +  |     |     |     |     |     |     |     |       #
   #                                                            #
   ### ------------------------------------------------------ ###


    Generate('DpgenConst', "instnop_i"    , param={ 'nbit' : 32, 'const' : "0x00000021",'physical' : True}) 
    Generate('DpgenConst', "instexcphnd_a", param={ 'nbit' : 32, 'const' : "0x80000080",'physical' : True}) 
    Generate('DpgenConst', "instboothnd_a", param={ 'nbit' : 32, 'const' : "0xbfc00180",'physical' : True}) 
    Generate('DpgenConst', "instreset_a"  , param={ 'nbit' : 32, 'const' : "0xbfc00000",'physical' : True}) 
    
    self.instnop_i     = Inst("instnop_i"    , "instnop_i"    , map = { 'q' : nop_i    , 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.instexcphnd_a = Inst("instexcphnd_a", "instexcphnd_a", map = { 'q' : excphnd_a, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.instboothnd_a = Inst("instboothnd_a", "instboothnd_a", map = { 'q' : boothnd_a, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.instreset_a   = Inst("instreset_a"  , "instreset_a"  , map = { 'q' : reset_a  , 'vdd' : self.vdd, 'vss' : self.vss}) 
    
    Generate("DpgenConst", 'const0000', param={ 'nbit' : 16, 'const' : "0x0000"                           , 'physical' : True})
    Generate("DpgenConst", 'const0_2' , param={ 'nbit' :  2, 'const' : "0b00"                             , 'physical' : True})
    Generate("DpgenConst", 'const4_32', param={ 'nbit' : 32, 'const' : "0x00000004"                       , 'physical' : True})
    Generate('DpgenConst', "const0_1" , param={ 'nbit' :  1, 'const' : "0b0"                              , 'physical' : True})
    Generate('DpgenConst', "const1_1" , param={ 'nbit' :  1, 'const' : "0b1"                              , 'physical' : True})
    Generate("DpgenConst", 'const0_31', param={ 'nbit' : 31, 'const' : "0b0000000000000000000000000000000", 'physical' : True})
    
    self.instconst0_2   = Inst('const0_2' , 'instconst0_2' , map = { 'q' : const0_2 , 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.instconst4_32  = Inst('const4_32', 'instconst4_32', map = { 'q' : const4_32, 'vdd' : self.vdd, 'vss' : self.vss})
    self.instconst0_1a  = Inst('const0_1' , 'instconst0_1a', map = { 'q' : const0_1a, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.instconst0_1b  = Inst('const0_1' , 'instconst0_1b', map = { 'q' : const0_1b, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.instconst0_1c  = Inst('const0_1' , 'instconst0_1c', map = { 'q' : const0_1c, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.instconst0_1d  = Inst('const0_1' , 'instconst0_1d', map = { 'q' : const0_1d, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.instconst1_1a  = Inst('const1_1' , 'instconst1_1a', map = { 'q' : const1_1a, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.instconst1_1b  = Inst('const1_1' , 'instconst1_1b', map = { 'q' : const1_1b, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.instconst1_1c  = Inst('const1_1' , 'instconst1_1c', map = { 'q' : const1_1c, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.instconst1_1d  = Inst('const1_1' , 'instconst1_1d', map = { 'q' : const1_1d, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.instconst0_31  = Inst('const0_31', 'instconst0_31', map = { 'q' : const0_31, 'vdd' : self.vdd, 'vss' : self.vss}) 
    
    Generate("DpgenBuse",    'etat32',     param={'nbit' : 32,              'physical' : True})
    Generate("DpgenMux2",    'mux32',      param={'nbit' : 32, 'drive' : 4, 'physical' : True})
    Generate("DpgenMux2",    'mux16',      param={'nbit' : 16, 'drive' : 4, 'physical' : True})
    Generate('DpgenAnd2',    'instand21',  param={'nbit' : 1 , 'drive' : 2, 'physical' : True})
    Generate("DpgenMux2",    'mux14',      param={'nbit' : 14, 'drive' : 4, 'physical' : True})
    Generate("DpgenAdsb2f",  'addsub32',   param={'nbit' : 32, 'drive' : 1, 'physical' : True})
    Generate('DpgenXor2',    'instxor232', param={'nbit' : 32, 'drive' : 1, 'physical' : True})
    Generate('DpgenOr3',     'instor3',    param={'nbit' : 32, 'drive' : 2, 'physical' : True})
    Generate('DpgenAnd2',    'instand232', param={'nbit' : 32, 'drive' : 2, 'physical' : True})
    Generate('DpgenOr4',     'instor41',   param={'nbit' : 1 , 'drive' : 2, 'physical' : True})
    Generate('DpgenOr2',     'instor21',   param={'nbit' : 1 , 'drive' : 2, 'physical' : True})
    Generate("DpgenMux2",    'mux1',       param={'nbit' : 1 , 'drive' : 4, 'physical' : True})
    Generate('DpgenNul',     'nul32',      param={'nbit' : 32,              'physical' : True})
    Generate("DpgenShifter", 'shift32',    param={'nbit' : 32,              'physical' : True})
    Generate("DpgenInv",     'inv1',       param={'nbit' : 1,  'drive' : 1, 'physical' : True})
    Generate("DpgenInv",     'inv32',      param={'nbit' : 32, 'drive' : 1, 'physical' : True})
    Generate('DpgenOr2',     'instor232',  param={'nbit' : 32, 'drive' : 2, 'physical' : True})
    Generate("DpgenMux2",    'mux24',      param={'nbit' : 24, 'drive' : 4, 'physical' : True})
    Generate("DpgenSff",     'reg32',      param={'nbit' : 32, 'drive' : 4, 'physical' : True})
    Generate("DpgenMux2",    'mux8',       param={'nbit' : 8 , 'drive' : 4, 'physical' : True})
    Generate("DpgenRf2r0",   'banc',       param={'nbit' : 32, 'nword' : 32,'physical' : True})
    Generate("DpgenBuff",    'buffer32',   param={'nbit' : 32,              'physical' : True})
    Generate("DpgenBuff",    'buffer8',    param={'nbit' : 8 ,              'physical' : True})
    Generate("DpgenBuff",    'buffer5',    param={'nbit' : 5 ,              'physical' : True})
    Generate("DpgenBuff",    'buffer1',    param={'nbit' : 1 ,              'physical' : True})
  
   ### -------------------------------------------------------------- ###
   #   internal description:                                            #
   #                                                                    #
   #   the following lines describes in details an implementation of    #
   # the mips r3000 risc architecture.                                  #
   #                                                                    #
   #   the description does not include cache memories, nor virtual to  #
   # real address translation mechanism (virtual memory not supported). #
   # also, the description contains only integer instructions excluding #
   # the multiply and divide instructions.                              #
   #                                                                    #
   #   the implementation includes 32 integer registers organized as a  #
   # register file (2 read access and 1 write access), the hi and lo    #
   # registers (although multiply and divide are not implemented) and   #
   # the coprocessor zero's registers: the exception program counter    #
   # (epc), the status register (sr), the cause register (cause), the   #
   # bad virtual address register (badvadr) and the processor revision  #
   # identifier (prid). the other registers of the coprocessor zero are #
   # not implemented.                                                   #
   #                                                                    #
   #   instructions are executed in a 5 stage pipeline:                 #
   #        ifc : instruction fetch                                     #
   #        dec : instruction decode                                    #
   #        exe : execute                                               #
   #        mem : memory access                                         #
   #        wbk : write back                                            #
   #                                                                    #
   #   all instructions follows the same execution scheme: in ifc, the  #
   # instruction is fetched from the memory; in dec, operands are       #
   # prepared and the next instruction address is computed; in exe, the #
   # operation is performed; in mem, the data memory is accessed; and   #
   # in wbk, the content of the register file is modified.              #
   #                                                                    #
   #   a global pipeline control mechanism guaranties the correct       #
   # execution of dependent instructions. most of data hazards on       #
   # integer registers are resolved by bypasses. data hazards on        #
   # integer registers that cannot be resolved by bypass produce        #
   # pipeline bubbles (one or two cycles).                              #
   #                                                                    #
   #   there is no dependency control mechanism on coprocessor zero's   #
   # registers.                                                         #
   #                                                                    #
   #   there is no dependency control mechanism on lo and hi registers  #
   #                                                                    #
   #   registers are synchronized on the rising edge of the clock.      #
   #                                                                    #
   #   notes:                                                           #
   #     move to coprocessor zero (mtc0):                               #
   #       registers of coprocessor zero are written in mem.            #
   #                                                                    #
   #     move from coprocessor zero (mfc0):                             #
   #       registers of coprocessor zero are read in dec.               #
   #                                                                    #
   #     move from lo or hi (mflo, mfhi):                               #
   #       registers are read in dec.                                   #
   ### -------------------------------------------------------------- ###
 
   #s_mw_sd  <= res_re   when (hz_sdm_sd  = '1') else data_rm ;
    self.mux32_s_mw_sd = Inst('mux32','mux32_s_mw_sd', map={'i0' : data_rm, 'i1' : res_re, 'cmd' : self.hz_sdm_sd, 'q' : s_mw_sd, 'vdd' : self.vdd, 'vss' : self.vss}) 

   #soper_sd <= s_mw_sd  when (hz_sdmw_sd = '1') else s_sd ;
    self.mux32_soper_sd = Inst('mux32','mux32_soper_sd', map={'i0' : s_sd, 'i1' : s_mw_sd, 'cmd' : self.hz_sdmw_sd, 'q' : soper_sd, 'vdd' : self.vdd, 'vss' : self.vss}) 

   #t_mw_sd  <= res_re   when (hz_tdm_sd  = '1') else data_rm ;
    self.mux32_t_mw_sd = Inst('mux32','mux32_t_mw_sd', map={'i0' : data_rm, 'i1' : res_re, 'cmd' : self.hz_tdm_sd, 'q' : t_mw_sd, 'vdd' : self.vdd, 'vss' : self.vss}) 

   #toper_sd <= t_mw_sd  when (hz_tdmw_sd = '1') else t_sd ;
    self.mux32_toper_sd = Inst('mux32','mux32_toper_sd', map={'i0' : t_sd, 'i1' : t_mw_sd, 'cmd' : self.hz_tdmw_sd, 'q' : toper_sd, 'vdd' : self.vdd, 'vss' : self.vss}) 

   #effto_sd <= i_ri     when (lui_sd     = '1') else toper_sd ;
    self.mux32_effto_sd = Inst('mux32','mux32_effto_sd', map={'i0' : toper_sd, 'i1' : i_ri, 'cmd' : self.lui_sd, 'q' : effto_sd, 'vdd' : self.vdd, 'vss' : self.vss}) 


   ### ------------------------------------------------------ ###
   #   read the special register to be transfered into an       #
   # integer register (mfc0 instruction)                        #
   ### ------------------------------------------------------ ###

   #br_epc_sd <= badvadr_rm  when (be_sd   = '1') else epc_rx ;
    self.mux32_br_epc_sd = Inst('mux32','mux32_br_epc_sd', map={'i0' : epc_rx, 'i1' : badvadr_rm, 'cmd' : self.be_sd, 'q' : br_epc_sd, 'vdd' : self.vdd, 'vss' : self.vss}) 

   #cop0op_sd <= sr_cr_sd    when (scbe_sd = '1') else br_epc_sd ;
    self.mux32_cop0op_sd = Inst('mux32','mux32_cop0op_sd', map={'i0' : br_epc_sd, 'i1' : self.sr_cr_sd, 'cmd' : self.scbe_sd, 'q' : cop0op_sd, 'vdd' : self.vdd, 'vss' : self.vss}) 


   ### ------------------------------------------------------ ###
   #   compute immediate operand                                #
   #                                                            #
   #   immediate operand selection :                            #
   #     - mfc0          : 0001                                 #
   #     - mflo          : 0010                                 #
   #     - mfhi          : 0100                                 #
   #     - i format inst : 1000                                 #
   ### ------------------------------------------------------ ###

   #imdsgn_sd0 <= imdsgn_sd
    self.buffer1_imdsgn_sd0 = Inst('buffer1','buffer1_imdsgn_sd0', map={'i0' : self.imdsgn_sd, 'q' : imdsgn_sd0, 'vdd' : self.vdd, 'vss' : self.vss}) 

   #self.constffff_imdsex_sd    = Inst('constffff',      'constffff_imdsex_sd',      map = { 'q' : imdsex_sd0     , 'vdd' : self.vdd, 'vss' : self.vss}) 
   #self.const000_imdsex_sd     = Inst('const0000',      'const000_imdsex_sd',      map = { 'q' : imdsex_sd1     , 'vdd' : self.vdd, 'vss' : self.vss}) 

   #self.instand2_i_osgnd_sd_iri_15 = Inst('instand21', 'instand2_i_osgnd_sd_iri_15', map={'i0' : i_ri[15], 'i1' : self.i_osgnd_sd, 'q' : i_osgnd_sd0, 'vdd' : self.vdd, 'vss' : self.vss})

   #imdsex_sd <= x"ffff" when (imdsgn_sd = '1') else x"0000" ;
   #self.mux16_imdsex_sd = Inst('mux16','mux16_imdsex_sd', map={'i0' : imdsex_sd1, 'i1' : imdsex_sd0, 'cmd' : i_osgnd_sd0, 'q' : imdsex_sd, 'vdd' : self.vdd, 'vss' : self.vss}) 

   #with iopsel_sd select
   #otheri_sd <= cop0op_sd                      when "0001" ,
   #             lo_rw                          when "0010" ,
   #             hi_rw                          when "0100" ,
   #             imdsex_sd & i_ri (15 downto 0) when "1000" ,
   #             x"00000000"                    when others ;
    self.etat32_otheri_sd_0 = Inst('etat32','etat32_otheri_sd_0', map={'i0' : cop0op_sd, 'cmd' : self.iopsel_sd[0], 'q' : otheri_sd, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.etat32_otheri_sd_1 = Inst('etat32','etat32_otheri_sd_1', map={'i0' : lo_rw, 'cmd' : self.iopsel_sd[1], 'q' : otheri_sd, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.etat32_otheri_sd_2 = Inst('etat32','etat32_otheri_sd_2', map={'i0' : hi_rw, 'cmd' : self.iopsel_sd[2], 'q' : otheri_sd, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.etat32_otheri_sd_3 = Inst('etat32','etat32_otheri_sd_3', map={'i0' : Cat(imdsgn_sd0, imdsgn_sd0, imdsgn_sd0, imdsgn_sd0, imdsgn_sd0, imdsgn_sd0, imdsgn_sd0, imdsgn_sd0, imdsgn_sd0, imdsgn_sd0, imdsgn_sd0, imdsgn_sd0, imdsgn_sd0, imdsgn_sd0, imdsgn_sd0, imdsgn_sd0, i_ri[15:0]), 'cmd' : self.iopsel_sd[3], 'q' : otheri_sd, 'vdd' : self.vdd, 'vss' : self.vss}) 

   #ioper_sd  <= seqadr_sd when (i_link_sd = '1') else otheri_sd ;
    self.mux32_ioper_sd = Inst('mux32','mux32_ioper_sd', map={'i0' : otheri_sd, 'i1' : seqadr_sd, 'cmd' : self.i_link_sd, 'q' : ioper_sd, 'vdd' : self.vdd, 'vss' : self.vss}) 


   ### ------------------------------------------------------ ###
   #   compute the offset to be added to the current            #
   # instruction address :                                      #
   #   - short offset for conditional branches                  #
   ### ------------------------------------------------------ ###

   #offset_sd (31 downto 18) <= x"fff" & "11" when (i_ri (15) = '1') else x"000" & "00" ;
   #offset_sd (17 downto  0) <= i_ri (15 downto 0) & b"00";

   ### ------------------------------------------------------ ###
   #   next instruction address adders :                        #
   #     - replace low order bits for jumps                     #
   #     - add the offset         for branches                  #
   #     - add 4                  for branches and other inst.  #
   ### ------------------------------------------------------ ###

   #jmpadr_sd               <= nextpc_rd (31 downto 28) &
   #                           i_ri      (25 downto  0) & "00";


   # Adder.
    self.instaddbracry_sd = Inst('addsub32', 'instaddbracry_sd', map={'i0' : nextpc_rd, 'i1' : Cat (i_ri[15],i_ri[15],i_ri[15],i_ri[15],i_ri[15],i_ri[15],i_ri[15],i_ri[15],i_ri[15],i_ri[15],i_ri[15],i_ri[15],i_ri[15], i_ri[15], i_ri[15:0], const0_2 ), 'add_sub' : const0_1a, 'q' : braadr_sd, 'c30' : bracry_31_sd, 'c31' : bracry_32_sd, 'vdd' : self.vdd, 'vss' : self.vss})
    self.instseqadr_sd    = Inst('addsub32', 'instseqadr_sd'   , map={'i0' : nextpc_rd, 'i1' : const4_32, 'add_sub' : const0_1b, 'q' : seqadr_sd, 'c30' : seqcry_31_sd, 'c31' : seqcry_32_sd, 'vdd' : self.vdd, 'vss' : self.vss})


   ### ------------------------------------------------------ ###
   #   conditional branches' condition                          #
   ### ------------------------------------------------------ ###


   #s_cp_t_sd  <= soper_sd xor toper_sd;
    self.instxor2s_cp_t_sd = Inst('instxor232', 'instxor2s_cp_t_sd', map={'i0' : soper_sd, 'i1' : toper_sd, 'q' : s_cp_t_sd, 'vdd' : self.vdd, 'vss' : self.vss})

   #s_eq_t_sd  <= '1' when (s_cp_t_sd = x"00000000") else '0' ;
    self.nul_s_eq_t_sd = Inst('nul32','nul_s_eq_t_sd',map = {'i0' : s_cp_t_sd, 'nul' : self.s_eq_t_sd, 'vdd' : self.vdd, 'vss' : self.vss})

   #s_eq_z_sd  <= '1' when (soper_sd  = x"00000000") else '0' ;
    self.nul_s_eq_z_sd = Inst('nul32','nul_s_eq_z_sd',map = {'i0' : soper_sd, 'nul' : self.s_eq_z_sd, 'vdd' : self.vdd, 'vss' : self.vss})


   ### ------------------------------------------------------ ###
   #   next instruction's address                               #
   ### ------------------------------------------------------ ###

   #jadr_sd   <= soper_sd  when (i_jr_sd   = '1') else jmpadr_sd ;
    self.mux32_jadr_sd = Inst('mux32','mux32_mux32_jadr_sd', map={'i0' :  Cat (nextpc_rd[31:28], i_ri[25:0],const0_2), 'i1' : soper_sd, 'cmd' : self.i_jr_sd, 'q' : jadr_sd, 'vdd' : self.vdd, 'vss' : self.vss}) 

   #badr_sd   <= braadr_sd when (btaken_sd = '1') else seqadr_sd ;
    self.mux32_badr_sd = Inst('mux32','mux32_badr_sd', map={'i0' : seqadr_sd, 'i1' : braadr_sd, 'cmd' : self.btaken_sd, 'q' : badr_sd, 'vdd' : self.vdd, 'vss' : self.vss}) 

   #nextpc_sd <= jadr_sd   when (i_allj_sd = '1') else badr_sd   ;
    self.mux32_nextpc_sd = Inst('mux32','mux32_nextpc_sd', map={'i0' : badr_sd, 'i1' : jadr_sd, 'cmd' : self.i_allj_sd, 'q' : nextpc_sd, 'vdd' : self.vdd, 'vss' : self.vss}) 


   ### ------------------------------------------------------ ###
   #   effective operands (bypasses)                            #
   ### ------------------------------------------------------ ###

   #s_mw_se  <= res_re   when (hz_sdm_se  = '1') else data_rm ;
    self.mux32_s_mw_se = Inst('mux32','mux32_s_mw_se', map={'i0' : data_rm, 'i1' : res_re, 'cmd' : self.hz_sdm_se, 'q' : s_mw_se, 'vdd' : self.vdd, 'vss' : self.vss}) 

   #soper_se <= s_mw_se  when (hz_sdmw_se = '1') else soper_rd ;
    self.mux32_soper_se = Inst('mux32','mux32_soper_se', map={'i0' : soper_rd, 'i1' : s_mw_se, 'cmd' : self.hz_sdmw_se, 'q' : soper_se, 'vdd' : self.vdd, 'vss' : self.vss}) 

   #t_mw_se  <= res_re   when (hz_tdm_se  = '1') else data_rm ;
    self.mux32_t_mw_se = Inst('mux32','mux32_t_mw_se', map={'i0' : data_rm, 'i1' : res_re, 'cmd' : self.hz_tdm_se, 'q' : t_mw_se, 'vdd' : self.vdd, 'vss' : self.vss}) 

   #toper_se <= t_mw_se  when (hz_tdmw_se = '1') else toper_rd ;
    self.mux32_toper_se = Inst('mux32','mux32_toper_se', map={'i0' : toper_rd, 'i1' : t_mw_se, 'cmd' : self.hz_tdmw_se, 'q' : toper_se, 'vdd' : self.vdd, 'vss' : self.vss}) 


   ### ------------------------------------------------------ ###
   #   operands                                                 #
   ### ------------------------------------------------------ ###

   #xoper_se <= soper_se ; VBE
   #self.buffer32_xoper_se = Inst('buffer32','buffer32_xoper_se', map={'i0' : soper_se, 'q' : xoper_se, 'vdd' : self.vdd, 'vss' : self.vss}) 

   #yoper_se <= ioper_rd when (i_ifmt_se = '1') else toper_se;
    self.mux32_yoper_se = Inst('mux32','mux32_yoper_se', map={'i0' : toper_se, 'i1' : ioper_rd, 'cmd' : self.i_ifmt_se, 'q' : yoper_se, 'vdd' : self.vdd, 'vss' : self.vss}) 


   ### ------------------------------------------------------ ###
   #   operands for arithmetic operations                       #
   ### ------------------------------------------------------ ###
   # Additionneur/Soustracteru XOPER YOPER

    self.addsub32_carith_se = Inst('addsub32','addsub32_carith_se', map={'i0' : soper_se, 'i1' : yoper_se, 'add_sub' : self.i_sub_se, 'q' : rarith_se, 'c30': self.carith_31_se, 'c31': self.carith_32_se,'vdd' : self.vdd, 'vss' : self.vss}) 


   ### ------------------------------------------------------ ###
   #   arithmetic result                                        #
   ### ------------------------------------------------------ ###

   #carith_se (0) <= i_sub_se; -- inutile


   ### ------------------------------------------------------ ###
   #   shifter's result                                         #
   ### ------------------------------------------------------ ###

    self.shift32_rshift_se = Inst('shift32', 'shift32_rshift_se', map={'op' : Cat(self.i_rsgnd_se, self.i_right_se), 'shamt' : self.shamt_se, 'i' : yoper_se, 'o' : rshift_se, 'vdd' : self.vdd, 'vss' : self.vss}) 

   #with (i_right_se and i_rsgnd_se and yoper_se (31)) select
   #shiftin_se <= x"ffffffff" when '1',
   #              x"00000000" when '0';
   #
   #with shamt_se (4 downto 0) select
   #shleft_se <=
   #  yoper_se (31 downto 0)                                when b"00000",
   #  yoper_se (30 downto 0) & shiftin_se (31)              when b"00001",
   #  yoper_se (29 downto 0) & shiftin_se (31 downto 30)    when b"00010",
   #  yoper_se (28 downto 0) & shiftin_se (31 downto 29)    when b"00011",
   #  yoper_se (27 downto 0) & shiftin_se (31 downto 28)    when b"00100",
   #  yoper_se (26 downto 0) & shiftin_se (31 downto 27)    when b"00101",
   #  yoper_se (25 downto 0) & shiftin_se (31 downto 26)    when b"00110",
   #  yoper_se (24 downto 0) & shiftin_se (31 downto 25)    when b"00111",
   #  yoper_se (23 downto 0) & shiftin_se (31 downto 24)    when b"01000",
   #  yoper_se (22 downto 0) & shiftin_se (31 downto 23)    when b"01001",
   #  yoper_se (21 downto 0) & shiftin_se (31 downto 22)    when b"01010",
   #  yoper_se (20 downto 0) & shiftin_se (31 downto 21)    when b"01011",
   #  yoper_se (19 downto 0) & shiftin_se (31 downto 20)    when b"01100",
   #  yoper_se (18 downto 0) & shiftin_se (31 downto 19)    when b"01101",
   #  yoper_se (17 downto 0) & shiftin_se (31 downto 18)    when b"01110",
   #  yoper_se (16 downto 0) & shiftin_se (31 downto 17)    when b"01111",
   #  yoper_se (15 downto 0) & shiftin_se (31 downto 16)    when b"10000",
   #  yoper_se (14 downto 0) & shiftin_se (31 downto 15)    when b"10001",
   #  yoper_se (13 downto 0) & shiftin_se (31 downto 14)    when b"10010",
   #  yoper_se (12 downto 0) & shiftin_se (31 downto 13)    when b"10011",
   #  yoper_se (11 downto 0) & shiftin_se (31 downto 12)    when b"10100",
   #  yoper_se (10 downto 0) & shiftin_se (31 downto 11)    when b"10101",
   #  yoper_se (9  downto 0) & shiftin_se (31 downto 10)    when b"10110",
   #  yoper_se (8  downto 0) & shiftin_se (31 downto  9)    when b"10111",
   #  yoper_se (7  downto 0) & shiftin_se (31 downto  8)    when b"11000",
   #  yoper_se (6  downto 0) & shiftin_se (31 downto  7)    when b"11001",
   #  yoper_se (5  downto 0) & shiftin_se (31 downto  6)    when b"11010",
   #  yoper_se (4  downto 0) & shiftin_se (31 downto  5)    when b"11011",
   #  yoper_se (3  downto 0) & shiftin_se (31 downto  4)    when b"11100",
   #  yoper_se (2  downto 0) & shiftin_se (31 downto  3)    when b"11101",
   #  yoper_se (1  downto 0) & shiftin_se (31 downto  2)    when b"11110",
   #  yoper_se (0)           & shiftin_se (31 downto  1)    when b"11111";
   #
   #with shamt_se (4 downto 0) select
   #shright_se <=
   #                              yoper_se (31 downto  0)   when b"00000",
   #  shiftin_se (31)           & yoper_se (31 downto  1)   when b"00001",
   #  shiftin_se (31 downto 30) & yoper_se (31 downto  2)   when b"00010",
   #  shiftin_se (31 downto 29) & yoper_se (31 downto  3)   when b"00011",
   #  shiftin_se (31 downto 28) & yoper_se (31 downto  4)   when b"00100",
   #  shiftin_se (31 downto 27) & yoper_se (31 downto  5)   when b"00101",
   #  shiftin_se (31 downto 26) & yoper_se (31 downto  6)   when b"00110",
   #  shiftin_se (31 downto 25) & yoper_se (31 downto  7)   when b"00111",
   #  shiftin_se (31 downto 24) & yoper_se (31 downto  8)   when b"01000",
   #  shiftin_se (31 downto 23) & yoper_se (31 downto  9)   when b"01001",
   #  shiftin_se (31 downto 22) & yoper_se (31 downto 10)   when b"01010",
   #  shiftin_se (31 downto 21) & yoper_se (31 downto 11)   when b"01011",
   #  shiftin_se (31 downto 20) & yoper_se (31 downto 12)   when b"01100",
   #  shiftin_se (31 downto 19) & yoper_se (31 downto 13)   when b"01101",
   #  shiftin_se (31 downto 18) & yoper_se (31 downto 14)   when b"01110",
   #  shiftin_se (31 downto 17) & yoper_se (31 downto 15)   when b"01111",
   #  shiftin_se (31 downto 16) & yoper_se (31 downto 16)   when b"10000",
   #  shiftin_se (31 downto 15) & yoper_se (31 downto 17)   when b"10001",
   #  shiftin_se (31 downto 14) & yoper_se (31 downto 18)   when b"10010",
   #  shiftin_se (31 downto 13) & yoper_se (31 downto 19)   when b"10011",
   #  shiftin_se (31 downto 12) & yoper_se (31 downto 20)   when b"10100",
   #  shiftin_se (31 downto 11) & yoper_se (31 downto 21)   when b"10101",
   #  shiftin_se (31 downto 10) & yoper_se (31 downto 22)   when b"10110",
   #  shiftin_se (31 downto  9) & yoper_se (31 downto 23)   when b"10111",
   #  shiftin_se (31 downto  8) & yoper_se (31 downto 24)   when b"11000",
   #  shiftin_se (31 downto  7) & yoper_se (31 downto 25)   when b"11001",
   #  shiftin_se (31 downto  6) & yoper_se (31 downto 26)   when b"11010",
   #  shiftin_se (31 downto  5) & yoper_se (31 downto 27)   when b"11011",
   #  shiftin_se (31 downto  4) & yoper_se (31 downto 28)   when b"11100",
   #  shiftin_se (31 downto  3) & yoper_se (31 downto 29)   when b"11101",
   #  shiftin_se (31 downto  2) & yoper_se (31 downto 30)   when b"11110",
   #  shiftin_se (31 downto  1) & yoper_se (31)             when b"11111";
   #
   #rshift_se <= shright_se when (i_right_se = '1') else shleft_se ;


   ### ------------------------------------------------------ ###
   #   logic unit's result                                      #
   #     - or_o   := b"00"                                      #
   #     - nor_o  := b"10"                                      #
   #     - and_o  := b"01"                                      #
   #     - xor_o  := b"11"                                      #
   ### ------------------------------------------------------ ###

   #and_se <= soper_se and yoper_se; #VBE
    self.instand2_and_se = Inst('instand232', 'instand2_and_se', map={'i0' : soper_se, 'i1' : yoper_se, 'q' : and_se, 'vdd' : self.vdd, 'vss' : self.vss})

   #or_se <= soper_se or  yoper_se; #VBE
    self.instor2_or_se = Inst('instor232', 'instor2_or_se', map={'i0' : soper_se, 'i1' : yoper_se, 'q' : or_se, 'vdd' : self.vdd, 'vss' : self.vss})

   #xor_se <= and_se   xor or_se   ;
    self.instxor2_xor_se = Inst('instxor232', 'instxor2_or_se', map={'i0' : and_se, 'i1' : or_se, 'q' : xor_se, 'vdd' : self.vdd, 'vss' : self.vss})

   #ornor_se  <= not or_se     when (i_logic_se (1) = '1') else or_se   ;
   #andxor_se <=     xor_se    when (i_logic_se (1) = '1') else and_se  ;
   #rlogic_se <=     andxor_se when (i_logic_se (0) = '1') else ornor_se;
    self.instinv32_or_se_not = Inst('inv32','instinv32_or_se_not', map={'i0' : or_se, 'nq' : or_se_not, 'vdd' : self.vdd, 'vss' : self.vss})
    self.mux32_ornor_se      = Inst('mux32','mux32_ornor_se'     , map={'i0' :  or_se, 'i1' : or_se_not, 'cmd' : self.i_logic_se[1], 'q' : ornor_se, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.mux32_andxor_se     = Inst('mux32','mux32_andxor_se'    , map={'i0' :  and_se, 'i1' : xor_se, 'cmd' : self.i_logic_se[1], 'q' : andxor_se, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.mux32_rlogic_se     = Inst('mux32','mux32_rlogic_se'    , map={'i0' :  ornor_se, 'i1' : andxor_se, 'cmd' : self.i_logic_se[0], 'q' : rlogic_se, 'vdd' : self.vdd, 'vss' : self.vss}) 


   ### ------------------------------------------------------ ###
   #   result out of alu                                        #
   #     - arith_o  := b"001_0001"                              #
   #     - test_o   := b"000_0001"                              #
   #     - logic_o  := b"000_0010"                              #
   #     - shift_o  := b"000_0100"                              #
   #     - soper_o  := b"010_1000"                              #
   #     - toper_o  := b"000_1000"                              #
   #     - ioper_o  := b"100_1000"                              #
   ### ------------------------------------------------------ ###

   #ra_rt_se <= rarith_se when (i_oper_se (4) = '1') else x"0000000" & b"000" & setbit_se ;
   #so_to_se <= soper_se  when (i_oper_se (5) = '1') else toper_se ;
   #i_s_t_se <= ioper_rd  when (i_oper_se (6) = '1') else so_to_se ;
    self.mux32_ra_rt_se = Inst('mux32','mux32_ra_rt_se', map={'i0' :  Cat(const0_31, self.setbit_se), 'i1' : rarith_se, 'cmd' : self.i_oper_se[4], 'q' : ra_rt_se, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.mux32_so_to_se = Inst('mux32','mux32_so_to_se', map={'i0' :  toper_se, 'i1' : soper_se, 'cmd' : self.i_oper_se[5], 'q' : so_to_se, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.mux32_i_s_t_se = Inst('mux32','mux32_i_s_t_se', map={'i0' :  so_to_se, 'i1' : ioper_rd, 'cmd' : self.i_oper_se[6], 'q' : i_s_t_se, 'vdd' : self.vdd, 'vss' : self.vss}) 
    
   #with i_oper_se (3 downto 0) select
   #res_se  <= ra_rt_se     when b"0001",
   #           rlogic_se    when b"0010",
   #           rshift_se    when b"0100",
   #           i_s_t_se     when b"1000",
   #           x"0000_0000" when others ;
    self.etat32_res_se0 = Inst('etat32','etat32_res_se0',  map={'i0' : ra_rt_se,  'cmd' : self.i_oper_se[0],  'q' : res_se, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.etat32_res_se1 = Inst('etat32','etat32_res_se1',  map={'i0' : rlogic_se,  'cmd' : self.i_oper_se[1],  'q' : res_se, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.etat32_res_se2 = Inst('etat32','etat32_res_se2',  map={'i0' : rshift_se,  'cmd' : self.i_oper_se[2],  'q' : res_se, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.etat32_res_se3 = Inst('etat32','etat32_res_se3',  map={'i0' : i_s_t_se,  'cmd' : self.i_oper_se[3],  'q' : res_se, 'vdd' : self.vdd, 'vss' : self.vss}) 


   ### ------------------------------------------------------ ###
   #   data alignment and zero or sign extension                #
   ### ------------------------------------------------------ ###

   #d_15x_sm  <= x"ffffff" when (d_in (15) = '1') else x"000000";
   #d_31x_sm  <= x"ffffff" when (d_in (31) = '1') else x"000000";
   #d_ext_sm  <= x"ffffff" when (datext_sm = '1') else x"000000";
   #self.mux24_d_15x_sm = Inst('mux24','mux24_d_15x_sm', map={'i0' :  const0_24, 'i1' : const1_24, 'cmd' : self.d_in[15], 'q' : d_15x_sm, 'vdd' : self.vdd, 'vss' : self.vss}) 
   #self.mux24_d_31x_sm = Inst('mux24','mux24_d_31x_sm', map={'i0' :  const0_24, 'i1' : const1_24, 'cmd' : self.d_in[31], 'q' : d_31x_sm, 'vdd' : self.vdd, 'vss' : self.vss}) 
   #self.mux24_d_ext_sm = Inst('mux24','mux24_d_ext_sm', map={'i0' :  const0_24, 'i1' : const1_24, 'cmd' : self.datext_sm, 'q' : d_ext_sm, 'vdd' : self.vdd, 'vss' : self.vss}) 
   
   #data_e_sm (31 downto  0) <=
   #                             d_in (31 downto  0) when (res_re (1) = '0') else
   #  d_31x_sm  (31 downto 16) & d_in (31 downto 16) ;
    self.mux32_data_e_sm = Inst('mux32','mux32_data_e_sm', map={'i0' :  self.d_in[31:0], 'i1' :Cat(self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31:16]), 'cmd' : res_re[1], 'q' : data_e_sm[31:0], 'vdd' : self.vdd, 'vss' : self.vss}) 

   #data_o_sm (31 downto  0) <=
   #  d_15x_sm  (31 downto  8) & d_in (15 downto  8) when (res_re (1) = '0') else
   #  d_31x_sm  (31 downto  8) & d_in (31 downto 24) ;
    self.mux32_data_o_sm = Inst('mux32','mux32_data_o_sm', map={'i0' : Cat(self.d_in[15], self.d_in[15], self.d_in[15], self.d_in[15], self.d_in[15], self.d_in[15], self.d_in[15], self.d_in[15], self.d_in[15], self.d_in[15], self.d_in[15], self.d_in[15], self.d_in[15], self.d_in[15], self.d_in[15], self.d_in[15], self.d_in[15], self.d_in[15], self.d_in[15], self.d_in[15], self.d_in[15], self.d_in[15], self.d_in[15], self.d_in[15], self.d_in[15:8]) , 'i1' : Cat(self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31], self.d_in[31:24]) , 'cmd' : res_re[1], 'q' : data_o_sm, 'vdd' : self.vdd, 'vss' : self.vss}) 

   #data_x_sm (31 downto  0) <=
   #  data_e_sm (31 downto  0)                       when (res_re (0) = '0') else
   #  data_o_sm (31 downto  0)                       ;
    self.mux32_data_x_sm = Inst('mux32','mux32_data_x_sm', map={'i0' :  data_e_sm, 'i1' : data_o_sm, 'cmd' : res_re[0], 'q' : data_x_sm, 'vdd' : self.vdd, 'vss' : self.vss}) 

   #reddat_sm ( 7 downto  0) <=
   #  data_x_sm ( 7 downto  0) ;
    self.buffer8_reddat_sm = Inst('buffer8','buffer8_reddat_sm', map={'i0' : data_x_sm[7:0], 'q' : reddat_sm[7:0], 'vdd' : self.vdd, 'vss' : self.vss}) 

   #reddat_sm (15 downto  8) <=
   #  data_x_sm (15 downto  8) when (bytsub_sm (1) = '0') else
   #  d_ext_sm  (15 downto  8) ;
    self.mux8_reddat_sm0 = Inst('mux8','mux8_reddat_sm0', map={'i0' :  data_x_sm[15:8], 'i1' : Cat (self.datext_sm, self.datext_sm, self.datext_sm, self.datext_sm, self.datext_sm, self.datext_sm, self.datext_sm, self.datext_sm), 'cmd' : self.bytsub_sm[1], 'q' : reddat_sm[15:8], 'vdd' : self.vdd, 'vss' : self.vss}) 

   #reddat_sm (23 downto 16) <=
   #  data_x_sm (23 downto 16) when (bytsub_sm (2) = '0') else
   #  d_ext_sm  (23 downto 16) ;
    self.mux8_reddat_sm1 = Inst('mux8','mux8_reddat_sm1', map={'i0' :  data_x_sm[23:16], 'i1' : Cat (self.datext_sm, self.datext_sm, self.datext_sm, self.datext_sm, self.datext_sm, self.datext_sm, self.datext_sm, self.datext_sm), 'cmd' : self.bytsub_sm[2], 'q' : reddat_sm[23:16], 'vdd' : self.vdd, 'vss' : self.vss}) 

   #reddat_sm (31 downto 24) <=
   #  data_x_sm (31 downto 24) when (bytsub_sm (3) = '0') else
   #  d_ext_sm  (31 downto 24) ;
    self.mux8_reddat_sm2 = Inst('mux8','mux8_reddat_sm2', map={'i0' :  data_x_sm[31:24], 'i1' : Cat (self.datext_sm, self.datext_sm, self.datext_sm, self.datext_sm, self.datext_sm, self.datext_sm, self.datext_sm, self.datext_sm), 'cmd' : self.bytsub_sm[3], 'q' : reddat_sm[31:24], 'vdd' : self.vdd, 'vss' : self.vss}) 

   #data_sm <= reddat_sm when (read_sm = '1') else res_re ;
    self.mux32_data_sm = Inst('mux32','mux32_data_sm', map={'i0' :  res_re, 'i1' : reddat_sm, 'cmd' : self.read_sm, 'q' : data_sm, 'vdd' : self.vdd, 'vss' : self.vss}) 


   ### ------------------------------------------------------ ###
   #   compute the next instruction address:                    #
   #                                                            #
   #    - in case of reset                                      #
   #    - in case of interrupt or exception during the bootstrap#
   #    - in case of interrupt or exception                     #
   ### ------------------------------------------------------ ###

   #nextpc_xx <= reset_a   when (reset_xx  = '1') else
   #             boothnd_a when (bootev_xx = '1') else
   #             excphnd_a ;
    self.mux32_nextpc_xx0 = Inst('mux32','mux32_nextpc_xx0', map={'i0' :  excphnd_a, 'i1' : boothnd_a, 'cmd' : self.bootev_xx, 'q' : nextpc_xx0, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.mux32_nextpc_xx  = Inst('mux32','mux32_nextpc_xx', map={'i0' :  nextpc_xx0, 'i1' : reset_a, 'cmd' : self.reset_xx, 'q' : nextpc_xx, 'vdd' : self.vdd, 'vss' : self.vss}) 


   ### ------------------------------------------------------ ###
   #   prepare the data to be written into the exception        #
   # program counter register:                                  #
   #                                                            #
   #     - interrupt:                                           #
   #         the address of the first unexecuted instruction is #
   #         saved unless the first unexecuted instruction is   #
   #         in the delayed slot of a branch instruction in     #
   #         which case the address of the branch instruction   #
   #         is saved.                                          #
   #     - exception:                                           #
   #         the address of the faulty instruction is saved     #
   #         unless the faulty instruction is in the delayed    #
   #         slot of a branch instruction in which case the     #
   #         address of the branch instruction is saved.        #
   ### ------------------------------------------------------ ###

   #epc_xx  <= pc_rd     when (bdslot_se = '0') else redopc_re ;
    self.mux32_epc_xx = Inst('mux32','mux32_epc_xx', map={'i0' :  pc_rd, 'i1' : redopc_re, 'cmd' : self.bdslot_se, 'q' : epc_xx, 'vdd' : self.vdd, 'vss' : self.vss}) 

   #epc_xm  <= pc_re     when (bdslot_sm = '0') else redopc_re ;
    self.mux32_epc_xm = Inst('mux32','mux32_epc_xm', map={'i0' :  pc_re, 'i1' : redopc_re, 'cmd' : self.bdslot_sm, 'q' : epc_xm, 'vdd' : self.vdd, 'vss' : self.vss}) 


   ### ------------------------------------------------------ ###
   #   assign registers (those related to a pipeline cycle)     #
   # instruction fetch cycle                                    #
   ### ------------------------------------------------------ ###

   #ifc_cycle : block (ck_sx = '1' and not ck_sx'stable)
   #begin
   #  i_ri      <= guarded nop_i      when (bubble_si = '1') else
   #                       i_ri       when (hold_si   = '1') else
   #                       i          ;
   #  pc_ri     <= guarded pc_ri      when (keep_si   = '1') else -- not(keep_si)=load_si
   #                       nextpc_rd  ;
   #end block;
    self.mux32_i_ri = Inst('mux32','mux32_i_ri', map={'i0' :  self.i, 'i1' : nop_i, 'cmd' : self.bubble_si, 'q' : i_ri1, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.reg_i_ri   = Inst('reg32','reg_i_ri'  , map={'wen' : self.nothold_si, 'ck' : self.ck ,'i0' : i_ri1,'q' : i_ri,'vdd' : self.vdd, 'vss' : self.vss}) 
    self.reg_pc_ri  = Inst('reg32','reg_pc_ri' , map={'wen' : self.load_si, 'ck' : self.ck,'i0' : nextpc_rd, 'q' : pc_ri,'vdd' : self.vdd, 'vss' : self.vss}) 


   ### ------------------------------------------------------ ###
   #   assign registers (those related to a pipeline cycle)     #
   # instruction decode cycle                                   #
   #                                                            #
   #  nextpc :                                                  #
   #     - in case of hardware events (reset, exception or      #
   #       interrupt) set the next address to a known value     #
   #       (reset or interrupt handler address). in other cases #
   #       nextpc is considered as a data register.             #
   ### ------------------------------------------------------ ###

   #dec_cycle : block (ck_sx = '1' and not ck_sx'stable)
   #begin
   #  i_rd       <= guarded nop_i      when (bubble_sd = '1') else #VBE A ENLEVER
   #                        i_rd       when (hold_sd   = '1') else
   #                        i_ri       ;
   #
   #  nextpc_rd  <= guarded nextpc_xx  when (wnxtpc_xx = '1') else
   #                        nextpc_rd  when (keep_sd   = '1') else
   #                        nextpc_sd  ;
   #
   #  pc_rd      <= guarded pc_rd      when (hold_sd   = '1') else
   #                        pc_ri      ;
   #
   #  soper_rd   <= guarded soper_se   when (keep_sd   = '1') else
   #                        soper_sd   ;
   #  toper_rd   <= guarded toper_se   when (keep_sd   = '1') else
   #                        effto_sd   ;
   #  ioper_rd   <= guarded ioper_rd   when (keep_sd   = '1') else
   #                        ioper_sd   ;
   #end block;
    self.mux32_nextpc_rd = Inst('mux32','mux32_nextpc_rd', map={'i0' :  nextpc_sd, 'i1' : nextpc_xx, 'cmd' : self.wnxtpc_xx, 'q' : nextpc_rd1, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.reg_nextpc_rd   = Inst('reg32','reg_nextpc_rd'  , map={'wen': self.notstall_sd, 'ck' : self.ck ,'i0' : nextpc_rd1,'q' : nextpc_rd,'vdd' : self.vdd, 'vss' : self.vss})
    self.reg_pc_rd       = Inst('reg32','reg_pc_rd'      , map={'wen': self.nothold_sd, 'ck' : self.ck ,'i0' : pc_ri,'q' : pc_rd,'vdd' : self.vdd, 'vss' : self.vss})
    self.mux32_soper_rd0 = Inst('mux32','mux32_soper_rd0', map={'i0' : soper_sd, 'i1' :soper_se, 'cmd' : self.keep_sd, 'q' : soper_rd0, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.reg_soper_rd    = Inst('reg32','reg_soper_rd'   , map={'wen': const1_1a, 'ck' : self.ck ,'i0' : soper_rd0,'q' : soper_rd,'vdd' : self.vdd, 'vss' : self.vss})
    self.mux32_toper_rd0 = Inst('mux32','mux32_toper_rd0', map={'i0' : effto_sd, 'i1' :toper_se, 'cmd' : self.keep_sd, 'q' : toper_rd0, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.reg_toper_rd    = Inst('reg32','reg_toper_rd'   , map={'wen': const1_1b, 'ck' : self.ck ,'i0' : toper_rd0,'q' : toper_rd,'vdd' : self.vdd, 'vss' : self.vss})
    self.reg_ioper_rd    = Inst('reg32','reg_ioper_rd'   , map={'wen': self.load_sd, 'ck' : self.ck ,'i0' : ioper_sd,'q' : ioper_rd,'vdd' : self.vdd, 'vss' : self.vss})


   ### ------------------------------------------------------ ###
   #   assign registers (those related to a pipeline cycle)     #
   # execute cycle                                              #
   #                                                            #
   #   copycap:                                                 #
   #     when the instruction has been duplicated, the copying  #
   #     capability falls to zero                               #
   ### ------------------------------------------------------ ###

   #exe_cycle : block (ck_sx = '1' and not ck_sx'stable)
   #begin
   #  i_re       <= guarded nop_i      when (bubble_se = '1') else # VBE A ENLEVER
   #                        i_re       when (hold_se   = '1') else
   #                        i_rd       ;
   #
   #  pc_re      <= guarded pc_re      when (hold_se   = '1') else
   #                        pc_rd      ;
   #
   #  nextpc_re  <= guarded nextpc_re  when (keep_se   = '1') else -- not(keep_se) = load_se
   #                        nextpc_rd  ;
   #  res_re     <= guarded res_re     when (keep_se   = '1') else
   #                        res_se     ;
   #  wdata_re   <= guarded wdata_re   when (keep_se   = '1') else
   #                        toper_se   ;
   #end block;
    self.reg_pc_re     = Inst('reg32','reg_pc_re'    , map={'wen': self.nothold_se, 'ck' : self.ck ,'i0' : pc_rd,'q' : pc_re,'vdd' : self.vdd, 'vss' : self.vss})
    self.reg_nextpc_re = Inst('reg32','reg_nextpc_re', map={'wen': self.load_se, 'ck' : self.ck ,'i0' : nextpc_rd,'q' : nextpc_re,'vdd' : self.vdd, 'vss' : self.vss})
    self.reg_res_re    = Inst('reg32','reg_res_re'   , map={'wen': self.load_se, 'ck' : self.ck ,'i0' : res_se,'q' : res_re,'vdd' : self.vdd, 'vss' : self.vss})
    self.reg_wdata_re  = Inst('reg32','reg_wdata_re' , map={'wen': self.load_se, 'ck' : self.ck ,'i0' : toper_se,'q' : wdata_re,'vdd' : self.vdd, 'vss' : self.vss})

   #redopc : block (ck_sx = '1' and not ck_sx'stable)
   #begin
   #  redopc_re <= guarded redopc_re   when (wredopc_se  = '0') else pc_rd ;
   #end block;
    self.reg_redopc_re = Inst('reg32','reg_redopc_re', map={'wen':self.wredopc_se, 'ck' : self.ck ,'i0' : pc_rd,'q' : redopc_re,'vdd' : self.vdd, 'vss' : self.vss}) 


   ### ------------------------------------------------------ ###
   #   assign registers (those related to a pipeline cycle)     #
   # memory access cycle                                        #
   ### ------------------------------------------------------ ###

   #mem_cycle : block (ck_sx = '1' and not ck_sx'stable)
   #begin
   #  i_rm       <= guarded nop_i      when (bubble_sm = '1') else # VBE A ENLEVER
   #                        i_rm       when (hold_sm   = '1') else
   #                        i_re       ;
   #  data_rm    <= guarded data_rm    when (keep_sm   = '1') else -- not(keep_sm) = load_sm
   #                        data_sm    ;
   #end block;
    self.reg_data_rm = Inst('reg32','reg_data_rm', map={'wen' : self.load_sm, 'ck' : self.ck ,'i0' : data_sm,'q' : data_rm,'vdd' : self.vdd, 'vss' : self.vss}) 

   #badvadr : block (ck_sx = '1' and not ck_sx'stable)
   #begin
   #  badvadr_rm <= guarded res_re     when (badda_xm = '1') else
   #                        nextpc_re  when (badia_xm = '1') else
   #                        badvadr_rm ;
   #end block;
    self.mux32_badvadr_rm0 = Inst('mux32','mux32_badvadr_rm0', map={'i0' :  badvadr_rm, 'i1' : nextpc_re, 'cmd' : self.badia_xm, 'q' : badvadr_rm0, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.mux32_badvadr_rm1 = Inst('mux32','mux32_badvadr_rm1', map={'i0' :  badvadr_rm0, 'i1' : res_re, 'cmd' : self.badda_xm, 'q' : badvadr_rm1, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.reg_badvadr_rm = Inst('reg32','reg_badvadr_rm', map={'wen' : const1_1c, 'ck' : self.ck ,'i0' : badvadr_rm1,'q' : badvadr_rm,'vdd' : self.vdd, 'vss' : self.vss}) 


   ### ------------------------------------------------------ ###
   #   assign registers (those related to a pipeline cycle)     #
   # write back cycle                                           #
   #                                                            #
   #     - low and high registers                               #
   #     - integer registers                                    #
   ### ------------------------------------------------------ ###

   #lo : block (ck_sx = '1' and not ck_sx'stable and wlo_sw = '1')
   #begin
   #  lo_rw <= guarded data_rm;
   #end block;
   #
   #hi : block (ck_sx = '1' and not ck_sx'stable and whi_sw = '1')
   #begin
   #  hi_rw <= guarded data_rm;
   #end block;
    self.reg_lo_rw = Inst('reg32','reg_lo_rw', map={'wen' : self.wlo_sw, 'ck' : self.ck ,'i0' : data_rm,'q' : lo_rw,'vdd' : self.vdd, 'vss' : self.vss}) 
    self.reg_hi_rw = Inst('reg32','reg_hi_rw', map={'wen' : self.whi_sw, 'ck' : self.ck ,'i0' : data_rm,'q' : hi_rw,'vdd' : self.vdd, 'vss' : self.vss}) 

    self.banc = Inst('banc','banc', map={'ck' : self.ck, 'sel' : const0_1c, 'sela': self.rsdnbr_sd, 'selb' : self.rtdnbr_sd, 'selw' : self.wreg_sw, 'datain0' : data_rm,'datain1' : data_rm, 'dataouta': s_sd,'dataoutb': t_sd, 'vdd' : self.vdd, 'vss' : self.vss}) 
   #r1  : block (ck_sx = '1' and not ck_sx'stable and wreg_sw ( 1) = '1')
   #begin
   #  r1_rw  <= guarded data_rm;
   #end block;
   #
   #r2  : block (ck_sx = '1' and not ck_sx'stable and wreg_sw ( 2) = '1')
   #begin
   #  r2_rw  <= guarded data_rm;
   #end block;
   #
   #r3  : block (ck_sx = '1' and not ck_sx'stable and wreg_sw ( 3) = '1')
   #begin
   #  r3_rw  <= guarded data_rm;
   #end block;
   #
   #r4  : block (ck_sx = '1' and not ck_sx'stable and wreg_sw ( 4) = '1')
   #begin
   #  r4_rw  <= guarded data_rm;
   #end block;
   #
   #r5  : block (ck_sx = '1' and not ck_sx'stable and wreg_sw ( 5) = '1')
   #begin
   #  r5_rw  <= guarded data_rm;
   #end block;
   #
   #r6  : block (ck_sx = '1' and not ck_sx'stable and wreg_sw ( 6) = '1')
   #begin
   #  r6_rw  <= guarded data_rm;
   #end block;
   #
   #r7  : block (ck_sx = '1' and not ck_sx'stable and wreg_sw ( 7) = '1')
   #begin
   #  r7_rw  <= guarded data_rm;
   #end block;
   #
   #r8  : block (ck_sx = '1' and not ck_sx'stable and wreg_sw ( 8) = '1')
   #begin
   #  r8_rw  <= guarded data_rm;
   #end block;
   #
   #r9  : block (ck_sx = '1' and not ck_sx'stable and wreg_sw ( 9) = '1')
   #begin
   #  r9_rw  <= guarded data_rm;
   #end block;
   #
   #r10 : block (ck_sx = '1' and not ck_sx'stable and wreg_sw (10) = '1')
   #begin
   #  r10_rw <= guarded data_rm;
   #end block;
   #
   #r11 : block (ck_sx = '1' and not ck_sx'stable and wreg_sw (11) = '1')
   #begin
   #  r11_rw <= guarded data_rm;
   #end block;
   #
   #r12 : block (ck_sx = '1' and not ck_sx'stable and wreg_sw (12) = '1')
   #begin
   #  r12_rw <= guarded data_rm;
   #end block;
   #
   #r13 : block (ck_sx = '1' and not ck_sx'stable and wreg_sw (13) = '1')
   #begin
   #  r13_rw <= guarded data_rm;
   #end block;
   #
   #r14 : block (ck_sx = '1' and not ck_sx'stable and wreg_sw (14) = '1')
   #begin
   #  r14_rw <= guarded data_rm;
   #end block;
   #
   #r15 : block (ck_sx = '1' and not ck_sx'stable and wreg_sw (15) = '1')
   #begin
   #  r15_rw <= guarded data_rm;
   #end block;
   #
   #r16 : block (ck_sx = '1' and not ck_sx'stable and wreg_sw (16) = '1')
   #begin
   #  r16_rw <= guarded data_rm;
   #end block;
   #
   #r17 : block (ck_sx = '1' and not ck_sx'stable and wreg_sw (17) = '1')
   #begin
   #  r17_rw <= guarded data_rm;
   #end block;
   #
   #r18 : block (ck_sx = '1' and not ck_sx'stable and wreg_sw (18) = '1')
   #begin
   #  r18_rw <= guarded data_rm;
   #end block;
   #
   #r19 : block (ck_sx = '1' and not ck_sx'stable and wreg_sw (19) = '1')
   #begin
   #  r19_rw <= guarded data_rm;
   #end block;
   #
   #r20 : block (ck_sx = '1' and not ck_sx'stable and wreg_sw (20) = '1')
   #begin
   #  r20_rw <= guarded data_rm;
   #end block;
   #
   #r21 : block (ck_sx = '1' and not ck_sx'stable and wreg_sw (21) = '1')
   #begin
   #  r21_rw <= guarded data_rm;
   #end block;
   #
   #r22 : block (ck_sx = '1' and not ck_sx'stable and wreg_sw (22) = '1')
   #begin
   #  r22_rw <= guarded data_rm;
   #end block;
   #
   #r23 : block (ck_sx = '1' and not ck_sx'stable and wreg_sw (23) = '1')
   #begin
   #  r23_rw <= guarded data_rm;
   #end block;
   #
   #r24 : block (ck_sx = '1' and not ck_sx'stable and wreg_sw (24) = '1')
   #begin
   #  r24_rw <= guarded data_rm;
   #end block;
   #
   #r25 : block (ck_sx = '1' and not ck_sx'stable and wreg_sw (25) = '1')
   #begin
   #  r25_rw <= guarded data_rm;
   #end block;
   #
   #r26 : block (ck_sx = '1' and not ck_sx'stable and wreg_sw (26) = '1')
   #begin
   #  r26_rw <= guarded data_rm;
   #end block;
   #
   #r27 : block (ck_sx = '1' and not ck_sx'stable and wreg_sw (27) = '1')
   #begin
   #  r27_rw <= guarded data_rm;
   #end block;
   #
   #r28 : block (ck_sx = '1' and not ck_sx'stable and wreg_sw (28) = '1')
   #begin
   #  r28_rw <= guarded data_rm;
   #end block;
   #
   #r29 : block (ck_sx = '1' and not ck_sx'stable and wreg_sw (29) = '1')
   #begin
   #  r29_rw <= guarded data_rm;
   #end block;
   #
   #r30 : block (ck_sx = '1' and not ck_sx'stable and wreg_sw (30) = '1')
   #begin
   #  r30_rw <= guarded data_rm;
   #end block;
   #
   #r31 : block (ck_sx = '1' and not ck_sx'stable and wreg_sw (31) = '1')
   #begin
   #  r31_rw <= guarded data_rm;
   #end block;


   ### ------------------------------------------------------ ###
   #   assign the the coprocessor zero's registers :            #
   #     the exception program counter register                 #
   ### ------------------------------------------------------ ###

   #epc : block (ck_sx = '1' and not ck_sx'stable)
   #begin
   #  epc_rx <= guarded epc_xm when (wepc_xm = '1') else
   #                    epc_xx when (wepc_xx = '1') else
   #                    epc_rx ;
   #end block;
    self.mux32_epc_rx0 = Inst('mux32','mux32_epc_rx0', map={'i0' :  epc_rx, 'i1' : epc_xx, 'cmd' : self.wepc_xx, 'q' : epc_rx0, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.mux32_epc_rx  = Inst('mux32','mux32_epc_rx' , map={'i0' :  epc_rx0, 'i1' : epc_xm, 'cmd' : self.wepc_xm, 'q' : epc_rx1, 'vdd' : self.vdd, 'vss' : self.vss}) 
    self.reg_epc_rx    = Inst('reg32','reg_epc_rx'   , map={'wen': const1_1d, 'ck' : self.ck ,'i0' : epc_rx1,'q' : epc_rx,'vdd' : self.vdd, 'vss' : self.vss}) 


   ### ------------------------------------------------------ ###
   #   assign the the coprocessor zero's registers :            #
   #     processor revision identifier register                 #
   ### ------------------------------------------------------ ###

   ### ------------------------------------------------------ ###
   #   assign outputs                                           #
   ### ------------------------------------------------------ ###

   #s_31_sd  <= soper_sd(31);
    self.buffer1_s_31_sd = Inst('buffer1','buffer1_s_31_sd', map={'i0' : soper_sd [31], 'q' : self.s_31_sd, 'vdd' : self.vdd, 'vss' : self.vss}) 

   #s_4_0_se <= soper_se(4 downto 0);
    self.buffer5_s_4_0_se = Inst('buffer5','buffer5_s_4_0_se', map={'i0' : soper_se[4:0], 'q' : self.s_4_0_se, 'vdd' : self.vdd, 'vss' : self.vss}) 


   ### ------------------------------------------------------ ###
   #   assign outputs                                           #
   ### ------------------------------------------------------ ###

   # not needed because carith_se do not fill the adder
   #carith_32_se <= carith_se (32);
   
   # not needed because carith_se do not fill the adder
   #carith_31_se <= carith_se (31);

   #self.rarith_31_se <= rarith_se(31);
    self.buffer1_rarith_31_se = Inst('buffer1','buffer1_rarith_31_se', map={'i0' : rarith_se[31], 'q' : self.rarith_31_se, 'vdd' : self.vdd, 'vss' : self.vss}) 


   ### ------------------------------------------------------ ###
   #   assign outputs                                           #
   #     - next instruction address                             #
   ### ------------------------------------------------------ ###

   #nextpc_1_se  <= nextpc_rd ( 1);
    self.buffer1_nextpc_1_se = Inst('buffer1','buffer1_nextpc_1_se', map={'i0' : nextpc_rd [ 1], 'q' : self.nextpc_1_se, 'vdd' : self.vdd, 'vss' : self.vss}) 

   #nextpc_0_se  <= nextpc_rd ( 0);
    self.buffer1_nextpc_0_se = Inst('buffer1','buffer1_nextpc_0_se', map={'i0' : nextpc_rd [ 0], 'q' : self.nextpc_0_se, 'vdd' : self.vdd, 'vss' : self.vss}) 

   #nextpc_31_se <= nextpc_rd (31);
    self.buffer1_nextpc_31_se = Inst('buffer1','buffer1_nextpc_31_se', map={'i0' : nextpc_rd [31], 'q' : self.nextpc_31_se, 'vdd' : self.vdd, 'vss' : self.vss}) 


   ### ------------------------------------------------------ ###
   #   assign outputs                                           #
   #    - result out of execute                                 #
   ### ------------------------------------------------------ ###

   #res_sm <= res_re;
    self.buffer32_res_sm = Inst('buffer32','buffer32_res_sm', map={'i0' : res_re, 'q' : self.res_sm, 'vdd' : self.vdd, 'vss' : self.vss}) 


   ### ------------------------------------------------------ ###
   #   assign outputs (data and instruction address):           #
   ### ------------------------------------------------------ ###

   #ADDR  <= RES_RE when (DACCESS_SM = '1') else NEXTPC_RD;
    self.mux32_addr = Inst('mux32','mux32_addr', map={'i0' :  nextpc_rd, 'i1' : res_re, 'cmd' : self.daccess_sm, 'q' : self.addr, 'vdd' : self.vdd, 'vss' : self.vss}) 

   #d_a   <= res_re   ;
   #self.buffer32_d_a = Inst('buffer32','buffer32_d_a', map={'i0' : res_re, 'q' : self.d_a, 'vdd' : self.vdd, 'vss' : self.vss}) 

   #i_a   <= nextpc_rd;
   #self.buffer32_i_a = Inst('buffer32','buffer32_i_a', map={'i0' : nextpc_rd, 'q' : self.i_a, 'vdd' : self.vdd, 'vss' : self.vss}) 


   ### ------------------------------------------------------ ###
   #   assign outputs (data output buffers)                     #
   ### ------------------------------------------------------ ###

   #d_out <= wdata_re (31 downto 0);
    self.buffer32_d_out = Inst('buffer32','buffer32_d_out', map={'i0' : wdata_re [31:0], 'q' : self.d_out, 'vdd' : self.vdd, 'vss' : self.vss}) 


   ### ------------------------------------------------------ ###
   #   assign outputs (miscellaneous):                          #
   ### ------------------------------------------------------ ###

   #scout   <= '0';
    self.buffer1_scout = Inst('buffer1','buffer1_scout', map={'i0' : const0_1d, 'q' : self.scout, 'vdd' : self.vdd, 'vss' : self.vss}) 

    return


  def Layout (self):
    Place     ( self.banc                        ,NOSYM, XY(0,0) )
    PlaceTop  ( self.instconst0_1c               ,NOSYM ) 
    SetRefIns ( self.banc )
  
    PlaceRight( self.instconst0_2                ,NOSYM, offsetX=35 )
  
    PlaceRight( self.mux32_epc_rx0               ,NOSYM )
    PlaceRight( self.mux32_epc_xx                ,NOSYM )
    PlaceRight( self.mux32_epc_rx                ,NOSYM )
    PlaceRight( self.reg_epc_rx                  ,NOSYM )
    PlaceTop  ( self.instconst1_1d               ,NOSYM )
    SetRefIns ( self.reg_epc_rx )
    PlaceRight( self.mux32_epc_xm                ,NOSYM )
    PlaceRight( self.reg_redopc_re               ,SYM_X )
    PlaceRight( self.reg_pc_re                   ,NOSYM )
    PlaceRight( self.reg_pc_rd                   ,SYM_X )
    PlaceRight( self.etat32_otheri_sd_0          ,NOSYM )
    PlaceRight( self.mux32_br_epc_sd             ,NOSYM, offsetX=35 )
    PlaceRight( self.mux32_cop0op_sd             ,NOSYM )
    PlaceRight( self.reg_badvadr_rm              ,NOSYM )
    PlaceTop  ( self.instconst1_1c               ,NOSYM ) 
    SetRefIns ( self.reg_badvadr_rm )
    PlaceRight( self.mux32_badvadr_rm1           ,NOSYM )
    PlaceRight( self.mux32_badvadr_rm0           ,NOSYM )
    PlaceRight( self.reg_nextpc_re               ,NOSYM )
    PlaceRight( self.reg_pc_ri                   ,SYM_X )
    PlaceRight( self.instexcphnd_a               ,NOSYM )
    PlaceRight( self.instboothnd_a               ,NOSYM )
    PlaceRight( self.instreset_a                 ,NOSYM )
    PlaceRight( self.mux32_nextpc_xx0            ,NOSYM )
    PlaceRight( self.mux32_nextpc_xx             ,NOSYM )
    PlaceRight( self.mux32_nextpc_rd             ,NOSYM )
    PlaceRight( self.reg_nextpc_rd               ,NOSYM )
    PlaceRight( self.instaddbracry_sd            ,NOSYM )
    PlaceTop  ( self.instconst0_1a               ,NOSYM )
    SetRefIns ( self.instaddbracry_sd )
    PlaceRight( self.mux32_nextpc_sd             ,NOSYM )
    PlaceRight( self.mux32_badr_sd               ,NOSYM )
    PlaceRight( self.instconst4_32               ,NOSYM )
    PlaceRight( self.instseqadr_sd               ,NOSYM )
    PlaceTop  ( self.instconst0_1b               ,NOSYM )
    SetRefIns ( self.instseqadr_sd )
    PlaceRight( self.mux32_jadr_sd               ,NOSYM, offsetX=35 )
    PlaceRight( self.instnop_i                   ,NOSYM )
    PlaceRight( self.mux32_i_ri                  ,NOSYM )
    PlaceRight( self.reg_i_ri                    ,NOSYM )
    PlaceRight( self.etat32_otheri_sd_3          ,NOSYM )
    PlaceRight( self.mux32_effto_sd              ,NOSYM )
    PlaceRight( self.nul_s_eq_t_sd               ,NOSYM )
    PlaceRight( self.instxor2s_cp_t_sd           ,SYM_X )
    PlaceRight( self.nul_s_eq_z_sd               ,NOSYM )
    PlaceRight( self.mux32_soper_sd              ,NOSYM )
    PlaceRight( self.mux32_s_mw_sd               ,NOSYM )
    PlaceRight( self.mux32_t_mw_sd               ,NOSYM )
    PlaceRight( self.mux32_toper_sd              ,NOSYM )
    PlaceRight( self.mux32_toper_rd0             ,NOSYM )
    PlaceRight( self.reg_toper_rd                ,NOSYM )
    PlaceTop  ( self.instconst1_1b               ,NOSYM ) 
    SetRefIns ( self.reg_toper_rd )
    PlaceRight( self.mux32_soper_rd0             ,NOSYM )
    PlaceRight( self.reg_soper_rd                ,NOSYM )
    PlaceTop  ( self.instconst1_1a               ,NOSYM ) 
    SetRefIns ( self.reg_soper_rd )
    PlaceRight( self.mux32_ioper_sd              ,NOSYM )
    PlaceRight( self.reg_ioper_rd                ,NOSYM )
  
    PlaceRight( self.instand2_and_se             ,NOSYM )
    PlaceRight( self.instor2_or_se               ,NOSYM )
    PlaceRight( self.mux32_andxor_se             ,NOSYM )
    PlaceRight( self.instxor2_xor_se             ,NOSYM )
    PlaceRight( self.instinv32_or_se_not         ,NOSYM )
    PlaceRight( self.mux32_ornor_se              ,NOSYM )
    PlaceRight( self.mux32_rlogic_se             ,NOSYM , offsetX=35)
    PlaceRight( self.etat32_res_se1              ,NOSYM )
    PlaceRight( self.mux32_yoper_se              ,NOSYM )
    PlaceRight( self.addsub32_carith_se          ,NOSYM )
    PlaceRight( self.mux32_ra_rt_se              ,NOSYM )
    PlaceRight( self.etat32_res_se0              ,NOSYM )
    PlaceRight( self.instconst0_31               ,NOSYM ) 
    PlaceRight( self.etat32_res_se2              ,NOSYM )
    
    PlaceRight( self.etat32_otheri_sd_1          ,NOSYM )
    PlaceRight( self.etat32_otheri_sd_2          ,NOSYM )
    PlaceRight( self.mux32_s_mw_se               ,NOSYM )
    PlaceRight( self.mux32_soper_se              ,NOSYM )
    PlaceRight( self.mux32_t_mw_se               ,NOSYM )
    PlaceRight( self.mux32_toper_se              ,NOSYM )
    PlaceRight( self.mux32_so_to_se              ,NOSYM )
    PlaceRight( self.mux32_i_s_t_se              ,NOSYM )
    PlaceRight( self.etat32_res_se3              ,NOSYM )
    PlaceRight( self.mux32_data_e_sm             ,NOSYM, offsetX=35 )
    PlaceRight( self.mux32_data_o_sm             ,NOSYM )
  
    PlaceRight( self.mux8_reddat_sm0             ,NOSYM, offsetY=400 )
    PlaceRight( self.mux8_reddat_sm1             ,NOSYM, offsetY=400 )
    PlaceRight( self.mux8_reddat_sm2             ,NOSYM, offsetY=400 )
    
    PlaceRight( self.mux32_data_x_sm             ,NOSYM, offsetY=-1200 )
    PlaceRight( self.mux32_data_sm               ,NOSYM )
    PlaceRight( self.reg_res_re                  ,NOSYM )
    PlaceRight( self.reg_wdata_re                ,NOSYM )
    PlaceRight( self.reg_data_rm                 ,NOSYM )
    PlaceRight( self.reg_lo_rw                   ,NOSYM )
    PlaceRight( self.reg_hi_rw                   ,NOSYM )
  
    PlaceRight( self.mux32_addr                  ,NOSYM )
    PlaceRight( self.buffer32_res_sm             ,NOSYM )
   #PlaceRight( self.buffer32_d_a                ,NOSYM, offsetX=30 )
   #PlaceRight( self.buffer32_i_a                ,NOSYM, offsetX=30 )
  
    PlaceRight( self.buffer32_d_out              ,NOSYM, offsetX=35 )
  
    PlaceRight( self.buffer8_reddat_sm           ,NOSYM )
    PlaceTop  ( self.buffer5_s_4_0_se            ,NOSYM )
  
    PlaceTop  ( self.buffer1_imdsgn_sd0          ,SYM_Y )
    PlaceTop  ( self.buffer1_s_31_sd             ,NOSYM )
    PlaceTop  ( self.buffer1_rarith_31_se        ,SYM_Y )
    PlaceTop  ( self.buffer1_nextpc_0_se         ,NOSYM )
    PlaceTop  ( self.buffer1_nextpc_1_se         ,SYM_Y )
    PlaceTop  ( self.buffer1_nextpc_31_se        ,NOSYM )
    PlaceTop  ( self.buffer1_scout               ,SYM_Y )
    PlaceTop  ( self.instconst0_1d               ,NOSYM ) 
  
    SetRefIns ( self.buffer8_reddat_sm )
    PlaceRight( self.shift32_rshift_se           ,NOSYM )
    return


def scriptMain ( **kw ):
  editor = None
  if kw.has_key('editor') and kw['editor']:
    editor = kw['editor']
    setEditor( editor )

  cell = buildModel( 'mips_r3000_1m_dp', DoNetlist|DoLayout )
  return cell


if __name__ == "__main__" :
  kw = {}
  scriptMain( **kw )

  sys.exit( 0 )
