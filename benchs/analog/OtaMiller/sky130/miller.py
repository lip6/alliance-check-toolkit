##!/usr/bin/python
#
# This file is part of the Coriolis Software.
# Copyright (c) UPMC 2020-2023, All Rights Reserved
#
#
# +-----------------------------------------------------------------+ 
# |             C O R I O L I S   D E S I G N S                     |
# |      A Collection of Analogic Designs Examples                  | 
# |                                                                 |
# |  Author      :               Marie-Minerve Louerat              |
# |  E-mail      :            Jean-Paul.Chaput@lip6.fr              |
# | =============================================================== |
# |  Python      :  "./miller.py"                                   |
# |                                                                 |
# |  Python by Marie-Minerve LOUERAT (February 28, 2019)            |
# |  rev April 2023                                                 |
# +-----------------------------------------------------------------+
#
#
# OTA 2 stage Miller, differential, type N
# Slicing Tree Structure  9 devices and 9 transistors
# Folded transistors
# Routing described
# C for Miller compensation 1st version
# bug in the layout of the capacitor
#
# -----------------------------------------------------------------------------
#                MP3OTA MP4OTA    MP6 MP8  C1a   C2b
#                MN1OTA MN2OTA
#                   MN5OTA        MN7 MN9  C2a   C1b
# -----------------------------------------------------------------------------

import os
import sys
from   coriolis           import Cfg
from   coriolis.Hurricane import *
from   coriolis           import CRL, helpers

#setTraceLevel( 100 )

from coriolis.Analog import Device, Transistor, CommonDrain, CommonGatePair,      \
                            CommonSourcePair, CrossCoupledPair, DifferentialPair, \
                            LevelShifter, SimpleCurrentMirror, CapacitorFamily,   \
                            MultiCapacitor, LayoutGenerator
from coriolis.Bora   import ParameterRange, StepParameterRange, MatrixParameterRange, \
                            SlicingNode, HSlicingNode, VSlicingNode, DSlicingNode,    \
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



