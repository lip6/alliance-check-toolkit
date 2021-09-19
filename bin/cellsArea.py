#!/usr/bin/env python3

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
    import CRL
    from   helpers   import ErrorMessage
except ImportError as e:
    serror = str(e)
    if serror.startswith('No module named'):
        module = serror.split()[-1]
        print( '[ERROR] The "%s" python module or symbol cannot be loaded.' % module )
        print( '        Please check the integrity of the <coriolis> package.' )
        sys.exit(1)
    if str(e).find('cannot open shared object file'):
        library = serror.split(':')[0]
        print( '[ERROR] The "%s" shared library cannot be loaded.' % library )
        print( '        Under RHEL 6, you must be under devtoolset-2.' )
        print( '        (scl enable devtoolset-2 bash)' )
    sys.exit(1)
except Exception as e:
    print( '[ERROR] A strange exception occurred while loading the basic Coriolis/Python' )
    print( '        modules. Something may be wrong at Python/C API level.\n' )
    print( '        %s' % e )
    sys.exit(2)


class CellsArea ( object ):

    def __init__ ( self, pitch ):
        self.libDir      = os.getcwd()
        self.libName     = os.path.basename( self.libDir )
        self.framework   = CRL.AllianceFramework.get()
        self.lambdaValue = DbU.toPhysical( DbU.fromLambda(1.0), DbU.UnitPowerMicro )
        self.pitch       = DbU.fromLambda( pitch )
        
        env = self.framework.getEnvironment() 
        env.addSYSTEM_LIBRARY( library=self.libDir, mode=CRL.Environment.Prepend )
        
        self.library     = self.framework.getLibrary( 0 )
        self.framework.loadLibraryCells( self.library )
        self.areas       = { }
        
        print( env.getPrint() )
        self._computeAreas()
        return
    

    def _computeAreas ( self ):
        for cell in self.library.getCells():
            ab = cell.getAbutmentBox()
            self.areas[ cell.getName() ] = ( ab.getWidth() // self.pitch
                                           , DbU.toLambda(ab.getWidth()) * DbU.toLambda(ab.getHeight())
                                           , DbU.toLambda(ab.getWidth()) * DbU.toLambda(ab.getHeight()) \
                                            * self.lambdaValue * self.lambdaValue
                                           )
        return
    

    def printTable ( self ):
        print( 'Annotating areas for library <%s>' % self.libName )
        print( 'Path: %s\n' % self.libDir )
        print( 'Lambda: %.2f µm'      % self.lambdaValue  )
        print( 'Pitch:  %.2f lambdas\n' % DbU.toLambda(self.pitch))
        print( '==============  ==============  ==============  ==============' )
        print( 'Cell            Pitches         Area (l²)       Area (µm²)' )
        print( '==============  ==============  ==============  ==============' )
        
        for pair in self.areas.items():
            print( '%14s  %14.1f  %14.2f  %14.2f' % ( pair[0], pair[1][0], pair[1][1], pair[1][2] )
        
        print( '==============  ==============  ==============  ==============\n' )
        return


    def annotateLib ( self ):
        cellPattern = re.compile( r'\s*cell\s*\((?P<cell>\w+)\)\s*\{' )
        areaPattern = re.compile( r'(?P<area>\s*area\s*:\s*)\d+.\d+\s*;' )
        
        libertyPath = './' + self.libName + '.lib.new'
        print( 'Back annotating: "%s".' % libertyPath )
        
        if not os.path.isfile( libertyPath ):
            print( '[ERROR] Liberty reference file "%s" not found.' % libertyPath )
            return
        
        fdLib       = open( libertyPath, 'r' )
        currentCell = None
        libContents = ''
        
        for line in fdLib:
            m = cellPattern.match( line )
            if m:
                if currentCell:
                    print( '[WARNING] "%s" has no area attribute in .lib.' )
                currentCell = m.group( 'cell' )
            else:
                if currentCell:
                    m = areaPattern.match( line )
                    if m:
                        if currentCell in self.areas:
                            libContents += '%s%.2f ;\n' % (m.group('area'),self.areas[currentCell][2])
                            currentCell = None
                            continue
                        else:
                            print( '[WARNING] "%s" has no area in table (?).' )
                        currentCell = None
        
          libContents += line
          
        fdLib.close()
        
        fdLib = open( libertyPath, 'w+' )
        fdLib.write( libContents )
        fdLib.close()
        return


if __name__ == '__main__':
    parser = optparse.OptionParser()
    parser.add_option( '-p', '--pitch', type='int', dest='pitch', default=5
                     , help='The routing pitch value (default: 5l).')
    (options, args) = parser.parse_args()
    
    try:
        cellsArea = CellsArea( options.pitch )
        cellsArea.printTable()
        cellsArea.annotateLib()
    
    except Exception as e:
        print( '[ERROR] A strange exception occurred while running the Python' )
        print( '        script. Please check that module for error:\n' )
        traceback.print_tb(sys.exc_info()[2])
        print( '        %s' % e )
        sys.exit(2)

  sys.exit( 0 )
