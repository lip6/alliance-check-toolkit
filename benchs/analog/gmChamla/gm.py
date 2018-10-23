#!/usr/bin/python
#
# This file is part of Alliance Check Toolkit
# Copyright (c) UPMC 2016-2018, All Rights Reserved
#
# +-----------------------------------------------------------------+ 
# |     A l l i a n c e   C h e c k   T o o l k i t                 |
# |            G M  -  Chamla Implementation                        |
# |                                                                 |
# |  Author      :               Marie-Minerve Louerat              |
# |  E-mail      :            Jean-Paul.Chaput@lip6.fr              |
# | =============================================================== |
# |  Python      :  "./layout/gm.py"                                |
# |                                                                 |
# |  Python portage by Jean-Paul CHAPUT (dec, 2016)                 |
# +-----------------------------------------------------------------+
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


import sys
import Cfg
from   Hurricane import *
import CRL
import helpers
import Hurricane
from   Hurricane import DataBase

helpers.staticInitialization( quiet=False )
helpers.setTraceLevel( 100 )
#helpers.setTraceLevel( 110 )

from   Analog import Device
from   Analog import Transistor
from   Analog import CommonDrain
from   Analog import CommonGatePair
from   Analog import CommonSourcePair
from   Analog import CrossCoupledPair
from   Analog import DifferentialPair
from   Analog import LevelShifter
from   Analog import SimpleCurrentMirror
from   Analog import LayoutGenerator
from   Bora   import SlicingNode
from   Bora   import HSlicingNode
from   Bora   import VSlicingNode
from   Bora   import DSlicingNode
from   Bora   import RHSlicingNode
from   Bora   import RVSlicingNode
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


