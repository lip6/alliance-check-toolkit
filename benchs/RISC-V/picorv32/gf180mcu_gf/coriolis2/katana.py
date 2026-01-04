
from coriolis.Hurricane import DebugSession

# Pb <id:797784 Horizontal mem_wstrb(2) Metal2 [0.05um 344.68um]>
# Issue with the way we connect to external terminals.
# RoutingPad id:536951 shadows too great an area.
#DebugSession.addToTrace( katana.getCell().getNet( 'mem_wstrb(2)' ))
#DebugSession.addToTrace( katana.getCell().getNet( 'mem_wstrb(3)' ))
# Pb <id:852696 Horizontal pcpi_rs2(18) Metal2 [-0.19um 299.88um]>
# Issue with the way we connect to external terminals.
# RoutingPad id:621846 shadows too great an area.
#DebugSession.addToTrace( katana.getCell().getNet( 'pcpi_rs2(18)' ))
#DebugSession.addToTrace( katana.getCell().getNet( 'clk_root_bl_tl_2' ))
# Non compacted reduced segment id:854047 M3 -> M4 @(0,31).
#DebugSession.addToTrace( katana.getCell().getNet( 'pcpi_rs1(18)' ))
# Pb @(574,94) Non-optimal net building.
#DebugSession.addToTrace( katana.getCell().getNet( 'count_instr(8)' ))
#DebugSession.addToTrace( katana.getCell().getNet( 'decoded_imm_j(14)' ))
#DebugSession.addToTrace( katana.getCell().getNet( 'cpuregs_18_16' ))
# <id:812633 Vertical mem_rdata(21) Metal3 [604.8um 53.48um]
#DebugSession.addToTrace( katana.getCell().getNet( 'mem_rdata(21)' ))
# Pb @(303,159) id:833211, unconnected Metal3 -> open.
#DebugSession.addToTrace( katana.getCell().getNet( 'abc_30082_new_n3833' ))
# Pb @(449,498) RP id:542648 removed too close contact leads to gap.
#DebugSession.addToTrace( katana.getCell().getNet( 'count_cycle(0)' ))
# DRC M4.3 @(0,378)
#DebugSession.addToTrace( katana.getCell().getNet( 'pcpi_wr' ))
# Pb @(603,31) strange loop on the Metal4 terminal.
#DebugSession.addToTrace( katana.getCell().getNet( 'mem_rdata(13)' ))
# Pb @(398,43) loop in Metal2 (dual terminal access).
# RP id:559311.
#DebugSession.addToTrace( katana.getCell().getNet( 'count_cycle(62)' ))
#DebugSession.addToTrace( katana.getCell().getNet( 'cpuregs_18_22' ))
#DebugSession.addToTrace( katana.getCell().getNet( 'abc_30082_new_n7706' ))
# Pb @<id:941961 Horizontal abc_30082_new_n4179 Metal2 [318.36um 223.16um]>. 
#DebugSession.addToTrace( katana.getCell().getNet( 'abc_30082_new_n4179' ))
# Pb @<id:981204 Vertical abc_30082_new_n3703 Metal3 [306.6um 82.04um] ...>
#DebugSession.addToTrace( katana.getCell().getNet( 'abc_30082_new_n3703' ))
# Pb @<id:834274 Vertical mem_rdata(14) Metal2 [413.86um 69.16um] ...> false unrouted.
#DebugSession.addToTrace( katana.getCell().getNet( 'mem_rdata(14)' ))
# Pb @<id:933931 Horizontal abc_30082_new_n4455 Metal2 [89.51um 180.04um] ...> Too close Metal2
# id:933931 -> event:00087595
# id:989303 -> event:00087605
# Problematic event: 152477-1.
#DebugSession.addToTrace( katana.getCell().getNet( 'abc_30082_new_n4455' ))
# Check near : (90,199)
#DebugSession.addToTrace( katana.getCell().getNet( 'abc_30656_new_n4285' ))
#DebugSession.addToTrace( katana.getCell().getNet( 'abc_30656_new_n3292' ))
# Pb should not move up <id:999234 Vertical abc_30656_new_n7713 Metal3 [486.92um 430.92um] 
#DebugSession.addToTrace( katana.getCell().getNet( 'abc_30656_new_n7713' ))
# Pb unrouted <id:1016977 Horizontal abc_30656_new_n3980 Metal2 [47.88um 159.32um] ...>
#
# <event:00172781 5:228.6:1.22um> &<id:1016977 Horizontal abc_30656_new_n3980 Metal2 ...>
#   State: *before* MaximumSlack:1 ripup:0
# <event:00172790 3:4135.8:1.78um> &<id:845031 Vertical abc_30656_new_n3980 Metal3 ...>
#
#DebugSession.addToTrace( katana.getCell().getNet( 'abc_30656_new_n3980' ))
#DebugSession.addToTrace( katana.getCell().getNet( 'abc_30656_new_n4431' ))
#DebugSession.addToTrace( katana.getCell().getNet( 'abc_30656_new_n4436' ))
#DebugSession.addToTrace( katana.getCell().getNet( 'latched_rd(2)' ))
# Pb @(140,219) Metal3 minimum area
DebugSession.addToTrace( katana.getCell().getNet( 'abc_30656_new_n3346' ))
