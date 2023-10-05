#!/usr/bin/env python3

import sys
import os
import traceback
from   coriolis.Hurricane  import DbU, Breakpoint
from   coriolis            import CRL
from   coriolis.helpers.io import ErrorMessage, WarningMessage
from   coriolis.helpers    import loadUserSettings, setTraceLevel, trace, l, u, n
loadUserSettings()
from   coriolis            import plugins
from   coriolis.plugins.block.block         import Block
from   coriolis.plugins.block.configuration import IoPin, GaugeConf
from   coriolis.plugins.block.spares        import Spares
from   coriolis.plugins.chip.configuration  import ChipConf
from   coriolis.plugins.chip.chip           import Chip
from   coriolis.plugins.core2chip.sky130    import CoreToChip


af = CRL.AllianceFramework.get()


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af
    rvalue = True
    try:
       #setTraceLevel( 550 )
       #Breakpoint.setStopLevel( 100 )
        if 'CHECK_TOOLKIT' in os.environ:
            checkToolkitDir   = os.environ[ 'CHECK_TOOLKIT' ]
            harnessProjectDir = checkToolkitDir + '/cells/sky130'
        else:
            print( '[ERROR] The "CHECK_TOOLKIT" environment variable has not been set.'  )
            print( '        Please check "./mk/users.d/user-CONFIG.mk".'  )
            sys.exit( 1 )
        buildChip = True
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'user_project_core_lambdasoc', CRL.Catalog.State.Logical )
        if editor:
            editor.setCell( cell ) 
            editor.setDbuMode( DbU.StringModePhysical )
        conf = ChipConf( cell, ioPins=[], ioPads=[] ) 
        conf.cfg.misc.verboseLevel1          = True
        conf.cfg.misc.verboseLevel2          = True
       #conf.cfg.etesian.bloat               = 'Flexlib'
        conf.cfg.etesian.densityVariation    = 0.05
        conf.cfg.etesian.aspectRatio         = 1.0
       # etesian.spaceMargin is ignored if the coreSize is directly set.
        conf.cfg.etesian.spaceMargin         = 0.10
        conf.cfg.etesian.antennaGateMaxWL    = u(400.0)
        conf.cfg.etesian.antennaDiodeMaxWL   = u(800.0)
        conf.cfg.anabatic.saturateRatio      = 0.90
        conf.cfg.anabatic.saturateRp         = 12
        conf.cfg.anabatic.searchHalo         = 2
        conf.cfg.anabatic.globalIterations   = 20
        conf.cfg.anabatic.topRoutingLayer    = 'm4'
        conf.cfg.katana.longWireUpReserve1   = 3.0
        conf.cfg.katana.hTracksReservedLocal = 25
        conf.cfg.katana.vTracksReservedLocal = 20
        conf.cfg.katana.hTracksReservedMin   = 15
        conf.cfg.katana.vTracksReservedMin   = 10
        conf.cfg.katana.trackFill            = 0
        conf.cfg.katana.runRealignStage      = True
        conf.cfg.katana.dumpMeasures         = True
       #conf.cfg.katana.longWireUpReserve1   = 2.0
        conf.cfg.block.spareSide             = u(8*10)
        conf.cfg.chip.supplyRailWidth        = u(20.0)
        conf.cfg.chip.supplyRailPitch        = u(40.0)
        conf.cfg.harness.path                = harnessProjectDir + '/user_project_wrapper.def'
        conf.editor              = editor
        conf.useSpares           = True
        conf.useHFNS             = True
        conf.bColumns            = 2
        conf.bRows               = 2
        conf.chipName            = 'chip'
        conf.coreSize            = ( u(220*10.0), u(220*10.0) )
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
