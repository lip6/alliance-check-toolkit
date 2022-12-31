#!/usr/bin/env python3

import sys
import traceback
import CRL
import helpers
helpers.loadUserSettings()
from   helpers.io import ErrorMessage, WarningMessage
from   helpers    import trace, l, u, n
import plugins
from   Hurricane  import DbU, Breakpoint, PythonAttributes
from   Seabreeze  import SeabreezeEngine
from   plugins.alpha.block.block          import Block
from   plugins.alpha.block.configuration  import IoPin, GaugeConf
from   plugins.alpha.block.spares         import Spares
from   plugins.alpha.core2chip.niolib     import CoreToChip
from   plugins.alpha.chip.configuration   import ChipConf
from   plugins.alpha.chip.chip            import Chip


af = CRL.AllianceFramework.get()


class MyAttribute ( object ):

    count = 0

    def __init__ ( self ):
        self.value = MyAttribute.count 
        print( '{} has been created'.format(self) )
        MyAttribute.count += 1

    def __del__ ( self ):
        print( '{} has been deleted'.format(self) )

    def __str__ ( self ):
        return '<MyAttribute {}>'.format(self.value)


class MyDatas ( object ):

    def __init__ ( self ):
        self.value = 2
        print( '{} has been created'.format(self) )

    def __del__ ( self ):
        print( '{} has been deleted'.format(self) )

    def __str__ ( self ):
        return '<MyDatas {}>'.format(self.value)


