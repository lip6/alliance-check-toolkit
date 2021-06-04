
from   __future__ import print_function

import os
import re
import json
import sys
import traceback
import collections
import CRL
import helpers
from   helpers         import trace, l, u, n
from   helpers.io      import ErrorMessage, WarningMessage
from   helpers.overlay import UpdateSession
import plugins
from   Hurricane  import Breakpoint, DataBase, DbU, Transformation, Point, Box, \
                         Cell, Instance
from   plugins.alpha.block.matrix         import RegisterMatrix
from   plugins.alpha.macro.macro          import Macro
from   plugins.alpha.block.iospecs        import IoSpecs
from   plugins.alpha.block.block          import Block
from   plugins.alpha.block.configuration  import IoPin, GaugeConf
from   plugins.alpha.core2chip.libresocio import CoreToChip
from   plugins.alpha.chip.configuration   import ChipConf
from   plugins.alpha.chip.chip            import Chip


af = CRL.AllianceFramework.get()
powerCount = 0
placeHolderCount = 0


def isiterable ( pyobj ):
    if isinstance(pyobj,collections.Iterable): return True
    return False


def doIoPowerCap ( flags ):
    global powerCount
    side = flags & IoPin.SIDE_MASK
    if flags & IoPin.A_BEGIN:
        ioPadPower = [ (side , None,    'power_{}'.format(powerCount),   'vdd' )
                     , (side , None,   'ground_{}'.format(powerCount),   'vss' )
                     , (side , None, 'ioground_{}'.format(powerCount), 'iovss' )
                     , (side , None,  'iopower_{}'.format(powerCount), 'iovdd' )
                     ]
    else:
        ioPadPower = [ (side , None,  'iopower_{}'.format(powerCount), 'iovdd' )
                     , (side , None, 'ioground_{}'.format(powerCount), 'iovss' )
                     , (side , None,   'ground_{}'.format(powerCount),   'vss' )
                     , (side , None,    'power_{}'.format(powerCount),   'vdd' )
                     ]
    powerCount += 1
    return ioPadPower


def doIoPinVector ( ioSpec, bits ):
    v = []
    if not isiterable(bits): bits = range(bits)
    if not bits:
        raise ErrorMessage( 1, [ 'doIoPinVector(): Argument "bits" is neither a width nor an iterable.'
                               , '(bits={})'.format(bits)
                               ] )
    if len(ioSpec) == 5:
        for bit in bits:
            v.append(( ioSpec[0]
                     , ioSpec[1]
                     , ioSpec[2].format(bit)
                     , ioSpec[3].format(bit)
                     , ioSpec[4].format(bit) ))
    elif len(ioSpec) == 6:
        for bit in bits:
            v.append(( ioSpec[0]
                     , ioSpec[1]
                     , ioSpec[2].format(bit)
                     , ioSpec[3].format(bit)
                     , ioSpec[4].format(bit)
                     , ioSpec[5].format(bit) ))
    elif len(ioSpec) == 7:
        for bit in bits:
            v.append(( ioSpec[0]
                     , ioSpec[1]
                     , ioSpec[2].format(bit)
                     , ioSpec[3].format(bit)
                     , ioSpec[4].format(bit)
                     , ioSpec[5].format(bit)
                     , ioSpec[6].format(bit) ))
    else:
        raise ErrorMessage( 1, [ 'doIoPinVector(): Argument "ioSpec" must have between 5 and 7 fields ({})'.format(len(ioSpec))
                               , '(ioSpec={})'.format(ioSpec)
                               ] )
    return v


def rsetAbutmentBox ( cell, ab ):
    for occurrence in cell.getNonTerminalNetlistInstanceOccurrences():
        masterCell = occurrence.getEntity().getMasterCell()
        masterCell.setAbutmentBox( ab )


