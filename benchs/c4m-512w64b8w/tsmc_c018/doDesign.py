
import sys
import traceback
import collections
import CRL
import helpers
helpers.loadUserSettings()
from   helpers         import trace, l, u, n
from   helpers.io      import ErrorMessage, WarningMessage
from   helpers.overlay import UpdateSession
import plugins
from   Hurricane  import Breakpoint, DbU, Point, Box, Transformation, Instance, \
                         DataBase
from   plugins.alpha.macro.macro          import Macro
from   plugins.alpha.block.block          import Block
from   plugins.alpha.block.configuration  import IoPin, GaugeConf
from   plugins.alpha.core2chip.libresocio import CoreToChip
from   plugins.alpha.chip.configuration   import ChipConf
from   plugins.alpha.chip.chip            import Chip


af = CRL.AllianceFramework.get()


def isiterable ( pyobj ):
    if isinstance(pyobj,collections.abc.Iterable): return True
    return False


def doIoPinVector ( ioSpec, bits ):
    v = []
    if not isiterable(bits): bits = range(bits)
    if len(ioSpec) != 5:
        raise ErrorMessage( 1, [ 'doIoPinVector(): Argument "ioSpec" must have excatly 5 fields ({})'.format(len(ioSpec))
                               , '(ioSpec={})'.format(ioSpec)
                               ] )
    if not bits:
        raise ErrorMessage( 1, [ 'doIoPinVector(): Argument "bits" is neither a width nor an iterable.'
                               , '(bits={})'.format(bits)
                               ] )
    for bit in bits:
        v.append(( ioSpec[0]
                 , ioSpec[1]
                 , ioSpec[2].format(bit)
                 , ioSpec[3].format(bit)
                 , ioSpec[4].format(bit) ))
    return v


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af
    rvalue = True
    try:
        #helpers.setTraceLevel( 550 )
        Breakpoint.setStopLevel( 100 )
        buildChip = True
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'sram_test', CRL.Catalog.State.Logical )
        if editor:
            editor.setCell( cell ) 
            editor.setDbuMode( DbU.StringModePhysical )
            
        ioPadsSpec = []
        ioPadsSpec += doIoPinVector( (IoPin.WEST , None,  'a_{}',  'a({})',  'a({})'), 9 )
        ioPadsSpec += doIoPinVector( (IoPin.NORTH, None, 'we_{}', 'we({})', 'we({})'), 8 )
        ioPadsSpec += doIoPinVector( (IoPin.SOUTH, None,  'byte_in_{}',  'byte_in({})',  'byte_in({})'), 8 )
        ioPadsSpec += doIoPinVector( (IoPin.EAST , None, 'byte_out_{}', 'byte_out({})', 'byte_out({})'), 8 )
        ioPadsSpec += [ (IoPin.NORTH, None, 'clk'       , 'clk', 'clk' )
                      , (IoPin.NORTH, None, 'power_0'   , 'vdd'    )
                      , (IoPin.NORTH, None, 'ground_0'  , 'vss'    )
                      , (IoPin.NORTH, None, 'ioground_0', 'iovss'  )
                      , (IoPin.NORTH, None, 'iopower_0' , 'iovdd'  )
                      , (IoPin.NORTH, None, 'iopower_1' , 'iovdd'  )
                      , (IoPin.NORTH, None, 'rst'       , 'rst', 'rst' )
                      ]
        memoryConf = ChipConf( cell, ioPins=[], ioPads=ioPadsSpec ) 
        memoryConf.cfg.viewer.pixelThreshold       = 5
        memoryConf.cfg.etesian.bloat               = 'nsxlib'
        memoryConf.cfg.etesian.densityVariation    = 0.05
        memoryConf.cfg.etesian.aspectRatio         = 1.0
       # etesian.spaceMargin is ignored if the coreSize is directly set.
        memoryConf.cfg.etesian.spaceMargin         = 0.20
        memoryConf.cfg.anabatic.searchHalo         = 2
        memoryConf.cfg.anabatic.globalIterations   = 20
        memoryConf.cfg.anabatic.topRoutingLayer    = 'METAL5'
        memoryConf.cfg.katana.hTracksReservedLocal = 6
        memoryConf.cfg.katana.vTracksReservedLocal = 3
        memoryConf.cfg.katana.hTracksReservedMin   = 3
        memoryConf.cfg.katana.vTracksReservedMin   = 1
        memoryConf.cfg.block.spareSide             = u(200)
       #memoryConf.cfg.chip.padCoreSide            = 'North'
       #memoryConf.cfg.chip.use45corners           = False
        memoryConf.cfg.chip.useAbstractPads        = True
        memoryConf.cfg.chip.supplyRailWidth        = u(35)
        memoryConf.cfg.chip.supplyRailPitch        = u(90)
        memoryConf.editor              = editor
        memoryConf.useSpares           = False
        memoryConf.useClockTree        = False
        memoryConf.useHFNS             = False
        memoryConf.bColumns            = 2
        memoryConf.bRows               = 3
        memoryConf.chipName            = 'chip'
        memoryConf.chipConf.ioPadGauge = 'LibreSOCIO'
        memoryConf.coreSize            = ( u( 988.0), u( 988.0) )
        memoryConf.chipSize            = ( u(2000.0), u(2000.0) )

        with UpdateSession():
            coreAb = Box( 0, 0, u(988.0), u(988.0) )
            cell.setAbutmentBox( coreAb )
        
        if buildChip:
            memoryToChip = CoreToChip( memoryConf )
            memoryToChip.buildChip()
            chipBuilder = Chip( memoryConf )
            chipBuilder.doChipFloorplan()
            with UpdateSession():
                sramName = 'spblock_512w64b8w'
                sram     = DataBase.getDB().getCell( 'spblock_512w64b8w' )
                if not sram:
                    print( '[ERROR] SRAM cell "{}" not found.'.format(sramName) )
                else:
                    sliceStep   = memoryToChip.conf.sliceStep  
                    sliceHeight = memoryToChip.conf.sliceHeight
                    coreAb      = cell.getAbutmentBox()
                    sramAb      = sram.getAbutmentBox()
                   #position    = Transformation( coreAb.getXMax() - sramAb.getWidth()
                   #                              - 2*sliceHeight - 1*sliceStep
                   #                            , u(0.0)
                   #                            , Transformation.Orientation.ID )
                   #chipBuilder.placeMacro( 'spblock_512w64b8w', position )
                    position    = Transformation( coreAb.getXMax() - sramAb.getWidth()
                                                , u(0.0)
                                                , Transformation.Orientation.ID )
                    sramInst    = cell.getInstance( 'subckt_289_spblock_512w64b8w' )
                    sramInst.setTransformation( position )
                    sramInst.setPlacementStatus( Instance.PlacementStatus.FIXED )
                    memoryConf.placeArea = Box( coreAb.getXMin() 
                                              , coreAb.getYMax() - sliceHeight*18
                                              , coreAb.getXMin() + sliceHeight*18
                                              , coreAb.getYMax()
                                              )
            Breakpoint.stop( 99, 'After core block placement.' )
            rvalue = chipBuilder.doPnR()
            chipBuilder.save()
            CRL.Gds.save( memoryConf.chip )
        else:
            blockBuilder = Block( memoryConf )
            rvalue = blockBuilder.doPnR()
            blockBuilder.save()
            CRL.Gds.save( memoryConf.cell )
    except Exception as e:
        helpers.io.catch( e )
        rvalue = False
    sys.stdout.flush()
    sys.stderr.flush()
    return rvalue
