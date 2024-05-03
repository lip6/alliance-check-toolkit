
# This file is part of the Coriolis Software.
# Copyright (c) Sorbonne Université 2019-2023, All Rights Reserved
#
# +-----------------------------------------------------------------+
# |                   C O R I O L I S                               |
# |          Alliance / Hurricane  Interface                        |
# |                                                                 |
# |  Author      :                    Jean-Paul CHAPUT              |
# |  E-mail      :            Jean-Paul.Chaput@lip6.fr              |
# | =============================================================== |
# |  Python      :       "./etc/symbolic/cmos/kite.py"              |
# +-----------------------------------------------------------------+


import coriolis.Cfg as Cfg
from   coriolis.helpers    import truncPath, l, u, n
from   coriolis.helpers.io import vprint
vprint( 2, '     - "%s".' % truncPath(__file__) )

from coriolis.Hurricane import DataBase
from coriolis.CRL       import AllianceFramework, RoutingGauge, \
                               RoutingLayerGauge, CellGauge

from ...common import kite


p = Cfg.getParamDouble    ( 'lefImport.minTerminalWidth'      ).setDouble    ( 0.0      )
p = Cfg.getParamString    ( 'katabatic.routingGauge'          ).setString    ( 'sxlib'  ) 
p = Cfg.getParamInt       ( "katabatic.globalLengthThreshold" ).setInt       ( 1450     )
p = Cfg.getParamPercentage( "katabatic.saturateRatio"         ).setPercentage( 80       ) 
p = Cfg.getParamInt       ( "katabatic.saturateRp"            ).setInt       ( 8        )
p = Cfg.getParamString    ( 'katabatic.topRoutingLayer'       ).setString    ( 'METAL6' )

 # Kite parameters.
p = Cfg.getParamInt( "kite.hTracksReservedLocal" ); p.setInt( 4       ); p.setMin( 0 ); p.setMax( 18 )
p = Cfg.getParamInt( "kite.vTracksReservedLocal" ); p.setInt( 3       ); p.setMin( 0 ); p.setMax( 18 )
p = Cfg.getParamInt( "kite.eventsLimit"          ); p.setInt( 4000002 ) 
p = Cfg.getParamInt( "kite.ripupCost"            ); p.setInt( 3       ); p.setMin( 0 )
p = Cfg.getParamInt( "kite.strapRipupLimit"      ); p.setInt( 16      ); p.setMin( 1 )
p = Cfg.getParamInt( "kite.localRipupLimit"      ); p.setInt( 9       ); p.setMin( 1 )
p = Cfg.getParamInt( "kite.globalRipupLimit"     ); p.setInt( 5       ); p.setMin( 1 )
p = Cfg.getParamInt( "kite.longGlobalRipupLimit" ); p.setInt( 5       ); p.setMin( 1 )

# Anabatic & Katana parameters are temporarily hosted here.
p = Cfg.getParamString    ( 'anabatic.routingGauge'          ); p.setString    ( 'msxlib_uniform' )
p = Cfg.getParamInt       ( "anabatic.globalLengthThreshold" ); p.setInt       ( 1450     )
p = Cfg.getParamPercentage( "anabatic.saturateRatio"         ); p.setPercentage( 80       )
p = Cfg.getParamInt       ( "anabatic.saturateRp"            ); p.setInt       ( 8        )
p = Cfg.getParamString    ( 'anabatic.topRoutingLayer'       ); p.setString    ( 'METAL5' )
p = Cfg.getParamInt       ( "anabatic.edgeLength"            ); p.setInt       ( 48       )
p = Cfg.getParamInt       ( "anabatic.edgeWidth"             ); p.setInt       ( 8        )
p = Cfg.getParamDouble    ( "anabatic.edgeCostH"             ); p.setDouble    ( 19.0     )
p = Cfg.getParamDouble    ( "anabatic.edgeCostK"             ); p.setDouble    ( -60.0    )
p = Cfg.getParamDouble    ( "anabatic.edgeHInc"              ); p.setDouble    ( 1.0      ) 
p = Cfg.getParamDouble    ( "anabatic.edgeHScaling"          ); p.setDouble    ( 1.0      ) 
p = Cfg.getParamInt       ( "anabatic.globalIterations"      ); p.setInt       ( 10       ); p.setMin(1); p.setMax(100)
p = Cfg.getParamEnumerate ( "anabatic.gcell.displayMode"     ); p.setInt       ( 1        )
p.addValue( "Boundary", 1 ) 
p.addValue( "Density" , 2 )

