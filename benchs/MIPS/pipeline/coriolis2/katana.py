
from coriolis.Hurricane import DebugSession

#DebugSession.addToTrace( katana.getCell().getNet( 'rsdnbr_sd(16)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'hz_tdm_sd' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'ck' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'mips_r3000_1m_dp_badr_sd(31)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'mips_r3000_1m_dp_otheri_sd(0)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'wreg_sw(4)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'mips_r3000_1m_dp_xor_se(0)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'mips_r3000_1m_dp_banc_dinx(10)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'wreg_sw(13)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'wreg_sw(14)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'mips_r3000_1m_dp_shift32_rshift_se_c0(2)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'mips_r3000_1m_ct_not_hold_si)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'mips_r3000_1m_dp_shift32_rshift_se_muxoutput(112)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'mips_r3000_1m_dp_res_re(30)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'mips_r3000_1m_dp_yoper_se(4)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'mips_r3000_1m_dp_nextpc_rd(0)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'mips_r3000_1m_dp_banc_dinx(27)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'rsdnbr_sd(22)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'mips_r3000_1m_ct_bdslot_rd' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'rtdnbr_sd(21)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'mips_r3000_1m_dp_banc_dinx(31)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'rtdnbr_sd(2)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'mips_r3000_1m_dp_mux32_s_mw_se_sel0' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'rtdnbr_sd(11)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'wreg_sw(11)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'rtdnbr_sd(12)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'rtdnbr_sd(15)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'mips_r3000_1m_dp_shift32_rshift_se_msb' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'mips_r3000_1m_ct_ao22_x2_54_sig' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'mips_r3000_1m_dp_toper_rd(4)' ) )
#In topology of &<id:260936 ContactTerminal mips_r3000_1m_dp_instseqadr_sd_pi_0_12 VIA12 [3165.0L 610.0L] 1.0L x 1.0L -T------->
#  A: &<id:104364 RoutingPad mips_r3000_1m_dp_instseqadr_sd_pi_0_12 [3165.0L 625.0L] Sh--- <Occurrence <id:120 Cell mips_r3000_1m_core_flat>:mips_r3000_1m_dp_instseqadr_sd_pg_i1_1_13:<id:5832 Vertical i0 METAL1 [5.0L 15.0L] [5.0L 35.0L] 2.0L>>>
#  G: &<id:210336 Horizontal mips_r3000_1m_dp_instseqadr_sd_pi_0_12 METAL2 [3165.0L 610.0L] [3225.0L 610.0L] 2.0L rpD:0 bl:0 -----U-G--T------i----bt-- [3164.0L:3226.0L]>
#  No verticals connecteds
#  Terminal horizontal segment Y 610.0L axis is outside RoutingPad [615.0L 635.0L].
#  Segment constraints: [615.0L 635.0L]
#DebugSession.addToTrace( katana.getCell().getNet( 'mips_r3000_1m_dp_instseqadr_sd_pi_0_12' ) )
# [ERROR] AutoContactTerminal::getNativeConstraintBox(): Empty native constraints.
#         On: <id:289705 ContactTerminal load_se VIA12 [2185.0L 1685.0L] 1.0L x 1.0L -T-----c->
# --> dp_sff_x4_buf wen
#DebugSession.addToTrace( katana.getCell().getNet( 'load_se' ) )
# [ERROR] TrackSegment::getFreeInterval(): Segment not found in it's assigned track.
#         * <VerticalTrack [18] METAL3 @90.0L [-3.5L:2953.5L] [1/1]> 
#         * <id:390860 Vertical mips_r3000_1m_dp_banc_dinx(0) METAL3 [94.0L 10.0L] [94.0L 10.0L] 2.0L rpD:0 bl:0 F-----C---T-----------bb-- [9.0L:11.0L] [9.0L:11.0L] 2.0L -F----T--->
#DebugSession.addToTrace( katana.getCell().getNet( 'mips_r3000_1m_dp_banc_dinx(0)' ) )
# ERROR] TrackSegment::getFreeInterval(): Segment not found in it's assigned track. 
#         * <VerticalTrack [242] METAL3 @1210.0L [-3.5L:2953.5L] [0/0]> 
#         * <id:325919 Vertical mips_r3000_1m_dp_banc_nck METAL3 [1212.5L 1690.0L] [1212.5L 1690.0L] 2.0L rpD:0 bl:0 F-----C---T-----------bb-- [1689.0L:1691.0L] [1689.0L:1691.0L] 2.0L -F----T--->
#DebugSession.addToTrace( katana.getCell().getNet( 'mips_r3000_1m_dp_banc_nck' ) )


