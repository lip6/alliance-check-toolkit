#!/usr/bin/env python

enableProfiling = False

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
  import Hurricane  
  from   Hurricane  import DbU
  from   Hurricane  import UpdateSession
  from   Hurricane  import Breakpoint
  from   Hurricane  import Transformation
  from   Hurricane  import Instance
  import Viewer
  import CRL
  import Anabatic
  import Katana
  import Etesian
  import Katabatic
  import Kite
  import Unicorn
  import plugins
  import clocktree.ClockTree
except ImportError, e:
  showPythonTrace( __file__, e, False )
  sys.exit(1)
except Exception, e:
  showPythonTrace( __file__, e )
  sys.exit(2)


framework     = CRL.AllianceFramework.create(0)
print framework.getEnvironment().getPrint()

technoName = Hurricane.DataBase.getDB().getTechnology().getName()


def scriptMain ( **kw ):
    success  = False
    
    try:
      cell, editor = plugins.kwParseMain( **kw )
    
      etesian = Etesian.EtesianEngine.create( cell )
      if editor: etesian.setViewer( editor )
      etesian.place()
      etesian.destroy()
      if editor:
        editor.refresh()
        editor.fit()
    
      katana = Katana.KatanaEngine.create( cell )
      katana.digitalInit    ()
      katana.runGlobalRouter()
      katana.resetRouting   ()
      katana.destroy        ()
    
      etesian = Etesian.EtesianEngine.create( cell )
      etesian.resetPlacement()
      etesian.place()
      etesian.destroy()
      if editor:
        editor.refresh()
        editor.fit()
      
     #plugins.RSavePlugin.scriptMain( **kw )
    except Exception, e:
      print e
    
    return success