p = Cfg.getParamBool  ( "katana.useGlobalEstimate"    ); p.setBool  ( False ) 
p = Cfg.getParamInt   ( "katana.searchHalo"           ); p.setInt   ( 1 ) 
p = Cfg.getParamInt   ( "katana.hTracksReservedLocal" ); p.setInt   ( 3       ); p.setMin(0); p.setMax(20)
p = Cfg.getParamInt   ( "katana.vTracksReservedLocal" ); p.setInt   ( 3       ); p.setMin(0); p.setMax(20)
p = Cfg.getParamInt   ( "katana.termSatReservedLocal" ); p.setInt   ( 8       ) 
p = Cfg.getParamInt   ( "katana.hTracksReservedMin"   ); p.setInt   ( 1       ); p.setMin(0); p.setMax(20)
p = Cfg.getParamInt   ( "katana.vTracksReservedMin"   ); p.setInt   ( 1       ); p.setMin(0); p.setMax(20)
p = Cfg.getParamInt   ( "katana.termSatThreshold"     ); p.setInt   ( 9       )
p = Cfg.getParamInt   ( "katana.eventsLimit"          ); p.setInt   ( 4000002 ) 
p = Cfg.getParamInt   ( "katana.ripupCost"            ); p.setInt   ( 3       ); p.setMin(0)
p = Cfg.getParamInt   ( "katana.strapRipupLimit"      ); p.setInt   ( 16      ); p.setMin(1)
p = Cfg.getParamInt   ( "katana.localRipupLimit"      ); p.setInt   ( 9       ); p.setMin(1)
p = Cfg.getParamInt   ( "katana.globalRipupLimit"     ); p.setInt   ( 5       ); p.setMin(1)
p = Cfg.getParamInt   ( "katana.longGlobalRipupLimit" ); p.setInt   ( 5       ); p.setMin(1)
p = Cfg.getParamString( 'chip.padCoreSide'            ); p.setString( 'South' )
p = Cfg.getParamInt   ( "block.spareSide"             ); p.setInt   ( l(2000) )


tech = DataBase.getDB().getTechnology()
af   = AllianceFramework.get()
rg   = RoutingGauge.create( 'msxlib_uniform' )

rg.addLayerGauge( RoutingLayerGauge.create( tech.getLayer('METAL1')       # metal.
                                          , RoutingLayerGauge.Vertical    # preferred routing direction.
                                          , RoutingLayerGauge.PinOnly     # layer usage.
                                          , 0                             # depth.
                                          , 0.0                           # density (deprecated).
                                          , l(0)                          # track offset from AB.
                                          , l(10)                         # track pitch.
                                          , l(3)                          # wire width.
                                          , 0                             # perpandicular wire width.
                                          , l(2)                          # VIA side (that is VIA12).
                                          , l(7)                          # obstacle dW.
                                          ) )

rg.addLayerGauge( RoutingLayerGauge.create( tech.getLayer('METAL2')       # metal.
                                          , RoutingLayerGauge.Horizontal  # preferred routing direction.
                                          , RoutingLayerGauge.Default     # layer usage.
                                          , 1                             # depth.
                                          , 0.0                           # density (deprecated).
                                          , l(0)                          # track offset from AB.
                                          , l(10)                         # track pitch.
                                          , l(3)                          # wire width.
                                          , 0                             # perpandicular wire width.
                                          , l(2)                          # VIA side (that is VIA23).
                                          , l(8)                          # obstacle dW.
                                          ) )