class GmChamla ( AnalogDesign ):

    def __init__ ( self ):
        AnalogDesign.__init__( self )
        return


    def build ( self, editor ):
        print '  o  Running GmChamla.build().'

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
          ]

        self.netTypes = \
          { 'vin+'  : { 'isExternal':True }
          , 'vin-'  : { 'isExternal':True }
          , 'vout+' : { 'isExternal':True }
          , 'vout-' : { 'isExternal':True }
          , 'vref'  : { 'isExternal':True }
          , 'vc'    : { 'isExternal':True }
          , 'vb5'   : { 'isExternal':True }
          , 'vb7'   : { 'isExternal':True }
          , 'vb10an': { 'isExternal':True }
          , 'vb10ap': { 'isExternal':True }
          , 'vb12an': { 'isExternal':True }
          , 'vb12ap': { 'isExternal':True }
          , 'vb13'  : { 'isExternal':True }
          , 'alim'  : { 'isExternal':True }
          , 'vss'   : { 'isExternal':True }
          }

        self.netSpecs = \
          { 'vin+'   : [ ('m1ap_an' , 'G1') ]
          , 'vin-'   : [ ('m1ap_an' , 'G2'), ]
          , 'vout+'  : [ ('m2n'     , 'D' ), ('m9ap_an', 'D2'), ('m11ap'  , 'G1') ]
          , 'vout-'  : [ ('m2p'     , 'D' ), ('m9ap_an', 'D1'), ('m11an'  , 'G2') ]
         #, 'vout+'  : [ ('m2n'     , 'D' ), ('m9ap_an', 'D2'), ('m11ap'  , 'G1'), ('inv_x84', 'i+') ]
         #, 'vout-'  : [ ('m2p'     , 'D' ), ('m9ap_an', 'D1'), ('m11an'  , 'G2'), ('inv_x84', 'i-') ]
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
          , 'vc'     : [ ('m4bn'    , 'G' ), ('m4bp'    , 'G' ) ]
         #, 'vb5'    : [ {'W': '2'}, ('m5an'    , 'G' ), ('m5bn'    , 'G' ), ('m5ap'    , 'G' ), ('m5bp'    , 'G' ) ]
          , 'vb5'    : [ ('m5an'    , 'G' ), ('m5bn'    , 'G' ), ('m5ap'    , 'G' ), ('m5bp'    , 'G' ) ]
          , 'vb7'    : [ ('m7an'    , 'G' ), ('m7bn'    , 'G' ), ('m8an'    , 'G' ), ('m8bn'    , 'G' )
                       , ('m7ap'    , 'G' ), ('m7bp'    , 'G' ), ('m8ap'    , 'G' ), ('m8bp'    , 'G' ) ]
          , 'vb10an' : [ ('m10an'   , 'G' ), ]
          , 'vb10ap' : [ ('m10ap'   , 'G' ), ]
          , 'vb12an' : [ ('m12ap_an', 'G2'), ]
          , 'vb12ap' : [ ('m12ap_an', 'G1'), ]
          , 'vb13'   : [ ('m13'     , 'G' ), ]
          , 'alim'   : [ ('m9ap_an' , 'S' ), ('m11an'    , 'D2'), ('m11ap'    , 'D1'), ('m13'      , 'S' )
                       , ('m5an'    , 'S' ), ('m5bn'     , 'S' ), ('m6an_bn'  , 'S' ), ('m5ap'     , 'S' )
                       , ('m5bp'    , 'S' ), ('m6ap_bp'  , 'S' ) ]
          , 'vss'    : [ ('m1ap_an' , 'S' ), ('m2p'      , 'B' ), ('m2n'      , 'B' ), ('m11an'    , 'B' )
                       , ('m11ap'   , 'B' ), ('m12ap_an' , 'S' ), ('m10an'    , 'S' ), ('m4an'     , 'D' )
                       , ('m4bn'    , 'D' ), ('m10ap'    , 'S' ), ('m4ap'     , 'D' ), ('m4bp'     , 'D' ) ]
          }

        self.beginCell( 'gm' )
        self.doDevices()
        self.doNets   ()
    
        self.beginSlicingTree()
        self.setToleranceRatioH( 1000000000.0 )
        self.setToleranceRatioW( 1000000000.0 )
        self.setToleranceBandH ( 1000000000.0 )
        self.setToleranceBandW ( 1000000000.0 )

       #self.pushHNode( Center )
       #self.addHRail( self.getNet('vss'), 'METAL4', 2, "CH1", "IH1" )

        self.pushVNode( Center )
        self.addSymmetry( 0, 2 )

        self.addSymmetryNet( VNode, self.getNet('vb5') )
        self.addSymmetryNet( VNode, self.getNet('vb7') )
        self.addSymmetryNet( VNode, self.getNet('vc') )
        self.addSymmetryNet( VNode, self.getNet('ampp_73'), self.getNet('ampn_72') )
        self.addSymmetryNet( VNode, self.getNet('ampp_71'), self.getNet('ampn_71') )
        self.addSymmetryNet( VNode, self.getNet('ampp_61'), self.getNet('ampn_61') )
        self.addSymmetryNet( VNode, self.getNet('ampp_63'), self.getNet('ampn_63') )
        self.addSymmetryNet( VNode, self.getNet('ampp_4' ), self.getNet('ampn_4' ) )
        self.addSymmetryNet( VNode, self.getNet('ampp_2' ), self.getNet('ampn_2' ) )
        self.addSymmetryNet( VNode, self.getNet('ampp_1' ), self.getNet('ampn_1' ) )
        self.addSymmetryNet( VNode, self.getNet('m2p_in' ), self.getNet('m2n_in' ) )
       
       #self.addVRail( self.getNet('alim'), 'METAL3', 2, "CV1", "CV1" )
       # Ampli P.
        self.pushHNode( Center )
        self.addDevice( 'm10ap'   , Center, span=(4.0, 2.0, 2.0), NF=4 )
        self.addDevice( 'm3ap_bp' , Center, span=(2.0, 2.0, 2.0), NF=2 )
        self.pushVNode( Center )
       #self.addSymmetry( 0, 1 )
        self.addDevice( 'm4ap'    , Center, span=(4.0, 2.0, 2.0), NF=4 )
        self.addDevice( 'm4bp'    , Center, span=(4.0, 2.0, 2.0), NF=4 )
        self.addSymmetry( 0, 1 )
        self.popNode()
        self.pushVNode( Center )
       #self.addSymmetry( 0, 3 )
       #self.addSymmetry( 1, 2 )
        self.addDevice( 'm7ap'    , Center, span=(4.0, 2.0, 2.0), NF=4 )
        self.addDevice( 'm8ap'    , Center, span=(4.0, 2.0, 2.0), NF=4 )
        self.addDevice( 'm8bp'    , Center, span=(4.0, 2.0, 2.0), NF=4 )
        self.addDevice( 'm7bp'    , Center, span=(4.0, 2.0, 2.0), NF=4 )
        self.addSymmetry( 0, 3 )
        self.addSymmetry( 1, 2 )
        self.popNode()
        self.pushVNode( Center )
       #self.addSymmetry( 0, 2 )
        self.addDevice( 'm5ap'    , Center, span=(4.0, 2.0, 2.0), NF=4 )
        self.addDevice( 'm6ap_bp' , Center, span=(4.0, 2.0, 2.0), NF=4 )
        self.addDevice( 'm5bp'    , Center, span=(4.0, 2.0, 2.0), NF=4 )
        self.addSymmetry( 0, 2 )
        self.popNode()
        self.popNode()
        
       # GMD.
        self.pushHNode( Center )
        self.addDevice( 'm1ap_an' , Center, span=(2.0, 2.0, 2.0), NF=2 )
        self.pushVNode( Center )
        self.addDevice( 'm2p'     , Center, span=(4.0, 2.0, 2.0), NF=4 )
        self.addDevice( 'm2n'     , Center, span=(4.0, 2.0, 2.0), NF=4 )
        self.popNode()
        self.addDevice( 'm9ap_an' , Center, span=(4.0, 2.0, 2.0), NF=4 )
        
       # CMC.
        self.addDevice( 'm12ap_an', Center, span=(2.0, 2.0, 2.0), NF=2 )
        self.pushVNode( Center )
       #self.addSymmetry( 0, 1 )
        self.addDevice( 'm11ap'   , Center, span=(2.0, 2.0, 2.0), NF=2 )
        self.addDevice( 'm11an'   , Center, span=(2.0, 2.0, 2.0), NF=2 )
        self.addSymmetry( 0, 1 )
        self.popNode()
        self.addDevice( 'm13'     , Center, span=(2.0, 2.0, 2.0), NF=2 )
        self.popNode()
        
       # Ampli N.
        self.pushHNode( Center )
        self.addDevice( 'm10an'   , Center, span=(4.0, 2.0, 2.0), NF=4 )
        self.addDevice( 'm3an_bn' , Center, span=(2.0, 2.0, 2.0), NF=2 )
        self.pushVNode( Center )
       #self.addSymmetry( 0, 1 )
        self.addDevice( 'm4bn'    , Center, span=(4.0, 2.0, 2.0), NF=4 )
        self.addDevice( 'm4an'    , Center, span=(4.0, 2.0, 2.0), NF=4 )
        self.addSymmetry( 0, 1 )
        self.popNode()
        self.pushVNode( Center )
       #self.addSymmetry( 0, 3 )
       #self.addSymmetry( 1, 2 )
        self.addDevice( 'm7bn'    , Center, span=(4.0, 2.0, 2.0), NF=4 )
        self.addDevice( 'm8bn'    , Center, span=(4.0, 2.0, 2.0), NF=4 )
        self.addDevice( 'm8an'    , Center, span=(4.0, 2.0, 2.0), NF=4 )
        self.addDevice( 'm7an'    , Center, span=(4.0, 2.0, 2.0), NF=4 )
        self.addSymmetry( 0, 3 )
        self.addSymmetry( 1, 2 )
        self.popNode()
        self.pushVNode( Center )
       #self.addSymmetry( 0, 2 )
        self.addDevice( 'm5bn'    , Center, span=(4.0, 2.0, 2.0), NF=4 )
        self.addDevice( 'm6an_bn' , Center, span=(4.0, 2.0, 2.0), NF=4 )
        self.addDevice( 'm5an'    , Center, span=(4.0, 2.0, 2.0), NF=4 )
        self.addSymmetry( 0, 2 )
        self.popNode()
        self.popNode()

       #self.addVRail( self.getNet('alim'), 'METAL3', 2, "CV2", "IV2" )
       #self.addVRail( self.getNet('alim'), 'METAL3', 3, "CV3", "IV3" )
        self.addSymmetry( 0, 2 )
        self.popNode()

       #self.addHRail( self.getNet('vss'), 'METAL4', 2, "CH2", "IH2" )
       #self.addHRail( self.getNet('vss'), 'METAL4', 3, "CH3", "IH3" )
       #self.popNode()
       #self.updatePlacement(30)
        self.endSlicingTree()
       #self.updatePlacement( 99.0, 61.2 )
        self.updatePlacement(  30 )
       #self.updatePlacement(   5 )
       #self.updatePlacement( 156 )
       #self.updatePlacement( 313 )
        self.endCell()
        
        if editor:
          editor.setCell( self.cell )
          editor.fit()
        return


def ScriptMain ( **kw ):
    editor = None
    if kw.has_key('editor') and kw['editor']:
      editor = kw['editor']

    cell = CRL.AllianceFramework.get().getCell( 'gm', CRL.Catalog.State.Views )
    if cell:
        UpdateSession.open()
        cell.destroy()
        UpdateSession.close()
        print 'Previous <gm> cell destroyed.'

    design = GmChamla()
    design.build( editor )
    return True
