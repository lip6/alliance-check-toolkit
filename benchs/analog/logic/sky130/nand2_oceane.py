#!/usr/bin/python3
#
# This file is part of the Coriolis Software.
#
# +-----------------------------------------------------------------+ 
# |             C O R I O L I S   D E S I G N S                     |
# |      A Collection of Analogic Designs Examples                  | 
# |                                                                 |
# |  Author      :               Marie-Minerve Louerat              |
# |  E-mail      :            Jean-Paul.Chaput@lip6.fr              |
# | =============================================================== |
# |  Python      :  "./nand2_oceane.py"                             |
# |                                                                 |
# |  Python by Marie-Minerve LOUERAT (24 March 2023)                |
# |  Oceane sizing by Jacky PORTE    (24 March 2023)                |
# |  24 March 2023                                                  |
# +-----------------------------------------------------------------+
#
#
# Folded transistors
# Routing described
#
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------

import os
import sys
from coriolis           import Cfg
from coriolis.Hurricane import *
from coriolis           import CRL, helpers

#helpers.setTraceLevel( 100 )

from coriolis.Analog import Device, Transistor, CommonDrain, CommonGatePair, \
                            CommonSourcePair, CrossCoupledPair,              \
                            DifferentialPair, LevelShifter,                  \
                            SimpleCurrentMirror, CapacitorFamily,            \
                            MultiCapacitor, LayoutGenerator
from coriolis.Bora   import ParameterRange, StepParameterRange,       \
                            MatrixParameterRange, SlicingNode,        \
                            HSlicingNode, VSlicingNode, DSlicingNode, \
                            RHSlicingNode, RVSlicingNode
from coriolis.karakaze.analogdesign import AnalogDesign

NMOS    = Transistor.NMOS
PMOS    = Transistor.PMOS
PIP     = CapacitorFamily.PIP
MIM     = CapacitorFamily.MIM
MOM     = CapacitorFamily.MOM
Center  = SlicingNode.AlignCenter
Left    = SlicingNode.AlignLeft
Right   = SlicingNode.AlignRight
Top     = SlicingNode.AlignTop
Bottom  = SlicingNode.AlignBottom
Unknown = SlicingNode.AlignBottom
VNode   = 1
HNode   = 2
DNode   = 3


class NAND2 ( AnalogDesign ):

    def __init__ ( self ):
        AnalogDesign.__init__( self )
        return

    def build ( self, editor ):
        print( '  o  Running NAND2.build().')

       #    | 0           | 1         | 2               | 3   | 4      |  5    | 6| 7   |8  |9     |10  | 11    |
       #    | Class       | Instance  | Layout Style    | Type| W      |  L    | M| Mint|Dum|SFirst|Bulk| BulkC |
       #    +=============+===========+=================+=====+========+=======+==+=====+===+======+====+=======+
        self.devicesSpecs = \
          [ [ Transistor  , 'na2mp1'  , 'WIP Transistor', PMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'na2mp2'  , 'WIP Transistor', PMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'na2mn1'  , 'WIP Transistor', NMOS, 0.42   , 0.150 , 1, None,  0, True , 0x2, True  ]
          , [ Transistor  , 'na2mn2'  , 'WIP Transistor', NMOS, 0.42   , 0.150 , 1, None,  0, True , 0x2, False ]
          ]

        self.netTypes = \
          { 'ea'    : { 'isExternal':True }
          , 'eb'    : { 'isExternal':True }
          , 's'     : { 'isExternal':True }
          , 'int1'  : { 'isExternal':False}
          , 'vdd'   : { 'isExternal':True }
          , 'vss'   : { 'isExternal':True }
          }
          
        self.netSpecs = \
          { 'ea'     : [ ('na2mn1' , 'G'), ('na2mp1' , 'G')]
          , 'eb'     : [ ('na2mn2' , 'G'), ('na2mp2' , 'G')]
          , 's'      : [ ('na2mn2' , 'D'), ('na2mp1' , 'D'), ('na2mp2' , 'D')]
          , 'int1'   : [ ('na2mn1' , 'D'), ('na2mn2' , 'S')]
     
          , 'vdd'    : [ ('na2mp1' , 'S'), ('na2mp2' , 'S')]
          , 'vss'    : [ ('na2mn1' , 'S'), ('na2mn2' , 'B')]
          }

        self.readParameters( './oceane_nand2.txt' )

        self.beginCell( 'nand2' )
        self.doDevices()
        self.doNets   ()
    
        self.beginSlicingTree()
        self.setToleranceRatioH( 1000000000.0 )
        self.setToleranceRatioW( 1000000000.0 )
        self.setToleranceBandH ( 1000000000.0 )
        self.setToleranceBandW ( 1000000000.0 )

        # #0
        self.pushHNode( Center )
        # #1

        self.addHRail( self.getNet('vss'), 'METAL4', 2, "CH1", "IH1" )

        # #1
        self.pushVNode( Center )

        # #2
        self.addDevice( 'na2mn1' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'na2mn2' , Center, StepParameterRange(1, 1, 1) )
        # #2
        self.popNode()
        # #1
        self.pushVNode( Center )
        # #2
        self.addDevice( 'na2mp1' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'na2mp2' , Center, StepParameterRange(1, 1, 1) )
        self.popNode()
        # #1
        self.addHRail( self.getNet('vdd'), 'METAL4', 2, "CH2", "IH2" )
        self.popNode()
        # #0
        #self.updatePlacement(  30 )
        self.endCell()
    
        if editor:
          editor.setCell( self.cell )
          editor.fit()
        return


def scriptMain ( **kw ):
    editor = None
    #if kw.has_key('editor') and kw['editor']:
    if 'editor' in kw and kw['editor']:
      editor = kw['editor']

    cell = CRL.AllianceFramework.get().getCell( 'nand2', CRL.Catalog.State.Views )
    if cell:
        UpdateSession.open()
        cell.destroy()
        UpdateSession.close()
        print( 'Previous <nand2> cell destroyed.')

    design = NAND2()
    design.build( editor )
    return True

