#!/usr/bin/env python3
#
# -*- mode:Python -*-
#
# This file is part of the Coriolis Software.
# Copyright (c) Sorbonne Université 2015-2021, All Rights Reserved
#
# +-----------------------------------------------------------------+ 
# |                   C O R I O L I S                               |
# |         C o r i o l i s   I n s t a l l e r                     |
# |                                                                 |
# |  Authors     :                    Jean-Paul Chaput              |
# |  E-mail      :       Jean-Paul.Chaput@asim.lip6.fr              |
# | =============================================================== |
# |  Python      :   "./socInstaller.py"                            |
# +-----------------------------------------------------------------+
#
# WARNING:
#   This script has been designed only for internal use in the
#   LIP6/CIAN department. If you want to use it you will need to
#   change the hardwired configuration.


showTrace = True

try:
    import sys
    import os.path
    import shutil
    import optparse
    import time
    import traceback
    import distutils.sysconfig
    import subprocess
    import socket
    import re
    import bz2
    import smtplib
    from io                     import IOBase
    from email.mime.text        import MIMEText
    from email.mime.multipart   import MIMEMultipart
    from email.mime.application import MIMEApplication
except ImportError as e:
    module = str(e).split()[-1]


class ErrorMessage ( Exception ):

    def __init__ ( self, code, *arguments ):
        self._code   = code
        self._errors = [ 'Malformed call to ErrorMessage()', '{}'.format(arguments) ]
        text = None
        if len(arguments) == 1:
            if isinstance(arguments[0],Exception): text = str(arguments[0]).split('\n')
            else:
                self._errors = arguments[0]
        elif len(arguments) > 1:
            text = list(arguments)
        if text:
            self._errors = []
            while len(text[0]) == 0: del text[0]
            lstrip = 0
            if text[0].startswith('[ERROR]'): lstrip = 8
            for line in text:
                if line[0:lstrip  ] == ' '*lstrip or \
                   line[0:lstrip-1] == '[ERROR]':
                    self._errors += [ line[lstrip:] ]
                else:
                    self._errors += [ line.lstrip() ]
        return

    def __str__ ( self ):
        if not isinstance(self._errors,list):
            return "[ERROR] {}".format(self._errors)
        formatted = "\n"
        for i in range(len(self._errors)):
            if i == 0: formatted += "[ERROR] {}".format(self._errors[i])
            else:      formatted += "        {}".format(self._errors[i])
            if i+1 < len(self._errors): formatted += "\n"
        return formatted

    def addMessage ( self, message ):
        if not isinstance(self._errors,list):
            self._errors = [ self._errors ]
        if isinstance(message,list):
            for line in message:
                  self._errors += [ line ]
        else:
            self._errors += [ message ]
        return

    def terminate ( self ):
        print( self )
        sys.exit(self._code)

    @property
    def code ( self ): return self._code


class BadBinary ( ErrorMessage ):

    def __init__ ( self, binary ):
        ErrorMessage.__init__( self, 1, 'Binary not found: "{}".'.format(binary) )
        return


class BadReturnCode ( ErrorMessage ):

    def __init__ ( self, status ):
        ErrorMessage.__init__( self, 1, 'Command returned status:{}.'.format(status) )
        return


class Command ( object ):

    def __init__ ( self, arguments, fdLog=None ):
        self.arguments = arguments
        self.fdLog     = fdLog
        if self.fdLog != None and not isinstance(self.fdLog,IOBase):
            print( '[WARNING] Command.__init__(): "fdLog" is neither None or a file.' )
        return

    def _argumentsToStr ( self, arguments ):
        s = ''
        for argument in arguments:
            if argument.find(' ') >= 0: s += ' "' + argument + '"'
            else:                       s += ' '  + argument
        return s

    def log ( self, text ):
        if isinstance(self.fdLog,IOBase):
            if isinstance(text,bytes):
                print( text[:-1].decode('utf-8') )
                self.fdLog.write( text.decode('utf-8') )
            elif isinstance(text,str):
                print( text[:-1] )
                self.fdLog.write( text )
            else:
                print( '[ERROR] Command.log(): "text" is neither bytes or str.' )
                print( '        {}'.format(text) )
            self.fdLog.flush()
        sys.stdout.flush()
        sys.stderr.flush()
        return

    def execute ( self ):
        global conf
        sys.stdout.flush()
        sys.stderr.flush()
        
        homeDir = os.environ['HOME']
        workDir = os.getcwd()
        if homeDir.startswith(homeDir):
            workDir = '~' + workDir[ len(homeDir) : ]
        user = 'root'
        if 'USER' in os.environ: user = os.environ['USER']
        prompt = '{}@{}:{}$'.format(user,conf.masterHost,workDir)
        
        try:
            self.log( '{}{}\n'.format(prompt,self._argumentsToStr(self.arguments)) )
            print( self.arguments )
            child = subprocess.Popen( self.arguments, stdout=subprocess.PIPE, stderr=subprocess.STDOUT )
            while True:
                line = child.stdout.readline()
                if not line: break
                self.log( line )
        except OSError as e:
            raise BadBinary( self.arguments[0] )
        
        (pid,status) = os.waitpid( child.pid, 0 )
        status >>= 8
        if status != 0:
            raise BadReturnCode( status )
        return


