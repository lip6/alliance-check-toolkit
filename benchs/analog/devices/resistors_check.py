#!/usr/bin/python

import sys
from   coriolis           import Cfg
#import node180.scn6m_deep_09
import NDA.node350.c35b4
from   coriolis.Hurricane import *
from   coriolis           import CRL
from   coriolis.helpers   import setTraceLevel
from   coriolis.Analog    import ResistorFamily, Resistor, LayoutGenerator
from   coriolis.Bora      import StepParameterRange


def toDbU ( value ): return DbU.fromPhysical( value, DbU.UnitPowerMicro )


def checkResistors ( editor ):

    UpdateSession.open()
    cell = CRL.AllianceFramework.get().createCell( 'check_resistors' )

    library = DataBase.getDB().getRootLibrary().getLibrary( 'AnalogRootLibrary' )
    if not library:
      library = Library.create( DataBase.getDB().getRootLibrary(), 'AnalogRootLibrary' )

    generator = LayoutGenerator()

    print( '     - Generating Device of %s...' % Resistor )

    bendsRange = StepParameterRange( 1, 10, 1 )

    device = Resistor.create( library, 'resistor0', ResistorFamily.RPOLYH )
    device.getParameter( 'Layout Styles' ).setValue( 'Snake' )
    device.getParameter( 'R'             ).setValue( 15015.5 )
    device.getParameter( 'W'             ).setValue(    10.0 )
    device.getParameter( 'L'             ).setValue(   200.0 )
    bends = device.getParameter( 'bends' )
   #bendsRange.progress()
    bends.setValue( bendsRange.getValue() )

    generator.setDevice( device )
    generator.drawLayout()

    transformation = Transformation()
    instance       = Instance.create( cell, 'resistor0', device, transformation, Instance.PlacementStatus.PLACED )

    print( '       Done %s' % Resistor )

    UpdateSession.close()

    if editor:
      editor.setCell( cell )
      editor.fit()
    return


def scriptMain ( **kw ):
    setTraceLevel( 100 )
    editor = None
    if 'editor' in kw and kw['editor']:
      editor = kw['editor']

    cell = CRL.AllianceFramework.get().getCell( 'check_resistors', CRL.Catalog.State.Views )
    if cell:
        UpdateSession.open()
        if editor: editor.removeHistory( cell )
        cell.destroy()

        library = DataBase.getDB().getRootLibrary().getLibrary( 'AnalogRootLibrary' )
        if library:
          cells = []
          for cell in library.getCells(): cells.append( cell )
          for cell in cells:
            if editor: editor.removeHistory( cell )
            cell.destroy()
        UpdateSession.close()
        print( 'Previous "check_capas" cell destroyed.' )

    checkResistors( editor )
    return True
