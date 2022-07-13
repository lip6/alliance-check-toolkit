#!/usr/bin/python

import sys
import Cfg
#import node180.scn6m_deep_09
import NDA.node350.c35b4
from   Hurricane import *
import CRL
from   Analog import CapacitorFamily
from   Analog import MultiCapacitor
from   Analog import LayoutGenerator
from   Analog import Matrix
from   Bora   import MatrixParameterRange


def toDbU ( value ): return DbU.fromPhysical( value, DbU.UnitPowerMicro )


def checkCapas ( editor ):

    mrange = MatrixParameterRange()
   #mrange.addValue( [ [ 0, 1 ]
   #                 , [ 2, 0 ]
   #                 ] )
   #mrange.addValue( [ [ 0, 1, 0 ]
   #                 , [ 1, 0, 1 ]
   #                 , [ 0, 1, 0 ]
   #                 ] )
    mrange.addValue( [ [ 1, 1, 1, 0 ]
                     , [ 0, 1, 1, 1 ]
                     , [ 1, 1, 1, 0 ]
                     , [ 0, 1, 1, 1 ]
                     ] )

    UpdateSession.open()
    cell = CRL.AllianceFramework.get().createCell( 'check_capas' )

    library = DataBase.getDB().getRootLibrary().getLibrary( 'AnalogRootLibrary' )
    if not library:
      library = Library.create( DataBase.getDB().getRootLibrary(), 'AnalogRootLibrary' )

    generator = LayoutGenerator()

    print( '     - Generating Device of %s...' % MultiCapacitor )

    device  = MultiCapacitor.create( library, 'capa0', CapacitorFamily.PIP, 2 )
    device.getParameter( 'Layout Styles' ).setValue( 'Matrix' )
    device.getParameter( 'capacities'    ).setValue( 0, 372  )
    device.getParameter( 'capacities'    ).setValue( 1, 1116 )
    pmatrix = device.getParameter( 'matrix' )
   #mrange.progress()
    pmatrix.setMatrix( mrange.getValue() )

    print( device.getParameter( 'capacities' ))

    generator.setDevice( device )
    generator.drawLayout()

    transformation = Transformation()
    instance       = Instance.create( cell, 'capa0', device, transformation, Instance.PlacementStatus.PLACED )

    print( '       Done %s' % MultiCapacitor )

    UpdateSession.close()

    if editor:
      editor.setCell( cell )
      editor.fit()
    return


def scriptMain ( **kw ):
    editor = None
    if 'editor' in kw and kw['editor']:
      editor = kw['editor']

    cell = CRL.AllianceFramework.get().getCell( 'check_capas', CRL.Catalog.State.Views )
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

    checkCapas( editor )
    return True
