
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
        helpers.setTraceLevel( 550 )
        cell, editor = plugins.kwParseMain( **kw )

        cell = af.getCell( 'ao68000', CRL.Catalog.State.Logical )
        if editor: editor.setCell( cell ) 

        ao68000 = Block.create \
                  ( cell
                  , ioPins=[ (IoPin.WEST |IoPin.A_BEGIN, 'dat_i({})'  , l( 200.0), l(150.0), 32)
                           , (IoPin.WEST |IoPin.A_BEGIN, 'dat_o({})'  , l( 250.0), l(150.0), 32)
                           , (IoPin.SOUTH|IoPin.A_BEGIN, 'adr_o({})'  , l( 160.0), l( 80.0), range(2,32))
                           , (IoPin.SOUTH|IoPin.A_BEGIN, 'ipl_i({})'  ,        0 , l(160.0),  3)
                           , (IoPin.SOUTH|IoPin.A_BEGIN, 'bte_o(1)'   ,        0 , l(160.0),  1)
                           , (IoPin.SOUTH|IoPin.A_BEGIN, 'cti_o({})'  ,        0 , l(160.0),  3)
                           , (IoPin.SOUTH|IoPin.A_BEGIN, 'fc_o({})'   ,        0 , l(160.0),  3)
                           , (IoPin.SOUTH|IoPin.A_BEGIN, 'sel_o({})'  ,        0 , l(160.0),  4)
                           , (IoPin.SOUTH|IoPin.A_BEGIN, 'ipl_i({})'  ,        0 , l(160.0),  3)
                           , (IoPin.SOUTH|IoPin.A_BEGIN, 'ipl_i({})'  ,        0 , l(160.0),  3)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'ack_i'      ,        0 , l(240.0),  1)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'clk_i'      ,        0 , l(240.0),  1)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'err_i'      ,        0 , l(240.0),  1)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'reset_n'    ,        0 , l(240.0),  1)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'rty_i'      ,        0 , l(240.0),  1)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'blk_o'      ,        0 , l(240.0),  1)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'blocked_o'  ,        0 , l(240.0),  1)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'cyc_o'      ,        0 , l(240.0),  1)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'reset_o'    ,        0 , l(240.0),  1)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'rmw_o'      ,        0 , l(240.0),  1)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'sgl_o'      ,        0 , l(240.0),  1)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'stb_o'      ,        0 , l(240.0),  1)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'we_o'       ,        0 , l(240.0),  1)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'rmw_o'      ,        0 , l(240.0),  1)
                           ]
                  )
        ao68000.state.cfg.etesian.bloat               = 'nsxlib'
        ao68000.state.cfg.etesian.densityVariation    = 0.05
        ao68000.state.cfg.etesian.aspectRatio         = 1.0
        ao68000.state.cfg.etesian.spaceMargin         = 0.10
        ao68000.state.cfg.anabatic.searchHalo         = 2
        ao68000.state.cfg.anabatic.globalIterations   = 20
        ao68000.state.cfg.katana.hTracksReservedLocal = 6
        ao68000.state.cfg.katana.vTracksReservedLocal = 3
        ao68000.state.cfg.katana.hTracksReservedMin   = 3
        ao68000.state.cfg.katana.vTracksReservedMin   = 1
        ao68000.state.cfg.block.spareSide             = l(700)
        ao68000.state.editor       = editor
        ao68000.state.useSpares    = True
        ao68000.state.useClockTree = True
        ao68000.state.bColumns     = 4
        ao68000.state.bRows        = 5
        rvalue = ao68000.build()
    except Exception, e:
        helpers.io.catch( e )
        rvalue = False

    sys.stdout.flush()
    sys.stderr.flush()
        
    return rvalue
