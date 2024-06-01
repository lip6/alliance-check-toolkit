#!/usr/bin/env python3

import sys
import traceback
from   coriolis.Hurricane  import DbU, Breakpoint, Cell, DataBase, Net, Horizontal, Vertical, Contact, NetExternalComponents
from   coriolis            import CRL
from   coriolis.helpers.io import ErrorMessage, WarningMessage, catch
from   coriolis.helpers    import loadUserSettings, setTraceLevel, trace, l, u, n
from   coriolis.helpers.overlay import UpdateSession
loadUserSettings()
from   coriolis            import plugins
from gf180mcu_nsx2.block import Block
#from   coriolis.plugins.block.block         import Block
from   coriolis.plugins.block.configuration import IoPin, GaugeConf
from   coriolis.plugins.block.spares        import Spares
from   coriolis.plugins.core2chip.niolib    import CoreToChip
from   coriolis.plugins.chip.configuration  import ChipConf
from   coriolis.plugins.chip.chip           import Chip


af = CRL.AllianceFramework.get()

def  addGuardRing (cell):
    with UpdateSession():
        technology = DataBase.getDB().getTechnology()
        dnwell   = technology.getLayer( 'POLY2' )
        ntie     = technology.getLayer( 'NTIE' )
        ptie     = technology.getLayer( 'PTIE' )
        metal1   = technology.getLayer( 'METAL1' )
        metal2   = technology.getLayer( 'METAL2' )
        via      = technology.getLayer( 'VIA12' )
        cntp      = technology.getLayer( 'CONT_BODY_P' )
        cntn      = technology.getLayer( 'CONT_DIF_N' )
        vss      = cell.getNet('vss')
        aBox     = cell.getAbutmentBox()
        xMin     = aBox.getXMin()
        xMax     = aBox.getXMax()
        yMin     = aBox.getYMin()
        yMax     = aBox.getYMax()
        yCenter  = aBox.getYCenter()
        yHight  = aBox.getHeight()
        xWidth  = aBox.getWidth()
        Horizontal.create(vss, dnwell, yCenter, (yHight + l(56)), (xMin - l(34)), (xMax + l(34)))
        Horizontal.create(vss, ptie, yMax + l(62), l(8), xMin - l(64), xMax + l(64))
        Horizontal.create(vss, ptie, yMin - l(62), l(8), xMin - l(64), xMax + l(64))
        Horizontal.create(vss, ntie, yMax + l(74), l(8), xMin - l(76), xMax + l(76))
        Horizontal.create(vss, ntie, yMin - l(74), l(8), xMin - l(76), xMax + l(76))
        Vertical.create(vss, ptie, xMax + l(62), l(8), yMin - l(62), yMax + l(62))
        Vertical.create(vss, ptie, xMin - l(62), l(8), yMin - l(62), yMax + l(62))
        Vertical.create(vss, ntie, xMax + l(74), l(8), yMin - l(74), yMax + l(74))
        Vertical.create(vss, ntie, xMin - l(74), l(8), yMin - l(74), yMax + l(74))
        Horizontal.create(vss, metal1, yMax + l(62), l(8), xMin - l(66), xMax + l(66))
        Horizontal.create(vss, metal1, yMin - l(62), l(8), xMin - l(66), xMax + l(66))
        Horizontal.create(vss, metal1, yMax + l(74), l(8), xMin - l(78), xMax + l(78))
        Horizontal.create(vss, metal1, yMin - l(74), l(8), xMin - l(78), xMax + l(78))
        Vertical.create(vss, metal2, xMax + l(62), l(8), yMin - l(62), yMax + l(62))
        Vertical.create(vss, metal2, xMin - l(62), l(8), yMin - l(62), yMax + l(62))
        Vertical.create(vss, metal2, xMax + l(74), l(8), yMin - l(74), yMax + l(74))
        Vertical.create(vss, metal2, xMin - l(74), l(8), yMin - l(74), yMax + l(74))
        Contact.create(vss, via, xMin - l(60), yMin - l(60))
        Contact.create(vss, via, xMax + l(60), yMin - l(60))
        Contact.create(vss, via, xMin - l(60), yMax + l(60))
        Contact.create(vss, via, xMax + l(60), yMax + l(60))
        Contact.create(vss, via, xMin - l(72), yMin - l(72))
        Contact.create(vss, via, xMax + l(72), yMin - l(72))
        Contact.create(vss, via, xMin - l(72), yMax + l(72))
        Contact.create(vss, via, xMax + l(72), yMax + l(72))
        for i in range(xMin - l(50), xMax +l(50), l(100)):
               Contact.create( vss, cntp, i, yMin - l(62))
               Contact.create( vss, cntp, i, yMax + l(62))
               Contact.create( vss, cntn, i, yMin - l(74))
               Contact.create( vss, cntn, i, yMax + l(74))
        for j in range(yMin - l(50), yMax + l(50), l(100)):
               Contact.create( vss, cntp, xMin - l(62), j)
               Contact.create( vss, cntp, xMax + l(62), j)
               Contact.create( vss, cntn, xMin - l(74), j)
               Contact.create( vss, cntn, xMax + l(74), j)
               Contact.create( vss, via, xMin - l(62), j)
               Contact.create( vss, via, xMax + l(62), j)
               Contact.create( vss, via, xMin - l(74), j)
               Contact.create( vss, via, xMax + l(74), j)
        yield cell
        


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af
    DbU.setStringMode( DbU.StringModeSymbolic )
    rvalue = True
    try:
       #setTraceLevel( 550 )
       #Breakpoint.setStopLevel( 100 )
        cell, editor = plugins.kwParseMain( **kw )
        cell = af.getCell( 'adder', CRL.Catalog.State.Logical )
       #af.saveCell( cell, CRL.Catalog.State.Logical )
        if editor:
            editor.setCell( cell ) 
        ioPadsSpec = []
        m1pitch = l(10.0)
        m2pitch = l(20.0)
        ioPinsSpec = []
        conf = ChipConf( cell, ioPins=ioPinsSpec, ioPads=ioPadsSpec ) 
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
        conf.coreSize  = ( l( 700.0), l( 500.0) )
        conf.editor    = editor
        blockBuilder   = Block( conf )
        cell.setTerminalNetlist( False )
        rvalue = blockBuilder.doPnR(addGuardRing(cell))
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
