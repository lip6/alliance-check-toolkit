
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

