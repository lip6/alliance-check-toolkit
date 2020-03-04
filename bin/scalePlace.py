#!/usr/bin/env python
# -*- coding: utf-8 -*-

try:
  import sys
  import traceback
  import os.path
  import shutil
  import optparse
  import math
  import Cfg
  import helpers
  from   helpers.io import ErrorMessage
  from   helpers    import showPythonTrace
  from   helpers    import trace
  helpers.loadUserSettings()
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
  from   Hurricane import Transformation
  from   Hurricane import Net
  from   Hurricane import Contact
  from   Hurricane import Horizontal
  from   Hurricane import Vertical
  import Viewer
  import CRL
  from   CRL import RoutingLayerGauge
except ImportError, e:
  serror = str(e)
  if serror.startswith('No module named'):
    module = serror.split()[-1]
    print '[ERROR] The <%s> python module or symbol cannot be loaded.' % module
    print '        Please check the integrity of the <coriolis> package.'
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


def scalePlace ( editor, sourceCell ):
  global framework

  scale = 2
  if sourceCell == None:
    raise ErrorMessage( 3, 'scalePlace.scalePlace(): Mandatory sourceCell argument is None.' )
  scaledCell = None

  print '\n  o  Processing', sourceCell

  UpdateSession.open()
  try:
    library    = framework.getLibrary( 0 )
    scaledCell = Cell.create( library, sourceCell.getName()+'_scaled' )

    ab = sourceCell.getAbutmentBox()
    scaledCell.setAbutmentBox( Box( ab.getXMin()*scale, ab.getYMin()*scale
                                  , ab.getXMax()*scale, ab.getYMax()*scale ) )

    for net in sourceCell.getNets():
      scaledNet = Net.create( scaledCell, net.getName() )
      if net.isExternal(): scaledNet.setExternal( True )
      if net.isGlobal  (): scaledNet.setGlobal  ( True )
      scaledNet.setType     ( net.getType     () )
      scaledNet.setDirection( net.getDirection() )

    for instance in sourceCell.getInstances():
      origTransf   = instance.getTransformation()
      print instance, origTransf

      if    origTransf.getOrientation() == Transformation.Orientation.MY \
         or origTransf.getOrientation() == Transformation.Orientation.R2:
        cellHeight = instance.getMasterCell().getAbutmentBox().getHeight()
        y          = (origTransf.getTy() - cellHeight)*2 + cellHeight
      else:
        y = origTransf.getTy() * 2

      if    origTransf.getOrientation() == Transformation.Orientation.MX \
         or origTransf.getOrientation() == Transformation.Orientation.R2:
        cellWidth = instance.getMasterCell().getAbutmentBox().getWidth()
        x         = (origTransf.getTx() - cellWidth)*2 + cellWidth
      else:
        x = origTransf.getTx() * 2

      scaledTransf = Transformation( x, y, origTransf.getOrientation() )
      copyInstance = Instance.create( scaledCell
                                    , instance.getName()
                                    , instance.getMasterCell()
                                    , scaledTransf
                                    , instance.getPlacementStatus() )

      for origPlug in instance.getPlugs():
        origNet = origPlug.getNet()
        if origNet:
          copyInstance.getPlug(
            copyInstance.getMasterCell().getNet(origPlug.getMasterNet().getName())
          ).setNet( scaledCell.getNet(origNet.getName()) )

  except ErrorMessage, e:
      print e; errorCode = e.code
  except Exception, e:
      print '\n\n', e; errorCode = 1
      traceback.print_tb(sys.exc_info()[2])

  UpdateSession.close()
  if scaledCell:
    framework.saveCell( scaledCell, CRL.Catalog.State.Views )
    if editor:
      editor.setCell( scaledCell )
      editor.fit()

  return scaledCell


def ScriptMain ( **kw ):
  global framework

  helpers.staticInitialization( quiet=True )
 #helpers.setTraceLevel( 550 )

  sourceCell = None
  if kw.has_key('cell') and kw['cell']:
    sourceCell = kw['cell']

  editor = None
  if kw.has_key('editor') and kw['editor']:
    editor = kw['editor']
    print '  o  Editor detected, running in graphic mode.'
    if sourceCell == None: sourceCell = editor.getCell()

  if sourceCell:
    scaledCell = scalePlace( editor, sourceCell )
      
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

  print framework.getEnvironment().getPrint()

  success = ScriptMain( **kw )
  shellSuccess = 0
  if not success: shellSuccess = 1

  sys.exit( shellSuccess )