class CommandArg ( object ):

    def __init__ ( self, command, wd=None, host=None, fdLog=None ):
        self.command = command
        self.host    = host
        self.wd      = wd
        self.fdLog   = fdLog
        return

    def __str__ ( self ):
        s = ''
        if self.wd: s = 'cd {} && '.format(self.wd)
        for i in range(len(self.command)):
            if i: s += ' '
            s += self.command[i]
        return s

    def getArgs ( self ):
        if not self.host: return self.command
        return [ 'ssh', self.host, str(self) ]

    def execute ( self ):
        if not self.host and self.wd: os.chdir( self.wd )
        Command( self.getArgs(), self.fdLog ).execute()
        return


class YosysCommand ( CommandArg ):

    def __init__ ( self, yosysBin, fdLog=None ):
        CommandArg.__init__ ( self, [ yosysBin ], fdLog=fdLog )
        return


class AllianceCommand ( CommandArg ):

    def __init__ ( self, srcDir, fdLog=None ):
        CommandArg.__init__ ( self, [ 'make'
                                    , '-f', 'Makefile.LIP6'
                                    , 'install_alliance' ]
                                  , wd=srcDir+'/coriolis'
                                  , fdLog=fdLog )
        return


class CoriolisCommand ( CommandArg ):

    def __init__ ( self, srcDir, threads=1, otherArgs=[], fdLog=None ):
        CommandArg.__init__ ( self, [ 'make'
                                    , '-f', 'Makefile.LIP6'
                                    , 'install'
                                    ] + otherArgs
                                  , wd=srcDir+'/coriolis'
                                  , fdLog=fdLog )
        return


class PdkIHPsg13g2Command ( CommandArg ):

    def __init__ ( self, srcDir, threads=1, otherArgs=[], fdLog=None ):
        CommandArg.__init__ ( self, [ './build-LIP6.sh' ] + otherArgs
                                  , wd=srcDir+'/coriolis-pdk-ihpsg13g2'
                                  , fdLog=fdLog )
        return


class PdkIHPsg13g2c4mCommand ( CommandArg ):

    def __init__ ( self, srcDir, threads=1, otherArgs=[], fdLog=None ):
        CommandArg.__init__ ( self, [ './build-LIP6.sh' ] + otherArgs
                                  , wd=srcDir+'/coriolis-pdk-ihpsg13g2-c4m'
                                  , fdLog=fdLog )
        return


class PdkGF180mcuCommand ( CommandArg ):

    def __init__ ( self, srcDir, threads=1, otherArgs=[], fdLog=None ):
        CommandArg.__init__ ( self, [ './build-LIP6.sh' ] + otherArgs
                                  , wd=srcDir+'/coriolis-pdk-gf180mcu'
                                  , fdLog=fdLog )
        return


class PdkGF180mcuc4mCommand ( CommandArg ):

    def __init__ ( self, srcDir, threads=1, otherArgs=[], fdLog=None ):
        CommandArg.__init__ ( self, [ './build-LIP6.sh' ] + otherArgs
                                  , wd=srcDir+'/coriolis-pdk-gf180mcu-c4m'
                                  , fdLog=fdLog )
        return


class PdkSky130c4mCommand ( CommandArg ):

    def __init__ ( self, srcDir, threads=1, otherArgs=[], fdLog=None ):
        CommandArg.__init__ ( self, [ './build-LIP6.sh' ] + otherArgs
                                  , wd=srcDir+'/coriolis-pdk-sky130-c4m'
                                  , fdLog=fdLog )
        return


