#!/usr/bin/python
#
# This file is part of the Chams-Designs Software.
# Copyright (c) UPMC 2016-2018, All Rights Reserved
#
# +------------------------------------------------------------------+ 
# |             C H A M S   D E S I G N S                            |
# |      A Collection of Analogic Designs Examples                   | 
# |                                                                  |
# |  Author      :               Marie-Minerve Louerat               |
# |  E-mail      :            Jean-Paul.Chaput@lip6.fr               |
# | ===============================================================  |
# |  Python      :  "./layout/gmdecod.py"                            |
# |                                                                  |
# |  Design      : Design of a digitally controlled transconductance |
# |                                                                  |
# +------------------------------------------------------------------+
#
# Slicing Tree Structure:
#
# -----------------------------------------------------------------------------
# |       |           |       |                   |       |           |       |
# | m5ap  |  m6ap_bp  |  m5bp |        m13        | m5bn  |  m6an_bn  |  m5an |
# |       |           |       |                   |       |           |       |
# |---------------------------|-------------------|---------------------------|
# |      |      |      |      |         |         |      |      |      |      |
# | m7ap | m8ap | m8bp | m7bp |  m11ap  |  m11an  | m7bn | m8bn | m8an | m7an |
# |      |      |      |      |         |         |      |      |      |      |
# |---------------------------|-------------------|---------------------------|
# |             |             |                   |             |             |
# |             |             |     m12ap_an      |             |             |
# |     m4ap    |    m4bp     |                   |     m4bn    |    m4an     |
# |             |             |-------------------|             |             |
# |---------------------------|                   |---------------------------|
# |                           |      m9ap_an      |                           |
# |                           |                   |                           |
# |          m3ap_bp          |-------------------|          m3an_bn          |
# |                           |         |         |                           |
# |                           |   m2p   |   m2n   |                           |
# |---------------------------|         |         |---------------------------|
# |                           |-------------------|                           |
# |                           |                   |                           |
# |           m10ap           |      m1ap_an      |           m10an           |
# |                           |                   |                           |
# -----------------------------------------------------------------------------


from   Hurricane import *
# Needed to import a digital block.
import CRL
import helpers

# Ensure that all the configuration is properly loaded
# before we do anything.
helpers.staticInitialization( quiet=False )
#helpers.setTraceLevel( 100 )
#helpers.setTraceLevel( 110 )

from   Analog import *
from   Bora   import *
from   karakaze.AnalogDesign import AnalogDesign


NMOS    = Transistor.NMOS
PMOS    = Transistor.PMOS
Center  = SlicingNode.AlignCenter
Left    = SlicingNode.AlignLeft
Right   = SlicingNode.AlignRight
Top     = SlicingNode.AlignTop
Bottom  = SlicingNode.AlignBottom
Unknown = SlicingNode.AlignBottom
VNode   = 1
HNode   = 2
DNode   = 3


def loadDecoder ():
    framework = CRL.AllianceFramework.get()
    decoder   = framework.getCell( 'decoder2_o', CRL.Catalog.State.Views )
    return decoder


