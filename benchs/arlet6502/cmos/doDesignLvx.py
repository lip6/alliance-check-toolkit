#!/usr/bin/env python3

useNiolib = False

import sys
import traceback
from   coriolis.Hurricane  import DataBase, DbU, Breakpoint, PythonAttributes, Vertical, Net
from   coriolis            import CRL, Cfg
from   coriolis.Tramontana import TramontanaEngine
from   coriolis.helpers    import loadUserSettings, setTraceLevel, trace, overlay, l, u, n
from   coriolis.helpers.io import ErrorMessage, WarningMessage, catch
loadUserSettings()
from   coriolis            import plugins
from   coriolis.plugins.block.block         import Block
from   coriolis.plugins.block.configuration import IoPin, GaugeConf
from   coriolis.plugins.block.spares        import Spares
if useNiolib:
    from coriolis.plugins.core2chip.niolib  import CoreToChip
else:
    from coriolis.plugins.core2chip.cmos    import CoreToChip
from   coriolis.plugins.chip.configuration  import ChipConf
from   coriolis.plugins.chip.chip           import Chip


af = CRL.AllianceFramework.get()




def makeDeepShort ():
    """
    Shorting in 35,1050  oa2ao222_x2, subckt_279_oa2ao222_x2, SYM_Y
      --> n600 and n375
    Resulting shorted net : "n375"
    """
    metal2 = DataBase.getDB().getTechnology().getLayer( 'METAL2' )
    with overlay.UpdateSession():
        stdCell = DataBase.getDB().getCell( 'o3_x2' )
        shortNet = Net.create( stdCell, 'deepShort' )
        Vertical.create( shortNet, metal2, l(10.0), l(2.0), l(15.0), l(20.0) )
    print( 'RESULTING SHORTED NET SHOULD BE "n375"' )


def makeShort ( cell ):
    """
    Resulting shorted net : "short"
    """
    metal2 = DataBase.getDB().getTechnology().getLayer( 'METAL2' )
    with overlay.UpdateSession():
        shortNet = Net.create( cell, 'short' )
        Vertical.create( shortNet, metal2, l(50.0), l(2.0), l(0.0), l(50.0) )
    print( 'RESULTING SHORTED NET SHOULD BE "short"' )


def makePowerShort ( cell ):
    """
    Resulting shorted net : "short"
    """
    metal1 = DataBase.getDB().getTechnology().getLayer( 'METAL1' )
    with overlay.UpdateSession():
        shortNet = Net.create( cell, 'short' )
        Vertical.create( shortNet, metal1, l(1340.0), l(2.0), l(190.0), l(200.0) )
    print( 'RESULTING SHORTED NET SHOULD BE "short"' )


def makeOpen ( cell ):
    """
    Resulting opened net : "abc_11869_new_n375"
    """
    with overlay.UpdateSession():
        openNet = cell.getNet( 'abc_11869_new_n375' )
        for component in openNet.getComponents():
            if component.getId() == 40474:
                component.destroy()
                break
    print( 'RESULTING OPEN NET SHOULD BE "n375"' )


