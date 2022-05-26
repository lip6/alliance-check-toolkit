
import sys
import traceback
from   pathlib    import Path
import CRL
import helpers
helpers.loadUserSettings()
from   helpers.io import ErrorMessage, WarningMessage
from   helpers    import trace, l, u, n
import plugins
from   Hurricane  import DebugSession, DbU, Breakpoint
from   plugins.alpha.block.block          import Block
from   plugins.alpha.block.configuration  import IoPin, GaugeConf
from   plugins.alpha.block.spares         import Spares
from   plugins.alpha.core2chip.libresocio import CoreToChip
from   plugins.alpha.chip.configuration   import ChipConf
from   plugins.alpha.chip.chip            import Chip


af = CRL.AllianceFramework.get()


class Tech ( object ):
    """
    Perform a quick guess of which technology we are using by looking at
    the directory the ``doDesign.py`` script is located into.
    """

    TSMC_C018  = 1
    SKY130_C4M = 2
    UNKNOWN    = 3

    def __init__ ( self ):
        scriptDir  = Path.cwd().name
        if scriptDir == 'tsmc_c018':
            self.tech = Tech.TSMC_C018
            print( '  o  Using TSMC 180nm technology settings.' )
        elif scriptDir == 'sky130_c4m':
            self.tech = Tech.SKY130_C4M
            print( '  o  Using SkyWater 130nm technology settings.' )
        else:
            raise ErrorMessage( 1, 'Tech.__init__(): Cannot guess the technology wer are using ("{}")' \
                                   .format(scriptDir) )

    @property
    def isTSMC_C180 ( self ): return self.tech == Tech.TSMC_C018

    @property
    def isSky130_C4M ( self ): return self.tech == Tech.SKY130_C4M


