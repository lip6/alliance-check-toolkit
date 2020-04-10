#!/usr/bin/env python
# -*- coding: utf-8 -*-

try:
  import sys
  import traceback
  import os.path
  import shutil
  import subprocess
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
  from   helpers import trace
  from   helpers.io import ErrorMessage
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

def testAddNet( cell ):
    UpdateSession.open()
    print("Cell :" + cell.getName())
    print("Insertion")
    cell.setName(cell.getName() + "_insered")
    framework.saveCell(cell, CRL.Catalog.State.Logical)
    print("Premiere sauvegarde OK")

    # Insertion d'un buffer : creation d'un net, création de l'instance du buffer
    net_mem2wb_to_buf = Net.create(cell,"mem2wb_to_buf")

    instance = cell.getInstance("subckt_173_inv_x1")
    driver_signal = instance.getPlug(instance.getMasterCell().getNet("nq"))

    driver_signal.setNet(net_mem2wb_to_buf)


    Cellbuf_x2 = framework.getCell( "buf_x2" , CRL.Catalog.State.Views )

    buf_instance = Instance.create(cell,"buf2_x2_ins", Cellbuf_x2)

    buf_instance.getPlug(Cellbuf_x2.getNet("i")).setNet(net_mem2wb_to_buf)
    buf_instance.getPlug(Cellbuf_x2.getNet("q")).setNet(cell.getNet("mem2wb_pop"))

    UpdateSession.close()

    print("Debut deuxieme sauvegarde")
    cell.setName(cell.getName() + "_insered_bis")
    framework.saveCell(cell, CRL.Catalog.State.Logical)
    return 1

def scriptMain ( **kw ):
  global framework

  helpers.staticInitialization( quiet=True )
 #helpers.setTraceLevel( 550 )

  scaledDir = framework.getAllianceLibrary(0).getPath()
  alibrary  = framework.getAllianceLibrary(1)

  sourceCell = None
  if kw.has_key('cell') and kw['cell']:
    sourceCell = kw['cell']
  else:
    print ErrorMessage( 1, 'No cell found.' )
    return 0

  if sourceCell:
    # Read config file
    return testAddNet( sourceCell )
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

  success = scriptMain( **kw )
  shellSuccess = 0
  if not success: shellSuccess = 1

  sys.exit( shellSuccess )
