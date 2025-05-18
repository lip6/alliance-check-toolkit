
import sys
import traceback
from   coriolis.Hurricane  import Breakpoint, DbU, Pin
from   coriolis            import CRL
from   coriolis.helpers.io import ErrorMessage, WarningMessage, catch
from   coriolis.helpers    import setTraceLevel, trace, l
from   coriolis            import plugins
from   coriolis.plugins.block.block         import Block
from   coriolis.plugins.block.configuration import IoPin
from   coriolis.plugins.chip.configuration  import ChipConf


af = CRL.AllianceFramework.get()


def scriptMain ( **kw ):
    """The mandatory function that Coriolis CGT/Unicorn will look for."""
    global af

    rvalue = True
    try:
        #setTraceLevel( 550 )
        #Breakpoint.setStopLevel( 100 )
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'm65s', CRL.Catalog.State.Logical )
        if editor: editor.setCell( cell ) 

        # ioPinsSpec, for peripheral pin placement as a standalone block.
        ioPinsSpec = [ (IoPin.SOUTH, 'adrs({})' , l(   5.0), l( 45.0), 16)
                     , (IoPin.EAST , 'data({})' , l(  25.0), l( 50.0),  8)
                     , (IoPin.EAST , 'datao({})', l(  40.0), l( 50.0),  8)
                     , (IoPin.WEST , 'debug({})', l(  30.0), l( 30.0), 16)
                     , (IoPin.EAST , 'debug(0)' , l(  30.0),       0 ,  1)
                     , (IoPin.NORTH, 'irq'      , l( 100.0),       0 ,  1)
                     , (IoPin.NORTH, 'm_clock'  , l( 150.0),       0 ,  1)
                     , (IoPin.NORTH, 'nmi'      , l( 200.0),       0 ,  1)
                     , (IoPin.NORTH, 'p_reset'  , l( 250.0),       0 ,  1)
                     , (IoPin.NORTH, 'rdy'      , l( 300.0),       0 ,  1)
                     , (IoPin.NORTH, 'start'    , l( 350.0),       0 ,  1)
                     , (IoPin.NORTH, 'rd'       , l( 400.0),       0 ,  1)
                     , (IoPin.NORTH, 'sync'     , l( 450.0),       0 ,  1)
                     , (IoPin.NORTH, 'wt'       , l( 500.0),       0 ,  1)
                     ]
        m65sConf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=[] ) 
        m65sConf.cfg.misc.logMode                = True
        m65sConf.cfg.etesian.graphics            = 2
        m65sConf.cfg.etesian.effort              = 2
        m65sConf.cfg.etesian.spaceMargin         = 0.10
        m65sConf.cfg.etesian.aspectRatio         = 1.00
        m65sConf.cfg.etesian.densityVariation    = 0.05
        m65sConf.cfg.anabatic.topRoutingLayer    = 'METAL5'
        m65sConf.cfg.katana.eventsLimit          = 1000000
        m65sConf.cfg.katana.hTracksReservedMin   = 7 
        m65sConf.cfg.katana.vTracksReservedMin   = 6
        m65sConf.cfg.katana.hTracksReservedLocal = 9 
        m65sConf.cfg.katana.vTracksReservedLocal = 9 
        m65sConf.cfg.katana.runRealignStage      = True
        m65sConf.cfg.block.spareSide             = l(1000)
        m65sConf.editor     = editor
        #m65sConf.fixedWidth = l(800)
        m65sConf.useSpares  = True
        m65sConf.useHTree( 'm_clock' )
        blockBuilder = Block( m65sConf )
        rvalue = blockBuilder.doPnR()
        blockBuilder.save()
    except Exception as e:
        catch( e )
        rvalue = False
    sys.stdout.flush()
    sys.stderr.flush()
    return rvalue
