#!/usr/bin/env python3

import sys
import traceback
import CRL
import helpers
helpers.loadUserSettings()
from   helpers.io import ErrorMessage, WarningMessage
from   helpers    import trace, l, u, n
import plugins
from   Hurricane  import DbU, Breakpoint
from   plugins.alpha.block.block          import Block
from   plugins.alpha.block.configuration  import IoPin, GaugeConf
from   plugins.alpha.block.spares         import Spares
from   plugins.alpha.core2chip.niolib     import CoreToChip
from   plugins.alpha.chip.configuration   import ChipConf
from   plugins.alpha.chip.chip            import Chip


af = CRL.AllianceFramework.get()


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af
    rvalue = True
    try:
       #helpers.setTraceLevel( 550 )
        Breakpoint.setStopLevel( 100 )
        buildChip = False
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'sarlogic', CRL.Catalog.State.Logical )
        if editor:
            editor.setCell( cell ) 
            editor.setDbuMode( DbU.StringModePhysical )
        ioPinsSpec = [ (IoPin.WEST |IoPin.A_BEGIN, 'res({})'        ,    l(50.0), l(50.0),  8)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'cmp'            ,    l(50.0), l(50.0),  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'dac_control({})',  9*l(50.0), l(50.0),  8)
                     
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'clk'            , 5*l(50.0),      0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'rst'            , 6*l(50.0),      0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'soc'            , 7*l(50.0),      0 ,  1)
                     , (IoPin.SOUTH|IoPin.A_BEGIN, 'se'             , 5*l(50.0),      0 ,  1)
                     , (IoPin.SOUTH|IoPin.A_BEGIN, 'eoc'            , 6*l(50.0),      0 ,  1)
                     ]
       #ioPinsSpec = []
        #sarlogicConf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        sarlogicConf = ChipConf( cell, ioPins=ioPinsSpec) 
        sarlogicConf.cfg.etesian.bloat               = 'disabled'
       #arlet6502Conf.cfg.etesian.bloat               = 'nsxlib'
        sarlogicConf.cfg.etesian.aspectRatio         = 1.0
       # etesian.spaceMargin is ignored if the coreSize is directly set.
       #arlet6502Conf.cfg.etesian.spaceMargin         = 0.10
       #arlet6502Conf.cfg.anabatic.searchHalo         = 2
        sarlogicConf.cfg.anabatic.globalIterations   = 10
        sarlogicConf.cfg.anabatic.topRoutingLayer    = 'METAL5'
       #arlet6502Conf.cfg.katana.hTracksReservedLocal = 0
       #arlet6502Conf.cfg.katana.vTracksReservedLocal = 0
        sarlogicConf.cfg.katana.hTracksReservedMin   = 7
        sarlogicConf.cfg.katana.vTracksReservedMin   = 5
        sarlogicConf.cfg.katana.trackFill            = 0
        sarlogicConf.cfg.katana.runRealignStage      = True
        sarlogicConf.cfg.block.spareSide             = l(7*50.0)
        sarlogicConf.cfg.chip.padCoreSide            = 'North'
       #arlet6502Conf.cfg.chip.use45corners           = False
        sarlogicConf.cfg.chip.useAbstractPads        = True
        sarlogicConf.cfg.chip.supplyRailWidth        = l(250.0)
        sarlogicConf.cfg.chip.supplyRailPitch        = l(150.0)
        sarlogicConf.editor              = editor
        sarlogicConf.useSpares           = True
        sarlogicConf.useHFNS             = False
        sarlogicConf.bColumns            = 2
        sarlogicConf.bRows               = 2
        sarlogicConf.chipName            = 'chip'
        sarlogicConf.chipConf.ioPadGauge = 'niolib'
        sarlogicConf.coreSize            = ( l( 15*50.0), l( 20*50.0) )
        sarlogicConf.chipSize            = ( l(  5000.0), l(  5000.0) )
        #sarlogicConf.useHTree( 'clk', Spares.HEAVY_LEAF_LOAD )
        #sarlogicConf.useHTree( 'reset' )
        if buildChip:
            sarlogicToChip = CoreToChip( sarlogicConf )
            sarlogicToChip.buildChip()
            chipBuilder = Chip( sarlogicConf )
            chipBuilder.doChipFloorplan()
            rvalue = chipBuilder.doPnR()
            chipBuilder.save()
        else:
            blockBuilder = Block( sarlogicConf )
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
