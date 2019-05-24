#!/usr/bin/env python

try:
  import sys
  import traceback
  import os.path
  import optparse
  import Cfg
  import Hurricane
  from   Hurricane  import DbU
  from   Hurricane  import UpdateSession
  from   Hurricane  import Breakpoint
  from   Hurricane  import Transformation
  from   Hurricane  import Instance
  import Viewer
  import CRL
  from   helpers.io import ErrorMessage
  import plugins.RSavePlugin
except ImportError, e:
  serror = str(e)
  if serror.startswith('No module named'):
    module = serror.split()[-1]
    print '[ERROR] The <%s> python module or symbol cannot be loaded.' % module
    print '        Please check the integrity of the <coriolis> package.'
    sys.exit(1)
  if str(e).find('cannot open shared object file'):
    library = serror.split(':')[0]
    print '[ERROR] The <%s> shared library cannot be loaded.' % library
    print '        Under RHEL 6, you must be under devtoolset-2.'
    print '        (scl enable devtoolset-2 bash)'
  sys.exit(1)
except Exception, e:
  print '[ERROR] A strange exception occurred while loading the basic Coriolis/Python'
  print '        modules. Something may be wrong at Python/C API level.\n'
  print '        %s' % e
  sys.exit(2)


framework = CRL.AllianceFramework.get()


if __name__ == '__main__':
  if len(sys.argv) != 2:
    print ''
    print 'Usage: blif2vst.py <blifName>'
    print ''
    print '  <blifName> is the sole and mandatory argument. It must be given'
    print '  without the ".blif" extension.'
    sys.exit( 1 )

  cellName    = sys.argv[1]
  kw          = {}
  kw['views'] = CRL.Catalog.State.Logical
  kw['cell' ] = CRL.Blif.load( cellName )

  plugins.RSavePlugin.ScriptMain( **kw )

  sys.exit( 0 )
