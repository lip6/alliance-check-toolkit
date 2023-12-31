#!/usr/bin/env python

try:
  import sys
  import CRL
  import stratus
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


def scriptMain ( **kw ):
  editor = None
  if kw.has_key('editor') and kw['editor']:
    editor = kw['editor']
    stratus.setEditor( editor )

  cell = stratus.buildModel( 'dpgen_RF2'
                           , stratus.DoNetlist #|stratus.DoLayout
                           , 'DpgenRf2d'
                           , parameters={ 'nbit' :32
                                        , 'nword':32 }
                           )
  return cell


if __name__ == "__main__" :
  kw           = {}
  success      = scriptMain( **kw )
  shellSuccess = 0
  if not success: shellSuccess = 1

  sys.exit( shellSuccess )





Generate("DpgenRf2r0",   'banc',       param={'nbit' : 32, 'nword' : 32,'physical' : True})