class PdkNsx2Command ( CommandArg ):

    def __init__ ( self, srcDir, threads=1, otherArgs=[], fdLog=None ):
        CommandArg.__init__ ( self, [ './build-LIP6.sh' ] + otherArgs
                                  , wd=srcDir+'/coriolis-pdk-nsx2'
                                  , fdLog=fdLog )
        return


class BenchsCommand ( CommandArg ):

    def __init__ ( self, benchsDir, fdLog=None ):
        CommandArg.__init__ ( self, [ '../bin/go.sh' ], wd=benchsDir, fdLog=fdLog )
        return


class PyBenchsCommand ( CommandArg ):

    def __init__ ( self, benchsDir, fdLog=None ):
        CommandArg.__init__ ( self, [ '../bin/gopy.sh' ], wd=benchsDir, fdLog=fdLog )
        return
        


class GitRepository ( object ):

    @staticmethod
    def getLocalRepository ( url ):
        localRepo = url.split( '/' )[-1]
        if localRepo.endswith('.git'):
          localRepo = localRepo[:-4]
        return localRepo

    def __init__ ( self, url, cloneDir, fdLog=None ):
        self.url       = url
        self.cloneDir  = cloneDir
        self.localRepo = GitRepository.getLocalRepository( url )
        self.fdLog     = fdLog
        return

    @property
    def localRepoDir ( self ): return self.cloneDir+'/'+self.localRepo

    def removeLocalRepo ( self ):
        if os.path.isdir(self.localRepoDir):
            print( 'Removing Git local repository: "{}"'.format(self.localRepoDir) )
            shutil.rmtree( self.localRepoDir )
        return

    def clone ( self ):
        print( 'Clone/pull from:', self.url )
        if not os.path.isdir(self.cloneDir):
            os.makedirs( self.cloneDir )
        if not os.path.isdir(self.localRepoDir):
            os.chdir( self.cloneDir )
            Command( [ 'git', 'clone', self.url ], self.fdLog ).execute()
        else:
            os.chdir( self.localRepoDir )
            Command( [ 'git', 'pull' ], self.fdLog ).execute()
        return

    def checkout ( self, branch ):
        os.chdir( self.localRepoDir )
        Command( [ 'git', 'checkout', branch ], self.fdLog ).execute()
        return

    def submoduleUpdate ( self ):
        os.chdir( self.localRepoDir )
        Command( [ 'git', 'submodule', 'update', '--init', '--recursive' ], self.fdLog ).execute()
        return


