
from Hurricane import DebugSession

# Problem of shifted minimum size area segment.
#  id:2727812 [762.96um 1666.23um]
#DebugSession.addToTrace( katana.getCell().getNet( 'subckt_195_paramod_8a8b45b7eb1cbc4ddab9c094bf37a8ebd8aaf536_eth_wishbone.subckt_2501_eth_spram_256x32.mem0_rdreg_0_q_0_hfns_80' ) )

#DebugSession.addToTrace( katana.getCell().getNet( 'm_wb_dat_o(31)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'subckt_195_paramod_8a8b45b7eb1cbc4ddab9c094bf37a8ebd8aaf536_eth_wishbone.subckt_2501_eth_spram_256x32.mem0_rdreg_0_q_2_hfns_121' ) )

# wb_dat_i_bit1_hfns_0
# On <id:2546857 Horizontal wb_dat_i_bit1_hfns_0 METAL2 [860.505um 751.74um]
#DebugSession.addToTrace( katana.getCell().getNet( 'wb_dat_i_bit1_hfns_0' ) )

# Horizontal wb_clk_i_hfns_199 METAL4 [249.28um 2554.86um] [249.48um 2554.86um] 0.38um
#DebugSession.addToTrace( katana.getCell().getNet( 'wb_clk_i_hfns_199' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'wb_clk_i_hfns_326' ) )

# ERROR] Below minimal length/area for <id:1341879 Horizontal subckt_195_paramod_8a8b45b7eb1cbc4ddab9c094bf37a8ebd8aaf536_eth_wishbone.subckt_2501_eth_spram_256x32.mem0_rdreg_0_q_0_hfns_78
# METAL4 [2226.04um 2333.76um] [2226.18um 2333.76um] 0.38um 
#DebugSession.addToTrace( katana.getCell().getNet( 'subckt_195_paramod_8a8b45b7eb1cbc4ddab9c094bf37a8ebd8aaf536_eth_wishbone.subckt_2501_eth_spram_256x32.mem0_rdreg_0_q_0_hfns_78' ) )

#[ERROR] Below minimal length/area for <id:2454703 Vertical wb_dat_o(29) METAL3 [7.92um 422.21um] [7.92um 422.65um] 0.38um
#  length:0.44um, minimal length:0.54um
#DebugSession.addToTrace( katana.getCell().getNet( 'wb_dat_o(29)' ) )

# [ERROR] Overlap in <HorizontalTrack [3450] METAL2 @2277um [-0.52um:2600.52um] [196/256]> between:
#   METAL2 [2151.25um 2277um] [2152.15um 2277um] 0.38um
#DebugSession.addToTrace( katana.getCell().getNet( 'subckt_195_paramod_8a8b45b7eb1cbc4ddab9c094bf37a8ebd8aaf536_eth_wishbone.subckt_2501_eth_spram_256x32.abc_97718_new_n18044' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'subckt_195_paramod_8a8b45b7eb1cbc4ddab9c094bf37a8ebd8aaf536_eth_wishbone.subckt_2501_eth_spram_256x32.abc_97718_new_n18042' ) )

# [ERROR] Below minimal length/area for <id:2546822 Horizontal wb_dat_i_bit1_hfns_2 METAL2 [649.35um 36.96um] [649.44um 36.96um] 0.38um
#DebugSession.addToTrace( katana.getCell().getNet( 'wb_dat_i_bit1_hfns_2' ) )

# <id:1362550 Horizontal subckt_194_eth_txethmac.subckt_149_eth_txcounters.abc_114483_new_n258 METAL2 [1098.9um 75.24um] [1130.35um 75.24um] 0.38um
#   @(1098,75)
#DebugSession.addToTrace( katana.getCell().getNet( 'subckt_194_eth_txethmac.subckt_149_eth_txcounters.abc_114483_new_n258' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'wb_rst_i_hfns_7' ) )

# [ERROR] Below minimal length/area for <id:2757741 Horizontal subckt_195_paramod_8a8b45b7eb1cbc4ddab9c094bf37a8ebd8aaf536_eth_wishbone.subckt_2501_eth_spram_256x32.abc_97718_new_n23540 METAL4
#    [918.06um 1532.52um] [918.08um 1532.52um] 0.38um
#    length:0.3um, minimal length:0.54um 
#DebugSession.addToTrace( katana.getCell().getNet( 'subckt_195_paramod_8a8b45b7eb1cbc4ddab9c094bf37a8ebd8aaf536_eth_wishbone.subckt_2501_eth_spram_256x32.abc_97718_new_n23540' ) )


