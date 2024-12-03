#!/usr/bin/env python3

import sys
import os
import os.path
from   pathlib import Path
import socket
import subprocess
import re
import argparse


reCoriolisPattern = re.compile( r".*coriolis.*" )
reReleasePattern  = re.compile( r".*release.*" )
reDebugPattern    = re.compile( r".*debug.*" )


def isInVenv():
    return (hasattr(sys, 'real_prefix') or
           (hasattr(sys, 'base_prefix') and sys.base_prefix != sys.prefix))


def scrubPath ( pathName ):
    """
    Remove from the PATH like environment variable ``pathName`` any
    previous path item referring to a Coriolis location.
    """
    if not pathName in os.environ: return ''
    value    = os.environ[ pathName ]
    elements = value.split( ':' )
    scrubbed = []
    for element in elements:
        if element == '': continue
        if    reCoriolisPattern.match(element) \
           or reReleasePattern .match(element) \
           or reDebugPattern   .match(element):
            continue
        scrubbed.append( element )
    if len(scrubbed) == 0: return ''
    return ':'.join( scrubbed )


def envWriteBack ( pathName, pathValues ):
    """
    Add to the environment PATH like variable ``pathName`` the components
    given in ``pathValue`` and export it back. To avoid having multiple
    Coriolis in the path, it is scrubbed beforehand.
    """
    if pathName in os.environ:
        scrubbed = scrubPath( pathName )
        if scrubbed != '':
            pathValues += ':' + scrubbed
    os.environ[ pathName ] = pathValues
    return pathValues


def setupPaths ( verbose, debug=False ):
    """
    Guess and setup the main variables to use Coriolis:

    * ``PATH``, to find the binaries.
    * ``LD_LIBRARY_PATH``, to access the dynamic libraries.
    * ``DYLD_LIBRARY_PATH``, same as above under MacOS.
    * ``PYTHONPATH``, to access the various Python modules provided
      by Coriolis.

    :param verbose: Self explanatory.
    :param debug:   Use the version compiled with debugging support.
                    Be aware that it is roughly 4 times slower...                
                    It's the tree rooted at ``debug/install``
                    instead of  ``release/install``.
    """
    # Setup CORIOLIS_TOP.
    osDarwin = re.compile (".*Darwin.*")
    osType   = 'Linux'
    uname    = subprocess.Popen( ["uname", "-srm"], stdout=subprocess.PIPE )
    lines    = uname.stdout.readlines()
    line     = lines[0].decode( 'ascii' )
    if osDarwin.match(line): osType = "Darwin"

    homeDir    = Path( os.environ['HOME'] )
    buildType  = Path( 'debug' if debug else 'release' )
    scriptPath = Path( __file__ ).resolve()
    topDirs    = []

    topDirs  += [ homeDir / 'coriolis-2.x' / buildType / 'install'
                , Path( '/soc/coriolis2' ) 
                , Path( '/usr' ) 
                ]
    if not debug and 'CORIOLIS_TOP' in os.environ:
        topDirs.insert( 0, Path( os.environ['CORIOLIS_TOP'] ))
    for part in scriptPath.parts:
        if part == 'nightly':
            topDirs.insert( 0, homeDir / 'nightly' / 'coriolis-2.x' / buildType / 'install' )
            break
    if verbose:
        print( '  o  Self locating Coriolis:' )
    coriolisTop = None
    libArchDir  = None
    for topDir in topDirs:
        if not coriolisTop:
            libHurricaneFound = False
            if   (topDir / 'lib64' / 'libhurricane.so').is_file(): libHurricaneFound = True
            elif (topDir / 'lib'   / 'libhurricane.so').is_file(): libHurricaneFound = True
            else:
                if (topDir / 'lib').is_dir():
                    for subDir in (topDir / 'lib').iterdir():
                        if (subDir / 'libhurricane.so').is_file():
                            libArchDir        = subDir
                            libHurricaneFound = True
                            break
            if libHurricaneFound:
                coriolisTop = topDir
                if verbose: print( '     - {} *'.format( topDir ))
                continue
        if verbose: print( '     - {}'.format(topDir) )
    if not coriolisTop:
        print( '[ERROR] environment.setupPaths(): Unable to locate Coriolis.' )
        return False

    os.environ[ 'CORIOLIS_TOP' ] = coriolisTop.as_posix()
    #if coriolisTop == '/usr': sysconfDir = Path( 'etc', 'coriolis2' )
    #else:                     sysconfDir = coriolisTop / 'etc' / 'coriolis2'
    if coriolisTop == '/usr': sysconfDir = Path( 'etc' )
    else:                     sysconfDir = coriolisTop / 'etc'

    # Setup PATH.
    customPath = (coriolisTop/'bin').as_posix()
    if isInVenv():
        customPath += ":" + sys.prefix + '/bin'
    binPath = envWriteBack( 'PATH', customPath )

    # Setup LD_LIBRARY_PATH.
    libDirs = []
    for lib in [ Path('lib'), Path('lib64') ]:
        libDir    = lib
        absLibDir = coriolisTop / lib
        if absLibDir.is_dir():
            libDirs.append( absLibDir )
        libDir = None
    if libArchDir:
        libDirs.append( libArchDir )
    if not len(libDirs):
        print( '[ERROR] environment.setupPaths(): Library directory not found.' )
        return False
    libraryPath = ''
    ldPathName  = 'LD_LIBRARY_PATH'
    if osType == 'Darwin':
        ldPathName  = 'DYLD_LIBRARY_PATH'
    for libDir in libDirs:
        if len(libraryPath): libraryPath = libraryPath + ':'
        libraryPath = libraryPath + libDir.as_posix()
    libraryPath = envWriteBack( ldPathName, libraryPath )

    # Setup PYTHONPATH.
    v = sys.version_info
    sitePackagesDir = None
    for libDir in libDirs:
        for pyPackageDir in [ Path('python{}.{}'.format(v.major,v.minor)) / 'site-packages'
                            , Path('python{}.{}'.format(v.major,v.minor)) / 'dist-packages'
                            , Path('{}.{}'.format(v.major,v.minor)) / 'site-packages'
                            , Path('python{}'.format(v.major)) / 'site-packages'
                            , Path('python{}'.format(v.major)) / 'dist-packages'
                            , Path('{}'.format(v.major)) / 'site-packages'
                            ]:
            sitePackagesDir = libDir / pyPackageDir
            if sitePackagesDir.is_dir():
                if verbose:
                    print( '     - {} *'.format(sitePackagesDir) )
                break
            else:
                if verbose:
                    print( '     - {}'.format(sitePackagesDir) )
                sitePackagesDir = None
        if sitePackagesDir:
            break
    if sitePackagesDir is None:
        print( '[ERROR] environment.setupPaths(): Python {site,dist}-packages directory not found.' )
        return False
    pythonPath = ''
    for packageDir in [ sitePackagesDir
                     #, sitePackagesDir / 'crlcore'
                     #, sitePackagesDir / 'cumulus'
                     #, sitePackagesDir / 'cumulus/plugins'
                     #, sitePackagesDir / 'status'
                     #, sysconfDir
                      ]:
        sys.path.append( str(packageDir) )
        if len(pythonPath): pythonPath += ':'
        pythonPath += str(packageDir)
    pythonPath = envWriteBack( 'PYTHONPATH', pythonPath )
    return True