class Configuration ( object ):

    PrimaryNames = \
        [ 'sender'          , 'receivers'
        , 'coriolisRepo'    , 'benchsRepo' , 'supportRepos'
        , 'pdkIHPsg13g2Repo', 'pdkIHPsg13g2c4mRepo'
        , 'pdkGF180mcuRepo' , 'pdkGF180mcuc4mRepo'
        , 'homeDir'         , 'masterHost'
        , 'debugArg'        , 'nightlyMode', 'dockerMode', 'chrootMode'
        , 'rmSource'        , 'rmBuild'
        , 'doGit'           , 'doAlliance'       , 'doCoriolis'   , 'doBenchs', 'doPyBenchs', 'doSendReport'
        , 'doPdkIHPsg13g2'  , 'doPdkIHPsg13g2c4m', 'doPdkGF180mcu', 'doPdkGF180mcuc4m'
        , 'success'         , 'rcode'
        ]
    SecondaryNames = \
        [ 'rootDir', 'srcDir', 'logDir', 'logs', 'fds', 'yosysBin', 'benchsDir'
        ]

    def __init__ ( self ):
        self._sender              = 'Jean-Paul.Chaput@soc.lip6.fr'
        self._receivers           = [ 'Jean-Paul.Chaput@lip6.fr', ]
        self._supportRepos        = [ 'https://github.com/Tencent/rapidjson.git' ]
        self._allianceRepo        = 'https://github.com/lip6/alliance.git'
        self._coriolisRepo        = 'https://github.com/lip6/coriolis.git'
        self._pdkIHPsg13g2Repo    = 'https://github.com/lip6/coriolis-pdk-ihpsg13g2.git'
        self._pdkIHPsg13g2c4mRepo = 'https://github.com/lip6/coriolis-pdk-ihpsg13g2-c4m.git'
        self._pdkGF180mcuRepo     = 'https://github.com/lip6/coriolis-pdk-gf180mcu.git'
        self._pdkGF180mcuc4mRepo  = 'https://github.com/lip6/coriolis-pdk-gf180mcu-c4m.git'
        self._pdkSky130c4mRepo    = 'https://github.com/lip6/coriolis-pdk-sky130-c4m.git'
        self._pdkNsx2Repo         = 'https://github.com/lip6/coriolis-pdk-nsx2.git'
        self._benchsRepo          = 'https://github.com/lip6/alliance-check-toolkit.git'
        self._homeDir           = os.environ['HOME']
        self._debugArg          = ''
        self._rmSource          = False
        self._rmBuild           = False
        self._doGit             = True
        self._doYosys           = False
        self._doAlliance        = False
        self._doCoriolis        = False
        self._doPdkIHPsg13g2    = False
        self._doPdkIHPsg13g2c4m = False
        self._doPdkGF180mcu     = False
        self._doPdkGF180mcuc4m  = False
        self._doBenchs          = False
        self._doPyBenchs        = False
        self._doSendReport      = False
        self._nightlyMode       = False
        self._dockerMode        = False
        self._chrootMode        = None
        self._logs              = { 'alliance'       :None
                                  , 'coriolis'       :None
                                  , 'pdkIHPsg13g2'   :None
                                  , 'pdkIHPsg13g2c4m':None
                                  , 'pdkGF180mcu'    :None
                                  , 'pdkGF180mcuc4m' :None
                                  , 'pdkSky130c4m'   :None
                                  , 'pdkNsx2'        :None
                                  , 'benchs'         :None }
        self._fds               = { 'alliance'       :None
                                  , 'coriolis'       :None
                                  , 'pdkIHPsg13g2'   :None
                                  , 'pdkIHPsg13g2c4m':None
                                  , 'pdkGF180mcu'    :None
                                  , 'pdkGF180mcuc4m' :None
                                  , 'pdkSky130c4m'   :None
                                  , 'pdkNsx2'        :None
                                  , 'benchs'         :None }
        self._benchsDir         = None
        self._masterHost        = self._detectMasterHost()
        self._success           = False
        self._rcode             = 0
        self._updateSecondaries()
        return

    def __setattr__ ( self, attribute, value ):
        if attribute in Configuration.SecondaryNames:
            print( ErrorMessage( 1, 'Attempt to write in read-only attribute "{}" in Configuration.' \
                                    .format(attribute) ))
            return
        
        if attribute == 'masterHost' or attribute == '_masterHost':
            if value == 'lepka':
                print( 'Never touch the Git tree when running on "lepka".' )
                self._rmSource     = False
                self._rmBuild      = False
                self._doGit        = False
                self._doSendReport = False
        if attribute[0] == '_':
            self.__dict__[attribute] = value
            return
        if attribute == 'homeDir': value = os.path.expanduser(value)
        
        self.__dict__['_'+attribute] = value
        self._updateSecondaries()
        return

    def __getattr__ ( self, attribute ):
        if attribute[0] != '_': attribute = '_'+attribute
        if not attribute in self.__dict__:
            raise ErrorMessage( 1, 'Configuration has no attribute "{}".'.format(attribute) )
        return self.__dict__[attribute]

    def _updateSecondaries ( self ):
        if self._nightlyMode:
            self._rootDir = self._homeDir + '/nightly/coriolis-2.x'
        else:
            self._rootDir  = self._homeDir + '/coriolis-2.x'
        self._srcDir     = self._rootDir + '/src'
        self._logDir     = self._srcDir  + '/logs'
        self._yosysBin   = self._srcDir  + '/' + GitRepository.getLocalRepository(self._coriolisRepo) + '/bootstrap/yosysInstaller.sh'
        self._benchsDir  = self._srcDir  + '/' + GitRepository.getLocalRepository(self._benchsRepo  ) + '/benchs'
        self._masterHost = self._detectMasterHost()
        return

    def _detectMasterHost ( self ):
        if self._chrootMode is None: return 'unknown'
        if self._chrootMode: return 'chrooted-host'
        masterHost = 'unknown'
        hostname   = socket.gethostname()
        hostAddr   = socket.gethostbyname(hostname)
        if hostname == 'lepka' and hostAddr == '127.0.0.1':
            masterHost = 'lepka'
        else:
            masterHost = hostname.split('.')[0]
        return masterHost

    def openLog ( self, stem ):
        if not os.path.isdir(self._logDir):
            os.makedirs( self._logDir )
        index   = 0
        timeTag = time.strftime( "%Y.%m.%d" )
        while True:
            logFile = os.path.join(self._logDir,"{}-{}-{:02}.log".format(stem,timeTag,index))
            if not os.path.isfile(logFile):
                print( 'Report log: "{}"'.format(logFile) )
                break
            index += 1
        fd = open( logFile, "w" )
        self._logs[stem] = logFile
        self._fds [stem] = fd
        return

    def closeLogs ( self ):
        for fd in self._fds.values():
            if fd: fd.close()
        return

    def compressLogs ( self ):
        for log in self._logs.values():
            if not log: continue
            fd   = open( log, 'r' )
            bzfd = bz2.BZ2File( log+'.bz2', 'w' )
            for line in fd.readlines():
                if isinstance(line,str):
                  bzfd.write( line.encode('utf-8') )
                elif isinstance(line,bytes):
                  bzfd.write( line )
            bzfd.close()
            fd.close()
            os.unlink( log )
        return

    def getCommands ( self, target ):
        commands = []
        if self.doYosys:
            if not os.path.isfile( self.yosysBin ):
                raise ErrorMessage( 1, [ 'Cannot find <yosysInstaller.sh>, should be here:'
                                       , '   "{}"'.format(self.yosysBin)
                                       ] )
            commands.append( YosysCommand( self.yosysBin, fdLog=self.fds['yosys'] ) )
        if self.doAlliance:
            commands.append( AllianceCommand( self.srcDir, fdLog=self.fds['alliance'] ) )
        if self.doCoriolis:
            otherArgs = []
            if self.debugArg: otherArgs.append( self.debugArg )
            if target == 'EL9':
                commands.append( CoriolisCommand( self.srcDir, 3, fdLog=self.fds['coriolis'] ) )
            elif target == 'Ubuntu18' or target == 'Debian9' or target == 'Debian10':
                commands.append( CoriolisCommand( self.srcDir, 3, otherArgs, fdLog=self.fds['coriolis'] ) )
        pdkOtherArgs = []
        if self.nightlyMode:
            pdkOtherArgs.append( '--nightly' )
        if self.doPdkIHPsg13g2:
            commands.append( PdkIHPsg13g2Command( self.srcDir, 1, pdkOtherArgs, fdLog=self.fds['pdkIHPsg13g2'] ) )
        if self.doPdkIHPsg13g2c4m:
            commands.append( PdkIHPsg13g2c4mCommand( self.srcDir, 1, pdkOtherArgs, fdLog=self.fds['pdkIHPsg13g2c4m'] ) )
        if self.doPdkGF180mcu:
            commands.append( PdkGF180mcuCommand( self.srcDir, 1, pdkOtherArgs, fdLog=self.fds['pdkGF180mcu'] ) )
        if self.doPdkGF180mcuc4m:
            commands.append( PdkGF180mcuc4mCommand( self.srcDir, 1, pdkOtherArgs, fdLog=self.fds['pdkGF180mcuc4m'] ) )
        if self.doPdkSky130c4m:
            commands.append( PdkSky130c4mCommand( self.srcDir, 1, pdkOtherArgs, fdLog=self.fds['pdkSky130c4m'] ) )
        if self.doPdkNsx2:
            commands.append( PdkNsx2Command( self.srcDir, 1, pdkOtherArgs, fdLog=self.fds['pdkNsx2'] ) )
        if self.doBenchs:
            commands.append( BenchsCommand( self.benchsDir, fdLog=self.fds['benchs'] ) )
        if self.doPyBenchs:
            commands.append( PyBenchsCommand( self.benchsDir, fdLog=self.fds['benchs'] ) )
        return commands


