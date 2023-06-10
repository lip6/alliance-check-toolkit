#!/usr/bin/env python

import sys
import os
import os.path
import socket
import re
import Cfg
import helpers


NdaDirectory = None
if 'NDA_TOP' in os.environ:
    NdaDirectory = os.environ['NDA_TOP']
if 'PDKMASTER_TOP' in os.environ:
    PdkMasterTop = os.environ['PDKMASTER_TOP']
    NdaDirectory = PdkMasterTop + '/libs.tech/coriolis/techno'
if not NdaDirectory:
    hostname = socket.gethostname()
    if hostname.startswith('lepka'):
        NdaDirectory = '/dsk/l1/jpc/crypted/soc/techno'
        if not os.path.isdir(NdaDirectory):
            print ('[ERROR] You forgot to mount the NDA '
                   'encrypted directory, stupid!')
    else:
        NdaDirectory = '/users/soft/techno/techno'
helpers.setNdaTopDir( NdaDirectory )

import Cfg 
from   Hurricane import Breakpoint, DbU, Library, Net, NetExternalComponents, \
                        Vertical, Pad
import CRL        
from   CRL               import AllianceFramework, RoutingLayerGauge
from   Anabatic          import StyleFlags
from   helpers           import overlay, l, u, n
from   node800.helvellyn import techno
from   plugins.alpha.block.block         import Block
from   plugins.alpha.block.configuration import IoPin, GaugeConf
from   plugins.alpha.block.spares        import Spares
from   plugins.alpha.chip.configuration  import ChipConf
from   plugins.alpha.chip.chip           import Chip

#techno.setup()

import Unicorn
import Etesian
import Anabatic
import Katana

af = AllianceFramework.get()


def loadGdsLib ():
    gdsLib = af.getLibrary( 0 )
    print( '  o  Loading GDS library in "{}".'.format( gdsLib.getName() ))
    CRL.Gds.load( gdsLib
                , NdaDirectory + '/PragmatIC/Helvellyn_V1.2.0/gds/std_cells_1.2.gds'
                , CRL.Gds.NoGdsPrefix|CRL.Gds.Layer_0_IsBoundary )
    af.wrapLibrary( gdsLib, 1 )
    hpitch       = 0
    gaugeName    = Cfg.getParamString('anabatic.routingGauge').asString()
    routingGauge = af.getRoutingGauge( gaugeName )
    for layerGauge in routingGauge.getLayerGauges():
        if layerGauge.getType() == RoutingLayerGauge.PinOnly:
            continue
        if layerGauge.getDirection() == RoutingLayerGauge.Horizontal:
            hpitch = layerGauge.getPitch()
            break
    print( '  o  Skrinking V-AB of {}'.format(DbU.getValueString( hpitch )))
    with overlay.UpdateSession():
        for cell in gdsLib.getCells():
            ab = cell.getAbutmentBox()
            if ab.getHeight() < 10*hpitch:
                continue
            ab.inflate( 0, -hpitch )
            cell.setAbutmentBox( ab )
            cell.setTerminalNetlist( True )
            for net in cell.getNets():
                if not net.isExternal():
                    continue
                if net.isPower() or net.getName() == 'vdd!':
                    net.setName( 'pvdd' )
                    net.setType( Net.Type.POWER )
                    net.setGlobal( True )
                    net.setDirection( Net.Direction.IN )
                    continue
                if net.isGround() or net.getName() == 'gnd!':
                    net.setName( 'pvss' )
                    net.setType( Net.Type.GROUND )
                    net.setGlobal( True )
                    net.setDirection( Net.Direction.IN )
                    continue
                if    net.getName() == 'Y' \
                   or net.getName() == 'Q' \
                   or net.getName() == 'Qb':
                    net.setDirection( Net.Direction.OUT )
                else:
                    net.setDirection( Net.Direction.IN )
                toDestroy = []
                for component in NetExternalComponents.get(net):
                    if isinstance(component,Pad):
                        bb  = component.getBoundingBox()
                        pad = Vertical.create( net
                                             , component.getLayer()
                                             , bb.getCenter().getX()
                                             , bb.getWidth()
                                             , bb.getYMin()
                                             , bb.getYMax() )
                        NetExternalComponents.setExternal( pad )
                        toDestroy.append( component )
                for component in toDestroy:
                    component.destroy()
    return gdsLib


