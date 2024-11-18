#!/usr/bin/python3
#
# This file is part of the Coriolis Software.
#
# +-----------------------------------------------------------------+ 
# |             C O I O L I S   D E S I G N S                       |
# |      A Collection of Analogic Designs Examples                  | 
# |                                                                 |
# |  Author      :               Marie-Minerve Louerat              |
# |  E-mail      :            Jean-Paul.Chaput@lip6.fr              |
# | =============================================================== |
# |  Python      :  "./comparator_buffer_RS_oceane.py"              |
# |                                                                 |
# |  Python by Marie-Minerve LOUERAT (30 March 2023)                |
# |  Oceane sizing by Jacky PORTE    (30 March 2023)                |
# |  revision: 24 April 2023                                        |
# +-----------------------------------------------------------------+
#
# Comparator : Dynamic pre-amplifier (Ptype), Latch-type Song comparator (type N), buffers and RS FFlop 
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


class COMPARATOR_B_RS ( AnalogDesign ):

    def __init__ ( self ):
        AnalogDesign.__init__( self )
        return

    def build ( self, editor ):
        print( '  o  Running COMPARATOR_B_RS.build().')

       #    | 0           | 1         | 2               | 3   | 4      |  5    | 6| 7   |8  |9     |10  | 11    |
       #    | Class       | Instance  | Layout Style    | Type| W      |  L    | M| Mint|Dum|SFirst|Bulk| BulkC |
       #    +=============+===========+=================+=====+========+=======+==+=====+===+======+====+=======+
        self.devicesSpecs = \
          [ [ Transistor  , 'cmpmp1' , 'WIP Transistor', PMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'cmpmp2' , 'WIP Transistor', PMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'cmpmp5' , 'WIP Transistor', PMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'cmpmn7' , 'WIP Transistor', NMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'cmpmn8' , 'WIP Transistor', NMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'cmpmn9' , 'WIP Transistor', NMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'cmpmn11', 'WIP Transistor', NMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'cmpmn12', 'WIP Transistor', NMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'cmpmp13', 'WIP Transistor', PMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'cmpmp14', 'WIP Transistor', PMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'cmpmp15', 'WIP Transistor', PMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'cmpmp16', 'WIP Transistor', PMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'cmpmn17', 'WIP Transistor', NMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'cmpmn18', 'WIP Transistor', NMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'cmpmn21', 'WIP Transistor', NMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'cmpmp21', 'WIP Transistor', PMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'cmpmn22', 'WIP Transistor', NMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'cmpmp22', 'WIP Transistor', PMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'cmpmn23', 'WIP Transistor', NMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'cmpmp23', 'WIP Transistor', PMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'cmpmn24', 'WIP Transistor', NMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'cmpmp24', 'WIP Transistor', PMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'rsmn1a' , 'WIP Transistor', NMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'rsmn1b' , 'WIP Transistor', NMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'rsmp1a' , 'WIP Transistor', PMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'rsmp1b' , 'WIP Transistor', PMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'rsmp2a' , 'WIP Transistor', PMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'rsmp2b' , 'WIP Transistor', PMOS, 0.42   , 0.150 , 1, None,  0, True , 0x1, True  ]
          ]

        self.netTypes = \
          { 'vcnap' : { 'isExternal':True }
          , 'vcnam' : { 'isExternal':True }
          , 'h'     : { 'isExternal':True }
          , 'pp'    : { 'isExternal':False}
          , 'pm'    : { 'isExternal':False}
          , 'ps'    : { 'isExternal':False}
          , 's11'   : { 'isExternal':False}
          , 's12'   : { 'isExternal':False}
          , 'sqp'   : { 'isExternal':False}
          , 'sqm'   : { 'isExternal':False}
          , 'is1'   : { 'isExternal':False}
          , 'is2'   : { 'isExternal':False}
          , 's'     : { 'isExternal':False}
          , 'r'     : { 'isExternal':False}
          , 'qpcmp' : { 'isExternal':True }
          , 'qmcmp' : { 'isExternal':True }
          , 'vdd'   : { 'isExternal':True }
          , 'vss'   : { 'isExternal':True }
          }
          
        self.netSpecs = \
          { 'h'      : [ ('cmpmp5' , 'G'), ('cmpmn7' , 'G'), ('cmpmn8' , 'G'), ('cmpmn9' , 'G')]
          , 'vcnap'  : [ ('cmpmp1' , 'G')]
          , 'vcnam'  : [ ('cmpmp2' , 'G')]
          , 'ps'     : [ ('cmpmp1' , 'S'), ('cmpmp2' , 'S'), ('cmpmp5' , 'D'), ('cmpmn9' , 'D')]
          , 'pp'     : [ ('cmpmp2' , 'D'), ('cmpmn8' , 'D'), ('cmpmn11', 'G'), ('cmpmp15', 'G')]
          , 'pm'     : [ ('cmpmp1' , 'D'), ('cmpmn7' , 'D'), ('cmpmn12', 'G'), ('cmpmp16', 'G')]

          , 's11'    : [ ('cmpmn11', 'S'), ('cmpmn17', 'D')]
          , 's12'    : [ ('cmpmn12', 'S'), ('cmpmn18', 'D')]

          , 'sqp'    : [ ('cmpmp13', 'G'), ('cmpmn17', 'G'), ('cmpmn12', 'D'), ('cmpmp14', 'D'), ('cmpmp16', 'D')
                       , ('cmpmn22', 'G'), ('cmpmp22', 'G')]
          , 'sqm'    : [ ('cmpmp14', 'G'), ('cmpmn18', 'G'), ('cmpmn11', 'D'), ('cmpmp13', 'D'), ('cmpmp15', 'D')
                       , ('cmpmn21', 'G'), ('cmpmp21', 'G')]

          , 'is1'    : [ ('cmpmn21', 'D'), ('cmpmp21', 'D'), ('cmpmn23', 'G'), ('cmpmp23', 'G')]
          , 'is2'    : [ ('cmpmn22', 'D'), ('cmpmp22', 'D'), ('cmpmn24', 'G'), ('cmpmp24', 'G')]

          , 's'      : [ ('cmpmn23', 'D'), ('cmpmp23', 'D'), ('rsmp2a',  'G')]
          , 'r'      : [ ('cmpmn24', 'D'), ('cmpmp24', 'D'), ('rsmp2b',  'G')]

          , 'qpcmp'  : [ ('rsmp1a',  'D'), ('rsmp2a',  'D'), ('rsmn1a',  'D'), ('rsmp1b',  'G'), ('rsmn1b',  'G')]
          , 'qmcmp'  : [ ('rsmp1b',  'D'), ('rsmp2b',  'D'), ('rsmn1b',  'D'), ('rsmp1a',  'G'), ('rsmn1a',  'G')]


          , 'vdd'    : [ ('cmpmp5' , 'S'), ('cmpmp13', 'S'), ('cmpmp14', 'S'), ('cmpmp15', 'S'), ('cmpmp16', 'S')
                       , ('cmpmp21', 'S'), ('cmpmp22', 'S'), ('cmpmp23', 'S'), ('cmpmp24', 'S')
                       , ('rsmp1a',  'S'), ('rsmp2a',  'S'), ('rsmp1b',  'S'), ('rsmp2b',  'S')]

          , 'vss'    : [ ('cmpmn7' , 'S'), ('cmpmn8' , 'S'), ('cmpmn9' , 'S'), ('cmpmn11', 'S'), ('cmpmn12', 'S') 
                       , ('cmpmn17', 'S'), ('cmpmn18', 'S'), ('cmpmn21', 'S'), ('cmpmn22', 'S'), ('cmpmn23', 'S')
                       , ('cmpmn24', 'S'), ('rsmn1a',  'S'), ('rsmn1b',  'S')]
          }

        self.readParameters( './sizes/oceane_comparator_buffer_RS.txt' )

        self.beginCell( 'comparator_b_rs' )
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
        self.addDevice( 'cmpmn9' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'cmpmn7' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'cmpmn8' , Center, StepParameterRange(1, 1, 1) )
        # #4
        self.popNode()
        # #3
        self.pushVNode( Center )
        # #4
        self.addDevice( 'cmpmp1' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'cmpmp2' , Center, StepParameterRange(1, 1, 1) )
        self.popNode()
        # #3
        self.addDevice( 'cmpmp5' , Center, StepParameterRange(1, 1, 1) )
        self.popNode()
        # #2
        self.pushHNode( Center )
        # #3
        self.pushVNode( Center )
        # #4
        self.addDevice( 'cmpmn17' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'cmpmn18' , Center, StepParameterRange(1, 1, 1) )
        # #4
        self.popNode()
        # #3
        self.pushVNode( Center )
        # #4
        self.addDevice( 'cmpmn11' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'cmpmn12' , Center, StepParameterRange(1, 1, 1) )
        self.popNode()
        # #3
        self.pushVNode( Center )
        # #4
        self.addDevice( 'cmpmp15' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'cmpmp13' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'cmpmp14' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'cmpmp16' , Center, StepParameterRange(1, 1, 1) )
        self.popNode()
        # #3
        self.popNode()
        # #2
        self.pushHNode( Center )
        # #3
        self.pushVNode( Center )
        # #4
        self.addDevice( 'cmpmn21' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'cmpmn22' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'cmpmn23' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'cmpmn24' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'rsmn1a'  , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'rsmn1b'  , Center, StepParameterRange(1, 1, 1) )
        # #4
        self.popNode()
        # #3
        self.pushVNode( Center )
        # #4
        self.addDevice( 'cmpmp21' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'cmpmp22' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'cmpmp23' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'cmpmp24' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'rsmp2a'  , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'rsmp1a'  , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'rsmp1b'  , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'rsmp2b'  , Center, StepParameterRange(1, 1, 1) )
        # #4
        self.popNode()
        # #3
        self.popNode()
        # #2
        self.popNode()
        # #1
        self.addHRail( self.getNet('vdd'), 'METAL4', 2, "CH2", "IH2" )
        self.popNode()
        # #0
        self.updatePlacement(  0 )
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

    cell = CRL.AllianceFramework.get().getCell( 'comparator_b_rs', CRL.Catalog.State.Views )
    if cell:
        UpdateSession.open()
        cell.destroy()
        UpdateSession.close()
        print( 'Previous <comparator_b_rs> cell destroyed.')

    design = COMPARATOR_B_RS()
    design.build( editor )
    return True

