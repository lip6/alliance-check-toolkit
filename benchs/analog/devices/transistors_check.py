#!/usr/bin/python

import sys
from   coriolis           import Cfg
from   coriolis.Hurricane import *
from   coriolis           import CRL
from   coriolis.Analog    import Transistor, CommonDrain, CommonGatePair, \
                                 CommonSourcePair, CrossCoupledPair,      \
                                 DifferentialPair, LevelShifter,          \
                                 SimpleCurrentMirror, LayoutGenerator
from   coriolis. helpers  import technoDir


def toDbU ( value ): return DbU.fromPhysical( value, DbU.UnitPowerMicro )


def analogDemo ( editor ):

             #  | Class              | Instance| Layout Style       | W                    | M| S. First| Mint | BulkC |
             #  +====================+=========+====================+======================+==+=========+======+=======+
    devices = [ ( Transistor         , 't0'    , 'WIP Transistor'   , DbU.fromLambda(80.00), 4, True    , None , True  )
             #, ( Transistor         , 't0b'   , 'WIP Transistor'   , DbU.fromLambda(80.00), 4, False   , None , False )
             #, ( Transistor         , 't0c'   , 'WIP Transistor'   , DbU.fromLambda(80.00), 4, False   , None , False )
             #, ( Transistor         , 't0d'   , 'Common transistor', toDbU(37.00)         , 4, True    , None , False )
             #, ( Transistor         , 't0e'   , 'Common transistor', toDbU(37.00)         , 4, True    , None , True  )
             #, ( Transistor         , 't1'    , None               , toDbU( 0.54)         , 1, False   , None , False )
             #, ( CommonDrain        , 'ta'    , None               , toDbU(37.00)         , 2, False   , 2    , False )
             #, ( CommonGatePair     , 'tb'    , None               , toDbU(37.00)         , 2, False   , 2    , False )
             #, ( CommonSourcePair   , 't4'    , 'WIP CSP'          , toDbU(10.56)         , 4, False   , 2    , True  )
             #, ( CommonSourcePair   , 't4b'   , 'Interdigitated'   , toDbU(10.56)         , 4, True    , 2    , True  )
             #, ( CrossCoupledPair   , 't3'    , None               , toDbU(37.00)         , 4, True    , 2    , False )
             #, ( DifferentialPair   , 't4'    , 'WIP DP'           , toDbU(10.56)         , 4, False   , 2    , False )
             #, ( DifferentialPair   , 't4b'   , 'Interdigitated'   , toDbU(10.56)         , 4, True    , 2    , True  )
             #, ( LevelShifter       , 't5'    , None               , toDbU(37.00)         , 4, True    , 2    , False )
             #, ( SimpleCurrentMirror, 't6'    , None               , toDbU(37.00)         , 4, True    , 2    , False )
              ]

    technoName = DataBase.getDB().getTechnology().getName()

    xspacing  = toDbU(14.0)
    yspacing  = toDbU(28.0)
    xspacingl = DbU.fromLambda(50.0)
    if technoName == 'c35b4':
      print( '  o  Using AMS 350nm (c34b4) settings.' )
      xspacing  = toDbU( 5.0)
      yspacing  = toDbU(11.0)
      xspacingl = DbU.fromLambda(80.0)
    elif technoName == 'cmos065':
      print( '  o  Using 65nm settings.' )
      xspacing  = toDbU( 5.0)
      yspacing  = toDbU(11.0)
      xspacingl = DbU.fromLambda(20.0)
    elif technoName == 'scn6m_deep_09':
      print( '  o  Using MOSIS 180nm settings (scn6m_deep_09).' )
      xspacing  = toDbU( 6.0)
      yspacing  = toDbU(14.0)
      xspacingl = DbU.fromLambda(50.0)
    else:
      print( '[WARNING] Cannot guess technology from:' )
      print( '          \"%s\"' % technoDir )

    UpdateSession.open()
    cell = CRL.AllianceFramework.get().createCell( 'devices_check' )

    library = DataBase.getDB().getRootLibrary().getLibrary( 'AnalogRootLibrary' )
    if not library:
      library = Library.create( DataBase.getDB().getRootLibrary(), 'AnalogRootLibrary' )

    generator = LayoutGenerator()

    for i in range(len(devices)):
      print( '     - Generating Device of %s...' % devices[i][0] )
      print( '       w:%f' % DbU.toLambda( devices[i][3] ) )

      device  = devices[i][0].create( library, devices[i][1], Transistor.NMOS, devices[i][7] )
      if devices[i][2]: device.getParameter( 'Layout Styles' ).setValue( devices[i][2] )
      device.getParameter( 'W' ).setValue( devices[i][3] )
      device.getParameter( 'L' ).setValue( DbU.fromLambda(2.0) )
      device.getParameter( 'M' ).setValue( devices[i][4] )
      if i == 0:
        device.setExternalDummy( 0 )
        device.setBulkType     ( 0x000f )
      if i in [1, 2]:
        device.setBulkType( 0x000f )
        device.getParameter( 'L' ).setValue( toDbU(3.0) )
     #if i == 2:
     #  device.setBulkType     ( 0x0006 )
      device.setSourceFirst( devices[i][5] )
      if devices[i][6]: device.setMint( devices[i][6] )

      generator.setDevice( device )
      generator.drawLayout()

      transformation = Transformation()
      if   i == 0: pass
      elif i == 100: transformation = Transformation( toDbU(0.0)  , yspacing   , Transformation.Orientation.ID )
      else:          transformation = Transformation( xspacing*(i), toDbU( 0.0), Transformation.Orientation.ID )

      instance = Instance.create( cell
                                , devices[i][1]
                                , device
                                , transformation
                                , Instance.PlacementStatus.FIXED )

      print( '       Done %s' % devices[i][0] )

    inv_x1 = CRL.AllianceFramework.get().getCell( 'inv_x1', CRL.Catalog.State.Views )
   #inv_x1 = CRL.AllianceFramework.get().getLibrary('nsxlib').getCell( 'inv_x1' )
    if inv_x1:
      inverter = Instance.create( cell
                                , 'inverter'
                                , inv_x1
                                , Transformation( -xspacingl
                                                , DbU.fromLambda(  0)
                                                , Transformation.Orientation.ID )
                                , Instance.PlacementStatus.FIXED )
    else:
      print( '[ERROR] Cell "inv_x1" has not been found in the libraries.' )

    UpdateSession.close()


    if editor:
      editor.setCell( cell )
      editor.fit()
    return


def scriptMain ( **kw ):
    editor = None
    if 'editor' in kw and kw['editor']:
      editor = kw['editor']

    cell = CRL.AllianceFramework.get().getCell( 'devices_check', CRL.Catalog.State.Views )
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
        print( 'Previous <devices_check> cell destroyed.' )

    analogDemo( editor )
    return True
