#!/usr/bin/env python
# -*- coding: utf-8 -*-

try:
  import sys
  import re
  import traceback
  import os.path
  import optparse
  import Cfg
  import helpers
  from   helpers.io import ErrorMessage
  from   helpers    import showPythonTrace
  from   helpers    import l, u, n
  import Hurricane
  from   Hurricane import DbU
  from   Hurricane import DataBase
  from   Hurricane import UpdateSession
  from   Hurricane import Breakpoint
  from   Hurricane import Box
  from   Hurricane import Transformation
  from   Hurricane import Instance
  from   Hurricane import Pin
  import Viewer
  import CRL
  import Etesian
  import Anabatic
  import Katana
  import Unicorn
  import plugins.RSavePlugin
except ImportError, e:
  print e
  showPythonTrace( __file__, e, False )
  sys.exit(1)
except Exception, e:
  print e
  showPythonTrace( __file__, e )
  sys.exit(2)


def placeAndRouteSnx ( **kw ):
    editor = None
    if kw.has_key('editor') and kw['editor']:
      editor = kw['editor']
    
    helpers.loadUserSettings()

    af     = CRL.AllianceFramework.get()
    metal2 = DataBase.getDB().getTechnology().getLayer( 'metal2' )
    metal3 = DataBase.getDB().getTechnology().getLayer( 'metal3' )
  
    cell = af.getCell( 'snx_scan', CRL.Catalog.State.Logical )
    if not cell:
      print '[ERROR] Unable to load cell "snx.vst", aborting .'
      return False
    kw[ 'cell' ] = cell
  
    ab = Box( l(    0.0 )
            , l(    0.0 )
            , l( 4100.0 )
            , l( 4100.0 ) )
  
    UpdateSession.open()
    cell.setAbutmentBox( ab )
    
    for i in range(15):  
      Pin.create( cell.getNet('datai(%d)' % i)
                , 'datai(%d).0' % i 
                , Pin.Direction.SOUTH
                , Pin.PlacementStatus.FIXED
                , metal3
                , l( 100.0*i + 50.0 ) , l( 0.0 )  # Position.
                , l( 2.0 )            , l( 2.0 )  # Size.
                )
  
    Pin.create( cell.getNet('p_reset')
              , 'p_reset.0' 
              , Pin.Direction.WEST
              , Pin.PlacementStatus.FIXED
              , metal2
              , l(   0.0 )
              , l( 140.0 )
              , l(   2.0 )
              , l(   2.0 )
              )
    UpdateSession.close()
    
    if editor: editor.setCell( cell )
  
    etesian = Etesian.EtesianEngine.create(cell)
    etesian.place()
  
    katana = Katana.KatanaEngine.create(cell)
    katana.digitalInit          ()
   #katana.runNegociatePreRouted()
    katana.runGlobalRouter      ( Katana.Flags.NoFlags )
    katana.loadGlobalRouting    ( Anabatic.EngineLoadGrByNet )
    katana.layerAssign          ( Anabatic.EngineNoNetLayerAssign )
    katana.runNegociate         ( Katana.Flags.NoFlags )
    katana.finalizeLayout       ()
    success = katana.isDetailedRoutingSuccess()
    katana.destroy()
  
   #af.saveCell( cell, CRL.Catalog.State.Views )
    plugins.RSavePlugin.scriptMain( **kw )
  
    helpers.resetCoriolis()
  
    return success


def scriptMain ( **kw ):
    for run in range(10):
      print 'Run %d ...' % run
      placeAndRouteSnx( **kw )
      print '=' * 79, '\n'
    return


if __name__ == '__main__':
  try:
    kw           = {}
    success      = scriptMain( **kw )
    shellSuccess = 0
    if not success: shellSuccess = 1
  except ImportError, e:
    showPythonTrace( __file__, e, False )
    sys.exit(1)
  except Exception, e:
    showPythonTrace( __file__, e )
    sys.exit(2)

  sys.exit( shellSuccess )