class GmDecodDigCtl ( AnalogDesign ):

    def __init__ ( self ):
        AnalogDesign.__init__( self )
        return


    def build ( self, editor ):
        print '  o  Running GmDecodDigCtl.build().'
        decoderModel = loadDecoder()
        
       #    | 0                  | 1         | 2               | 3   | 4       |  5  | 6| 7   |8  |9     |10  | 11    | 12   | 13   | 
       #    | Class              | Instance  | Layout Style    | Type| W       |  L  | M| Mint|Dum|SFirst|Bulk| BulkC | NERC | NIRC | 
       #    +====================+===========+=================+=====+=========+=====+==+=====+===+======+====+=======+======+======+
        self.devicesSpecs = \
          [ [ Transistor         , 'm10ap'   , 'WIP Transistor', NMOS, 21.44   , 3.00, 4, None,  0, True , 0xf, True  ]
          , [ DifferentialPair   , 'm3ap_bp' , 'WIP DP'        , NMOS, 10.56   , 3.00, 4,    2,  1, True , 0xf, True  ]
          , [ Transistor         , 'm4ap'    , 'WIP Transistor', PMOS, 39.76   , 3.00, 4, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm4bp'    , 'WIP Transistor', PMOS, 39.76   , 3.00, 4, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm5ap'    , 'WIP Transistor', PMOS, 12.92   , 1.00, 4, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm5bp'    , 'WIP Transistor', PMOS, 12.92   , 1.00, 4, None,  0, True , 0xf, True  ]
          , [ CommonSourcePair   , 'm6ap_bp' , 'WIP CSP'       , PMOS, 50.40   , 1.00, 4,    2,  1, True , 0xf, True  ]
          , [ Transistor         , 'm7ap'    , 'WIP Transistor', PMOS, 12.92   , 1.00, 4, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm7bp'    , 'WIP Transistor', PMOS, 12.92   , 1.00, 4, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm8ap'    , 'WIP Transistor', PMOS, 12.73   , 1.00, 4, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm8bp'    , 'WIP Transistor', PMOS, 12.73   , 1.00, 4, None,  0, True , 0xf, True  ]
          , [ DifferentialPair   , 'm11an'   , 'WIP DP'        , NMOS,  8.57328, 1.00, 4,    2,  1, True , 0xf, False ]
          , [ DifferentialPair   , 'm11ap'   , 'WIP DP'        , NMOS,  8.57328, 1.00, 4,    2,  1, True , 0xf, False ]
          , [ DifferentialPair   , 'm12ap_an', 'WIP DP'        , NMOS,  2.94359, 1.00, 4,    2,  1, True , 0xf, True  ]
          , [ Transistor         , 'm13'     , 'WIP Transistor', PMOS,  9.95588, 1.00, 4, None,  0, True , 0xf, True  ]
          , [ DifferentialPair   , 'm1ap_an' , 'WIP DP'        , NMOS,  3.445  , 3.00, 4,    2,  1, True , 0xf, True  ]
          , [ Transistor         , 'm2p'     , 'WIP Transistor', NMOS, 50.44   , 1.00, 4, None,  0, True , 0x1, False ]
          , [ Transistor         , 'm2n'     , 'WIP Transistor', NMOS, 50.44   , 1.00, 4, None,  0, True , 0x1, False ]
          , [ CommonSourcePair   , 'm9ap_an' , 'WIP CSP'       , PMOS,145.46   , 1.00, 4,    2,  1, True , 0xf, True  ]
          , [ Transistor         , 'm10an'   , 'WIP Transistor', NMOS, 21.44   , 3.00, 4, None,  0, True , 0xf, True  ]
          , [ DifferentialPair   , 'm3an_bn' , 'WIP DP'        , NMOS, 10.56   , 3.00, 4,    2,  1, True , 0xf, True  ]
          , [ Transistor         , 'm4an'    , 'WIP Transistor', PMOS, 39.76   , 3.00, 4, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm4bn'    , 'WIP Transistor', PMOS, 39.76   , 3.00, 4, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm5an'    , 'WIP Transistor', PMOS, 12.92   , 1.00, 4, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm5bn'    , 'WIP Transistor', PMOS, 12.92   , 1.00, 4, None,  0, True , 0xf, True  ]
          , [ CommonSourcePair   , 'm6an_bn' , 'WIP CSP'       , PMOS, 50.40   , 1.00, 4,    2,  1, True , 0xf, True  ]
          , [ Transistor         , 'm7an'    , 'WIP Transistor', PMOS, 12.92   , 1.00, 4, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm7bn'    , 'WIP Transistor', PMOS, 12.92   , 1.00, 4, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm8an'    , 'WIP Transistor', PMOS, 12.73   , 1.00, 4, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm8bn'    , 'WIP Transistor', PMOS, 12.73   , 1.00, 4, None,  0, True , 0xf, True  ]
          # transistors for digital control of biasing VC
          , [ Transistor         , 'm4bpbias', 'WIP Transistor', PMOS, 12.00   , 1.00, 4, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm4bnbias', 'WIP Transistor', PMOS, 12.00   , 1.00, 4, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm4bpb0'  , 'WIP Transistor', PMOS,  1.50   , 1.00, 1, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm4bpb1'  , 'WIP Transistor', PMOS,  1.50   , 1.00, 1, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm4bpb2'  , 'WIP Transistor', PMOS,  1.50   , 1.00, 1, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm4bpb3'  , 'WIP Transistor', PMOS,  1.50   , 1.00, 1, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm4bpb4'  , 'WIP Transistor', PMOS,  1.50   , 1.00, 1, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm4bpb5'  , 'WIP Transistor', PMOS,  1.50   , 1.00, 1, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm4bpb6'  , 'WIP Transistor', PMOS,  1.50   , 1.00, 1, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm4bpb7'  , 'WIP Transistor', PMOS,  1.50   , 1.00, 1, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm4bnb0'  , 'WIP Transistor', PMOS,  1.50   , 1.00, 1, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm4bnb1'  , 'WIP Transistor', PMOS,  1.50   , 1.00, 1, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm4bnb2'  , 'WIP Transistor', PMOS,  1.50   , 1.00, 1, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm4bnb3'  , 'WIP Transistor', PMOS,  1.50   , 1.00, 1, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm4bnb4'  , 'WIP Transistor', PMOS,  1.50   , 1.00, 1, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm4bnb5'  , 'WIP Transistor', PMOS,  1.50   , 1.00, 1, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm4bnb6'  , 'WIP Transistor', PMOS,  1.50   , 1.00, 1, None,  0, True , 0xf, True  ]
          , [ Transistor         , 'm4bnb7'  , 'WIP Transistor', PMOS,  1.50   , 1.00, 1, None,  0, True , 0xf, True  ]
          , [ decoderModel       , 'decoder' ]
          ]

        self.netTypes = \
          { 'vin+'  : { 'isExternal':True }
          , 'vin-'  : { 'isExternal':True }
          , 'vout+' : { 'isExternal':True }
          , 'vout-' : { 'isExternal':True }
         #, 'vout1+': { 'isExternal':True }
         #, 'vout1-': { 'isExternal':True }
         #, 'vout2+': { 'isExternal':True }
         #, 'vout2-': { 'isExternal':True }
         #, 'vout3+': { 'isExternal':True }
         #, 'vout3-': { 'isExternal':True }
          , 'vout4+': { 'isExternal':True }
          , 'vout4-': { 'isExternal':True }
          , 'vref'  : { 'isExternal':True }
         # vc becomes internal and has 2 signals vcp and vcn
          , 'vcn'   : { 'isExternal':False}
          , 'vcp'   : { 'isExternal':False}
          , 'vb5'   : { 'isExternal':True }
          , 'vb7'   : { 'isExternal':True }
          , 'vb10an': { 'isExternal':True }
          , 'vb10ap': { 'isExternal':True }
          , 'vb12an': { 'isExternal':True }
          , 'vb12ap': { 'isExternal':True }
          , 'vb13'  : { 'isExternal':True }
          , 'vdd'   : { 'isExternal':True }
          , 'vss'   : { 'isExternal':True }
         # gate voltage of transistors for digital control of biasing VC
          , 'vc1'   : { 'isExternal':False}
          , 'vc2'   : { 'isExternal':False}
          , 'vc3'   : { 'isExternal':False}
          , 'vc4'   : { 'isExternal':False}
          , 'vc5'   : { 'isExternal':False}
          , 'vc6'   : { 'isExternal':False}
          , 'vc7'   : { 'isExternal':False}
          }

        self.netSpecs = \
          { 'vin+'   : [ ('m1ap_an' , 'G1') ]
          , 'vin-'   : [ ('m1ap_an' , 'G2'), ]
          , 'vout+'  : [ ('m2n'     , 'D' ), ('m9ap_an', 'D2'), ('m11ap'  , 'G1')  ]
          , 'vout-'  : [ ('m2p'     , 'D' ), ('m9ap_an', 'D1'), ('m11an'  , 'G2') ]
          # CMC.
          , 'cmc_1'  : [ ('m11ap'   , 'S'), ('m12ap_an', 'D1') ]
          , 'cmc_1'  : [ ('m11an'   , 'S'), ('m12ap_an', 'D2') ]
          # AmpLin N.
          , 'ampn_1' : [ ('m6an_bn' , 'D1'), ('m8an'   , 'S' ) ]
          , 'ampn_2' : [ ('m6an_bn' , 'D2'), ('m8bn'   , 'S' ) ]
          , 'ampn_4' : [ ('m3an_bn' , 'D2'), ('m6an_bn', 'G' ), ('m8bn'   , 'D' ) ]
          , 'ampn_61': [ ('m10an'   , 'D' ), ('m3an_bn', 'S' ) ]
          , 'ampn_62': [ ('m5an'    , 'D' ), ('m7an'   , 'S' ) ]
          , 'ampn_63': [ ('m5bn'    , 'D' ), ('m7bn'   , 'S' ) ]
          , 'ampn_71': [ ('m3an_bn' , 'G1'), ('m4an'   , 'S' ), ('m7an'   , 'D' ) ]
          , 'ampn_72': [ ('m3an_bn' , 'G2'), ('m4bn'   , 'S' ), ('m7bn'   , 'D' ) ]
          # AmpLin P.
          , 'ampp_1' : [ ('m6ap_bp' , 'D1'), ('m8ap'   , 'S' ) ]
          , 'ampp_2' : [ ('m6ap_bp' , 'D2'), ('m8bp'   , 'S' ) ]
          , 'ampp_4' : [ ('m3ap_bp' , 'D2'), ('m6ap_bp', 'G' ), ('m8bp'   , 'D' ) ]
          , 'ampp_61': [ ('m10ap'   , 'D' ), ('m3ap_bp', 'S' ) ]
          , 'ampp_62': [ ('m5ap'    , 'D' ), ('m7ap'   , 'S' ) ]
          , 'ampp_63': [ ('m5bp'    , 'D' ), ('m7bp'   , 'S' ) ]
          , 'ampp_71': [ ('m3ap_bp' , 'G1'), ('m4ap'   , 'S' ), ('m7ap'   , 'D' ) ]
          , 'ampp_73': [ ('m3ap_bp' , 'G2'), ('m4bp'   , 'S' ), ('m7bp'   , 'D' ) ]
          # Interface of internal signals to whole design.
          , 'vcmfb'  : [ ('m11an'   , 'D1'), ('m11ap'   , 'D2'), ('m13'     , 'D' ), ('m9ap_an' , 'G' ) ]
          , 'm2n_in' : [ ('m2n'     , 'G' ), ('m3an_bn' , 'D1'), ('m8an'    , 'D' ) ]
          , 'm2p_in' : [ ('m2p'     , 'G' ), ('m3ap_bp' , 'D1'), ('m8ap'    , 'D' ) ]
         #, 'm4ap_in': [ {'W': '2'} ,('m4ap'    , 'G' ), ('m1ap_an' , 'D1'), ('m2p'     , 'S' ) ]
         #, 'm4an_in': [ {'W': '2'} ,('m4an'    , 'G' ), ('m1ap_an' , 'D2'), ('m2n'     , 'S' ) ]
          , 'm4ap_in': [ ('m4ap'    , 'G' ), ('m1ap_an' , 'D1'), ('m2p'     , 'S' ) ]
          , 'm4an_in': [ ('m4an'    , 'G' ), ('m1ap_an' , 'D2'), ('m2n'     , 'S' ) ]
          # Blocks external polarization.
          , 'vref'   : [ ('m11an'   , 'G1'), ('m11ap'   , 'G2') ]
          # vc becomes internal with vcp and vcn 
          , 'vcp'    : [ ('m4bp'    , 'G' ), ('m4bpbias', 'G' ), ('m4bpbias', 'S' ), ('m4bpb0'  , 'G' ) 
                       , ('m4bpb0'  , 'D' ), ('m4bpb1'  , 'D' ), ('m4bpb2'  , 'D' ), ('m4bpb3'  , 'D' ), ('m4bpb4'  , 'D' ),('m4bpb5'  , 'D' ),('m4bpb6'  , 'D' ),('m4bpb7'  , 'D' )]
          , 'vcn'    : [ ('m4bn'    , 'G' ), ('m4bnbias', 'G' ), ('m4bnbias', 'S' ), ('m4bnb0'  , 'G' ) 
                       , ('m4bnb0'  , 'D' ), ('m4bnb1'  , 'D' ), ('m4bnb2'  , 'D' ), ('m4bnb3'  , 'D' ), ('m4bnb4'  , 'D' ),('m4bnb5'  , 'D' ),('m4bnb6'  , 'D' ),('m4bnb7'  , 'D' )]
         #, 'vb5'    : [ {'W': '2'}, ('m5an'    , 'G' ), ('m5bn'    , 'G' ), ('m5ap'    , 'G' ), ('m5bp'    , 'G' ) ]
          , 'vb5'    : [ ('m5an'    , 'G' ), ('m5bn'    , 'G' ), ('m5ap'    , 'G' ), ('m5bp'    , 'G' ) ]
          , 'vb7'    : [ ('m7an'    , 'G' ), ('m7bn'    , 'G' ), ('m8an'    , 'G' ), ('m8bn'    , 'G' )
                       , ('m7ap'    , 'G' ), ('m7bp'    , 'G' ), ('m8ap'    , 'G' ), ('m8bp'    , 'G' ) ]
          , 'vb10an' : [ ('m10an'   , 'G' ), ]
          , 'vb10ap' : [ ('m10ap'   , 'G' ), ]
          , 'vb12an' : [ ('m12ap_an', 'G2'), ]
          , 'vb12ap' : [ ('m12ap_an', 'G1'), ]
          , 'vb13'   : [ ('m13'     , 'G' ), ]
          , 'vdd'    : [ ('m9ap_an' , 'S' ), ('m11an'    , 'D2'), ('m11ap'    , 'D1'), ('m13'     , 'S' )
                       , ('m5an'    , 'S' ), ('m5bn'     , 'S' ), ('m6an_bn'  , 'S' ), ('m5ap'    , 'S' )
                       , ('m5bp'    , 'S' ), ('m6ap_bp'  , 'S' ) 
                       , ('m4bpb0'  , 'S' ), ('m4bpb1'   , 'S' ), ('m4bpb2'   , 'S' ), ('m4bpb3'  , 'S' ), ('m4bpb4'  , 'S' ),('m4bpb5'  , 'S' ),('m4bpb6'  , 'S' ),('m4bpb7'  , 'S' )
                       , ('m4bnb0'  , 'S' ), ('m4bnb1'   , 'S' ), ('m4bnb2'   , 'S' ), ('m4bnb3'  , 'S' ), ('m4bnb4'  , 'S' ),('m4bnb5'  , 'S' ),('m4bnb6'  , 'S' ),('m4bnb7'  , 'S' )]
          , 'vss'    : [ ('m1ap_an' , 'S' ), ('m2p'      , 'B' ), ('m2n'      , 'B' ), ('m11an'    , 'B' )
                       , ('m11ap'   , 'B' ), ('m12ap_an' , 'S' ), ('m10an'    , 'S' ), ('m4an'     , 'D' )
                       , ('m4bn'    , 'D' ), ('m10ap'    , 'S' ), ('m4ap'     , 'D' ), ('m4bp'     , 'D' )
                       , ('m4bpbias', 'D' ), ('m4bnbias', 'D' ) ] 
          # Transistors for digital control of biasing VC
          , 'vc1'    : [ ('m4bpb1'  , 'G' ), ('m4bnb1'   , 'G' ), ('decoder', 'vc(1)' ) ]
          , 'vc2'    : [ ('m4bpb2'  , 'G' ), ('m4bnb2'   , 'G' ), ('decoder', 'vc(2)' ) ]
          , 'vc3'    : [ ('m4bpb3'  , 'G' ), ('m4bnb3'   , 'G' ), ('decoder', 'vc(3)' ) ]
          , 'vc4'    : [ ('m4bpb4'  , 'G' ), ('m4bnb4'   , 'G' ), ('decoder', 'vc(4)' ) ]
          , 'vc5'    : [ ('m4bpb5'  , 'G' ), ('m4bnb5'   , 'G' ), ('decoder', 'vc(5)' ) ]
          , 'vc6'    : [ ('m4bpb6'  , 'G' ), ('m4bnb6'   , 'G' ), ('decoder', 'vc(6)' ) ]
          , 'vc7'    : [ ('m4bpb7'  , 'G' ), ('m4bnb7'   , 'G' ), ('decoder', 'vc(7)' ) ]
          # Encoded command.
          , 'cmd0' : [ ('decoder', 'command(0)' ) ]
          , 'cmd1' : [ ('decoder', 'command(1)' ) ]
          , 'cmd2' : [ ('decoder', 'command(2)' ) ]
          }

        self.beginCell( 'gmdecod' )
        self.doDevices()
        self.doNets   ()
    
        self.beginSlicingTree()
        self.setToleranceRatioH( 1000000000.0 )
        self.setToleranceRatioW( 1000000000.0 )
        self.setToleranceBandH ( 1000000000.0 )
        self.setToleranceBandW ( 1000000000.0 )

        self.pushHNode( Center )
        self.addHRail( self.getNet('vss'), 'METAL4', 2, "CH1", "IH1" )

        self.pushVNode( Center )
        #self.addSymmetry( 0, 2 )

        self.addSymmetryNet( VNode, self.getNet('vb5') )
        self.addSymmetryNet( VNode, self.getNet('vb7') )
       # self.addSymmetryNet( VNode, self.getNet('vc1') )
       # self.addSymmetryNet( VNode, self.getNet('vc2') )
       # self.addSymmetryNet( VNode, self.getNet('vc3') )
       # self.addSymmetryNet( VNode, self.getNet('vc4') )
       # self.addSymmetryNet( VNode, self.getNet('vc5') )
       # self.addSymmetryNet( VNode, self.getNet('vc6') )
       # self.addSymmetryNet( VNode, self.getNet('vc7') )
        self.addSymmetryNet( VNode, self.getNet('vcp'), self.getNet('vcn') )
       #fait planter 
       # self.addSymmetryNet( VNode, self.getNet('vout+'), self.getNet('vout-') )
        self.addSymmetryNet( VNode, self.getNet('ampp_73'), self.getNet('ampn_72') )
        self.addSymmetryNet( VNode, self.getNet('ampp_71'), self.getNet('ampn_71') )
        self.addSymmetryNet( VNode, self.getNet('ampp_61'), self.getNet('ampn_61') )
        self.addSymmetryNet( VNode, self.getNet('ampp_63'), self.getNet('ampn_63') )
        self.addSymmetryNet( VNode, self.getNet('ampp_4' ), self.getNet('ampn_4' ) )
        self.addSymmetryNet( VNode, self.getNet('ampp_2' ), self.getNet('ampn_2' ) )
        self.addSymmetryNet( VNode, self.getNet('ampp_1' ), self.getNet('ampn_1' ) )
        self.addSymmetryNet( VNode, self.getNet('m2p_in' ), self.getNet('m2n_in' ) )
       
        self.addVRail( self.getNet('vdd'), 'METAL3', 2, "CV1", "CV1" )
        # Ampli P.
        self.pushHNode( Center )
        self.addDevice( 'm10ap'   , Center, StepParameterRange(4, 2, 2) )
        self.addDevice( 'm3ap_bp' , Center, StepParameterRange(2, 2, 2) )
        self.pushVNode( Center )
       #self.addSymmetry( 0, 1 )
        self.addDevice( 'm4bp'    , Center, StepParameterRange(4, 2, 2) )
        self.addDevice( 'm4ap'    , Center, StepParameterRange(4, 2, 2) )
        self.addSymmetry( 0, 1 )
        self.popNode()
        self.pushVNode( Center )
       #self.addSymmetry( 0, 3 )
       #self.addSymmetry( 1, 2 )
        self.addDevice( 'm7ap'    , Center, StepParameterRange(4, 2, 2) )
        self.addDevice( 'm8ap'    , Center, StepParameterRange(4, 2, 2) )
        self.addDevice( 'm8bp'    , Center, StepParameterRange(4, 2, 2) )
        self.addDevice( 'm7bp'    , Center, StepParameterRange(4, 2, 2) )
        self.addSymmetry( 0, 3 )
        self.addSymmetry( 1, 2 )
        self.popNode()
        self.pushVNode( Center )
       #self.addSymmetry( 0, 2 )
        self.addDevice( 'm5ap'    , Center, StepParameterRange(4, 2, 2) )
        self.addDevice( 'm6ap_bp' , Center, StepParameterRange(4, 2, 2) )
        self.addDevice( 'm5bp'    , Center, StepParameterRange(4, 2, 2) )
        self.addSymmetry( 0, 2 )
        self.popNode()
       # Digitally controlled biasing
        self.pushVNode( Center )
        self.addDevice( 'm4bpbias', Center, StepParameterRange(2, 1, 2) )
        self.addDevice( 'm4bpb0'  , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'm4bpb1'  , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'm4bpb2'  , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'm4bpb3'  , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'm4bpb4'  , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'm4bpb5'  , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'm4bpb6'  , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'm4bpb7'  , Center, StepParameterRange(1, 1, 1) )
        self.popNode()

        self.popNode()
         
        # GMD.
        self.pushHNode( Center )
        self.addDevice( 'm1ap_an' , Center, StepParameterRange(2, 2, 2) )
        self.pushVNode( Center )
        self.addDevice( 'm2p'     , Center, StepParameterRange(4, 2, 2) )
        self.addDevice( 'm2n'     , Center, StepParameterRange(4, 2, 2) )
        self.popNode()
        self.addDevice( 'm9ap_an' , Center, StepParameterRange(4, 2, 2) )
        
        # CMC.
        self.addDevice( 'm12ap_an', Center, StepParameterRange(2, 2, 2) )
        self.pushVNode( Center )
       #self.addSymmetry( 0, 1 )
        self.addDevice( 'm11ap'   , Center, StepParameterRange(2, 2, 2) )
        self.addDevice( 'm11an'   , Center, StepParameterRange(2, 2, 2) )
        self.addSymmetry( 0, 1 )
        self.popNode()
        self.addDevice( 'm13'     , Center, StepParameterRange(2, 2, 2) )
        self.addDevice( 'decoder' , Center, None )
        self.popNode()
        
        # Ampli N.
        self.pushHNode( Center )
        self.addDevice( 'm10an'   , Center, StepParameterRange(4, 2, 2) )
        self.addDevice( 'm3an_bn' , Center, StepParameterRange(2, 2, 2) )
        self.pushVNode( Center )
       #self.addSymmetry( 0, 1 )
        self.addDevice( 'm4an'    , Center, StepParameterRange(4, 2, 2) )
        self.addDevice( 'm4bn'    , Center, StepParameterRange(4, 2, 2) )
        self.addSymmetry( 0, 1 )
        self.popNode()
        self.pushVNode( Center )
       #self.addSymmetry( 0, 3 )
       #self.addSymmetry( 1, 2 )
        self.addDevice( 'm7bn'    , Center, StepParameterRange(4, 2, 2) )
        self.addDevice( 'm8bn'    , Center, StepParameterRange(4, 2, 2) )
        self.addDevice( 'm8an'    , Center, StepParameterRange(4, 2, 2) )
        self.addDevice( 'm7an'    , Center, StepParameterRange(4, 2, 2) )
        self.addSymmetry( 0, 3 )
        self.addSymmetry( 1, 2 )
        self.popNode()
        self.pushVNode( Center )
       #self.addSymmetry( 0, 2 )
        self.addDevice( 'm5bn'    , Center, StepParameterRange(4, 2, 2) )
        self.addDevice( 'm6an_bn' , Center, StepParameterRange(4, 2, 2) )
        self.addDevice( 'm5an'    , Center, StepParameterRange(4, 2, 2) )
        self.addSymmetry( 0, 2 )
        self.popNode()
       # Digitally controlled biasing.
        self.pushVNode( Center )
        self.addDevice( 'm4bnb7'  , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'm4bnb6'  , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'm4bnb5'  , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'm4bnb4'  , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'm4bnb3'  , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'm4bnb2'  , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'm4bnb1'  , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'm4bnb0'  , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'm4bnbias', Center, StepParameterRange(2, 1, 2) )
        self.popNode()

        self.popNode()

       #self.addVRail( self.getNet('vdd'), 'METAL3', 2, "CV2", "IV2" )
        self.addVRail( self.getNet('vdd'), 'METAL3', 3, "CV3", "IV3" )
        self.addSymmetry( 1, 3 )
        self.popNode()

       #self.addHRail( self.getNet('vss'), 'METAL4', 2, "CH2", "IH2" )
        self.addHRail( self.getNet('vss'), 'METAL4', 3, "CH3", "IH3" )
        self.popNode()
        self.endSlicingTree()
        self.updatePlacement( 99.0, 61.2 )
       #self.updatePlacement( 0 )
        self.endCell()
        
        if editor:
          editor.setCell( self.cell )
          editor.fit()
        return


def ScriptMain ( **kw ):
    editor = None
    if kw.has_key('editor') and kw['editor']:
      editor = kw['editor']

   #framework = CRL.AllianceFramework.get()

   #cell = framework.getCell( 'gmdecod', CRL.Catalog.State.Views )
   #if cell:
   #    UpdateSession.open()
   #    cell.destroy()
   #    UpdateSession.close()
   #    print 'Previous <gmdecod> cell destroyed.'

    design = GmDecodDigCtl()
    design.build( editor )

    return True
