
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

        cell = af.getCell( 'retrouc_2020beta', CRL.Catalog.State.Logical )
        if editor: editor.setCell( cell ) 

        retrouc = Block.create \
                  ( cell
                 #, ioPins=[ (IoPin.WEST |IoPin.A_BEGIN, 'io_{}_i'      , l(  50.0), l( 50.0), 87)
                 #         , (IoPin.EAST |IoPin.A_BEGIN, 'io_{}_o'      , l(  50.0), l(100.0), 87)
                 #         , (IoPin.EAST |IoPin.A_BEGIN, 'io_{}_oe'     , l( 100.0), l(100.0), 87)
                 #         , (IoPin.SOUTH|IoPin.A_BEGIN, 'mem_0_we'     , l( 100.0),       0,   1)
                 #         , (IoPin.SOUTH|IoPin.A_BEGIN, 'mem_0_ce(3)'  , l( 150.0),       0,   1)
                 #         , (IoPin.SOUTH|IoPin.A_BEGIN, 'mem_0_a({})'  , l( 200.0), l( 20.0),  8)
                 #         , (IoPin.SOUTH|IoPin.A_BEGIN, 'mem_0_d_w({})', l( 360.0), l( 20.0), 32)
                 #         , (IoPin.SOUTH|IoPin.A_BEGIN, 'mem_0_d_r({})', l(1000.0), l( 10.0), 32)
                 #         , (IoPin.SOUTH|IoPin.A_BEGIN, 'en_0({})'     , l(1320.0), l( 20.0),  3)
                 #         , (IoPin.NORTH|IoPin.A_BEGIN, 'jtag_0_tdi'   , l(1000.0),       0 ,  1)
                 #         , (IoPin.NORTH|IoPin.A_BEGIN, 'jtag_0_tdo'   , l(1050.0),       0 ,  1)
                 #         , (IoPin.NORTH|IoPin.A_BEGIN, 'jtag_0_tms'   , l(1100.0),       0 ,  1)
                 #         , (IoPin.NORTH|IoPin.A_BEGIN, 'rst_0'        , l(1200.0),       0 ,  1)
                 #         , (IoPin.NORTH|IoPin.A_BEGIN, 'clk_0'        , l(1210.0),       0 ,  1)
                 #         , (IoPin.NORTH|IoPin.A_BEGIN, 'jtag_0_tck'   , l(1220.0),       0 ,  1)
                 #         ]
                  , ioPins=[ (IoPin.WEST |IoPin.A_BEGIN, 'io_{}_i'      , l(  50.0), l( 50.0), 87)
                           , (IoPin.EAST |IoPin.A_BEGIN, 'io_{}_o'      , l(  50.0), l(100.0), 87)
                           , (IoPin.EAST |IoPin.A_BEGIN, 'io_{}_oe'     , l( 100.0), l(100.0), 87)
                           , (IoPin.SOUTH|IoPin.A_BEGIN, 'mem_0_we'     , l(  80.0),       0,   1)
                           , (IoPin.SOUTH|IoPin.A_BEGIN, 'mem_0_ce(3)'  , l( 120.0),       0,   1)
                           , (IoPin.SOUTH|IoPin.A_BEGIN, 'mem_0_a({})'  , l( 200.0), l( 16.0),  8)
                           , (IoPin.SOUTH|IoPin.A_BEGIN, 'mem_0_d_w({})', l( 288.0), l( 16.0), 32)
                           , (IoPin.SOUTH|IoPin.A_BEGIN, 'mem_0_d_r({})', l( 800.0), l(  8.0), 32)
                           , (IoPin.SOUTH|IoPin.A_BEGIN, 'en_0({})'     , l(1056.0), l( 16.0),  3)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'jtag_0_tdi'   , l( 800.0),       0 ,  1)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'jtag_0_tdo'   , l( 840.0),       0 ,  1)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'jtag_0_tms'   , l( 880.0),       0 ,  1)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'rst_0'        , l( 960.0),       0 ,  1)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'clk_0'        , l( 968.0),       0 ,  1)
                           , (IoPin.NORTH|IoPin.A_BEGIN, 'jtag_0_tck'   , l( 976.0),       0 ,  1)
                           ]
                  )
        retrouc.state.cfg.etesian.bloat               = 'nsxlib'
        retrouc.state.cfg.etesian.uniformDensity      = True
        retrouc.state.cfg.etesian.aspectRatio         = 1.0
        retrouc.state.cfg.etesian.spaceMargin         = 0.10
        retrouc.state.cfg.anabatic.searchHalo         = 2
        retrouc.state.cfg.anabatic.globalIterations   = 20
        retrouc.state.cfg.katana.hTracksReservedLocal = 9
        retrouc.state.cfg.katana.vTracksReservedLocal = 9
        retrouc.state.cfg.katana.hTracksReservedMin   = 3
        retrouc.state.cfg.katana.vTracksReservedMin   = 1
        retrouc.state.cfg.block.spareSide             = l(700)
        retrouc.state.editor       = editor
        retrouc.state.useSpares    = True
        retrouc.state.useClockTree = True
        retrouc.state.bColumns     = 4
        retrouc.state.bRows        = 4
        rvalue = retrouc.build()
    except Exception, e:
        helpers.io.catch( e )
        rvalue = False

    sys.stdout.flush()
    sys.stderr.flush()
        
    return rvalue