rg.addLayerGauge( RoutingLayerGauge.create( tech.getLayer('METAL3')       # metal.
                                          , RoutingLayerGauge.Vertical    # preferred routing direction.
                                          , RoutingLayerGauge.Default     # layer usage.
                                          , 2                             # depth.
                                          , 0.0                           # density (deprecated).
                                          , l(0)                          # track offset from AB.
                                          , l(10)                         # track pitch.
                                          , l(3)                          # wire width.
                                          , 0                             # perpandicular wire width.
                                          , l(2)                          # VIA side (that is VIA34).
                                          , l(8)                          # obstacle dW.
                                          ) )

rg.addLayerGauge( RoutingLayerGauge.create( tech.getLayer('METAL4')       # metal.
                                          , RoutingLayerGauge.Horizontal  # preferred routing direction.
                                          , RoutingLayerGauge.Default     # layer usage.
                                          , 3                             # depth.
                                          , 0.0                           # density (deprecated).
                                          , l(0)                          # track offset from AB.
                                          , l(10)                         # track pitch.
                                          , l(3)                          # wire width.
                                          , 0                             # perpandicular wire width.
                                          , l(2)                          # VIA side (that is VIA23).
                                          , l(8)                          # obstacle dW.
                                          ) )

rg.addLayerGauge( RoutingLayerGauge.create( tech.getLayer('METAL5')       # metal.
                                          , RoutingLayerGauge.Vertical    # preferred routing direction.
                                          , RoutingLayerGauge.Default     # layer usage.
                                          , 4                             # depth.
                                          , 0.0                           # density (deprecated).
                                          , l(0)                          # track offset from AB.
                                          , l(10)                         # track pitch.
                                          , l(3)                          # wire width.
                                          , 0                             # perpandicular wire width.
                                          , l(2)                          # VIA side (that is VIA23).
                                          , l(8)                          # obstacle dW.
                                          ) )

rg.addLayerGauge( RoutingLayerGauge.create( tech.getLayer('METAL6')       # metal.
                                          , RoutingLayerGauge.Horizontal  # preferred routing direction.
                                          , RoutingLayerGauge.PowerSupply # layer usage.
                                          , 5                             # depth.
                                          , 0.0                           # density (deprecated).
                                          , l(0)                          # track offset from AB.
                                          , l(10)                         # track pitch.
                                          , l(3)                          # wire width.
                                          , 0                             # perpandicular wire width.
                                          , l(2)                          # VIA side (that is VIA23).
                                          , l(8)                          # obstacle dW.
                                          ) )

af.addRoutingGauge( rg )
rg   = RoutingGauge.create( 'msxlib' )

rg.addLayerGauge( RoutingLayerGauge.create( tech.getLayer('METAL1')       # metal.
                                          , RoutingLayerGauge.Vertical    # preferred routing direction.
                                          , RoutingLayerGauge.PinOnly     # layer usage.
                                          , 0                             # depth.
                                          , 0.0                           # density (deprecated).
                                          , l(0)                          # track offset from AB.
                                          , l(10)                         # track pitch.
                                          , l(3)                          # wire width.
                                          , 0                             # perpandicular wire width.
                                          , l(2)                          # VIA side (that is VIA12).
                                          , l(7)                          # obstacle dW.
                                          ) )

rg.addLayerGauge( RoutingLayerGauge.create( tech.getLayer('METAL2')       # metal.
                                          , RoutingLayerGauge.Horizontal  # preferred routing direction.
                                          , RoutingLayerGauge.Default     # layer usage.
                                          , 1                             # depth.
                                          , 0.0                           # density (deprecated).
                                          , l(0)                          # track offset from AB.
                                          , l(10)                         # track pitch.
                                          , l(3)                          # wire width.
                                          , 0                             # perpandicular wire width.
                                          , l(2)                          # VIA side (that is VIA23).
                                          , l(8)                          # obstacle dW.
                                          ) )