class Report ( object ):

    def __init__ ( self, conf ):
        self.conf = conf
        commaspace = ', '
        date       = time.strftime( "%A %d %B %Y" )
        stateText  = 'FAILED'
        modeText   = 'SoC installation'
        if self.conf.success:     stateText = 'SUCCESS'
        if self.conf.nightlyMode: modeText  = 'Nightly build'
        self.message = MIMEMultipart()
        self.message['Subject'] = '[{}] Coriolis {} {}'.format(stateText,modeText,date)
        self.message['From'   ] = self.conf.sender
        self.message['To'     ] = commaspace.join( self.conf.receivers )
        self.attachements = []
        self.mainText  = '\n'
        self.mainText += 'Salut le Crevard,\n'
        self.mainText += '\n'
        if self.conf.nightlyMode:
            self.mainText += 'This is the nightly build report of Coriolis.\n'
        else:
            self.mainText += 'SoC installer report of Coriolis.\n'
        self.mainText += '{}\n'.format(date)
        self.mainText += '\n'
        if self.conf.success:
            self.mainText += 'Build was SUCCESSFUL\n'
        else:
            self.mainText += 'Build has FAILED, please have a look to the attached log file(s).\n'
        self.mainText += '\n'
        self.mainText += 'Complete log file(s) can be found here:\n'
        return

    def attachLog ( self, logFile ):
        if not logFile: return
        
        fd = open( logFile, 'rb' )
        try:
            fd.seek( -1024*100, os.SEEK_END )
        except IOError as e:
            pass
        tailLines = ''
        for line in fd.readlines()[1:]:
            tailLines += line.decode( 'latin_1' )
        fd.close()
        self.mainText += '    "{}"\n'.format(logFile)
        
        attachement = MIMEApplication(tailLines)
        attachement.add_header( 'Content-Disposition', 'attachment', filename=os.path.basename(logFile) )
        self.attachements.append( attachement )
        return

    def send ( self ):
        self.message.attach( MIMEText(self.mainText) )
        for attachement in self.attachements:
            self.message.attach( attachement )
        
        print( "Sending mail report to:" )
        for receiver in self.conf.receivers: print( '  <{}>'.format(receiver) )
        session = smtplib.SMTP( 'localhost' )
        session.sendmail( self.conf.sender, self.conf.receivers, self.message.as_string() )
        session.quit()
        return