# @(1308,2291)
#DebugSession.addToTrace( katana.getCell().getNet( 'wb_clk_i_hfns_253' ) )

# @(0,539)
#DebugSession.addToTrace( katana.getCell().getNet( 'wb_sel_i(3)' ) )

#DebugSession.addToTrace( katana.getCell().getNet( 'wb_clk_i_hfns_34' ) )

# @(8,19)
#DebugSession.addToTrace( katana.getCell().getNet( 'wb_dat_i(0)' ) )

# Stupid M2 V not routed @(2594,726)
# id:2227882 mcrs_pad_i M3 badly postioned.
# DebugSession.addToTrace( katana.getCell().getNet( 'mcrs_pad_i' ) )
# DebugSession.addToTrace( katana.getCell().getNet( 'subckt_195_paramod_8a8b45b7eb1cbc4ddab9c094bf37a8ebd8aaf536_eth_wishbone.subckt_2501_eth_spram_256x32.abc_97718_auto_rtlil_cc_2515_muxgate_86497' ) )

# With clock tree on "wb_clk_i" but no HFNS.
# [ERROR] Overlap in <VerticalTrack [629] METAL3 @415.14um [-0.52um:2600.52um] [26/32]> between:
#   <id:1427798 Vertical subckt_195_paramod_8a8b45b7eb1cbc4ddab9c094bf37a8ebd8aaf536_eth_wishbone.subckt_2503_paramod_0c2657bd5c5455bdd610d1f801789b00c2352910_eth_fifo.write_pointer(0) METAL3 [415.14um 777.48um] [415.14um 804.54um] 0.38um rpD:2 ------CG-----w-----bb-- [776.94um:805.08um] 28.14um 0 ---T--->
#   <id:1297113 Vertical subckt_195_paramod_8a8b45b7eb1cbc4ddab9c094bf37a8ebd8aaf536_eth_wishbone.subckt_2503_paramod_0c2657bd5c5455bdd610d1f801789b00c2352910_eth_fifo.abc_91722_new_n1940 METAL3 [415.14um 805.2um] [415.14um 835.56um] 0.38um rpD:2 ------CG-----w-----bb-M [804.92um:835.84um] 30.92um 0 ---T--->
#   TargetU:805.08um SourceU:804.92um

# Missing HFNS driver on top level of the tree.
#DebugSession.addToTrace( katana.getCell().getNet( 'loadrxstatus' ) )

#[ERROR] Overlap in <VerticalTrack [629] METAL3 @415.14um [-0.52um:2600.52um] [26/32]> between:
#  <id:1427798 Vertical subckt_195_paramod_8a8b45b7eb1cbc4ddab9c094bf37a8ebd8aaf536_eth_wishbone.subckt_2503_paramod_0c2657bd5c5455bdd610d1f801789b00c2352910_eth_fifo.write_pointer(0) METAL3 [415.14um 777.48um] [415.14um 804.54um] 0.38um rpD:2 ------CG-----w-----bb-- [776.94um:805.08um] 28.14um 0 ---T--->
#  <id:1297113 Vertical subckt_195_paramod_8a8b45b7eb1cbc4ddab9c094bf37a8ebd8aaf536_eth_wishbone.subckt_2503_paramod_0c2657bd5c5455bdd610d1f801789b00c2352910_eth_fifo.abc_91722_new_n1940 METAL3 [415.14um 805.2um] [415.14um 835.56um] 0.38um rpD:2 ------CG-----w-----bb-M [804.92um:835.84um] 30.92um 0 ---T--->
#  TargetU:805.08um SourceU:804.92um
#DebugSession.addToTrace( katana.getCell().getNet( 'subckt_195_paramod_8a8b45b7eb1cbc4ddab9c094bf37a8ebd8aaf536_eth_wishbone.subckt_2503_paramod_0c2657bd5c5455bdd610d1f801789b00c2352910_eth_fifo.write_pointer(0)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'subckt_195_paramod_8a8b45b7eb1cbc4ddab9c094bf37a8ebd8aaf536_eth_wishbone.subckt_2503_paramod_0c2657bd5c5455bdd610d1f801789b00c2352910_eth_fifo.abc_91722_new_n1940 ' ) )
