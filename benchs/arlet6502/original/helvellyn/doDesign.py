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
                        Vertical, Horizontal, Pad, DataBase
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


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    Breakpoint.setStopLevel( 101 )
    Breakpoint.stop( 100, 'GDS library loaded.' )
   #helpers.setTraceLevel( 550 )
    af = AllianceFramework.get()
    with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
        cfg.misc.catchCore            = False
        cfg.misc.minTraceLevel        = 14500
        cfg.misc.maxTraceLevel        = 16000
        cfg.misc.info                 = False
        cfg.misc.paranoid             = False
        cfg.misc.bug                  = False
        cfg.misc.logMode              = True
        cfg.misc.verboseLevel1        = True
        cfg.misc.verboseLevel2        = True
        cfg.etesian.graphics          = 2
       #cfg.etesian.aspectRatio       = 2.2
        cfg.katana.eventsLimit        = 4000000
       #lg5 = af.getRoutingGauge('StdCellLib').getLayerGauge( 5 )
       #lg5.setType( RoutingLayerGauge.PowerSupply )
    env = af.getEnvironment()
    env.setCLOCK( '^sys_clk$|^ck|^jtag_tck$' )

    hscaling  = 2
    vscaling  = 2
    coreSizeX = 41
    coreSizeY = 41
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
   #OR2x1  = gdsLib.getCell( 'OR2x1' )
   #if editor: editor.setCell( OR2x1 )

    cell = CRL.Blif.load( 'Arlet6502' )
    if editor: editor.setCell( cell )
    Breakpoint.stop( 100, 'BLIF netlist loaded' )
    try:
        ioPadsSpec = [ ]
        ioPinsSpec = [ (IoPin.WEST |IoPin.A_BEGIN, 'DI({})'  , vp(10), vp(10),  8)
                     , (IoPin.WEST |IoPin.A_BEGIN, 'DO({})'  , vp(15), vp(10),  8)
                     , (IoPin.EAST |IoPin.A_BEGIN, 'A({})'   , vp(10), vp(10), 16)
                     
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'clk'     , hp(100),    0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'IRQ'     , hp(110),    0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'NMI'     , hp(120),    0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'RDY'     , hp(130),    0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'WE'      , hp(140),    0 ,  1)
                     , (IoPin.NORTH|IoPin.A_BEGIN, 'reset'   , hp(150),    0 ,  1)
                     ]
        conf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        conf.cfg.etesian.bloat               = 'channel'
        conf.cfg.etesian.densityVariation    = 0.05
        conf.cfg.etesian.aspectRatio         = 1.0
       # etesian.spaceMargin is ignored if the coreSize is directly set.
        conf.cfg.etesian.spaceMargin         = 0.02
        conf.cfg.anabatic.searchHalo         = 2
        conf.cfg.anabatic.globalIterations   = 30
        conf.cfg.anabatic.netBuilderStyle    = 'VH,2RL'
        conf.cfg.anabatic.routingStyle       = StyleFlags.VH
        conf.cfg.katana.hTracksReservedLocal = 8
        conf.cfg.katana.vTracksReservedLocal = 7
        conf.cfg.katana.hTracksReservedMin   = 4
        conf.cfg.katana.vTracksReservedMin   = 4
        conf.cfg.katana.trackFill            = 0
        conf.cfg.katana.runRealignStage      = True
        conf.cfg.katana.dumpMeasures         = False
        conf.cfg.block.spareSide             = sh(7)
       #conf.cfg.chip.minPadSpacing          = u(1.46)
       #conf.cfg.chip.supplyRailWidth        = u(20.0)
       #conf.cfg.chip.supplyRailPitch        = u(40.0)
        conf.cfg.spares.maxSinks             = 10
        conf.editor              = editor
        conf.useSpares           = True
        conf.sparesTies          = True
        conf.useHFNS             = False
        conf.bColumns            = 2
        conf.bRows               = 2
        conf.chipName            = 'chip'
        conf.coreSize            = ( sh(coreSizeX), sh(coreSizeY) )
        conf.chipSize            = ( u(  2020.0), u(  2060.0) )
        conf.useHTree( 'clk', Spares.HEAVY_LEAF_LOAD )
       #conf.useHTree( 'reset' )
        blockBuilder = Block( conf )
        rvalue = blockBuilder.doPnR()
        blockBuilder.save()
    except Exception as e:
        helpers.io.catch( e )
        rvalue = False
  # etesian = Etesian.EtesianEngine.create( cell )
  # etesian.setDefaultAb()
  # if editor: editor.fit()
  # etesian.place()
  # etesian.toHurricane()
  # etesian.destroy()
  ##Breakpoint.stop( 100, 'Placement done' )
  # if editor: editor.fit()
  # katana = Katana.KatanaEngine.create( cell )
  # katana.digitalInit()
  # katana.runGlobalRouter( Katana.Flags.NoFlags )
  # if editor: editor.fit()
  # Breakpoint.stop( 100, 'Global routing done' )
  # katana.loadGlobalRouting( Anabatic.EngineLoadGrByNet )
  # katana.runNegociate     ( Katana.Flags.NoFlags )
  # success = katana.isDetailedRoutingSuccess()
  # Breakpoint.stop( 100, 'P&R done (success={}). About to destroy Katana.'.format(success) )
  # katana.finalizeLayout()
  # katana.destroy()
  # CRL.DefExport.drive( cell, 0 )
  # CRL.Gds.save( cell )
    return cell
