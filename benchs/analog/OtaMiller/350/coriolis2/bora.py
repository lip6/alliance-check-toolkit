from coriolis.Hurricane import DebugSession

#DebugSession.addToTrace( bora.getCell().getNet( 'Vout+' ) )
#DebugSession.addToTrace( bora.getCell().getNet( 'vb5' ) )
#DebugSession.addToTrace( bora.getCell().getNet( 'ampp_71' ) )
#DebugSession.addToTrace( bora.getCell().getNet( 'ampn_72' ) )
#DebugSession.addToTrace( bora.getCell().getNet( 'ampp_73' ) )
#DebugSession.addToTrace( bora.getCell().getNet( 'ampn_72' ) )
#DebugSession.addToTrace( bora.getCell().getNet( 'ampn_4' ) )
#DebugSession.addToTrace( bora.getCell().getNet( 'ampp_4' ) )
#DebugSession.addToTrace( bora.getCell().getNet( 'm2n_in' ) )
#DebugSession.addToTrace( bora.getCell().getNet( 'm2p_in' ) )
#DebugSession.addToTrace( bora.getCell().getNet( 'm2n_in' ) )
#DebugSession.addToTrace( bora.getCell().getNet( 'ampp_61' ) )
#DebugSession.addToTrace( bora.getCell().getNet( 'ampn_61' ) )
#DebugSession.addToTrace( bora.getCell().getNet( 'ampp_2' ) )
#DebugSession.addToTrace( bora.getCell().getNet( 'm4an_in' ) )
#DebugSession.addToTrace( bora.getCell().getNet( 'vcmfb' ) )
#DebugSession.addToTrace( bora.getCell().getNet( 'alim' ) )
#DebugSession.addToTrace( bora.getCell().getNet( 'sp' ) )
# Pb Turn missing vertical <id:15890 ContactTurn s1a VIA23 [15.4um 53.375um] ...>
#DebugSession.addToTrace( bora.getCell().getNet( 's1a' ) )
# Pb Turn missing horizontal <id:15914 ContactTurn s1b VIA23 [42um 61.25um] ...>
#DebugSession.addToTrace( bora.getCell().getNet( 's1b' ) )
#DebugSession.addToTrace( bora.getCell().getNet( 'vdd' ) )
# NetBuilderHV::construct(): NULL target contact while building
#   <id:2067 Net "s1a" ---- LOGICAL ---- (UNDEFINED)>
#   in <id:15521 Anabatic::GCell <Box 2.8um 31.5um 13.9998um 48.9998um> ------c--------,iD---- 0>
# NetBuilderHV::construct(): NULL target contact while building
#   <id:2067 Net "s1a" ---- LOGICAL ---- (UNDEFINED)>
#   in <id:15569 Anabatic::GCell <Box 8.4um 52.5um 22.3998um 54.2498um> ---------S-----,i----- 0>
# In topology of &<id:15875 ContactHTee s1a VIA23 [23.8um 50.75um] 0.35um x 0.35um ---h-i-ct>
#   L: &<id:15876 Horizontal s1a METAL2 [23.8um 50.75um] [23.8um 50.75um] 0.525um rpD:15 bl:0 --u--------------i-------- [23.5375um:24.0625um]>
#   L: &<id:15878 Horizontal s1a METAL2 [23.8um 50.75um] [23.8um 50.75um] 0.525um rpD:15 bl:0 --u--------------i-------- [23.5375um:24.0625um]>
#   G: &<id:15743 Horizontal s1a METAL2 [23.8um 50.75um] [46.2um 50.75um] 0.525um rpD:15 bl:0 --u----G---------i-------M [23.5375um:46.4625um]>
#   No verticals connecteds
#   HTee has more than two horizontal segments.
# In topology of &<id:15877 ContactTurn s1a VIA23 [15.4um 53.375um] 0.35um x 0.35um -----i-ct>
#   L: &<id:15879 Horizontal s1a METAL2 [15.4um 53.375um] [15.4um 53.375um] 0.525um rpD:15 bl:0 --u--------------i-------- [15.1375um:15.6625um]>
#   G: &<id:15730 Vertical s1a METAL3 [15.4um 50.75um] [15.4um 53.375um] 0.525um rpD:15 bl:0 --u----G---------i-------M [50.4875um:53.6375um]>
#   G: &<id:15731 Vertical s1a METAL3 [15.4um 53.375um] [15.4um 57.75um] 0.525um rpD:15 bl:0 --u----G---------i-------M [53.1125um:58.0125um]>
#   Turn has more than one vertical segment.
#DebugSession.addToTrace( bora.getCell().getNet( 's1b' ) )
# In topology of &<id:15984 ContactTurn vss VIA23 [37.1um 19.25um] 0.35um x 0.35um -----i-ct>
#   G: &<id:15855 Horizontal vss METAL2 [23.8um 15.75um] [37.1um 15.75um] 0.525um rpD:15 bl:0 -Xu----G---D-----i-------M [23.5375um:37.3625um]>
#   L: &<id:15985 Vertical vss METAL3 [37.1um 19.25um] [37.1um 19.25um] 0.525um rpD:15 bl:0 --u--------------i-------- [18.9875um:19.5125um]>
#   G: &<id:15868 Vertical vss METAL3 [37.1um 19.25um] [37.1um 28um] 0.525um rpD:15 bl:0 --u----G---------i-------M [18.9875um:28.2625um]>
#   Turn has more than one vertical segment.
#DebugSession.addToTrace( bora.getCell().getNet( 'vss' ) )
#In topology of &<id:15995 ContactHTee vdd VIA23 [23.8um 61.25um] 0.35um x 0.35um ---h-i-ct>
#   G: &<id:15844 Horizontal vdd METAL2 [15.4um 56um] [23.8um 56um] 0.525um rpD:15 bl:0 --u----G---------i-------M [15.1375um:24.0625um]>
#   L: &<id:15996 Vertical vdd METAL3 [23.8um 61.25um] [23.8um 61.25um] 0.525um rpD:15 bl:0 --u--------------i-------- [60.9875um:61.5125um]>
#   G: &<id:15852 Vertical vdd METAL3 [23.8um 61.25um] [23.8um 71.75um] 0.525um rpD:15 bl:0 --u----G---------i-------M [60.9875um:72.0125um]>
#   HTee has less than two horizontal segments.
DebugSession.addToTrace( bora.getCell().getNet( 'vdd' ) )


