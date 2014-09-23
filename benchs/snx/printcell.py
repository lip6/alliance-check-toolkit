#!/usr/bin/env python
#
# This file is part of the Coriolis Software.
# Copyright (c) UPMC 2014-2014, All Rights Reserved
#
# +-----------------------------------------------------------------+
# |                   C O R I O L I S                               |
# |      C u m u l u s  -  P y t h o n   T o o l s                  |
# |                                                                 |
# |  Author      :                    Jean-Paul CHAPUT              |
# |  E-mail      :       Jean-Paul.Chaput@asim.lip6.fr              |
# | =============================================================== |
# |  Python      :       "./plugins/RSavePlugin.py"                 |
# +-----------------------------------------------------------------+


try:
  import sys
  import traceback
  import os.path
  import Cfg
  import CRL
  import helpers
  from   helpers   import ErrorMessage
  from   helpers   import WarningMessage
  import plugins
except ImportError, e:
  module = str(e).split()[-1]

  print '[ERROR] The <%s> python module or symbol cannot be loaded.' % module
  print '        Please check the integrity of the <coriolis> package.'
  sys.exit(1)
except Exception, e:
  print '[ERROR] A strange exception occurred while loading the basic Coriolis/Python'
  print '        modules. Something may be wrong at Python/C API level.\n'
  print '        %s' % e
  sys.exit(2)



# --------------------------------------------------------------------
# Plugin hook functions, unicornHook:menus, ScritMain:call

def unicornHook ( **kw ):
    plugins.kwUnicornHook( 'plugins.rsave'
                         , 'R-Save Cell'
                         , 'Recursively Save Top Cell and it\'s Instances'
                         , sys.modules[__name__].__file__
                         , **kw
                         )
    return

def printrecur( instance ):
      framework = CRL.AllianceFramework.get()
      masterCell = instance.getMasterCell()
      if not masterCell.isTerminal():
        print '     - %s (layout).' % masterCell.getName()
        framework.saveCell( masterCell, CRL.Catalog.State.Physical )
        for subinst in masterCell.getInstances():
		printrecur(subinst)
	
      return


def ScriptMain ( **kw ):
  try:
    helpers.staticInitialization( )
   #helpers.setTraceLevel( 550 )

    cell, editor = plugins.kwParseMain( **kw )

    if not cell:
      print WarningMessage( 'No Cell loaded in the editor (yet), nothing done.' )
      return 0

    framework = CRL.AllianceFramework.get()

   # Write back layout to disk if everything has gone fine.
   # Must write all the sub-blocks of the core but *not* the
   # standard cell (mainly the feed-through).
    print '  o  Recursive Save-Cell.'
    for instance in cell.getInstances():
      masterCell = instance.getMasterCell()
      if not masterCell.isTerminal():
	printrecur(instance)
        #print '     - %s (layout).' % masterCell.getName()
        # framework.saveCell( masterCell, CRL.Catalog.State.Physical )

    print '     - %s (layout).' % cell.getName()
    framework.saveCell( cell, CRL.Catalog.State.Physical )

  except ErrorMessage, e:
    print e; errorCode = e.code
  except Exception, e:
    print '\n\n', e; errorCode = 1
    traceback.print_tb(sys.exc_info()[2])

  sys.stdout.flush()
  sys.stderr.flush()
      
  return 0