class MILLERD ( AnalogDesign ):

    def __init__ ( self ):
        helpers.setTraceLevel( 100 )
        AnalogDesign.__init__( self )
        return

    def build ( self, editor ):
        print( '  o  Running MILLERD.build().')

        twoCapas_2x2 = [ [ 0, 1 ]
                       , [ 1, 0 ]
                       ]

        mrange_1 = MatrixParameterRange()
        mrange_1.addValue( twoCapas_2x2 )




       #    | 0           | 1         | 2               | 3   | 4      |  5    | 6| 7   |8  |9     |10  | 11    |
       #    | Class       | Instance  | Layout Style    | Type| W      |  L    | M| Mint|Dum|SFirst|Bulk| BulkC |
       #    +=============+===========+=================+=====+========+=======+==+=====+===+======+====+=======+
       #    | 0                  | 1         | 2               | 3   | 4             | 5              | 6     |
       #    | Class              | Instance  | Layout Style    | Type| Cs            | Default Matrix | Dummy |
       #    +====================+===========+=================+=====+===============+================+=======+

        self.devicesSpecs = \
          [ [ Transistor  , 'mn1'     , 'WIP Transistor', NMOS, 6.0    , 0.350 , 2, None,  0, True , 0x2, False ]
          , [ Transistor  , 'mn2'     , 'WIP Transistor', NMOS, 6.0    , 0.350 , 2, None,  0, True , 0x2, False ]
          , [ Transistor  , 'mp3'     , 'WIP Transistor', PMOS, 20.0   , 0.350 , 4, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'mp4'     , 'WIP Transistor', PMOS, 20.0   , 0.350 , 4, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'mn5'     , 'WIP Transistor', NMOS, 14.0   , 0.350 , 4, None,  0, True , 0x2, True  ]
          , [ Transistor  , 'mp6'     , 'WIP Transistor', PMOS, 200.0  , 0.350 ,16, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'mn7'     , 'WIP Transistor', NMOS, 30.0   , 0.350 ,10, None,  0, True , 0x2, True  ]
          , [ Transistor  , 'mp8'     , 'WIP Transistor', PMOS, 200.0  , 0.350 ,16, None,  0, True , 0x1, True  ]
          , [ Transistor  , 'mn9'     , 'WIP Transistor', NMOS, 30.0   , 0.350 ,10, None,  0, True , 0x2, True  ]
          , [ MultiCapacitor     , 'MIM_1'   , 'Matrix'        , MIM , (0.13, 0.13)         , twoCapas_2x2    , False ]

          ]

        self.netTypes = \
          { 'ep'    : { 'isExternal':True }
          , 's1b'   : { 'isExternal':False}
          , 'em'    : { 'isExternal':True }
          , 's1a'   : { 'isExternal':False}
          , 'vz'    : { 'isExternal':False}
          , 'sp'    : { 'isExternal':True }
          , 'sm'    : { 'isExternal':True }
          , 'evp1'  : { 'isExternal':True }
          , 'nmc1'  : { 'isExternal':True }
          , 'vdd'   : { 'isExternal':True }
          , 'vss'   : { 'isExternal':True }
            
          }
          
        self.netSpecs = \
          { 'em'     : [ ('mn1' , 'G'), ]
          , 'ep'     : [ ('mn2' , 'G'), ]
          , 's1a'    : [ ('mn1' , 'D'), ('mp3', 'D'), ('mp8', 'G'), ('MIM_1', 't1')]
          , 's1b'    : [ ('mn2' , 'D'), ('mp4', 'D'), ('mp6', 'G'), ('MIM_1', 't0')]
          , 'sp'     : [ ('mn7' , 'D'), ('mp6', 'D'), ('MIM_1', 'b0')]
          , 'sm'     : [ ('mn9' , 'D'), ('mp8', 'D'), ('MIM_1', 'b1')]
          , 'vz'     : [ ('mn5' , 'D'), ('mn1', 'S'), ('mn2', 'S')]
          , 'evp1'   : [ ('mn5' , 'G'), ('mn7', 'G'), ('mn9', 'G')]
          , 'nmc1'   : [ ('mp3' , 'G'), ('mp4', 'G')]
          , 'vdd'    : [ ('mp3' , 'S'), ('mp4', 'S')
                       , ('mp6' , 'S'), ('mp8', 'S')]
          , 'vss'    : [ ('mn1' , 'B'), ('mn2', 'B'), ('mn5', 'S' )
                       , ('mn7' , 'S'), ('mn9', 'S')]
          }

        #self.readParameters( './sizes/ota.txt' )

        self.beginCell( 'millerN' )
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
        self.addDevice( 'mn5'    , Center, StepParameterRange(self.devicesSpecs[4][6], 1, 1) )
        # #3
        self.pushVNode( Center )
        # #4
        self.addSymmetry( 0, 1 )
        self.addDevice( 'mn1' , Center, StepParameterRange(self.devicesSpecs[0][6], 1, 1) )
        self.addDevice( 'mn2' , Center, StepParameterRange(self.devicesSpecs[1][6], 1, 1) )
        # #4
        self.popNode()
        # #3
        self.pushVNode( Center )
        # #4
        self.addSymmetry( 0, 1 )
        self.addDevice( 'mp3' , Center, StepParameterRange(self.devicesSpecs[2][6], 1, 1) )
        self.addDevice( 'mp4' , Center, StepParameterRange(self.devicesSpecs[3][6], 1, 1) )
        self.popNode()
        # #3
        self.popNode()

        # #2
        self.pushHNode( Center )
        # #3
        self.pushVNode( Center )
        # #4
        self.addSymmetry( 0, 1 )
        self.addDevice( 'mn7' , Center, StepParameterRange(self.devicesSpecs[6][6], 1, 1) )
        self.addDevice( 'mn9' , Center, StepParameterRange(self.devicesSpecs[8][6], 1, 1) )
        # #4
        self.popNode()
        # #3
        self.pushVNode( Center )
        # #4
        self.addSymmetry( 0, 1 )
        self.addDevice( 'mp6' , Center, StepParameterRange(self.devicesSpecs[5][6], 1, 1) )
        self.addDevice( 'mp8' , Center, StepParameterRange(self.devicesSpecs[7][6], 1, 1) )
        self.popNode()
        # #3
        self.popNode()
        # #2
        self.addDevice( 'MIM_1', Center, mrange_1 )
        # #2
        self.popNode()
        # #1

        self.addHRail( self.getNet('vdd'), 'METAL4', 2, "CH2", "IH2" )

        self.popNode()
        # # #0

        self.endSlicingTree()
    
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

    cell = CRL.AllianceFramework.get().getCell( 'millerN', CRL.Catalog.State.Views )
    if cell:
        UpdateSession.open()
        cell.destroy()
        UpdateSession.close()
        print( 'Previous <millerN> cell destroyed.')

    design = MILLERD()
    design.build( editor )
    return True

