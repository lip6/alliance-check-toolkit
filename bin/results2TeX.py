#!/usr/bin/env python3
#
# -*- Mode: Python -*-

import sys
import os
import os.path
import string
import re
import subprocess
import optparse


def texEscape ( s ):
    return s.replace( "_", "\\_" )


class Fig2Dev ( object ):
    reFontLine     = re.compile ( r"^4 .*" )
    USE_LATEX_FONT = "0"
    LATEX_BOLD     = "4"

    def __init__ ( self, resultsDir ):
        self._resultsDir = resultsDir
        return

    def toEepic ( self, graphName ):
        print( "Translating %s to eepic..." % graphName )
        origFigFile = self._resultsDir+'/'+graphName+'.fig'
        copyFigFile = self._resultsDir+'/'+graphName+'.copy.fig'
        eepicFile   = self._resultsDir+'/'+graphName+'.eepic'

        origFigFd   = open( origFigFile, 'r' )
        copyFigFd   = open( copyFigFile, 'w' )

        if not origFigFd or not copyFigFd: return
        while 1:
            line = origFigFd.readline()
            if line == '': break
        
            m = Fig2Dev.reFontLine.match( line )
            if m != None:
                fields    = line.split()
                fields[5] = Fig2Dev.LATEX_BOLD
                fields[8] = Fig2Dev.USE_LATEX_FONT
                fields[6] = '11.000'
                if fields[13][:6] == 'TITLE':
                    fields[ 6] = '12.000'
                    fields[13] = ''
                line = ' '.join( fields ) + '\n'
            copyFigFd.write( line )
        origFigFd.close()
        copyFigFd.close()

        fig2dev = subprocess.Popen( ["fig2dev"
                                    , "-L"
                                    , "eepic"
                                   #, "-s"
                                   #, "8"
                                    , "-F"
                                    , copyFigFile
                                    , eepicFile ] )
        os.waitpid( fig2dev.pid, 0 )
        return


class Gnuplot ( object ):
    LineStyle      = 0x0001
    GatesXTics     = 0x0002
    SegmentsXTics  = 0x0004
    TimeYTics      = 0x0008
    TimeLogYTics   = 0x0010
    MemoryLogYTics = 0x0020
    PercentYTics   = 0x0040
    
    _scripts = { LineStyle     :[ "set style data linespoints"
                                , "set style line 1 linewidth 1"
                                , "set style line 2 linewidth 2 linetype 1 pointtype 4"
                                , "set style line 3 linewidth 2 linetype 3 pointtype 12"
                                , "set xtics font \"Helvetica Bold,8\""
                                , "set ytics font \"Helvetica Bold,8\""
                                , "unset x2tics"
                                , "unset y2tics"
                                , "set format x \"%2.0s%c\""
                                , "set mxtics 2"
                                , "set grid"
                                , "set grid linestyle 1" ]
               , GatesXTics    :[ "set mxtics   10"
                                , "set logscale x"
                                , "set format   x \"%2.0s%c\""
                                , "set xlabel   \"gates\""
                                ]
               , SegmentsXTics :[ "set mxtics   10"
                                , "set logscale x"
                                , "set format   x \"%2.0s%c\""
                                ]
               , TimeYTics     :[ "set mytics   5"
                                , "set format   y \"%.1s%c\"" ]
               , TimeLogYTics  :[ "set mytics   10"
                                , "set logscale y"
                                , "set format   y \"%2.0s%c\"" ]
               , MemoryLogYTics:[ "set mytics   10"
                                , "set logscale y"
                                , "set format   y \"%2.0s%c\"" ]
               , PercentYTics  :[ "set yrange [0.05:0.35]"
                                , "set ytics  0.05"
                                , "set mytics 5" ]
               }

    def __init__ ( self, resultsDir ):
        self._resultsDir = resultsDir
        return

    def run ( self, graphName, scriptFlags, mainScript ):
        print( "Running Gnuplot for %s" % graphName )
        outputFig = self._resultsDir + '/' + graphName + ".fig"
        script  = []
       #script += [ 'set output "%s"' % outputFig ]
        if scriptFlags & Gnuplot.LineStyle:      script += Gnuplot._scripts[Gnuplot.LineStyle]
        if scriptFlags & Gnuplot.GatesXTics:     script += Gnuplot._scripts[Gnuplot.GatesXTics]
        if scriptFlags & Gnuplot.SegmentsXTics:  script += Gnuplot._scripts[Gnuplot.SegmentsXTics]
        if scriptFlags & Gnuplot.TimeYTics:      script += Gnuplot._scripts[Gnuplot.TimeYTics]
        if scriptFlags & Gnuplot.TimeLogYTics:   script += Gnuplot._scripts[Gnuplot.TimeLogYTics]
        if scriptFlags & Gnuplot.MemoryLogYTics: script += Gnuplot._scripts[Gnuplot.MemoryLogYTics]
        if scriptFlags & Gnuplot.PercentYTics:   script += Gnuplot._scripts[Gnuplot.PercentYTics]
        script += mainScript
        script += [ "quit" ]
        gnuplot = subprocess.Popen( ["gnuplot"]
                                  , stdin =subprocess.PIPE
                                  , stdout=subprocess.PIPE
                                  , bufsize=0
                                  )
        for line in script:
            gnuplot.stdin.write( (line + "\n").encode() )
        print( "Writing Fig %s" % outputFig )
        fd = open( outputFig, "w" )
        for line in gnuplot.stdout.readlines():
            fd.write( line.decode() )
        fd.close()
        return


