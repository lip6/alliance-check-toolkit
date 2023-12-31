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
# |  Python      :  "./ota.py"                                      |
# |                                                                 |
# |  Python by Marie-Minerve LOUERAT (January 9, 2023)              |
# |  10 January 2023                                                |
# |  1 June     2023  technology migration                          |
# +-----------------------------------------------------------------+
#
#
# OTA 1 stage, non differential, type N
# Slicing Tree Structure 5 devices and 5 transistors
# The differential input pair mn1 and mn2 has, in general, bulk connected at VSS and source connected to MN5 drain
# It requires transistor BULK-SOURCE unconnected (BULKC = FALSE)
# Folded transistors
# Routing described
#
# -----------------------------------------------------------------------------
#                MP3 MP4    
#                MN1 MN2
#                  MN5       
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



class OTAS ( AnalogDesign ):

    def __init__ ( self ):
        AnalogDesign.__init__( self )
        return

    def build ( self, editor ):
        print( '  o  Running OTAS.build().')

       #    | 0           | 1         | 2               | 3   | 4      |  5    | 6| 7   |8  |9     |10  | 11    |
       #    | Class       | Instance  | Layout Style    | Type| W      |  L    | M| Mint|Dum|SFirst|Bulk| BulkC |
       #    +=============+===========+=================+=====+========+=======+==+=====+===+======+====+=======+
        self.devicesSpecs = \
          [ [ Transistor  , 'mn1'     , 'WIP Transistor', NMOS, 6.0    , 0.350 , 2, None,  0, True , 0x1, False ]
          , [ Transistor  , 'mn2'     , 'WIP Transistor', NMOS, 6.0    , 0.350 , 2, None,  0, True , 0x1, False ]
          , [ Transistor  , 'mp3'     , 'WIP Transistor', PMOS, 20.0   , 0.350 , 4, None,  0, True , 0xf, True  ]
          , [ Transistor  , 'mp4'     , 'WIP Transistor', PMOS, 20.0   , 0.350 , 4, None,  0, True , 0xf, True  ]
          , [ Transistor  , 'mn5'     , 'WIP Transistor', NMOS, 14.0   , 0.350 , 4, None,  0, True , 0xf, True  ]
          ]

        self.netTypes = \
          { 'ep'    : { 'isExternal':True }
          , 'em'    : { 'isExternal':True }
          , 's1a'   : { 'isExternal':False}
          , 'vz'    : { 'isExternal':False}
          , 'sp'    : { 'isExternal':True }
          , 'evp1'  : { 'isExternal':True }
          , 'nmc1'  : { 'isExternal':True }
          , 'vdd'   : { 'isExternal':True }
          , 'vss'   : { 'isExternal':True }
            
          }
          
        self.netSpecs = \
          { 'ep'     : [ ('mn1' , 'G')]
          , 'em'     : [ ('mn2' , 'G')]
          , 's1a'    : [ ('mn1' , 'D'), ('mp3', 'D'), ('mp3', 'G'), ('mp4', 'G')]
          , 'sp'     : [ ('mn2' , 'D'), ('mp4', 'D')]
          , 'vz'     : [ ('mn5' , 'D'), ('mn1', 'S'), ('mn2', 'S')]
          , 'evp1'   : [ ('mn5' , 'G')]
          , 'vdd'    : [ ('mp3' , 'S'), ('mp4', 'S')]
          , 'vss'    : [ ('mn1' , 'B'), ('mn2', 'B'), ('mn5', 'S' )]
          }

        #self.readParameters( './sizes/ota.txt' )

        self.beginCell( 'otasimple' )
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
        self.addDevice( 'mn5'    , Center, StepParameterRange(2, 2, 4) )
        # #3
        self.pushVNode( Center )
        # #4
        self.addSymmetry( 0, 1 )
        self.addDevice( 'mn1' , Center, StepParameterRange(2, 1, 1) )
        self.addDevice( 'mn2' , Center, StepParameterRange(2, 1, 1) )
        # #4
        self.popNode()
        # #3
        self.pushVNode( Center )
        # #4
        self.addSymmetry( 0, 1 )
        self.addDevice( 'mp3' , Center, StepParameterRange(2, 2, 4) )
        self.addDevice( 'mp4' , Center, StepParameterRange(2, 2, 4) )
        self.popNode()
        # #3
        self.popNode()
        # #2
        self.popNode()
        # #1
        self.addHRail( self.getNet('vdd'), 'METAL4', 2, "CH2", "IH2" )
        self.popNode()
        # #0
        self.updatePlacement(3)
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

    cell = CRL.AllianceFramework.get().getCell( 'otasimple', CRL.Catalog.State.Views )
    if cell:
        UpdateSession.open()
        cell.destroy()
        UpdateSession.close()
        print( 'Previous <otasimple> cell destroyed.')

    design = OTAS()
    design.build( editor )
    return True

