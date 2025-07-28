#!/usr/bin/env python3

import sys
import traceback
from   coriolis.Hurricane  import DbU, Breakpoint, PythonAttributes
from   coriolis            import CRL, Cfg
from   coriolis.helpers    import loadUserSettings, setTraceLevel, trace, overlay, l, u, n
from   coriolis.helpers.io import ErrorMessage, WarningMessage, catch
loadUserSettings()
from   coriolis            import plugins
from   coriolis.plugins.block.block         import Block
from   coriolis.plugins.block.configuration import IoPin, GaugeConf
from   coriolis.plugins.block.spares        import Spares
from   pdks.gf180mcu.core2chip.gf180mcu     import CoreToChip
from   coriolis.plugins.chip.configuration  import ChipConf
from   coriolis.plugins.chip.chip           import Chip


af        = CRL.AllianceFramework.get()
buildChip = False


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af, buildChip

    with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
        cfg.misc.verboseLevel1    = True
        cfg.misc.verboseLevel2    = True

    rvalue = True
    try:
        #setTraceLevel( 550 )
        #for cell in af.getAllianceLibrary(1).getLibrary().getCells():
        #    print( '"{}" {}'.format(cell.getName(),cell) )
        #Breakpoint.setStopLevel( 99 )
        cell, editor = plugins.kwParseMain( **kw )
        cell = CRL.Blif.load( 'ao68000' )
        if editor:
            editor.setCell( cell ) 
            editor.setDbuMode( DbU.StringModePhysical )
        vspace     = 8
        hspace     = 7
        # ioPinsSpec, for peripheral pin placement as a standalone block.
        ioPinsSpec = [ (IoPin.WEST |IoPin.A_BEGIN, 'ACK_I'    ,  1*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'CLK_I'    ,  2*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'ERR_I'    ,  3*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'reset_n'  ,  4*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'RTY_I'    ,  5*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'BLK_O'    ,  6*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'blocked_o',  7*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'CYC_O'    ,  8*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'reset_o'  ,  9*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'RMW_O'    , 10*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'SGL_O'    , 11*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'STB_O'    , 12*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'WE_O'     , 14*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'ipl_i({})', 15*vspace,   vspace, 3 )
                     , (IoPin.WEST |IoPin.A_BEGIN, 'BTE_O({})', 18*vspace,   vspace, 2 )
                     , (IoPin.WEST |IoPin.A_BEGIN, 'CTI_O({})', 20*vspace,   vspace, 3 )
                     , (IoPin.WEST |IoPin.A_BEGIN,  'fc_o({})', 23*vspace,   vspace, 3 )
                     , (IoPin.WEST |IoPin.A_BEGIN, 'SEL_O({})', 27*vspace,   vspace, 4 )
                     , (IoPin.SOUTH|IoPin.A_BEGIN, 'DAT_I({})',    hspace,   hspace, 32 )
                     , (IoPin.EAST |IoPin.A_BEGIN, 'ADR_O({})',    vspace, 4*vspace, range(2,32) )
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'DAT_O({})',    hspace, 4*hspace, 32 )
                     ]
        conf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=[] ) 
        conf.cfg.etesian.bloat               = 'disabled'
       #conf.cfg.etesian.bloat               = 'nsxlib'
        conf.cfg.etesian.densityVariation    = 0.05
        conf.cfg.etesian.aspectRatio         = 1.0
       # etesian.spaceMargin is ignored if the coreSize is directly set.
       #conf.cfg.etesian.spaceMargin         = 0.10
       #conf.cfg.anabatic.searchHalo         = 2
        conf.cfg.anabatic.gcellAspectRatio   = 1.8
        conf.cfg.anabatic.globalIterations   = 30
        conf.cfg.katana.maxFlatEdgeOverflow  = 300
        conf.cfg.katana.hTracksReservedLocal = 13
        conf.cfg.katana.vTracksReservedLocal = 16
        conf.cfg.katana.hTracksReservedMin   = 11
        conf.cfg.katana.vTracksReservedMin   = 12
        conf.cfg.katana.trackFill            = 0
        conf.cfg.katana.runRealignStage      = False
        conf.cfg.block.spareSide             = 8*conf.sliceHeight
        conf.editor              = editor
        conf.ioPinsInTracks      = True
        conf.useSpares           = True
        conf.useHFNS             = True
        conf.bColumns            = 2
        conf.bRows               = 2
        conf.chipName            = 'chip'
        conf.coreSize            = conf.computeCoreSize( 170*conf.sliceHeight, 1.0 )
        conf.chipSize            = ( 100*conf.sliceHeight, 100*conf.sliceHeight )
        conf.useHTree( 'CLK_I', Spares.HEAVY_LEAF_LOAD )
        conf.useHTree( 'reset_n' )
        if buildChip:
            ao68000ToChip = CoreToChip( conf )
            ao68000ToChip.buildChip()
            chipBuilder = Chip( conf )
            chipBuilder.doChipFloorplan()
            rvalue = chipBuilder.doPnR()
            chipBuilder.save()
        else:
            blockBuilder = Block( conf )
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
