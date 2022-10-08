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

       #m1pitch    = u(0.46)
       #m2pitch    = u(0.51)

        ioPinsSpec = [ (IoPin.EAST |IoPin.A_BEGIN, 'res({})'        ,  u(  13.2),  u(  13.2),  8)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'eoc'            ,  u(  1.32),         0 ,  1)

                     , (IoPin.WEST |IoPin.A_BEGIN, 'cmp'            ,  u(  13.2),         0 ,  1)                     

                     , (IoPin.NORTH|IoPin.A_BEGIN, 'clk'            ,   u( 13.2),         0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'rst'            ,  u( 14.52),         0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'soc'            ,  u( 15.84),         0 ,  1)

                     , (IoPin.SOUTH|IoPin.A_BEGIN, 'dac_control({})',  u(  13.2),    u(13.2),  8)
                     , (IoPin.SOUTH|IoPin.A_BEGIN, 'se'             ,  u(  1.32),         0 ,  1)
                     ]
        #sarlogicConf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        sarlogicConf = ChipConf( cell, ioPins=ioPinsSpec) 
        sarlogicConf.cfg.etesian.bloat               = 'Flexlib'
       #arlet6502Conf.cfg.etesian.bloat               = 'nsxlib'
        sarlogicConf.cfg.etesian.uniformDensity      = True
        sarlogicConf.cfg.etesian.aspectRatio         = 1.0
       # etesian.spaceMargin is ignored if the coreSize is directly set.
        sarlogicConf.cfg.etesian.spaceMargin         = 0.20
        sarlogicConf.cfg.anabatic.searchHalo         = 2
        sarlogicConf.cfg.anabatic.globalIterations   = 20
        sarlogicConf.cfg.anabatic.topRoutingLayer    = 'METAL5'
        sarlogicConf.cfg.katana.hTracksReservedLocal = 6
        sarlogicConf.cfg.katana.vTracksReservedLocal = 3
        sarlogicConf.cfg.katana.hTracksReservedMin   = 3
        sarlogicConf.cfg.katana.vTracksReservedMin   = 1
        sarlogicConf.cfg.katana.trackFill            = 0
        sarlogicConf.cfg.katana.runRealignStage      = True
        sarlogicConf.cfg.block.spareSide             = u(7*13)
       #sarlogicConf.cfg.chip.padCoreSide            = 'North'
       #arlet6502Conf.cfg.chip.use45corners           = False
        sarlogicConf.cfg.chip.useAbstractPads        = True
        sarlogicConf.cfg.chip.supplyRailWidth        = u(35)
        sarlogicConf.cfg.chip.supplyRailPitch        = u(90)
        sarlogicConf.editor              = editor
        sarlogicConf.useSpares           = True
        sarlogicConf.useClockTree        = False
        sarlogicConf.useHFNS             = True
        sarlogicConf.bColumns            = 3
        sarlogicConf.bRows               = 3
        sarlogicConf.chipName            = 'chip'
       #sarlogicConf.chipConf.ioPadGauge = 'niolib'
        sarlogicConf.coreSize            = ( u(15*13.2), u(12*13.2) )
       #sarlogicConf.chipSize            = ( u(  2020.0), u(  2060.0) )
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
