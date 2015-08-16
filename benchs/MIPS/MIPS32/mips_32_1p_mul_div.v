module mips_32_1p_mul_div(
        ck,
        reset_n,
        it_n,
        cpu_nbr,
        i_a,
        i_rq,
        i_mode,
        i_rberr,
        i_accpt,
        i_in,
        i_ack,
        i_beren,
        i_inline,
        d_a,
        d_bytsel,
        d_rq,
        d_rw,
        d_mode,
        d_sync,
        d_reg,
        d_linked,
        d_rstlkd,
        d_cache,
        d_cachop,
        d_rberr,
        d_wberr,
        d_accpt,
        d_out,
        d_in,
        d_ack,
        mcheck_n,
        test,
        scin,
        scout,
        vdd,
        vss,
        vddp,
        vssp
    );
    parameter [31:0]reset_addr  = 32'b10111111110000000000000000000000;
    parameter [31:0]bootexc_addr  = 32'b10111111110000000000001110000000;
    input ck;
    input reset_n;
    input [5:0]it_n;
    input [9:0]cpu_nbr;
    output [31:2]i_a;
    output i_rq;
    output [1:0]i_mode;
    input i_rberr;
    input i_accpt;
    input [31:0]i_in;
    output i_ack;
    output i_beren;
    output i_inline;
    output [31:2]d_a;
    output [3:0]d_bytsel;
    output d_rq;
    output d_rw;
    output [1:0]d_mode;
    output d_sync;
    output d_reg;
    output d_linked;
    output d_rstlkd;
    output d_cache;
    output [4:0]d_cachop;
    input d_rberr;
    input d_wberr;
    input d_accpt;
    output [31:0]d_out;
    input [31:0]d_in;
    output d_ack;
    input mcheck_n;
    input test;
    input scin;
    output scout;
    input vdd;
    input vss;
    input vddp;
    input vssp;
    wire [1:0]imp_sx;
    wire i_rfmt_sd;
    wire i_ifmt_sd;
    wire i_illg_sd;
    wire i_ifmt_se;
    wire i_reads_sd;
    wire i_readt_sd;
    wire i_reads_se;
    wire i_readt_se;
    wire i_duses_sd;
    wire i_duset_sd;
    wire i_euses_sd;
    wire i_euses_se;
    wire i_euset_sd;
    wire i_euset_se;
    wire i_eusel_se;
    wire i_euseh_se;
    wire i_musel_sm;
    wire i_museh_sm;
    wire i_mpdc_sm;
    wire i_wpdc_se;
    wire i_wpdc_sm;
    wire i_wpdc_sw;
    wire i_osgnd_sd;
    wire i_osgnd_se;
    wire i_arith_se;
    wire i_logic_se;
    wire i_shift_se;
    wire i_test_se;
    wire i_oper_se;
    wire i_clead_se;
    wire i_sub_se;
    wire i_shr_se;
    wire i_lt_se;
    wire i_ltu_se;
    wire i_ge_se;
    wire i_geu_se;
    wire i_eq_se;
    wire i_ne_se;
    wire i_and_se;
    wire i_nor_se;
    wire i_xor_se;
    wire i_or_se;
    wire i_soper_se;
    wire i_toper_se;
    wire i_ioper_se;
    wire i_clz_se;
    wire i_msub_se;
    wire i_mult_sm;
    wire [2:0]i_mic_se;
    wire i_cisc_se;
    wire i_ovrf_se;
    wire i_mload_se;
    wire i_mstor_se;
    wire i_load_se;
    wire i_stor_se;
    wire i_linkd_se;
    wire i_linkd_sm;
    wire i_xreg_se;
    wire i_xreg_sm;
    wire i_byte_se;
    wire i_half_se;
    wire i_word_se;
    wire i_wrdl_se;
    wire i_wrdr_se;
    wire i_brnch_sd;
    wire i_brnch_se;
    wire i_wreg_sd;
    wire i_wreg_se;
    wire i_wreg_sm;
    wire i_wreg_sw;
    wire i_wcop0_sm;
    wire i_wlo_sm;
    wire i_wlo_sw;
    wire i_whi_sm;
    wire i_whi_sw;
    wire seqi_sd;
    wire [4:0]cachop_se;
    wire [4:0]cachop_sm;
    wire effwait_sm;
    wire i_sysc_sd;
    wire syscall_xd;
    wire i_brek_sd;
    wire break_xd;
    wire i_trap_sd;
    wire inotrdy_se;
    wire [4:0]rs_sd;
    wire [4:0]rt_sd;
    wire [31:0]excadr_xm;
    wire [31:0]nextpc_xx;
    wire wredopc_se;
    wire [31:0]cause_xx;
    wire [31:0]cause_xm;
    wire [31:0]cause_sm;
    wire [31:0]cause_sx;
    wire wcause_xx;
    wire wcause_xm;
    wire [31:0]status_xx;
    wire [31:0]status_xm;
    wire [31:0]deisr_sm;
    wire wsr_xx;
    wire wsr_xm;
    wire [7:0]cop0s_sd;
    wire [7:0]cop0d_sd;
    wire [4:0]sham_sd;
    wire [4:0]cp_sde_sd;
    wire [4:0]cp_sdm_sd;
    wire [4:0]cp_sdw_sd;
    wire [4:0]cp_tde_sd;
    wire [4:0]cp_tdm_sd;
    wire [4:0]cp_tdw_sd;
    wire [4:0]cp_sdm_se;
    wire [4:0]cp_sdw_se;
    wire [4:0]cp_tdm_se;
    wire [4:0]cp_tdw_se;
    wire [31:0]s_cp_t_sd;
    wire [31:0]x_cp_y_se;
    wire dathzds_sd;
    wire hazards_sd;
    wire dathzds_se;
    wire hazards_se;
    wire dathzds_sm;
    wire hazards_sm;
    wire kill_si;
    wire stall_si;
    wire copy_si;
    wire exec_si;
    wire kill_sd;
    wire stall_sd;
    wire copy_sd;
    wire exec_sd;
    wire kill_se;
    wire stall_se;
    wire copy_se;
    wire exec_se;
    wire kill_sm;
    wire stall_sm;
    wire copy_sm;
    wire exec_sm;
    wire kill_sw;
    wire stall_sw;
    wire copy_sw;
    wire exec_sw;
    wire killed_si;
    wire killed_sd;
    wire killed_se;
    wire bubble_si;
    wire hold_si;
    wire shift_si;
    wire keep_si;
    wire load_si;
    wire bubble_sd;
    wire hold_sd;
    wire shift_sd;
    wire keep_sd;
    wire load_sd;
    wire bubble_se;
    wire hold_se;
    wire shift_se;
    wire keep_se;
    wire load_se;
    wire bubble_sm;
    wire hold_sm;
    wire shift_sm;
    wire keep_sm;
    wire load_sm;
    wire bubble_sw;
    wire hold_sw;
    wire shift_sw;
    wire keep_sw;
    wire load_sw;
    wire [31:2]seqpr0_sd;
    wire [31:2]seqpr1_sd;
    wire [31:2]seqpr2_sd;
    wire [31:2]seqpr3_sd;
    wire [31:2]seqpr4_sd;
    wire [31:2]seqpr5_sd;
    wire [31:2]seqcry_sd;
    wire [31:0]seqcyi_sd;
    wire [31:0]seqadr_sd;
    wire [31:0]braofs_sd;
    wire [31:0]brapr0_sd;
    wire [31:0]brapr1_sd;
    wire [31:0]brapr2_sd;
    wire [31:0]brapr3_sd;
    wire [31:0]brapr4_sd;
    wire [31:0]brapr5_sd;
    wire [31:0]bragn0_sd;
    wire [31:0]bragn1_sd;
    wire [31:0]bragn2_sd;
    wire [31:0]bragn3_sd;
    wire [31:0]bragn4_sd;
    wire [31:0]bragn5_sd;
    wire [31:0]bracry_sd;
    wire [31:0]bracyi_sd;
    wire [31:0]braadr_sd;
    wire [31:0]jmpadr_sd;
    wire [4:0]rd_sd;
    wire [4:0]rd_sm;
    wire [31:0]effhwre_sd;
    wire [31:0]xoper_se;
    wire [31:0]cldpr1_se;
    wire [31:0]cldpr2_se;
    wire [31:0]cldpr3_se;
    wire [31:0]cldpr4_se;
    wire [31:0]cldpr5_se;
    wire [31:0]cldmsk_se;
    wire cld_5_se;
    wire cld_4_se;
    wire cld_3_se;
    wire cld_2_se;
    wire cld_1_se;
    wire cld_0_se;
    wire [31:0]rclead_se;
    wire [31:0]aripr0_se;
    wire [31:0]aripr1_se;
    wire [31:0]aripr2_se;
    wire [31:0]aripr3_se;
    wire [31:0]aripr4_se;
    wire [31:0]aripr5_se;
    wire [31:0]arign0_se;
    wire [31:0]arign1_se;
    wire [31:0]arign2_se;
    wire [31:0]arign3_se;
    wire [31:0]arign4_se;
    wire [31:0]arign5_se;
    wire [31:0]aricyi_se;
    wire [31:0]rarith_se;
    wire [31:0]yshf_se;
    wire [31:0]shf5_t_se;
    wire [31:0]shf5_f_se;
    wire [31:0]rshift_se;
    wire [31:0]rtest_se;
    wire overflw_se;
    wire [31:0]data_se;
    wire miccopy_se;
    wire micbeg_se;
    wire xmxpp_se;
    wire ymsgn_se;
    wire xmsgn_se;
    wire zminv_se;
    wire [31:0]xmul_se;
    wire [63:0]zmopr_sm;
    wire [63:0]xx00mul_se;
    wire [63:0]xx01mul_se;
    wire [63:0]xx02mul_se;
    wire [63:0]xx03mul_se;
    wire [63:0]xx04mul_se;
    wire [63:0]xx05mul_se;
    wire [63:0]xx06mul_se;
    wire [63:0]xx07mul_se;
    wire [63:0]xx08mul_se;
    wire [63:0]xx09mul_se;
    wire [63:0]xx10mul_se;
    wire [63:0]xx11mul_se;
    wire [63:0]xx12mul_se;
    wire [63:0]xx13mul_se;
    wire [63:0]xx14mul_se;
    wire [63:0]xx15mul_se;
    wire [63:0]xx16mul_se;
    wire [63:0]xx17mul_se;
    wire [63:0]xx18mul_se;
    wire [63:0]xx19mul_se;
    wire [63:0]xx20mul_se;
    wire [63:0]xx21mul_se;
    wire [63:0]xx22mul_se;
    wire [63:0]xx23mul_se;
    wire [63:0]xx24mul_se;
    wire [63:0]xx25mul_se;
    wire [63:0]xx26mul_se;
    wire [63:0]xx27mul_se;
    wire [63:0]xx28mul_se;
    wire [63:0]xx29mul_se;
    wire [63:0]xx30mul_se;
    wire [63:0]xx31mul_se;
    wire [63:0]s00mul0_se;
    wire [63:0]s01mul0_se;
    wire [63:0]s02mul0_se;
    wire [63:0]s03mul0_se;
    wire [63:0]s04mul0_se;
    wire [63:0]s05mul0_se;
    wire [63:0]s06mul0_se;
    wire [63:0]s07mul0_se;
    wire [63:0]c00mul0_se;
    wire [63:0]c01mul0_se;
    wire [63:0]c02mul0_se;
    wire [63:0]c03mul0_se;
    wire [63:0]c04mul0_se;
    wire [63:0]c05mul0_se;
    wire [63:0]c06mul0_se;
    wire [63:0]c07mul0_se;
    wire [63:0]s00mul1_se;
    wire [63:0]s01mul1_se;
    wire [63:0]s02mul1_se;
    wire [63:0]s03mul1_se;
    wire [63:0]s04mul1_se;
    wire [63:0]s05mul1_se;
    wire [63:0]s06mul1_se;
    wire [63:0]s07mul1_se;
    wire [63:0]c00mul1_se;
    wire [63:0]c01mul1_se;
    wire [63:0]c02mul1_se;
    wire [63:0]c03mul1_se;
    wire [63:0]c04mul1_se;
    wire [63:0]c05mul1_se;
    wire [63:0]c05mul1_sm;
    wire [63:0]c06mul1_se;
    wire [63:0]c07mul1_se;
    wire [63:0]c07mul1_sm;
    wire [63:0]s00mul2_se;
    wire [63:0]s00mul2_sm;
    wire [63:0]s01mul2_se;
    wire [63:0]s01mul2_sm;
    wire [63:0]s02mul2_se;
    wire [63:0]s02mul2_sm;
    wire [63:0]s03mul2_se;
    wire [63:0]s03mul2_sm;
    wire [63:0]s04mul2_se;
    wire [63:0]s04mul2_sm;
    wire [63:0]c00mul2_se;
    wire [63:0]c00mul2_sm;
    wire [63:0]c01mul2_se;
    wire [63:0]c01mul2_sm;
    wire [63:0]c02mul2_se;
    wire [63:0]c02mul2_sm;
    wire [63:0]c03mul2_se;
    wire [63:0]c03mul2_sm;
    wire [63:0]c04mul2_se;
    wire [63:0]c04mul2_sm;
    wire [63:0]s00mul3_sm;
    wire [63:0]s01mul3_sm;
    wire [63:0]s02mul3_sm;
    wire [63:0]s03mul3_sm;
    wire [63:0]c00mul3_sm;
    wire [63:0]c01mul3_sm;
    wire [63:0]c02mul3_sm;
    wire [63:0]c03mul3_sm;
    wire [63:0]s00mul4_sm;
    wire [63:0]s01mul4_sm;
    wire [63:0]s02mul4_sm;
    wire [63:0]c00mul4_sm;
    wire [63:0]c01mul4_sm;
    wire [63:0]c02mul4_sm;
    wire [63:0]s00mul5_sm;
    wire [63:0]s01mul5_sm;
    wire [63:0]c00mul5_sm;
    wire [63:0]c01mul5_sm;
    wire [63:0]s00mul6_sm;
    wire [63:0]c00mul6_sm;
    wire [63:0]s00mul7_sm;
    wire [63:0]s00mul7_sw;
    wire [63:0]c00mul7_sm;
    wire [63:0]c00mul7_sw;
    wire [63:0]mulpr0_sw;
    wire [63:0]mulpr1_sw;
    wire [63:0]mulpr2_sw;
    wire [63:0]mulpr3_sw;
    wire [63:0]mulpr4_sw;
    wire [63:0]mulpr5_sw;
    wire [63:0]mulpr6_sw;
    wire [63:0]mulgn0_sw;
    wire [63:0]mulgn1_sw;
    wire [63:0]mulgn2_sw;
    wire [63:0]mulgn3_sw;
    wire [63:0]mulgn4_sw;
    wire [63:0]mulgn5_sw;
    wire [63:0]mulgn6_sw;
    wire [63:0]mulcry_sw;
    wire [63:0]mulcyi_sw;
    wire [63:0]mulsum_sw;
    wire [31:0]xdiv_se;
    wire [31:0]ydiv_se;
    wire divxsgn_se;
    wire divysgn_se;
    wire divqsgn_se;
    wire [31:0]divrpr0_se;
    wire [31:0]divrpr1_se;
    wire [31:0]divrpr2_se;
    wire [31:0]divrpr3_se;
    wire [31:0]divrpr4_se;
    wire [31:0]divrpr5_se;
    wire [31:0]divrcry_se;
    wire [31:0]divrcyi_se;
    wire [31:0]divrneg_se;
    wire [31:0]divqpr0_se;
    wire [31:0]divqpr1_se;
    wire [31:0]divqpr2_se;
    wire [31:0]divqpr3_se;
    wire [31:0]divqpr4_se;
    wire [31:0]divqpr5_se;
    wire [31:0]divqcry_se;
    wire [31:0]divqcyi_se;
    wire [31:0]divqneg_se;
    wire [31:0]divxzp1_se;
    wire [31:0]divxzp2_se;
    wire [31:0]divxzp3_se;
    wire [31:0]divxzp4_se;
    wire [31:0]divxzp5_se;
    wire [31:0]divxzmk_se;
    wire divxcz5_se;
    wire divxcz4_se;
    wire divxcz3_se;
    wire divxcz2_se;
    wire divxcz1_se;
    wire divxcz0_se;
    wire [5:0]divxcz_se;
    wire [31:0]divyzp1_se;
    wire [31:0]divyzp2_se;
    wire [31:0]divyzp3_se;
    wire [31:0]divyzp4_se;
    wire [31:0]divyzp5_se;
    wire [31:0]divyzmk_se;
    wire divycz5_se;
    wire divycz4_se;
    wire divycz3_se;
    wire divycz2_se;
    wire divycz1_se;
    wire divycz0_se;
    wire [5:0]divycz_se;
    wire [5:0]divscyi_se;
    wire [5:0]divscry_se;
    wire [5:0]divscnt_se;
    wire [4:0]divysha_se;
    wire [31:0]divyshr_se;
    wire [31:0]divdpr0_se;
    wire [31:0]divdpr1_se;
    wire [31:0]divdpr2_se;
    wire [31:0]divdpr3_se;
    wire [31:0]divdpr4_se;
    wire [31:0]divdpr5_se;
    wire [31:0]divdgn0_se;
    wire [31:0]divdgn1_se;
    wire [31:0]divdgn2_se;
    wire [31:0]divdgn3_se;
    wire [31:0]divdgn4_se;
    wire [31:0]divdgn5_se;
    wire [31:0]divdcry_se;
    wire [31:0]divdcyi_se;
    wire [31:0]divdif_se;
    wire [31:0]divlpr0_se;
    wire [31:0]divlpr1_se;
    wire [31:0]divlpr2_se;
    wire [31:0]divlpr3_se;
    wire [31:0]divlpr4_se;
    wire [31:0]divlpr5_se;
    wire [31:0]divlgn0_se;
    wire [31:0]divlgn1_se;
    wire [31:0]divlgn2_se;
    wire [31:0]divlgn3_se;
    wire [31:0]divlgn4_se;
    wire [31:0]divlgn5_se;
    wire divleu_se;
    wire [31:0]divqshl_se;
    wire daccess_se;
    wire write_se;
    wire read_se;
    wire dnotrdy_sm;
    wire [1:0]bytadr_sm;
    wire [31:0]scdin_sm;
    wire wbadia_xm;
    wire wbadda_xm;
    wire [5:0]it_xx;
    wire [7:0]itmask_xx;
    wire [7:0]enblit_xx;
    wire bdslot_xi;
    wire rsvdins_xd;
    wire rsvdins_xe;
    wire iamalgn_xi;
    wire lamalgn_xe;
    wire samalgn_xe;
    wire lasviol_xe;
    wire sasviol_xe;
    wire iabuser_xi;
    wire dabuser_xm;
    wire mcheckx_xx;
    wire earlyex_xe;
    wire lateex_xm;
    wire excrq_xm;
    wire [31:0]epc_sm;
    wire [31:0]eepc_sm;
    wire weepc_xx;
    wire [31:0]ebase_xx;
    wire webase_xx;
    wire [31:0]cntcyi_sx;
    wire [31:0]cntcry_sx;
    wire [31:0]cntpr0_sx;
    wire [31:0]cntpr1_sx;
    wire [31:0]cntpr2_sx;
    wire [31:0]cntpr3_sx;
    wire [31:0]cntpr4_sx;
    wire [31:0]cntpr5_sx;
    wire [31:0]count_sx;
    wire [31:0]count_sm;
    wire wcount_sx;
    wire [31:0]tcctx_sm;
    localparam r0_rw  = 8'b00000000;
    localparam prid_rx  = 8'b00000000;
    localparam nop_i  = 8'b00000000;
    wire [40:0]nop_type;
    localparam iline_msk  = 32'b11111111111111111111111111000011;
    localparam m_writ_w  = 2'b00;
    localparam m_writ_h  = 2'b10;
    localparam m_writ_b  = 2'b11;
    localparam m_read_w  = 2'b01;
    localparam bootexc_a  = bootexc_addr;
    localparam reset_a  = reset_addr;
    localparam c0_badva  = 8'b01000000;
    localparam c0_count  = 8'b01001000;
    localparam c0_status  = 8'b01100000;
    localparam c0_cause  = 8'b01101000;
    localparam c0_epc  = 8'b01110000;
    localparam c0_prid  = 8'b01111000;
    localparam c0_ebase  = 8'b01111001;
    localparam c0_eepc  = 8'b11110000;
    localparam c0_tcctx  = 8'b00010101;
    localparam c0_usrlcl  = 8'b00100010;
    localparam c0_hwrena  = 8'b00111000;
    localparam hw_count  = 5'b00010;
    localparam hw_cpunbr  = 5'b00000;
    localparam hw_usrlcl  = 5'b11101;
    localparam r_fmt_o  = 4'b0001;
    localparam i_fmt_o  = 4'b0010;
    localparam j_fmt_o  = 4'b0100;
    localparam illgl_o  = 4'b1000;
    localparam du_s_o  = 2'b10;
    localparam eu_s_o  = 2'b01;
    localparam no_s_o  = 2'b00;
    localparam du_t_o  = 2'b10;
    localparam eu_t_o  = 2'b01;
    localparam no_t_o  = 2'b00;
    localparam eu_h_o  = 2'b10;
    localparam mu_h_o  = 2'b01;
    localparam no_h_o  = 2'b00;
    localparam eu_l_o  = 2'b10;
    localparam mu_l_o  = 2'b01;
    localparam no_l_o  = 2'b00;
    localparam o_sgn_o  = 1'b1;
    localparam o_usg_o  = 1'b0;
    localparam add_o  = 5'b10000;
    localparam sub_o  = 5'b10010;
    localparam shl_o  = 6'b100000;
    localparam shr_o  = 6'b100010;
    localparam eq_o  = 6'b110000;
    localparam ne_o  = 6'b110100;
    localparam ltu_o  = 6'b110010;
    localparam geu_o  = 6'b110110;
    localparam lt_o  = 6'b111010;
    localparam ge_o  = 6'b111110;
    localparam or_o  = 7'b1000000;
    localparam and_o  = 7'b1000010;
    localparam xor_o  = 7'b1000100;
    localparam nor_o  = 7'b1000110;
    localparam toper_o  = 7'b1010010;
    localparam soper_o  = 7'b1010100;
    localparam ioper_o  = 7'b1010000;
    localparam clo_o  = 7'b1100000;
    localparam clz_o  = 7'b1100010;
    localparam msub_o  = 2'b10;
    localparam madd_o  = 3'b100;
    localparam mult_o  = 1'b0;
    localparam div_o  = 2'b11;
    localparam ovr_o  = 4'b0001;
    localparam trp_o  = 4'b0010;
    localparam sys_o  = 4'b0100;
    localparam brk_o  = 4'b1000;
    localparam nox_o  = 4'b0000;
    localparam e_pd_o  = 3'b100;
    localparam m_pd_o  = 3'b010;
    localparam w_pd_o  = 3'b001;
    localparam no_pd_o  = 3'b000;
    localparam s_i_o  = 4'b0001;
    localparam s_l_o  = 4'b0010;
    localparam s_h_o  = 4'b0100;
    localparam s_hl_o  = 4'b0110;
    localparam s_c_o  = 4'b1000;
    localparam no_sv_o  = 4'b0000;
    localparam no_br_o  = 1'b0;
    localparam brnch_o  = 1'b1;
    localparam m_lwd_o  = 9'b100000100;
    localparam m_lwl_o  = 9'b100000001;
    localparam m_lwr_o  = 9'b100000010;
    localparam m_lhf_o  = 9'b100001000;
    localparam m_lby_o  = 9'b100010000;
    localparam m_swd_o  = 9'b010000100;
    localparam m_swl_o  = 9'b010000001;
    localparam m_swr_o  = 9'b010000010;
    localparam m_shf_o  = 9'b010001000;
    localparam m_sby_o  = 9'b010010000;
    localparam m_llk_o  = 9'b101000100;
    localparam m_slk_o  = 9'b111000100;
    localparam m_lrg_o  = 9'b100100100;
    localparam m_srg_o  = 9'b010100100;
    localparam no_m_o  = 9'b000000000;
    localparam imp_std  = 2'b00;
    localparam imp_tsr  = 2'b01;
    localparam exe_end  = 3'b000;
    localparam div_clz  = 3'b001;
    localparam div_cnt  = 3'b010;
    localparam div_shl  = 3'b011;
    localparam div_dif  = 3'b100;
    localparam div_lst  = 3'b101;
    localparam special_g  = 3'b000;
    localparam special2_g  = 3'b010;
    localparam special3_g  = 3'b011;
    localparam others_g  = 3'b001;
    localparam bcond_g  = 4'b1000;
    localparam cop0_g  = 2'b10;
    localparam cop2_g  = 2'b11;
    localparam special_i  = 1'b0;
    localparam special2_i  = 5'b11100;
    localparam special3_i  = 5'b11111;
    localparam bcond_i  = 1'b1;
    localparam cop0_i  = 5'b10000;
    localparam cop2_i  = 5'b10010;
    localparam add_i  = 6'b100000;
    localparam addi_i  = 7'b1001000;
    localparam addiu_i  = 7'b1001001;
    localparam addu_i  = 6'b100001;
    localparam and_i  = 6'b100100;
    localparam andi_i  = 7'b1001100;
    localparam beq_i  = 7'b1000100;
    localparam bgez_i  = 9'b100000001;
    localparam bgezal_i  = 9'b100010001;
    localparam bgtz_i  = 7'b1000111;
    localparam blez_i  = 7'b1000110;
    localparam bltz_i  = 9'b100000000;
    localparam bltzal_i  = 9'b100010000;
    localparam bne_i  = 7'b1000101;
    localparam break_i  = 4'b1101;
    localparam cache_i  = 7'b1101111;
    localparam clo_i  = 8'b10100001;
    localparam clz_i  = 8'b10100000;
    localparam div_i  = 5'b11010;
    localparam divu_i  = 5'b11011;
    localparam eret_i  = 9'b101011000;
    localparam j_i  = 7'b1000010;
    localparam jal_i  = 7'b1000011;
    localparam jalr_i  = 4'b1001;
    localparam jr_i  = 4'b1000;
    localparam lb_i  = 7'b1100000;
    localparam lbu_i  = 7'b1100100;
    localparam ll_i  = 7'b1110000;
    localparam lh_i  = 7'b1100001;
    localparam lhu_i  = 7'b1100101;
    localparam lui_i  = 7'b1001111;
    localparam lw_i  = 7'b1100011;
    localparam lwl_i  = 7'b1100010;
    localparam lwr_i  = 7'b1100110;
    localparam madd_i  = 8'b10000000;
    localparam maddu_i  = 8'b10000001;
    localparam mfc0_i  = 9'b100100000;
    localparam mfc2_i  = 9'b110100000;
    localparam mflo_i  = 5'b10010;
    localparam mfhi_i  = 5'b10000;
    localparam mfmc0_i  = 9'b100101011;
    localparam movn_i  = 4'b1011;
    localparam movz_i  = 4'b1010;
    localparam msub_i  = 8'b10000100;
    localparam msubu_i  = 8'b10000101;
    localparam mtc0_i  = 9'b100100100;
    localparam mtc2_i  = 9'b110100100;
    localparam mtlo_i  = 5'b10011;
    localparam mthi_i  = 5'b10001;
    localparam mul_i  = 8'b10000010;
    localparam mult_i  = 5'b11000;
    localparam multu_i  = 5'b11001;
    localparam nor_i  = 6'b100111;
    localparam or_i  = 6'b100101;
    localparam ori_i  = 7'b1001101;
    localparam pref_i  = 7'b1110011;
    localparam rdhwr_i  = 8'b11111011;
    localparam sb_i  = 7'b1101000;
    localparam sc_i  = 7'b1111000;
    localparam sh_i  = 7'b1101001;
    localparam sll_i  = 1'b0;
    localparam sllv_i  = 3'b100;
    localparam slt_i  = 6'b101010;
    localparam slti_i  = 7'b1001010;
    localparam sltiu_i  = 7'b1001011;
    localparam sltu_i  = 6'b101011;
    localparam srl_i  = 2'b10;
    localparam srlv_i  = 3'b110;
    localparam sra_i  = 2'b11;
    localparam srav_i  = 3'b111;
    localparam sub_i  = 6'b100010;
    localparam subu_i  = 6'b100011;
    localparam sw_i  = 7'b1101011;
    localparam swl_i  = 7'b1101010;
    localparam swr_i  = 7'b1101110;
    localparam sync_i  = 4'b1111;
    localparam syscall_i  = 4'b1100;
    localparam teq_i  = 6'b110100;
    localparam teqi_i  = 9'b100001100;
    localparam tge_i  = 6'b110000;
    localparam tgei_i  = 9'b100001000;
    localparam tgeiu_i  = 9'b100001001;
    localparam tgeu_i  = 6'b110001;
    localparam tlt_i  = 6'b110010;
    localparam tlti_i  = 9'b100001010;
    localparam tltiu_i  = 9'b100001011;
    localparam tltu_i  = 6'b110011;
    localparam tne_i  = 6'b110110;
    localparam tnei_i  = 9'b100001110;
    localparam wait_i  = 9'b101100000;
    localparam xor_i  = 6'b100110;
    localparam xori_i  = 7'b1001110;
    reg impstd_sx;
    reg imptsr_sx;
    reg [8:0]cop0_sd;
    reg [8:0]cop2_sd;
    reg [8:0]opcod_sd;
    reg [40:0]i_type_sd;
    reg eret_sd;
    reg eret_se;
    reg eret_sm;
    reg mfc0_sd;
    reg mtc0_sd;
    reg mtc0_se;
    reg mtc0_sm;
    reg mfmc0_sd;
    reg mfmc0_se;
    reg mfmc0_sm;
    reg mfc2_sd;
    reg mfc2_se;
    reg mtc2_sd;
    reg mtc2_se;
    reg wait_sd;
    reg wait_se;
    reg wait_sm;
    reg sync_se;
    reg cach_se;
    reg rdhwr_se;
    reg iasviol_xi;
    reg iberen_sx;
    reg wr31_sd;
    reg [31:0]s_sd;
    reg [31:0]t_sd;
    reg sreadr0_sd;
    reg treadr0_sd;
    reg hz_sde_sd;
    reg hz_sdm_sd;
    reg hz_sdw_sd;
    reg hz_tde_sd;
    reg hz_tdm_sd;
    reg hz_tdw_sd;
    reg inshzds_sd;
    reg [31:0]soper_sd;
    reg [31:0]toper_sd;
    reg [31:0]cop0op_sd;
    reg [31:0]hwrop_sd;
    reg [15:0]imdsex_sd;
    reg [31:0]ioper_sd;
    reg [31:0]retadr_sd;
    reg s_eq_t_sd;
    reg s_lt_z_sd;
    reg s_le_z_sd;
    reg [31:0]nextpc_sd;
    reg iinlin_sd;
    reg [4:0]effrd_sd;
    reg [31:0]rddec_sd;
    reg usrmod_sx;
    reg cpunuse_xd;
    reg [1:0]cpnbr_xd;
    reg irq_se;
    reg sreadr0_se;
    reg treadr0_se;
    reg hz_sdm_se;
    reg hz_sdw_se;
    reg hz_tdm_se;
    reg hz_tdw_se;
    reg hz_lo_se;
    reg hz_hi_se;
    reg [31:0]soper_se;
    reg [31:0]toper_se;
    reg [31:0]ioper_se;
    reg t_eq_z_se;
    reg cndwrg_se;
    reg [4:0]rd_se;
    reg [31:0]yoper_se;
    reg [31:0]cldxop_se;
    reg [31:0]xarith_se;
    reg [31:0]yarith_se;
    reg [31:0]aricry_se;
    reg x_eq_y_se;
    reg x_lt_y_se;
    reg x_ltu_y_se;
    reg testbit_se;
    reg [4:0]xshf_se;
    reg [31:0]shsgn_se;
    reg [31:0]shf0_t_se;
    reg [31:0]shf1_t_se;
    reg [31:0]shf2_t_se;
    reg [31:0]shf3_t_se;
    reg [31:0]shf4_t_se;
    reg [31:0]shf0_f_se;
    reg [31:0]shf1_f_se;
    reg [31:0]shf2_f_se;
    reg [31:0]shf3_f_se;
    reg [31:0]shf4_f_se;
    reg [5:0]sham_se;
    reg [31:0]shf0_se;
    reg [31:0]shf1_se;
    reg [31:0]shf2_se;
    reg [31:0]shf3_se;
    reg [31:0]shf4_se;
    reg [31:0]shf5_se;
    reg [31:0]rlogic_se;
    reg [31:0]roper_se;
    reg [31:0]res_se;
    reg [31:0]xmext_se;
    reg [31:0]ymul_se;
    reg [63:0]pp00mul_se;
    reg [63:0]pp01mul_se;
    reg [63:0]pp02mul_se;
    reg [63:0]pp03mul_se;
    reg [63:0]pp04mul_se;
    reg [63:0]pp05mul_se;
    reg [63:0]pp06mul_se;
    reg [63:0]pp07mul_se;
    reg [63:0]pp08mul_se;
    reg [63:0]pp09mul_se;
    reg [63:0]pp10mul_se;
    reg [63:0]pp11mul_se;
    reg [63:0]pp12mul_se;
    reg [63:0]pp13mul_se;
    reg [63:0]pp14mul_se;
    reg [63:0]pp15mul_se;
    reg [63:0]pp16mul_se;
    reg [63:0]pp17mul_se;
    reg [63:0]pp18mul_se;
    reg [63:0]pp19mul_se;
    reg [63:0]pp20mul_se;
    reg [63:0]pp21mul_se;
    reg [63:0]pp22mul_se;
    reg [63:0]pp23mul_se;
    reg [63:0]pp24mul_se;
    reg [63:0]pp25mul_se;
    reg [63:0]pp26mul_se;
    reg [63:0]pp27mul_se;
    reg [63:0]pp28mul_se;
    reg [63:0]pp29mul_se;
    reg [63:0]pp30mul_se;
    reg [63:0]pp31mul_se;
    reg [63:0]ppxxmul_se;
    reg [63:0]zmul_sm;
    reg [63:0]ppzzmul_sm;
    reg [63:0]rmul_sw;
    reg [2:0]nextmic_se;
    reg micend_se;
    reg miclst_se;
    reg [31:0]divrx_se;
    reg [31:0]divqy_se;
    reg [31:0]divx_se;
    reg [31:0]divy_se;
    reg [31:0]divq_se;
    reg [5:0]divxclz_se;
    reg [5:0]divyclz_se;
    reg [31:0]divxeff_se;
    reg [31:0]divyeff_se;
    reg [31:0]divreff_se;
    reg [31:0]divqeff_se;
    reg divscnz_se;
    reg [31:0]divyshl_se;
    reg drq_se;
    reg drstlk_se;
    reg dsync_se;
    reg dcache_se;
    reg [3:0]bytsel_se;
    reg [31:0]data_b_se;
    reg [31:0]data_h_se;
    reg [31:0]data_l_se;
    reg [31:0]data_0_se;
    reg [31:0]data_1_se;
    reg hz_lo_sm;
    reg hz_hi_sm;
    reg rdhwr_xe;
    reg damalgn_xe;
    reg dasviol_xe;
    reg ovrf_xe;
    reg trap_xe;
    reg [31:0]din_sm;
    reg [31:0]wrdin_sm;
    reg [31:0]wldin_sm;
    reg [23:0]bsext_sm;
    reg [15:0]hsext_sm;
    reg [31:0]data_sm;
    reg [31:0]lo_sw;
    reg [31:0]hi_sw;
    reg [31:0]data_sw;
    reg wcount_sm;
    reg [31:0]ebase_sm;
    reg webase_sm;
    reg wtcctx_sm;
    reg wusrlcl_sm;
    reg whwrena_sm;
    reg bdslot_xm;
    reg [4:0]exccode_xm;
    reg wcause_sm;
    reg [31:0]rstorsr_sm;
    reg [31:0]status_sm;
    reg wsr_sm;
    reg [31:0]epc_xm;
    reg wepc_xm;
    reg wepc_sm;
    reg [31:0]eepc_xx;
    reg weepc_sm;
    reg [31:0]nextpc_xm;
    reg hwswit_xx;
    reg glbmsk_xx;
    reg intrq_xx;
    reg [31:0]i_ri;
    reg iread_ri;
    reg bdslot_ri;
    reg killed_ri;
    reg iabuser_ri;
    reg iamalgn_ri;
    reg iasviol_ri;
    reg [31:0]pc_ri;
    reg [31:0]i_rd;
    reg [40:0]i_type_rd;
    reg [8:0]opcod_rd;
    reg bdslot_rd;
    reg killed_rd;
    reg [4:0]rs_rd;
    reg [4:0]rt_rd;
    reg [4:0]rd_rd;
    reg [31:0]effhwre_rd;
    reg [7:0]cop0d_rd;
    reg trap_rd;
    reg break_rd;
    reg syscall_rd;
    reg rsvdins_rd;
    reg cpunuse_rd;
    reg iabuser_rd;
    reg iamalgn_rd;
    reg iasviol_rd;
    reg [31:0]nextpc_rd;
    reg [31:0]pc_rd;
    reg [31:0]soper_rd;
    reg [31:0]toper_rd;
    reg [31:0]ioper_rd;
    reg [4:0]sham_rd;
    reg [1:0]cpnbr_rd;
    reg [31:0]i_re;
    reg [40:0]i_type_re;
    reg [8:0]opcod_re;
    reg bdslot_re;
    reg [4:0]rt_re;
    reg [4:0]rd_re;
    reg [7:0]cop0d_re;
    reg ovrf_re;
    reg irq_re;
    reg drq_re;
    reg drstlk_re;
    reg dsync_re;
    reg dcache_re;
    reg [3:0]bytsel_re;
    reg write_re;
    reg read_re;
    reg iamalgn_re;
    reg iasviol_re;
    reg lamalgn_re;
    reg lasviol_re;
    reg samalgn_re;
    reg sasviol_re;
    reg iabuser_re;
    reg trap_re;
    reg break_re;
    reg syscall_re;
    reg rsvdins_re;
    reg cpunuse_re;
    reg earlyex_re;
    reg zminv_re;
    reg [2:0]mic_re;
    reg micend_re;
    reg miclst_re;
    reg [31:0]pc_re;
    reg [31:0]nextpc_re;
    reg [31:0]res_re;
    reg [31:0]data_re;
    reg [1:0]cpnbr_re;
    reg [63:0]c05mul1_re;
    reg [63:0]c07mul1_re;
    reg [63:0]s00mul2_re;
    reg [63:0]s01mul2_re;
    reg [63:0]s02mul2_re;
    reg [63:0]s03mul2_re;
    reg [63:0]s04mul2_re;
    reg [63:0]c00mul2_re;
    reg [63:0]c01mul2_re;
    reg [63:0]c02mul2_re;
    reg [63:0]c03mul2_re;
    reg [63:0]c04mul2_re;
    reg [31:0]divx_re;
    reg [5:0]divxclz_re;
    reg [31:0]divy_re;
    reg [5:0]divyclz_re;
    reg [31:0]divq_re;
    reg [31:0]redopc_re;
    reg [31:0]i_rm;
    reg dread_rm;
    reg [40:0]i_type_rm;
    reg [4:0]rd_rm;
    reg [8:0]opcod_rm;
    reg zminv_rm;
    reg [63:0]s00mul7_rm;
    reg [63:0]c00mul7_rm;
    reg [31:0]data_rm;
    reg [31:0]divq_rm;
    reg [31:0]divr_rm;
    reg [31:0]badva_rx;
    reg [31:0]ebase_rm;
    reg [31:0]cause_rx;
    reg [31:0]epc_rx;
    reg [31:0]eepc_rx;
    reg [31:0]count_rx;
    reg [31:0]tcctx_rm;
    reg [31:0]usrlcl_rm;
    reg [31:0]hwrena_rm;
    reg [31:0]status_rx;
    reg [31:0]lo_rw;
    reg [31:0]hi_rw;
    reg [31:0]r1_rw;
    reg [31:0]r2_rw;
    reg [31:0]r3_rw;
    reg [31:0]r4_rw;
    reg [31:0]r5_rw;
    reg [31:0]r6_rw;
    reg [31:0]r7_rw;
    reg [31:0]r8_rw;
    reg [31:0]r9_rw;
    reg [31:0]r10_rw;
    reg [31:0]r11_rw;
    reg [31:0]r12_rw;
    reg [31:0]r13_rw;
    reg [31:0]r14_rw;
    reg [31:0]r15_rw;
    reg [31:0]r16_rw;
    reg [31:0]r17_rw;
    reg [31:0]r18_rw;
    reg [31:0]r19_rw;
    reg [31:0]r20_rw;
    reg [31:0]r21_rw;
    reg [31:0]r22_rw;
    reg [31:0]r23_rw;
    reg [31:0]r24_rw;
    reg [31:0]r25_rw;
    reg [31:0]r26_rw;
    reg [31:0]r27_rw;
    reg [31:0]r28_rw;
    reg [31:0]r29_rw;
    reg [31:0]r30_rw;
    reg [31:0]r31_rw;
    reg reset_rx;
    reg hwswit_rx;
    reg intrq_rx;
    reg mcheck_rx;
    reg mcheckx_rx;
    reg i_rq;
    reg [31:2]i_a;
    reg i_inline;
    reg [1:0]i_mode;
    reg [31:2]d_a;
    reg [31:0]d_out;
    reg d_rw;
    reg [3:0]d_bytsel;
    reg d_rq;
    reg d_rstlkd;
    reg d_sync;
    reg d_cache;
    reg d_linked;
    reg d_reg;
    reg [4:0]d_cachop;
    reg [1:0]d_mode;
    assign it_xx =  ~( it_n);
    assign mcheckx_xx = (  ~( mcheck_n) &  ~( mcheck_rx) );
    assign imp_sx = 2'b01;
    always 
    begin
        if ( imp_sx == 2'b00 ) 
        begin
            impstd_sx <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:1638 
            begin
                impstd_sx <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( imp_sx == 2'b01 ) 
        begin
            imptsr_sx <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:1639 
            begin
                imptsr_sx <= 1'b0;
            end
        end
    end
    always @ (  i_ri)
    begin
        if ( i_ri[25] == 1'b0 ) 
        begin
            cop0_sd <= { 2'b10, i_ri[25:21] };
        end
        else
        begin 
            cop0_sd <= { 2'b10, i_ri[5:0] };
        end
    end
    always @ (  i_ri)
    begin
        if ( i_ri[25] == 1'b0 ) 
        begin
            cop2_sd <= { 2'b11, i_ri[25:21] };
        end
        else
        begin 
            cop2_sd <= { 2'b11, i_ri[5:0] };
        end
    end
    always @ (  i_ri)
    begin
        if ( i_ri[31:26] == 6'b000000 ) 
        begin
            opcod_sd <= { 3'b000, i_ri[5:0] };
        end
        else
        begin 
            if ( i_ri[31:26] == 6'b011100 ) 
            begin
                opcod_sd <= { 3'b010, i_ri[5:0] };
            end
            else
            begin 
                if ( i_ri[31:26] == 6'b011111 ) 
                begin
                    opcod_sd <= { 3'b011, i_ri[5:0] };
                end
                else
                begin 
                    if ( i_ri[31:26] == 6'b000001 ) 
                    begin
                        opcod_sd <= { 4'b1000, i_ri[20:16] };
                    end
                    else
                    begin 
                        if ( i_ri[31:26] == 6'b010000 ) 
                        begin
                            opcod_sd <= cop0_sd;
                        end
                        else
                        begin 
                            if ( i_ri[31:26] == 6'b010010 ) 
                            begin
                                opcod_sd <= cop2_sd;
                            end
                            else
                            begin 
                                opcod_sd <= { 3'b001, i_ri[31:26] };
                            end
                        end
                    end
                end
            end
        end
    end
    assign nop_type = { 4'b0001, 9'b000000000 };
    always @ (  opcod_sd)
    begin
        if ( opcod_sd == 9'b000100000 ) 
        begin
            i_type_sd <= { 4'b0001, 9'b000000000 };
        end
        else
        begin 
            if ( opcod_sd == 9'b001001000 ) 
            begin
                i_type_sd <= { 4'b0010, 9'b000000000 };
            end
            else
            begin 
                if ( opcod_sd == 9'b001001001 ) 
                begin
                    i_type_sd <= { 4'b0010, 9'b000000000 };
                end
                else
                begin 
                    if ( opcod_sd == 9'b000100001 ) 
                    begin
                        i_type_sd <= { 4'b0001, 9'b000000000 };
                    end
                    else
                    begin 
                        if ( opcod_sd == 9'b000100100 ) 
                        begin
                            i_type_sd <= { 4'b0001, 9'b000000000 };
                        end
                        else
                        begin 
                            if ( opcod_sd == 9'b001001100 ) 
                            begin
                                i_type_sd <= { 4'b0010, 9'b000000000 };
                            end
                            else
                            begin 
                                if ( opcod_sd == 9'b001000100 ) 
                                begin
                                    i_type_sd <= { 4'b0010, 9'b000000000 };
                                end
                                else
                                begin 
                                    if ( opcod_sd == 9'b001000110 ) 
                                    begin
                                        i_type_sd <= { 4'b0010, 9'b000000000 };
                                    end
                                    else
                                    begin 
                                        if ( opcod_sd == 9'b100000001 ) 
                                        begin
                                            i_type_sd <= { 4'b0010, 9'b000000000 };
                                        end
                                        else
                                        begin 
                                            if ( opcod_sd == 9'b100010001 ) 
                                            begin
                                                i_type_sd <= { 4'b0010, 9'b000000000 };
                                            end
                                            else
                                            begin 
                                                if ( opcod_sd == 9'b001000111 ) 
                                                begin
                                                    i_type_sd <= { 4'b0010, 9'b000000000 };
                                                end
                                                else
                                                begin 
                                                    if ( opcod_sd == 9'b100000000 ) 
                                                    begin
                                                        i_type_sd <= { 4'b0010, 9'b000000000 };
                                                    end
                                                    else
                                                    begin 
                                                        if ( opcod_sd == 9'b100010000 ) 
                                                        begin
                                                            i_type_sd <= { 4'b0010, 9'b000000000 };
                                                        end
                                                        else
                                                        begin 
                                                            if ( opcod_sd == 9'b001000101 ) 
                                                            begin
                                                                i_type_sd <= { 4'b0010, 9'b000000000 };
                                                            end
                                                            else
                                                            begin 
                                                                if ( opcod_sd == 9'b000001101 ) 
                                                                begin
                                                                    i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                end
                                                                else
                                                                begin 
                                                                    if ( opcod_sd == 9'b001101111 ) 
                                                                    begin
                                                                        i_type_sd <= { 4'b0010, 9'b000000000 };
                                                                    end
                                                                    else
                                                                    begin 
                                                                        if ( opcod_sd == 9'b010100001 ) 
                                                                        begin
                                                                            i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                        end
                                                                        else
                                                                        begin 
                                                                            if ( opcod_sd == 9'b010100000 ) 
                                                                            begin
                                                                                i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                            end
                                                                            else
                                                                            begin 
                                                                                if ( opcod_sd == 9'b000011010 ) 
                                                                                begin
                                                                                    i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                end
                                                                                else
                                                                                begin 
                                                                                    if ( opcod_sd == 9'b000011011 ) 
                                                                                    begin
                                                                                        i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                    end
                                                                                    else
                                                                                    begin 
                                                                                        if ( opcod_sd == 9'b101011000 ) 
                                                                                        begin
                                                                                            i_type_sd <= { 4'b0010, 9'b000000000 };
                                                                                        end
                                                                                        else
                                                                                        begin 
                                                                                            if ( opcod_sd == 9'b001000010 ) 
                                                                                            begin
                                                                                                i_type_sd <= { 4'b0100, 9'b000000000 };
                                                                                            end
                                                                                            else
                                                                                            begin 
                                                                                                if ( opcod_sd == 9'b001000011 ) 
                                                                                                begin
                                                                                                    i_type_sd <= { 4'b0100, 9'b000000000 };
                                                                                                end
                                                                                                else
                                                                                                begin 
                                                                                                    if ( opcod_sd == 9'b000001001 ) 
                                                                                                    begin
                                                                                                        i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                    end
                                                                                                    else
                                                                                                    begin 
                                                                                                        if ( opcod_sd == 9'b000001000 ) 
                                                                                                        begin
                                                                                                            i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                        end
                                                                                                        else
                                                                                                        begin 
                                                                                                            if ( opcod_sd == 9'b001100000 ) 
                                                                                                            begin
                                                                                                                i_type_sd <= { 4'b0010, 9'b100010000 };
                                                                                                            end
                                                                                                            else
                                                                                                            begin 
                                                                                                                if ( opcod_sd == 9'b001100100 ) 
                                                                                                                begin
                                                                                                                    i_type_sd <= { 4'b0010, 9'b100010000 };
                                                                                                                end
                                                                                                                else
                                                                                                                begin 
                                                                                                                    if ( opcod_sd == 9'b001100001 ) 
                                                                                                                    begin
                                                                                                                        i_type_sd <= { 4'b0010, 9'b100001000 };
                                                                                                                    end
                                                                                                                    else
                                                                                                                    begin 
                                                                                                                        if ( opcod_sd == 9'b001100101 ) 
                                                                                                                        begin
                                                                                                                            i_type_sd <= { 4'b0010, 9'b100001000 };
                                                                                                                        end
                                                                                                                        else
                                                                                                                        begin 
                                                                                                                            if ( opcod_sd == 9'b001110000 ) 
                                                                                                                            begin
                                                                                                                                i_type_sd <= { 4'b0010, 9'b101000100 };
                                                                                                                            end
                                                                                                                            else
                                                                                                                            begin 
                                                                                                                                if ( opcod_sd == 9'b001001111 ) 
                                                                                                                                begin
                                                                                                                                    i_type_sd <= { 4'b0010, 9'b000000000 };
                                                                                                                                end
                                                                                                                                else
                                                                                                                                begin 
                                                                                                                                    if ( opcod_sd == 9'b001100011 ) 
                                                                                                                                    begin
                                                                                                                                        i_type_sd <= { 4'b0010, 9'b100000100 };
                                                                                                                                    end
                                                                                                                                    else
                                                                                                                                    begin 
                                                                                                                                        if ( opcod_sd == 9'b001100010 ) 
                                                                                                                                        begin
                                                                                                                                            i_type_sd <= { 4'b0010, 9'b100000001 };
                                                                                                                                        end
                                                                                                                                        else
                                                                                                                                        begin 
                                                                                                                                            if ( opcod_sd == 9'b001100110 ) 
                                                                                                                                            begin
                                                                                                                                                i_type_sd <= { 4'b0010, 9'b100000010 };
                                                                                                                                            end
                                                                                                                                            else
                                                                                                                                            begin 
                                                                                                                                                if ( opcod_sd == 9'b010000000 ) 
                                                                                                                                                begin
                                                                                                                                                    i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                end
                                                                                                                                                else
                                                                                                                                                begin 
                                                                                                                                                    if ( opcod_sd == 9'b010000001 ) 
                                                                                                                                                    begin
                                                                                                                                                        i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                    end
                                                                                                                                                    else
                                                                                                                                                    begin 
                                                                                                                                                        if ( opcod_sd == 9'b100100000 ) 
                                                                                                                                                        begin
                                                                                                                                                            i_type_sd <= { 4'b0010, 9'b000000000 };
                                                                                                                                                        end
                                                                                                                                                        else
                                                                                                                                                        begin 
                                                                                                                                                            if ( opcod_sd == 9'b110100000 ) 
                                                                                                                                                            begin
                                                                                                                                                                i_type_sd <= { 4'b0010, 9'b100100100 };
                                                                                                                                                            end
                                                                                                                                                            else
                                                                                                                                                            begin 
                                                                                                                                                                if ( opcod_sd == 9'b000010010 ) 
                                                                                                                                                                begin
                                                                                                                                                                    i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                end
                                                                                                                                                                else
                                                                                                                                                                begin 
                                                                                                                                                                    if ( opcod_sd == 9'b000010000 ) 
                                                                                                                                                                    begin
                                                                                                                                                                        i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                    end
                                                                                                                                                                    else
                                                                                                                                                                    begin 
                                                                                                                                                                        if ( opcod_sd == 9'b100101011 ) 
                                                                                                                                                                        begin
                                                                                                                                                                            i_type_sd <= { 4'b0010, 9'b000000000 };
                                                                                                                                                                        end
                                                                                                                                                                        else
                                                                                                                                                                        begin 
                                                                                                                                                                            if ( opcod_sd == 9'b000001011 ) 
                                                                                                                                                                            begin
                                                                                                                                                                                i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                            end
                                                                                                                                                                            else
                                                                                                                                                                            begin 
                                                                                                                                                                                if ( opcod_sd == 9'b000001010 ) 
                                                                                                                                                                                begin
                                                                                                                                                                                    i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                end
                                                                                                                                                                                else
                                                                                                                                                                                begin 
                                                                                                                                                                                    if ( opcod_sd == 9'b010000100 ) 
                                                                                                                                                                                    begin
                                                                                                                                                                                        i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                    end
                                                                                                                                                                                    else
                                                                                                                                                                                    begin 
                                                                                                                                                                                        if ( opcod_sd == 9'b010000101 ) 
                                                                                                                                                                                        begin
                                                                                                                                                                                            i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                        end
                                                                                                                                                                                        else
                                                                                                                                                                                        begin 
                                                                                                                                                                                            if ( opcod_sd == 9'b100100100 ) 
                                                                                                                                                                                            begin
                                                                                                                                                                                                i_type_sd <= { 4'b0010, 9'b000000000 };
                                                                                                                                                                                            end
                                                                                                                                                                                            else
                                                                                                                                                                                            begin 
                                                                                                                                                                                                if ( opcod_sd == 9'b110100100 ) 
                                                                                                                                                                                                begin
                                                                                                                                                                                                    i_type_sd <= { 4'b0010, 9'b010100100 };
                                                                                                                                                                                                end
                                                                                                                                                                                                else
                                                                                                                                                                                                begin 
                                                                                                                                                                                                    if ( opcod_sd == 9'b000010001 ) 
                                                                                                                                                                                                    begin
                                                                                                                                                                                                        i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                    end
                                                                                                                                                                                                    else
                                                                                                                                                                                                    begin 
                                                                                                                                                                                                        if ( opcod_sd == 9'b000010011 ) 
                                                                                                                                                                                                        begin
                                                                                                                                                                                                            i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                        end
                                                                                                                                                                                                        else
                                                                                                                                                                                                        begin 
                                                                                                                                                                                                            if ( opcod_sd == 9'b010000010 ) 
                                                                                                                                                                                                            begin
                                                                                                                                                                                                                i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                            end
                                                                                                                                                                                                            else
                                                                                                                                                                                                            begin 
                                                                                                                                                                                                                if ( opcod_sd == 9'b000011000 ) 
                                                                                                                                                                                                                begin
                                                                                                                                                                                                                    i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                                end
                                                                                                                                                                                                                else
                                                                                                                                                                                                                begin 
                                                                                                                                                                                                                    if ( opcod_sd == 9'b000011001 ) 
                                                                                                                                                                                                                    begin
                                                                                                                                                                                                                        i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                                    end
                                                                                                                                                                                                                    else
                                                                                                                                                                                                                    begin 
                                                                                                                                                                                                                        if ( opcod_sd == 9'b000100111 ) 
                                                                                                                                                                                                                        begin
                                                                                                                                                                                                                            i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                                        end
                                                                                                                                                                                                                        else
                                                                                                                                                                                                                        begin 
                                                                                                                                                                                                                            if ( opcod_sd == 9'b000100101 ) 
                                                                                                                                                                                                                            begin
                                                                                                                                                                                                                                i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                                            end
                                                                                                                                                                                                                            else
                                                                                                                                                                                                                            begin 
                                                                                                                                                                                                                                if ( opcod_sd == 9'b001001101 ) 
                                                                                                                                                                                                                                begin
                                                                                                                                                                                                                                    i_type_sd <= { 4'b0010, 9'b000000000 };
                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                else
                                                                                                                                                                                                                                begin 
                                                                                                                                                                                                                                    if ( opcod_sd == 9'b001110011 ) 
                                                                                                                                                                                                                                    begin
                                                                                                                                                                                                                                        i_type_sd <= { 4'b0010, 9'b000000000 };
                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                    begin 
                                                                                                                                                                                                                                        if ( opcod_sd == 9'b011111011 ) 
                                                                                                                                                                                                                                        begin
                                                                                                                                                                                                                                            i_type_sd <= { 4'b0010, 9'b000000000 };
                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                        else
                                                                                                                                                                                                                                        begin 
                                                                                                                                                                                                                                            if ( opcod_sd == 9'b001101000 ) 
                                                                                                                                                                                                                                            begin
                                                                                                                                                                                                                                                i_type_sd <= { 4'b0010, 9'b010010000 };
                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                            else
                                                                                                                                                                                                                                            begin 
                                                                                                                                                                                                                                                if ( opcod_sd == 9'b001111000 ) 
                                                                                                                                                                                                                                                begin
                                                                                                                                                                                                                                                    i_type_sd <= { 4'b0010, 9'b111000100 };
                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                else
                                                                                                                                                                                                                                                begin 
                                                                                                                                                                                                                                                    if ( opcod_sd == 9'b001101001 ) 
                                                                                                                                                                                                                                                    begin
                                                                                                                                                                                                                                                        i_type_sd <= { 4'b0010, 9'b010001000 };
                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                                    begin 
                                                                                                                                                                                                                                                        if ( opcod_sd == 9'b000000100 ) 
                                                                                                                                                                                                                                                        begin
                                                                                                                                                                                                                                                            i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                        else
                                                                                                                                                                                                                                                        begin 
                                                                                                                                                                                                                                                            if ( opcod_sd == 9'b000000000 ) 
                                                                                                                                                                                                                                                            begin
                                                                                                                                                                                                                                                                i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            else
                                                                                                                                                                                                                                                            begin 
                                                                                                                                                                                                                                                                if ( opcod_sd == 9'b000101010 ) 
                                                                                                                                                                                                                                                                begin
                                                                                                                                                                                                                                                                    i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                else
                                                                                                                                                                                                                                                                begin 
                                                                                                                                                                                                                                                                    if ( opcod_sd == 9'b001001010 ) 
                                                                                                                                                                                                                                                                    begin
                                                                                                                                                                                                                                                                        i_type_sd <= { 4'b0010, 9'b000000000 };
                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                                                    begin 
                                                                                                                                                                                                                                                                        if ( opcod_sd == 9'b001001011 ) 
                                                                                                                                                                                                                                                                        begin
                                                                                                                                                                                                                                                                            i_type_sd <= { 4'b0010, 9'b000000000 };
                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                        else
                                                                                                                                                                                                                                                                        begin 
                                                                                                                                                                                                                                                                            if ( opcod_sd == 9'b000101011 ) 
                                                                                                                                                                                                                                                                            begin
                                                                                                                                                                                                                                                                                i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                            else
                                                                                                                                                                                                                                                                            begin 
                                                                                                                                                                                                                                                                                if ( opcod_sd == 9'b000000011 ) 
                                                                                                                                                                                                                                                                                begin
                                                                                                                                                                                                                                                                                    i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                else
                                                                                                                                                                                                                                                                                begin 
                                                                                                                                                                                                                                                                                    if ( opcod_sd == 9'b000000111 ) 
                                                                                                                                                                                                                                                                                    begin
                                                                                                                                                                                                                                                                                        i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                                                                    begin 
                                                                                                                                                                                                                                                                                        if ( opcod_sd == 9'b000000010 ) 
                                                                                                                                                                                                                                                                                        begin
                                                                                                                                                                                                                                                                                            i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                        else
                                                                                                                                                                                                                                                                                        begin 
                                                                                                                                                                                                                                                                                            if ( opcod_sd == 9'b000000110 ) 
                                                                                                                                                                                                                                                                                            begin
                                                                                                                                                                                                                                                                                                i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                            else
                                                                                                                                                                                                                                                                                            begin 
                                                                                                                                                                                                                                                                                                if ( opcod_sd == 9'b000100010 ) 
                                                                                                                                                                                                                                                                                                begin
                                                                                                                                                                                                                                                                                                    i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                else
                                                                                                                                                                                                                                                                                                begin 
                                                                                                                                                                                                                                                                                                    if ( opcod_sd == 9'b000100011 ) 
                                                                                                                                                                                                                                                                                                    begin
                                                                                                                                                                                                                                                                                                        i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                                                                                    begin 
                                                                                                                                                                                                                                                                                                        if ( opcod_sd == 9'b001101011 ) 
                                                                                                                                                                                                                                                                                                        begin
                                                                                                                                                                                                                                                                                                            i_type_sd <= { 4'b0010, 9'b010000100 };
                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                        else
                                                                                                                                                                                                                                                                                                        begin 
                                                                                                                                                                                                                                                                                                            if ( opcod_sd == 9'b001101010 ) 
                                                                                                                                                                                                                                                                                                            begin
                                                                                                                                                                                                                                                                                                                i_type_sd <= { 4'b0010, 9'b010000001 };
                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                            else
                                                                                                                                                                                                                                                                                                            begin 
                                                                                                                                                                                                                                                                                                                if ( opcod_sd == 9'b001101110 ) 
                                                                                                                                                                                                                                                                                                                begin
                                                                                                                                                                                                                                                                                                                    i_type_sd <= { 4'b0010, 9'b010000010 };
                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                else
                                                                                                                                                                                                                                                                                                                begin 
                                                                                                                                                                                                                                                                                                                    if ( opcod_sd == 9'b000001111 ) 
                                                                                                                                                                                                                                                                                                                    begin
                                                                                                                                                                                                                                                                                                                        i_type_sd <= { 4'b0010, 9'b000000000 };
                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                                                                                                    begin 
                                                                                                                                                                                                                                                                                                                        if ( opcod_sd == 9'b000001100 ) 
                                                                                                                                                                                                                                                                                                                        begin
                                                                                                                                                                                                                                                                                                                            i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                        else
                                                                                                                                                                                                                                                                                                                        begin 
                                                                                                                                                                                                                                                                                                                            if ( opcod_sd == 9'b000110100 ) 
                                                                                                                                                                                                                                                                                                                            begin
                                                                                                                                                                                                                                                                                                                                i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                                            else
                                                                                                                                                                                                                                                                                                                            begin 
                                                                                                                                                                                                                                                                                                                                if ( opcod_sd == 9'b100001100 ) 
                                                                                                                                                                                                                                                                                                                                begin
                                                                                                                                                                                                                                                                                                                                    i_type_sd <= { 4'b0010, 9'b000000000 };
                                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                                else
                                                                                                                                                                                                                                                                                                                                begin 
                                                                                                                                                                                                                                                                                                                                    if ( opcod_sd == 9'b000110000 ) 
                                                                                                                                                                                                                                                                                                                                    begin
                                                                                                                                                                                                                                                                                                                                        i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                                                                                                                    begin 
                                                                                                                                                                                                                                                                                                                                        if ( opcod_sd == 9'b100001000 ) 
                                                                                                                                                                                                                                                                                                                                        begin
                                                                                                                                                                                                                                                                                                                                            i_type_sd <= { 4'b0010, 9'b000000000 };
                                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                                        else
                                                                                                                                                                                                                                                                                                                                        begin 
                                                                                                                                                                                                                                                                                                                                            if ( opcod_sd == 9'b100001001 ) 
                                                                                                                                                                                                                                                                                                                                            begin
                                                                                                                                                                                                                                                                                                                                                i_type_sd <= { 4'b0010, 9'b000000000 };
                                                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                                                            else
                                                                                                                                                                                                                                                                                                                                            begin 
                                                                                                                                                                                                                                                                                                                                                if ( opcod_sd == 9'b000110001 ) 
                                                                                                                                                                                                                                                                                                                                                begin
                                                                                                                                                                                                                                                                                                                                                    i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                                                else
                                                                                                                                                                                                                                                                                                                                                begin 
                                                                                                                                                                                                                                                                                                                                                    if ( opcod_sd == 9'b000110010 ) 
                                                                                                                                                                                                                                                                                                                                                    begin
                                                                                                                                                                                                                                                                                                                                                        i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                                                                                                                                    begin 
                                                                                                                                                                                                                                                                                                                                                        if ( opcod_sd == 9'b100001010 ) 
                                                                                                                                                                                                                                                                                                                                                        begin
                                                                                                                                                                                                                                                                                                                                                            i_type_sd <= { 4'b0010, 9'b000000000 };
                                                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                                                        else
                                                                                                                                                                                                                                                                                                                                                        begin 
                                                                                                                                                                                                                                                                                                                                                            if ( opcod_sd == 9'b100001011 ) 
                                                                                                                                                                                                                                                                                                                                                            begin
                                                                                                                                                                                                                                                                                                                                                                i_type_sd <= { 4'b0010, 9'b000000000 };
                                                                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                                                                            else
                                                                                                                                                                                                                                                                                                                                                            begin 
                                                                                                                                                                                                                                                                                                                                                                if ( opcod_sd == 9'b000110011 ) 
                                                                                                                                                                                                                                                                                                                                                                begin
                                                                                                                                                                                                                                                                                                                                                                    i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                                                                else
                                                                                                                                                                                                                                                                                                                                                                begin 
                                                                                                                                                                                                                                                                                                                                                                    if ( opcod_sd == 9'b000110110 ) 
                                                                                                                                                                                                                                                                                                                                                                    begin
                                                                                                                                                                                                                                                                                                                                                                        i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                                                                                                                                                    begin 
                                                                                                                                                                                                                                                                                                                                                                        if ( opcod_sd == 9'b100001110 ) 
                                                                                                                                                                                                                                                                                                                                                                        begin
                                                                                                                                                                                                                                                                                                                                                                            i_type_sd <= { 4'b0010, 9'b000000000 };
                                                                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                                                                        else
                                                                                                                                                                                                                                                                                                                                                                        begin 
                                                                                                                                                                                                                                                                                                                                                                            if ( opcod_sd == 9'b101100000 ) 
                                                                                                                                                                                                                                                                                                                                                                            begin
                                                                                                                                                                                                                                                                                                                                                                                i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                                                                                            else
                                                                                                                                                                                                                                                                                                                                                                            begin 
                                                                                                                                                                                                                                                                                                                                                                                if ( opcod_sd == 9'b000100110 ) 
                                                                                                                                                                                                                                                                                                                                                                                begin
                                                                                                                                                                                                                                                                                                                                                                                    i_type_sd <= { 4'b0001, 9'b000000000 };
                                                                                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                                                                                else
                                                                                                                                                                                                                                                                                                                                                                                begin 
                                                                                                                                                                                                                                                                                                                                                                                    if ( opcod_sd == 9'b001001110 ) 
                                                                                                                                                                                                                                                                                                                                                                                    begin
                                                                                                                                                                                                                                                                                                                                                                                        i_type_sd <= { 4'b0010, 9'b000000000 };
                                                                                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                                                                                                                                                                    begin 
                                                                                                                                                                                                                                                                                                                                                                                        i_type_sd <= { 4'b1000, 9'b000000000 };
                                                                                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                end
                                                                                                                                                                                                                            end
                                                                                                                                                                                                                        end
                                                                                                                                                                                                                    end
                                                                                                                                                                                                                end
                                                                                                                                                                                                            end
                                                                                                                                                                                                        end
                                                                                                                                                                                                    end
                                                                                                                                                                                                end
                                                                                                                                                                                            end
                                                                                                                                                                                        end
                                                                                                                                                                                    end
                                                                                                                                                                                end
                                                                                                                                                                            end
                                                                                                                                                                        end
                                                                                                                                                                    end
                                                                                                                                                                end
                                                                                                                                                            end
                                                                                                                                                        end
                                                                                                                                                    end
                                                                                                                                                end
                                                                                                                                            end
                                                                                                                                        end
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            end
                                                                                                                        end
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    assign i_illg_sd = i_type_sd[40];
    assign i_ifmt_sd = i_type_sd[38];
    assign i_rfmt_sd = i_type_sd[37];
    assign i_duses_sd = i_type_sd[36];
    assign i_euses_sd = i_type_sd[35];
    assign i_duset_sd = i_type_sd[34];
    assign i_euset_sd = i_type_sd[33];
    assign i_reads_sd = ( i_type_sd[36] | i_type_sd[35] );
    assign i_readt_sd = ( i_type_sd[34] | i_type_sd[33] );
    assign i_osgnd_sd = i_type_sd[28];
    assign i_brek_sd = i_type_sd[20];
    assign i_sysc_sd = i_type_sd[19];
    assign i_trap_sd = i_type_sd[18];
    assign i_wreg_sd = i_type_sd[10];
    assign i_brnch_sd = i_type_sd[9];
    assign i_ifmt_se = i_type_rd[38];
    assign i_euses_se = i_type_rd[35];
    assign i_euset_se = i_type_rd[33];
    assign i_reads_se = ( i_type_rd[36] | i_type_rd[35] );
    assign i_readt_se = ( i_type_rd[34] | i_type_rd[33] );
    assign i_euseh_se = i_type_rd[32];
    assign i_eusel_se = i_type_rd[30];
    assign i_osgnd_se = i_type_rd[28];
    assign i_arith_se = ( (  ~( i_type_rd[27]) &  ~( i_type_rd[26]) ) & i_type_rd[25] );
    assign i_shift_se = ( (  ~( i_type_rd[27]) & i_type_rd[26] ) &  ~( i_type_rd[25]) );
    assign i_test_se = ( (  ~( i_type_rd[27]) & i_type_rd[26] ) & i_type_rd[25] );
    assign i_logic_se = ( ( i_type_rd[27] &  ~( i_type_rd[26]) ) &  ~( i_type_rd[25]) );
    assign i_oper_se = ( ( i_type_rd[27] &  ~( i_type_rd[26]) ) & i_type_rd[25] );
    assign i_clead_se = ( ( i_type_rd[27] & i_type_rd[26] ) &  ~( i_type_rd[25]) );
    assign i_sub_se = i_type_rd[22];
    assign i_shr_se = i_type_rd[22];
    assign i_eq_se = (  ~( i_type_rd[23]) &  ~( i_type_rd[22]) );
    assign i_ne_se = ( i_type_rd[23] &  ~( i_type_rd[22]) );
    assign i_ltu_se = ( (  ~( i_type_rd[24]) &  ~( i_type_rd[23]) ) & i_type_rd[22] );
    assign i_lt_se = ( ( i_type_rd[24] &  ~( i_type_rd[23]) ) & i_type_rd[22] );
    assign i_geu_se = ( (  ~( i_type_rd[24]) & i_type_rd[23] ) & i_type_rd[22] );
    assign i_ge_se = ( ( i_type_rd[24] & i_type_rd[23] ) & i_type_rd[22] );
    assign i_and_se = (  ~( i_type_rd[23]) & i_type_rd[22] );
    assign i_nor_se = ( i_type_rd[23] & i_type_rd[22] );
    assign i_xor_se = ( i_type_rd[23] &  ~( i_type_rd[22]) );
    assign i_or_se = (  ~( i_type_rd[23]) &  ~( i_type_rd[22]) );
    assign i_soper_se = ( i_type_rd[23] &  ~( i_type_rd[22]) );
    assign i_toper_se = (  ~( i_type_rd[23]) & i_type_rd[22] );
    assign i_ioper_se = (  ~( i_type_rd[23]) &  ~( i_type_rd[22]) );
    assign i_clz_se = i_type_rd[22];
    assign i_msub_se = i_type_rd[22];
    assign i_mic_se = i_type_rd[24:22];
    assign i_cisc_se = i_type_rd[21];
    assign i_ovrf_se = i_type_rd[17];
    assign i_wpdc_se = i_type_rd[14];
    assign i_wreg_se = i_type_rd[10];
    assign i_brnch_se = i_type_rd[9];
    assign i_mload_se = ( i_type_rd[8] &  ~( i_type_rd[5]) );
    assign i_mstor_se = ( i_type_rd[7] &  ~( i_type_rd[5]) );
    assign i_load_se = i_type_rd[8];
    assign i_stor_se = i_type_rd[7];
    assign i_linkd_se = i_type_rd[6];
    assign i_xreg_se = i_type_rd[5];
    assign i_byte_se = i_type_rd[4];
    assign i_half_se = i_type_rd[3];
    assign i_word_se = i_type_rd[2];
    assign i_wrdr_se = i_type_rd[1];
    assign i_wrdl_se = i_type_rd[0];
    assign i_museh_sm = i_type_re[31];
    assign i_musel_sm = i_type_re[29];
    assign i_mult_sm = (  ~( i_type_re[23]) &  ~( i_type_re[22]) );
    assign i_mpdc_sm = i_type_re[15];
    assign i_wpdc_sm = i_type_re[14];
    assign i_wcop0_sm = i_type_re[13];
    assign i_whi_sm = i_type_re[12];
    assign i_wlo_sm = i_type_re[11];
    assign i_wreg_sm = i_type_re[10];
    assign i_linkd_sm = i_type_re[6];
    assign i_xreg_sm = i_type_re[5];
    assign i_wpdc_sw = i_type_rm[14];
    assign i_whi_sw = i_type_rm[12];
    assign i_wlo_sw = i_type_rm[11];
    assign i_wreg_sw = i_type_rm[10];
    assign bdslot_xi = i_brnch_sd;
    always 
    begin
        if ( opcod_sd == 9'b101011000 ) 
        begin
            eret_sd <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2111 
            begin
                eret_sd <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( opcod_rd == 9'b101011000 ) 
        begin
            eret_se <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2112 
            begin
                eret_se <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( opcod_re == 9'b101011000 ) 
        begin
            eret_sm <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2113 
            begin
                eret_sm <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( opcod_sd == 9'b100100000 ) 
        begin
            mfc0_sd <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2115 
            begin
                mfc0_sd <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( opcod_sd == 9'b100100100 ) 
        begin
            mtc0_sd <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2117 
            begin
                mtc0_sd <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( opcod_rd == 9'b100100100 ) 
        begin
            mtc0_se <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2118 
            begin
                mtc0_se <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( opcod_re == 9'b100100100 ) 
        begin
            mtc0_sm <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2119 
            begin
                mtc0_sm <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( opcod_sd == 9'b100101011 ) 
        begin
            mfmc0_sd <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2121 
            begin
                mfmc0_sd <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( opcod_rd == 9'b100101011 ) 
        begin
            mfmc0_se <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2122 
            begin
                mfmc0_se <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( opcod_re == 9'b100101011 ) 
        begin
            mfmc0_sm <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2123 
            begin
                mfmc0_sm <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( opcod_sd == 9'b110100000 ) 
        begin
            mfc2_sd <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2125 
            begin
                mfc2_sd <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( opcod_rd == 9'b110100000 ) 
        begin
            mfc2_se <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2126 
            begin
                mfc2_se <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( opcod_sd == 9'b110100100 ) 
        begin
            mtc2_sd <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2128 
            begin
                mtc2_sd <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( opcod_rd == 9'b110100100 ) 
        begin
            mtc2_se <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2129 
            begin
                mtc2_se <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( opcod_sd == 9'b101100000 ) 
        begin
            wait_sd <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2131 
            begin
                wait_sd <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( opcod_rd == 9'b101100000 ) 
        begin
            wait_se <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2132 
            begin
                wait_se <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( opcod_re == 9'b101100000 ) 
        begin
            wait_sm <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2133 
            begin
                wait_sm <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( opcod_rd == 9'b000001111 ) 
        begin
            sync_se <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2135 
            begin
                sync_se <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( opcod_rd == 9'b001101111 ) 
        begin
            cach_se <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2137 
            begin
                cach_se <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( opcod_rd == 9'b011111011 ) 
        begin
            rdhwr_se <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2139 
            begin
                rdhwr_se <= 1'b0;
            end
        end
    end
    assign iabuser_xi = ( i_rberr & irq_re );
    assign iamalgn_xi = ( nextpc_rd[0] | nextpc_rd[1] );
    always 
    begin
        if ( impstd_sx == 1'b1 ) 
        begin
            iasviol_xi <= ( nextpc_rd[31] & usrmod_sx );
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2153 
            begin
                iasviol_xi <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( ( ( iabuser_ri == 1'b1 ) | ( iabuser_rd == 1'b1 ) ) | ( iabuser_re == 1'b1 ) ) 
        begin
            iberen_sx <= 1'b0;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2160 
            begin
                iberen_sx <= 1'b1;
            end
        end
    end
    assign cop0s_sd = { i_ri[15:11], i_ri[2:0] };
    assign cop0d_sd = { i_ri[15:11], i_ri[2:0] };
    always 
    begin
        if ( opcod_sd == 9'b001000011 ) 
        begin
            wr31_sd <= 1'b1;
        end
        else
        begin 
            if ( opcod_sd == 9'b100010000 ) 
            begin
                wr31_sd <= 1'b1;
            end
            else
            begin 
                if ( opcod_sd == 9'b100010001 ) 
                begin
                    wr31_sd <= 1'b1;
                end
                else
                begin 
                    if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2178 
                    begin
                        wr31_sd <= 1'b0;
                    end
                end
            end
        end
    end
    assign rs_sd = i_ri[25:21];
    assign rt_sd = i_ri[20:16];
    always @ (  rs_sd)
    begin
        if ( rs_sd == 5'b00000 ) 
        begin
            s_sd <= 8'b00000000;
        end
        else
        begin 
            if ( rs_sd == 5'b00001 ) 
            begin
                s_sd <= r1_rw;
            end
            else
            begin 
                if ( rs_sd == 5'b00010 ) 
                begin
                    s_sd <= r2_rw;
                end
                else
                begin 
                    if ( rs_sd == 5'b00011 ) 
                    begin
                        s_sd <= r3_rw;
                    end
                    else
                    begin 
                        if ( rs_sd == 5'b00100 ) 
                        begin
                            s_sd <= r4_rw;
                        end
                        else
                        begin 
                            if ( rs_sd == 5'b00101 ) 
                            begin
                                s_sd <= r5_rw;
                            end
                            else
                            begin 
                                if ( rs_sd == 5'b00110 ) 
                                begin
                                    s_sd <= r6_rw;
                                end
                                else
                                begin 
                                    if ( rs_sd == 5'b00111 ) 
                                    begin
                                        s_sd <= r7_rw;
                                    end
                                    else
                                    begin 
                                        if ( rs_sd == 5'b01000 ) 
                                        begin
                                            s_sd <= r8_rw;
                                        end
                                        else
                                        begin 
                                            if ( rs_sd == 5'b01001 ) 
                                            begin
                                                s_sd <= r9_rw;
                                            end
                                            else
                                            begin 
                                                if ( rs_sd == 5'b01010 ) 
                                                begin
                                                    s_sd <= r10_rw;
                                                end
                                                else
                                                begin 
                                                    if ( rs_sd == 5'b01011 ) 
                                                    begin
                                                        s_sd <= r11_rw;
                                                    end
                                                    else
                                                    begin 
                                                        if ( rs_sd == 5'b01100 ) 
                                                        begin
                                                            s_sd <= r12_rw;
                                                        end
                                                        else
                                                        begin 
                                                            if ( rs_sd == 5'b01101 ) 
                                                            begin
                                                                s_sd <= r13_rw;
                                                            end
                                                            else
                                                            begin 
                                                                if ( rs_sd == 5'b01110 ) 
                                                                begin
                                                                    s_sd <= r14_rw;
                                                                end
                                                                else
                                                                begin 
                                                                    if ( rs_sd == 5'b01111 ) 
                                                                    begin
                                                                        s_sd <= r15_rw;
                                                                    end
                                                                    else
                                                                    begin 
                                                                        if ( rs_sd == 5'b10000 ) 
                                                                        begin
                                                                            s_sd <= r16_rw;
                                                                        end
                                                                        else
                                                                        begin 
                                                                            if ( rs_sd == 5'b10001 ) 
                                                                            begin
                                                                                s_sd <= r17_rw;
                                                                            end
                                                                            else
                                                                            begin 
                                                                                if ( rs_sd == 5'b10010 ) 
                                                                                begin
                                                                                    s_sd <= r18_rw;
                                                                                end
                                                                                else
                                                                                begin 
                                                                                    if ( rs_sd == 5'b10011 ) 
                                                                                    begin
                                                                                        s_sd <= r19_rw;
                                                                                    end
                                                                                    else
                                                                                    begin 
                                                                                        if ( rs_sd == 5'b10100 ) 
                                                                                        begin
                                                                                            s_sd <= r20_rw;
                                                                                        end
                                                                                        else
                                                                                        begin 
                                                                                            if ( rs_sd == 5'b10101 ) 
                                                                                            begin
                                                                                                s_sd <= r21_rw;
                                                                                            end
                                                                                            else
                                                                                            begin 
                                                                                                if ( rs_sd == 5'b10110 ) 
                                                                                                begin
                                                                                                    s_sd <= r22_rw;
                                                                                                end
                                                                                                else
                                                                                                begin 
                                                                                                    if ( rs_sd == 5'b10111 ) 
                                                                                                    begin
                                                                                                        s_sd <= r23_rw;
                                                                                                    end
                                                                                                    else
                                                                                                    begin 
                                                                                                        if ( rs_sd == 5'b11000 ) 
                                                                                                        begin
                                                                                                            s_sd <= r24_rw;
                                                                                                        end
                                                                                                        else
                                                                                                        begin 
                                                                                                            if ( rs_sd == 5'b11001 ) 
                                                                                                            begin
                                                                                                                s_sd <= r25_rw;
                                                                                                            end
                                                                                                            else
                                                                                                            begin 
                                                                                                                if ( rs_sd == 5'b11010 ) 
                                                                                                                begin
                                                                                                                    s_sd <= r26_rw;
                                                                                                                end
                                                                                                                else
                                                                                                                begin 
                                                                                                                    if ( rs_sd == 5'b11011 ) 
                                                                                                                    begin
                                                                                                                        s_sd <= r27_rw;
                                                                                                                    end
                                                                                                                    else
                                                                                                                    begin 
                                                                                                                        if ( rs_sd == 5'b11100 ) 
                                                                                                                        begin
                                                                                                                            s_sd <= r28_rw;
                                                                                                                        end
                                                                                                                        else
                                                                                                                        begin 
                                                                                                                            if ( rs_sd == 5'b11101 ) 
                                                                                                                            begin
                                                                                                                                s_sd <= r29_rw;
                                                                                                                            end
                                                                                                                            else
                                                                                                                            begin 
                                                                                                                                if ( rs_sd == 5'b11110 ) 
                                                                                                                                begin
                                                                                                                                    s_sd <= r30_rw;
                                                                                                                                end
                                                                                                                                else
                                                                                                                                begin 
                                                                                                                                    if ( rs_sd == 5'b11111 ) 
                                                                                                                                    begin
                                                                                                                                        s_sd <= r31_rw;
                                                                                                                                    end
                                                                                                                                    else
                                                                                                                                    begin 
                                                                                                                                        s_sd <= 1'b0;
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            end
                                                                                                                        end
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    always @ (  rt_sd)
    begin
        if ( rt_sd == 5'b00000 ) 
        begin
            t_sd <= 8'b00000000;
        end
        else
        begin 
            if ( rt_sd == 5'b00001 ) 
            begin
                t_sd <= r1_rw;
            end
            else
            begin 
                if ( rt_sd == 5'b00010 ) 
                begin
                    t_sd <= r2_rw;
                end
                else
                begin 
                    if ( rt_sd == 5'b00011 ) 
                    begin
                        t_sd <= r3_rw;
                    end
                    else
                    begin 
                        if ( rt_sd == 5'b00100 ) 
                        begin
                            t_sd <= r4_rw;
                        end
                        else
                        begin 
                            if ( rt_sd == 5'b00101 ) 
                            begin
                                t_sd <= r5_rw;
                            end
                            else
                            begin 
                                if ( rt_sd == 5'b00110 ) 
                                begin
                                    t_sd <= r6_rw;
                                end
                                else
                                begin 
                                    if ( rt_sd == 5'b00111 ) 
                                    begin
                                        t_sd <= r7_rw;
                                    end
                                    else
                                    begin 
                                        if ( rt_sd == 5'b01000 ) 
                                        begin
                                            t_sd <= r8_rw;
                                        end
                                        else
                                        begin 
                                            if ( rt_sd == 5'b01001 ) 
                                            begin
                                                t_sd <= r9_rw;
                                            end
                                            else
                                            begin 
                                                if ( rt_sd == 5'b01010 ) 
                                                begin
                                                    t_sd <= r10_rw;
                                                end
                                                else
                                                begin 
                                                    if ( rt_sd == 5'b01011 ) 
                                                    begin
                                                        t_sd <= r11_rw;
                                                    end
                                                    else
                                                    begin 
                                                        if ( rt_sd == 5'b01100 ) 
                                                        begin
                                                            t_sd <= r12_rw;
                                                        end
                                                        else
                                                        begin 
                                                            if ( rt_sd == 5'b01101 ) 
                                                            begin
                                                                t_sd <= r13_rw;
                                                            end
                                                            else
                                                            begin 
                                                                if ( rt_sd == 5'b01110 ) 
                                                                begin
                                                                    t_sd <= r14_rw;
                                                                end
                                                                else
                                                                begin 
                                                                    if ( rt_sd == 5'b01111 ) 
                                                                    begin
                                                                        t_sd <= r15_rw;
                                                                    end
                                                                    else
                                                                    begin 
                                                                        if ( rt_sd == 5'b10000 ) 
                                                                        begin
                                                                            t_sd <= r16_rw;
                                                                        end
                                                                        else
                                                                        begin 
                                                                            if ( rt_sd == 5'b10001 ) 
                                                                            begin
                                                                                t_sd <= r17_rw;
                                                                            end
                                                                            else
                                                                            begin 
                                                                                if ( rt_sd == 5'b10010 ) 
                                                                                begin
                                                                                    t_sd <= r18_rw;
                                                                                end
                                                                                else
                                                                                begin 
                                                                                    if ( rt_sd == 5'b10011 ) 
                                                                                    begin
                                                                                        t_sd <= r19_rw;
                                                                                    end
                                                                                    else
                                                                                    begin 
                                                                                        if ( rt_sd == 5'b10100 ) 
                                                                                        begin
                                                                                            t_sd <= r20_rw;
                                                                                        end
                                                                                        else
                                                                                        begin 
                                                                                            if ( rt_sd == 5'b10101 ) 
                                                                                            begin
                                                                                                t_sd <= r21_rw;
                                                                                            end
                                                                                            else
                                                                                            begin 
                                                                                                if ( rt_sd == 5'b10110 ) 
                                                                                                begin
                                                                                                    t_sd <= r22_rw;
                                                                                                end
                                                                                                else
                                                                                                begin 
                                                                                                    if ( rt_sd == 5'b10111 ) 
                                                                                                    begin
                                                                                                        t_sd <= r23_rw;
                                                                                                    end
                                                                                                    else
                                                                                                    begin 
                                                                                                        if ( rt_sd == 5'b11000 ) 
                                                                                                        begin
                                                                                                            t_sd <= r24_rw;
                                                                                                        end
                                                                                                        else
                                                                                                        begin 
                                                                                                            if ( rt_sd == 5'b11001 ) 
                                                                                                            begin
                                                                                                                t_sd <= r25_rw;
                                                                                                            end
                                                                                                            else
                                                                                                            begin 
                                                                                                                if ( rt_sd == 5'b11010 ) 
                                                                                                                begin
                                                                                                                    t_sd <= r26_rw;
                                                                                                                end
                                                                                                                else
                                                                                                                begin 
                                                                                                                    if ( rt_sd == 5'b11011 ) 
                                                                                                                    begin
                                                                                                                        t_sd <= r27_rw;
                                                                                                                    end
                                                                                                                    else
                                                                                                                    begin 
                                                                                                                        if ( rt_sd == 5'b11100 ) 
                                                                                                                        begin
                                                                                                                            t_sd <= r28_rw;
                                                                                                                        end
                                                                                                                        else
                                                                                                                        begin 
                                                                                                                            if ( rt_sd == 5'b11101 ) 
                                                                                                                            begin
                                                                                                                                t_sd <= r29_rw;
                                                                                                                            end
                                                                                                                            else
                                                                                                                            begin 
                                                                                                                                if ( rt_sd == 5'b11110 ) 
                                                                                                                                begin
                                                                                                                                    t_sd <= r30_rw;
                                                                                                                                end
                                                                                                                                else
                                                                                                                                begin 
                                                                                                                                    if ( rt_sd == 5'b11111 ) 
                                                                                                                                    begin
                                                                                                                                        t_sd <= r31_rw;
                                                                                                                                    end
                                                                                                                                    else
                                                                                                                                    begin 
                                                                                                                                        t_sd <= 1'b0;
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            end
                                                                                                                        end
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    assign cp_sde_sd = ( rs_sd ^ rd_rd );
    assign cp_sdm_sd = ( rs_sd ^ rd_re );
    assign cp_sdw_sd = ( rs_sd ^ rd_rm );
    assign cp_tde_sd = ( rt_sd ^ rd_rd );
    assign cp_tdm_sd = ( rt_sd ^ rd_re );
    assign cp_tdw_sd = ( rt_sd ^ rd_rm );
    always 
    begin
        if ( rs_sd == 5'b00000 ) 
        begin
            sreadr0_sd <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2279 
            begin
                sreadr0_sd <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( rt_sd == 5'b00000 ) 
        begin
            treadr0_sd <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2280 
            begin
                treadr0_sd <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( ( ( ( cp_sde_sd == 5'b00000 ) & ( sreadr0_sd == 1'b0 ) ) & ( i_reads_sd == 1'b1 ) ) & ( i_wreg_se == 1'b1 ) ) 
        begin
            hz_sde_sd <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2292 
            begin
                hz_sde_sd <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( ( ( ( cp_sdm_sd == 5'b00000 ) & ( sreadr0_sd == 1'b0 ) ) & ( i_reads_sd == 1'b1 ) ) & ( i_wreg_sm == 1'b1 ) ) 
        begin
            hz_sdm_sd <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2295 
            begin
                hz_sdm_sd <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( ( ( ( cp_sdw_sd == 5'b00000 ) & ( sreadr0_sd == 1'b0 ) ) & ( i_reads_sd == 1'b1 ) ) & ( i_wreg_sw == 1'b1 ) ) 
        begin
            hz_sdw_sd <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2298 
            begin
                hz_sdw_sd <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( ( ( ( cp_tde_sd == 5'b00000 ) & ( treadr0_sd == 1'b0 ) ) & ( i_readt_sd == 1'b1 ) ) & ( i_wreg_se == 1'b1 ) ) 
        begin
            hz_tde_sd <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2302 
            begin
                hz_tde_sd <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( ( ( ( cp_tdm_sd == 5'b00000 ) & ( treadr0_sd == 1'b0 ) ) & ( i_readt_sd == 1'b1 ) ) & ( i_wreg_sm == 1'b1 ) ) 
        begin
            hz_tdm_sd <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2305 
            begin
                hz_tdm_sd <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( ( ( ( cp_tdw_sd == 5'b00000 ) & ( treadr0_sd == 1'b0 ) ) & ( i_readt_sd == 1'b1 ) ) & ( i_wreg_sw == 1'b1 ) ) 
        begin
            hz_tdw_sd <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2308 
            begin
                hz_tdw_sd <= 1'b0;
            end
        end
    end
    assign dathzds_sd = ( ( ( ( ( ( ( ( ( ( ( ( i_duses_sd & hz_sde_sd ) | ( ( i_duses_sd & hz_sdm_sd ) & ( i_mpdc_sm | i_wpdc_sm ) ) ) | ( ( i_duses_sd & hz_sdw_sd ) & i_wpdc_sw ) ) | ( ( i_euses_sd & hz_sde_sd ) & i_wpdc_se ) ) | ( ( i_euses_sd & hz_sdm_sd ) & i_wpdc_sm ) ) | ( ( i_euses_sd & hz_sdw_sd ) & i_wpdc_sw ) ) | ( i_duset_sd & hz_tde_sd ) ) | ( ( i_duset_sd & hz_tdm_sd ) & ( i_mpdc_sm | i_wpdc_sm ) ) ) | ( ( i_duset_sd & hz_tdw_sd ) & i_wpdc_sw ) ) | ( ( i_euset_sd & hz_tde_sd ) & i_wpdc_se ) ) | ( ( i_euset_sd & hz_tdm_sd ) & i_wpdc_sm ) ) | ( ( i_euset_sd & hz_tdw_sd ) & i_wpdc_sw ) );
    always 
    begin
        if ( ( mtc0_se == 1'b1 ) | ( mtc0_sm == 1'b1 ) ) 
        begin
            inshzds_sd <= 1'b1;
        end
        else
        begin 
            if ( ( mfmc0_se == 1'b1 ) | ( mfmc0_sm == 1'b1 ) ) 
            begin
                inshzds_sd <= 1'b1;
            end
            else
            begin 
                if ( ( eret_se == 1'b1 ) | ( eret_sm == 1'b1 ) ) 
                begin
                    inshzds_sd <= 1'b1;
                end
                else
                begin 
                    if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2360 
                    begin
                        inshzds_sd <= 1'b0;
                    end
                end
            end
        end
    end
    assign hazards_sd = ( dathzds_sd | inshzds_sd );
    always @ (  res_re or  data_rm or  s_sd)
    begin
        if ( hz_sdm_sd == 1'b1 ) 
        begin
            soper_sd <= res_re;
        end
        else
        begin 
            if ( hz_sdw_sd == 1'b1 ) 
            begin
                soper_sd <= data_rm;
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2377 
                begin
                    soper_sd <= s_sd;
                end
            end
        end
    end
    always @ (  res_re or  data_rm or  t_sd)
    begin
        if ( hz_tdm_sd == 1'b1 ) 
        begin
            toper_sd <= res_re;
        end
        else
        begin 
            if ( hz_tdw_sd == 1'b1 ) 
            begin
                toper_sd <= data_rm;
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2381 
                begin
                    toper_sd <= t_sd;
                end
            end
        end
    end
    always @ (  cop0s_sd)
    begin
        if ( cop0s_sd == 8'b01000000 ) 
        begin
            cop0op_sd <= badva_rx;
        end
        else
        begin 
            if ( cop0s_sd == 8'b01001000 ) 
            begin
                cop0op_sd <= count_rx;
            end
            else
            begin 
                if ( cop0s_sd == 8'b01100000 ) 
                begin
                    cop0op_sd <= status_rx;
                end
                else
                begin 
                    if ( cop0s_sd == 8'b01110000 ) 
                    begin
                        cop0op_sd <= epc_rx;
                    end
                    else
                    begin 
                        if ( cop0s_sd == 8'b01101000 ) 
                        begin
                            cop0op_sd <= cause_rx;
                        end
                        else
                        begin 
                            if ( cop0s_sd == 8'b01111000 ) 
                            begin
                                cop0op_sd <= 8'b00000000;
                            end
                            else
                            begin 
                                if ( cop0s_sd == 8'b01111001 ) 
                                begin
                                    cop0op_sd <= ebase_rm;
                                end
                                else
                                begin 
                                    if ( cop0s_sd == 8'b11110000 ) 
                                    begin
                                        cop0op_sd <= eepc_rx;
                                    end
                                    else
                                    begin 
                                        if ( cop0s_sd == 8'b00010101 ) 
                                        begin
                                            cop0op_sd <= tcctx_rm;
                                        end
                                        else
                                        begin 
                                            if ( cop0s_sd == 8'b00100010 ) 
                                            begin
                                                cop0op_sd <= usrlcl_rm;
                                            end
                                            else
                                            begin 
                                                if ( cop0s_sd == 8'b00111000 ) 
                                                begin
                                                    cop0op_sd <= hwrena_rm;
                                                end
                                                else
                                                begin 
                                                    cop0op_sd <= 1'b0;
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    always @ (  rd_sd)
    begin
        if ( rd_sd == 5'b00010 ) 
        begin
            hwrop_sd <= count_rx;
        end
        else
        begin 
            if ( rd_sd == 5'b00000 ) 
            begin
                hwrop_sd <= { 1'b0, ebase_rm[9:0] };
            end
            else
            begin 
                if ( rd_sd == 5'b11101 ) 
                begin
                    hwrop_sd <= usrlcl_rm;
                end
                else
                begin 
                    hwrop_sd <= 1'b0;
                end
            end
        end
    end
    always 
    begin
        if ( ( i_ri[15] == 1'b1 ) & ( i_osgnd_sd == 1'b1 ) ) 
        begin
            imdsex_sd <= 16'b1111111111111111;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2419 
            begin
                imdsex_sd <= 4'b0000;
            end
        end
    end
    always @ (  opcod_sd)
    begin
        if ( opcod_sd == 9'b100010000 ) 
        begin
            ioper_sd <= seqadr_sd;
        end
        else
        begin 
            if ( opcod_sd == 9'b100010001 ) 
            begin
                ioper_sd <= seqadr_sd;
            end
            else
            begin 
                if ( opcod_sd == 9'b000001001 ) 
                begin
                    ioper_sd <= seqadr_sd;
                end
                else
                begin 
                    if ( opcod_sd == 9'b001000011 ) 
                    begin
                        ioper_sd <= seqadr_sd;
                    end
                    else
                    begin 
                        if ( opcod_sd == 9'b001001111 ) 
                        begin
                            ioper_sd <= { i_ri[15:0], 4'b0000 };
                        end
                        else
                        begin 
                            if ( opcod_sd == 9'b100100000 ) 
                            begin
                                ioper_sd <= cop0op_sd;
                            end
                            else
                            begin 
                                if ( opcod_sd == 9'b100101011 ) 
                                begin
                                    ioper_sd <= cop0op_sd;
                                end
                                else
                                begin 
                                    if ( opcod_sd == 9'b011111011 ) 
                                    begin
                                        ioper_sd <= hwrop_sd;
                                    end
                                    else
                                    begin 
                                        ioper_sd <= { imdsex_sd, i_ri[15:0] };
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    assign sham_sd = i_ri[10:6];
    always @ (  eepc_rx or  epc_rx)
    begin
        if ( status_rx[2] == 1'b1 ) 
        begin
            retadr_sd <= eepc_rx;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2444 
            begin
                retadr_sd <= epc_rx;
            end
        end
    end
    assign jmpadr_sd = { nextpc_rd[31:28], 2'b00 };
    assign braofs_sd = { imdsex_sd[13:0], 2'b00 };
    assign brapr0_sd = ( braofs_sd | nextpc_rd );
    assign bragn0_sd = ( braofs_sd & nextpc_rd );
    assign brapr1_sd = ( brapr0_sd & { brapr0_sd[30:0], 1'b1 } );
    assign brapr2_sd = ( brapr1_sd & { brapr1_sd[29:0], 2'b11 } );
    assign brapr3_sd = ( brapr2_sd & { brapr2_sd[27:0], 4'b1111 } );
    assign brapr4_sd = ( brapr3_sd & { brapr3_sd[23:0], 8'b11111111 } );
    assign brapr5_sd = ( brapr4_sd & { brapr4_sd[15:0], 16'b1111111111111111 } );
    assign bragn1_sd = ( bragn0_sd | ( brapr0_sd & { bragn0_sd[30:0], 1'b0 } ) );
    assign bragn2_sd = ( bragn1_sd | ( brapr1_sd & { bragn1_sd[29:0], 2'b00 } ) );
    assign bragn3_sd = ( bragn2_sd | ( brapr2_sd & { bragn2_sd[27:0], 1'b0 } ) );
    assign bragn4_sd = ( bragn3_sd | ( brapr3_sd & { bragn3_sd[23:0], 2'b00 } ) );
    assign bragn5_sd = ( bragn4_sd | ( brapr4_sd & { bragn4_sd[15:0], 4'b0000 } ) );
    assign bracry_sd = bragn5_sd;
    assign bracyi_sd = { bracry_sd[30:0], 1'b0 };
    assign braadr_sd = ( ( bracyi_sd ^ braofs_sd ) ^ nextpc_rd );
    assign seqpr0_sd = nextpc_rd[31:2];
    assign seqpr1_sd = ( seqpr0_sd & { seqpr0_sd[32:4], 1'b1 } );
    assign seqpr2_sd = ( seqpr1_sd & { seqpr1_sd[31:4], 2'b11 } );
    assign seqpr3_sd = ( seqpr2_sd & { seqpr2_sd[29:4], 4'b1111 } );
    assign seqpr4_sd = ( seqpr3_sd & { seqpr3_sd[25:4], 8'b11111111 } );
    assign seqpr5_sd = ( seqpr4_sd & { seqpr4_sd[17:4], 16'b1111111111111111 } );
    assign seqcry_sd = seqpr5_sd;
    assign seqcyi_sd = { seqcry_sd[32:4], 3'b100 };
    assign seqadr_sd = ( seqcyi_sd ^ nextpc_rd );
    assign s_cp_t_sd = ( soper_sd ^ toper_sd );
    always 
    begin
        if ( s_cp_t_sd == 8'b00000000 ) 
        begin
            s_eq_t_sd <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2533 
            begin
                s_eq_t_sd <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( soper_sd[31] == 1'b1 ) 
        begin
            s_lt_z_sd <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2534 
            begin
                s_lt_z_sd <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( ( soper_sd[31] == 1'b1 ) | ( soper_sd == 8'b00000000 ) ) 
        begin
            s_le_z_sd <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2535 
            begin
                s_le_z_sd <= 1'b0;
            end
        end
    end
    always @ (  retadr_sd or  nextpc_rd or  soper_sd or  jmpadr_sd or  braadr_sd or  seqadr_sd)
    begin
        if ( eret_sd == 1'b1 ) 
        begin
            nextpc_sd <= retadr_sd;
        end
        else
        begin 
            if ( mtc0_sd == 1'b1 ) 
            begin
                nextpc_sd <= nextpc_rd;
            end
            else
            begin 
                if ( ( opcod_sd == 9'b000001000 ) | ( opcod_sd == 9'b000001001 ) ) 
                begin
                    nextpc_sd <= soper_sd;
                end
                else
                begin 
                    if ( ( opcod_sd == 9'b001000010 ) | ( opcod_sd == 9'b001000011 ) ) 
                    begin
                        nextpc_sd <= jmpadr_sd;
                    end
                    else
                    begin 
                        if ( ( ( ( ( ( ( ( ( opcod_sd == 9'b001000100 ) & ( s_eq_t_sd == 1'b1 ) ) | ( ( opcod_sd == 9'b001000101 ) & ( s_eq_t_sd == 1'b0 ) ) ) | ( ( opcod_sd == 9'b100000000 ) & ( s_lt_z_sd == 1'b1 ) ) ) | ( ( opcod_sd == 9'b100010000 ) & ( s_lt_z_sd == 1'b1 ) ) ) | ( ( opcod_sd == 9'b001000110 ) & ( s_le_z_sd == 1'b1 ) ) ) | ( ( opcod_sd == 9'b001000111 ) & ( s_le_z_sd == 1'b0 ) ) ) | ( ( opcod_sd == 9'b100000001 ) & ( s_lt_z_sd == 1'b0 ) ) ) | ( ( opcod_sd == 9'b100010001 ) & ( s_lt_z_sd == 1'b0 ) ) ) 
                        begin
                            nextpc_sd <= braadr_sd;
                        end
                        else
                        begin 
                            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2542 
                            begin
                                nextpc_sd <= seqadr_sd;
                            end
                        end
                    end
                end
            end
        end
    end
    assign seqi_sd =  ~( ( i_brnch_sd | eret_sd ));
    always @ (  seqi_sd)
    begin
        if ( ( nextpc_rd | 32'b11111111111111111111111111000011 ) == 32'b11111111111111111111111111111111 ) 
        begin
            iinlin_sd <= 1'b0;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2563 
            begin
                iinlin_sd <= seqi_sd;
            end
        end
    end
    assign rd_sd = i_ri[15:11];
    always @ (  rd_sd or  rt_sd)
    begin
        if ( ( i_wreg_sd & wr31_sd ) == 1'b1 ) 
        begin
            effrd_sd <= 5'b11111;
        end
        else
        begin 
            if ( ( i_wreg_sd & i_rfmt_sd ) == 1'b1 ) 
            begin
                effrd_sd <= rd_sd;
            end
            else
            begin 
                if ( ( i_wreg_sd & i_ifmt_sd ) == 1'b1 ) 
                begin
                    effrd_sd <= rt_sd;
                end
                else
                begin 
                    if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2576 
                    begin
                        effrd_sd <= 5'b00000;
                    end
                end
            end
        end
    end
    always @ (  rd_sd)
    begin
        if ( rd_sd == 5'b00000 ) 
        begin
            rddec_sd <= 1'b1;
        end
        else
        begin 
            if ( rd_sd == 5'b00001 ) 
            begin
                rddec_sd <= 2'b10;
            end
            else
            begin 
                if ( rd_sd == 5'b00010 ) 
                begin
                    rddec_sd <= 3'b100;
                end
                else
                begin 
                    if ( rd_sd == 5'b00011 ) 
                    begin
                        rddec_sd <= 4'b1000;
                    end
                    else
                    begin 
                        if ( rd_sd == 5'b00100 ) 
                        begin
                            rddec_sd <= 5'b10000;
                        end
                        else
                        begin 
                            if ( rd_sd == 5'b00101 ) 
                            begin
                                rddec_sd <= 6'b100000;
                            end
                            else
                            begin 
                                if ( rd_sd == 5'b00110 ) 
                                begin
                                    rddec_sd <= 7'b1000000;
                                end
                                else
                                begin 
                                    if ( rd_sd == 5'b00111 ) 
                                    begin
                                        rddec_sd <= 8'b10000000;
                                    end
                                    else
                                    begin 
                                        if ( rd_sd == 5'b01000 ) 
                                        begin
                                            rddec_sd <= 9'b100000000;
                                        end
                                        else
                                        begin 
                                            if ( rd_sd == 5'b01001 ) 
                                            begin
                                                rddec_sd <= 10'b1000000000;
                                            end
                                            else
                                            begin 
                                                if ( rd_sd == 5'b01010 ) 
                                                begin
                                                    rddec_sd <= 11'b10000000000;
                                                end
                                                else
                                                begin 
                                                    if ( rd_sd == 5'b01011 ) 
                                                    begin
                                                        rddec_sd <= 12'b100000000000;
                                                    end
                                                    else
                                                    begin 
                                                        if ( rd_sd == 5'b01100 ) 
                                                        begin
                                                            rddec_sd <= 13'b1000000000000;
                                                        end
                                                        else
                                                        begin 
                                                            if ( rd_sd == 5'b01101 ) 
                                                            begin
                                                                rddec_sd <= 14'b10000000000000;
                                                            end
                                                            else
                                                            begin 
                                                                if ( rd_sd == 5'b01110 ) 
                                                                begin
                                                                    rddec_sd <= 15'b100000000000000;
                                                                end
                                                                else
                                                                begin 
                                                                    if ( rd_sd == 5'b01111 ) 
                                                                    begin
                                                                        rddec_sd <= 16'b1000000000000000;
                                                                    end
                                                                    else
                                                                    begin 
                                                                        if ( rd_sd == 5'b10000 ) 
                                                                        begin
                                                                            rddec_sd <= 17'b10000000000000000;
                                                                        end
                                                                        else
                                                                        begin 
                                                                            if ( rd_sd == 5'b10001 ) 
                                                                            begin
                                                                                rddec_sd <= 18'b100000000000000000;
                                                                            end
                                                                            else
                                                                            begin 
                                                                                if ( rd_sd == 5'b10010 ) 
                                                                                begin
                                                                                    rddec_sd <= 19'b1000000000000000000;
                                                                                end
                                                                                else
                                                                                begin 
                                                                                    if ( rd_sd == 5'b10011 ) 
                                                                                    begin
                                                                                        rddec_sd <= 20'b10000000000000000000;
                                                                                    end
                                                                                    else
                                                                                    begin 
                                                                                        if ( rd_sd == 5'b10100 ) 
                                                                                        begin
                                                                                            rddec_sd <= 21'b100000000000000000000;
                                                                                        end
                                                                                        else
                                                                                        begin 
                                                                                            if ( rd_sd == 5'b10101 ) 
                                                                                            begin
                                                                                                rddec_sd <= 22'b1000000000000000000000;
                                                                                            end
                                                                                            else
                                                                                            begin 
                                                                                                if ( rd_sd == 5'b10110 ) 
                                                                                                begin
                                                                                                    rddec_sd <= 23'b10000000000000000000000;
                                                                                                end
                                                                                                else
                                                                                                begin 
                                                                                                    if ( rd_sd == 5'b10111 ) 
                                                                                                    begin
                                                                                                        rddec_sd <= 24'b100000000000000000000000;
                                                                                                    end
                                                                                                    else
                                                                                                    begin 
                                                                                                        if ( rd_sd == 5'b11000 ) 
                                                                                                        begin
                                                                                                            rddec_sd <= 25'b1000000000000000000000000;
                                                                                                        end
                                                                                                        else
                                                                                                        begin 
                                                                                                            if ( rd_sd == 5'b11001 ) 
                                                                                                            begin
                                                                                                                rddec_sd <= 26'b10000000000000000000000000;
                                                                                                            end
                                                                                                            else
                                                                                                            begin 
                                                                                                                if ( rd_sd == 5'b11010 ) 
                                                                                                                begin
                                                                                                                    rddec_sd <= 27'b100000000000000000000000000;
                                                                                                                end
                                                                                                                else
                                                                                                                begin 
                                                                                                                    if ( rd_sd == 5'b11011 ) 
                                                                                                                    begin
                                                                                                                        rddec_sd <= 28'b1000000000000000000000000000;
                                                                                                                    end
                                                                                                                    else
                                                                                                                    begin 
                                                                                                                        if ( rd_sd == 5'b11100 ) 
                                                                                                                        begin
                                                                                                                            rddec_sd <= 29'b10000000000000000000000000000;
                                                                                                                        end
                                                                                                                        else
                                                                                                                        begin 
                                                                                                                            if ( rd_sd == 5'b11101 ) 
                                                                                                                            begin
                                                                                                                                rddec_sd <= 30'b100000000000000000000000000000;
                                                                                                                            end
                                                                                                                            else
                                                                                                                            begin 
                                                                                                                                if ( rd_sd == 5'b11110 ) 
                                                                                                                                begin
                                                                                                                                    rddec_sd <= 31'b1000000000000000000000000000000;
                                                                                                                                end
                                                                                                                                else
                                                                                                                                begin 
                                                                                                                                    if ( rd_sd == 5'b11111 ) 
                                                                                                                                    begin
                                                                                                                                        rddec_sd <= 32'b10000000000000000000000000000000;
                                                                                                                                    end
                                                                                                                                    else
                                                                                                                                    begin 
                                                                                                                                        rddec_sd <= 1'b0;
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            end
                                                                                                                        end
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    assign effhwre_sd = ( rddec_sd & hwrena_rm );
    always 
    begin
        if ( status_rx[4:1] == 4'b1000 ) 
        begin
            usrmod_sx <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2638 
            begin
                usrmod_sx <= 1'b0;
            end
        end
    end
    assign rsvdins_xd = i_illg_sd;
    assign break_xd = i_brek_sd;
    assign syscall_xd = i_sysc_sd;
    always 
    begin
        if ( eret_sd == 1'b1 ) 
        begin
            cpunuse_xd <= (  ~( status_rx[28]) & usrmod_sx );
        end
        else
        begin 
            if ( mfc0_sd == 1'b1 ) 
            begin
                cpunuse_xd <= (  ~( status_rx[28]) & usrmod_sx );
            end
            else
            begin 
                if ( mtc0_sd == 1'b1 ) 
                begin
                    cpunuse_xd <= (  ~( status_rx[28]) & usrmod_sx );
                end
                else
                begin 
                    if ( mfmc0_sd == 1'b1 ) 
                    begin
                        cpunuse_xd <= (  ~( status_rx[28]) & usrmod_sx );
                    end
                    else
                    begin 
                        if ( wait_sd == 1'b1 ) 
                        begin
                            cpunuse_xd <= (  ~( status_rx[28]) & usrmod_sx );
                        end
                        else
                        begin 
                            if ( mfc2_sd == 1'b1 ) 
                            begin
                                cpunuse_xd <= (  ~( status_rx[30]) & usrmod_sx );
                            end
                            else
                            begin 
                                if ( mtc2_sd == 1'b1 ) 
                                begin
                                    cpunuse_xd <= (  ~( status_rx[30]) & usrmod_sx );
                                end
                                else
                                begin 
                                    if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2655 
                                    begin
                                        cpunuse_xd <= 1'b0;
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    always 
    begin
        if ( mfc2_sd == 1'b1 ) 
        begin
            cpnbr_xd <= 2'b10;
        end
        else
        begin 
            if ( mtc2_sd == 1'b1 ) 
            begin
                cpnbr_xd <= 2'b10;
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2664 
                begin
                    cpnbr_xd <= 2'b00;
                end
            end
        end
    end
    always 
    begin
        if ( wait_se == 1'b1 ) 
        begin
            irq_se <= 1'b0;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2684 
            begin
                irq_se <= 1'b1;
            end
        end
    end
    assign inotrdy_se = (  ~( i_accpt) |  ~( irq_re) );
    assign cp_sdm_se = ( rs_rd ^ rd_re );
    assign cp_sdw_se = ( rs_rd ^ rd_rm );
    assign cp_tdm_se = ( rt_rd ^ rd_re );
    assign cp_tdw_se = ( rt_rd ^ rd_rm );
    always 
    begin
        if ( rs_rd == 5'b00000 ) 
        begin
            sreadr0_se <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2705 
            begin
                sreadr0_se <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( rt_rd == 5'b00000 ) 
        begin
            treadr0_se <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2706 
            begin
                treadr0_se <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( ( ( ( cp_sdm_se == 5'b00000 ) & ( sreadr0_se == 1'b0 ) ) & ( i_reads_se == 1'b1 ) ) & ( i_wreg_sm == 1'b1 ) ) 
        begin
            hz_sdm_se <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2726 
            begin
                hz_sdm_se <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( ( ( ( cp_sdw_se == 5'b00000 ) & ( sreadr0_se == 1'b0 ) ) & ( i_reads_se == 1'b1 ) ) & ( i_wreg_sw == 1'b1 ) ) 
        begin
            hz_sdw_se <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2729 
            begin
                hz_sdw_se <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( ( ( ( cp_tdm_se == 5'b00000 ) & ( treadr0_se == 1'b0 ) ) & ( i_readt_se == 1'b1 ) ) & ( i_wreg_sm == 1'b1 ) ) 
        begin
            hz_tdm_se <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2733 
            begin
                hz_tdm_se <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( ( ( ( cp_tdw_se == 5'b00000 ) & ( treadr0_se == 1'b0 ) ) & ( i_readt_se == 1'b1 ) ) & ( i_wreg_sw == 1'b1 ) ) 
        begin
            hz_tdw_se <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2736 
            begin
                hz_tdw_se <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( ( i_eusel_se == 1'b1 ) & ( i_wlo_sm == 1'b1 ) ) 
        begin
            hz_lo_se <= 1'b1;
        end
        else
        begin 
            if ( ( i_eusel_se == 1'b1 ) & ( i_wlo_sw == 1'b1 ) ) 
            begin
                hz_lo_se <= 1'b1;
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2740 
                begin
                    hz_lo_se <= 1'b0;
                end
            end
        end
    end
    always 
    begin
        if ( ( i_euseh_se == 1'b1 ) & ( i_whi_sm == 1'b1 ) ) 
        begin
            hz_hi_se <= 1'b1;
        end
        else
        begin 
            if ( ( i_euseh_se == 1'b1 ) & ( i_whi_sw == 1'b1 ) ) 
            begin
                hz_hi_se <= 1'b1;
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2743 
                begin
                    hz_hi_se <= 1'b0;
                end
            end
        end
    end
    assign dathzds_se = ( ( ( ( ( i_euses_se & hz_sdm_se ) & i_mpdc_sm ) | ( ( i_euset_se & hz_tdm_se ) & i_mpdc_sm ) ) | hz_lo_se ) | hz_hi_se );
    assign hazards_se = dathzds_se;
    always @ (  res_re or  data_rm or  soper_rd)
    begin
        if ( hz_sdm_se == 1'b1 ) 
        begin
            soper_se <= res_re;
        end
        else
        begin 
            if ( hz_sdw_se == 1'b1 ) 
            begin
                soper_se <= data_rm;
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2784 
                begin
                    soper_se <= soper_rd;
                end
            end
        end
    end
    always @ (  res_re or  data_rm or  toper_rd)
    begin
        if ( hz_tdm_se == 1'b1 ) 
        begin
            toper_se <= res_re;
        end
        else
        begin 
            if ( hz_tdw_se == 1'b1 ) 
            begin
                toper_se <= data_rm;
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2788 
                begin
                    toper_se <= toper_rd;
                end
            end
        end
    end
    always @ (  lo_rw or  hi_rw or  ioper_rd)
    begin
        if ( opcod_rd == 9'b000010010 ) 
        begin
            ioper_se <= lo_rw;
        end
        else
        begin 
            if ( opcod_rd == 9'b000010000 ) 
            begin
                ioper_se <= hi_rw;
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2792 
                begin
                    ioper_se <= ioper_rd;
                end
            end
        end
    end
    always 
    begin
        if ( toper_se == 8'b00000000 ) 
        begin
            t_eq_z_se <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2804 
            begin
                t_eq_z_se <= 1'b0;
            end
        end
    end
    always @ (  t_eq_z_se)
    begin
        if ( opcod_rd == 9'b000001011 ) 
        begin
            cndwrg_se <=  ~( t_eq_z_se);
        end
        else
        begin 
            if ( opcod_rd == 9'b000001010 ) 
            begin
                cndwrg_se <= t_eq_z_se;
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2805 
                begin
                    cndwrg_se <= 1'b1;
                end
            end
        end
    end
    always @ (  rd_rd)
    begin
        if ( cndwrg_se == 1'b1 ) 
        begin
            rd_se <= rd_rd;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2808 
            begin
                rd_se <= 5'b00000;
            end
        end
    end
    assign xoper_se = soper_se;
    always @ (  ioper_rd or  toper_se)
    begin
        if ( i_ifmt_se == 1'b1 ) 
        begin
            yoper_se <= ioper_rd;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2815 
            begin
                yoper_se <= toper_se;
            end
        end
    end
    always @ (  soper_se)
    begin
        if ( i_clz_se == 1'b1 ) 
        begin
            cldxop_se <=  ~( soper_se);
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2822 
            begin
                cldxop_se <= soper_se;
            end
        end
    end
    assign cldpr1_se = ( cldxop_se & { 1'b1, cldxop_se[31:1] } );
    assign cldpr2_se = ( cldpr1_se & { 2'b11, cldpr1_se[31:2] } );
    assign cldpr3_se = ( cldpr2_se & { 4'b1111, cldpr2_se[31:4] } );
    assign cldpr4_se = ( cldpr3_se & { 8'b11111111, cldpr3_se[31:8] } );
    assign cldpr5_se = ( cldpr4_se & { 16'b1111111111111111, cldpr4_se[31:16] } );
    assign cldmsk_se = (  ~( cldxop_se) & { 1'b1, cldpr5_se[31:1] } );
    assign cld_5_se = cldpr5_se[0];
    assign cld_4_se = ( ( ( ( ( ( ( ( ( ( ( ( ( ( ( cldmsk_se[15] | cldmsk_se[14] ) | cldmsk_se[13] ) | cldmsk_se[12] ) | cldmsk_se[11] ) | cldmsk_se[10] ) | cldmsk_se[9] ) | cldmsk_se[8] ) | cldmsk_se[7] ) | cldmsk_se[6] ) | cldmsk_se[5] ) | cldmsk_se[4] ) | cldmsk_se[3] ) | cldmsk_se[2] ) | cldmsk_se[1] ) | cldmsk_se[0] );
    assign cld_3_se = ( ( ( ( ( ( ( ( ( ( ( ( ( ( ( cldmsk_se[23] | cldmsk_se[22] ) | cldmsk_se[21] ) | cldmsk_se[20] ) | cldmsk_se[19] ) | cldmsk_se[18] ) | cldmsk_se[17] ) | cldmsk_se[16] ) | cldmsk_se[7] ) | cldmsk_se[6] ) | cldmsk_se[5] ) | cldmsk_se[4] ) | cldmsk_se[3] ) | cldmsk_se[2] ) | cldmsk_se[1] ) | cldmsk_se[0] );
    assign cld_2_se = ( ( ( ( ( ( ( ( ( ( ( ( ( ( ( cldmsk_se[27] | cldmsk_se[26] ) | cldmsk_se[25] ) | cldmsk_se[24] ) | cldmsk_se[19] ) | cldmsk_se[18] ) | cldmsk_se[17] ) | cldmsk_se[16] ) | cldmsk_se[11] ) | cldmsk_se[10] ) | cldmsk_se[9] ) | cldmsk_se[8] ) | cldmsk_se[3] ) | cldmsk_se[2] ) | cldmsk_se[1] ) | cldmsk_se[0] );
    assign cld_1_se = ( ( ( ( ( ( ( ( ( ( ( ( ( ( ( cldmsk_se[29] | cldmsk_se[28] ) | cldmsk_se[25] ) | cldmsk_se[24] ) | cldmsk_se[21] ) | cldmsk_se[20] ) | cldmsk_se[17] ) | cldmsk_se[16] ) | cldmsk_se[13] ) | cldmsk_se[12] ) | cldmsk_se[9] ) | cldmsk_se[8] ) | cldmsk_se[5] ) | cldmsk_se[4] ) | cldmsk_se[1] ) | cldmsk_se[0] );
    assign cld_0_se = ( ( ( ( ( ( ( ( ( ( ( ( ( ( ( cldmsk_se[30] | cldmsk_se[28] ) | cldmsk_se[26] ) | cldmsk_se[24] ) | cldmsk_se[22] ) | cldmsk_se[20] ) | cldmsk_se[18] ) | cldmsk_se[16] ) | cldmsk_se[14] ) | cldmsk_se[12] ) | cldmsk_se[10] ) | cldmsk_se[8] ) | cldmsk_se[6] ) | cldmsk_se[4] ) | cldmsk_se[2] ) | cldmsk_se[0] );
    assign rclead_se = { 1'b0, cld_0_se };
    always @ (  xoper_se)
    begin
        if ( ( mtc2_se | mfc2_se ) == 1'b1 ) 
        begin
            xarith_se <= 1'b0;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2897 
            begin
                xarith_se <= xoper_se;
            end
        end
    end
    always @ (  yoper_se)
    begin
        if ( i_sub_se == 1'b1 ) 
        begin
            yarith_se <=  ~( yoper_se);
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2898 
            begin
                yarith_se <= yoper_se;
            end
        end
    end
    assign aripr0_se = ( xarith_se | yarith_se );
    assign arign0_se = ( xarith_se & yarith_se );
    assign aripr1_se = ( aripr0_se & { aripr0_se[30:0], 1'b1 } );
    assign aripr2_se = ( aripr1_se & { aripr1_se[29:0], 2'b11 } );
    assign aripr3_se = ( aripr2_se & { aripr2_se[27:0], 4'b1111 } );
    assign aripr4_se = ( aripr3_se & { aripr3_se[23:0], 8'b11111111 } );
    assign aripr5_se = ( aripr4_se & { aripr4_se[15:0], 16'b1111111111111111 } );
    assign arign1_se = ( arign0_se | ( aripr0_se & { arign0_se[30:0], 1'b0 } ) );
    assign arign2_se = ( arign1_se | ( aripr1_se & { arign1_se[29:0], 2'b00 } ) );
    assign arign3_se = ( arign2_se | ( aripr2_se & { arign2_se[27:0], 1'b0 } ) );
    assign arign4_se = ( arign3_se | ( aripr3_se & { arign3_se[23:0], 2'b00 } ) );
    assign arign5_se = ( arign4_se | ( aripr4_se & { arign4_se[15:0], 4'b0000 } ) );
    always @ (  arign5_se)
    begin
        if ( i_sub_se == 1'b1 ) 
        begin
            aricry_se <= ( arign5_se | aripr5_se );
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2935 
            begin
                aricry_se <= arign5_se;
            end
        end
    end
    assign aricyi_se = { aricry_se[30:0], i_sub_se };
    assign rarith_se = ( ( xarith_se ^ yarith_se ) ^ aricyi_se );
    assign overflw_se = ( aricry_se[31] ^ aricry_se[30] );
    assign x_cp_y_se = ( xoper_se ^ yoper_se );
    always 
    begin
        if ( x_cp_y_se == 8'b00000000 ) 
        begin
            x_eq_y_se <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2952 
            begin
                x_eq_y_se <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( ( rarith_se[31] ^ overflw_se ) == 1'b1 ) 
        begin
            x_lt_y_se <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2953 
            begin
                x_lt_y_se <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( aricry_se[31] == 1'b0 ) 
        begin
            x_ltu_y_se <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2954 
            begin
                x_ltu_y_se <= 1'b0;
            end
        end
    end
    always @ (  x_lt_y_se or  x_ltu_y_se or  x_eq_y_se)
    begin
        if ( i_lt_se == 1'b1 ) 
        begin
            testbit_se <= x_lt_y_se;
        end
        else
        begin 
            if ( i_ltu_se == 1'b1 ) 
            begin
                testbit_se <= x_ltu_y_se;
            end
            else
            begin 
                if ( i_ge_se == 1'b1 ) 
                begin
                    testbit_se <=  ~( x_lt_y_se);
                end
                else
                begin 
                    if ( i_geu_se == 1'b1 ) 
                    begin
                        testbit_se <=  ~( x_ltu_y_se);
                    end
                    else
                    begin 
                        if ( i_eq_se == 1'b1 ) 
                        begin
                            testbit_se <= x_eq_y_se;
                        end
                        else
                        begin 
                            if ( i_ne_se == 1'b1 ) 
                            begin
                                testbit_se <=  ~( x_eq_y_se);
                            end
                            else
                            begin 
                                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2960 
                                begin
                                    testbit_se <= 1'b0;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    assign rtest_se = { 7'b0000000, testbit_se };
    always @ (  opcod_rd)
    begin
        if ( ( ( opcod_rd == 9'b000000000 ) || ( opcod_rd == 9'b000000010 ) ) || ( opcod_rd == 9'b000000011 ) ) 
        begin
            xshf_se <= sham_rd;
        end
        else
        begin 
            xshf_se <= soper_se[4:0];
        end
    end
    assign yshf_se = toper_se;
    always 
    begin
        if ( ( i_osgnd_se & yshf_se[31] ) == 1'b0 ) 
        begin
            shsgn_se <= 1'b0;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2984 
            begin
                shsgn_se <= 32'b11111111111111111111111111111111;
            end
        end
    end
    always 
    begin
        if ( i_shr_se == 1'b0 ) 
        begin
            shf0_t_se <= { yshf_se[30:0], 1'b0 };
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2991 
            begin
                shf0_t_se <= { yshf_se[30:0], yshf_se[31] };
            end
        end
    end
    always 
    begin
        if ( i_shr_se == 1'b0 ) 
        begin
            shf1_t_se <= { shf0_se[29:0], 2'b00 };
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2994 
            begin
                shf1_t_se <= { shf0_se[29:0], shf0_se[31:30] };
            end
        end
    end
    always 
    begin
        if ( i_shr_se == 1'b0 ) 
        begin
            shf2_t_se <= { shf1_se[27:0], 1'b0 };
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:2997 
            begin
                shf2_t_se <= { shf1_se[27:0], shf1_se[31:28] };
            end
        end
    end
    always 
    begin
        if ( i_shr_se == 1'b0 ) 
        begin
            shf3_t_se <= { shf2_se[23:0], 2'b00 };
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3000 
            begin
                shf3_t_se <= { shf2_se[23:0], shf2_se[31:24] };
            end
        end
    end
    always 
    begin
        if ( i_shr_se == 1'b0 ) 
        begin
            shf4_t_se <= { shf3_se[15:0], 4'b0000 };
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3003 
            begin
                shf4_t_se <= { shf3_se[15:0], shf3_se[31:16] };
            end
        end
    end
    assign shf5_t_se = { shf4_se[30:0], shf4_se[31] };
    always @ (  yshf_se)
    begin
        if ( i_shr_se == 1'b1 ) 
        begin
            shf0_f_se <= { yshf_se[31:1], shsgn_se[0] };
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3009 
            begin
                shf0_f_se <= yshf_se;
            end
        end
    end
    always @ (  shf0_se)
    begin
        if ( i_shr_se == 1'b1 ) 
        begin
            shf1_f_se <= { shf0_se[31:3], shf0_se[0] };
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3012 
            begin
                shf1_f_se <= shf0_se;
            end
        end
    end
    always @ (  shf1_se)
    begin
        if ( i_shr_se == 1'b1 ) 
        begin
            shf2_f_se <= { shf1_se[31:7], shf1_se[2:0] };
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3016 
            begin
                shf2_f_se <= shf1_se;
            end
        end
    end
    always @ (  shf2_se)
    begin
        if ( i_shr_se == 1'b1 ) 
        begin
            shf3_f_se <= { shf2_se[31:15], shf2_se[6:0] };
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3020 
            begin
                shf3_f_se <= shf2_se;
            end
        end
    end
    always @ (  shf3_se)
    begin
        if ( i_shr_se == 1'b1 ) 
        begin
            shf4_f_se <= { shf3_se[31], shf3_se[14:0] };
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3024 
            begin
                shf4_f_se <= shf3_se;
            end
        end
    end
    assign shf5_f_se = shf4_se;
    always 
    begin
        if ( i_shr_se == 1'b0 ) 
        begin
            sham_se <= { 1'b0, xshf_se };
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3035 
            begin
                sham_se <= { 1'b1,  ~( xshf_se) };
            end
        end
    end
    always @ (  shf0_t_se or  shf0_f_se)
    begin
        if ( sham_se[0] == 1'b1 ) 
        begin
            shf0_se <= shf0_t_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3038 
            begin
                shf0_se <= shf0_f_se;
            end
        end
    end
    always @ (  shf1_t_se or  shf1_f_se)
    begin
        if ( sham_se[1] == 1'b1 ) 
        begin
            shf1_se <= shf1_t_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3039 
            begin
                shf1_se <= shf1_f_se;
            end
        end
    end
    always @ (  shf2_t_se or  shf2_f_se)
    begin
        if ( sham_se[2] == 1'b1 ) 
        begin
            shf2_se <= shf2_t_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3040 
            begin
                shf2_se <= shf2_f_se;
            end
        end
    end
    always @ (  shf3_t_se or  shf3_f_se)
    begin
        if ( sham_se[3] == 1'b1 ) 
        begin
            shf3_se <= shf3_t_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3041 
            begin
                shf3_se <= shf3_f_se;
            end
        end
    end
    always @ (  shf4_t_se or  shf4_f_se)
    begin
        if ( sham_se[4] == 1'b1 ) 
        begin
            shf4_se <= shf4_t_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3042 
            begin
                shf4_se <= shf4_f_se;
            end
        end
    end
    always @ (  shf5_t_se or  shf5_f_se)
    begin
        if ( sham_se[5] == 1'b1 ) 
        begin
            shf5_se <= shf5_t_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3043 
            begin
                shf5_se <= shf5_f_se;
            end
        end
    end
    assign rshift_se = shf5_se;
    always 
    begin
        if ( i_and_se == 1'b1 ) 
        begin
            rlogic_se <= ( xoper_se & yoper_se );
        end
        else
        begin 
            if ( i_nor_se == 1'b1 ) 
            begin
                rlogic_se <=  ~( ( xoper_se | yoper_se ));
            end
            else
            begin 
                if ( i_xor_se == 1'b1 ) 
                begin
                    rlogic_se <= ( xoper_se ^ yoper_se );
                end
                else
                begin 
                    if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3051 
                    begin
                        rlogic_se <= ( xoper_se | yoper_se );
                    end
                end
            end
        end
    end
    always @ (  soper_se or  toper_se or  ioper_se)
    begin
        if ( i_soper_se == 1'b1 ) 
        begin
            roper_se <= soper_se;
        end
        else
        begin 
            if ( i_toper_se == 1'b1 ) 
            begin
                roper_se <= toper_se;
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3060 
                begin
                    roper_se <= ioper_se;
                end
            end
        end
    end
    always @ (  rarith_se or  rlogic_se or  rshift_se or  rtest_se or  rclead_se or  roper_se)
    begin
        if ( i_arith_se == 1'b1 ) 
        begin
            res_se <= rarith_se;
        end
        else
        begin 
            if ( i_logic_se == 1'b1 ) 
            begin
                res_se <= rlogic_se;
            end
            else
            begin 
                if ( i_shift_se == 1'b1 ) 
                begin
                    res_se <= rshift_se;
                end
                else
                begin 
                    if ( i_test_se == 1'b1 ) 
                    begin
                        res_se <= rtest_se;
                    end
                    else
                    begin 
                        if ( i_clead_se == 1'b1 ) 
                        begin
                            res_se <= rclead_se;
                        end
                        else
                        begin 
                            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3068 
                            begin
                                res_se <= roper_se;
                            end
                        end
                    end
                end
            end
        end
    end
    assign xmxpp_se = ( i_osgnd_se & toper_se[31] );
    assign xmsgn_se = ( i_osgnd_se & soper_se[31] );
    assign ymsgn_se = ( i_osgnd_se & toper_se[31] );
    assign zminv_se = ( i_msub_se ^ ( i_osgnd_se & toper_se[31] ) );
    always 
    begin
        if ( xmsgn_se == 1'b0 ) 
        begin
            xmext_se <= 8'b00000000;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3215 
            begin
                xmext_se <= 32'b11111111111111111111111111111111;
            end
        end
    end
    assign xmul_se = soper_se;
    always @ (  toper_se)
    begin
        if ( ymsgn_se == 1'b0 ) 
        begin
            ymul_se <= toper_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3218 
            begin
                ymul_se <=  ~( toper_se);
            end
        end
    end
    assign xx00mul_se = { xmext_se, xmul_se };
    assign xx01mul_se = { xmext_se[30:0], 1'b0 };
    assign xx02mul_se = { xmext_se[29:0], 2'b00 };
    assign xx03mul_se = { xmext_se[28:0], 3'b000 };
    assign xx04mul_se = { xmext_se[27:0], 1'b0 };
    assign xx05mul_se = { xmext_se[26:0], 1'b0 };
    assign xx06mul_se = { xmext_se[25:0], 2'b00 };
    assign xx07mul_se = { xmext_se[24:0], 3'b000 };
    assign xx08mul_se = { xmext_se[23:0], 2'b00 };
    assign xx09mul_se = { xmext_se[22:0], 1'b0 };
    assign xx10mul_se = { xmext_se[21:0], 2'b00 };
    assign xx11mul_se = { xmext_se[20:0], 3'b000 };
    assign xx12mul_se = { xmext_se[19:0], 3'b000 };
    assign xx13mul_se = { xmext_se[18:0], 1'b0 };
    assign xx14mul_se = { xmext_se[17:0], 2'b00 };
    assign xx15mul_se = { xmext_se[16:0], 3'b000 };
    assign xx16mul_se = { xmext_se[15:0], 4'b0000 };
    assign xx17mul_se = { xmext_se[14:0], 1'b0 };
    assign xx18mul_se = { xmext_se[13:0], 2'b00 };
    assign xx19mul_se = { xmext_se[12:0], 3'b000 };
    assign xx20mul_se = { xmext_se[11:0], 5'b00000 };
    assign xx21mul_se = { xmext_se[10:0], 1'b0 };
    assign xx22mul_se = { xmext_se[9:0], 2'b00 };
    assign xx23mul_se = { xmext_se[8:0], 3'b000 };
    assign xx24mul_se = { xmext_se[7:0], 6'b000000 };
    assign xx25mul_se = { xmext_se[6:0], 1'b0 };
    assign xx26mul_se = { xmext_se[5:0], 2'b00 };
    assign xx27mul_se = { xmext_se[4:0], 3'b000 };
    assign xx28mul_se = { xmext_se[3:0], 7'b0000000 };
    assign xx29mul_se = { xmext_se[2:0], 1'b0 };
    assign xx30mul_se = { xmext_se[1:0], 2'b00 };
    assign xx31mul_se = { xmext_se[0], 3'b000 };
    always @ (  xx00mul_se)
    begin
        if ( ymul_se[0] == 1'b1 ) 
        begin
            pp00mul_se <= xx00mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3263 
            begin
                pp00mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx01mul_se)
    begin
        if ( ymul_se[1] == 1'b1 ) 
        begin
            pp01mul_se <= xx01mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3264 
            begin
                pp01mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx02mul_se)
    begin
        if ( ymul_se[2] == 1'b1 ) 
        begin
            pp02mul_se <= xx02mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3265 
            begin
                pp02mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx03mul_se)
    begin
        if ( ymul_se[3] == 1'b1 ) 
        begin
            pp03mul_se <= xx03mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3266 
            begin
                pp03mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx04mul_se)
    begin
        if ( ymul_se[4] == 1'b1 ) 
        begin
            pp04mul_se <= xx04mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3267 
            begin
                pp04mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx05mul_se)
    begin
        if ( ymul_se[5] == 1'b1 ) 
        begin
            pp05mul_se <= xx05mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3268 
            begin
                pp05mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx06mul_se)
    begin
        if ( ymul_se[6] == 1'b1 ) 
        begin
            pp06mul_se <= xx06mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3269 
            begin
                pp06mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx07mul_se)
    begin
        if ( ymul_se[7] == 1'b1 ) 
        begin
            pp07mul_se <= xx07mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3270 
            begin
                pp07mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx08mul_se)
    begin
        if ( ymul_se[8] == 1'b1 ) 
        begin
            pp08mul_se <= xx08mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3271 
            begin
                pp08mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx09mul_se)
    begin
        if ( ymul_se[9] == 1'b1 ) 
        begin
            pp09mul_se <= xx09mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3272 
            begin
                pp09mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx10mul_se)
    begin
        if ( ymul_se[10] == 1'b1 ) 
        begin
            pp10mul_se <= xx10mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3273 
            begin
                pp10mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx11mul_se)
    begin
        if ( ymul_se[11] == 1'b1 ) 
        begin
            pp11mul_se <= xx11mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3274 
            begin
                pp11mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx12mul_se)
    begin
        if ( ymul_se[12] == 1'b1 ) 
        begin
            pp12mul_se <= xx12mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3275 
            begin
                pp12mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx13mul_se)
    begin
        if ( ymul_se[13] == 1'b1 ) 
        begin
            pp13mul_se <= xx13mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3276 
            begin
                pp13mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx14mul_se)
    begin
        if ( ymul_se[14] == 1'b1 ) 
        begin
            pp14mul_se <= xx14mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3277 
            begin
                pp14mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx15mul_se)
    begin
        if ( ymul_se[15] == 1'b1 ) 
        begin
            pp15mul_se <= xx15mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3278 
            begin
                pp15mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx16mul_se)
    begin
        if ( ymul_se[16] == 1'b1 ) 
        begin
            pp16mul_se <= xx16mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3279 
            begin
                pp16mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx17mul_se)
    begin
        if ( ymul_se[17] == 1'b1 ) 
        begin
            pp17mul_se <= xx17mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3280 
            begin
                pp17mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx18mul_se)
    begin
        if ( ymul_se[18] == 1'b1 ) 
        begin
            pp18mul_se <= xx18mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3281 
            begin
                pp18mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx19mul_se)
    begin
        if ( ymul_se[19] == 1'b1 ) 
        begin
            pp19mul_se <= xx19mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3282 
            begin
                pp19mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx20mul_se)
    begin
        if ( ymul_se[20] == 1'b1 ) 
        begin
            pp20mul_se <= xx20mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3283 
            begin
                pp20mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx21mul_se)
    begin
        if ( ymul_se[21] == 1'b1 ) 
        begin
            pp21mul_se <= xx21mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3284 
            begin
                pp21mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx22mul_se)
    begin
        if ( ymul_se[22] == 1'b1 ) 
        begin
            pp22mul_se <= xx22mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3285 
            begin
                pp22mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx23mul_se)
    begin
        if ( ymul_se[23] == 1'b1 ) 
        begin
            pp23mul_se <= xx23mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3286 
            begin
                pp23mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx24mul_se)
    begin
        if ( ymul_se[24] == 1'b1 ) 
        begin
            pp24mul_se <= xx24mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3287 
            begin
                pp24mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx25mul_se)
    begin
        if ( ymul_se[25] == 1'b1 ) 
        begin
            pp25mul_se <= xx25mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3288 
            begin
                pp25mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx26mul_se)
    begin
        if ( ymul_se[26] == 1'b1 ) 
        begin
            pp26mul_se <= xx26mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3289 
            begin
                pp26mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx27mul_se)
    begin
        if ( ymul_se[27] == 1'b1 ) 
        begin
            pp27mul_se <= xx27mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3290 
            begin
                pp27mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx28mul_se)
    begin
        if ( ymul_se[28] == 1'b1 ) 
        begin
            pp28mul_se <= xx28mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3291 
            begin
                pp28mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx29mul_se)
    begin
        if ( ymul_se[29] == 1'b1 ) 
        begin
            pp29mul_se <= xx29mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3292 
            begin
                pp29mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx30mul_se)
    begin
        if ( ymul_se[30] == 1'b1 ) 
        begin
            pp30mul_se <= xx30mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3293 
            begin
                pp30mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx31mul_se)
    begin
        if ( ymul_se[31] == 1'b1 ) 
        begin
            pp31mul_se <= xx31mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3294 
            begin
                pp31mul_se <= 1'b0;
            end
        end
    end
    always @ (  xx00mul_se)
    begin
        if ( xmxpp_se == 1'b1 ) 
        begin
            ppxxmul_se <= xx00mul_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3301 
            begin
                ppxxmul_se <= 1'b0;
            end
        end
    end
    assign s00mul0_se = ( ( pp00mul_se ^ pp01mul_se ) ^ pp02mul_se );
    assign s01mul0_se = ( ( pp04mul_se ^ pp05mul_se ) ^ pp06mul_se );
    assign s02mul0_se = ( ( pp08mul_se ^ pp09mul_se ) ^ pp10mul_se );
    assign s03mul0_se = ( ( pp12mul_se ^ pp13mul_se ) ^ pp14mul_se );
    assign s04mul0_se = ( ( pp16mul_se ^ pp17mul_se ) ^ pp18mul_se );
    assign s05mul0_se = ( ( pp20mul_se ^ pp21mul_se ) ^ pp22mul_se );
    assign s06mul0_se = ( ( pp24mul_se ^ pp25mul_se ) ^ pp26mul_se );
    assign s07mul0_se = ( ( pp28mul_se ^ pp29mul_se ) ^ pp30mul_se );
    assign c00mul0_se = { ( ( ( pp00mul_se[62:0] & pp01mul_se[62:0] ) | ( pp00mul_se[62:0] & pp02mul_se[62:0] ) ) | ( pp01mul_se[62:0] & pp02mul_se[62:0] ) ), 1'b0 };
    assign c01mul0_se = { ( ( ( pp04mul_se[62:0] & pp05mul_se[62:0] ) | ( pp04mul_se[62:0] & pp06mul_se[62:0] ) ) | ( pp05mul_se[62:0] & pp06mul_se[62:0] ) ), 1'b0 };
    assign c02mul0_se = { ( ( ( pp08mul_se[62:0] & pp09mul_se[62:0] ) | ( pp08mul_se[62:0] & pp10mul_se[62:0] ) ) | ( pp09mul_se[62:0] & pp10mul_se[62:0] ) ), 1'b0 };
    assign c03mul0_se = { ( ( ( pp12mul_se[62:0] & pp13mul_se[62:0] ) | ( pp12mul_se[62:0] & pp14mul_se[62:0] ) ) | ( pp13mul_se[62:0] & pp14mul_se[62:0] ) ), 1'b0 };
    assign c04mul0_se = { ( ( ( pp16mul_se[62:0] & pp17mul_se[62:0] ) | ( pp16mul_se[62:0] & pp18mul_se[62:0] ) ) | ( pp17mul_se[62:0] & pp18mul_se[62:0] ) ), 1'b0 };
    assign c05mul0_se = { ( ( ( pp20mul_se[62:0] & pp21mul_se[62:0] ) | ( pp20mul_se[62:0] & pp22mul_se[62:0] ) ) | ( pp21mul_se[62:0] & pp22mul_se[62:0] ) ), 1'b0 };
    assign c06mul0_se = { ( ( ( pp24mul_se[62:0] & pp25mul_se[62:0] ) | ( pp24mul_se[62:0] & pp26mul_se[62:0] ) ) | ( pp25mul_se[62:0] & pp26mul_se[62:0] ) ), 1'b0 };
    assign c07mul0_se = { ( ( ( pp28mul_se[62:0] & pp29mul_se[62:0] ) | ( pp28mul_se[62:0] & pp30mul_se[62:0] ) ) | ( pp29mul_se[62:0] & pp30mul_se[62:0] ) ), 1'b0 };
    assign s00mul1_se = ( ( s00mul0_se ^ c00mul0_se ) ^ pp03mul_se );
    assign s01mul1_se = ( ( s01mul0_se ^ c01mul0_se ) ^ pp07mul_se );
    assign s02mul1_se = ( ( s02mul0_se ^ c02mul0_se ) ^ pp11mul_se );
    assign s03mul1_se = ( ( s03mul0_se ^ c03mul0_se ) ^ pp15mul_se );
    assign s04mul1_se = ( ( s04mul0_se ^ c04mul0_se ) ^ pp19mul_se );
    assign s05mul1_se = ( ( s05mul0_se ^ c05mul0_se ) ^ pp23mul_se );
    assign s06mul1_se = ( ( s06mul0_se ^ c06mul0_se ) ^ pp27mul_se );
    assign s07mul1_se = ( ( s07mul0_se ^ c07mul0_se ) ^ pp31mul_se );
    assign c00mul1_se = { ( ( ( s00mul0_se[62:0] & c00mul0_se[62:0] ) | ( s00mul0_se[62:0] & pp03mul_se[62:0] ) ) | ( c00mul0_se[62:0] & pp03mul_se[62:0] ) ), 1'b0 };
    assign c01mul1_se = { ( ( ( s01mul0_se[62:0] & c01mul0_se[62:0] ) | ( s01mul0_se[62:0] & pp07mul_se[62:0] ) ) | ( c01mul0_se[62:0] & pp07mul_se[62:0] ) ), 1'b0 };
    assign c02mul1_se = { ( ( ( s02mul0_se[62:0] & c02mul0_se[62:0] ) | ( s02mul0_se[62:0] & pp11mul_se[62:0] ) ) | ( c02mul0_se[62:0] & pp11mul_se[62:0] ) ), 1'b0 };
    assign c03mul1_se = { ( ( ( s03mul0_se[62:0] & c03mul0_se[62:0] ) | ( s03mul0_se[62:0] & pp15mul_se[62:0] ) ) | ( c03mul0_se[62:0] & pp15mul_se[62:0] ) ), 1'b0 };
    assign c04mul1_se = { ( ( ( s04mul0_se[62:0] & c04mul0_se[62:0] ) | ( s04mul0_se[62:0] & pp19mul_se[62:0] ) ) | ( c04mul0_se[62:0] & pp19mul_se[62:0] ) ), 1'b0 };
    assign c05mul1_se = { ( ( ( s05mul0_se[62:0] & c05mul0_se[62:0] ) | ( s05mul0_se[62:0] & pp23mul_se[62:0] ) ) | ( c05mul0_se[62:0] & pp23mul_se[62:0] ) ), 1'b0 };
    assign c06mul1_se = { ( ( ( s06mul0_se[62:0] & c06mul0_se[62:0] ) | ( s06mul0_se[62:0] & pp27mul_se[62:0] ) ) | ( c06mul0_se[62:0] & pp27mul_se[62:0] ) ), 1'b0 };
    assign c07mul1_se = { ( ( ( s07mul0_se[62:0] & c07mul0_se[62:0] ) | ( s07mul0_se[62:0] & pp31mul_se[62:0] ) ) | ( c07mul0_se[62:0] & pp31mul_se[62:0] ) ), 1'b0 };
    assign s00mul2_se = ( ( s00mul1_se ^ c00mul1_se ) ^ ppxxmul_se );
    assign s01mul2_se = ( ( s01mul1_se ^ c01mul1_se ) ^ s02mul1_se );
    assign s02mul2_se = ( ( s03mul1_se ^ c03mul1_se ) ^ c02mul1_se );
    assign s03mul2_se = ( ( s04mul1_se ^ c04mul1_se ) ^ s05mul1_se );
    assign s04mul2_se = ( ( s06mul1_se ^ c06mul1_se ) ^ s07mul1_se );
    assign c00mul2_se = { ( ( ( s00mul1_se[62:0] & c00mul1_se[62:0] ) | ( s00mul1_se[62:0] & ppxxmul_se[62:0] ) ) | ( c00mul1_se[62:0] & ppxxmul_se[62:0] ) ), 1'b0 };
    assign c01mul2_se = { ( ( ( s01mul1_se[62:0] & c01mul1_se[62:0] ) | ( s01mul1_se[62:0] & s02mul1_se[62:0] ) ) | ( c01mul1_se[62:0] & s02mul1_se[62:0] ) ), 1'b0 };
    assign c02mul2_se = { ( ( ( s03mul1_se[62:0] & c03mul1_se[62:0] ) | ( s03mul1_se[62:0] & c02mul1_se[62:0] ) ) | ( c03mul1_se[62:0] & c02mul1_se[62:0] ) ), 1'b0 };
    assign c03mul2_se = { ( ( ( s04mul1_se[62:0] & c04mul1_se[62:0] ) | ( s04mul1_se[62:0] & s05mul1_se[62:0] ) ) | ( c04mul1_se[62:0] & s05mul1_se[62:0] ) ), 1'b0 };
    assign c04mul2_se = { ( ( ( s06mul1_se[62:0] & c06mul1_se[62:0] ) | ( s06mul1_se[62:0] & s07mul1_se[62:0] ) ) | ( c06mul1_se[62:0] & s07mul1_se[62:0] ) ), 1'b0 };
    assign zmopr_sm = { hi_rw, lo_rw };
    always @ (  zmopr_sm)
    begin
        if ( i_mult_sm == 1'b0 ) 
        begin
            zmul_sm <= zmopr_sm;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3463 
            begin
                zmul_sm <= 1'b0;
            end
        end
    end
    always @ (  zmul_sm)
    begin
        if ( zminv_re == 1'b0 ) 
        begin
            ppzzmul_sm <= zmul_sm;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3464 
            begin
                ppzzmul_sm <=  ~( zmul_sm);
            end
        end
    end
    assign c05mul1_sm = c05mul1_re;
    assign c07mul1_sm = c07mul1_re;
    assign s00mul2_sm = s00mul2_re;
    assign s01mul2_sm = s01mul2_re;
    assign s02mul2_sm = s02mul2_re;
    assign s03mul2_sm = s03mul2_re;
    assign s04mul2_sm = s04mul2_re;
    assign c00mul2_sm = c00mul2_re;
    assign c01mul2_sm = c01mul2_re;
    assign c02mul2_sm = c02mul2_re;
    assign c03mul2_sm = c03mul2_re;
    assign c04mul2_sm = c04mul2_re;
    assign s00mul3_sm = ( ( s00mul2_sm ^ c00mul2_sm ) ^ s01mul2_sm );
    assign s01mul3_sm = ( ( s02mul2_sm ^ c02mul2_sm ) ^ c01mul2_sm );
    assign s02mul3_sm = ( ( s03mul2_sm ^ c03mul2_sm ) ^ c05mul1_sm );
    assign s03mul3_sm = ( ( s04mul2_sm ^ c04mul2_sm ) ^ c07mul1_sm );
    assign c00mul3_sm = { ( ( ( s00mul2_sm[62:0] & c00mul2_sm[62:0] ) | ( s00mul2_sm[62:0] & s01mul2_sm[62:0] ) ) | ( c00mul2_sm[62:0] & s01mul2_sm[62:0] ) ), 1'b0 };
    assign c01mul3_sm = { ( ( ( s02mul2_sm[62:0] & c02mul2_sm[62:0] ) | ( s02mul2_sm[62:0] & c01mul2_sm[62:0] ) ) | ( c02mul2_sm[62:0] & c01mul2_sm[62:0] ) ), 1'b0 };
    assign c02mul3_sm = { ( ( ( s03mul2_sm[62:0] & c03mul2_sm[62:0] ) | ( s03mul2_sm[62:0] & c05mul1_sm[62:0] ) ) | ( c03mul2_sm[62:0] & c05mul1_sm[62:0] ) ), 1'b0 };
    assign c03mul3_sm = { ( ( ( s04mul2_sm[62:0] & c04mul2_sm[62:0] ) | ( s04mul2_sm[62:0] & c07mul1_sm[62:0] ) ) | ( c04mul2_sm[62:0] & c07mul1_sm[62:0] ) ), 1'b0 };
    assign s00mul4_sm = ( ( s00mul3_sm ^ c00mul3_sm ) ^ ppzzmul_sm );
    assign s01mul4_sm = ( ( s01mul3_sm ^ c01mul3_sm ) ^ s02mul3_sm );
    assign s02mul4_sm = ( ( s03mul3_sm ^ c03mul3_sm ) ^ c02mul3_sm );
    assign c00mul4_sm = { ( ( ( s00mul3_sm[62:0] & c00mul3_sm[62:0] ) | ( s00mul3_sm[62:0] & ppzzmul_sm[62:0] ) ) | ( c00mul3_sm[62:0] & ppzzmul_sm[62:0] ) ), 1'b0 };
    assign c01mul4_sm = { ( ( ( s01mul3_sm[62:0] & c01mul3_sm[62:0] ) | ( s01mul3_sm[62:0] & s02mul3_sm[62:0] ) ) | ( c01mul3_sm[62:0] & s02mul3_sm[62:0] ) ), 1'b0 };
    assign c02mul4_sm = { ( ( ( s03mul3_sm[62:0] & c03mul3_sm[62:0] ) | ( s03mul3_sm[62:0] & c02mul3_sm[62:0] ) ) | ( c03mul3_sm[62:0] & c02mul3_sm[62:0] ) ), 1'b0 };
    assign s00mul5_sm = ( ( s00mul4_sm ^ c00mul4_sm ) ^ s01mul4_sm );
    assign s01mul5_sm = ( ( s02mul4_sm ^ c02mul4_sm ) ^ c01mul4_sm );
    assign c00mul5_sm = { ( ( ( s00mul4_sm[62:0] & c00mul4_sm[62:0] ) | ( s00mul4_sm[62:0] & s01mul4_sm[62:0] ) ) | ( c00mul4_sm[62:0] & s01mul4_sm[62:0] ) ), 1'b0 };
    assign c01mul5_sm = { ( ( ( s02mul4_sm[62:0] & c02mul4_sm[62:0] ) | ( s02mul4_sm[62:0] & c01mul4_sm[62:0] ) ) | ( c02mul4_sm[62:0] & c01mul4_sm[62:0] ) ), 1'b0 };
    assign s00mul6_sm = ( ( s00mul5_sm ^ c00mul5_sm ) ^ s01mul5_sm );
    assign c00mul6_sm = { ( ( ( s00mul5_sm[62:0] & c00mul5_sm[62:0] ) | ( s00mul5_sm[62:0] & s01mul5_sm[62:0] ) ) | ( c00mul5_sm[62:0] & s01mul5_sm[62:0] ) ), 1'b0 };
    assign s00mul7_sm = ( ( s00mul6_sm ^ c00mul6_sm ) ^ c01mul5_sm );
    assign c00mul7_sm = { ( ( ( s00mul6_sm[62:0] & c00mul6_sm[62:0] ) | ( s00mul6_sm[62:0] & c01mul5_sm[62:0] ) ) | ( c00mul6_sm[62:0] & c01mul5_sm[62:0] ) ), 1'b0 };
    assign s00mul7_sw = s00mul7_rm;
    assign c00mul7_sw = c00mul7_rm;
    assign mulpr0_sw = ( s00mul7_sw | c00mul7_sw );
    assign mulgn0_sw = ( s00mul7_sw & c00mul7_sw );
    assign mulpr1_sw = ( mulpr0_sw & { mulpr0_sw[62:0], 1'b1 } );
    assign mulpr2_sw = ( mulpr1_sw & { mulpr1_sw[61:0], 2'b11 } );
    assign mulpr3_sw = ( mulpr2_sw & { mulpr2_sw[59:0], 4'b1111 } );
    assign mulpr4_sw = ( mulpr3_sw & { mulpr3_sw[55:0], 8'b11111111 } );
    assign mulpr5_sw = ( mulpr4_sw & { mulpr4_sw[47:0], 16'b1111111111111111 } );
    assign mulpr6_sw = ( mulpr5_sw & { mulpr5_sw[31:0], 32'b11111111111111111111111111111111 } );
    assign mulgn1_sw = ( mulgn0_sw | ( mulpr0_sw & { mulgn0_sw[62:0], 1'b0 } ) );
    assign mulgn2_sw = ( mulgn1_sw | ( mulpr1_sw & { mulgn1_sw[61:0], 2'b00 } ) );
    assign mulgn3_sw = ( mulgn2_sw | ( mulpr2_sw & { mulgn2_sw[59:0], 1'b0 } ) );
    assign mulgn4_sw = ( mulgn3_sw | ( mulpr3_sw & { mulgn3_sw[55:0], 2'b00 } ) );
    assign mulgn5_sw = ( mulgn4_sw | ( mulpr4_sw & { mulgn4_sw[47:0], 4'b0000 } ) );
    assign mulgn6_sw = ( mulgn5_sw | ( mulpr5_sw & { mulgn5_sw[31:0], 1'b0 } ) );
    assign mulcry_sw = mulgn6_sw;
    assign mulcyi_sw = { mulcry_sw[62:0], 1'b0 };
    assign mulsum_sw = ( ( mulcyi_sw ^ s00mul7_sw ) ^ c00mul7_sw );
    always @ (  mulsum_sw)
    begin
        if ( zminv_rm == 1'b0 ) 
        begin
            rmul_sw <= mulsum_sw;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3654 
            begin
                rmul_sw <=  ~( mulsum_sw);
            end
        end
    end
    assign micbeg_se = ( i_cisc_se & micend_re );
    assign miccopy_se = ( i_cisc_se &  ~( miclst_re) );
    assign xdiv_se = soper_se;
    assign ydiv_se = toper_se;
    always @ (  i_mic_se)
    begin
        if ( micbeg_se == 1'b1 ) 
        begin
            nextmic_se <= i_mic_se;
        end
        else
        begin 
            if ( mic_re == 3'b001 ) 
            begin
                nextmic_se <= 3'b010;
            end
            else
            begin 
                if ( ( mic_re == 3'b010 ) & ( divscnt_se[5] == 1'b0 ) ) 
                begin
                    nextmic_se <= 3'b011;
                end
                else
                begin 
                    if ( ( mic_re == 3'b010 ) & ( divscnt_se[5] == 1'b1 ) ) 
                    begin
                        nextmic_se <= 3'b101;
                    end
                    else
                    begin 
                        if ( mic_re == 3'b011 ) 
                        begin
                            nextmic_se <= 3'b100;
                        end
                        else
                        begin 
                            if ( ( mic_re == 3'b100 ) & ( divscnz_se == 1'b0 ) ) 
                            begin
                                nextmic_se <= 3'b100;
                            end
                            else
                            begin 
                                if ( ( mic_re == 3'b100 ) & ( divscnz_se == 1'b1 ) ) 
                                begin
                                    nextmic_se <= 3'b101;
                                end
                                else
                                begin 
                                    if ( mic_re == 3'b101 ) 
                                    begin
                                        nextmic_se <= 3'b000;
                                    end
                                    else
                                    begin 
                                        if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3671 
                                        begin
                                            nextmic_se <= 3'b000;
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    always 
    begin
        if ( nextmic_se == 3'b000 ) 
        begin
            micend_se <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3685 
            begin
                micend_se <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( nextmic_se == 3'b101 ) 
        begin
            miclst_se <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3686 
            begin
                miclst_se <= 1'b0;
            end
        end
    end
    always @ (  xdiv_se or  divx_re)
    begin
        if ( micbeg_se == 1'b1 ) 
        begin
            divrx_se <= xdiv_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3691 
            begin
                divrx_se <= divx_re;
            end
        end
    end
    always @ (  ydiv_se or  divq_re)
    begin
        if ( micbeg_se == 1'b1 ) 
        begin
            divqy_se <= ydiv_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3694 
            begin
                divqy_se <= divq_re;
            end
        end
    end
    always @ (  divxeff_se or  divx_re or  divx_re or  divx_re or  divx_re or  divdif_se or  divreff_se or  divx_re)
    begin
        if ( micbeg_se == 1'b1 ) 
        begin
            divx_se <= divxeff_se;
        end
        else
        begin 
            if ( mic_re == 3'b001 ) 
            begin
                divx_se <= divx_re;
            end
            else
            begin 
                if ( mic_re == 3'b010 ) 
                begin
                    divx_se <= divx_re;
                end
                else
                begin 
                    if ( mic_re == 3'b011 ) 
                    begin
                        divx_se <= divx_re;
                    end
                    else
                    begin 
                        if ( ( mic_re == 3'b100 ) & ( divleu_se == 1'b0 ) ) 
                        begin
                            divx_se <= divx_re;
                        end
                        else
                        begin 
                            if ( ( mic_re == 3'b100 ) & ( divleu_se == 1'b1 ) ) 
                            begin
                                divx_se <= divdif_se;
                            end
                            else
                            begin 
                                if ( mic_re == 3'b101 ) 
                                begin
                                    divx_se <= divreff_se;
                                end
                                else
                                begin 
                                    if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3697 
                                    begin
                                        divx_se <= divx_re;
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    always @ (  divyeff_se or  divy_re or  divy_re or  divyshl_se or  divyshr_se or  divy_re)
    begin
        if ( micbeg_se == 1'b1 ) 
        begin
            divy_se <= divyeff_se;
        end
        else
        begin 
            if ( mic_re == 3'b001 ) 
            begin
                divy_se <= divy_re;
            end
            else
            begin 
                if ( mic_re == 3'b010 ) 
                begin
                    divy_se <= divy_re;
                end
                else
                begin 
                    if ( mic_re == 3'b011 ) 
                    begin
                        divy_se <= divyshl_se;
                    end
                    else
                    begin 
                        if ( mic_re == 3'b100 ) 
                        begin
                            divy_se <= divyshr_se;
                        end
                        else
                        begin 
                            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3706 
                            begin
                                divy_se <= divy_re;
                            end
                        end
                    end
                end
            end
        end
    end
    always @ (  divq_re or  divq_re or  divq_re or  divqshl_se or  divqeff_se or  divq_re)
    begin
        if ( micbeg_se == 1'b1 ) 
        begin
            divq_se <= 1'b0;
        end
        else
        begin 
            if ( mic_re == 3'b001 ) 
            begin
                divq_se <= divq_re;
            end
            else
            begin 
                if ( mic_re == 3'b010 ) 
                begin
                    divq_se <= divq_re;
                end
                else
                begin 
                    if ( mic_re == 3'b011 ) 
                    begin
                        divq_se <= divq_re;
                    end
                    else
                    begin 
                        if ( mic_re == 3'b100 ) 
                        begin
                            divq_se <= divqshl_se;
                        end
                        else
                        begin 
                            if ( mic_re == 3'b101 ) 
                            begin
                                divq_se <= divqeff_se;
                            end
                            else
                            begin 
                                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3713 
                                begin
                                    divq_se <= divq_re;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    always @ (  divxclz_re or  divxcz_se or  divxclz_re)
    begin
        if ( micbeg_se == 1'b1 ) 
        begin
            divxclz_se <= divxclz_re;
        end
        else
        begin 
            if ( mic_re == 3'b001 ) 
            begin
                divxclz_se <= divxcz_se;
            end
            else
            begin 
                if ( mic_re == 3'b010 ) 
                begin
                    divxclz_se <= 6'b000001;
                end
                else
                begin 
                    if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3721 
                    begin
                        divxclz_se <= divxclz_re;
                    end
                end
            end
        end
    end
    always @ (  divyclz_re or  divycz_se or  divscnt_se or  divscnt_se or  divyclz_re)
    begin
        if ( micbeg_se == 1'b1 ) 
        begin
            divyclz_se <= divyclz_re;
        end
        else
        begin 
            if ( mic_re == 3'b001 ) 
            begin
                divyclz_se <= divycz_se;
            end
            else
            begin 
                if ( mic_re == 3'b010 ) 
                begin
                    divyclz_se <= divscnt_se;
                end
                else
                begin 
                    if ( mic_re == 3'b100 ) 
                    begin
                        divyclz_se <= divscnt_se;
                    end
                    else
                    begin 
                        if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3726 
                        begin
                            divyclz_se <= divyclz_re;
                        end
                    end
                end
            end
        end
    end
    assign divrpr0_se =  ~( divrx_se);
    assign divrpr1_se = ( divrpr0_se & { divrpr0_se[30:0], 1'b1 } );
    assign divrpr2_se = ( divrpr1_se & { divrpr1_se[29:0], 2'b11 } );
    assign divrpr3_se = ( divrpr2_se & { divrpr2_se[27:0], 4'b1111 } );
    assign divrpr4_se = ( divrpr3_se & { divrpr3_se[23:0], 8'b11111111 } );
    assign divrpr5_se = ( divrpr4_se & { divrpr4_se[15:0], 16'b1111111111111111 } );
    assign divrcry_se = divrpr5_se;
    assign divrcyi_se = { divrcry_se[30:0], 1'b1 };
    assign divrneg_se = (  ~( divrx_se) ^ divrcyi_se );
    assign divqpr0_se =  ~( divqy_se);
    assign divqpr1_se = ( divqpr0_se & { divqpr0_se[30:0], 1'b1 } );
    assign divqpr2_se = ( divqpr1_se & { divqpr1_se[29:0], 2'b11 } );
    assign divqpr3_se = ( divqpr2_se & { divqpr2_se[27:0], 4'b1111 } );
    assign divqpr4_se = ( divqpr3_se & { divqpr3_se[23:0], 8'b11111111 } );
    assign divqpr5_se = ( divqpr4_se & { divqpr4_se[15:0], 16'b1111111111111111 } );
    assign divqcry_se = divqpr5_se;
    assign divqcyi_se = { divqcry_se[30:0], 1'b1 };
    assign divqneg_se = (  ~( divqy_se) ^ divqcyi_se );
    assign divxsgn_se = xdiv_se[31];
    assign divysgn_se = ydiv_se[31];
    assign divqsgn_se = ( xdiv_se[31] ^ ydiv_se[31] );
    always @ (  divrneg_se or  xdiv_se)
    begin
        if ( ( i_osgnd_se == 1'b1 ) & ( divxsgn_se == 1'b1 ) ) 
        begin
            divxeff_se <= divrneg_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3786 
            begin
                divxeff_se <= xdiv_se;
            end
        end
    end
    always @ (  divqneg_se or  ydiv_se)
    begin
        if ( ( i_osgnd_se == 1'b1 ) & ( divysgn_se == 1'b1 ) ) 
        begin
            divyeff_se <= divqneg_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3788 
            begin
                divyeff_se <= ydiv_se;
            end
        end
    end
    always @ (  divrneg_se or  divrx_se)
    begin
        if ( ( i_osgnd_se == 1'b1 ) & ( divxsgn_se == 1'b1 ) ) 
        begin
            divreff_se <= divrneg_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3791 
            begin
                divreff_se <= divrx_se;
            end
        end
    end
    always @ (  divqneg_se or  divq_re)
    begin
        if ( ( i_osgnd_se == 1'b1 ) & ( divqsgn_se == 1'b1 ) ) 
        begin
            divqeff_se <= divqneg_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3793 
            begin
                divqeff_se <= divq_re;
            end
        end
    end
    assign divyzp1_se = (  ~( divy_re) & { 1'b1,  ~( divy_re[31:1]) } );
    assign divyzp2_se = ( divyzp1_se & { 2'b11, divyzp1_se[31:2] } );
    assign divyzp3_se = ( divyzp2_se & { 4'b1111, divyzp2_se[31:4] } );
    assign divyzp4_se = ( divyzp3_se & { 8'b11111111, divyzp3_se[31:8] } );
    assign divyzp5_se = ( divyzp4_se & { 16'b1111111111111111, divyzp4_se[31:16] } );
    assign divyzmk_se = ( divy_re & { 1'b1, divyzp5_se[31:1] } );
    assign divycz5_se = divyzp5_se[0];
    assign divycz4_se = ( ( ( ( ( ( ( ( ( ( ( ( ( ( ( divyzmk_se[15] | divyzmk_se[14] ) | divyzmk_se[13] ) | divyzmk_se[12] ) | divyzmk_se[11] ) | divyzmk_se[10] ) | divyzmk_se[9] ) | divyzmk_se[8] ) | divyzmk_se[7] ) | divyzmk_se[6] ) | divyzmk_se[5] ) | divyzmk_se[4] ) | divyzmk_se[3] ) | divyzmk_se[2] ) | divyzmk_se[1] ) | divyzmk_se[0] );
    assign divycz3_se = ( ( ( ( ( ( ( ( ( ( ( ( ( ( ( divyzmk_se[23] | divyzmk_se[22] ) | divyzmk_se[21] ) | divyzmk_se[20] ) | divyzmk_se[19] ) | divyzmk_se[18] ) | divyzmk_se[17] ) | divyzmk_se[16] ) | divyzmk_se[7] ) | divyzmk_se[6] ) | divyzmk_se[5] ) | divyzmk_se[4] ) | divyzmk_se[3] ) | divyzmk_se[2] ) | divyzmk_se[1] ) | divyzmk_se[0] );
    assign divycz2_se = ( ( ( ( ( ( ( ( ( ( ( ( ( ( ( divyzmk_se[27] | divyzmk_se[26] ) | divyzmk_se[25] ) | divyzmk_se[24] ) | divyzmk_se[19] ) | divyzmk_se[18] ) | divyzmk_se[17] ) | divyzmk_se[16] ) | divyzmk_se[11] ) | divyzmk_se[10] ) | divyzmk_se[9] ) | divyzmk_se[8] ) | divyzmk_se[3] ) | divyzmk_se[2] ) | divyzmk_se[1] ) | divyzmk_se[0] );
    assign divycz1_se = ( ( ( ( ( ( ( ( ( ( ( ( ( ( ( divyzmk_se[29] | divyzmk_se[28] ) | divyzmk_se[25] ) | divyzmk_se[24] ) | divyzmk_se[21] ) | divyzmk_se[20] ) | divyzmk_se[17] ) | divyzmk_se[16] ) | divyzmk_se[13] ) | divyzmk_se[12] ) | divyzmk_se[9] ) | divyzmk_se[8] ) | divyzmk_se[5] ) | divyzmk_se[4] ) | divyzmk_se[1] ) | divyzmk_se[0] );
    assign divycz0_se = ( ( ( ( ( ( ( ( ( ( ( ( ( ( ( divyzmk_se[30] | divyzmk_se[28] ) | divyzmk_se[26] ) | divyzmk_se[24] ) | divyzmk_se[22] ) | divyzmk_se[20] ) | divyzmk_se[18] ) | divyzmk_se[16] ) | divyzmk_se[14] ) | divyzmk_se[12] ) | divyzmk_se[10] ) | divyzmk_se[8] ) | divyzmk_se[6] ) | divyzmk_se[4] ) | divyzmk_se[2] ) | divyzmk_se[0] );
    assign divycz_se = { divycz5_se, divycz0_se };
    assign divxzp1_se = (  ~( divx_re) & { 1'b1,  ~( divx_re[31:1]) } );
    assign divxzp2_se = ( divxzp1_se & { 2'b11, divxzp1_se[31:2] } );
    assign divxzp3_se = ( divxzp2_se & { 4'b1111, divxzp2_se[31:4] } );
    assign divxzp4_se = ( divxzp3_se & { 8'b11111111, divxzp3_se[31:8] } );
    assign divxzp5_se = ( divxzp4_se & { 16'b1111111111111111, divxzp4_se[31:16] } );
    assign divxzmk_se = ( divx_re & { 1'b1, divxzp5_se[31:1] } );
    assign divxcz5_se = divxzp5_se[0];
    assign divxcz4_se = ( ( ( ( ( ( ( ( ( ( ( ( ( ( ( divxzmk_se[15] | divxzmk_se[14] ) | divxzmk_se[13] ) | divxzmk_se[12] ) | divxzmk_se[11] ) | divxzmk_se[10] ) | divxzmk_se[9] ) | divxzmk_se[8] ) | divxzmk_se[7] ) | divxzmk_se[6] ) | divxzmk_se[5] ) | divxzmk_se[4] ) | divxzmk_se[3] ) | divxzmk_se[2] ) | divxzmk_se[1] ) | divxzmk_se[0] );
    assign divxcz3_se = ( ( ( ( ( ( ( ( ( ( ( ( ( ( ( divxzmk_se[23] | divxzmk_se[22] ) | divxzmk_se[21] ) | divxzmk_se[20] ) | divxzmk_se[19] ) | divxzmk_se[18] ) | divxzmk_se[17] ) | divxzmk_se[16] ) | divxzmk_se[7] ) | divxzmk_se[6] ) | divxzmk_se[5] ) | divxzmk_se[4] ) | divxzmk_se[3] ) | divxzmk_se[2] ) | divxzmk_se[1] ) | divxzmk_se[0] );
    assign divxcz2_se = ( ( ( ( ( ( ( ( ( ( ( ( ( ( ( divxzmk_se[27] | divxzmk_se[26] ) | divxzmk_se[25] ) | divxzmk_se[24] ) | divxzmk_se[19] ) | divxzmk_se[18] ) | divxzmk_se[17] ) | divxzmk_se[16] ) | divxzmk_se[11] ) | divxzmk_se[10] ) | divxzmk_se[9] ) | divxzmk_se[8] ) | divxzmk_se[3] ) | divxzmk_se[2] ) | divxzmk_se[1] ) | divxzmk_se[0] );
    assign divxcz1_se = ( ( ( ( ( ( ( ( ( ( ( ( ( ( ( divxzmk_se[29] | divxzmk_se[28] ) | divxzmk_se[25] ) | divxzmk_se[24] ) | divxzmk_se[21] ) | divxzmk_se[20] ) | divxzmk_se[17] ) | divxzmk_se[16] ) | divxzmk_se[13] ) | divxzmk_se[12] ) | divxzmk_se[9] ) | divxzmk_se[8] ) | divxzmk_se[5] ) | divxzmk_se[4] ) | divxzmk_se[1] ) | divxzmk_se[0] );
    assign divxcz0_se = ( ( ( ( ( ( ( ( ( ( ( ( ( ( ( divxzmk_se[30] | divxzmk_se[28] ) | divxzmk_se[26] ) | divxzmk_se[24] ) | divxzmk_se[22] ) | divxzmk_se[20] ) | divxzmk_se[18] ) | divxzmk_se[16] ) | divxzmk_se[14] ) | divxzmk_se[12] ) | divxzmk_se[10] ) | divxzmk_se[8] ) | divxzmk_se[6] ) | divxzmk_se[4] ) | divxzmk_se[2] ) | divxzmk_se[0] );
    assign divxcz_se = { divxcz5_se, divxcz0_se };
    assign divscyi_se = { divscry_se[4:0], 1'b1 };
    assign divscry_se = ( ( (  ~( divxclz_re) & divyclz_re ) | (  ~( divxclz_re) & divscyi_se ) ) | ( divyclz_re & divscyi_se ) );
    assign divscnt_se = ( (  ~( divxclz_re) ^ divyclz_re ) ^ divscyi_se );
    always 
    begin
        if ( divyclz_re == 1'b0 ) 
        begin
            divscnz_se <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:3945 
            begin
                divscnz_se <= 1'b0;
            end
        end
    end
    assign divyshr_se = { 1'b0, divy_re[31:1] };
    assign divysha_se = divyclz_re[4:0];
    always @ (  divysha_se)
    begin
        if ( divysha_se == 5'b00000 ) 
        begin
            divyshl_se <= divy_re;
        end
        else
        begin 
            if ( divysha_se == 5'b00001 ) 
            begin
                divyshl_se <= { divy_re[30:0], 1'b0 };
            end
            else
            begin 
                if ( divysha_se == 5'b00010 ) 
                begin
                    divyshl_se <= { divy_re[29:0], 2'b00 };
                end
                else
                begin 
                    if ( divysha_se == 5'b00011 ) 
                    begin
                        divyshl_se <= { divy_re[28:0], 3'b000 };
                    end
                    else
                    begin 
                        if ( divysha_se == 5'b00100 ) 
                        begin
                            divyshl_se <= { divy_re[27:0], 1'b0 };
                        end
                        else
                        begin 
                            if ( divysha_se == 5'b00101 ) 
                            begin
                                divyshl_se <= { divy_re[26:0], 1'b0 };
                            end
                            else
                            begin 
                                if ( divysha_se == 5'b00110 ) 
                                begin
                                    divyshl_se <= { divy_re[25:0], 2'b00 };
                                end
                                else
                                begin 
                                    if ( divysha_se == 5'b00111 ) 
                                    begin
                                        divyshl_se <= { divy_re[24:0], 3'b000 };
                                    end
                                    else
                                    begin 
                                        if ( divysha_se == 5'b01000 ) 
                                        begin
                                            divyshl_se <= { divy_re[23:0], 2'b00 };
                                        end
                                        else
                                        begin 
                                            if ( divysha_se == 5'b01001 ) 
                                            begin
                                                divyshl_se <= { divy_re[22:0], 1'b0 };
                                            end
                                            else
                                            begin 
                                                if ( divysha_se == 5'b01010 ) 
                                                begin
                                                    divyshl_se <= { divy_re[21:0], 2'b00 };
                                                end
                                                else
                                                begin 
                                                    if ( divysha_se == 5'b01011 ) 
                                                    begin
                                                        divyshl_se <= { divy_re[20:0], 3'b000 };
                                                    end
                                                    else
                                                    begin 
                                                        if ( divysha_se == 5'b01100 ) 
                                                        begin
                                                            divyshl_se <= { divy_re[19:0], 3'b000 };
                                                        end
                                                        else
                                                        begin 
                                                            if ( divysha_se == 5'b01101 ) 
                                                            begin
                                                                divyshl_se <= { divy_re[18:0], 1'b0 };
                                                            end
                                                            else
                                                            begin 
                                                                if ( divysha_se == 5'b01110 ) 
                                                                begin
                                                                    divyshl_se <= { divy_re[17:0], 2'b00 };
                                                                end
                                                                else
                                                                begin 
                                                                    if ( divysha_se == 5'b01111 ) 
                                                                    begin
                                                                        divyshl_se <= { divy_re[16:0], 3'b000 };
                                                                    end
                                                                    else
                                                                    begin 
                                                                        if ( divysha_se == 5'b10000 ) 
                                                                        begin
                                                                            divyshl_se <= { divy_re[15:0], 4'b0000 };
                                                                        end
                                                                        else
                                                                        begin 
                                                                            if ( divysha_se == 5'b10001 ) 
                                                                            begin
                                                                                divyshl_se <= { divy_re[14:0], 1'b0 };
                                                                            end
                                                                            else
                                                                            begin 
                                                                                if ( divysha_se == 5'b10010 ) 
                                                                                begin
                                                                                    divyshl_se <= { divy_re[13:0], 2'b00 };
                                                                                end
                                                                                else
                                                                                begin 
                                                                                    if ( divysha_se == 5'b10011 ) 
                                                                                    begin
                                                                                        divyshl_se <= { divy_re[12:0], 3'b000 };
                                                                                    end
                                                                                    else
                                                                                    begin 
                                                                                        if ( divysha_se == 5'b10100 ) 
                                                                                        begin
                                                                                            divyshl_se <= { divy_re[11:0], 5'b00000 };
                                                                                        end
                                                                                        else
                                                                                        begin 
                                                                                            if ( divysha_se == 5'b10101 ) 
                                                                                            begin
                                                                                                divyshl_se <= { divy_re[10:0], 1'b0 };
                                                                                            end
                                                                                            else
                                                                                            begin 
                                                                                                if ( divysha_se == 5'b10110 ) 
                                                                                                begin
                                                                                                    divyshl_se <= { divy_re[9:0], 2'b00 };
                                                                                                end
                                                                                                else
                                                                                                begin 
                                                                                                    if ( divysha_se == 5'b10111 ) 
                                                                                                    begin
                                                                                                        divyshl_se <= { divy_re[8:0], 3'b000 };
                                                                                                    end
                                                                                                    else
                                                                                                    begin 
                                                                                                        if ( divysha_se == 5'b11000 ) 
                                                                                                        begin
                                                                                                            divyshl_se <= { divy_re[7:0], 6'b000000 };
                                                                                                        end
                                                                                                        else
                                                                                                        begin 
                                                                                                            if ( divysha_se == 5'b11001 ) 
                                                                                                            begin
                                                                                                                divyshl_se <= { divy_re[6:0], 1'b0 };
                                                                                                            end
                                                                                                            else
                                                                                                            begin 
                                                                                                                if ( divysha_se == 5'b11010 ) 
                                                                                                                begin
                                                                                                                    divyshl_se <= { divy_re[5:0], 2'b00 };
                                                                                                                end
                                                                                                                else
                                                                                                                begin 
                                                                                                                    if ( divysha_se == 5'b11011 ) 
                                                                                                                    begin
                                                                                                                        divyshl_se <= { divy_re[4:0], 3'b000 };
                                                                                                                    end
                                                                                                                    else
                                                                                                                    begin 
                                                                                                                        if ( divysha_se == 5'b11100 ) 
                                                                                                                        begin
                                                                                                                            divyshl_se <= { divy_re[3:0], 7'b0000000 };
                                                                                                                        end
                                                                                                                        else
                                                                                                                        begin 
                                                                                                                            if ( divysha_se == 5'b11101 ) 
                                                                                                                            begin
                                                                                                                                divyshl_se <= { divy_re[2:0], 1'b0 };
                                                                                                                            end
                                                                                                                            else
                                                                                                                            begin 
                                                                                                                                if ( divysha_se == 5'b11110 ) 
                                                                                                                                begin
                                                                                                                                    divyshl_se <= { divy_re[1:0], 2'b00 };
                                                                                                                                end
                                                                                                                                else
                                                                                                                                begin 
                                                                                                                                    if ( divysha_se == 5'b11111 ) 
                                                                                                                                    begin
                                                                                                                                        divyshl_se <= { divy_re[0], 3'b000 };
                                                                                                                                    end
                                                                                                                                    else
                                                                                                                                    begin 
                                                                                                                                        divyshl_se <= 8'b00000000;
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            end
                                                                                                                        end
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    assign divdpr0_se = ( divx_re |  ~( divy_re) );
    assign divdgn0_se = ( divx_re &  ~( divy_re) );
    assign divdpr1_se = ( divdpr0_se & { divdpr0_se[30:0], 1'b1 } );
    assign divdpr2_se = ( divdpr1_se & { divdpr1_se[29:0], 2'b11 } );
    assign divdpr3_se = ( divdpr2_se & { divdpr2_se[27:0], 4'b1111 } );
    assign divdpr4_se = ( divdpr3_se & { divdpr3_se[23:0], 8'b11111111 } );
    assign divdpr5_se = ( divdpr4_se & { divdpr4_se[15:0], 16'b1111111111111111 } );
    assign divdgn1_se = ( divdgn0_se | ( divdpr0_se & { divdgn0_se[30:0], 1'b0 } ) );
    assign divdgn2_se = ( divdgn1_se | ( divdpr1_se & { divdgn1_se[29:0], 2'b00 } ) );
    assign divdgn3_se = ( divdgn2_se | ( divdpr2_se & { divdgn2_se[27:0], 4'b0000 } ) );
    assign divdgn4_se = ( divdgn3_se | ( divdpr3_se & { divdgn3_se[23:0], 2'b00 } ) );
    assign divdgn5_se = ( divdgn4_se | ( divdpr4_se & { divdgn4_se[15:0], 4'b0000 } ) );
    assign divdcry_se = ( divdgn5_se | divdpr5_se );
    assign divdcyi_se = { divdcry_se[30:0], 1'b1 };
    assign divdif_se = ( ( divx_re ^  ~( divy_re) ) ^ divdcyi_se );
    assign divlpr0_se = ( divx_re ^  ~( divy_re) );
    assign divlgn0_se = ( divx_re &  ~( divy_re) );
    assign divlpr1_se = ( divlpr0_se & { divlpr0_se[30:0], 1'b1 } );
    assign divlpr2_se = ( divlpr1_se & { divlpr1_se[29:0], 2'b11 } );
    assign divlpr3_se = ( divlpr2_se & { divlpr2_se[27:0], 4'b1111 } );
    assign divlpr4_se = ( divlpr3_se & { divlpr3_se[23:0], 8'b11111111 } );
    assign divlpr5_se = ( divlpr4_se & { divlpr4_se[15:0], 16'b1111111111111111 } );
    assign divlgn1_se = ( divlgn0_se | ( divlpr0_se & { divlgn0_se[30:0], 1'b0 } ) );
    assign divlgn2_se = ( divlgn1_se | ( divlpr1_se & { divlgn1_se[29:0], 2'b00 } ) );
    assign divlgn3_se = ( divlgn2_se | ( divlpr2_se & { divlgn2_se[27:0], 4'b0000 } ) );
    assign divlgn4_se = ( divlgn3_se | ( divlpr3_se & { divlgn3_se[23:0], 2'b00 } ) );
    assign divlgn5_se = ( divlgn4_se | ( divlpr4_se & { divlgn4_se[15:0], 4'b0000 } ) );
    assign divleu_se = ( divlgn5_se[31] | divlpr5_se[31] );
    assign divqshl_se = { divq_re[30:0], divleu_se };
    assign daccess_se = ( i_stor_se | i_load_se );
    assign read_se = i_load_se;
    assign write_se = i_stor_se;
    always @ (  daccess_se)
    begin
        if ( ( earlyex_xe == 1'b0 ) & ( reset_rx == 1'b0 ) ) 
        begin
            drq_se <= daccess_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4094 
            begin
                drq_se <= 1'b0;
            end
        end
    end
    always @ (  eret_se)
    begin
        if ( ( earlyex_xe == 1'b0 ) & ( reset_rx == 1'b0 ) ) 
        begin
            drstlk_se <= eret_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4095 
            begin
                drstlk_se <= 1'b0;
            end
        end
    end
    always @ (  sync_se)
    begin
        if ( ( earlyex_xe == 1'b0 ) & ( reset_rx == 1'b0 ) ) 
        begin
            dsync_se <= sync_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4096 
            begin
                dsync_se <= 1'b0;
            end
        end
    end
    always @ (  cach_se)
    begin
        if ( ( earlyex_xe == 1'b0 ) & ( reset_rx == 1'b0 ) ) 
        begin
            dcache_se <= cach_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4097 
            begin
                dcache_se <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( ( i_byte_se == 1'b1 ) & ( rarith_se[1:0] == 2'b00 ) ) 
        begin
            bytsel_se <= 4'b0001;
        end
        else
        begin 
            if ( ( i_byte_se == 1'b1 ) & ( rarith_se[1:0] == 2'b01 ) ) 
            begin
                bytsel_se <= 4'b0010;
            end
            else
            begin 
                if ( ( i_byte_se == 1'b1 ) & ( rarith_se[1:0] == 2'b10 ) ) 
                begin
                    bytsel_se <= 4'b0100;
                end
                else
                begin 
                    if ( ( i_byte_se == 1'b1 ) & ( rarith_se[1:0] == 2'b11 ) ) 
                    begin
                        bytsel_se <= 4'b1000;
                    end
                    else
                    begin 
                        if ( ( i_half_se == 1'b1 ) & ( rarith_se[1] == 1'b0 ) ) 
                        begin
                            bytsel_se <= 4'b0011;
                        end
                        else
                        begin 
                            if ( ( i_half_se == 1'b1 ) & ( rarith_se[1] == 1'b1 ) ) 
                            begin
                                bytsel_se <= 4'b1100;
                            end
                            else
                            begin 
                                if ( i_word_se == 1'b1 ) 
                                begin
                                    bytsel_se <= 4'b1111;
                                end
                                else
                                begin 
                                    if ( ( i_wrdr_se == 1'b1 ) & ( rarith_se[1:0] == 2'b00 ) ) 
                                    begin
                                        bytsel_se <= 4'b1111;
                                    end
                                    else
                                    begin 
                                        if ( ( i_wrdr_se == 1'b1 ) & ( rarith_se[1:0] == 2'b01 ) ) 
                                        begin
                                            bytsel_se <= 4'b1110;
                                        end
                                        else
                                        begin 
                                            if ( ( i_wrdr_se == 1'b1 ) & ( rarith_se[1:0] == 2'b10 ) ) 
                                            begin
                                                bytsel_se <= 4'b1100;
                                            end
                                            else
                                            begin 
                                                if ( ( i_wrdr_se == 1'b1 ) & ( rarith_se[1:0] == 2'b11 ) ) 
                                                begin
                                                    bytsel_se <= 4'b1000;
                                                end
                                                else
                                                begin 
                                                    if ( ( i_wrdl_se == 1'b1 ) & ( rarith_se[1:0] == 2'b00 ) ) 
                                                    begin
                                                        bytsel_se <= 4'b0001;
                                                    end
                                                    else
                                                    begin 
                                                        if ( ( i_wrdl_se == 1'b1 ) & ( rarith_se[1:0] == 2'b01 ) ) 
                                                        begin
                                                            bytsel_se <= 4'b0011;
                                                        end
                                                        else
                                                        begin 
                                                            if ( ( i_wrdl_se == 1'b1 ) & ( rarith_se[1:0] == 2'b10 ) ) 
                                                            begin
                                                                bytsel_se <= 4'b0111;
                                                            end
                                                            else
                                                            begin 
                                                                if ( ( i_wrdl_se == 1'b1 ) & ( rarith_se[1:0] == 2'b11 ) ) 
                                                                begin
                                                                    bytsel_se <= 4'b1111;
                                                                end
                                                                else
                                                                begin 
                                                                    if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4103 
                                                                    begin
                                                                        bytsel_se <= 4'b0000;
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    always @ (  toper_se)
    begin
        if ( i_byte_se == 1'b1 ) 
        begin
            data_b_se <= { toper_se[31:16], toper_se[7:0] };
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4130 
            begin
                data_b_se <= toper_se;
            end
        end
    end
    always @ (  data_b_se)
    begin
        if ( i_byte_se == 1'b1 ) 
        begin
            data_h_se <= { data_b_se[15:0], data_b_se[15:0] };
        end
        else
        begin 
            if ( i_half_se == 1'b1 ) 
            begin
                data_h_se <= { data_b_se[15:0], data_b_se[15:0] };
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4135 
                begin
                    data_h_se <= data_b_se;
                end
            end
        end
    end
    always @ (  data_h_se)
    begin
        if ( i_wrdl_se == 1'b1 ) 
        begin
            data_l_se <= { data_h_se[23:0], data_h_se[31:24] };
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4141 
            begin
                data_l_se <= data_h_se;
            end
        end
    end
    always @ (  data_l_se)
    begin
        if ( rarith_se[0] == 1'b1 ) 
        begin
            data_0_se <= { data_l_se[23:0], data_l_se[31:24] };
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4145 
            begin
                data_0_se <= data_l_se;
            end
        end
    end
    always @ (  data_0_se)
    begin
        if ( rarith_se[1] == 1'b1 ) 
        begin
            data_1_se <= { data_0_se[15:0], data_0_se[31:16] };
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4149 
            begin
                data_1_se <= data_0_se;
            end
        end
    end
    assign data_se = data_1_se;
    assign cachop_se = rt_rd;
    assign cachop_sm = rt_re;
    assign wredopc_se = i_brnch_se;
    always 
    begin
        if ( ( i_musel_sm == 1'b1 ) & ( i_wlo_sw == 1'b1 ) ) 
        begin
            hz_lo_sm <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4172 
            begin
                hz_lo_sm <= 1'b0;
            end
        end
    end
    always 
    begin
        if ( ( i_museh_sm == 1'b1 ) & ( i_whi_sw == 1'b1 ) ) 
        begin
            hz_hi_sm <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4175 
            begin
                hz_hi_sm <= 1'b0;
            end
        end
    end
    assign dathzds_sm = ( hz_lo_sm | hz_hi_sm );
    assign hazards_sm = dathzds_sm;
    always 
    begin
        if ( ( ( ( effhwre_rd == 1'b0 ) & ( rdhwr_se == 1'b1 ) ) & ( usrmod_sx == 1'b1 ) ) & ( status_rx[28] == 1'b0 ) ) 
        begin
            rdhwr_xe <= 1'b1;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4209 
            begin
                rdhwr_xe <= 1'b0;
            end
        end
    end
    assign rsvdins_xe = ( rdhwr_xe | rsvdins_rd );
    always @ (  rarith_se)
    begin
        if ( i_word_se == 1'b1 ) 
        begin
            damalgn_xe <= ( rarith_se[0] | rarith_se[1] );
        end
        else
        begin 
            if ( i_half_se == 1'b1 ) 
            begin
                damalgn_xe <= rarith_se[0];
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4227 
                begin
                    damalgn_xe <= 1'b0;
                end
            end
        end
    end
    always 
    begin
        if ( impstd_sx == 1'b1 ) 
        begin
            dasviol_xe <= ( rarith_se[31] & usrmod_sx );
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4231 
            begin
                dasviol_xe <= 1'b0;
            end
        end
    end
    assign lamalgn_xe = ( damalgn_xe & i_mload_se );
    assign lasviol_xe = ( dasviol_xe & i_mload_se );
    assign samalgn_xe = ( damalgn_xe & i_mstor_se );
    assign sasviol_xe = ( dasviol_xe & i_mstor_se );
    always @ (  overflw_se)
    begin
        if ( i_ovrf_se == 1'b1 ) 
        begin
            ovrf_xe <= overflw_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4239 
            begin
                ovrf_xe <= 1'b0;
            end
        end
    end
    always @ (  testbit_se)
    begin
        if ( trap_rd == 1'b1 ) 
        begin
            trap_xe <= testbit_se;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4240 
            begin
                trap_xe <= 1'b0;
            end
        end
    end
    assign effwait_sm = ( wait_sm &  ~( hwswit_rx) );
    assign dnotrdy_sm = (  ~( d_accpt) & ( ( ( drq_re | drstlk_re ) | dsync_re ) | dcache_re ) );
    assign rd_sm = rd_re;
    assign bytadr_sm = res_re[1:0];
    always @ (  d_in)
    begin
        if ( bytadr_sm == 2'b00 ) 
        begin
            din_sm <= d_in;
        end
        else
        begin 
            if ( bytadr_sm == 2'b01 ) 
            begin
                din_sm <= { 2'b00, d_in[31:8] };
            end
            else
            begin 
                if ( bytadr_sm == 2'b10 ) 
                begin
                    din_sm <= { 4'b0000, d_in[31:16] };
                end
                else
                begin 
                    if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4273 
                    begin
                        din_sm <= { 6'b000000, d_in[31:24] };
                    end
                end
            end
        end
    end
    always @ (  d_in)
    begin
        if ( bytadr_sm == 2'b00 ) 
        begin
            wrdin_sm <= d_in;
        end
        else
        begin 
            if ( bytadr_sm == 2'b01 ) 
            begin
                wrdin_sm <= { data_re[7:0], d_in[31:8] };
            end
            else
            begin 
                if ( bytadr_sm == 2'b10 ) 
                begin
                    wrdin_sm <= { data_re[15:0], d_in[31:16] };
                end
                else
                begin 
                    if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4285 
                    begin
                        wrdin_sm <= { data_re[23:0], d_in[31:24] };
                    end
                end
            end
        end
    end
    always @ (  d_in)
    begin
        if ( bytadr_sm == 2'b11 ) 
        begin
            wldin_sm <= d_in;
        end
        else
        begin 
            if ( bytadr_sm == 2'b10 ) 
            begin
                wldin_sm <= { d_in[23:0], data_re[31:24] };
            end
            else
            begin 
                if ( bytadr_sm == 2'b01 ) 
                begin
                    wldin_sm <= { d_in[15:0], data_re[31:16] };
                end
                else
                begin 
                    if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4297 
                    begin
                        wldin_sm <= { d_in[7:0], data_re[31:8] };
                    end
                end
            end
        end
    end
    assign scdin_sm = din_sm;
    always 
    begin
        if ( din_sm[7] == 1'b1 ) 
        begin
            bsext_sm <= 24'b111111111111111111111111;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4314 
            begin
                bsext_sm <= 6'b000000;
            end
        end
    end
    always 
    begin
        if ( din_sm[15] == 1'b1 ) 
        begin
            hsext_sm <= 16'b1111111111111111;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4315 
            begin
                hsext_sm <= 4'b0000;
            end
        end
    end
    always @ (  opcod_re)
    begin
        if ( opcod_re == 9'b001100011 ) 
        begin
            data_sm <= din_sm;
        end
        else
        begin 
            if ( opcod_re == 9'b001100010 ) 
            begin
                data_sm <= wldin_sm;
            end
            else
            begin 
                if ( opcod_re == 9'b001100110 ) 
                begin
                    data_sm <= wrdin_sm;
                end
                else
                begin 
                    if ( opcod_re == 9'b001100001 ) 
                    begin
                        data_sm <= { hsext_sm, din_sm[15:0] };
                    end
                    else
                    begin 
                        if ( opcod_re == 9'b001100101 ) 
                        begin
                            data_sm <= { 4'b0000, din_sm[15:0] };
                        end
                        else
                        begin 
                            if ( opcod_re == 9'b001100000 ) 
                            begin
                                data_sm <= { bsext_sm, din_sm[7:0] };
                            end
                            else
                            begin 
                                if ( opcod_re == 9'b001100100 ) 
                                begin
                                    data_sm <= { 6'b000000, din_sm[7:0] };
                                end
                                else
                                begin 
                                    if ( opcod_re == 9'b001110000 ) 
                                    begin
                                        data_sm <= din_sm;
                                    end
                                    else
                                    begin 
                                        if ( opcod_re == 9'b001111000 ) 
                                        begin
                                            data_sm <= scdin_sm;
                                        end
                                        else
                                        begin 
                                            if ( opcod_re == 9'b110100000 ) 
                                            begin
                                                data_sm <= din_sm;
                                            end
                                            else
                                            begin 
                                                data_sm <= res_re;
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    always @ (  divq_rm or  divq_rm or  data_rm or  rmul_sw)
    begin
        if ( opcod_rm == 9'b000011010 ) 
        begin
            lo_sw <= divq_rm;
        end
        else
        begin 
            if ( opcod_rm == 9'b000011011 ) 
            begin
                lo_sw <= divq_rm;
            end
            else
            begin 
                if ( opcod_rm == 9'b000010011 ) 
                begin
                    lo_sw <= data_rm;
                end
                else
                begin 
                    if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4334 
                    begin
                        lo_sw <= rmul_sw[31:0];
                    end
                end
            end
        end
    end
    always @ (  divr_rm or  divr_rm or  data_rm or  rmul_sw)
    begin
        if ( opcod_rm == 9'b000011010 ) 
        begin
            hi_sw <= divr_rm;
        end
        else
        begin 
            if ( opcod_rm == 9'b000011011 ) 
            begin
                hi_sw <= divr_rm;
            end
            else
            begin 
                if ( opcod_rm == 9'b000010001 ) 
                begin
                    hi_sw <= data_rm;
                end
                else
                begin 
                    if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4339 
                    begin
                        hi_sw <= rmul_sw[63:32];
                    end
                end
            end
        end
    end
    always @ (  rmul_sw or  data_rm)
    begin
        if ( opcod_rm == 9'b010000010 ) 
        begin
            data_sw <= rmul_sw[31:0];
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4348 
            begin
                data_sw <= data_rm;
            end
        end
    end
    assign dabuser_xm = ( ( d_rberr & drq_re ) | d_wberr );
    assign wbadda_xm = ( ( ( sasviol_re | lasviol_re ) | lamalgn_re ) | samalgn_re );
    assign wbadia_xm = ( iasviol_re | iamalgn_re );
    assign cntpr0_sx = count_rx;
    assign cntpr1_sx = ( cntpr0_sx & { cntpr0_sx[30:0], 1'b1 } );
    assign cntpr2_sx = ( cntpr1_sx & { cntpr1_sx[29:0], 2'b11 } );
    assign cntpr3_sx = ( cntpr2_sx & { cntpr2_sx[27:0], 4'b1111 } );
    assign cntpr4_sx = ( cntpr3_sx & { cntpr3_sx[23:0], 8'b11111111 } );
    assign cntpr5_sx = ( cntpr4_sx & { cntpr4_sx[15:0], 16'b1111111111111111 } );
    assign cntcry_sx = cntpr5_sx;
    assign cntcyi_sx = { cntcry_sx[30:0], 1'b1 };
    assign count_sx = ( cntcyi_sx ^ count_rx );
    assign count_sm = res_re;
    assign wcount_sx = 1'b1;
    always @ (  i_wcop0_sm)
    begin
        if ( cop0d_re == 8'b01001000 ) 
        begin
            wcount_sm <= i_wcop0_sm;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4422 
            begin
                wcount_sm <= 1'b0;
            end
        end
    end
    assign ebase_xx = { 20'b10000000000000000000, cpu_nbr };
    always 
    begin
        if ( imptsr_sx == 1'b1 ) 
        begin
            ebase_sm <= { res_re[31:12], cpu_nbr };
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4437 
            begin
                ebase_sm <= { 2'b10, cpu_nbr };
            end
        end
    end
    assign webase_xx = reset_rx;
    always @ (  i_wcop0_sm)
    begin
        if ( cop0d_re == 8'b01111001 ) 
        begin
            webase_sm <= i_wcop0_sm;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4449 
            begin
                webase_sm <= 1'b0;
            end
        end
    end
    assign tcctx_sm = res_re;
    always @ (  i_wcop0_sm)
    begin
        if ( cop0d_re == 8'b00010101 ) 
        begin
            wtcctx_sm <= i_wcop0_sm;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4465 
            begin
                wtcctx_sm <= 1'b0;
            end
        end
    end
    always @ (  i_wcop0_sm)
    begin
        if ( cop0d_re == 8'b00100010 ) 
        begin
            wusrlcl_sm <= i_wcop0_sm;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4474 
            begin
                wusrlcl_sm <= 1'b0;
            end
        end
    end
    always @ (  i_wcop0_sm)
    begin
        if ( cop0d_re == 8'b00111000 ) 
        begin
            whwrena_sm <= i_wcop0_sm;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4482 
            begin
                whwrena_sm <= 1'b0;
            end
        end
    end
    always @ (  bdslot_re or  cause_rx)
    begin
        if ( status_rx[1] == 1'b0 ) 
        begin
            bdslot_xm <= bdslot_re;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4517 
            begin
                bdslot_xm <= cause_rx[31];
            end
        end
    end
    always 
    begin
        if ( mcheckx_rx == 1'b1 ) 
        begin
            exccode_xm <= 5'b11000;
        end
        else
        begin 
            if ( iabuser_re == 1'b1 ) 
            begin
                exccode_xm <= 3'b110;
            end
            else
            begin 
                if ( ( iamalgn_re | iasviol_re ) == 1'b1 ) 
                begin
                    exccode_xm <= 3'b100;
                end
                else
                begin 
                    if ( ( lamalgn_re | lasviol_re ) == 1'b1 ) 
                    begin
                        exccode_xm <= 3'b100;
                    end
                    else
                    begin 
                        if ( ( samalgn_re | sasviol_re ) == 1'b1 ) 
                        begin
                            exccode_xm <= 3'b101;
                        end
                        else
                        begin 
                            if ( syscall_re == 1'b1 ) 
                            begin
                                exccode_xm <= 4'b1000;
                            end
                            else
                            begin 
                                if ( break_re == 1'b1 ) 
                                begin
                                    exccode_xm <= 4'b1001;
                                end
                                else
                                begin 
                                    if ( rsvdins_re == 1'b1 ) 
                                    begin
                                        exccode_xm <= 4'b1010;
                                    end
                                    else
                                    begin 
                                        if ( cpunuse_re == 1'b1 ) 
                                        begin
                                            exccode_xm <= 4'b1011;
                                        end
                                        else
                                        begin 
                                            if ( ovrf_re == 1'b1 ) 
                                            begin
                                                exccode_xm <= 4'b1100;
                                            end
                                            else
                                            begin 
                                                if ( trap_re == 1'b1 ) 
                                                begin
                                                    exccode_xm <= 4'b1101;
                                                end
                                                else
                                                begin 
                                                    if ( dabuser_xm == 1'b1 ) 
                                                    begin
                                                        exccode_xm <= 3'b111;
                                                    end
                                                    else
                                                    begin 
                                                        if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4519 
                                                        begin
                                                            exccode_xm <= 1'b0;
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    assign cause_xx = { 4'b0000, 2'b00 };
    assign cause_xm = { bdslot_xm, cause_rx[1:0] };
    assign cause_sm = { cause_rx[31:28], cause_rx[7:0] };
    assign cause_sx = { cause_rx[31:16], cause_rx[9:0] };
    assign wcause_xx = reset_rx;
    assign wcause_xm = excrq_xm;
    always @ (  i_wcop0_sm)
    begin
        if ( cop0d_re == 8'b01101000 ) 
        begin
            wcause_sm <= i_wcop0_sm;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4586 
            begin
                wcause_sm <= 1'b0;
            end
        end
    end
    assign status_xx = 23'b10000000000000000000100;
    assign status_xm = ( status_rx | 2'b10 );
    always 
    begin
        if ( status_rx[2] == 1'b1 ) 
        begin
            rstorsr_sm <= ( status_rx & 32'b11111111111111111111111111111011 );
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4614 
            begin
                rstorsr_sm <= ( status_rx & 32'b11111111111111111111111111111001 );
            end
        end
    end
    assign deisr_sm = { status_rx[31:1], i_re[5] };
    always @ (  rstorsr_sm or  deisr_sm or  res_re)
    begin
        if ( eret_sm == 1'b1 ) 
        begin
            status_sm <= rstorsr_sm;
        end
        else
        begin 
            if ( mfmc0_sm == 1'b1 ) 
            begin
                status_sm <= deisr_sm;
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4619 
                begin
                    status_sm <= res_re;
                end
            end
        end
    end
    assign wsr_xx = reset_rx;
    assign wsr_xm = excrq_xm;
    always 
    begin
        if ( eret_sm == 1'b1 ) 
        begin
            wsr_sm <= 1'b1;
        end
        else
        begin 
            if ( mfmc0_sm == 1'b1 ) 
            begin
                wsr_sm <= 1'b1;
            end
            else
            begin 
                if ( ( mtc0_sm == 1'b1 ) & ( cop0d_re == 8'b01100000 ) ) 
                begin
                    wsr_sm <= 1'b1;
                end
                else
                begin 
                    if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4634 
                    begin
                        wsr_sm <= 1'b0;
                    end
                end
            end
        end
    end
    always @ (  pc_re or  redopc_re)
    begin
        if ( bdslot_re == 1'b0 ) 
        begin
            epc_xm <= pc_re;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4660 
            begin
                epc_xm <= redopc_re;
            end
        end
    end
    assign epc_sm = res_re;
    always @ (  excrq_xm)
    begin
        if ( status_rx[1] == 1'b0 ) 
        begin
            wepc_xm <= excrq_xm;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4674 
            begin
                wepc_xm <= 1'b0;
            end
        end
    end
    always @ (  i_wcop0_sm)
    begin
        if ( cop0d_re == 8'b01110000 ) 
        begin
            wepc_sm <= i_wcop0_sm;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4675 
            begin
                wepc_sm <= 1'b0;
            end
        end
    end
    always @ (  pc_re or  redopc_re)
    begin
        if ( bdslot_re == 1'b0 ) 
        begin
            eepc_xx <= pc_re;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4692 
            begin
                eepc_xx <= redopc_re;
            end
        end
    end
    assign eepc_sm = res_re;
    assign weepc_xx = reset_rx;
    always @ (  i_wcop0_sm)
    begin
        if ( cop0d_re == 8'b11110000 ) 
        begin
            weepc_sm <= i_wcop0_sm;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4703 
            begin
                weepc_sm <= 1'b0;
            end
        end
    end
    assign nextpc_xx = reset_addr;
    assign excadr_xm = { ebase_rm[31:12], 9'b110000000 };
    always @ (  excadr_xm)
    begin
        if ( status_rx[22] == 1'b1 ) 
        begin
            nextpc_xm <= bootexc_addr;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4716 
            begin
                nextpc_xm <= excadr_xm;
            end
        end
    end
    assign earlyex_xe = ( ( ( ( ( ( ( ( ( ( ( ( ( ( cpunuse_rd | break_rd ) | syscall_rd ) | trap_xe ) | iabuser_rd ) | iamalgn_rd ) | iasviol_rd ) | rsvdins_xe ) | lamalgn_xe ) | lasviol_xe ) | samalgn_xe ) | sasviol_xe ) | ovrf_xe ) | mcheckx_xx ) | intrq_rx );
    assign lateex_xm = dabuser_xm;
    assign excrq_xm = ( earlyex_re | lateex_xm );
    always 
    begin
        if ( cause_rx[15:8] == 2'b00 ) 
        begin
            hwswit_xx <= 1'b0;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4749 
            begin
                hwswit_xx <= 1'b1;
            end
        end
    end
    assign itmask_xx = status_rx[15:8];
    assign enblit_xx = ( itmask_xx & cause_rx[15:8] );
    always 
    begin
        if ( status_rx[2:0] == 3'b001 ) 
        begin
            glbmsk_xx <=  ~( killed_se);
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4761 
            begin
                glbmsk_xx <= 1'b0;
            end
        end
    end
    always @ (  glbmsk_xx)
    begin
        if ( enblit_xx == 2'b00 ) 
        begin
            intrq_xx <= 1'b0;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:4763 
            begin
                intrq_xx <= glbmsk_xx;
            end
        end
    end
    assign kill_si = ( ( ( excrq_xm | reset_rx ) | mtc0_sd ) | eret_sd );
    assign stall_si = (  ~( kill_si) & ( ( copy_sd | stall_sd ) | inotrdy_se ) );
    assign copy_si = 1'b0;
    assign exec_si =  ~( ( ( kill_si | stall_si ) | copy_si ));
    assign kill_sd = ( excrq_xm | reset_rx );
    assign stall_sd = (  ~( kill_sd) & ( ( ( copy_se | stall_se ) | hazards_sd ) | inotrdy_se ) );
    assign copy_sd = 1'b0;
    assign exec_sd =  ~( ( ( kill_sd | stall_sd ) | copy_sd ));
    assign kill_se = ( excrq_xm | reset_rx );
    assign stall_se = (  ~( kill_se) & ( ( copy_sm | stall_sm ) | hazards_se ) );
    assign copy_se = (  ~( ( kill_se | stall_se )) & miccopy_se );
    assign exec_se =  ~( ( ( kill_se | stall_se ) | copy_se ));
    assign kill_sm = ( excrq_xm | reset_rx );
    assign stall_sm = (  ~( kill_sm) & ( ( ( copy_sw | stall_sw ) | hazards_sm ) | dnotrdy_sm ) );
    assign copy_sm = (  ~( ( kill_sm | stall_sm )) & effwait_sm );
    assign exec_sm =  ~( ( ( kill_sm | stall_sm ) | copy_sm ));
    assign kill_sw = 1'b0;
    assign stall_sw = 1'b0;
    assign copy_sw = 1'b0;
    assign exec_sw =  ~( ( ( kill_sw | stall_sw ) | copy_sw ));
    assign killed_si = kill_si;
    assign killed_sd = ( kill_sd | killed_ri );
    assign killed_se = ( kill_se | killed_rd );
    assign bubble_si = ( ( kill_si | stall_si ) & ( kill_sd | exec_sd ) );
    assign hold_si = ( stall_sd | copy_sd );
    assign shift_si = ( ( copy_si | exec_si ) & exec_sd );
    assign bubble_sd = ( ( kill_sd | stall_sd ) & ( kill_se | exec_se ) );
    assign hold_sd = ( stall_se | copy_se );
    assign shift_sd = ( ( copy_sd | exec_sd ) & exec_se );
    assign bubble_se = ( ( kill_se | stall_se ) & ( kill_sm | exec_sm ) );
    assign hold_se = ( stall_sm | copy_sm );
    assign shift_se = ( ( copy_se | exec_se ) & exec_sm );
    assign bubble_sm = ( ( kill_sm | stall_sm ) & ( kill_sw | exec_sw ) );
    assign hold_sm = ( stall_sw | copy_sw );
    assign shift_sm = ( ( copy_sm | exec_sm ) & exec_sw );
    assign bubble_sw = ( ( kill_sw | stall_sw ) & ( 1'b0 | 1'b1 ) );
    assign hold_sw = ( 1'b0 | 1'b0 );
    assign shift_sw = ( ( copy_sw | exec_sw ) & 1'b1 );
    assign load_si = ( copy_si | exec_si );
    assign keep_si = ( kill_si | stall_si );
    assign load_sd = ( copy_sd | exec_sd );
    assign keep_sd = ( kill_sd | stall_sd );
    assign load_se = ( copy_se | exec_se );
    assign keep_se = ( kill_se | stall_se );
    assign load_sm = ( copy_sm | exec_sm );
    assign keep_sm = ( kill_sm | stall_sm );
    assign load_sw = ( copy_sw | exec_sw );
    assign keep_sw = ( kill_sw | stall_sw );
    always @ (  posedge ck)
    begin : IFC_CYCLE
        if ( ck ) 
        begin
            if ( bubble_si == 1'b1 ) 
            begin
                i_ri <= 8'b00000000;
            end
            else
            begin 
                if ( hold_si == 1'b1 ) 
                begin
                    i_ri <= i_ri;
                end
                else
                begin 
                    i_ri <= i_in;
                end
            end
            if ( bubble_si == 1'b1 ) 
            begin
                iread_ri <= 1'b0;
            end
            else
            begin 
                if ( hold_si == 1'b1 ) 
                begin
                    iread_ri <= 1'b0;
                end
                else
                begin 
                    iread_ri <= 1'b1;
                end
            end
            if ( bubble_si == 1'b1 ) 
            begin
                bdslot_ri <= bdslot_xi;
            end
            else
            begin 
                if ( hold_si == 1'b1 ) 
                begin
                    bdslot_ri <= bdslot_ri;
                end
                else
                begin 
                    bdslot_ri <= bdslot_xi;
                end
            end
            if ( bubble_si == 1'b1 ) 
            begin
                killed_ri <= killed_si;
            end
            else
            begin 
                if ( hold_si == 1'b1 ) 
                begin
                    killed_ri <= killed_ri;
                end
                else
                begin 
                    killed_ri <= killed_si;
                end
            end
            if ( bubble_si == 1'b1 ) 
            begin
                iabuser_ri <= 1'b0;
            end
            else
            begin 
                if ( hold_si == 1'b1 ) 
                begin
                    iabuser_ri <= iabuser_ri;
                end
                else
                begin 
                    iabuser_ri <= iabuser_xi;
                end
            end
            if ( bubble_si == 1'b1 ) 
            begin
                iamalgn_ri <= 1'b0;
            end
            else
            begin 
                if ( hold_si == 1'b1 ) 
                begin
                    iamalgn_ri <= iamalgn_ri;
                end
                else
                begin 
                    iamalgn_ri <= iamalgn_xi;
                end
            end
            if ( bubble_si == 1'b1 ) 
            begin
                iasviol_ri <= 1'b0;
            end
            else
            begin 
                if ( hold_si == 1'b1 ) 
                begin
                    iasviol_ri <= iasviol_ri;
                end
                else
                begin 
                    iasviol_ri <= iasviol_xi;
                end
            end
            if ( hold_si == 1'b1 ) 
            begin
                pc_ri <= pc_ri;
            end
            else
            begin 
                pc_ri <= nextpc_rd;
            end
        end
    end
    always @ (  posedge ck)
    begin : DEC_CYCLE
        if ( ck ) 
        begin
            if ( bubble_sd == 1'b1 ) 
            begin
                i_rd <= 8'b00000000;
            end
            else
            begin 
                if ( hold_sd == 1'b1 ) 
                begin
                    i_rd <= i_rd;
                end
                else
                begin 
                    i_rd <= i_ri;
                end
            end
            if ( bubble_sd == 1'b1 ) 
            begin
                i_type_rd <= nop_type;
            end
            else
            begin 
                if ( hold_sd == 1'b1 ) 
                begin
                    i_type_rd <= i_type_rd;
                end
                else
                begin 
                    i_type_rd <= i_type_sd;
                end
            end
            if ( bubble_sd == 1'b1 ) 
            begin
                opcod_rd <= 9'b000000000;
            end
            else
            begin 
                if ( hold_sd == 1'b1 ) 
                begin
                    opcod_rd <= opcod_rd;
                end
                else
                begin 
                    opcod_rd <= opcod_sd;
                end
            end
            if ( bubble_sd == 1'b1 ) 
            begin
                bdslot_rd <= bdslot_ri;
            end
            else
            begin 
                if ( hold_sd == 1'b1 ) 
                begin
                    bdslot_rd <= bdslot_rd;
                end
                else
                begin 
                    bdslot_rd <= bdslot_ri;
                end
            end
            if ( bubble_sd == 1'b1 ) 
            begin
                killed_rd <= killed_sd;
            end
            else
            begin 
                if ( hold_sd == 1'b1 ) 
                begin
                    killed_rd <= killed_rd;
                end
                else
                begin 
                    killed_rd <= killed_sd;
                end
            end
            if ( bubble_sd == 1'b1 ) 
            begin
                rs_rd <= 5'b00000;
            end
            else
            begin 
                if ( hold_sd == 1'b1 ) 
                begin
                    rs_rd <= rs_rd;
                end
                else
                begin 
                    rs_rd <= rs_sd;
                end
            end
            if ( bubble_sd == 1'b1 ) 
            begin
                rt_rd <= 5'b00000;
            end
            else
            begin 
                if ( hold_sd == 1'b1 ) 
                begin
                    rt_rd <= rt_rd;
                end
                else
                begin 
                    rt_rd <= rt_sd;
                end
            end
            if ( bubble_sd == 1'b1 ) 
            begin
                rd_rd <= 5'b00000;
            end
            else
            begin 
                if ( hold_sd == 1'b1 ) 
                begin
                    rd_rd <= rd_rd;
                end
                else
                begin 
                    rd_rd <= effrd_sd;
                end
            end
            if ( bubble_sd == 1'b1 ) 
            begin
                effhwre_rd <= 8'b00000000;
            end
            else
            begin 
                if ( hold_sd == 1'b1 ) 
                begin
                    effhwre_rd <= effhwre_rd;
                end
                else
                begin 
                    effhwre_rd <= effhwre_sd;
                end
            end
            if ( bubble_sd == 1'b1 ) 
            begin
                cop0d_rd <= 8'b00000000;
            end
            else
            begin 
                if ( hold_sd == 1'b1 ) 
                begin
                    cop0d_rd <= cop0d_rd;
                end
                else
                begin 
                    cop0d_rd <= cop0d_sd;
                end
            end
            if ( bubble_sd == 1'b1 ) 
            begin
                trap_rd <= 1'b0;
            end
            else
            begin 
                if ( hold_sd == 1'b1 ) 
                begin
                    trap_rd <= trap_rd;
                end
                else
                begin 
                    trap_rd <= i_trap_sd;
                end
            end
            if ( bubble_sd == 1'b1 ) 
            begin
                break_rd <= 1'b0;
            end
            else
            begin 
                if ( hold_sd == 1'b1 ) 
                begin
                    break_rd <= break_rd;
                end
                else
                begin 
                    break_rd <= break_xd;
                end
            end
            if ( bubble_sd == 1'b1 ) 
            begin
                syscall_rd <= 1'b0;
            end
            else
            begin 
                if ( hold_sd == 1'b1 ) 
                begin
                    syscall_rd <= syscall_rd;
                end
                else
                begin 
                    syscall_rd <= syscall_xd;
                end
            end
            if ( bubble_sd == 1'b1 ) 
            begin
                rsvdins_rd <= 1'b0;
            end
            else
            begin 
                if ( hold_sd == 1'b1 ) 
                begin
                    rsvdins_rd <= rsvdins_rd;
                end
                else
                begin 
                    rsvdins_rd <= rsvdins_xd;
                end
            end
            if ( bubble_sd == 1'b1 ) 
            begin
                cpunuse_rd <= 1'b0;
            end
            else
            begin 
                if ( hold_sd == 1'b1 ) 
                begin
                    cpunuse_rd <= cpunuse_rd;
                end
                else
                begin 
                    cpunuse_rd <= cpunuse_xd;
                end
            end
            if ( bubble_sd == 1'b1 ) 
            begin
                iabuser_rd <= 1'b0;
            end
            else
            begin 
                if ( hold_sd == 1'b1 ) 
                begin
                    iabuser_rd <= iabuser_rd;
                end
                else
                begin 
                    iabuser_rd <= iabuser_ri;
                end
            end
            if ( bubble_sd == 1'b1 ) 
            begin
                iamalgn_rd <= 1'b0;
            end
            else
            begin 
                if ( hold_sd == 1'b1 ) 
                begin
                    iamalgn_rd <= iamalgn_rd;
                end
                else
                begin 
                    iamalgn_rd <= iamalgn_ri;
                end
            end
            if ( bubble_sd == 1'b1 ) 
            begin
                iasviol_rd <= 1'b0;
            end
            else
            begin 
                if ( hold_sd == 1'b1 ) 
                begin
                    iasviol_rd <= iasviol_rd;
                end
                else
                begin 
                    iasviol_rd <= iasviol_ri;
                end
            end
            if ( reset_rx == 1'b1 ) 
            begin
                nextpc_rd <= nextpc_xx;
            end
            else
            begin 
                if ( excrq_xm == 1'b1 ) 
                begin
                    nextpc_rd <= nextpc_xm;
                end
                else
                begin 
                    if ( keep_sd == 1'b1 ) 
                    begin
                        nextpc_rd <= nextpc_rd;
                    end
                    else
                    begin 
                        nextpc_rd <= nextpc_sd;
                    end
                end
            end
            if ( hold_sd == 1'b1 ) 
            begin
                pc_rd <= pc_rd;
            end
            else
            begin 
                pc_rd <= pc_ri;
            end
            if ( keep_sd == 1'b1 ) 
            begin
                soper_rd <= soper_se;
            end
            else
            begin 
                soper_rd <= soper_sd;
            end
            if ( keep_sd == 1'b1 ) 
            begin
                toper_rd <= toper_se;
            end
            else
            begin 
                toper_rd <= toper_sd;
            end
            if ( keep_sd == 1'b1 ) 
            begin
                ioper_rd <= ioper_rd;
            end
            else
            begin 
                ioper_rd <= ioper_sd;
            end
            if ( keep_sd == 1'b1 ) 
            begin
                sham_rd <= sham_rd;
            end
            else
            begin 
                sham_rd <= sham_sd;
            end
            if ( keep_sd == 1'b1 ) 
            begin
                cpnbr_rd <= cpnbr_rd;
            end
            else
            begin 
                cpnbr_rd <= cpnbr_xd;
            end
        end
    end
    always @ (  posedge ck)
    begin : EXE_CYCLE
        if ( ck ) 
        begin
            if ( bubble_se == 1'b1 ) 
            begin
                i_re <= 8'b00000000;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    i_re <= i_re;
                end
                else
                begin 
                    i_re <= i_rd;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                i_type_re <= nop_type;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    i_type_re <= i_type_re;
                end
                else
                begin 
                    i_type_re <= i_type_rd;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                opcod_re <= 9'b000000000;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    opcod_re <= opcod_re;
                end
                else
                begin 
                    opcod_re <= opcod_rd;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                bdslot_re <= bdslot_rd;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    bdslot_re <= bdslot_re;
                end
                else
                begin 
                    bdslot_re <= bdslot_rd;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                rt_re <= 5'b00000;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    rt_re <= rt_re;
                end
                else
                begin 
                    rt_re <= rt_rd;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                rd_re <= 5'b00000;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    rd_re <= rd_re;
                end
                else
                begin 
                    rd_re <= rd_se;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                cop0d_re <= 8'b00000000;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    cop0d_re <= cop0d_re;
                end
                else
                begin 
                    cop0d_re <= cop0d_rd;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                ovrf_re <= 1'b0;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    ovrf_re <= ovrf_re;
                end
                else
                begin 
                    ovrf_re <= ovrf_xe;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                irq_re <= 1'b1;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    irq_re <= irq_re;
                end
                else
                begin 
                    irq_re <= irq_se;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                drq_re <= 1'b0;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    drq_re <= drq_re;
                end
                else
                begin 
                    drq_re <= drq_se;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                drstlk_re <= 1'b0;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    drstlk_re <= drstlk_re;
                end
                else
                begin 
                    drstlk_re <= drstlk_se;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                dsync_re <= 1'b0;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    dsync_re <= dsync_re;
                end
                else
                begin 
                    dsync_re <= dsync_se;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                dcache_re <= 1'b0;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    dcache_re <= dcache_re;
                end
                else
                begin 
                    dcache_re <= dcache_se;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                bytsel_re <= 4'b0000;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    bytsel_re <= bytsel_re;
                end
                else
                begin 
                    bytsel_re <= bytsel_se;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                write_re <= 1'b0;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    write_re <= write_re;
                end
                else
                begin 
                    write_re <= write_se;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                read_re <= 1'b0;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    read_re <= read_re;
                end
                else
                begin 
                    read_re <= read_se;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                iamalgn_re <= 1'b0;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    iamalgn_re <= iamalgn_re;
                end
                else
                begin 
                    iamalgn_re <= iamalgn_rd;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                iasviol_re <= 1'b0;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    iasviol_re <= iasviol_re;
                end
                else
                begin 
                    iasviol_re <= iasviol_rd;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                lamalgn_re <= 1'b0;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    lamalgn_re <= lamalgn_re;
                end
                else
                begin 
                    lamalgn_re <= lamalgn_xe;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                lasviol_re <= 1'b0;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    lasviol_re <= lasviol_re;
                end
                else
                begin 
                    lasviol_re <= lasviol_xe;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                samalgn_re <= 1'b0;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    samalgn_re <= samalgn_re;
                end
                else
                begin 
                    samalgn_re <= samalgn_xe;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                sasviol_re <= 1'b0;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    sasviol_re <= sasviol_re;
                end
                else
                begin 
                    sasviol_re <= sasviol_xe;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                iabuser_re <= 1'b0;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    iabuser_re <= iabuser_re;
                end
                else
                begin 
                    iabuser_re <= iabuser_rd;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                trap_re <= 1'b0;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    trap_re <= trap_re;
                end
                else
                begin 
                    trap_re <= trap_xe;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                break_re <= 1'b0;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    break_re <= break_re;
                end
                else
                begin 
                    break_re <= break_rd;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                syscall_re <= 1'b0;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    syscall_re <= syscall_re;
                end
                else
                begin 
                    syscall_re <= syscall_rd;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                rsvdins_re <= 1'b0;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    rsvdins_re <= rsvdins_re;
                end
                else
                begin 
                    rsvdins_re <= rsvdins_rd;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                cpunuse_re <= 1'b0;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    cpunuse_re <= cpunuse_re;
                end
                else
                begin 
                    cpunuse_re <= cpunuse_rd;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                earlyex_re <= 1'b0;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    earlyex_re <= earlyex_re;
                end
                else
                begin 
                    earlyex_re <= earlyex_xe;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                zminv_re <= 1'b0;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    zminv_re <= zminv_re;
                end
                else
                begin 
                    zminv_re <= zminv_se;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                mic_re <= 3'b000;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    mic_re <= mic_re;
                end
                else
                begin 
                    mic_re <= nextmic_se;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                micend_re <= 1'b1;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    micend_re <= micend_re;
                end
                else
                begin 
                    micend_re <= micend_se;
                end
            end
            if ( bubble_se == 1'b1 ) 
            begin
                miclst_re <= 1'b0;
            end
            else
            begin 
                if ( hold_se == 1'b1 ) 
                begin
                    miclst_re <= miclst_re;
                end
                else
                begin 
                    miclst_re <= miclst_se;
                end
            end
            if ( hold_se == 1'b1 ) 
            begin
                pc_re <= pc_re;
            end
            else
            begin 
                pc_re <= pc_rd;
            end
            if ( keep_se == 1'b1 ) 
            begin
                nextpc_re <= nextpc_re;
            end
            else
            begin 
                nextpc_re <= nextpc_rd;
            end
            if ( keep_se == 1'b1 ) 
            begin
                res_re <= res_re;
            end
            else
            begin 
                res_re <= res_se;
            end
            if ( keep_se == 1'b1 ) 
            begin
                data_re <= data_re;
            end
            else
            begin 
                data_re <= data_se;
            end
            if ( keep_se == 1'b1 ) 
            begin
                cpnbr_re <= cpnbr_re;
            end
            else
            begin 
                cpnbr_re <= cpnbr_rd;
            end
            if ( keep_se == 1'b1 ) 
            begin
                c05mul1_re <= c05mul1_re;
            end
            else
            begin 
                c05mul1_re <= c05mul1_se;
            end
            if ( keep_se == 1'b1 ) 
            begin
                c07mul1_re <= c07mul1_re;
            end
            else
            begin 
                c07mul1_re <= c07mul1_se;
            end
            if ( keep_se == 1'b1 ) 
            begin
                s00mul2_re <= s00mul2_re;
            end
            else
            begin 
                s00mul2_re <= s00mul2_se;
            end
            if ( keep_se == 1'b1 ) 
            begin
                s01mul2_re <= s01mul2_re;
            end
            else
            begin 
                s01mul2_re <= s01mul2_se;
            end
            if ( keep_se == 1'b1 ) 
            begin
                s02mul2_re <= s02mul2_re;
            end
            else
            begin 
                s02mul2_re <= s02mul2_se;
            end
            if ( keep_se == 1'b1 ) 
            begin
                s03mul2_re <= s03mul2_re;
            end
            else
            begin 
                s03mul2_re <= s03mul2_se;
            end
            if ( keep_se == 1'b1 ) 
            begin
                s04mul2_re <= s04mul2_re;
            end
            else
            begin 
                s04mul2_re <= s04mul2_se;
            end
            if ( keep_se == 1'b1 ) 
            begin
                c00mul2_re <= c00mul2_re;
            end
            else
            begin 
                c00mul2_re <= c00mul2_se;
            end
            if ( keep_se == 1'b1 ) 
            begin
                c01mul2_re <= c01mul2_re;
            end
            else
            begin 
                c01mul2_re <= c01mul2_se;
            end
            if ( keep_se == 1'b1 ) 
            begin
                c02mul2_re <= c02mul2_re;
            end
            else
            begin 
                c02mul2_re <= c02mul2_se;
            end
            if ( keep_se == 1'b1 ) 
            begin
                c03mul2_re <= c03mul2_re;
            end
            else
            begin 
                c03mul2_re <= c03mul2_se;
            end
            if ( keep_se == 1'b1 ) 
            begin
                c04mul2_re <= c04mul2_re;
            end
            else
            begin 
                c04mul2_re <= c04mul2_se;
            end
            if ( keep_se == 1'b1 ) 
            begin
                divx_re <= divx_re;
            end
            else
            begin 
                divx_re <= divx_se;
            end
            if ( keep_se == 1'b1 ) 
            begin
                divxclz_re <= divxclz_re;
            end
            else
            begin 
                divxclz_re <= divxclz_se;
            end
            if ( keep_se == 1'b1 ) 
            begin
                divy_re <= divy_re;
            end
            else
            begin 
                divy_re <= divy_se;
            end
            if ( keep_se == 1'b1 ) 
            begin
                divyclz_re <= divyclz_re;
            end
            else
            begin 
                divyclz_re <= divyclz_se;
            end
            if ( keep_se == 1'b1 ) 
            begin
                divq_re <= divq_re;
            end
            else
            begin 
                divq_re <= divq_se;
            end
        end
    end
    always @ (  posedge ck)
    begin : REDOPC
        if ( ck ) 
        begin
            if ( keep_se == 1'b1 ) 
            begin
                redopc_re <= redopc_re;
            end
            else
            begin 
                if ( wredopc_se == 1'b0 ) 
                begin
                    redopc_re <= redopc_re;
                end
                else
                begin 
                    redopc_re <= pc_rd;
                end
            end
        end
    end
    always @ (  posedge ck)
    begin : MEM_CYCLE
        if ( ck ) 
        begin
            if ( bubble_sm == 1'b1 ) 
            begin
                i_rm <= 8'b00000000;
            end
            else
            begin 
                if ( hold_sm == 1'b1 ) 
                begin
                    i_rm <= i_rm;
                end
                else
                begin 
                    i_rm <= i_re;
                end
            end
            if ( bubble_sm == 1'b1 ) 
            begin
                dread_rm <= 1'b0;
            end
            else
            begin 
                if ( hold_sm == 1'b1 ) 
                begin
                    dread_rm <= 1'b0;
                end
                else
                begin 
                    dread_rm <= read_re;
                end
            end
            if ( bubble_sm == 1'b1 ) 
            begin
                i_type_rm <= nop_type;
            end
            else
            begin 
                if ( hold_sm == 1'b1 ) 
                begin
                    i_type_rm <= i_type_rm;
                end
                else
                begin 
                    i_type_rm <= i_type_re;
                end
            end
            if ( bubble_sm == 1'b1 ) 
            begin
                rd_rm <= 5'b00000;
            end
            else
            begin 
                if ( hold_sm == 1'b1 ) 
                begin
                    rd_rm <= rd_rm;
                end
                else
                begin 
                    rd_rm <= rd_sm;
                end
            end
            if ( bubble_sm == 1'b1 ) 
            begin
                opcod_rm <= 9'b000000000;
            end
            else
            begin 
                if ( hold_sm == 1'b1 ) 
                begin
                    opcod_rm <= opcod_rm;
                end
                else
                begin 
                    opcod_rm <= opcod_re;
                end
            end
            if ( bubble_sm == 1'b1 ) 
            begin
                zminv_rm <= 1'b0;
            end
            else
            begin 
                if ( hold_sm == 1'b1 ) 
                begin
                    zminv_rm <= zminv_rm;
                end
                else
                begin 
                    zminv_rm <= zminv_re;
                end
            end
            if ( keep_sm == 1'b1 ) 
            begin
                s00mul7_rm <= s00mul7_rm;
            end
            else
            begin 
                s00mul7_rm <= s00mul7_sm;
            end
            if ( keep_sm == 1'b1 ) 
            begin
                c00mul7_rm <= c00mul7_rm;
            end
            else
            begin 
                c00mul7_rm <= c00mul7_sm;
            end
            if ( keep_sm == 1'b1 ) 
            begin
                data_rm <= data_rm;
            end
            else
            begin 
                data_rm <= data_sm;
            end
            if ( keep_sm == 1'b1 ) 
            begin
                divq_rm <= divq_rm;
            end
            else
            begin 
                divq_rm <= divq_re;
            end
            if ( keep_sm == 1'b1 ) 
            begin
                divr_rm <= divr_rm;
            end
            else
            begin 
                divr_rm <= divx_re;
            end
        end
    end
    always @ (  posedge ck)
    begin : COP0_REGISTERS
        if ( ck ) 
        begin
            if ( wbadda_xm == 1'b1 ) 
            begin
                badva_rx <= res_re;
            end
            else
            begin 
                if ( wbadia_xm == 1'b1 ) 
                begin
                    badva_rx <= nextpc_re;
                end
                else
                begin 
                    badva_rx <= badva_rx;
                end
            end
            if ( webase_xx == 1'b1 ) 
            begin
                ebase_rm <= ebase_xx;
            end
            else
            begin 
                if ( ( webase_sm == 1'b1 ) & ( keep_sm == 1'b0 ) ) 
                begin
                    ebase_rm <= ebase_sm;
                end
                else
                begin 
                    ebase_rm <= ebase_rm;
                end
            end
            if ( wcause_xx == 1'b1 ) 
            begin
                cause_rx <= cause_xx;
            end
            else
            begin 
                if ( wcause_xm == 1'b1 ) 
                begin
                    cause_rx <= cause_xm;
                end
                else
                begin 
                    if ( ( wcause_sm == 1'b1 ) & ( keep_sm == 1'b0 ) ) 
                    begin
                        cause_rx <= cause_sm;
                    end
                    else
                    begin 
                        cause_rx <= cause_sx;
                    end
                end
            end
            if ( wepc_xm == 1'b1 ) 
            begin
                epc_rx <= epc_xm;
            end
            else
            begin 
                if ( ( wepc_sm == 1'b1 ) & ( keep_sm == 1'b0 ) ) 
                begin
                    epc_rx <= epc_sm;
                end
                else
                begin 
                    epc_rx <= epc_rx;
                end
            end
            if ( weepc_xx == 1'b1 ) 
            begin
                eepc_rx <= eepc_xx;
            end
            else
            begin 
                if ( ( weepc_sm == 1'b1 ) & ( keep_sm == 1'b0 ) ) 
                begin
                    eepc_rx <= eepc_sm;
                end
                else
                begin 
                    eepc_rx <= eepc_rx;
                end
            end
            if ( ( wcount_sm == 1'b1 ) & ( keep_sm == 1'b0 ) ) 
            begin
                count_rx <= count_sm;
            end
            else
            begin 
                if ( wcount_sx == 1'b1 ) 
                begin
                    count_rx <= count_sx;
                end
                else
                begin 
                    count_rx <= count_rx;
                end
            end
            if ( ( wtcctx_sm == 1'b1 ) & ( keep_sm == 1'b0 ) ) 
            begin
                tcctx_rm <= tcctx_sm;
            end
            else
            begin 
                tcctx_rm <= tcctx_rm;
            end
            if ( ( wusrlcl_sm == 1'b1 ) & ( keep_sm == 1'b0 ) ) 
            begin
                usrlcl_rm <= res_re;
            end
            else
            begin 
                usrlcl_rm <= usrlcl_rm;
            end
            if ( ( whwrena_sm == 1'b1 ) & ( keep_sm == 1'b0 ) ) 
            begin
                hwrena_rm <= res_re;
            end
            else
            begin 
                hwrena_rm <= hwrena_rm;
            end
            if ( wsr_xx == 1'b1 ) 
            begin
                status_rx <= status_xx;
            end
            else
            begin 
                if ( wsr_xm == 1'b1 ) 
                begin
                    status_rx <= status_xm;
                end
                else
                begin 
                    if ( ( wsr_sm == 1'b1 ) & ( keep_sm == 1'b0 ) ) 
                    begin
                        status_rx <= status_sm;
                    end
                    else
                    begin 
                        status_rx <= status_rx;
                    end
                end
            end
        end
    end
    always @ (  posedge ck)
    begin : WBK_CYCLE
        if ( ck ) 
        begin
            if ( ( i_wlo_sw == 1'b1 ) & ( keep_sw == 1'b0 ) ) 
            begin
                lo_rw <= lo_sw;
            end
            else
            begin 
                lo_rw <= lo_rw;
            end
            if ( ( i_whi_sw == 1'b1 ) & ( keep_sw == 1'b0 ) ) 
            begin
                hi_rw <= hi_sw;
            end
            else
            begin 
                hi_rw <= hi_rw;
            end
            if ( ( rd_rm == 5'b00001 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r1_rw <= data_sw;
            end
            else
            begin 
                r1_rw <= r1_rw;
            end
            if ( ( rd_rm == 5'b00010 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r2_rw <= data_sw;
            end
            else
            begin 
                r2_rw <= r2_rw;
            end
            if ( ( rd_rm == 5'b00011 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r3_rw <= data_sw;
            end
            else
            begin 
                r3_rw <= r3_rw;
            end
            if ( ( rd_rm == 5'b00100 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r4_rw <= data_sw;
            end
            else
            begin 
                r4_rw <= r4_rw;
            end
            if ( ( rd_rm == 5'b00101 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r5_rw <= data_sw;
            end
            else
            begin 
                r5_rw <= r5_rw;
            end
            if ( ( rd_rm == 5'b00110 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r6_rw <= data_sw;
            end
            else
            begin 
                r6_rw <= r6_rw;
            end
            if ( ( rd_rm == 5'b00111 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r7_rw <= data_sw;
            end
            else
            begin 
                r7_rw <= r7_rw;
            end
            if ( ( rd_rm == 5'b01000 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r8_rw <= data_sw;
            end
            else
            begin 
                r8_rw <= r8_rw;
            end
            if ( ( rd_rm == 5'b01001 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r9_rw <= data_sw;
            end
            else
            begin 
                r9_rw <= r9_rw;
            end
            if ( ( rd_rm == 5'b01010 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r10_rw <= data_sw;
            end
            else
            begin 
                r10_rw <= r10_rw;
            end
            if ( ( rd_rm == 5'b01011 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r11_rw <= data_sw;
            end
            else
            begin 
                r11_rw <= r11_rw;
            end
            if ( ( rd_rm == 5'b01100 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r12_rw <= data_sw;
            end
            else
            begin 
                r12_rw <= r12_rw;
            end
            if ( ( rd_rm == 5'b01101 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r13_rw <= data_sw;
            end
            else
            begin 
                r13_rw <= r13_rw;
            end
            if ( ( rd_rm == 5'b01110 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r14_rw <= data_sw;
            end
            else
            begin 
                r14_rw <= r14_rw;
            end
            if ( ( rd_rm == 5'b01111 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r15_rw <= data_sw;
            end
            else
            begin 
                r15_rw <= r15_rw;
            end
            if ( ( rd_rm == 5'b10000 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r16_rw <= data_sw;
            end
            else
            begin 
                r16_rw <= r16_rw;
            end
            if ( ( rd_rm == 5'b10001 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r17_rw <= data_sw;
            end
            else
            begin 
                r17_rw <= r17_rw;
            end
            if ( ( rd_rm == 5'b10010 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r18_rw <= data_sw;
            end
            else
            begin 
                r18_rw <= r18_rw;
            end
            if ( ( rd_rm == 5'b10011 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r19_rw <= data_sw;
            end
            else
            begin 
                r19_rw <= r19_rw;
            end
            if ( ( rd_rm == 5'b10100 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r20_rw <= data_sw;
            end
            else
            begin 
                r20_rw <= r20_rw;
            end
            if ( ( rd_rm == 5'b10101 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r21_rw <= data_sw;
            end
            else
            begin 
                r21_rw <= r21_rw;
            end
            if ( ( rd_rm == 5'b10110 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r22_rw <= data_sw;
            end
            else
            begin 
                r22_rw <= r22_rw;
            end
            if ( ( rd_rm == 5'b10111 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r23_rw <= data_sw;
            end
            else
            begin 
                r23_rw <= r23_rw;
            end
            if ( ( rd_rm == 5'b11000 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r24_rw <= data_sw;
            end
            else
            begin 
                r24_rw <= r24_rw;
            end
            if ( ( rd_rm == 5'b11001 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r25_rw <= data_sw;
            end
            else
            begin 
                r25_rw <= r25_rw;
            end
            if ( ( rd_rm == 5'b11010 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r26_rw <= data_sw;
            end
            else
            begin 
                r26_rw <= r26_rw;
            end
            if ( ( rd_rm == 5'b11011 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r27_rw <= data_sw;
            end
            else
            begin 
                r27_rw <= r27_rw;
            end
            if ( ( rd_rm == 5'b11100 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r28_rw <= data_sw;
            end
            else
            begin 
                r28_rw <= r28_rw;
            end
            if ( ( rd_rm == 5'b11101 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r29_rw <= data_sw;
            end
            else
            begin 
                r29_rw <= r29_rw;
            end
            if ( ( rd_rm == 5'b11110 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r30_rw <= data_sw;
            end
            else
            begin 
                r30_rw <= r30_rw;
            end
            if ( ( rd_rm == 5'b11111 ) & ( keep_sw == 1'b0 ) ) 
            begin
                r31_rw <= data_sw;
            end
            else
            begin 
                r31_rw <= r31_rw;
            end
        end
    end
    always @ (  posedge ck)
    begin : MISCELLANEOUS
        if ( ck ) 
        begin
            reset_rx <=  ~( reset_n);
            hwswit_rx <= hwswit_xx;
            intrq_rx <= intrq_xx;
            if ( reset_rx == 1'b0 ) 
            begin
                mcheck_rx <=  ~( mcheck_n);
            end
            else
            begin 
                mcheck_rx <= 1'b0;
            end
            mcheckx_rx <= mcheckx_xx;
        end
    end
    always @ (  irq_re or  irq_se)
    begin
        if ( bubble_se == 1'b1 ) 
        begin
            i_rq <= 1'b1;
        end
        else
        begin 
            if ( hold_se == 1'b1 ) 
            begin
                i_rq <= irq_re;
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:5779 
                begin
                    i_rq <= irq_se;
                end
            end
        end
    end
    assign i_beren = iberen_sx;
    always @ (  nextpc_xx or  nextpc_xm or  nextpc_rd or  nextpc_sd)
    begin
        if ( reset_rx == 1'b1 ) 
        begin
            i_a <= nextpc_xx[31:2];
        end
        else
        begin 
            if ( excrq_xm == 1'b1 ) 
            begin
                i_a <= nextpc_xm[31:2];
            end
            else
            begin 
                if ( keep_sd == 1'b1 ) 
                begin
                    i_a <= nextpc_rd[31:2];
                end
                else
                begin 
                    if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:5790 
                    begin
                        i_a <= nextpc_sd[31:2];
                    end
                end
            end
        end
    end
    always @ (  iinlin_sd)
    begin
        if ( reset_rx == 1'b1 ) 
        begin
            i_inline <= 1'b0;
        end
        else
        begin 
            if ( excrq_xm == 1'b1 ) 
            begin
                i_inline <= 1'b0;
            end
            else
            begin 
                if ( keep_sd == 1'b1 ) 
                begin
                    i_inline <= 1'b0;
                end
                else
                begin 
                    if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:5800 
                    begin
                        i_inline <= iinlin_sd;
                    end
                end
            end
        end
    end
    always @ (  status_rx)
    begin
        if ( status_rx[1] == 1'b1 ) 
        begin
            i_mode <= 2'b00;
        end
        else
        begin 
            if ( status_rx[2] == 1'b1 ) 
            begin
                i_mode <= 2'b00;
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:5812 
                begin
                    i_mode <= status_rx[4:3];
                end
            end
        end
    end
    assign i_ack = iread_ri;
    always @ (  res_re or  rarith_se)
    begin
        if ( keep_se == 1'b1 ) 
        begin
            d_a <= res_re[31:2];
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:5834 
            begin
                d_a <= rarith_se[31:2];
            end
        end
    end
    always @ (  data_re or  data_se)
    begin
        if ( keep_se == 1'b1 ) 
        begin
            d_out <= data_re;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:5837 
            begin
                d_out <= data_se;
            end
        end
    end
    always 
    begin
        if ( bubble_se == 1'b1 ) 
        begin
            d_rw <= 1'b1;
        end
        else
        begin 
            if ( hold_se == 1'b1 ) 
            begin
                d_rw <=  ~( write_re);
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:5840 
                begin
                    d_rw <=  ~( write_se);
                end
            end
        end
    end
    always @ (  bytsel_re or  bytsel_se)
    begin
        if ( bubble_se == 1'b1 ) 
        begin
            d_bytsel <= 4'b0000;
        end
        else
        begin 
            if ( hold_se == 1'b1 ) 
            begin
                d_bytsel <= bytsel_re;
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:5844 
                begin
                    d_bytsel <= bytsel_se;
                end
            end
        end
    end
    always @ (  drq_re or  drq_se)
    begin
        if ( bubble_se == 1'b1 ) 
        begin
            d_rq <= 1'b0;
        end
        else
        begin 
            if ( hold_se == 1'b1 ) 
            begin
                d_rq <= drq_re;
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:5856 
                begin
                    d_rq <= drq_se;
                end
            end
        end
    end
    always @ (  drstlk_re or  drstlk_se)
    begin
        if ( bubble_se == 1'b1 ) 
        begin
            d_rstlkd <= 1'b0;
        end
        else
        begin 
            if ( hold_se == 1'b1 ) 
            begin
                d_rstlkd <= drstlk_re;
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:5860 
                begin
                    d_rstlkd <= drstlk_se;
                end
            end
        end
    end
    always @ (  dsync_re or  dsync_se)
    begin
        if ( bubble_se == 1'b1 ) 
        begin
            d_sync <= 1'b0;
        end
        else
        begin 
            if ( hold_se == 1'b1 ) 
            begin
                d_sync <= dsync_re;
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:5864 
                begin
                    d_sync <= dsync_se;
                end
            end
        end
    end
    always @ (  dcache_re or  dcache_se)
    begin
        if ( bubble_se == 1'b1 ) 
        begin
            d_cache <= 1'b0;
        end
        else
        begin 
            if ( hold_se == 1'b1 ) 
            begin
                d_cache <= dcache_re;
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:5868 
                begin
                    d_cache <= dcache_se;
                end
            end
        end
    end
    always @ (  i_linkd_sm or  i_linkd_se)
    begin
        if ( bubble_se == 1'b1 ) 
        begin
            d_linked <= 1'b0;
        end
        else
        begin 
            if ( hold_se == 1'b1 ) 
            begin
                d_linked <= i_linkd_sm;
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:5880 
                begin
                    d_linked <= i_linkd_se;
                end
            end
        end
    end
    always @ (  i_xreg_sm or  i_xreg_se)
    begin
        if ( bubble_se == 1'b1 ) 
        begin
            d_reg <= 1'b0;
        end
        else
        begin 
            if ( hold_se == 1'b1 ) 
            begin
                d_reg <= i_xreg_sm;
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:5884 
                begin
                    d_reg <= i_xreg_se;
                end
            end
        end
    end
    always @ (  cachop_sm or  cachop_se)
    begin
        if ( keep_se == 1'b1 ) 
        begin
            d_cachop <= cachop_sm;
        end
        else
        begin 
            if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:5888 
            begin
                d_cachop <= cachop_se;
            end
        end
    end
    always @ (  status_rx)
    begin
        if ( status_rx[1] == 1'b1 ) 
        begin
            d_mode <= 2'b00;
        end
        else
        begin 
            if ( status_rx[2] == 1'b1 ) 
            begin
                d_mode <= 2'b00;
            end
            else
            begin 
                if ( 1 ) // edautils Note : Review the 'if' condition. This is correct if it corresponds to the last 'else' section of the conditional concurrent signal assignment at /dsk/l1/jpc/coriolis-2.x/src/alliance-check-toolkit/benchs/MIPS/MIPS32/mips_32_1p_mul_div.vhd:5899 
                begin
                    d_mode <= status_rx[4:3];
                end
            end
        end
    end
    assign d_ack = dread_rm;
    assign scout = 1'b0;
endmodule 
