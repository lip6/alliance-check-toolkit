
import sys
import traceback
import CRL
import helpers
from   helpers    import trace, l
from   helpers.io import ErrorMessage, WarningMessage
import plugins
from   Hurricane  import Breakpoint, DbU, Pin
from   plugins.alpha.block.block         import Block
from   plugins.alpha.block.spares        import Spares
from   plugins.alpha.block.configuration import IoPin
from   plugins.alpha.chip.configuration  import ChipConf


af = CRL.AllianceFramework.get()


def scriptMain ( **kw ):
    """The mandatory function that Coriolis CGT/Unicorn will look for."""
    global af

    rvalue = True
    try:
        #helpers.setTraceLevel( 550 )
        #Breakpoint.setStopLevel( 100 )
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'ao68000', CRL.Catalog.State.Logical )
        if editor: editor.setCell( cell ) 

        # ioPinsSpec, for peripheral pin placement as a standalone block.
        ioPinsSpec = [ (IoPin.WEST , 'ack_i'    , l( 200.0),        0,  1)
                    #, (IoPin.WEST , 'clk_i'    , l( 400.0),        0,  1) 
                     , (IoPin.WEST , 'err_i'    , l( 600.0),        0,  1) 
                    #, (IoPin.WEST , 'reset_n'  , l( 800.0),        0,  1) 
                     , (IoPin.WEST , 'rty_i'    , l(1000.0),        0,  1) 
                     , (IoPin.WEST , 'blk_o'    , l(1200.0),        0,  1) 
                     , (IoPin.WEST , 'blocked_o', l(1400.0),        0,  1) 
                     , (IoPin.WEST , 'cyc_o'    , l(1600.0),        0,  1) 
                     , (IoPin.WEST , 'reset_o'  , l(1800.0),        0,  1) 
                     , (IoPin.WEST , 'rmw_o'    , l(2000.0),        0,  1) 
                     , (IoPin.WEST , 'sgl_o'    , l(2200.0),        0,  1) 
                     , (IoPin.WEST , 'stb_o'    , l(2400.0),        0,  1) 
                     , (IoPin.WEST , 'we_o'     , l(2600.0),        0,  1) 
                     , (IoPin.WEST , 'ipl_i({})', l(2800.0), l(200.0),  3) 
                     , (IoPin.WEST , 'bte_o({})', l(3400.0), l(200.0),  2) 
                     , (IoPin.WEST , 'cti_o({})', l(3800.0), l(200.0),  3) 
                     , (IoPin.WEST , 'fc_o({})' , l(4600.0), l(200.0),  3) 
                     , (IoPin.WEST , 'sel_o({})', l(5200.0), l(200.0),  4) 
                     , (IoPin.SOUTH, 'dat_i({})', l(  40.0), l(400.0), 32) 
                     , (IoPin.EAST , 'adr_o({})', l(  40.0), l(400.0), 32) 
                     , (IoPin.NORTH, 'dat_o({})', l(  40.0), l(400.0), 32) 
                     ]

        ao68000Conf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=[] ) 
        ao68000Conf.cfg.misc.logMode                = True
        ao68000Conf.cfg.etesian.bloat               = 'nsxlib'
        ao68000Conf.cfg.etesian.spaceMargin         = 0.35
        ao68000Conf.cfg.etesian.aspectRatio         = 1.00
        ao68000Conf.cfg.etesian.effort              = 2
        ao68000Conf.cfg.etesian.uniformDensity      = True
        ao68000Conf.cfg.anabatic.searchHalo         = 3
        ao68000Conf.cfg.anabatic.topRoutingLayer    = 'METAL5'
        ao68000Conf.cfg.katana.hTracksReservedMin   = 7   # Minimum reserved capacity,
        ao68000Conf.cfg.katana.vTracksReservedMin   = 6   # applied on *all* edges.
        ao68000Conf.cfg.katana.hTracksReservedLocal = 12  # Maximum reserved capacity,
        ao68000Conf.cfg.katana.vTracksReservedLocal = 7   # for local routing.
        ao68000Conf.cfg.block.spareSide             = l(7*100.0)
        ao68000Conf.cfg.chip.supplyRailWidth        = l(350.0)
        ao68000Conf.cfg.chip.supplyRailPitch        = l(300.0)
        ao68000Conf.editor     = editor
       #ao68000Conf.fixedWidth = l(3500)
        ao68000Conf.useSpares  = True
        ao68000Conf.bColumns   = 2
        ao68000Conf.bRows      = 2
        ao68000Conf.useHTree( 'clk_i', Spares.HEAVY_LEAF_LOAD )
        ao68000Conf.useHTree( 'reset_n' )
        blockBuilder = Block( ao68000Conf )
        rvalue = blockBuilder.doPnR()
        blockBuilder.save()
    except Exception as e:
        helpers.io.catch( e )
        rvalue = False
    sys.stdout.flush()
    sys.stderr.flush()
    return rvalue


if __name__ == '__main__':
    rvalue = scriptMain()
    shellRValue = 0 if rvalue else 1
    sys.exit( shellRValue )