class MyNetDatas ( object ):

    def __init__ ( self, net ):
        self.net = net
        print( '{} has been created'.format(self) )

    def __del__ ( self ):
        print( '{} has been deleted'.format(self) )

    def __str__ ( self ):
        return '<MyNetDatas {}>'.format(self.net)


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af
    rvalue = True
    try:
       #helpers.setTraceLevel( 550 )
       #Breakpoint.setStopLevel( 100 )
        buildChip = False
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'arlet6502', CRL.Catalog.State.Logical )
        if editor:
            editor.setCell( cell ) 
            editor.setDbuMode( DbU.StringModePhysical )
        PythonAttributes.enable( cell )
        print( type(PythonAttributes.get( cell )))
        print( dir(PythonAttributes.get( cell )))
       #PythonAttributes.get( cell ).myAttribute = MyAttribute()
        cell.myAttribute  = MyAttribute()
        cell.myAttribute1 = MyAttribute()
        sys.stdout.flush()
        sys.stderr.flush()
        print( 'cell.myAttribute=', cell.myAttribute )
        print( dir(PythonAttributes.get( cell )))
        print( 'attr numbers =', PythonAttributes.get(cell).getDictSize() )
       #del PythonAttributes.get( cell ).myAttribute
        del cell.myAttribute
        print( 'attr numbers =', PythonAttributes.get(cell).getDictSize() )
        print( dir(PythonAttributes.get( cell )))
       #PythonAttributes.destroy( cell )
       #wdatas = MyDatas()
       #PythonAttributes.add( cell, 'Python.MyDatas', MyDatas() )
        for net in cell.getNets():
            PythonAttributes.enable( net )
            net.netDatas = MyNetDatas(net)
       #rdatas = PythonAttributes.get( cell, 'Python.MyDatas' )
       #print( rdatas )
       #PythonAttributes.remove( cell, 'Python.MyDatas' )
       #sys.exit( 0 )
        ioPadsSpec = [ (IoPin.WEST , None, 'iopower_0'  , 'iovdd'  )
                     , (IoPin.WEST , None, 'ioground_0' , 'vss'    )
                     , (IoPin.WEST , None, 'di_0'       , 'di(0)'  , 'di(0)'  )
                     , (IoPin.WEST , None, 'di_1'       , 'di(1)'  , 'di(1)'  )
                     , (IoPin.WEST , None, 'di_2'       , 'di(2)'  , 'di(2)'  )
                     , (IoPin.WEST , None, 'di_3'       , 'di(3)'  , 'di(3)'  )
                     , (IoPin.WEST , None, 'power_0'    , 'vdd'    )
                     , (IoPin.WEST , None, 'ground_0'   , 'vss'    )
                     , (IoPin.WEST , None, 'di_4'       , 'di(4)'  , 'di(4)'  )
                     , (IoPin.WEST , None, 'di_5'       , 'di(5)'  , 'di(5)'  )
                     , (IoPin.WEST , None, 'di_6'       , 'di(6)'  , 'di(6)'  )
                     , (IoPin.WEST , None, 'di_7'       , 'di(7)'  , 'di(7)'  )
                     , (IoPin.WEST , None, 'ioground_1' , 'vss'    )
                     , (IoPin.WEST , None, 'iopower_1'  , 'iovdd'  )

                     , (IoPin.SOUTH, None, 'iopower_2'  , 'iovdd'  )
                     , (IoPin.SOUTH, None, 'ioground_2' , 'vss'    )
                     , (IoPin.SOUTH, None, 'do_0'       , 'do(0)'  , 'do(0)'  )
                     , (IoPin.SOUTH, None, 'do_1'       , 'do(1)'  , 'do(1)'  )
                     , (IoPin.SOUTH, None, 'do_2'       , 'do(2)'  , 'do(2)'  )
                     , (IoPin.SOUTH, None, 'do_3'       , 'do(3)'  , 'do(3)'  )
                     , (IoPin.SOUTH, None, 'do_4'       , 'do(4)'  , 'do(4)'  )
                     , (IoPin.SOUTH, None, 'do_5'       , 'do(5)'  , 'do(5)'  )
                     , (IoPin.SOUTH, None, 'do_6'       , 'do(6)'  , 'do(6)'  )
                     , (IoPin.SOUTH, None, 'do_7'       , 'do(7)'  , 'do(7)'  )
                     , (IoPin.SOUTH, None, 'a_0'        , 'a(0)'   , 'a(0)'   )
                     , (IoPin.SOUTH, None, 'a_1'        , 'a(1)'   , 'a(1)'   )
                     , (IoPin.SOUTH, None, 'iopower_3'  , 'iovdd'  )
                     , (IoPin.SOUTH, None, 'ioground_3' , 'vss'    )

                     , (IoPin.EAST , None, 'iopower_4'  , 'iovdd'  )
                     , (IoPin.EAST , None, 'ioground_4' , 'vss'    )
                     , (IoPin.EAST , None, 'a_2'        , 'a(2)'   , 'a(2)'   )
                     , (IoPin.EAST , None, 'a_3'        , 'a(3)'   , 'a(3)'   )
                     , (IoPin.EAST , None, 'a_4'        , 'a(4)'   , 'a(4)'   )
                     , (IoPin.EAST , None, 'a_5'        , 'a(5)'   , 'a(5)'   )
                     , (IoPin.EAST , None, 'a_6'        , 'a(6)'   , 'a(6)'   )
                     , (IoPin.EAST , None, 'a_7'        , 'a(7)'   , 'a(7)'   )
                     , (IoPin.EAST , None, 'power_1'    , 'vdd'    )
                     , (IoPin.EAST , None, 'ground_1'   , 'vss'    )
                     , (IoPin.EAST , None, 'a_8'        , 'a(8)'   , 'a(8)'   )
                     , (IoPin.EAST , None, 'a_9'        , 'a(9)'   , 'a(9)'   )
                     , (IoPin.EAST , None, 'a_10'       , 'a(10)'  , 'a(10)'  )
                     , (IoPin.EAST , None, 'a_11'       , 'a(11)'  , 'a(11)'  )
                     , (IoPin.EAST , None, 'a_12'       , 'a(12)'  , 'a(12)'  )
                     , (IoPin.EAST , None, 'a_13'       , 'a(13)'  , 'a(13)'  )
                     , (IoPin.EAST , None, 'ioground_5' , 'vss'    )
                     , (IoPin.EAST , None, 'iopower_5'  , 'iovdd'  )

                     , (IoPin.NORTH, None, 'iopower_6'  , 'iovdd'  )
                     , (IoPin.NORTH, None, 'ioground_6' , 'vss'    )
                     , (IoPin.NORTH, None, 'irq'        , 'irq'    , 'irq'    )
                     , (IoPin.NORTH, None, 'nmi'        , 'nmi'    , 'nmi'    )
                     , (IoPin.NORTH, None, 'rdy'        , 'rdy'    , 'rdy'    )
                     , (IoPin.NORTH, None, 'power_2'    , 'vdd'    )
                     , (IoPin.NORTH, None, 'ground_2'   , 'vss'    )
                     , (IoPin.NORTH, None, 'clk'        , 'clk'    , 'clk'    )
                     , (IoPin.NORTH, None, 'reset'      , 'reset'  , 'reset'  )
                     , (IoPin.NORTH, None, 'we'         , 'we'     , 'we'     )
                     , (IoPin.NORTH, None, 'a_14'       , 'a(14)'  , 'a(14)'  )
                     , (IoPin.NORTH, None, 'a_15'       , 'a(15)'  , 'a(15)'  )
                     , (IoPin.NORTH, None, 'ioground_7' , 'vss'    )
                     , (IoPin.NORTH, None, 'iopower_7'  , 'iovdd'  )
                     ]
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
       #ioPinsSpec = []
        arlet6502Conf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        arlet6502Conf.cfg.etesian.bloat               = 'disabled'
       #arlet6502Conf.cfg.etesian.bloat               = 'nsxlib'
        arlet6502Conf.cfg.etesian.uniformDensity      = True
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
        arlet6502Conf.cfg.chip.padCoreSide            = 'North'
       #arlet6502Conf.cfg.chip.use45corners           = False
        arlet6502Conf.cfg.chip.useAbstractPads        = True
        arlet6502Conf.cfg.chip.supplyRailWidth        = l(250.0)
        arlet6502Conf.cfg.chip.supplyRailPitch        = l(150.0)
        arlet6502Conf.editor              = editor
        arlet6502Conf.useSpares           = True
        arlet6502Conf.useHFNS             = False
        arlet6502Conf.bColumns            = 2
        arlet6502Conf.bRows               = 2
        arlet6502Conf.chipName            = 'chip'
        arlet6502Conf.chipConf.ioPadGauge = 'niolib'
        arlet6502Conf.coreSize            = ( l( 35*50.0), l( 39*50.0) )
        arlet6502Conf.chipSize            = ( l(  5000.0), l(  5000.0) )
        arlet6502Conf.useHTree( 'clk', Spares.HEAVY_LEAF_LOAD )
        arlet6502Conf.useHTree( 'reset' )
        if buildChip:
            arlet6502ToChip = CoreToChip( arlet6502Conf )
            arlet6502ToChip.buildChip()
            chipBuilder = Chip( arlet6502Conf )
            chipBuilder.doChipFloorplan()
            rvalue = chipBuilder.doPnR()
            chipBuilder.save()
        else:
            blockBuilder = Block( arlet6502Conf )
            rvalue = blockBuilder.doPnR()
            blockBuilder.save()
            seabreeze = SeabreezeEngine.create( cell )
           #seabreeze.buildElmore( cell.getNet( 'subckt_0_cpu.axys_1_2' ))
           #seabreeze.buildElmore( cell.getNet( 'subckt_0_cpu.backwards' ))
        for net in cell.getNets():
            try:
                netDatas = net.netDatas
                print( 'netDatas =', netDatas )
            except Exception as e:
                print( 'No prop', net )
        PythonAttributes.disableAll( "netDatas" )
        PythonAttributes.disableAll()
    except Exception as e:
        helpers.io.catch( e )
        rvalue = False
    sys.stdout.flush()
    sys.stderr.flush()
    return rvalue


if __name__ == '__main__':
    rvalue = scriptMain()
    shellRValue = 0 if rvalue else 1
    sys.exit( shellRValue )
