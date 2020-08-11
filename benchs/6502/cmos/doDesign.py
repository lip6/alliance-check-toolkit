
from   __future__ import print_function
import sys
import traceback
import CRL
import helpers
from   helpers.io import ErrorMessage
from   helpers.io import WarningMessage
from   helpers    import trace, l
import plugins
from   Hurricane  import DbU
from   Hurricane  import Pin
from   plugins.alpha.block.block         import Block
from   plugins.alpha.block.configuration import IoPin


af = CRL.AllianceFramework.get()


def scriptMain ( **kw ):
    """The mandatory function that Coriolis CGT/Unicorn will look for."""
    global af

    rvalue = True
    try:
        helpers.setTraceLevel( 550 )
        cell, editor = plugins.kwParseMain( **kw )

        cell = af.getCell( 'm65s', CRL.Catalog.State.Logical )
        if editor: editor.setCell( cell ) 

        block = Block.create( cell
                            , ioPins=[ (IoPin.SOUTH, 'adrs({})' , l(  10.0), l( 90.0), 16)
                                     , (IoPin.EAST , 'data({})' , l(  50.0), l(100.0),  8)
                                     , (IoPin.EAST , 'datao({})', l(  75.0), l(100.0),  8)
                                     , (IoPin.WEST , 'debug({})', l(  50.0), l( 50.0), 16)
                                     , (IoPin.EAST , 'debug(0)' , l(  45.0),       0 ,  1)
                                     , (IoPin.NORTH, 'irq'      , l( 200.0),       0 ,  1)
                                     , (IoPin.NORTH, 'm_clock'  , l( 300.0),       0 ,  1)
                                     , (IoPin.NORTH, 'nmi'      , l( 400.0),       0 ,  1)
                                     , (IoPin.NORTH, 'p_reset'  , l( 500.0),       0 ,  1)
                                     , (IoPin.NORTH, 'rdy'      , l( 600.0),       0 ,  1)
                                     , (IoPin.NORTH, 'start'    , l( 700.0),       0 ,  1)
                                     , (IoPin.NORTH, 'rd'       , l( 800.0),       0 ,  1)
                                     , (IoPin.NORTH, 'sync'     , l( 900.0),       0 ,  1)
                                     , (IoPin.NORTH, 'wt'       , l(1000.0),       0 ,  1)
                                     ]
                            )
        block.state.cfg.misc.logMode        = True
        block.state.cfg.etesian.spaceMargin = 0.10
        block.state.cfg.etesian.aspectRatio = 0.90
        block.state.editor                  = editor
        block.state.useClockTree            = True
        block.state.fixedWidth              = l(1400)
        rvalue = block.build()
    except Exception, e:
        helpers.io.catch( e )
        rvalue = False

    sys.stdout.flush()
    sys.stderr.flush()
        
    return rvalue