def printVariable ( name ):
    if not name in os.environ:
        print( '  {}:'.format( name ))
        print( '    - variable_not_set' )
        return
    values = os.environ[ name ].split( ':' )
    print( '  {}:'.format( name ))
    for value in values:
        print( '    - {}'.format( value ))


def printEnvironment ():
    """
    Display the environment setup, using YAML formatting.
    """
    print( '# crlenv.py: Alliance/Coriolis finder, guessed values.' )
    print( '---' )
    print( 'Environment:' )
    print( '  isInVenv:' )
    print( '    state:          ', isInVenv() )
    print( '    sys.prefix:     ', sys.prefix )
    print( '    sys.base_prefix:', sys.base_prefix )
    for name in ('CORIOLIS_TOP', 'PATH', 'DYLD_LIBRARY_PATH'
                , 'LD_LIBRARY_PATH', 'PYTHONPATH'):
        printVariable( name )


if __name__ == '__main__':
    """
    Run any script in a environmnent set for Coriolis.

    Example:

    .. code:: bash

       ego@home:~> crlenv.py -- doit clean_flow
       b2v          Run <blif2vst arlet6502 depends=[Arlet6502.blif]>.
       cgt          Run plain CGT (no loaded design)
       clean_flow   Clean all generated (targets) files.
       gds          Run <Alias "gds" for "pnr">.
       pnr          Run <pnr arlet6502_cts_r.gds depends=[arlet6502.vst,Arlet6502.spi]>.
       yosys        Run <yosys Arlet6502.v top=Arlet6502 blackboxes=[] flattens=[]>.
       ego@home:~> crlenv.py -- bash
       [ego@home]$ echo $CORIOLIS_TOP
       /home/ego/coriolis-2.x/Linux.el9/Release.Shared/install
       [ego@home]$ exit
       ego@home:~>
    """
    parser = argparse.ArgumentParser()  
    parser.add_argument( '-v', '--verbose', action='store_true', dest='verbose' )
    parser.add_argument( '-d', '--debug'  , action='store_true', dest='debug'   )
    parser.add_argument( 'command', nargs='*' )
    args = parser.parse_args()

    setupPaths( args.verbose, args.debug )
    if not len(args.command):
        printEnvironment()
        sys.exit( 0 )
    state = subprocess.run( args.command )
    sys.exit( state.returncode )
