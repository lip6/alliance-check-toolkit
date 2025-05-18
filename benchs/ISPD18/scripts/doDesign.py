#!/usr/bin/env python3

import sys
import traceback
from   coriolis.Hurricane  import DataBase, DbU, Breakpoint, PythonAttributes, Instance, \
                                  Box, Transformation
from   coriolis            import CRL, Cfg, Etesian, Anabatic, Katana, Tramontana
from   coriolis.helpers    import loadUserSettings, setTraceLevel, trace, overlay, l, u, n
from   coriolis.helpers.io import ErrorMessage, WarningMessage, catch
from   coriolis            import plugins
from   coriolis.plugins.block.block          import Block
from   coriolis.plugins.block.configuration  import IoPin, GaugeConf
from   coriolis.plugins.chip.configuration   import ChipConf
from   coriolis.plugins.chip.chip            import Chip


af       = CRL.AllianceFramework.get()
loadCell = None


def scriptMain ( **kw ):
    """The mandatory function to be called by Coriolis CGT/Unicorn."""
    global af, loadCell
    gaugeName    = None
    dumpMeasures = True
    with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
        cfg.misc.catchCore              = False
        cfg.misc.info                   = False
        cfg.misc.paranoid               = False
        cfg.misc.bug                    = False
        cfg.misc.logMode                = True
        cfg.misc.verboseLevel1          = True
        cfg.misc.verboseLevel2          = False
        cfg.misc.minTraceLevel          = 16000
        cfg.misc.maxTraceLevel          = 17000
        cfg.tramontana.mergeSupplies    = True
       #cfg.anabatic.searchHalo         = 2
        cfg.katana.hTracksReservedLocal = 15
        cfg.katana.vTracksReservedLocal = 15
        cfg.katana.hTracksReservedMin   = 6
        cfg.katana.vTracksReservedMin   = 6
        cfg.anabatic.routingGauge       = None   # Trigger disk loading.
        gaugeName = cfg.anabatic.routingGauge

    rvalue       = True
    routingGauge = af.getRoutingGauge( gaugeName )
    try:
        #setTraceLevel( 550 )
        #Breakpoint.setStopLevel( 100 )
        cellName = None
        cell, editor = plugins.kwParseMain( **kw )
        print( 'Loading ISPD18 benchmark "{}"'.format( loadCell ))
        cell = af.getCell( loadCell, CRL.Catalog.State.Views )
        if editor:
            editor.setCell( cell ) 
            editor.setDbuMode( DbU.StringModePhysical )
        stdCellArea = None
        if cell.getName() in ( 'ispd18_test1.input'
                             , 'ispd18_test2.input'):
            ab       = cell.getAbutmentBox()
            for inst in cell.getInstances():
                refInst = inst
                break
            yrefInst = refInst.getTransformation().getTy()
            yadjust  = u(1.71) - (yrefInst - ab.getYMin()) % u(1.71)
            print( 'yadjust={}'.format( DbU.getValueString( yadjust )))
            

            metal3 = DataBase.getDB().getTechnology().getLayer( 'Metal3' )
            metal4 = DataBase.getDB().getTechnology().getLayer( 'Metal4' )
            rlg3   = routingGauge.getLayerGauge( metal3 )
            rlg4   = routingGauge.getLayerGauge( metal4 )
            ab.inflate( rlg3.getPitch(), yadjust, rlg3.getPitch(), rlg4.getPitch() )
            print( cell.getAbutmentBox() )
            cell.setAbutmentBox( ab )
            print( cell.getAbutmentBox() )
        if cell.getName() in ( 'ispd18_test7.input'):
            stdCellArea = Box( u(9.6), u(278.4), u(901.5), u(1046.4) )
            etesian = Etesian.EtesianEngine.create( cell )
            etesian.setPlaceArea( stdCellArea )
            etesian.toHurricane()
            etesian.destroy()
            

        katana = Katana.KatanaEngine.create( cell )
        katana.digitalInit       ()
        if stdCellArea:
            katana.resetStdCellArea()
            katana.addStdCellArea( stdCellArea )
        Breakpoint.stop( 100, 'Block.route() Before global routing.' )
        katana.runGlobalRouter  ( Katana.Flags.NoFlags )
        Breakpoint.stop( 100, 'Block.route() After global routing.' )
        katana.loadGlobalRouting( Anabatic.EngineLoadGrByNet )
        Breakpoint.stop( 100, 'Block.route() Loaded global into detailed.' )
        katana.layerAssign      ( Anabatic.EngineNoNetLayerAssign )
        katana.runNegociate     ( Katana.Flags.NoFlags )
        rvalue = katana.isDetailedRoutingSuccess()
        Breakpoint.stop( 99, 'Block.route() done, success:{}.'.format(rvalue) )
        katana.finalizeLayout()
        if dumpMeasures is True:
            katana.dumpMeasures()
        katana.destroy()
        CRL.DefExport.drive( cell, 0 )
        if not rvalue:
            return rvalue
        tramontana = Tramontana.TramontanaEngine.create( cell )
        tramontana.printConfiguration()
        tramontana.extract()
        tramontana.printSummary()
        rvalue = tramontana.getSuccessState()

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