def scriptMain (**kw):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af
   #helpers.setTraceLevel( 550 )
   #Breakpoint.setStopLevel( 99 )
    rvalue     = True
    coreSizeX  = u(6*90.0)
    coreSizeY  = u(6*90.0)
    chipBorder = u(2*214.0 + 8*13.0)
    ioSpecs    = IoSpecs()
   #pinmuxFile = './non_generated/litex_pinpads.json'
   #pinmuxFile = './coriolis2/pll/litex_pinpads.json'
   #ioSpecs.loadFromPinmux( pinmuxFile )
   # I/O pads, East side.
    ioPadsSpec  = []
    ioPadsSpec += doIoPowerCap( IoPin.EAST|IoPin.A_BEGIN )
    ioPadsSpec += [ (IoPin.EAST             , None, 'div_out_test', 'div_out_test', 'div_out_test' )
                  , (IoPin.EAST|IoPin.ANALOG, None, 'vco_test_ana', 'vco_test_ana', 'vco_test_ana' )
                  ]
   # I/O pads, West side.
    ioPadsSpec += doIoPowerCap( IoPin.WEST|IoPin.A_BEGIN )
    ioPadsSpec += [ (IoPin.WEST, None, 'out_v', 'out_v', 'out_v' ) ]
   # I/O pads, North side.
    ioPadsSpec += doIoPowerCap( IoPin.NORTH|IoPin.A_BEGIN )
    ioPadsSpec += [ (IoPin.NORTH, None, 'ref_v', 'ref_v', 'ref_v' )
                  , (IoPin.NORTH, None, 'a0'   , 'a0'   , 'a0' )
                  , (IoPin.NORTH, None, 'a1'   , 'a1'   , 'a1' )
                  ]
   # I/O pads, South side.
    ioPadsSpec += doIoPowerCap( IoPin.SOUTH|IoPin.A_BEGIN )
    try:
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'wrappll', CRL.Catalog.State.Logical )
        if cell is None:
            print( ErrorMessage( 2, 'doDesign.scriptMain(): Unable to load cell "{}".' \
                                    .format('pll') ))
            sys.exit(1)
        if editor: editor.setCell( cell )
       #pllConf = ChipConf( cell, ioPads=ioSpecs.ioPadsSpec )
        pllConf = ChipConf( cell, ioPads=ioPadsSpec )
        pllConf.cfg.etesian.bloat = 'Flexlib'
        pllConf.cfg.etesian.uniformDensity = True
        pllConf.cfg.etesian.aspectRatio = 1.0
        pllConf.cfg.etesian.spaceMargin = 0.05
        pllConf.cfg.anabatic.searchHalo = 2
        pllConf.cfg.anabatic.globalIterations = 20
        pllConf.cfg.anabatic.topRoutingLayer = 'METAL5'
        pllConf.cfg.katana.hTracksReservedLocal = 9
        pllConf.cfg.katana.vTracksReservedLocal = 5
        pllConf.cfg.katana.hTracksReservedMin = 6
        pllConf.cfg.katana.vTracksReservedMin = 4
        pllConf.cfg.katana.runRealignStage = True
        pllConf.cfg.block.spareSide = u(7*13)
        pllConf.cfg.chip.supplyRailWidth = u(35)
        pllConf.cfg.chip.supplyRailPitch = u(90)
        pllConf.editor = editor
        pllConf.useSpares = False
        pllConf.useClockTree = False
        pllConf.useHFNS = False
        pllConf.bColumns = 2
        pllConf.bRows = 2
        pllConf.chipConf.name = 'chip'
        pllConf.chipConf.ioPadGauge = 'LibreSOCIO'
        pllConf.coreSize = (coreSizeX, coreSizeY)
        pllConf.chipSize = (coreSizeX + chipBorder + u(5.0), coreSizeY + chipBorder - u(0.04) )

        pllToChip = CoreToChip( pllConf )
        pllToChip.buildChip()
        chipBuilder = Chip( pllConf )
        chipBuilder.doChipFloorplan()

        with UpdateSession():
            coreAb      = cell.getAbutmentBox()
            sliceHeight = chipBuilder.conf.sliceHeight
            sliceStep   = chipBuilder.conf.sliceStep
            pllTransf = Transformation( coreAb.getXMax() # -u(234.0)
                                      , coreAb.getYMax() - u(208.0)
                                      , Transformation.Orientation.MX )
            print( 'pllTransf={}'.format(pllTransf) )
            chipBuilder.placeMacro( 'pll', pllTransf )
        sys.stderr.flush()
        sys.stdout.flush()
        Breakpoint.stop( 99, 'After core placement.' )

        rvalue = chipBuilder.doPnR()
        chipBuilder.save()
        CRL.Gds.save( pllConf.chip )
    except Exception, e:
        helpers.io.catch(e)
        rvalue = False
    sys.stdout.flush()
    sys.stderr.flush()
    return rvalue
