#!/usr/bin/env python3

import sys
import traceback
from   coriolis.Hurricane  import DbU, Breakpoint, Cell, DataBase, Net, Horizontal, Vertical, Contact, NetExternalComponents, Transformation, Instance
from   coriolis            import CRL
from   coriolis.helpers.io import ErrorMessage, WarningMessage, catch
from   coriolis.helpers    import loadUserSettings, setTraceLevel, trace, l, u, n
from   coriolis.helpers.overlay import UpdateSession
loadUserSettings()
from   coriolis            import plugins
#from gf180mcu_nsx2.block import Block
from   coriolis.plugins.block.block         import Block
from   coriolis.plugins.block.configuration import IoPin, GaugeConf
from   coriolis.plugins.block.spares        import Spares
from   coriolis.plugins.core2chip.niolib    import CoreToChip
from   coriolis.plugins.chip.configuration  import ChipConf
from   coriolis.plugins.chip.chip           import Chip
from   gf180mcu_nsx2.guardring import addGuardRing

af = CRL.AllianceFramework.get()

GuardRing = True

def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af
    coreName = 'adder'
    ioPadsSpec = []
    m1pitch = l(10.0)
    m2pitch = l(20.0)
    ioPinsSpec = []
    ioPinsSpec = []
    ioPinsSpec = [ (IoPin.WEST |IoPin.A_BEGIN, 'a({})'  ,  5*m1pitch, 5*m1pitch,  8)
                 , (IoPin.WEST |IoPin.A_BEGIN, 'b({})'  , 7*m1pitch, 5*m1pitch,  8)
                 , (IoPin.EAST |IoPin.A_BEGIN, 'f({})'  , 10*m1pitch, 5*m1pitch,  8)
                 , (IoPin.NORTH|IoPin.A_BEGIN, 'm_clock'     , 00*m2pitch,       0 ,  1)
                 , (IoPin.NORTH|IoPin.A_BEGIN, 'p_reset'     , 10*m2pitch,       0 ,  1)
                 ]
    DbU.setStringMode( DbU.StringModeSymbolic )
    rvalue = True
    try:
       #setTraceLevel( 550 )
       #Breakpoint.setStopLevel( 100 )
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( coreName, CRL.Catalog.State.Logical )
       #af.saveCell( cell, CRL.Catalog.State.Logical )
        if editor:
            editor.setCell( cell ) 
        conf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
        blockBuilder   = Block( conf )
        conf.cfg.anabatic.globalIterations   = 10
        conf.cfg.anabatic.topRoutingLayer    = 'METAL5'
        conf.cfg.block.spareSide             = l(1000)
        conf.cfg.katana.hTracksReservedMin   = 6
        conf.cfg.katana.vTracksReservedMin   = 5
        conf.cfg.katana.hTracksReservedLocal = 10
        conf.cfg.katana.vTracksReservedLocal = 7 
        conf.cfg.katana.termSatReservedLocal = 6 
        conf.cfg.katana.termSatThreshold     = 9 
        conf.cfg.katana.trackFill            = 0
        conf.cfg.katana.runRealignStage      = True
        conf.cfg.katana.dumpMeasures         = False
        conf.useSpares = False
        conf.useHFNS   = False
        conf.useHTree  = False
        #conf.coreSize  = ( l( 700.0), l( 500.0) )
        conf.editor    = editor
        cell.setTerminalNetlist( False )
        rvalue = blockBuilder.doPnR()
        if GuardRing:
           addGuardRing(cell)
        print("in Main" , cell.getName())
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