# ------------------------------------------------------------------- 
# <socInstaller> Main Part.


parser = optparse.OptionParser ()  
parser.add_option ( "--debug"          , action="store_true",                dest="debug"            , help="Build a <Debug> aka (-g) version." )
parser.add_option ( "--no-git"         , action="store_true" ,               dest="noGit"            , help="Do not pull/update Git repositories before building." )
parser.add_option ( "--do-yosys"       , action="store_true",                dest="doYosys"          , help="Rebuild Yosys." )
parser.add_option ( "--do-alliance"    , action="store_true",                dest="doAlliance"       , help="Rebuild the Alliance tools." )
parser.add_option ( "--do-coriolis"    , action="store_true",                dest="doCoriolis"       , help="Rebuild the Coriolis tools." )
parser.add_option ( "--do-ihpsg13g2"   , action="store_true",                dest="doPdkIHPsg13g2"   , help="Rebuild the IHP SG13G2 PDK." )
parser.add_option ( "--do-ihpsg13g2c4m", action="store_true",                dest="doPdkIHPsg13g2c4m", help="Rebuild the IHP SG13G2 PDK, with C4M standard cells." )
parser.add_option ( "--do-gf180mcu"    , action="store_true",                dest="doPdkGF180mcu"    , help="Rebuild the GF 180 MCU PDK." )
parser.add_option ( "--do-gf180mcuc4m" , action="store_true",                dest="doPdkGF180mcuc4m" , help="Rebuild the GF 180 MCU PDK, with C4M standard cells." )
parser.add_option ( "--do-sky130c4m"   , action="store_true",                dest="doPdkSky130c4m"   , help="Rebuild the SkyWater 130A PDK, with C4M standard cells." )
parser.add_option ( "--do-nsx2"        , action="store_true",                dest="doPdkNsx2"        , help="Rebuild the Symbolic NSxLib 2 PDK." )
parser.add_option ( "--do-report"      , action="store_true",                dest="doReport"         , help="Send a final report." )
parser.add_option ( "--nightly"        , action="store_true",                dest="nightly"          , help="Perform a nighly build." )
parser.add_option ( "--docker"         , action="store_true",                dest="docker"           , help="Perform a build inside a docker container." )
parser.add_option ( "--chroot"         , action="store_true",                dest="chroot"           , help="Perform a build inside a chrooted environment." )
parser.add_option ( "--benchs"         , action="store_true",                dest="benchs"           , help="Run the <alliance-checker-toolkit> sanity benchs (make)." )
parser.add_option ( "--pybenchs"       , action="store_true",                dest="pybenchs"         , help="Run the <alliance-checker-toolkit> sanity benchs (doit)." )
parser.add_option ( "--rm-build"       , action="store_true",                dest="rmBuild"          , help="Remove the build/install directories." )
parser.add_option ( "--rm-source"      , action="store_true",                dest="rmSource"         , help="Remove the Git source repositories." )
parser.add_option ( "--rm-all"         , action="store_true",                dest="rmAll"            , help="Remove everything (source+build+install)." )
parser.add_option ( "--root"           , action="store"     , type="string", dest="rootDir"          , help="The root directory (default: <~/coriolis-2.x/>)." )
parser.add_option ( "--profile"        , action="store"     , type="string", dest="profile"          , help="The targeted OS for the build." )
(options, args) = parser.parse_args ()


