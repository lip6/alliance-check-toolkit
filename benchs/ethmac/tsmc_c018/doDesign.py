
import sys
import traceback
from   pathlib    import Path
import CRL
import helpers
helpers.loadUserSettings()
from   helpers.io import ErrorMessage, WarningMessage
from   helpers    import overlay, trace, l, u, n
import plugins
from   Hurricane  import DebugSession, Breakpoint, DbU, Box , Transformation, \
                         Instance
from   plugins.alpha.block.block          import Block
from   plugins.alpha.block.configuration  import IoPin, GaugeConf
from   plugins.alpha.block.spares         import Spares
from   plugins.alpha.core2chip.libresocio import CoreToChip
from   plugins.alpha.chip.configuration   import ChipConf
from   plugins.alpha.chip.chip            import Chip
from   plugins.sram.sram_256x32           import SRAM_256x32


"""
Generator of ``ethmac`` sub-block
=================================

General outline of the block

1. The I/O pads are supposed to be facing the east side of the block,
   there are 21 of them. The height of the block have been adjusted
   match it. As we do not know the the size of the I/O pads for
   Skywater we made an educated guess.

2. The connection to the core of the circuit, that is the two wishbone
   interfaces are on the right side of the chip.

3. When the SRAM is present, it is put on the left side of the chip.

Possible options

1. With or without the standard cell based SRAM generator.
2. With or without clock tree on PHY supplied RX/TX clocks.

Experimental results
~~~~~~~~~~~~~~~~~~~~

+----------------+--------------------+----------------+-------------------+
|      Tech      |     Options        |   Wire Length  |         Area      |
+================+====================+================+===================+
| SkyWater 130nm | No SRAM  No H-Tree | 3047615 -      | 1900*2100  -      |
|                +--------------------+----------------+-------------------+
|                | No SRAM     H-Tree | 3070051 -      | 2000*2100  -      |
|                +--------------------+----------------+-------------------+
|                |    SRAM  No H-Tree | 2523052 (-17%) | 2482*1360  (-15%) |
|                +--------------------+----------------+-------------------+
|                |    SRAM     H-Tree | 2544690 (-17%) | 2508*1360  (-19%) |
+----------------+--------------------+----------------+-------------------+
| TSMC 180nm     | No SRAM  No H-Tree | 4050593 -      | 3510*1898  -      |
|                +--------------------+----------------+-------------------+
|                | No SRAM     H-Tree | 4076011 -      | 3510*1898  -      |
|                +--------------------+----------------+-------------------+
|                |    SRAM  No H-Tree | 3377114 (-17%) | 3398*1768  (-10%) |
|                +--------------------+----------------+-------------------+
|                |    SRAM     H-Tree | 3387077 (-17%) | 3431*1768  (-9%)  |
+----------------+--------------------+----------------+-------------------+

Conclusions:

1. Even with a standard cell generated SRAM we win both in term of
   wirelength and area.

2. Using the SRAM allow us to restrict the placement area so the trees
   for the RX/TX clocks coming from the I/O pads (``mrx_clk_pad_i`` and
   ``mtx_clk_pad_i``) are much more compacts.

"""


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
    rvalue         = True
    useStdCellSRAM = True
    useHTree       = True
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
            gaugeName  = 'FlexLib'
            topMetal   = 'METAL5'
            hscaling   = 1 if useStdCellSRAM else 2
            vscaling   = 1
            coreSizeX  = 270
            coreSizeY  = 146  # 21*90um = 1890um ~ 146*13um
            iopadWidth = u(80) if useStdCellSRAM else u(90.0)
        elif tech.isSky130_C4M:
            gaugeName  = 'StdCellLib'
            topMetal   = 'm4'
            hscaling   = 2 if useStdCellSRAM else 4
            vscaling   = 2
            coreSizeX  = 200 if useHTree else 190
            coreSizeY  = 210
            iopadWidth = u(60.0)
        rg = af.getRoutingGauge( gaugeName )
        cg = af.getCellGauge   ( gaugeName )
        vpitch = rg.getLayerGauge( 2 ).getPitch()
        hpitch = rg.getLayerGauge( 1 ).getPitch()
        sliceHeight = cg.getSliceHeight()

        def hp     ( v ): return v*hpitch*hscaling
        def vp     ( v ): return v*vpitch*vscaling
        def sh     ( v ): return v*sliceHeight
        def eastHP ( v ): return int( (v*iopadWidth) / hpitch ) * hpitch 

        cell, editor = plugins.kwParseMain( **kw )

        if useStdCellSRAM:
            sram = SRAM_256x32( 4, 'cmpt_eth_spram_256x32' )
            sram.placeAt()
            if editor:
                editor.setCell( sram.cell ) 
                editor.setDbuMode( DbU.StringModePhysical )
            Breakpoint.stop( 10, 'SRAM Generated' )

        cell = af.getCell( 'ethmac', CRL.Catalog.State.Logical )
        cell.uniquify( 100 )

        if useStdCellSRAM:
            with overlay.UpdateSession():
                if tech.isTSMC_C180:
                    pathToSram = [ 'subckt_195_paramod_8a8b45b7eb1cbc4ddab9c094bf37a8ebd8aaf536_eth_wishbone'
                                 , 'subckt_2501_eth_spram_256x32'
                                 ]
                elif tech.isSky130_C4M:
                    pathToSram = [ 'subckt_196_paramod_8a8b45b7eb1cbc4ddab9c094bf37a8ebd8aaf536_eth_wishbone'
                                 , 'subckt_3133_eth_spram_256x32'
                                 ]
                    
                rightExpand = vpitch*1600 if useHTree else vpitch*1550
                ab = sram.cell.getAbutmentBox()
                ab.inflate( 0, 0, rightExpand, 0 )
                cell.setAbutmentBox( ab )
                inst = cell.getInstance( pathToSram[0] ) 
                masterCell = inst.getMasterCell()
                masterCell.setAbutmentBox( ab )
                inst.setTransformation( Transformation() )
                inst.setPlacementStatus( Instance.PlacementStatus.FIXED )
                inst = masterCell.getInstance( pathToSram[1] )
                inst.setTransformation( Transformation(rightExpand,0,Transformation.Orientation.ID) )
                inst.setPlacementStatus( Instance.PlacementStatus.FIXED )
            Breakpoint.stop( 10, 'Abutment box defined' )

        setDebug( cell )
        if editor:
            editor.setCell( cell ) 
            editor.setDbuMode( DbU.StringModePhysical )
        ioPinsSpec = [ (IoPin.WEST |IoPin.A_BEGIN, 'wb_clk_i'      , hp(    5),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'wb_rst_i'      , hp(   10),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'wb_dat_i({})'  , hp(   15),  hp( 5), 32)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'wb_dat_o({})'  , hp(  175),  hp( 5), 32)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'wb_err_o'      , hp(  335),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'wb_adr_i({})'  , hp(  340),  hp( 5),  range(2,12))
                     , (IoPin.WEST |IoPin.A_BEGIN, 'wb_sel_i({})'  , hp(  590),  hp( 2),  4)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'wb_we_i'       , hp(  598),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'wb_cyc_i'      , hp(  600),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'wb_stb_i'      , hp(  605),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'wb_ack_o'      , hp(  610),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_adr_o({})', hp(  614),  hp( 4), 32)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_sel_o({})', hp(  775),  hp( 5),  4)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_we_o'     , hp(  795),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_dat_i({})', hp(  800),  hp( 5), 32)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_dat_o({})', hp(  960),  hp( 5), 32)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_cyc_o'    , hp( 1120),      0 ,  1)
                    #, (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_stb_o'    , hp( 1122),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_ack_i'    , hp( 1124),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_err_i'    , hp( 1126),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_cti_o(0)' , hp( 1128),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_cti_o(1)' , hp( 1130),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_bte_o(0)' , hp( 1132),      0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'm_wb_bte_o(1)' , hp( 1134),      0 ,  1)

                    # Must connect to 21 I/O pads on the east side.
                     , (IoPin.EAST |IoPin.A_BEGIN, 'mtx_clk_pad_i' , eastHP(  1),         0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'mtxd_pad_o({})', eastHP(  2), eastHP(1) ,  range(4))
                     , (IoPin.EAST |IoPin.A_BEGIN, 'mtxen_pad_o'   , eastHP(  6),         0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'mtxerr_pad_o'  , eastHP(  7),         0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'mrx_clk_pad_i' , eastHP(  8),         0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'mrxdv_pad_i'   , eastHP(  9),         0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'mrxd_pad_i({})', eastHP( 10), eastHP(1) ,  range(4))
                    #, (IoPin.EAST |IoPin.A_BEGIN, 'mrxen_pad_i'   , eastHP( 14),         0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'mrxerr_pad_i'  , eastHP( 15),         0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'mcoll_pad_i'   , eastHP( 16),         0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'mcrs_pad_i'    , eastHP( 17),         0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'md_pad_i'      , eastHP( 18),         0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'mdc_pad_o'     , eastHP( 19),         0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'md_pad_o'      , eastHP( 20),         0 ,  1)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'md_padoe_o'    , eastHP( 21),         0 ,  1)
                     ]
       #ioPinsSpec = []
        ethmacConf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=[] ) 
        ethmacConf.cfg.viewer.pixelThreshold       = 5
       # Disable diode protection for fair measurements.
        ethmacConf.cfg.etesian.antennaMaxWL        = 0
        ethmacConf.cfg.etesian.antennaGateMaxWL    = 0
        ethmacConf.cfg.etesian.antennaDiodeMaxWL   = 0
        ethmacConf.cfg.etesian.bloat               = 'Flexlib'
        ethmacConf.cfg.etesian.densityVariation    = 0.05
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
        ethmacConf.useSpares           = useHTree
        ethmacConf.useHFNS             = False
        ethmacConf.bColumns            = 2
        ethmacConf.bRows               = 2
        ethmacConf.chipName            = 'chip'
        ethmacConf.chipConf.ioPadGauge = 'LibreSOCIO'
        if not useStdCellSRAM:
            ethmacConf.coreSize = ( coreSizeX*sliceHeight, coreSizeY*sliceHeight )
            ethmacConf.chipSize = ( u(2020.0), u(2060.0) )
            if useHTree:
                ethmacConf.useHTree( 'mrx_clk_pad_i' )
                ethmacConf.useHTree( 'mtx_clk_pad_i' )
               #ethmacConf.useHTree( 'wb_clk_i', Spares.HEAVY_LEAF_LOAD )
               #ethmacConf.useHTree( 'clk_from_pad' )
               #ethmacConf.useHTree( 'reset_from_pad' )
               #ethmacConf.useHTree( 'core.subckt_0_cpu.abc_11829_new_n340' )
        else:
            ethmacConf.placeArea = Box( 0, 0, rightExpand, ab.getHeight()  )
            if useHTree:
                ethmacConf.useHTree( 'mrx_clk_pad_i' )
                ethmacConf.useHTree( 'mtx_clk_pad_i' )
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