class DataEntry ( object ):

    def __init__ ( self ):
        self.design              = "noname"
        self.gates               = 0
        self.gcells              = 0
        self.loadTime            = 0
        self.loadSize            = 0
       #self.knikTime            = 0
       #self.knikSize            = 0
        self.HovE                = 0
        self.VovE                = 0
       #self.globalWL            = 0
       #self.area                = 0
       #self.saturation          = 0
        self.globalSegments      = 0
        self.edges               = 0
        self.katanaAssignTime    = 0
        self.katanaRunTime       = 0
        self.katanaSize          = 0
        self.katanaFinalizeTime  = 0
        self.katanaSegments      = 0
        self.katanaDetailedWL    = 0
        self.katanaFailedWL      = 0
        self.katanaWLexpandRatio = 0
        self.katanaEvents        = 0
        self.katanaUniqueEvents  = 0
        return

    def readFromLine ( self, line, lineno ):
        fields = line.split()
        if len(fields) == 21:
            self.design              = "noname"
            self.gates               = int(  fields[ 0])
            self.gcells              = int(  fields[ 1])
            self.placeTime           = float(fields[ 2])
            self.area                = float(fields[ 3])
            self.saturation          = float(fields[ 4])
            self.loadTime            = float(fields[ 5])
            self.loadSize            = int(  fields[ 6])
           #self.knikTime            = float(fields[ X])
           #self.knikSize            = int(  fields[ X])
            self.HovE                = int(  fields[ 7])
            self.VovE                = int(  fields[ 8])
           #self.globalWL            = int(  fields[ X])
           #self.area                = float(fields[ X])
           #self.saturation          = float(fields[ X])
            self.globalSegments      = int(  fields[ 9])
            self.edges               = int(  fields[10])
            self.katanaAssignTime    = float(fields[11])
            self.katanaRunTime       = float(fields[12])
            self.katanaSize          = float(fields[13])/1024
            self.katanaFinalizeTime  = float(fields[14])
            self.katanaSegments      = int(  fields[15])
            self.katanaDetailedWL    = int(  fields[16])
            self.katanaFailedWL      = int(  fields[17])
            self.katanaWLexpandRatio = float(fields[18])
            self.katanaEvents        = int(  fields[19])
            self.katanaUniqueEvents  = int(  fields[20])
            return True

        print( '[WARNING] Malformed data line at %d, doesn\'t have 21 fields (%d,ignoring):' \
               % (lineno,len(fields)) )
        print( '          %s' % line )
        return False


