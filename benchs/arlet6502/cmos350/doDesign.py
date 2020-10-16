
from   __future__ import print_function
import sys
import traceback
import CRL
import helpers
from   helpers.io import ErrorMessage
from   helpers.io import WarningMessage
from   helpers    import trace
from   helpers    import l, u, n
import plugins
from   Hurricane  import DbU
from   plugins.alpha.block.block         import Block
from   plugins.alpha.block.configuration import IoPin


af = CRL.AllianceFramework.get()


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af

    rvalue = True
    try:
       #helpers.setTraceLevel( 550 )
        cell, editor = plugins.kwParseMain( **kw )

        cell = af.getCell( 'arlet6502', CRL.Catalog.State.Logical )
        if editor: editor.setCell( cell ) 

        arlet6502 = Block.create \
                  ( cell
                  , ioPins=[ (IoPin.WEST |IoPin.A_BEGIN, 'di({})'  , l( 200.0), l(150.0),  8)
                           , (IoPin.WEST |IoPin.A_BEGIN, 'do({})'  , l( 250.0), l(150.0),  8)
                           , (IoPin.EAST |IoPin.A_BEGIN, 'a({})'   , l( 200.0), l( 70.0), 16)

                           , (IoPin.NORTH|IoPin.A_BEGIN, 'clk'     , l( 80.0),       0 ,  1)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'irq'     , l(160.0),       0 ,  1)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'nmi'     , l(240.0),       0 ,  1)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'rdy'     , l(320.0),       0 ,  1)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'we'      , l(400.0),       0 ,  1)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'reset'   , l(480.0),       0 ,  1)
                           ]
                  )
        arlet6502.state.cfg.etesian.bloat               = 'nsxlib'
        arlet6502.state.cfg.etesian.uniformDensity      = True
        arlet6502.state.cfg.etesian.aspectRatio         = 1.0
        arlet6502.state.cfg.etesian.spaceMargin         = 0.10
        arlet6502.state.cfg.anabatic.searchHalo         = 2
        arlet6502.state.cfg.anabatic.globalIterations   = 20
        arlet6502.state.cfg.katana.hTracksReservedLocal = 6
        arlet6502.state.cfg.katana.vTracksReservedLocal = 3
        arlet6502.state.cfg.katana.hTracksReservedMin   = 3
        arlet6502.state.cfg.katana.vTracksReservedMin   = 1
        arlet6502.state.cfg.block.spareSide             = l(700)
        arlet6502.state.editor       = editor
        arlet6502.state.useSpares    = True
        arlet6502.state.useClockTree = True
        arlet6502.state.bColumns     = 2
        arlet6502.state.bRows        = 3
        arlet6502.state.chipName     = 'chip'
        rvalue = arlet6502.build()
    except Exception, e:
        helpers.io.catch( e )
        rvalue = False

    sys.stdout.flush()
    sys.stderr.flush()
        
    return rvalue
