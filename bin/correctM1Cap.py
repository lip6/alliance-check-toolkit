#!/usr/bin/env python3

try:
  import sys
  import traceback
  import os.path
  import shutil
  import optparse
  import math
  import Cfg
  import Hurricane
  from   Hurricane import DataBase
  from   Hurricane import DbU
  from   Hurricane import Transformation
  from   Hurricane import Box
  from   Hurricane import UpdateSession
  from   Hurricane import Breakpoint
  from   Hurricane import Net
  from   Hurricane import NetExternalComponents
  from   Hurricane import BasicLayer
  from   Hurricane import ContactLayer
  from   Hurricane import ViaLayer
  from   Hurricane import RegularLayer
  from   Hurricane import TransistorLayer
  from   Hurricane import DiffusionLayer
  from   Hurricane import Cell
  from   Hurricane import Instance
  from   Hurricane import Net
  from   Hurricane import Contact
  from   Hurricane import Horizontal
  from   Hurricane import Vertical
  import Viewer
  import CRL
  from   CRL import RoutingLayerGauge
  import helpers
  from   helpers    import trace
  from   helpers.io import ErrorMessage
except ImportError as e:
  serror = str(e)
  if serror.startswith('No module named'):
    module = serror.split()[-1]
    print( '[ERROR] The <%s> python module or symbol cannot be loaded.' % module )
    print( '        Please check the integrity of the <coriolis> package.' )
  if str(e).find('cannot open shared object file'):
    library = serror.split(':')[0]
    print( '[ERROR] The <%s> shared library cannot be loaded.' % library )
    print( '        Under RHEL 6, you must be under devtoolset-2.')
    print( '        (scl enable devtoolset-2 bash)' )
  sys.exit(1)
except Exception as e:
  print( '[ERROR] A strange exception occurred while loading the basic Coriolis/Python' )
  print( '        modules. Something may be wrong at Python/C API level.\n' )
  print( '        %s' % e )
  sys.exit(2)


framework = CRL.AllianceFramework.get()
oneLambda = DbU.fromLambda(  1.0 )
hPitch    = DbU.fromLambda( 10.0 )


def patch ( editor, cell ):
  global framework
  global oneLambda
  global hPitch

  METAL1 = DataBase.getDB().getTechnology().getLayer( 'METAL1' )

  if cell == None:
    raise ErrorMessage( 3, 'correctM1Cap.patch(): Mandatory cell argument is None.' )
  patchedCell = None

  print( '\n  o  Processing', cell )

  UpdateSession.open()
  try:
    library = framework.getLibrary( 0 )

    for net in cell.getNets():
      if not net.isExternal(): continue

      for component in net.getComponents():
        if component.getLayer() != METAL1: continue
        if not isinstance(component,Vertical): continue

        if component.getSourceY() > component.getTargetY(): component.invert()

        yMin = component.getSourceY()
        if yMin < 0:
          print( '[ERROR] Negative source Y for %s, skipped.' % component )
        else:
          modulo = yMin % hPitch
          if (modulo <= oneLambda):
            component.setDySource( yMin - modulo )
            print( '     | Source cap adjusted (was above):', component )
          if (modulo >= 4 * oneLambda):
            component.setDySource( yMin + hPitch - modulo )
            print( '     | Source cap adjusted (was below):', component )

        yMax = component.getTargetY()
        if yMax < 0:
          print( '[ERROR] Negative target Y for %s, skipped.' % component )
        else:
          modulo = yMax % hPitch
          if (hPitch - modulo <= oneLambda):
            component.setDyTarget( yMax + (hPitch - modulo) )
            print( '     | Target cap adjusted (was above):', component )
          if (modulo <= 4 * oneLambda):
            component.setDyTarget( yMax - modulo )
            print( '     | Target cap adjusted (was below):', component )

  except ErrorMessage as e:
      print( e ); errorCode = e.code
  except Exception as e:
      print( '\n\n', e ); errorCode = 1
      traceback.print_tb(sys.exc_info()[2])

  UpdateSession.close()
  framework.saveCell( cell, CRL.Catalog.State.Physical )
  if editor:
    editor.setCell( cell )
    editor.fit()

  return cell


def scriptMain ( **kw ):
  global framework

  helpers.staticInitialization( quiet=True )
 #helpers.setTraceLevel( 550 )

  patchedLib = framework.getAllianceLibrary(0).getPath()
  alibrary   = framework.getAllianceLibrary(1)
  if not alibrary:
    print( '[ERROR] No Library at index 1, please check SYSTEM_LIBRARY in settings.py.' )
    return 1

  hasCatal = False
  apCount  = 0
  vbeCount = 0
  for file in os.listdir( patchedLib ):
    if file      == 'CATAL': hasCatal = True
    if file[-4:] ==  '.vbe': vbeCount += 1
    if file[-3:] ==   '.ap': apCount  += 1

  if hasCatal or vbeCount or apCount:
    print( '[ERROR] Target directory already contains CATAL/.vbe/.ap files.' )
    print( '        You must remove them before proceeding with this script.' )
    print( '        (%s)' % patchedLib )
    return 1

  cell = None
  if 'cell' in kw and kw['cell']:
    cell = kw['cell']

  editor = None
  if 'editor' in kw and kw['editor']:
    editor = kw['editor']
    print( '  o  Editor detected, running in graphic mode.' )
    if cell == None: cell = editor.getCell()

  if cell:
    patchedCell = patch( editor, cell )
  else:
    print( '  o  Processing library "%s".' % alibrary.getLibrary().getName() )
    print( '     (path:%s)'                % alibrary.getPath() )
    framework.loadLibraryCells( alibrary.getLibrary() )
    for cell in alibrary.getLibrary().getCells():
      patchedCell = patch( editor, cell )

    print( '' )
    print( '  o  Direct copy of ".vbe" & CATAL files.' )
    for file in os.listdir( alibrary.getPath() ):
      if file == 'CATAL' or file[-4:] == '.vbe':
        print( '     | %s' % file )
        shutil.copy( alibrary.getPath()+'/'+file, patchedLib )
      
  return 0


if __name__ == '__main__':
  parser = optparse.OptionParser()
  parser.add_option( '-c', '--cell', type='string',                      dest='cell'       , help='The name of the chip to build, whithout extension.')
  parser.add_option( '-v', '--verbose'            , action='store_true', dest='verbose'    , help='First level of verbosity.')
  parser.add_option( '-V', '--very-verbose'       , action='store_true', dest='veryVerbose', help='Second level of verbosity.')
  (options, args) = parser.parse_args()

  kw = {}
  if options.cell:
    kw['cell'] = framework.getCell( options.cell, CRL.Catalog.State.Views )
  if options.verbose:     Cfg.getParamBool('misc.verboseLevel1').setBool(True)
  if options.veryVerbose: Cfg.getParamBool('misc.verboseLevel2').setBool(True)

  print( framework.getEnvironment().getPrint() )

  success = scriptMain( **kw )
  shellSuccess = 0
  if not success: shellSuccess = 1

  sys.exit( shellSuccess )
