
from Hurricane import DebugSession
from Hurricane import UpdateSession

#DebugSession.addToTrace( katana.getCell().getNet( 'imuxe.no2_x1_2_sig' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'b_from_pads(1)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'ialu.no3_x1_7_sig' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'iram.not_aux109' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 's(0)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'core.iram.aux74' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'q0_from_pads' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'a_from_pads(3)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'b_from_pads(0)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'd_from_pads(3)' ) )

#UpdateSession.open()
#
#keep = [ #'ialu.aux28'      ,
#         #'iram.not_aux109' ,
#         #'s(0)'            ,
#         #'s(3)'            ,
#         #'r(1)'            ,
#          'r(2)'            ]
#
#netsToDestroy = []
#
#for net in katana.getCell().getNets():
#  if net.isSupply(): continue
#  if net.getName() in keep: continue
#  katana.exclude( net )
#
#UpdateSession.close()

# - Short circuit between 2 nets:
#   | "core.r(3)".
#   | "core.ialu.not_r(0)".
#   + Shorted components:
#     > T A:&<id:77273 Horizontal core.ialu.not_r(0) METAL2 [790.0L 1650.0L] [1175.0L 1650.0L] 2.0L>
#     | Event 8928.
#     | T B:&<id:77525 Horizontal core.r(3) METAL2 [710.0L 1650.0L] [1150.0L 1650.0L] 2.0L> 
#     | Event 5319.
#     | Shorting @<Box 789.0L 1649.0L 1151.0L 1651.0L>
#DebugSession.addToTrace( katana.getCell().getNet( 'core.r(3)' ) )
#DebugSession.addToTrace( katana.getCell().getNet( 'core.ialu.not_r(0)' ) )