rg.addLayerGauge( RoutingLayerGauge.create( tech.getLayer('METAL3')       # metal.
                                          , RoutingLayerGauge.Vertical    # preferred routing direction.
                                          , RoutingLayerGauge.Default     # layer usage.
                                          , 2                             # depth.
                                          , 0.0                           # density (deprecated).
                                          , l(0)                          # track offset from AB.
                                          , l(10)                         # track pitch.
                                          , l(3)                          # wire width.
                                          , 0                             # perpandicular wire width.
                                          , l(2)                          # VIA side (that is VIA34).
                                          , l(8)                          # obstacle dW.
                                          ) )

rg.addLayerGauge( RoutingLayerGauge.create( tech.getLayer('METAL4')       # metal.
                                          , RoutingLayerGauge.Horizontal  # preferred routing direction.
                                          , RoutingLayerGauge.Default     # layer usage.
                                          , 3                             # depth.
                                          , 0.0                           # density (deprecated).
                                          , l(0)                          # track offset from AB.
                                          , l(15)                         # track pitch.
                                          , l(6)                          # wire width.
                                          , 0                             # perpandicular wire width.
                                          , l(4)                          # VIA side (that is VIA23).
                                          , l(8)                          # obstacle dW.
                                          ) )

rg.addLayerGauge( RoutingLayerGauge.create( tech.getLayer('METAL5')       # metal.
                                          , RoutingLayerGauge.Vertical    # preferred routing direction.
                                          , RoutingLayerGauge.Default     # layer usage.
                                          , 4                             # depth.
                                          , 0.0                           # density (deprecated).
                                          , l(0)                          # track offset from AB.
                                          , l(15)                         # track pitch.
                                          , l(6)                          # wire width.
                                          , 0                             # perpandicular wire width.
                                          , l(4)                          # VIA side (that is VIA23).
                                          , l(8)                          # obstacle dW.
                                          ) )

rg.addLayerGauge( RoutingLayerGauge.create( tech.getLayer('METAL6')       # metal.
                                          , RoutingLayerGauge.Horizontal  # preferred routing direction.
                                          , RoutingLayerGauge.PowerSupply # layer usage.
                                          , 5                             # depth.
                                          , 0.0                           # density (deprecated).
                                          , l(0)                          # track offset from AB.
                                          , l(15)                         # track pitch.
                                          , l(6)                          # wire width.
                                          , 0                             # perpandicular wire width.
                                          , l(4)                          # VIA side (that is VIA23).
                                          , l(8)                          # obstacle dW.
                                          ) )

af.addRoutingGauge( rg )

rg = RoutingGauge.create( 'msxlib4' )

rg.addLayerGauge( RoutingLayerGauge.create( tech.getLayer('METAL1')       # metal.
                                          , RoutingLayerGauge.Vertical    # preferred routing direction.
                                          , RoutingLayerGauge.PinOnly     # layer usage.
                                          , 0                             # depth.
                                          , 0.0                           # density (deprecated).
                                          , l(0)                          # track offset from AB.
                                          , l(10)                         # track pitch.
                                          , l(3)                          # wire width.
                                          , 0                             # perpandicular wire width.
                                          , l(2)                          # VIA side (that is VIA12).
                                          , l(7)                          # obstacle dW.
                                          ) )

rg.addLayerGauge( RoutingLayerGauge.create( tech.getLayer('METAL2')       # metal.
                                          , RoutingLayerGauge.Horizontal  # preferred routing direction.
                                          , RoutingLayerGauge.Default     # layer usage.
                                          , 1                             # depth.
                                          , 0.0                           # density (deprecated).
                                          , l(0)                          # track offset from AB.
                                          , l(10)                         # track pitch.
                                          , l(3)                          # wire width.
                                          , 0                             # perpandicular wire width.
                                          , l(2)                          # VIA side (that is VIA23).
                                          , l(8)                          # obstacle dW.
                                          ) )