class Results2TeX ( object ):
    ISCAS89pattern       = re.compile( r"^s\d+$" )
    ICCAD04pattern       = re.compile( r"^ibm.+$" )

    def __init__ ( self, resultsDir ):
        self._resultsDir   = resultsDir
        self._primaryDatas = { "SoC":[], "ISCAS89":[], "ICCAD04":[] }
        self._fig2dev      = Fig2Dev( resultsDir )
        self._gnuplot      = Gnuplot( resultsDir )
        return

    @staticmethod
    def _isISCAS89 ( designName ):
        if Results2TeX.ISCAS89pattern.match(designName): return True
        return False

    @staticmethod
    def _isICCAD04 ( designName ):
        if Results2TeX.ICCAD04pattern.match(designName): return True
        return False

    def readPrimaryDatas ( self, primaryDatasFile ):
        print( "Reading primary datas from <%s>..." % primaryDatasFile )
        fd = open( self._resultsDir+'/'+primaryDatasFile, "r" )

        designName = "unnamed"
        if fd != None:
            lineno = 0
            while 1:
                lineno += 1
                line = fd.readline()
                if line == "": break
                data = line.split()
                if data[0] == '#':
                    if len(data) == 2:
                        designName = data[1]
                        if designName.endswith("_flat"):
                            designName = designName[:-5]
                        if designName.endswith("export_p70"):
                            designName = designName[:-10]
                    continue

                benchmark = "SoC"
                if Results2TeX._isISCAS89(designName): benchmark = "ISCAS89"
                if Results2TeX._isICCAD04(designName): benchmark = "ICCAD04"

                entry = DataEntry()
                if entry.readFromLine(line,lineno):
                    entry.design = designName
                    self._primaryDatas[benchmark].append( entry )
                designName = "unnamed"
            fd.close ()
        return

    def writeDataTabular ( self, primaryDatasName ):
        print( "Writing %s.tex" % primaryDatasName )

        fd = open( self._resultsDir+'/'+primaryDatasName+".tex", "w" )
        if fd != None:
            fd.write( ' \\newcommand{\\resultsdir}{%s}\n' % self._resultsDir )
            fd.write( ' \\newcommand{\\timedatas}{\n' )
            fd.write( ' \\ttfamily\n' )
            fd.write( ' \\begin{tabular}{|r|r|r|r|r|r|r|r|r|r|}\n' )
            fd.write( '   \\hline\n' )
            fd.write( '   design & \#gates & LoadT & LoadS & AssignT & AlgoT & AlgoS & FinT & \#segments & \#events \\\\\n' )
            fd.write( '          &         & (s)   & (Mb)  & (s)     & (s)   & (Mb)  & (s)  &            &          \\\\\n' )
            for benchmark in self._primaryDatas.keys():
                datas =  self._primaryDatas[benchmark]
                if not datas: continue

                fd.write( "   \\hline\\hline\n" )
                fd.write( "   \\multicolumn{10}{|c|}{\\textsf{\\textbf{%s benchmark}}} \\\\\n" % benchmark )
                fd.write( "   \\hline\n" )
                for data in datas:
                    fd.write( "   %-30s& %5.2f & %7.2f & %5i & %7.2f & %7.2f & %5i & %7.2f & %6i & %6i \\\\\n" \
                              % ( "\\texttt{%s}" % texEscape(data.design)
                                , data.gates
                                , data.loadTime
                                , data.loadSize
                                , data.katanaAssignTime
                                , data.katanaRunTime
                                , int(data.katanaSize * 1024)
                                , data.katanaFinalizeTime
                                , data.katanaSegments
                                , data.katanaEvents
                                )
                            )
            fd.write( "   \\hline\n" )
            fd.write( " \\end{tabular}\n" )
            fd.write( " }\n" )

            fd.write( ' \\newcommand{\\statsdatas}{\n' )
            fd.write( ' \\ttfamily\n' )
            fd.write( ' \\begin{tabular}{|r|r|r|r|r|r|r|r|r|}\n' )
            fd.write( '   \\hline\n' )
            fd.write( '   design & \#gates & \#gcells & PlaceT & \\#globals & \\#segments & Detailed  & \\#events & \\#unique \\\\\n' )
            fd.write( '          &         &          &        &           &            & WL         &          & events   \\\\\n' )
            for benchmark in self._primaryDatas.keys():
                datas =  self._primaryDatas[benchmark]
                if not datas: continue

                fd.write( "   \\hline\\hline\n" )
                fd.write( "   \\multicolumn{8}{|c|}{\\textsf{\\textbf{%s benchmark}}} \\\\\n" % benchmark )
                fd.write( "   \\hline\n" )
                for data in self._primaryDatas[benchmark]:
                    fd.write( "   %-30s& %7i & %9i & %9i & %7i & %7i & %9i+%i & %7i & %7i \\\\\n" \
                              % ( "\\texttt{%s}" % texEscape(data.design)
                                , data.gates
                                , data.gcells
                                , data.placeTime
                                , data.globalSegments
                                , data.katanaSegments
                                , data.katanaDetailedWL
                                , data.katanaFailedWL
                                , data.katanaEvents
                                , data.katanaUniqueEvents
                                )
                            )
            fd.write( "   \\hline\n" )
            fd.write( " \\end{tabular}\n" )
            fd.write( " }\n" )
            fd.close()
        return

    def writeSaturation ( self ):
        graphName = "katana-saturation"
    
        dataFiles = {}
        for benchmark in self._primaryDatas.keys():
            datas = self._primaryDatas[benchmark]
            if not datas: continue

            dataFiles[benchmark] = "%s/%s.%s.dat" %  (self._resultsDir,benchmark,graphName)
            print( "Writing %s" % dataFiles[benchmark] )
            fd = open ( dataFiles[benchmark], "w" )
            for data in datas:
                fd.write( "%-10s %s\n" % (data.gates,data.saturation) )
            fd.close ()
    
        script = [ "set style data linespoints"
                 , "set style line 1 linewidth 1"
                 , "set style line 2 linewidth 2 linetype 1 pointtype 4"
                 , "set style line 3 linewidth 2 linetype 3 pointtype 12"
                 , "set xtics font \"Helvetica Bold,11\""
                 , "set ytics font \"Helvetica Bold,11\""
                 , "set grid"
                 , "set grid linestyle 1"
                # X axis configuration.
                 , "unset x2tics"
                 , "set format x \"%2.0s%c\""
                 , "set mxtics   2"
                 , "set mxtics   10"
                 , "set logscale x"
                 , "set format   x \"%2.0s%c\""
                #, "set xrange   [1e+3:4e+5]"
                #, "set xlabel   \"#gates\" offset 0,0.5"
                # Y axis configuration.
                 , "unset y2tics"
                 , "set yrange   [0.05:0.35]"
                 , "set ytics    0.05"
                 , "set mytics   5"
                # Figure size configuration.
                 , "set terminal fig size 5.0 5.0"
                 , "set size square"
                # Plots.
                #, "set key inside top left"
                 , 'set title \"TITLE Design Saturation (\%s) vs. gates\"'
                 , 'plot \"%s\" linestyle 2 notitle' % (dataFiles["SoC"])
                 ]
        self._gnuplot.run( graphName, 0, script )
        self._fig2dev.toEepic( graphName )
        return

    def writeAllTimes ( self ):
        graphName = "katana-alltimes"
    
        dataFiles = {}
        for benchmark in self._primaryDatas.keys():
            datas = self._primaryDatas[benchmark]
            if not datas: continue

            dataFiles[benchmark] = "%s/%s.%s.dat" %  (self._resultsDir,benchmark,graphName)
            print( "Writing %s" % dataFiles[benchmark] )
            fd = open ( dataFiles[benchmark], "w" )
            for data in datas: fd.write( '%-10s %10s\n' % (data.gates,data.loadTime) )
            fd.write( '\n\n' )
           #for data in datas: fd.write( '%-10s %10s\n' % (data.gates,data.katanaLoadTime) )
           #fd.write( '\n\n' )
            for data in datas: fd.write( '%-10s %10s\n' % (data.gates,data.katanaAssignTime) )
            fd.write( '\n\n' )
            for data in datas: fd.write( '%-10s %10s\n' % (data.gates,data.katanaRunTime) )
            fd.write( '\n\n' )
            for data in datas: fd.write( '%-10s %10s\n' % (data.gates,data.katanaFinalizeTime) )
            fd.close ()
    
        script = [ "set style data linespoints"
                 , "set style line 1 linewidth 1"
                 , "set style line 2 linewidth 2 linetype 1 pointtype 4"
                 , "set style line 3 linewidth 2 linetype 3 pointtype 12"
                 , "set xtics font \"Helvetica Bold,11\""
                 , "set ytics font \"Helvetica Bold,11\""
                 , "set grid"
                 , "set grid linestyle 1"
                # X axis configuration.
                 , "unset x2tics"
                 , "set mxtics   2"
                 , "set mxtics   10"
                 , "set logscale x"
                 , "set format   x \"%2.0s%c\""
                 , "set xrange   [1e+4:1e+8]"
                #, "set xlabel   \"#gates\" offset 0,0.5"
                # Y axis configuration.
                 , "unset y2tics"
                 , 'set logscale y'
                 , "set mytics   10"
                 , "set format   \"%2.0s%c\""
                 , "set yrange   [1e-1:1e+3]"
                # Figure size configuration.
                 , "set terminal fig size 4.5 4.5"
                 , "set size square"
                # Plots.
                 , "set key inside top left"
                 , 'set title \"TITLE Runtimes (s) vs. gates\"'
                 , 'plot \"%s\" index 0 linewidth 6 linetype 1 pointtype  9 title "Load"'     % (dataFiles["SoC"])
                #+    ', \"%s\" index 1 linewidth 2 linetype 2 pointtype  8 title "Load"'     % (dataFiles["SoC"])
                 +    ', \"%s\" index 1 linewidth 2 linetype 2 pointtype  4 title "Assign"'   % (dataFiles["SoC"])
                 +    ', \"%s\" index 2 linewidth 6 linetype 1 pointtype  5 title "Algo"'     % (dataFiles["SoC"])
                 +    ', \"%s\" index 3 linewidth 2 linetype 2 pointtype 10 title "Finalize"' % (dataFiles["SoC"])
                 ]
        self._gnuplot.run( graphName, 0, script )
        self._fig2dev.toEepic( graphName )
        return

    def writePlaceTimes ( self ):
        graphName = "katana-placetimes"
    
        dataFiles = {}
        for benchmark in self._primaryDatas.keys():
            datas = self._primaryDatas[benchmark]
            if not datas: continue

            dataFiles[benchmark] = "%s/%s.%s.dat" %  (self._resultsDir,benchmark,graphName)
            print( "Writing %s" % dataFiles[benchmark] )
            fd = open ( dataFiles[benchmark], "w" )
            for data in datas: fd.write( '%-10s %10s\n' % (data.gates,data.placeTime) )
            fd.close ()
    
        script = [ "set style data linespoints"
                 , "set style line 1 linewidth 1"
                 , "set xtics font \"Helvetica Bold,11\""
                 , "set ytics font \"Helvetica Bold,11\""
                 , "set grid"
                 , "set grid linestyle 1"
                # X axis configuration.
                 , "unset x2tics"
                 , "set mxtics   2"
                 , "set mxtics   10"
                 , "set logscale x"
                 , "set format   x \"%2.0s%c\""
                 , "set xrange   [1e+4:1e+8]"
                #, "set xlabel   \"#gates\" offset 0,0.5"
                # Y axis configuration.
                 , "unset y2tics"
                 , 'set logscale y'
                 , "set mytics   10"
                 , "set format   \"%2.0s%c\""
                 , "set yrange   [1e+1:1e+5]"
                # Figure size configuration.
                 , "set terminal fig size 4.5 4.5"
                 , "set size square"
                # Plots.
                 , "set key inside top left"
                 , 'set title \"TITLE Runtimes (s) vs. gates\"'
                 , 'plot \"%s\" index 0 linewidth 6 linetype 1 pointtype  9 title "Place"' % (dataFiles["SoC"])
                 ]
        self._gnuplot.run( graphName, 0, script )
        self._fig2dev.toEepic( graphName )
        return

    def writeMemoryVsGates ( self ):
        graphName = "katana-memory-vs-gates"
    
        dataFiles = {}
        for benchmark in self._primaryDatas.keys():
            datas = self._primaryDatas[benchmark]
            if not datas: continue

            dataFiles[benchmark] = "%s/%s.%s.dat" %  (self._resultsDir,benchmark,graphName)
            print( "Writing %s" % dataFiles[benchmark] )
            fd = open ( dataFiles[benchmark], "w" )
            for data in datas:
                fd.write( "%-10f %.12f\n" % (data.gates,data.katanaSize) )
            fd.close ()
    
        script = [ "set style data linespoints"
                 , "set style line 1 linewidth 2 linetype 1 pointtype 4"
                 , "set style line 2 linewidth 1 linetype 2 pointtype 4"
                 , "set xtics font \"Helvetica Bold,11\""
                 , "set ytics font \"Helvetica Bold,11\""
                 , "set grid"
                 , "set grid linestyle 2"
                # X axis configuration.
                 , "unset x2tics"
                 , "set mxtics   2"
                 , "set mxtics   10"
                 , "set logscale x"
                 , "set format   x \"%2.0s%c\""
                 , "set xrange   [1e+4:1e+6]"
                # Y axis configuration.
                 , "set logscale y"
                 , "set mytics   5"
                 , "set format   y \"%.0s%c\""
                 , "set yrange   [1e-1:1e+1]"
                # Figure size configuration.
                 , "set terminal fig size 4.0 4.0"
                 , "set size square"
                # Plots.
                #, "set key inside top left"
                 , 'set title \"TITLE Katana Memory (Gb) vs. gates\"'
                 , 'plot \"%s\" linestyle 1 notitle' % (dataFiles["SoC"])
                 ]
        self._gnuplot.run( graphName, 0, script )
        self._fig2dev.toEepic( graphName )
        return

    def writeMemoryGatesVsGates ( self ):
        graphName = "katana-memorygates-vs-gates"
    
        dataFiles = {}
        for benchmark in self._primaryDatas.keys():
            datas = self._primaryDatas[benchmark]
            if not datas: continue

            dataFiles[benchmark] = "%s/%s.%s.dat" %  (self._resultsDir,benchmark,graphName)
            print( "Writing %s" % dataFiles[benchmark] )
            fd = open ( dataFiles[benchmark], "w" )
            for data in datas:
                fd.write( "%-10f %.12f\n" % (data.gates,(data.katanaSize*(2**30))/float(data.gates)) )
            fd.close ()
    
        script = [ "set style data linespoints"
                 , "set style line 1 linewidth 2 linetype 1 pointtype 4"
                 , "set style line 2 linewidth 1 linetype 2 pointtype 4"
                 , "set xtics font \"Helvetica Bold,11\""
                 , "set ytics font \"Helvetica Bold,11\""
                 , "set grid"
                 , "set grid linestyle 2"
                # X axis configuration.
                 , "unset x2tics"
                 , "set mxtics   2"
                 , "set mxtics   10"
                 , "set logscale x"
                 , "set format   x \"%2.0s%c\""
                # Y axis configuration.
                 , "set logscale y"
                 , "set mytics   5"
                 , "set format   y \"%.0s%c\""
                # Figure size configuration.
                 , "set terminal fig size 4.0 4.0"
                 , "set size square"
                # Plots.
                #, "set key inside top left"
                 , 'set title \"TITLE Katana Memory (b/gates) vs. gates\"'
                 , 'plot \"%s\" linestyle 1 notitle' % (dataFiles["SoC"])
                 ]
        self._gnuplot.run( graphName, 0, script )
        self._fig2dev.toEepic( graphName )
        return

    def writeAssignTime ( self ):
        graphName = "katana-assigntime"
    
        dataFiles = {}
        for benchmark in self._primaryDatas.keys():
            datas = self._primaryDatas[benchmark]
            if not datas: continue

            dataFiles[benchmark] = "%s/%s.%s.dat" %  (self._resultsDir,benchmark,graphName)
            print( "Writing %s" % dataFiles[benchmark] )
            fd = open ( dataFiles[benchmark], "w" )
            for data in datas: fd.write( '%-10s %10s\n' % (data.gates,data.katanaAssignTime) )
            fd.write( '\n\n' )
            for data in datas: fd.write( '%-10s %10s\n' % (data.gates,data.katanaRunTime) )
            fd.close ()
    
        script = [ "set style data linespoints"
                 , "set style line 1 linewidth 1"
                 , "set style line 2 linewidth 2 linetype 1 pointtype 4"
                 , "set style line 3 linewidth 2 linetype 3 pointtype 12"
                 , "set xtics font \"Helvetica Bold,11\""
                 , "set ytics font \"Helvetica Bold,11\""
                 , "set grid"
                 , "set grid linestyle 1"
                # X axis configuration.
                 , "unset x2tics"
                 , "set mxtics   2"
                 , "set mxtics   10"
                 , "set logscale x"
                 , "set format   x \"%2.0s%c\""
                #, "set xrange   [1e+3:4e+5]"
                #, "set xlabel   \"#gates\" offset 0,0.5"
                # Y axis configuration.
                 , "unset y2tics"
                 , 'set logscale y'
                 , "set mytics   10"
                 , "set format   \"%2.0s%c\""
                # Figure size configuration.
                 , "set terminal fig size 5.0 5.0"
                 , "set size square"
                # Plots.
                 , "set key inside top left"
                 , 'set title \"TITLE Runtimes (s) vs. gates\"'
                 , 'plot \"%s\" index 0 linewidth 2 linetype 2 pointtype  4 title "Assign"'   % (dataFiles["SoC"])
                 +    ', \"%s\" index 1 linewidth 6 linetype 1 pointtype  5 title "Algo"'     % (dataFiles["SoC"])
                 ]
        self._gnuplot.run( graphName, 0, script )
        self._fig2dev.toEepic( graphName )
        return

    def writeSpeedAreaVsSat ( self ):
        graphName = "katana-speedarea-vs-sat"
    
        dataFiles = {}
        for benchmark in self._primaryDatas.keys():
            datas = self._primaryDatas[benchmark]
            if not datas: continue

            dataFiles[benchmark] = "%s/%s.%s.dat" %  (self._resultsDir,benchmark,graphName)
            print( "Writing %s" % dataFiles[benchmark] )
            fd = open ( dataFiles[benchmark], "w" )
            for data in datas:
                fd.write( "%-10f %.12f\n" % (data.saturation,(data.katanaRunTime/data.area)) )
            fd.close ()
    
        script = [ "set style data points"
                 , "set style line 1 linewidth 2 linetype 1 pointtype 4"
                 , "set style line 2 linewidth 1 linetype 2 pointtype 4"
                 , "set xtics font \"Helvetica Bold,11\""
                 , "set ytics font \"Helvetica Bold,11\""
                 , "set grid"
                 , "set grid linestyle 2"
                # X axis configuration.
                 , "set format   x \"%.2f\""
                # Y axis configuration.
                 , "set mytics   2"
                 , "set format   y \"%.0s%c\""
                # Figure size configuration.
                 , "set terminal fig"
                # Plots.
                #, "set key inside top left"
                 , 'set title \"TITLE Katana Speed (s/area) vs. saturation\"'
                 , 'plot \"%s\" linestyle 1 notitle' % (dataFiles["SoC"])
                 ]
        self._gnuplot.run( graphName, 0, script )
        self._fig2dev.toEepic( graphName )
        return

    def writeSpeedGatesSatVsGates ( self ):
        graphName = "katana-speedgatessat-vs-gates"
    
        dataFiles = {}
        for benchmark in self._primaryDatas.keys():
            datas = self._primaryDatas[benchmark]
            if not datas: continue

            dataFiles[benchmark] = "%s/%s.%s.dat" %  (self._resultsDir,benchmark,graphName)
            print( "Writing %s" % dataFiles[benchmark] )
            fd = open ( dataFiles[benchmark], "w" )
            for data in datas:
                fd.write( "%-10f %.12f\n" % (data.gates,(data.katanaRunTime/(data.gates*data.saturation))) )
            fd.close ()
    
        script = [ "set style data linespoints"
                 , "set style line 1 linewidth 2 linetype 1 pointtype 4"
                 , "set style line 2 linewidth 1 linetype 2 pointtype 4"
                 , "set xtics font \"Helvetica Bold,11\""
                 , "set ytics font \"Helvetica Bold,11\""
                 , "set grid"
                 , "set grid linestyle 2"
                # X axis configuration.
                 , "unset x2tics"
                 , "set mxtics   2"
                 , "set mxtics   10"
                 , "set logscale x"
                 , "set format   x \"%2.0s%c\""
                # Y axis configuration.
                 , "set mytics   5"
                 , "set format   y \"%.0s%c\""
                # Figure size configuration.
                 , "set terminal fig"
                # Plots.
                #, "set key inside top left"
                 , 'set title \"TITLE Katana Speed (s/gates*sat) vs. gates\"'
                 , 'plot \"%s\" linestyle 1 notitle' % (dataFiles["SoC"])
                 ]
        self._gnuplot.run( graphName, 0, script )
        self._fig2dev.toEepic( graphName )
        return

    def writeSpeedGatesVsGates ( self ):
        graphName = "katana-speedgates-vs-gates"
    
        dataFiles = {}
        for benchmark in self._primaryDatas.keys():
            datas = self._primaryDatas[benchmark]
            if not datas: continue

            dataFiles[benchmark] = "%s/%s.%s.dat" %  (self._resultsDir,benchmark,graphName)
            print( "Writing %s" % dataFiles[benchmark] )
            fd = open ( dataFiles[benchmark], "w" )
            for data in datas:
                fd.write( "%-10f %.12f\n" % (data.gates,(data.katanaRunTime/data.gates)) )
            fd.close ()
    
        script = [ "set style data linespoints"
                 , "set style line 1 linewidth 2 linetype 1 pointtype 4"
                 , "set style line 2 linewidth 1 linetype 2 pointtype 4"
                 , "set xtics font \"Helvetica Bold,11\""
                 , "set ytics font \"Helvetica Bold,11\""
                 , "set grid"
                 , "set grid linestyle 2"
                # X axis configuration.
                 , "unset x2tics"
                 , "set mxtics   2"
                 , "set mxtics   10"
                 , "set logscale x"
                 , "set format   x \"%2.0s%c\""
                # Y axis configuration.
                 , "set mytics   5"
                 , "set format   y \"%.1s%c\""
                # Figure size configuration.
                 , "set terminal fig"
                # Plots.
                #, "set key inside top left"
                 , 'set title \"TITLE Katana Speed (s/gates) vs. gates\"'
                 , 'plot \"%s\" linestyle 1 notitle' % (dataFiles["SoC"])
                 ]
        self._gnuplot.run( graphName, 0, script )
        self._fig2dev.toEepic( graphName )
        return

    def writeSpeedSegmentsVsGates ( self ):
        graphName = "katana-speedsegments-vs-gates"
    
        dataFiles = {}
        for benchmark in self._primaryDatas.keys():
            datas = self._primaryDatas[benchmark]
            if not datas: continue

            dataFiles[benchmark] = "%s/%s.%s.dat" %  (self._resultsDir,benchmark,graphName)
            print( "Writing %s" % dataFiles[benchmark] )
            fd = open ( dataFiles[benchmark], "w" )
            for data in datas:
                fd.write( "%-10f %.12f\n" % (data.gates,(data.katanaRunTime/data.katanaSegments)) )
            fd.close ()
    
        script = [ "set style data linespoints"
                 , "set style line 1 linewidth 2 linetype 1 pointtype 4"
                 , "set style line 2 linewidth 1 linetype 2 pointtype 4"
                 , "set xtics font \"Helvetica Bold,11\""
                 , "set ytics font \"Helvetica Bold,11\""
                 , "set grid"
                 , "set grid linestyle 2"
                # X axis configuration.
                 , "unset x2tics"
                 , "set mxtics   2"
                 , "set mxtics   10"
                 , "set logscale x"
                 , "set format   x \"%2.0s%c\""
                # Y axis configuration.
                 , "set mytics   5"
                 , "set format   y \"%.0s%c\""
                # Figure size configuration.
                 , "set terminal fig"
                # Plots.
                #, "set key inside top left"
                 , 'set title \"TITLE Katana Speed (s/segments) vs. gates\"'
                 , 'plot \"%s\" linestyle 1 notitle' % (dataFiles["SoC"])
                 ]
        self._gnuplot.run( graphName, 0, script )
        self._fig2dev.toEepic( graphName )
        return

   #def writeKatanaRuntime ( self ):
   #    graphName = "katana-runtime"
   #
   #    dataFiles = {}
   #    for benchmark in self._primaryDatas.keys():
   #        dataFiles[benchmark] = "%s.%s.dat" %  (benchmark,graphName)
   #        print( "Writing %s" % dataFiles[benchmark] )
   #        fd = open ( dataFiles[benchmark], "w" )
   #        for data in self._primaryDatas[benchmark]:
   #            fd.write ( "%-10s %s\n" % (data[Results2TeX.GatesNb]
   #                                      ,data[Results2TeX.KatanaAlgoTime]) )
   #        fd.close ()
   #
   #    script = [ "set style data linespoints"
   #             , "set style line 1 linewidth 1"
   #             , "set style line 2 linewidth 2 linetype 1 pointtype 4"
   #             , "set style line 3 linewidth 1 linetype 1 pointtype 5"
   #             , "set xtics font \"Helvetica Bold,8\""
   #             , "set ytics font \"Helvetica Bold,8\""
   #             , "set grid"
   #             , "set grid linestyle 1"
   #            # X axis configuration.
   #             , "unset x2tics"
   #             , "set format x \"%2.0s%c\""
   #             , "set mxtics   2"
   #             , "set mxtics   10"
   #             , "set logscale x"
   #             , "set format   x \"%2.0s%c\""
   #             , "set xrange   [1e+3:4e+5]"
   #             , "set xlabel   \"#gates\" offset 0,0.5"
   #            # Y axis configuration.
   #             , "unset y2tics"
   #             , "set mytics   10"
   #             , "set logscale y"
   #             , "set format   y \"%2.0s%c\"" 
   #             , "set yrange   [10:4e+3]"
   #             , "set ylabel   \"seconds\" offset 0.5,0 rotate by 90"
   #            # Figure size configuration.
   #             , "set terminal fig size 3.0 3.0"
   #             , "set size square"
   #            #, "plot \"./%s\" linestyle 3 notitle" % dataFiles["ICCAD04"]
   #            #+ ", \"ICCAD04.encounter-runtime.dat\" linestyle 2 notitle"
   #             , "set key inside top left"
   #             , "plot \"./%s\" linestyle 2 title \"SoC\"" % dataFiles["SoC"]
   #             + ", \"%s\" linestyle 3 title \"ISCAS89\""  % dataFiles["ISCAS89"]
   #             + ", \"%s\" linestyle 3 title \"ICCAD04\""  % dataFiles["ICCAD04"]
   #            #+ ", \"ICCAD04.encounter-runtime.dat\" linestyle 3 notitle"
   #             ]
   #    Gnuplot().run ( graphName, 0, script )
   #    Fig2Dev().toEepic ( graphName )
   #    return
    
   #def writeKatanaMemory ( self ):
   #    graphName = "katana-memory"
   #
   #    dataFiles = {}
   #    for benchmark in self._primaryDatas.keys():
   #        dataFiles[benchmark] = "%s.%s.dat" %  (benchmark,graphName)
   #        print( "Writing %s" % dataFiles[benchmark] )
   #        fd = open ( dataFiles[benchmark], "w" )
   #        for data in self._primaryDatas[benchmark]:
   #            fd.write ( "%-10s %s\n" % (data[Results2TeX.GatesNb]
   #                                      ,data[Results2TeX.KatanaAlgoSize]) )
   #        fd.close ()
   #
   #    script = [ "set style data linespoints"
   #             , "set style line 1 linewidth 1"
   #             , "set style line 2 linewidth 2 linetype 1 pointtype 4"
   #             , "set style line 3 linewidth 1 linetype 1 pointtype 5"
   #             , "set xtics font \"Helvetica Bold,8\""
   #             , "set ytics font \"Helvetica Bold,8\""
   #             , "set grid"
   #             , "set grid linestyle 1"
   #            # X axis configuration.
   #             , "unset x2tics"
   #             , "set format x \"%2.0s%c\""
   #             , "set mxtics   2"
   #             , "set mxtics   10"
   #             , "set logscale x"
   #             , "set format   x \"%2.0s%c\""
   #             , "set xrange   [1e+3:200e+3]"
   #             , "set xlabel   \"#gates\" offset 0,0.5"
   #            # Y axis configuration.
   #             , "set mytics   10"
   #             , "set logscale y"
   #             , "set format   y \"%2.0s%c\"" 
   #             , "set yrange   [20:1000]"
   #             , "set ylabel   \"memory (MB)\" offset 0.5,0 rotate by 90"
   #            # Figure size configuration.
   #             , "set terminal fig size 3.0 2.5"
   #             , "set key inside top left"
   #             , "plot \"./%s\" linestyle 2 title \"SoC\"" % dataFiles["SoC"]
   #             + ", \"%s\" linestyle 3 title \"ISCAS89\"" % dataFiles["ISCAS89"]
   #             + ", \"%s\" linestyle 3 title \"ICCAD04\"" % dataFiles["ICCAD04"]
   #             ]
   #    Gnuplot().run ( graphName, 0, script )
   #    Fig2Dev().toEepic ( graphName )
   #    return
   #
   #def writeKatanaRuntimeVsSat ( self ):
   #    graphName = "katana-runtime-vs-sat"
   #
   #    dataFiles = {}
   #    for benchmark in self._primaryDatas.keys():
   #        dataFiles[benchmark] = "%s.%s.dat" %  (benchmark,graphName)
   #        print( "Writing %s" % dataFiles[benchmark] )
   #        fd = open ( dataFiles[benchmark], "w" )
   #        for data in self._primaryDatas[benchmark]:
   #            fd.write ( "%-10s %f\n" % (data[Results2TeX.Saturation]
   #                                      , float(data[Results2TeX.KatanaAlgoTime])
   #                                       /float(data[Results2TeX.GatesNb]) ) )
   #        fd.close ()
   #
   #    script = [ "set terminal fig size 3.45 2"
   #             , "set format y \"%.0s%c\""
   #             , "set yrange [0:50e-3]"
   #             , "set ytics 10e-3"
   #             , "set mytics 5"
   #             , "set format x \"%.2f\""
   #             , "set xtics 0.05"
   #             , "set mxtics 5"
   #             , "set grid"
   #             , "set grid linestyle 1"
   #             , "f(x) = a*x + b"
   #             , "fit f(x) \"./%s\" using 1:2 via a,b" % dataFiles["SoC"]
   #             , "plot [x=0.10:0.40] f(x) notitle linewidth 2,"
   #             + " \"./%s\" notitle with points linewidth 2 pointtype 4," % dataFiles["SoC"]
   #             + " \"./%s\" notitle with points linewidth 1 pointtype 5," % dataFiles["ISCAS89"]
   #             + " \"./%s\" notitle with points linewidth 2 pointtype 5"  % dataFiles["ICCAD04"]
   #             ]
   #    Gnuplot().run ( graphName, 0, script )
   #    Fig2Dev().toEepic ( graphName )
   #    return


if __name__ == "__main__":

    parser = optparse.OptionParser() 
    parser.add_option("--results-dir", dest="resultsDir", help="The directory of the results.")
    (options, args) = parser.parse_args (sys.argv[1:])

    if options.resultsDir:
        results2TeX = Results2TeX( options.resultsDir )
        results2TeX.readPrimaryDatas         ( "katana.dat" )
        results2TeX.writeDataTabular         ( "datas" )
       #results2TeX.writeSaturation          ()
        results2TeX.writeAllTimes            ()
        results2TeX.writePlaceTimes          ()
       #results2TeX.writeAssignTime          ()
       #results2TeX.writeSpeedAreaVsSat      ()
       #results2TeX.writeSpeedGatesSatVsGates()
       #results2TeX.writeSpeedGatesVsGates   ()
       #results2TeX.writeSpeedSegmentsVsGates()
        results2TeX.writeMemoryVsGates       ()
        results2TeX.writeMemoryGatesVsGates  ()

    sys.exit ( 0 )