def setDebug ( cell ):
   #helpers.setTraceLevel( 550 )
   #DebugSession.addToTrace( cell.getNet( 'loadrxstatus' ))
   #DebugSession.addToTrace( cell.getNet( 'subckt_195_paramod_8a8b45b7eb1cbc4ddab9c094bf37a8ebd8aaf536_eth_wishbone.rxfiforeset' ))
    pass


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af
    rvalue = True
    try:
       #Breakpoint.setStopLevel( 100 )
       #
       # +--------------------------------------------------+
       # |          TSMC 180nm                              |
       # +=======================+==========================+
       # | Pitch METAL2 (H)      |  0.66um                  |
       # +-----------------------+--------------------------+
       # | Pitch METAL3 (V)      |  0.66um                  |
       # +-----------------------+--------------------------+
       # | Slice height          |  13.0um                  |
       # +-----------------------+--------------------------+
       #
       # +--------------------------------------------------+
       # |              Google/SkyWater 130nm               |
       # +=======================+==========================+
       # | Pitch METAL2 (H)      |  0.51um                  |
       # +-----------------------+--------------------------+
       # | Pitch METAL3 (V)      |  0.68um                  |
       # +-----------------------+--------------------------+
       # | Slice height          |  10.0um                  |
       # +-----------------------+--------------------------+
       #
        tech = Tech()
        if tech.isTSMC_C180:
            gaugeName = 'FlexLib'
            topMetal  = 'METAL5'
            hscaling  = 1
            vscaling  = 1
            coreSizeX = 200
            coreSizeY = 200
        elif tech.isSky130_C4M:
            gaugeName = 'StdCellLib'
            topMetal  = 'm4'
            hscaling  = 2
            vscaling  = 2
            coreSizeX = 210
            coreSizeY = 210
        rg = af.getRoutingGauge( gaugeName )
        cg = af.getCellGauge   ( gaugeName )
        vpitch = rg.getLayerGauge( 2 ).getPitch()
        hpitch = rg.getLayerGauge( 1 ).getPitch()
        sliceHeight = cg.getSliceHeight()

        def hp ( v ): return v*hpitch*hscaling
        def vp ( v ): return v*vpitch*vscaling
        def sh ( v ): return v*sliceHeight

        buildChip = False
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'ethmac', CRL.Catalog.State.Logical )
        cell.uniquify( 100 )
        setDebug( cell )
        if editor:
            editor.setCell( cell ) 
            editor.setDbuMode( DbU.StringModePhysical )
        ioPinsSpec = [ (IoPin.WEST |IoPin.A_BEGIN, 'wb_clk_i'      , hp(   10),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'wb_rst_i'      , hp(   20),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'wb_dat_i({})'  , hp(   30),  hp(10), 32)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'wb_dat_o({})'  , hp(  350),  hp(10), 32)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'wb_err_o'      , hp(  670),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'wb_adr_i({})'  , hp(  680),  hp(10),  range(2,12))
                     , (IoPin.WEST |IoPin.A_BEGIN, 'wb_sel_i({})'  , hp(  780),  hp(10),  4)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'wb_we_i'       , hp(  820),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'wb_cyc_i'      , hp(  830),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'wb_stb_i'      , hp(  840),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'wb_ack_o'      , hp(  850),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_adr_o({})', hp(  860),  hp(10), 32)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_sel_o({})', hp( 1180),  hp(10),  4)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_we_o'     , hp( 1220),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_dat_i({})', hp( 1230),  hp(10), 32)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_dat_o({})', hp( 1550),  hp(10), 32)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_cyc_o'    , hp( 1870),      0 ,  1)
                    #, (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_stb_o'    , hp( 1880),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_ack_i'    , hp( 1890),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_err_i'    , hp( 1900),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_cti_o(0)' , hp( 1910),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_cti_o(1)' , hp( 1920),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_bte_o(0)' , hp( 1930),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_bte_o(1)' , hp( 1940),      0 ,  1)

                     , (IoPin.EAST |IoPin.A_BEGIN, 'mtx_clk_pad_i' , hp(  100),      0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'mtxd_pad_o({})', hp(  200), hp(10) ,  range(4))
                     , (IoPin.EAST |IoPin.A_BEGIN, 'mtxen_pad_o'   , hp(  300),      0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'mtxerr_pad_o'  , hp(  400),      0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'mrx_clk_pad_i' , hp(  500),      0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'mrxdv_pad_i'   , hp(  600),      0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'mrxd_pad_i({})', hp(  700), hp(10) ,  range(4))
                    #, (IoPin.EAST |IoPin.A_BEGIN, 'mrxen_pad_i'   , hp(  800),      0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'mrxerr_pad_i'  , hp(  900),      0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'mcoll_pad_i'   , hp( 1000),      0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'mcrs_pad_i'    , hp( 1100),      0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'md_pad_i'      , hp( 1200),      0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'mdc_pad_o'     , hp( 1300),      0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'md_pad_o'      , hp( 1400),      0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'md_padoe_o'    , hp( 1500),      0 ,  1)
                     ]
       #ioPinsSpec = []
        ethmacConf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=[] ) 
        ethmacConf.cfg.viewer.pixelThreshold       = 5
        ethmacConf.cfg.etesian.bloat               = 'Flexlib'
        ethmacConf.cfg.etesian.uniformDensity      = True
        ethmacConf.cfg.etesian.aspectRatio         = 1.0
       # etesian.spaceMargin is ignored if the coreSize is directly set.
        ethmacConf.cfg.etesian.spaceMargin         = 0.10
        ethmacConf.cfg.anabatic.searchHalo         = 2
        ethmacConf.cfg.anabatic.globalIterations   = 20
        ethmacConf.cfg.anabatic.topRoutingLayer    = topMetal
        ethmacConf.cfg.katana.hTracksReservedLocal = 7
        ethmacConf.cfg.katana.vTracksReservedLocal = 3
        ethmacConf.cfg.katana.hTracksReservedMin   = 4
        ethmacConf.cfg.katana.vTracksReservedMin   = 1
        ethmacConf.cfg.katana.trackFill            = 0
        ethmacConf.cfg.katana.runRealignStage      = True
        ethmacConf.cfg.katana.dumpMeasures         = True
        ethmacConf.cfg.block.spareSide             = 7*sliceHeight
       #ethmacConf.cfg.chip.padCoreSide            = 'North'
       #ethmacConf.cfg.chip.use45corners           = False
        ethmacConf.cfg.chip.useAbstractPads        = True
        ethmacConf.cfg.chip.minPadSpacing          = u(1.46)
        ethmacConf.cfg.chip.supplyRailWidth        = u(35)
        ethmacConf.cfg.chip.supplyRailPitch        = u(90)
        ethmacConf.editor              = editor
        ethmacConf.useSpares           = True
        ethmacConf.useHFNS             = True
        ethmacConf.bColumns            = 2
        ethmacConf.bRows               = 2
        ethmacConf.chipName            = 'chip'
        ethmacConf.chipConf.ioPadGauge = 'LibreSOCIO'
        ethmacConf.coreSize            = ( coreSizeX*sliceHeight, coreSizeY*sliceHeight )
        ethmacConf.chipSize            = ( u(2020.0), u(2060.0) )
        ethmacConf.useHTree( 'wb_clk_i', Spares.HEAVY_LEAF_LOAD )
       #ethmacConf.useHTree( 'clk_from_pad' )
       #ethmacConf.useHTree( 'reset_from_pad' )
        #ethmacConf.useHTree( 'core.subckt_0_cpu.abc_11829_new_n340' )
        if buildChip:
            ethmacToChip = CoreToChip( ethmacConf )
            ethmacToChip.buildChip()
            chipBuilder = Chip( ethmacConf )
            chipBuilder.doChipFloorplan()
            rvalue = chipBuilder.doPnR()
            chipBuilder.save()
        else:
            blockBuilder = Block( ethmacConf )
            rvalue = blockBuilder.doPnR()
            blockBuilder.save()
    except Exception as e:
        helpers.io.catch( e )
        rvalue = False
    return rvalue


if __name__ == '__main__':
    rvalue = scriptMain()
    sys.stdout.flush()
    sys.stderr.flush()
    shellRValue = 0 if rvalue else 1
    sys.exit( shellRValue )
