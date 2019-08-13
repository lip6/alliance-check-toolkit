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

  parser = optparse.OptionParser()
  parser.add_option( '-c', '--cell'  , type='string',                      dest='cellName'     , help='The name of the BLIF to convert, without extension.')
  parser.add_option( '-v', '--verbose'              , action='store_true', dest='verbose'      , help='First level of verbosity.')
  parser.add_option( '-V', '--very-verbose'         , action='store_true', dest='veryVerbose'  , help='Second level of verbosity.')
  parser.add_option(       '--vst-use-concat'       , action='store_true', dest='vstUseConcat' , help='The VST driver will use "&" (concat) in PORT MAP.')
  (options, args) = parser.parse_args()
  
  views    = CRL.Catalog.State.Logical
  if options.verbose:
    Cfg.getParamBool('misc.verboseLevel1').setBool(True)
  if options.veryVerbose:
    Cfg.getParamBool('misc.verboseLevel1').setBool(True)
    Cfg.getParamBool('misc.verboseLevel2').setBool(True)
  if options.vstUseConcat: views    |= CRL.Catalog.State.VstUseConcat
    
  kw          = {}
  kw['views'] = views
  kw['cell' ] = CRL.Blif.load( options.cellName )

  plugins.RSavePlugin.ScriptMain( **kw )

  sys.exit( 0 )
