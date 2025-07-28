#!/usr/bin/env python3

import sys
import os
import traceback
from   coriolis.Hurricane  import DbU, Breakpoint
from   coriolis            import Cfg, CRL
from   coriolis.helpers.io import ErrorMessage, WarningMessage, catch
from   coriolis.helpers    import loadUserSettings, setTraceLevel, trace, overlay, l, u, n
loadUserSettings()
from   coriolis            import plugins
from   coriolis.plugins.block.block         import Block
from   coriolis.plugins.block.configuration import IoPin, GaugeConf
from   coriolis.plugins.block.spares        import Spares
from   coriolis.plugins.chip.configuration  import ChipConf
from   coriolis.plugins.chip.chip           import Chip
from   coriolis.plugins.core2chip.sky130    import CoreToChip


af        = CRL.AllianceFramework.get()
buildChip = True


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
       #setTraceLevel( 550 )
        Breakpoint.setStopLevel( 100 )
        if 'CHECK_TOOLKIT' in os.environ:
            checkToolkitDir   = os.environ[ 'CHECK_TOOLKIT' ]
            harnessProjectDir = checkToolkitDir + '/cells/sky130'
        else:
            print( '[ERROR] The "CHECK_TOOLKIT" environment variable has not been set.'  )
            print( '        Please check "./mk/users.d/user-CONFIG.mk".'  )
            sys.exit( 1 )
        routingGauge = af.getRoutingGauge( gaugeName )
        sliceHeight  = af.getCellGauge().getSliceHeight()
        sliceStep    = af.getCellGauge().getSliceStep  ()
        cell, editor = plugins.kwParseMain( **kw )
        cell = CRL.Blif.load( 'user_project_core_lambdasoc' )
        if editor:
            editor.setCell( cell ) 
            editor.setDbuMode( DbU.StringModePhysical )
        env = af.getEnvironment()
        env.setCLOCK( '^clk' )
        conf = ChipConf( cell, ioPins=[], ioPads=[] ) 
       #conf.cfg.misc.minTraceLevel          = 145
       #conf.cfg.misc.maxTraceLevel          = 146
        conf.cfg.misc.verboseLevel1          = True
        conf.cfg.misc.verboseLevel2          = True
       #conf.cfg.etesian.bloat               = 'Flexlib'
        conf.cfg.etesian.aspectRatio         = 1.0
       # etesian.spaceMargin is ignored if the coreSize is directly set.
        conf.cfg.etesian.spaceMargin         = 0.10
        conf.cfg.anabatic.globalIterations   = 20
       #conf.cfg.katana.longWireUpReserve1   = 3.0
        conf.cfg.anabatic.gcellAspectRatio   = 1.8 
        conf.cfg.katana.maxFlatEdgeOverflow  = 300
        conf.cfg.katana.hTracksReservedLocal = 20
        conf.cfg.katana.vTracksReservedLocal = 26
        conf.cfg.katana.hTracksReservedMin   = 9
        conf.cfg.katana.vTracksReservedMin   = 12
       #conf.cfg.katana.hTracksReservedMin   = 7
       #conf.cfg.katana.hTracksReservedLocal = 25
       #conf.cfg.katana.vTracksReservedMin   = 5
       #conf.cfg.katana.vTracksReservedLocal = 20
       #conf.cfg.katana.dumpMeasures         = True
       #conf.cfg.katana.longWireUpReserve1   = 2.0
        conf.cfg.block.spareSide             = sliceHeight*10
        conf.cfg.harness.path                = harnessProjectDir + '/user_project_wrapper.def'
        conf.editor              = editor
        conf.useSpares           = True
        conf.useHFNS             = True
        conf.bColumns            = 2
        conf.bRows               = 2
        conf.chipName            = 'chip'
        conf.coreSize            = conf.computeCoreSize( 300*sliceHeight )
       #conf.coreSize            = ( u(1658*0.76), u(210*6.0) )
       #conf.chipSize            = ( u(  2020.0), u(  2060.0) )
        conf.coreToChipClass     = CoreToChip
        conf.useHTree( 'io_in_from_pad(0)', Spares.HEAVY_LEAF_LOAD )
        if buildChip:
            chipBuilder = Chip( conf )
            chipBuilder.doChipNetlist()
            chipBuilder.doChipFloorplan()
            if editor:
                editor.setCell( conf.chip )
            rvalue = chipBuilder.doPnR()
            chipBuilder.save()
        else:
            conf.useHTree( 'io_in(0)', Spares.HEAVY_LEAF_LOAD )
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
