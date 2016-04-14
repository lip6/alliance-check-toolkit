#!/usr/bin/env python
# -*- coding: utf-8 -*-

try:
  import sys
  import re
  import traceback
  import os.path
  import optparse
  import Cfg
  import Hurricane
  from   Hurricane import DbU
  from   Hurricane import DataBase
  from   Hurricane import UpdateSession
  from   Hurricane import Breakpoint
  from   Hurricane import Transformation
  from   Hurricane import Instance
  import Viewer
  import CRL
  from   helpers   import ErrorMessage
  import Etesian
  import Katabatic
  import Kite
  import Unicorn
  import clocktree.ClockTree
  import plugins.ClockTreePlugin
  import plugins.ChipPlugin
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


class CellsArea ( object ):

    def __init__ ( self, libName ):
      self.libName     = libName
      self.framework   = CRL.AllianceFramework.get()
      self.lambdaValue = DbU.toPhysical( DbU.fromLambda(1.0), DbU.UnitPowerMicro )
      self.pitch       = DbU.fromLambda( 10.0 )
      self.library     = self.framework.getLibrary( libName )

      self.framework.loadLibraryCells( libName )
      self.areas     = { }
    
      print self.framework.getEnvironment().getPrint()
      self._computeAreas()
      return
    

    def _computeAreas ( self ):
      for cell in self.library.getCells():
        ab = cell.getAbutmentBox()
        self.areas[ cell.getName() ] = ( ab.getWidth() / self.pitch
                                       , DbU.toLambda(ab.getWidth()) * DbU.toLambda(ab.getHeight())
                                       , DbU.toLambda(ab.getWidth()) * DbU.toLambda(ab.getHeight()) \
                                        * self.lambdaValue * self.lambdaValue
                                       )
      return
    

    def printTable ( self ):
      print ''
      print 'Lambda: %.2f µm'      % self.lambdaValue 
      print 'Pitch:  %.2f lambdas' % DbU.toLambda(self.pitch)
      print ''
      print '==============  ==============  ==============  =============='
      print 'Cell            Pitches         Area (l²)       Area (µm²)'
      print '==============  ==============  ==============  =============='
    
      for pair in self.areas.items():
        print '%14s  %14.1f  %14.2f  %14.2f' % ( pair[0], pair[1][0], pair[1][1], pair[1][2] )
    
      print '==============  ==============  ==============  =============='
      print ''
      return


    def annotateLib ( self ):
      cellPattern = re.compile( r'\s*cell\s*\((?P<cell>\w+)\)\s*\{' )
      areaPattern = re.compile( r'(?P<area>\s*area\s*:\s*)\d+.\d+\s*;' )

      libertyPath = './' + self.libName + '.lib.new'
      print 'Back annotating: \"%s\".' % libertyPath

      if not os.path.isfile( libertyPath ):
        print '[ERROR] Liberty reference file \"%s\" not found.' % libertyPath
        return

      fdLib       = open( libertyPath, 'r' )
      currentCell = None
      libContents = ''

      for line in fdLib:
        m = cellPattern.match( line )
        if m:
          if currentCell:
            print '[WARNING] \"%s\" has no area attribute in .lib.'
          currentCell = m.group( 'cell' )
        else:
          if currentCell:
            m = areaPattern.match( line )
            if m:
              if self.areas.has_key(currentCell):
                libContents += '%s%.2f ;\n' % (m.group('area'),self.areas[currentCell][2])
                currentCell = None
                continue
              else:
                print '[WARNING] \"%s\" has no area in table (?).'
              currentCell = None

        libContents += line
        
      fdLib.close()

      fdLib = open( libertyPath, 'w+' )
      fdLib.write( libContents )
      fdLib.close()
      return


if __name__ == '__main__':
  parser = optparse.OptionParser()
  parser.add_option( '-l', '--library', type='string', dest='library', help='The name of the Alliance library to process.')
  (options, args) = parser.parse_args()

  if not options.library:
    print '[ERROR] Missing mandatory argument <library>.'
    sys.exit( 1 )

  try:
    cellsArea = CellsArea( options.library )
    cellsArea.printTable()
    cellsArea.annotateLib()

  except Exception, e:
    print '[ERROR] A strange exception occurred while running the Python'
    print '        script. Please check that module for error:\n'
    traceback.print_tb(sys.exc_info()[2])
    print '        %s' % e
    sys.exit(2)

  sys.exit( 0 )