def loadLefLib ():
    lefLib = CRL.LefImport.load( NdaDirectory + '/PragmatIC/Helvellyn_V1.2.0/lef_astd/Hei_V1.2.0_tech.lef' )
    lefLib = CRL.LefImport.load( NdaDirectory + '/PragmatIC/Helvellyn_V1.2.0/lef_astd/lib_astd.lef' )
    af.wrapLibrary( lefLib, 1 )
    return lefLib


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    Breakpoint.setStopLevel( 99 )
   #helpers.setTraceLevel( 550 )
    with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
        cfg.misc.catchCore            = False
        cfg.misc.minTraceLevel        = 14500
        cfg.misc.maxTraceLevel        = 15000
        cfg.misc.info                 = False
        cfg.misc.paranoid             = False
        cfg.misc.bug                  = False
        cfg.misc.logMode              = True
        cfg.misc.verboseLevel1        = True
        cfg.misc.verboseLevel2        = True
        cfg.etesian.graphics          = 2
        cfg.etesian.effort            = 2
        cfg.etesian.bloat             = 'channel'
       #cfg.etesian.aspectRatio       = 2.2
        cfg.etesian.aspectRatio       = 1.0
        cfg.etesian.spaceMargin       = 0.20
        cfg.anabatic.netBuilderStyle  = 'VH,2RL'
        cfg.anabatic.routingStyle     = StyleFlags.VH
       #cfg.anabatic.topRoutingLayer  = 'mt2'
        cfg.katana.eventsLimit        = 4000000
        cfg.katana.hTracksReservedMin = 5 
        cfg.katana.vTracksReservedMin = 5
       #lg5 = af.getRoutingGauge('StdCellLib').getLayerGauge( 5 )
       #lg5.setType( RoutingLayerGauge.PowerSupply )
        env = af.getEnvironment()
        env.setCLOCK( '^sys_clk$|^ck|^jtag_tck$' )

    hscaling  = 4
    vscaling  = 4
    coreSizeX = 220
    coreSizeY = 220
    rg = af.getRoutingGauge( 'StdCellLib' )
    cg = af.getCellGauge   ( 'LEF.CoreSite' )
    vpitch = rg.getLayerGauge( 1 ).getPitch()
    hpitch = rg.getLayerGauge( 0 ).getPitch()
    sliceHeight = cg.getSliceHeight()

    def hp ( v ): return v*hpitch*hscaling
    def vp ( v ): return v*vpitch*vscaling
    def sh ( v ): return v*sliceHeight

    useLEF = False
    editor = None
    if 'editor' in kw and kw['editor']:
        editor = kw[ 'editor' ]
  
    if useLEF:
        lefLib = loadLefLib()
        CRL.Blif.add( lefLib )
    else:
        gdsLib = loadGdsLib()
        CRL.Blif.add( gdsLib )
    Breakpoint.stop( 100, '{} library loaded.'.format( 'LEF' if useLEF else 'GDS' ))
   #OR2x1  = gdsLib.getCell( 'OR2x1' )
   #if editor: editor.setCell( OR2x1 )

    cell = CRL.Blif.load( 'ao68000' )
    if editor: editor.setCell( cell )
    Breakpoint.stop( 100, 'BLIF netlist loaded' )
    try:
        ioPadsSpec = [ ]
        ioPinsSpec = [ (IoPin.WEST |IoPin.A_BEGIN, 'ACK_I'    , vp( 10),     0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'CLK_I'    , vp( 20),     0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'ERR_I'    , vp( 30),     0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'reset_n'  , vp( 40),     0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'RTY_I'    , vp( 50),     0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'BLK_O'    , vp( 60),     0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'blocked_o', vp( 70),     0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'CYC_O'    , vp( 80),     0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'reset_o'  , vp( 90),     0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'RMW_O'    , vp(100),     0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'sgl_o'    , vp(110),     0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'STB_O'    , vp(120),     0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'WE_O'     , vp(130),     0 ,  1)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'ipl_i({})', vp(140), vp(10),  3)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'BTE_O({})', vp(170), vp(10),  2)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'CTI_O({})', vp(190), vp(10),  3)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'fc_o({})' , vp(220), vp(10),  3)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'SEL_O({})', vp(250), vp(10),  4)
                     , (IoPin.SOUTH|IoPin.A_BEGIN, 'DAT_I({})', vp( 10), vp(10), 32)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'ADR_O({})', vp( 10), vp(10), range(2,32))
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'DAT_O({})', vp( 10), vp(10), 32)
                     ]
        conf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        conf.cfg.etesian.bloat               = 'channel'
        conf.cfg.etesian.aspectRatio         = 1.0
       # etesian.spaceMargin is ignored if the coreSize is directly set.
        conf.cfg.etesian.spaceMargin         = 0.02
        conf.cfg.anabatic.searchHalo         = 2
        conf.cfg.anabatic.globalIterations   = 30
        conf.cfg.anabatic.netBuilderStyle    = 'VH,2RL'
        conf.cfg.anabatic.routingStyle       = StyleFlags.VH
        conf.cfg.katana.hTracksReservedLocal = 7
        conf.cfg.katana.vTracksReservedLocal = 7
        conf.cfg.katana.hTracksReservedMin   = 3
        conf.cfg.katana.vTracksReservedMin   = 4
        conf.cfg.katana.trackFill            = 0
        conf.cfg.katana.runRealignStage      = True
        conf.cfg.katana.dumpMeasures         = False
        conf.cfg.block.spareSide             = sh(7)
       #conf.cfg.chip.minPadSpacing          = u(1.46)
       #conf.cfg.chip.supplyRailWidth        = u(20.0)
       #conf.cfg.chip.supplyRailPitch        = u(40.0)
        conf.editor              = editor
        conf.useSpares           = False
        conf.useClockTree        = False
        conf.useHFNS             = False
        conf.bColumns            = 2
        conf.bRows               = 2
        conf.chipName            = 'chip'
        conf.coreSize            = ( sh(coreSizeX), sh(coreSizeY) )
        conf.chipSize            = ( u(  2020.0), u(  2060.0) )
       #conf.useHTree( 'clk', Spares.HEAVY_LEAF_LOAD )
       #conf.useHTree( 'reset' )
        blockBuilder = Block( conf )
        rvalue = blockBuilder.doPnR()
        blockBuilder.save()
    except Exception as e:
        helpers.io.catch( e )
        rvalue = False
    return cell
