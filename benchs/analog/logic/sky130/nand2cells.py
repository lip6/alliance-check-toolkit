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
# |  Python      :  "./nand2cells.py"                               |
# |                                                                 |
# |  Python by Marie-Minerve LOUERAT (5 April  2023)                |
# |  Oceane sizing by Jacky PORTE    (24 March 2023)                |
# |  5 April  2023                                                  |
# +-----------------------------------------------------------------+
#
# 2 nand2 cells are connected
#         netlist description is splitted
#         layout description is splitted
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



class NAND2  ( object ):

    def __init__ ( self ):
        pass

    def buildDevAndNets (self, design ):
        i=2
        design.devicesSpecs += \
          [ [ Transistor  , 'na2mp1'+str(i) , 'WIP Transistor', PMOS, 0.84   , 0.925 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'na2mp2'+str(i) , 'WIP Transistor', PMOS, 0.84   , 0.925 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'na2mn1'+str(i) , 'WIP Transistor', NMOS, 0.42   , 0.150 , 1, None,  0, True , 0x2, True  ]
          , [ Transistor  , 'na2mn2'+str(i) , 'WIP Transistor', NMOS, 0.42   , 0.150 , 1, None,  0, True , 0x2, False ]
          ]

        design.netTypes[ 's'+str(i)  ] = { 'isExternal':True }

        if 's'+str(i) not in design.netSpecs: design.netSpecs[ 's'+str(i) ] = []
        design.netSpecs[ 's'+str(i)   ] += [ ('na2mn2'+str(i) , 'D'), ('na2mp1'+str(i) , 'D'), ('na2mp2'+str(i) , 'D')]
        design.netSpecs[ 's'+str(i-1) ] += [ ('na2mn1'+str(i) , 'G'), ('na2mp1'+str(i) , 'G')]
        design.netSpecs[ 'eb'         ] += [ ('na2mn2'+str(i) , 'G'), ('na2mp2'+str(i) , 'G')]

        if 'int1'+str(i) not in design.netSpecs: design.netSpecs[ 'int1'+str(i) ] = []
        design.netSpecs[ 'int1'+str(i)] += [ ('na2mn1'+str(i) , 'D'), ('na2mn2'+str(i) , 'S')]

        design.netSpecs[ 'vdd'        ] += [ ('na2mp1'+str(i) , 'S'), ('na2mp2'+str(i) , 'S')]
        design.netSpecs[ 'vss'        ] += [ ('na2mn1'+str(i) , 'S'), ('na2mn2'+str(i) , 'B')]


    def buildSlicingTree ( self, design ):
        i=2   
        # #2
        design.pushHNode( Center )
        # #3
        design.pushVNode( Center )
        # #4
        design.addDevice( 'na2mn1'+str(i) , Center, StepParameterRange(1, 1, 1) )
        design.addDevice( 'na2mn2'+str(i) , Center, StepParameterRange(1, 1, 1) )
        
        # #4
        design.popNode()
        # #3
        design.pushVNode( Center )
        # #4
        design.addDevice( 'na2mp1'+str(i) , Center, StepParameterRange(1, 1, 1) )
        design.addDevice( 'na2mp2'+str(i) , Center, StepParameterRange(1, 1, 1) )
        # #4
        design.popNode()
        # #3
        design.popNode()
        # #2


class TWOCELLSNAND2 ( AnalogDesign ):

    def __init__ ( self ):
        AnalogDesign.__init__( self )
        return

    def build ( self, editor ):
        print( '  o  Running TWOCELLSNAND2.build().')

       #    | 0           | 1         | 2               | 3   | 4      |  5    | 6| 7   |8  |9     |10  | 11    |
       #    | Class       | Instance  | Layout Style    | Type| W      |  L    | M| Mint|Dum|SFirst|Bulk| BulkC |
       #    +=============+===========+=================+=====+========+=======+==+=====+===+======+====+=======+
        i=1
        self.devicesSpecs = \
          [ [ Transistor  , 'na2mp1'+str(i)  , 'WIP Transistor', PMOS, 0.84   , 0.925 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'na2mp2'+str(i)  , 'WIP Transistor', PMOS, 0.84   , 0.925 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'na2mn1'+str(i)  , 'WIP Transistor', NMOS, 0.42   , 0.150 , 1, None,  0, True , 0x2, True  ]
          , [ Transistor  , 'na2mn2'+str(i)  , 'WIP Transistor', NMOS, 0.42   , 0.150 , 1, None,  0, True , 0x2, False ]
         ]

        self.netTypes = \
          { 'ea'    : { 'isExternal':True }
          , 'eb'    : { 'isExternal':True }
          , 'vdd'   : { 'isExternal':True }
          , 'vss'   : { 'isExternal':True }
          }
          
        self.netSpecs = \
          { 'ea'          : [ ('na2mn1'+str(i) , 'G'), ('na2mp1'+str(i) , 'G')]
          , 'eb'          : [ ('na2mn2'+str(i) , 'G'), ('na2mp2'+str(i) , 'G')]
          , 's'+str(i)    : [ ('na2mn2'+str(i) , 'D'), ('na2mp1'+str(i) , 'D'), ('na2mp2'+str(i) , 'D')]
          , 'int1'+str(i) : [ ('na2mn1'+str(i) , 'D'), ('na2mn2'+str(i) , 'S')]
     
          , 'vdd'         : [ ('na2mp1'+str(i) , 'S'), ('na2mp2'+str(i) , 'S')]
          , 'vss'         : [ ('na2mn1'+str(i) , 'S'), ('na2mn2'+str(i) , 'B')]
          }

        nand2 = NAND2()
        nand2.buildDevAndNets( self )


        self.beginCell( 'twocellsnand2' )
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
        self.pushHNode( Center )
        # #3
        self.pushVNode( Center )
        # #4
        i=1
        self.addDevice( 'na2mn1'+str(i) , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'na2mn2'+str(i) , Center, StepParameterRange(1, 1, 1) )
        
        # #4
        self.popNode()
        # #3
        self.pushVNode( Center )
        # #4
        i=1
        self.addDevice( 'na2mp1'+str(i) , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'na2mp2'+str(i) , Center, StepParameterRange(1, 1, 1) )
        self.popNode()
        # #3

        self.popNode()
        # #2
        nand2.buildSlicingTree( self )

        # #2
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

    cell = CRL.AllianceFramework.get().getCell( 'twocellsnand2', CRL.Catalog.State.Views )
    if cell:
        UpdateSession.open()
        cell.destroy()
        UpdateSession.close()
        print( 'Previous <twocellsnand2> cell destroyed.')

    design = TWOCELLSNAND2()
    design.build( editor )
    return True

