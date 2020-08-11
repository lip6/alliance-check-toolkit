#!/usr/bin/env python

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
from   Hurricane  import Transformation
from   plugins.alpha.block.block         import Block
from   plugins.alpha.block.configuration import IoPin

helpers.loadUserSettings()
af = CRL.AllianceFramework.get()


def scriptMain ( **kw ):
    """The mandatory function that Coriolis CGT/Unicorn will look for."""
    global af

    rvalue = True
    try:
        helpers.setTraceLevel( 550 )
        cell, editor = plugins.kwParseMain( **kw )

        add = af.getCell( 'add', CRL.Catalog.State.Views )
        blockAdd = Block.create \
            ( add
            , ioPins=[ (IoPin.SOUTH|IoPin.A_BEGIN, 'a({})', l( 10.0), l(20.0), 16)
                     , (IoPin.SOUTH|IoPin.A_BEGIN, 'b({})', l( 20.0), l(20.0), 16)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'o({})', l(100.0), l(10.0), 16)
                     ]
            )
        blockAdd.state.cfg.etesian.spaceMargin = 0.10
        blockAdd.state.fixedHeight = l(400)
        blockAdd.state.useSpares   = False
        blockAdd.state.editor      = editor
       #rvalue = blockAdd.build()
        
        sub = af.getCell( 'sub', CRL.Catalog.State.Views )
        blockSub = Block.create \
            ( sub
            , ioPins=[ (IoPin.SOUTH|IoPin.A_BEGIN, 'a({})', l( 10.0), l(20.0), 16)
                     , (IoPin.SOUTH|IoPin.A_BEGIN, 'b({})', l( 20.0), l(20.0), 16)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'o({})', l(100.0), l(10.0), 16)
                     ]
            )
        blockSub.state.cfg.etesian.spaceMargin = 0.10
        blockSub.state.fixedHeight = l(400)
        blockSub.state.useSpares   = False
        blockSub.state.editor      = editor
       #rvalue = blockSub.build()

        alu16      = af.getCell( 'alu16', CRL.Catalog.State.Logical )
        blockAlu16 = Block.create \
            ( alu16
            , ioPins=[ (IoPin.WEST |IoPin.A_BEGIN, 'clk'  , l(400.0) )
                     , (IoPin.WEST |IoPin.A_BEGIN, 'rst'  , l(140.0) )
                     , (IoPin.WEST |IoPin.A_BEGIN, 'op'   , l(200.0) )
                     , (IoPin.SOUTH|IoPin.A_BEGIN, 'a({})', l( 50.0), l(60.0), 16)
                     , (IoPin.SOUTH|IoPin.A_BEGIN, 'b({})', l( 80.0), l(60.0), 16)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'o({})', l( 50.0), l(60.0), 16)
                     ]
            )
        blockAlu16.useBlockInstance( 'subckt_48_add'
                                    , Transformation( l(100), l(100), Transformation.Orientation.ID ))
        blockAlu16.useBlockInstance( 'subckt_49_sub'
                                    , Transformation( l(600), l(100), Transformation.Orientation.ID ))
        blockAlu16.setUnexpandPins( IoPin.SOUTH )
        blockAlu16.state.cfg.etesian.uniformDensity    =  True
        blockAlu16.state.cfg.etesian.aspectRatio       =  1.0
        blockAlu16.state.cfg.etesian.spaceMargin       =  0.07
        blockAlu16.state.cfg.katana.searchHalo         =  20
        blockAlu16.state.cfg.katana.vTracksReservedMin =  1
        blockAlu16.state.cfg.katana.hTracksReservedMin =  1
        blockAlu16.state.fixedHeight = l( 750)
        blockAlu16.state.fixedWidth  = l(1050)
        blockAlu16.state.useSpares   = False
        blockAlu16.state.editor      = editor
        rvalue = blockAlu16.build()

        alu16.setName( 'alu16_r' )
        af.saveCell( alu16, CRL.Catalog.State.Views )
    except Exception, e:
        helpers.io.catch( e )
        rvalue = False

    sys.stdout.flush()
    sys.stderr.flush()
        
    return rvalue


if __name__ == '__main__':
   try:
       kw           = {}
       success      = scriptMain( **kw )
       shellSuccess = 0
       if not success: shellSuccess = 1
   except ImportError, e:
       showPythonTrace( __file__, e, False )
       sys.exit(1)
   except Exception, e:
       showPythonTrace( __file__, e )
       sys.exit(2)

   sys.exit( shellSuccess )
