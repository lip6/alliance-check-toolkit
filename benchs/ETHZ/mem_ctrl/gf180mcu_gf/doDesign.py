#!/usr/bin/env python3

import sys
import os
import traceback
from   coriolis            import Cfg, CRL
from   coriolis.Hurricane  import DbU, Breakpoint
from   coriolis.helpers.io import ErrorMessage, WarningMessage, catch
from   coriolis.helpers    import loadUserSettings, setTraceLevel, overlay, trace, l, u, n
loadUserSettings()
from   coriolis            import plugins
from   coriolis.plugins.block.block          import Block
from   coriolis.plugins.block.configuration  import IoPin, GaugeConf
from   coriolis.plugins.block.spares         import Spares
from   coriolis.plugins.chip.configuration   import ChipConf
from   coriolis.plugins.chip.chip            import Chip
from   pdks.gf180mcu.core2chip.gf180mcu      import CoreToChip

af        = CRL.AllianceFramework.get()
buildChip = False



def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""

    global af, buildChip
    rvalue    = True
    gaugeName = None
    with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
        cfg.misc.catchCore              = False
        cfg.misc.info                   = False
        cfg.misc.paranoid               = False
        cfg.misc.bug                    = False
        cfg.misc.logMode                = True
        cfg.misc.verboseLevel1          = True
        cfg.misc.verboseLevel2          = True
        cfg.misc.minTraceLevel          = 16000
        cfg.misc.maxTraceLevel          = 17000
        cfg.anabatic.routingGauge       = None   # Trigger disk loading.
        gaugeName = cfg.anabatic.routingGauge
    try:
        #setTraceLevel( 540 )
        #Breakpoint.setStopLevel( 99 )
        buildChip = False
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'mem_ctrl', CRL.Catalog.State.Logical )
        if not cell:
            cell = CRL.Blif.load( 'mem_ctrl' )
        if editor:
            editor.setCell( cell ) 
            editor.setDbuMode( DbU.StringModePhysical )
        sliceHeight = af.getCellGauge().getSliceHeight()
        sliceStep   = af.getCellGauge().getSliceStep  ()
        vspace     = 1
        hspace     = 1
        ioPadsSpec = [ ]
        ioPinsSpec = [ (IoPin.SOUTH|IoPin.A_BEGIN, 'pi{:04}',   vspace, 4*vspace, range(0, 1204))
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'po{:04}', 2*vspace, 3*vspace, range(0, 1231))
                     ]
        designConf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        designConf.cfg.tramontana.mergeSupplies    = True
        designConf.cfg.etesian.bloat               = 'disabled'
        designConf.cfg.etesian.densityVariation    = 0.05
        designConf.cfg.etesian.aspectRatio         = 1.0
       # etesian.spaceMargin is ignored if the coreSize is directly set.
        designConf.cfg.etesian.spaceMargin         = 0.55
        designConf.cfg.anabatic.globalIterations   = 15
       #designConf.cfg.katana.searchHalo           = 2
        designConf.cfg.katana.hTracksReservedLocal = 10
       #designConf.cfg.katana.vTracksReservedLocal = 10
        designConf.cfg.katana.hTracksReservedMin   = 6
       #designConf.cfg.katana.vTracksReservedMin   = 7
        designConf.cfg.katana.trackFill            = 0
        designConf.cfg.katana.runRealignStage      = False
        designConf.cfg.block.spareSide             = 10*sliceHeight
        designConf.editor              = editor
        designConf.ioPinsInTracks      = True
       #designConf.useSpares           = True
       #designConf.useHFNS             = True
        designConf.bColumns            = 2
        designConf.bRows               = 2
        designConf.chipName            = 'chip'
        designConf.coreToChipClass     = CoreToChip
        designConf.coreSize            = designConf.computeCoreSize( 270*2*sliceHeight, 5.0 )
       #designConf.coreSize            = ( 620*sliceStep, 86*sliceHeight )
       #designConf.chipSize            = ( u( 8*85 + 2*270.0), u( 8*85 + 2*300.0) )
       #designConf.doLvx               = 'corona'
       #designConf.useHTree( 'clk', Spares.HEAVY_LEAF_LOAD )
       #designConf.useHTree( 'resetn' )
        if buildChip:
            chipBuilder = Chip( designConf )
            chipBuilder.doChipNetlist()
            chipBuilder.doChipFloorplan()
            if editor:
                editor.setCell( designConf.chip )
            rvalue = chipBuilder.doPnR()
            chipBuilder.save()
        else:
            blockBuilder = Block( designConf )
            rvalue = blockBuilder.doPnR()
            blockBuilder.save()
    except Exception as e:
        catch( e )
        rvalue = False
    sys.stdout.flush()
    sys.stderr.flush()
    return rvalue


if __name__ == '__main__':
    rvalue = scriptMain()
    shellRValue = 0 if rvalue else 1
    sys.exit( shellRValue )
