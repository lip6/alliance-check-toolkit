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
# |  Sizes       :      made with Oceane, jacky.porte@lip6.fr       |
# | =============================================================== |
# |  Python      :  "./doOta.py"                                    |
# |                                                                 |
# |  Python by Marie-Minerve LOUERAT (January 9, 2023)              |
# |  10 January 2023                                                |
# |  1 June     2023  technology migration                          |
# |  12 January 2024  get sizes from a csv file                     |
# |  15 January 2024  adjust layout parameters  BulkC               |
# |  16 January 2024  adjust parameter names, not conficting, units |
# +-----------------------------------------------------------------+
#
#
# OTA 1 stage, non differential, type N
# Slicing Tree Structure 5 devices and 5 transistors
# The differential input pair mn1 and mn2 has, in general, bulk connected at VSS and source connected to MN5 drain
# It requires transistor BULK-SOURCE unconnected (BULKC = FALSE)
# Folded transistors
# Routing described
# Names and values retrieved from a csv file, maybe an output of oceane
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
import pandas as pd
import numpy as np


# helpers.setTraceLevel( 100 )

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

# define the file where the parameters are provided by the sizing operation oceane_sizes.txt
# reads the parameters from the file, csv format
# in this file, the table shows the transistor finger width WF in MICRONS
# base=pd.read_csv('oceane_sizes.txt', sep=' ', skipinitialspace=True, encoding="utf-8", dtype={'L': np.float64})
base=pd.read_csv('oceane_sizes.txt', sep=' ', skipinitialspace=True, encoding="utf-8")

# define the list of transistors used in the layout description
all_transistor = ['mn1', 'mn2', 'mp3', 'mp4', 'mn5']
all_transistor_base = base['Name'].tolist()
print(all_transistor_base)

