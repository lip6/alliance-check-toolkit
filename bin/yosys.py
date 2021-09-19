#!/usr/bin/env python3

import sys
import os
import os.path
import subprocess
import optparse
from   helpers.io import ErrorMessage
from   helpers.io import catch


class Yosys ( object ):

    ReadRTLIL   = 0x0001
    ReadVerilog = 0x0002
    Flatten     = 0x0004
    KeepTcl     = 0x0008
    ReadMask    = ReadRTLIL | ReadVerilog

    def __init__ ( self ):
        self.flags       = Yosys.ReadRTLIL
        self.libertyFile = None
        self.blocks      = []
        self.blackboxes  = []
        return

    def setFlags ( self, mask, value ):
        if value: self.flags |=  mask
        else:     self.flags &= ~mask
        return

    def setFlatten ( self, blocks ):
        self.setFlags( Yosys.Flatten, True )
        self.blocks = blocks

    def setKeepTcl ( self, value ):
        self.setFlags( Yosys.KeepTcl, True )

    def setLiberty ( self, libertyFile ):
        if not os.path.isfile(libertyFile):
            raise ErrorMessage( 1, [ 'Yosys.setLiberty(): Can\'t find liberty file.'
                                   , '"{}"'.format(libertyFile) ] )
        self.libertyFile = libertyFile
        return

    def setBlackboxes ( self, blackboxes ):
        for blackbox in blackboxes:
            if blackbox is None: continue
            blackboxFile = None
            for extension in [ '.v' ]:
                blackboxFile = blackbox + extension
                if os.path.isfile(blackboxFile): break
            if blackboxFile is None:
                raise ErrorMessage( 1, [ 'Yosys.setBlackboxes(): Can\'t find blackbox file.'
                                       , '"{}{{.v}}"'.format(blackbox) ] )
            else:
                self.blackboxes.append( blackboxFile )
        return

    def setInputRTLIL ( self ):
        self.setFlags( Yosys.ReadMask , False )
        self.setFlags( Yosys.ReadRTLIL, True  )
        return

    def setInputVerilog ( self ):
        self.setFlags( Yosys.ReadMask   , False )
        self.setFlags( Yosys.ReadVerilog, True  )
        return

    def run ( self, designName, top='top' ):
        tclScript = ''
        for blackbox in self.blackboxes:
            if blackbox.endswith('.v'):
                tclScript += 'yosys read_verilog {}\n'.format(blackbox)
        if self.flags & Yosys.ReadRTLIL:
            if not os.path.isfile(designName+'.il'):
                raise ErrorMessage( 1, 'Yosys.run(): Can\'t find RTLIL design file "{}.il".' \
                                       .format(designName) )
            tclScript += 'yosys read_ilang   {designName}.il\n'
        else:
            if not os.path.isfile(designName+".v"):
                raise ErrorMessage( 1, 'Yosys.run(): Can\'t find Verilog design file "{}.v".' \
                                       .format(designName) )
            tclScript += 'yosys read_verilog {designName}.v\n'
        tclScript += 'yosys hierarchy -check -top {designTop}\n' \
                     'yosys synth            -top {designTop}\n'
        blocks = ''
        if self.flags & Yosys.Flatten:
            tclScript += 'yosys flatten               {blocks}\n'    \
                         'yosys hierarchy        -top {designTop}\n'
            for block in self.blocks:
                if len(blocks) > 0: blocks += ' '
                blocks += block
        tclScript += 'yosys memory\n'                              \
                     'yosys dfflibmap -liberty    {libertyFile}\n' \
                     'yosys abc       -liberty    {libertyFile}\n' \
                     'yosys clean\n'                               \
                     'yosys write_blif {designName}.blif\n'
        tclFile = designName + '.tcl'
        with open( tclFile, 'w' ) as tclFd:
            keywords = { 'designName' : designName
                       , 'designTop'  : top
                       , 'blocks'     : blocks
                       , 'libertyFile': self.libertyFile
                       }
            tclFd.write( tclScript.format( **keywords ))
        status = subprocess.call( [ 'yosys', '-c', tclFile ] )
        if not (self.flags & Yosys.KeepTcl): os.unlink( tclFile )
        return status


if __name__ == '__main__':

    parser = optparse.OptionParser()
    parser.add_option ( '-d', '--design'    , action='store'     , type='string', dest='design'    , help='The name of the design file, without extension.' )
    parser.add_option ( '-t', '--top'       , action='store'     , type='string', dest='top'       
                                                                                , default='top'    , help='The hierarchy top level name model.' )
    parser.add_option ( '-f', '--flatten'                        , type='string', dest='flatten'   , help='Flatten the design hierarchy.' )
    parser.add_option ( '-k', '--keep-tcl'  , action='store_true',                dest='keepTcl'   , help='Keep the Yosys TCL command script.' )
    parser.add_option ( '-i', '--input-lang', action='store'     , type='string', dest='inputLang' , help='Set the input description language (RTLIL or Verilog).' )
    parser.add_option ( '-l', '--liberty'   , action='store'     , type='string', dest='liberty'   , help='Set the path to the liberty file (.lib).' )
    parser.add_option ( '-b', '--blackboxes',                      type='string', dest='blackboxes', help='A comma separated list of black boxes.' )
    (options, args) = parser.parse_args()

    try:
        flatten = None
        if options.flatten:
            flatten = options.flatten.split(',')
        blackboxes = None
        if options.blackboxes:
            blackboxes = options.blackboxes.split(',')
        yosys = Yosys()
        if options.inputLang == 'Verilog': yosys.setInputVerilog()
        if options.inputLang == 'RTLIL'  : yosys.setInputRTLIL()
        if flatten:                        yosys.setFlatten( flatten )
        if options.keepTcl: yosys.setKeepTcl( True )
        if options.liberty: yosys.setLiberty( options.liberty )
        if blackboxes:      yosys.setBlackboxes( blackboxes )
        rcode = yosys.run( options.design, top=options.top )
    except Exception as e:
        catch( e )
        sys.exit(2)
    
    sys.exit( rcode )