rg.addLayerGauge( RoutingLayerGauge.create( tech.getLayer('METAL3')       # metal.
                                          , RoutingLayerGauge.Vertical    # preferred routing direction.
                                          , RoutingLayerGauge.Default     # layer usage.
                                          , 2                             # depth.
                                          , 0.0                           # density (deprecated).
                                          , l(0)                          # track offset from AB.
                                          , l(8)                          # track pitch.
                                          , l(3)                          # wire width.
                                          , 0                             # perpandicular wire width.
                                          , l(2)                          # VIA side (that is VIA12).
                                          , l(8)                          # obstacle dW.
                                          ) )

rg.addLayerGauge( RoutingLayerGauge.create( tech.getLayer('METAL4')       # metal.
                                          , RoutingLayerGauge.Horizontal  # preferred routing direction.
                                          , RoutingLayerGauge.Default     # layer usage.
                                          , 3                             # depth.
                                          , 0.0                           # density (deprecated).
                                          , l(0)                          # track offset from AB.
                                          , l(10)                         # track pitch.
                                          , l(3)                          # wire width.
                                          , 0                             # perpandicular wire width.
                                          , l(2)                          # VIA side (that is VIA23).
                                          , l(8)                          # obstacle dW.
                                          ) )

af.addRoutingGauge( rg )

rg = RoutingGauge.create( 'msxlib-2M' )

rg.addLayerGauge( RoutingLayerGauge.create( tech.getLayer('METAL1')       # metal.
                                          , RoutingLayerGauge.Vertical    # preferred routing direction.
                                          , RoutingLayerGauge.PinOnly     # layer usage.
                                          , 0                             # depth.
                                          , 0.0                           # density (deprecated).
                                          , l(0)                          # track offset from AB.
                                          , l(10)                         # track pitch.
                                          , l(3)                          # wire width.
                                          , 0                             # perpandicular wire width.
                                          , l(3)                          # VIA side (that is VIA12).
                                          , l(7)                          # obstacle dW.
                                          ) )

rg.addLayerGauge( RoutingLayerGauge.create( tech.getLayer('METAL2')       # metal.
                                          , RoutingLayerGauge.Horizontal  # preferred routing direction.
                                          , RoutingLayerGauge.Default     # layer usage.
                                          , 1                             # depth.
                                          , 0.0                           # density (deprecated).
                                          , l(0)                          # track offset from AB.
                                          , l(10)                         # track pitch.
                                          , l(3)                          # wire width.
                                          , 0                             # perpandicular wire width.
                                          , l(3)                          # VIA side (that is VIA23).
                                          , l(8)                          # obstacle dW.
                                          ) )

af.addRoutingGauge( rg )

af.setRoutingGauge( 'msxlib_uniform' )

# Gauge for standard cells.
cg = CellGauge.create( 'msxlib_uniform'
                     , 'metal2'   # pin layer name.
                     , l( 10.0)   # pitch.
                     , l(100.0)   # cell slice height.
                     , l( 10.0)   # cell slice step.
                     )
af.addCellGauge( cg )
cg = CellGauge.create( 'msxlib'
                     , 'metal2'   # pin layer name.
                     , l( 10.0)   # pitch.
                     , l(100.0)   # cell slice height.
                     , l( 10.0)   # cell slice step.
                     )
af.addCellGauge( cg )
cg = CellGauge.create( 'msxlib4'
                     , 'metal2'   # pin layer name.
                     , l( 10.0)   # pitch.
                     , l(100.0)   # cell slice height.
                     , l( 10.0)   # cell slice step.
                     )
af.addCellGauge( cg )

# Gauge for Alliance symbolic I/O pads.
cg = CellGauge.create( 'phlib80'
                     , 'metal2'   # pin layer name.
                     , l( 10.0)   # pitch.
                     , l(312.0)   # cell slice height.
                     , l(246.0)   # cell slice step.
                     )
af.addCellGauge( cg )

# Gauge for Flexlib symbolic I/O pads (abstracts).
cg = CellGauge.create( 'niolib'
                     , 'metal2'    # pin layer name.
                     , l(  10.0)   # pitch.
                     , l(1190.0)   # cell slice height.
                     , l( 500.0)   # cell slice step.
                     )
af.addCellGauge( cg )
