
import sys
import traceback
from   coriolis.Hurricane  import DbU, Breakpoint
from   coriolis            import CRL, Cfg
from   coriolis.helpers    import loadUserSettings, setTraceLevel, trace, overlay, l, u, n
from   coriolis.helpers.io import ErrorMessage, WarningMessage, catch
loadUserSettings()
from   coriolis            import plugins
from   coriolis.plugins.block.block          import Block
from   coriolis.plugins.block.configuration  import IoPin, GaugeConf
from   coriolis.plugins.block.spares         import Spares
from   coriolis.plugins.chip.configuration   import ChipConf
from   coriolis.plugins.chip.chip            import Chip
from   pdks.gf180mcu.core2chip.gf180mcu      import CoreToChip


buildChip = False
af        = CRL.AllianceFramework.get()


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
        cfg.misc.catchCore              = False
        cfg.misc.info                   = False
        cfg.misc.paranoid               = False
        cfg.misc.bug                    = False
        cfg.misc.logMode                = True
        cfg.misc.verboseLevel1          = True
        cfg.misc.verboseLevel2          = True
        cfg.misc.minTraceLevel          = 14500
        cfg.misc.maxTraceLevel          = 15000

    global buildChip, af
    hpitch       = 0
    vpitch       = 0
    gaugeName    = Cfg.getParamString('anabatic.routingGauge').asString()
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
    rvalue = True
    try:
        #setTraceLevel( 550 )
        #Breakpoint.setStopLevel( 100 )
        cell, editor = plugins.kwParseMain( **kw )
        cell = CRL.Blif.load( 'adder' )
        if editor:
            editor.setCell( cell ) 
            editor.setDbuMode( DbU.StringModePhysical )
        ioPadsSpec = [ (IoPin.WEST , None    , 'a_0'        , 'a(0)'   , 'a(0)'  )
                     , (IoPin.WEST , None    , 'a_1'        , 'a(1)'   , 'a(1)'  )
                     , (IoPin.WEST , None    , 'a_2'        , 'a(2)'   , 'a(2)'  )
                     , (IoPin.WEST , None    , 'a_3'        , 'a(3)'   , 'a(3)'  )
                     , (IoPin.WEST , None    , 'allpower_0' , 'iovdd'  , 'VDD'   )
                     , (IoPin.WEST , None    , 'allground_0', 'iovss'  , 'VSS'   )
                     , (IoPin.WEST , None    , 'b_0'        , 'b(0)'   , 'b(0)'  )
                     , (IoPin.WEST , None    , 'b_1'        , 'b(1)'   , 'b(1)'  )
                     , (IoPin.WEST , None    , 'b_2'        , 'b(2)'   , 'b(2)'  )
                     , (IoPin.WEST , None    , 'b_3'        , 'b(3)'   , 'b(3)'  )
                     , (IoPin.SOUTH, None    , 'allpower_1' , 'iovdd'  , 'VDD'   )
                     , (IoPin.SOUTH, None    , 'allground_1', 'iovss'  , 'VSS'   )
                     , (IoPin.EAST , None    , 'f_0'        , 'f(0)'   , 'f(0)'  )
                     , (IoPin.EAST , None    , 'f_1'        , 'f(1)'   , 'f(1)'  )
                     , (IoPin.EAST , None    , 'f_2'        , 'f(2)'   , 'f(2)'  )
                     , (IoPin.EAST , None    , 'f_3'        , 'f(3)'   , 'f(3)'  )
                     , (IoPin.NORTH, u(400.0), 'm_clock'    , 'm_clock', 'm_clock' )
                     , (IoPin.NORTH, u(500.0), 'p_reset'    , 'p_reset', 'p_reset' )
                     ]
        vspace = 19
        hspace = 2
        ioPinsSpec = [ (IoPin.WEST |IoPin.A_BEGIN, 'a({})'  , vspace   , vspace, 4)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'b({})'  , vspace*6 , vspace, 4)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'f({})'  , vspace   , vspace, 4)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'p_reset', hspace*10,      0, 1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'm_clock', hspace*50,      0, 1)
                     ]
       #ioPinsSpec = []
        conf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        conf.cfg.viewer.pixelThreshold       = 5
        conf.cfg.etesian.bloat               = 'disabled'
        conf.cfg.etesian.densityVariation    = 0.05
        conf.cfg.etesian.aspectRatio         = 1.0
       # etesian.spaceMargin is ignored if the coreSize is directly set.
        conf.cfg.etesian.spaceMargin         = 0.20
        conf.cfg.anabatic.searchHalo         = 2
        conf.cfg.anabatic.globalIterations   = 10
        conf.cfg.katana.hTracksReservedLocal = 6
        conf.cfg.katana.vTracksReservedLocal = 6
        conf.cfg.katana.hTracksReservedMin   = 1
        conf.cfg.katana.vTracksReservedMin   = 1
        conf.cfg.block.spareSide             = 8*conf.sliceHeight
        conf.cfg.chip.padCoreSide            = 'North'
        conf.editor              = editor
        conf.ioPinsInTracks      = True
        conf.useSpares           = True
        conf.useClockTree        = True
        conf.useHFNS             = False
        conf.bColumns            = 2
        conf.bRows               = 2
        conf.chipName            = 'chip'
        conf.doLvx               = 'corona'
        conf.coreSize            = conf.computeCoreSize( 25*conf.sliceHeight, 1.0 )
        conf.chipSize            = ( 300*conf.sliceHeight, 300*conf.sliceHeight )
        conf.coreToChipClass     = CoreToChip
        if buildChip:
            conf.useHTree( 'm_clock_from_pad' )
            chipBuilder = Chip( conf )
            chipBuilder.doChipNetlist()
            chipBuilder.doChipFloorplan()
            rvalue = chipBuilder.doPnR()
            chipBuilder.save()
        else:
            conf.useHTree( 'm_clock' )
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
    shellRValue = 0 if rvalue else 1
    sys.exit( shellRValue )