conf = Configuration()

try:
    if options.debug:                     conf.debugArg          = '--debug' 
    if options.nightly:                   conf.nightlyMode       = True
    if options.docker:                    conf.dockerMode        = True
    if options.chroot:                    conf.chrootMode        = True
    if options.noGit:                     conf.doGit             = False
    if options.doYosys:                   conf.doYosys           = True
    if options.doAlliance:                conf.doAlliance        = True
    if options.doCoriolis:                conf.doCoriolis        = True
    if options.doPdkIHPsg13g2:            conf.doPdkIHPsg13g2    = True
    if options.doPdkIHPsg13g2c4m:         conf.doPdkIHPsg13g2c4m = True
    if options.doPdkGF180mcu:             conf.doPdkGF180mcu     = True
    if options.doPdkGF180mcuc4m:          conf.doPdkGF180mcuc4m  = True
    if options.doPdkSky130c4m:            conf.doPdkSky130c4m    = True
    if options.doPdkNsx2:                 conf.doPdkNsx2         = True
    if options.benchs:                    conf.doBenchs          = True
    if options.pybenchs:                  conf.doPyBenchs        = True
    if options.doReport:                  conf.doSendReport      = True
    if options.rmSource or options.rmAll: conf.rmSource          = True
    if options.rmBuild  or options.rmAll: conf.rmBuild           = True

    if conf.doYosys:           conf.openLog( 'yosys'           )
    if conf.doAlliance:        conf.openLog( 'alliance'        )
    if conf.doCoriolis:        conf.openLog( 'coriolis'        )
    if conf.doPdkIHPsg13g2:    conf.openLog( 'pdkIHPsg13g2'    )
    if conf.doPdkIHPsg13g2c4m: conf.openLog( 'pdkIHPsg13g2c4m' )
    if conf.doPdkGF180mcu:     conf.openLog( 'pdkGF180mcu'     )
    if conf.doPdkGF180mcuc4m:  conf.openLog( 'pdkGF180mcuc4m'  )
    if conf.doPdkSky130c4m:    conf.openLog( 'pdkSky130c4m'    )
    if conf.doPdkNsx2:         conf.openLog( 'pdkNsx2'         )
    if conf.doBenchs:          conf.openLog( 'benchs'          )
    if conf.doPyBenchs:        conf.openLog( 'benchs'          )
    if conf.dockerMode:        os.environ['USER'] = 'root'

    gitSupports = []
    for supportRepo in conf.supportRepos:
        gitSupports.append( GitRepository( supportRepo, conf.srcDir+'/support' ) )
    gitCoriolis = GitRepository( conf.coriolisRepo, conf.srcDir, conf.fds['coriolis'] )
    gitBenchs   = GitRepository( conf.benchsRepo  , conf.srcDir, conf.fds['coriolis'] )

    if conf.doAlliance:
        gitAlliance = GitRepository( conf.allianceRepo, conf.srcDir, conf.fds['alliance'] )

    if conf.doPdkIHPsg13g2:
        gitPdkIHPsg13g2 = GitRepository( conf.pdkIHPsg13g2Repo, conf.srcDir, conf.fds['pdkIHPsg13g2'] )

    if conf.doPdkIHPsg13g2c4m:
        gitPdkIHPsg13g2c4m = GitRepository( conf.pdkIHPsg13g2c4mRepo, conf.srcDir, conf.fds['pdkIHPsg13g2c4m'] )

    if conf.doPdkGF180mcu:
        gitPdkGF180mcu = GitRepository( conf.pdkGF180mcuRepo, conf.srcDir, conf.fds['pdkGF180mcu'] )

    if conf.doPdkGF180mcuc4m:
        gitPdkGF180mcuc4m = GitRepository( conf.pdkGF180mcuc4mRepo, conf.srcDir, conf.fds['pdkGF180mcuc4m'] )

    if conf.doPdkGF180mcuc4m:
        gitPdkSky130c4m = GitRepository( conf.pdkSky130c4mRepo, conf.srcDir, conf.fds['pdkSky130c4m'] )

    if conf.doPdkNsx2:
        gitPdkNsx2 = GitRepository( conf.pdkNsx2Repo, conf.srcDir, conf.fds['pdkNsx2'] )

    if conf.doGit:
        for gitSupport in gitSupports:
            if conf.rmSource: gitSupport.removeLocalRepo()
            if gitSupport.url.endswith('rapidjson.git'):
                continue
            gitSupport.clone()
            if gitSupport.url.endswith('rapidjson.git'):
              gitSupport.checkout( 'b1a4d91' )
        
        if conf.doAlliance:
            if conf.rmSource: gitAlliance.removeLocalRepo()
            gitAlliance.clone   ()
            gitAlliance.checkout( 'main' )
        
        if conf.doCoriolis:
            if conf.rmSource: gitCoriolis.removeLocalRepo()
            gitCoriolis.clone   ()
            gitCoriolis.checkout( 'main' )
            gitCoriolis.submoduleUpdate()
        
        if conf.doPdkIHPsg13g2:
            if conf.rmSource: gitPdkIHPsg13g2.removeLocalRepo()
            gitPdkIHPsg13g2.clone   ()
            gitPdkIHPsg13g2.checkout( 'main' )
            gitPdkIHPsg13g2.submoduleUpdate()
        
        if conf.doPdkIHPsg13g2c4m:
            if conf.rmSource: gitPdkIHPsg13g2c4m.removeLocalRepo()
            gitPdkIHPsg13g2c4m.clone   ()
            gitPdkIHPsg13g2c4m.checkout( 'main' )
        
        if conf.doPdkGF180mcu:
            if conf.rmSource: gitPdkGF180mcu.removeLocalRepo()
            gitPdkGF180mcu.clone   ()
            gitPdkGF180mcu.checkout( 'main' )
            gitPdkGF180mcu.submoduleUpdate()
        
        if conf.doPdkGF180mcuc4m:
            if conf.rmSource: gitPdkGF180mcuc4m.removeLocalRepo()
            gitPdkGF180mcuc4m.clone   ()
            gitPdkGF180mcuc4m.checkout( 'main' )
        
        if conf.doPdkSky130c4m:
            if conf.rmSource: gitPdkSky130c4m.removeLocalRepo()
            gitPdkSky130c4m.clone   ()
            gitPdkSky130c4m.checkout( 'main' )
        
        if conf.doPdkNsx2:
            if conf.rmSource: gitPdkNsx2.removeLocalRepo()
            gitPdkNsx2.clone   ()
            gitPdkNsx2.checkout( 'main' )
      
        if conf.rmSource: gitBenchs.removeLocalRepo()
        gitBenchs.clone()
        gitBenchs.checkout( 'main' )

    if conf.rmBuild:
        for entry in os.listdir(conf.rootDir):
            if entry.startswith('Linux.') or entry == "release":
                buildDir = conf.rootDir+'/'+entry
                print( 'Removing OS build directory: "{}"'.format(buildDir) )
                shutil.rmtree( buildDir )

    commands = conf.getCommands( options.profile )
    for command in commands:
        if command.host:
            print( 'Executing command on remote host "{}":'.format(host) )
        else:
            print( 'Executing command on *local* host:' )
        print( '  {}'.format(command) )
        command.execute()

    conf.closeLogs()
    conf.success = True

except ErrorMessage as e:
    print( e )
    conf.closeLogs()
    conf.success = False
    
    if showTrace:
        print( '\nPython stack trace:' )
        traceback.print_tb( sys.exc_info()[2] )
    conf.rcode = e.code

if conf.doSendReport:
    report = Report( conf )
    report.attachLog( conf.logs['coriolis' ] )
    report.attachLog( conf.logs['benchs'   ] )
    report.send()

conf.compressLogs()

sys.exit( conf.rcode )