def makeOpenClock ( cell ):
    """
    Resulting opened net : "clk_root_bl_bl_0"
    """
    componentsId = (37499, 37494, 37476, 59478)
    destroyComponents = []
    openNet = cell.getNet( 'clk_root_bl_bl_0' )
    for component in openNet.getComponents():
        if component.getId() in componentsId:
            destroyComponents.append( component )
    with overlay.UpdateSession():
        for component in destroyComponents:
            component.destroy()
    print( 'RESULTING OPEN NET SHOULD BE "clk_root_bl_bl_0"' )


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global useNiolib
    def addSupplyPads ( side, specs ):
        global useNiolib
        if useNiolib:
            specs.append( (side, None, 'iopower_{}' .format( addSupplyPads.count ), 'iovdd'  ))
            specs.append( (side, None, 'power_{}'   .format( addSupplyPads.count ), 'vdd'    ))
            specs.append( (side, None, 'ground_{}'  .format( addSupplyPads.count ), 'vss'    ))
            specs.append( (side, None, 'ioground_{}'.format( addSupplyPads.count ), 'vss'    ))
        else:
            specs.append( (side, None, 'allpower_{}' .format( addSupplyPads.count ), 'vddpad' , 'vdd' ))
            specs.append( (side, None, 'allground_{}'.format( addSupplyPads.count ), 'vsspad' , 'vss' ))
        addSupplyPads.count += 1
    addSupplyPads.count = 0
        
    with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
        cfg.misc.catchCore              = False
        cfg.misc.info                   = False
        cfg.misc.paranoid               = False
        cfg.misc.bug                    = False
        cfg.misc.logMode                = False
        cfg.misc.verboseLevel1          = True
        cfg.misc.verboseLevel2          = True
        cfg.misc.minTraceLevel          = 16000
        cfg.misc.maxTraceLevel          = 17000
        cfg.etesian.graphics            = 2

    global af
    rvalue = True
    try:
        #setTraceLevel( 550 )
        #Breakpoint.setStopLevel( 100 )
        buildChip = False
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'arlet6502', CRL.Catalog.State.Logical )
        if editor:
            editor.setCell( cell ) 
            editor.setDbuMode( DbU.StringModePhysical )
        ioPadsSpec = []
        ioPadsSpec.append(( IoPin.WEST , None, 'di_{}'  , 'di({})' , 'di({})', range( 0, 4) ))
        addSupplyPads(      IoPin.WEST , ioPadsSpec )
        ioPadsSpec.append(( IoPin.WEST , None, 'di_{}'  , 'di({})' , 'di({})', range( 4, 8) ))
                            
        ioPadsSpec.append(( IoPin.SOUTH, None, 'do_{}'  , 'do({})' , 'do({})', range( 0, 5) ))
        addSupplyPads(      IoPin.SOUTH, ioPadsSpec )
        ioPadsSpec.append(( IoPin.SOUTH, None, 'do_{}'  , 'do({})' , 'do({})', range( 5, 8) ))
        ioPadsSpec.append(( IoPin.SOUTH, None, 'a_{}'   , 'a({})'  , 'a({})' , range( 0, 2) ))
                            
        ioPadsSpec.append(( IoPin.EAST , None, 'a_{}'   , 'a({})'  , 'a({})' , range( 2, 8) ))
        addSupplyPads(      IoPin.EAST , ioPadsSpec )
        ioPadsSpec.append(( IoPin.EAST , None, 'a_{}'   , 'a({})'  , 'a({})' , range( 8,14) ))

        ioPadsSpec.append(( IoPin.NORTH, None, 'irq'    , 'irq'    , 'irq'    ))
        ioPadsSpec.append(( IoPin.NORTH, None, 'nmi'    , 'nmi'    , 'nmi'    ))
        ioPadsSpec.append(( IoPin.NORTH, None, 'rdy'    , 'rdy'    , 'rdy'    ))
        if useNiolib:
            ioPadsSpec.append(( IoPin.NORTH, None, 'clk', 'clk', 'clk' ))
        else:
            ioPadsSpec.append(( IoPin.NORTH, None, 'clock_0', 'clk', 'clk'))
        addSupplyPads(      IoPin.NORTH, ioPadsSpec )
        ioPadsSpec.append(( IoPin.NORTH, None, 'reset'  , 'reset'  , 'reset'  ))
        ioPadsSpec.append(( IoPin.NORTH, None, 'we'     , 'we'     , 'we'     ))
        ioPadsSpec.append(( IoPin.NORTH, None, 'a_{}'   , 'a({})'  , 'a({})' , range(14,16) ))
        ioPinsSpec = [ (IoPin.WEST |IoPin.A_BEGIN, 'di({})'  ,    l(50.0), l(50.0),  8)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'do({})'  , 14*l(50.0), l(50.0),  8)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'a({})'   ,    l(50.0), l(50.0), 16)
                     
                     #, (IoPin.NORTH|IoPin.A_BEGIN, 'clk'     , 10*l(50.0),      0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'irq'     , 11*l(50.0),      0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'nmi'     , 12*l(50.0),      0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'rdy'     , 13*l(50.0),      0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'we'      , 14*l(50.0),      0 ,  1)
                     #, (IoPin.NORTH|IoPin.A_BEGIN, 'reset'   , 15*l(50.0),      0 ,  1)
                     ]
        arlet6502Conf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        arlet6502Conf.cfg.tramontana.mergeSupplies    = True
        arlet6502Conf.cfg.etesian.bloat               = 'disabled'
        #arlet6502Conf.cfg.etesian.bloat               = 'nsxlib'
        arlet6502Conf.cfg.etesian.densityVariation    = 0.05
        arlet6502Conf.cfg.etesian.aspectRatio         = 1.0
        # etesian.spaceMargin is ignored if the coreSize is directly set.
        #arlet6502Conf.cfg.etesian.spaceMargin         = 0.10
        #arlet6502Conf.cfg.anabatic.searchHalo         = 2
        arlet6502Conf.cfg.anabatic.globalIterations   = 10
        arlet6502Conf.cfg.anabatic.topRoutingLayer    = 'METAL5'
        arlet6502Conf.cfg.katana.hTracksReservedLocal = 10
        arlet6502Conf.cfg.katana.vTracksReservedLocal = 10
        arlet6502Conf.cfg.katana.hTracksReservedMin   = 7
        arlet6502Conf.cfg.katana.vTracksReservedMin   = 5
        arlet6502Conf.cfg.katana.trackFill            = 0
        arlet6502Conf.cfg.katana.runRealignStage      = True
        arlet6502Conf.cfg.block.spareSide             = l(7*50.0)
        arlet6502Conf.cfg.chip.supplyRailWidth        = l(250.0)
        arlet6502Conf.cfg.chip.supplyRailPitch        = l(150.0)
        arlet6502Conf.editor              = editor
        arlet6502Conf.doLvx               = False
        arlet6502Conf.useSpares           = True
        arlet6502Conf.useHFNS             = True
        arlet6502Conf.bColumns            = 2
        arlet6502Conf.bRows               = 2
        arlet6502Conf.chipConf.ioPadGauge = 'pxlib'
        arlet6502Conf.chipName            = 'chip'
       #arlet6502Conf.coreSize            = ( l( 35*50.0), l( 39*50.0) )
        arlet6502Conf.coreSize            = ( l( 33*50.0), l( 33*50.0) )
        if useNiolib:
            arlet6502Conf.chipSize        = ( l(  9400.0), l(10400.0) )
        else:
            arlet6502Conf.chipSize        = ( 14*l(200.0)+2*l(400.0), 16*l(200.0)+2*l(400.0) )
        arlet6502Conf.coreToChipClass     = CoreToChip
        if buildChip:
            clockName = 'clk'
            if useNiolib: clockName = clockName + '_from_pad'
            arlet6502Conf.useHTree( clockName, Spares.HEAVY_LEAF_LOAD )
            arlet6502Conf.useHTree( 'reset' )
            chipBuilder = Chip( arlet6502Conf )
            chipBuilder.doChipNetlist()
            chipBuilder.doChipFloorplan()
            rvalue = chipBuilder.doPnR()
            chipBuilder.save()
        else:
            arlet6502Conf.useHTree( 'clk', Spares.HEAVY_LEAF_LOAD )
            arlet6502Conf.useHTree( 'reset' )
            blockBuilder = Block( arlet6502Conf )
            rvalue = blockBuilder.doPnR()
            blockBuilder.save()
            #makeOpenClock( cell )
            #makeOpen( cell )
            #makePowerShort( cell )
            #makeShort( cell )
            #makeDeepShort()
            extractor = TramontanaEngine.create( blockBuilder.conf.cell )
            extractor.printConfiguration()
            extractor.extract()
            extractor.printSummary()
            if not extractor.getSuccessState():
                raise ErrorMessage( 1, 'Extraction+LVX has failed on "{}".'.format( cell.getName() ))
            extractor.destroy()
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