# describe the circuit for layout generation
class OTAS ( AnalogDesign ):

    def __init__ ( self ):
        AnalogDesign.__init__( self )
        return

    def build ( self, editor ):
        print( '  o  Running OTAS.build().')
       
       # device parameter list
       # in this list, the transistor width is the total transistor width (WF*M), in micro meter

       #    | 0           | 1         | 2               | 3   | 4      |  5    | 6| 7   |8  |9     |10  | 11    |
       #    | Class       | Instance  | Layout Style    | Type| W      |  L    | M| Mint|Dum|SFirst|Bulk| BulkC |
       #    +=============+===========+=================+=====+========+=======+==+=====+===+======+====+=======+
       # self.devicesSpecs = \
       #   [ [ Transistor  , 'mn1'     , 'WIP Transistor', NMOS, 6.0    , 0.350 , 2, None,  0, True , 0x1, False ]
       #   , [ Transistor  , 'mn2'     , 'WIP Transistor', NMOS, 6.0    , 0.350 , 2, None,  0, True , 0x1, False ]
       #   , [ Transistor  , 'mp3'     , 'WIP Transistor', PMOS, 20.0   , 0.350 , 4, None,  0, True , 0xf, True  ]
       #   , [ Transistor  , 'mp4'     , 'WIP Transistor', PMOS, 20.0   , 0.350 , 4, None,  0, True , 0xf, True  ]
       #   , [ Transistor  , 'mn5'     , 'WIP Transistor', NMOS, 14.0   , 0.350 , 4, None,  0, True , 0xf, True  ]
       #   ]

        self.devicesSpecs =  []

        for transistor in all_transistor:
            if transistor in all_transistor_base:

                print(transistor, 'is present in the code and in the parameters base.')

                name = base.loc[base['Name']==transistor, 'Name'].to_string(index=False)
                print('type name', type(name))
                print(name)

                typeMOS = base.loc[base['Name']==transistor, 'TMOS'].to_string(index=False)
                if   typeMOS == 'NMOS': value = Transistor.NMOS
                elif typeMOS == 'PMOS': value = Transistor.PMOS
                print('type(typeMOS)',typeMOS,type(value),value)
                print(type(typeMOS),typeMOS,type(value),value)

                # reading the transistor finger width in micron
                # WF = float(base.loc[base['Name']==transistor, 'WF'].to_string(index=False))*(10**6)
                WF = float(base.loc[base['Name']==transistor, 'WF'].to_string(index=False))
                print('type WF', type(WF))
                print(WF)

                # L = float(base.loc[base['Name']==transistor, 'L'].to_string(index=False))*(10**6)
                L = float(base.loc[base['Name']==transistor, 'L'].to_string(index=False))
                print('type L', type(L))
                print(L)

                M = int(base.loc[base['Name']==transistor, 'M'].to_string(index=False))
                print('type M', type(M))
                print(M)

                # BulkC =(base.loc[base['Name']==transistor, 'BulkC'].bool())
                # BulkC = base.loc[base['Name']==transistor, 'BulkC'].to_string(index=False)
                BulkSource = base.loc[base['Name']==transistor, 'BScon'].to_string(index=False)
                if   BulkSource == 'True' : BulkC = True
                elif BulkSource == 'False': BulkC = False
                print('type BulkC', type(BulkC))
                print(BulkC)

                #                         | Class | Instance | Layout Style | Type | W | L | M | Mint | Dum | SFirst | Bulk | BulkC |
                # self.devicesSpecs.append([Transistor, name, 'WIP Transistor',  type, WF*M, L, 1, None, 0, True, 0xf, False])
                # computing the whole transistor width from finger width and number of fingers

                self.devicesSpecs.append([Transistor, name, 'WIP Transistor',  value, WF*M, L, M, None, 0, True, 0xf, BulkC])
                print(name, typeMOS,  WF, WF*M, L, M, BulkC)
                print(self.devicesSpecs)

            else:
                # checking if transistor parameters are provided in the file
                print('ERROR:', transistor, 'is not present in the parameters base.')
                sys.exit( 1 )

        for transistor_base in all_transistor_base:
            # checking if transistor name of the file is in the transistor list
            if transistor_base not in all_transistor:
                print('ERROR:', transistor_base, 'is present in the parameters base only and not in the code.')
                sys.exit( 1 )
            else:
                pass


        # adjusting the bulk termianl of mn1 and mn2, south side of the transistor is used
        print(self.devicesSpecs[0][1], 'Bulk', self.devicesSpecs[0][10])
        self.devicesSpecs[0][10]=2
        print(self.devicesSpecs[0][1], 'Bulk', self.devicesSpecs[0][10])

        print(self.devicesSpecs[1][1], 'Bulk', self.devicesSpecs[1][10])
        self.devicesSpecs[1][10]=2
        print(self.devicesSpecs[1][1], 'Bulk', self.devicesSpecs[1][10])
        

        # describing the terminals, the external ones are not used today
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
          
        # decribing the nets, using instances and internal terminals
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

        # building the cell, instances and nets
        self.beginCell( 'otasimple' )
        self.doDevices()
        self.doNets   ()
    
        # describing the slicing tree
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
        # # mn5
        # self.addDevice( 'mn5'    , Center, StepParameterRange(2, 2, 4) )
        # self.addDevice( 'mn5'    , Center, StepParameterRange(self.devicesSpecs[4][6], 2, 4) )
        self.addDevice( self.devicesSpecs[4][1]   , Center, StepParameterRange(self.devicesSpecs[4][6], 2, 4) )
        print(self.devicesSpecs[4][1], 'M',self.devicesSpecs[4][6])
        # #3
        self.pushVNode( Center )
        # #4
        # # mn1 and mn2
        self.addSymmetry( 0, 1 )
        # self.addDevice( 'mn1' , Center, StepParameterRange(2, 1, 1) )
        # self.addDevice( 'mn1' , Center, StepParameterRange(int (base.loc[base['Name']=='mn1', 'M'].to_string(index=False)), 1, 1) )
        self.addDevice( 'mn1' , Center, StepParameterRange(self.devicesSpecs[0][6], 1, 1) )
        # print('M(mn1)= ', int (base.loc[base['Name']=='mn1', 'M'].to_string(index=False)))
        print(self.devicesSpecs[0][1], 'M', self.devicesSpecs[0][6])

        # self.addDevice( 'mn2' , Center, StepParameterRange(2, 1, 1) )
        self.addDevice( 'mn2' , Center, StepParameterRange(self.devicesSpecs[1][6], 1, 1) )
        print(self.devicesSpecs[1][1], 'M',self.devicesSpecs[1][6])

        # #4
        self.popNode()
        # #3
        self.pushVNode( Center )
        # #4
        # # mp3 and mp4
        self.addSymmetry( 0, 1 )
        # self.addDevice( 'mp3' , Center, StepParameterRange(2, 2, 4) )
        self.addDevice( 'mp3' , Center, StepParameterRange(self.devicesSpecs[2][6], 2, 4) )
        print(self.devicesSpecs[2][1], 'M',self.devicesSpecs[2][6])
        # self.addDevice( 'mp4' , Center, StepParameterRange(2, 2, 4) )
        self.addDevice( 'mp4' , Center, StepParameterRange(self.devicesSpecs[3][6], 2, 4) )
        print(self.devicesSpecs[3][1], 'M',self.devicesSpecs[3][6])
        self.popNode()
        # #3
        self.popNode()
        # #2
        self.popNode()
        # #1
        self.addHRail( self.getNet('vdd'), 'METAL4', 2, "CH2", "IH2" )
        self.popNode()
        # #0
        # select the index of the layout shapes which is displayed, can be changed in cgt
        self.updatePlacement(7)
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

