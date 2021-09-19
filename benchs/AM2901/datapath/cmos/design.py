#!/usr/bin/env python3

try:
  import sys
  import CRL
  import helpers
  import stratus
except ImportError as e:
  serror = str(e)
  if serror.startswith('No module named'):
    module = serror.split()[-1]
    print( '[ERROR] The "{}" python module or symbol cannot be loaded.'.format(module) )
    print( '        Please check the integrity of the "coriolis" package.' )
    sys.exit(1)
  if str(e).find('cannot open shared object file'):
    library = serror.split(':')[0]
    print( '[ERROR] The "{}" shared library cannot be loaded.'.format(library) )
    print( '        Under RHEL 6, you must be under devtoolset-2.' )
    print( '        (scl enable devtoolset-2 bash)' )
  sys.exit(1)
except Exception as e:
  print( '[ERROR] A strange exception occurred while loading the basic Coriolis/Python' )
  print( '        modules. Something may be wrong at Python/C API level.\n' )
  print( '        {}'.format(e) )
  sys.exit(2)


def scriptMain ( **kw ):
  editor = None
  if 'editor' in kw and kw['editor']:
    editor = kw['editor']
    stratus.setEditor( editor )
  
  cell = stratus.buildModel( 'amd2901_dpt'   , stratus.DoNetlist|stratus.DoLayout )
  cell = stratus.buildModel( 'amd2901_core'  , stratus.DoNetlist|stratus.DoLayout )
  cell = stratus.buildModel( 'corona'        , stratus.DoNetlist )
  cell = stratus.buildModel( 'amd2901'       , stratus.DoNetlist )
  return cell


if __name__ == "__main__" :
  try:
    kw           = {}
    success      = scriptMain( **kw )
    shellSuccess = 0
    if not success: shellSuccess = 1

  except Exception as e:
    helpers.io.catch( e )

  sys.exit( shellSuccess )
