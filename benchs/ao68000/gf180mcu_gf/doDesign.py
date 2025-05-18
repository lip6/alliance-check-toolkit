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
#from   coriolis.plugins.core2chip.niolib    import CoreToChip
from   coriolis.plugins.chip.configuration  import ChipConf
from   coriolis.plugins.chip.chip           import Chip


af = CRL.AllianceFramework.get()


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af

    gaugeName = None
    with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
        cfg.misc.verboseLevel1    = True
        cfg.misc.verboseLevel2    = True
        cfg.anabatic.routingGauge = None   # Trigger disk loading.
        gaugeName = cfg.anabatic.routingGauge

    hpitch       = 0
    vpitch       = 0
    routingGauge = af.getRoutingGauge( gaugeName )
    for layerGauge in routingGauge.getLayerGauges():
        if layerGauge.getType() in [ CRL.RoutingLayerGauge.PinOnly
                                   , CRL.RoutingLayerGauge.Unusable
                                   , CRL.RoutingLayerGauge.BottomPowerSupply ]:
            continue
        if not hpitch and layerGauge.getDirection() == CRL.RoutingLayerGauge.Horizontal:
            hpitch = layerGauge.getPitch()
        if not vpitch and layerGauge.getDirection() == CRL.RoutingLayerGauge.Vertical:
            vpitch = layerGauge.getPitch()
    sliceHeight = af.getCellGauge().getSliceHeight()
    sliceStep   = af.getCellGauge().getSliceStep  ()
    print( '  o  Looked up gauge/pitch values.' )
    print( '     - hpitch: {:>20}.'     .format( DbU.getValueString( hpitch ) ))
    print( '     - vpitch: {:>20}.'     .format( DbU.getValueString( vpitch ) ))
    print( '     - sliceHeight: {:>15}.'.format( DbU.getValueString( sliceHeight ) ))
    vpitchedSliceHeight = sliceHeight - sliceHeight%hpitch
    hpitchedSliceHeight = sliceHeight - sliceHeight%vpitch

    rvalue = True
    try:
        #setTraceLevel( 550 )
        #for cell in af.getAllianceLibrary(1).getLibrary().getCells():
        #    print( '"{}" {}'.format(cell.getName(),cell) )
        Breakpoint.setStopLevel( 99 )
        buildChip = False
        cell, editor = plugins.kwParseMain( **kw )
        cell = CRL.Blif.load( 'ao68000' )
        if editor:
            editor.setCell( cell ) 
            editor.setDbuMode( DbU.StringModePhysical )
        vspace     = hpitch * 10
        hspace     = vpitch * 8
        # ioPinsSpec, for peripheral pin placement as a standalone block.
        ioPinsSpec = [ (IoPin.WEST |IoPin.A_BEGIN, 'ack_i'    , vpitch//2 +  1*vspace, 0, 1)
                    #, (IoPin.WEST |IoPin.A_BEGIN, 'clk_i'    , vpitch//2 +  2*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'err_i'    , vpitch//2 +  3*vspace, 0, 1)
                    #, (IoPin.WEST |IoPin.A_BEGIN, 'reset_n'  , vpitch//2 +  4*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'rty_i'    , vpitch//2 +  5*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'blk_o'    , vpitch//2 +  6*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'blocked_o', vpitch//2 +  7*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'cyc_o'    , vpitch//2 +  8*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'reset_o'  , vpitch//2 +  9*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'rmw_o'    , vpitch//2 + 10*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'sgl_o'    , vpitch//2 + 11*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'stb_o'    , vpitch//2 + 12*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'we_o'     , vpitch//2 + 13*vspace, 0, 1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'ipl_i({})', vpitch//2 + 14*vspace, vspace, 3 )
                     , (IoPin.WEST |IoPin.A_BEGIN, 'bte_o({})', vpitch//2 + 17*vspace, vspace, 2 )
                     , (IoPin.WEST |IoPin.A_BEGIN, 'cti_o({})', vpitch//2 + 19*vspace, vspace, 3 )
                     , (IoPin.WEST |IoPin.A_BEGIN,  'fc_o({})', vpitch//2 + 22*vspace, vspace, 3 )
                     , (IoPin.WEST |IoPin.A_BEGIN, 'sel_o({})', vpitch//2 + 26*vspace, vspace, 4 )
                     , (IoPin.SOUTH|IoPin.A_BEGIN, 'dat_i({})',                hspace, hspace, 32 )
                     , (IoPin.EAST |IoPin.A_BEGIN, 'adr_o({})', vpitch//2 +    vspace,  5*vspace, 32 )
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'dat_o({})',                hspace,  5*hspace, 32 )
                     ]
       #ioPinsSpec = []
        ao68000Conf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=[] ) 
        ao68000Conf.cfg.etesian.bloat               = 'disabled'
       #ao68000Conf.cfg.etesian.bloat               = 'nsxlib'
        ao68000Conf.cfg.etesian.densityVariation    = 0.05
        ao68000Conf.cfg.etesian.aspectRatio         = 1.0
       # etesian.spaceMargin is ignored if the coreSize is directly set.
       #ao68000Conf.cfg.etesian.spaceMargin         = 0.10
       #ao68000Conf.cfg.anabatic.searchHalo         = 2
        ao68000Conf.cfg.anabatic.globalIterations   = 6
        ao68000Conf.cfg.katana.hTracksReservedLocal = 6
        ao68000Conf.cfg.katana.vTracksReservedLocal = 5
        ao68000Conf.cfg.katana.hTracksReservedMin   = 5
        ao68000Conf.cfg.katana.vTracksReservedMin   = 6
        ao68000Conf.cfg.katana.trackFill            = 0
        ao68000Conf.cfg.katana.runRealignStage      = True
        ao68000Conf.cfg.block.spareSide             = 16*sliceHeight
        ao68000Conf.cfg.chip.padCoreSide            = 'North'
       #ao68000Conf.cfg.chip.use45corners           = False
        ao68000Conf.cfg.chip.useAbstractPads        = True
        ao68000Conf.cfg.chip.supplyRailWidth        = l(250.0)
        ao68000Conf.cfg.chip.supplyRailPitch        = l(150.0)
        ao68000Conf.editor              = editor
        ao68000Conf.useSpares           = True
        ao68000Conf.useHFNS             = False
        ao68000Conf.bColumns            = 2
        ao68000Conf.bRows               = 2
        ao68000Conf.chipName            = 'chip'
        ao68000Conf.chipConf.ioPadGauge = 'niolib'
        ao68000Conf.coreSize            = ( 200*sliceHeight, 200*sliceHeight )
        ao68000Conf.chipSize            = ( 100*sliceHeight, 100*sliceHeight )
        ao68000Conf.useHTree( 'clk', Spares.HEAVY_LEAF_LOAD )
        ao68000Conf.useHTree( 'reset' )
        if buildChip:
            ao68000ToChip = CoreToChip( ao68000Conf )
            ao68000ToChip.buildChip()
            chipBuilder = Chip( ao68000Conf )
            chipBuilder.doChipFloorplan()
            rvalue = chipBuilder.doPnR()
            chipBuilder.save()
        else:
            blockBuilder = Block( ao68000Conf )
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
