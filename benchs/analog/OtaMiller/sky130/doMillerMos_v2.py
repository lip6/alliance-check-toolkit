##!/usr/bin/python
#
# This file is part of the Coriolis Software.
# Copyright (c) UPMC 2020-2024, All Rights Reserved
#
#
# +-----------------------------------------------------------------+ 
# |             C O R I O L I S   D E S I G N S                     |
# |      A Collection of Analogic Designs Examples                  | 
# |                                                                 |
# |  Author      :               Marie-Minerve Louerat              |
# |  E-mail      :            Jean-Paul.Chaput@lip6.fr              |
# | =============================================================== |
# |  Python      :  "./doMillerMos_2.py"                            |
# |                                                                 |
# |  Python by Marie-Minerve LOUERAT (February 28, 2019)            |
# |  rev April 2023                                                 |
# |  rev June 2023                                                  |
# |  rev November 2023                                              |
# |  rev January 2024 : reading sizes and layout info from CSV file |
# |                     adding little examples to set/get           |
# |                     to be clarified                             |
# |                     device parameters from the DevicesSpecs     |
# |                     slicing tree to match PMOS transistors      |
# |                     slicing tree showing Pareto front           |
# |                     to be combined with M update and resizing   |
# +-----------------------------------------------------------------+
#
#
# OTA 2 stage Miller, differential, type N
# Slicing Tree Structure  9 devices and 9 transistors
# Folded transistors
# Routing described
# NO C for Miller compensation 1st version
# bug in the layout of the capacitor in sky130
#
# -----------------------------------------------------------------------------
#                MP3 MP4    MP6 MP8  
#                MN1 MN2
#                  MN5      MN7 MN9 
# -----------------------------------------------------------------------------

import os
import sys
from   coriolis            import Cfg
from   coriolis.Hurricane  import *
from   coriolis            import CRL, helpers
from   coriolis.helpers    import l, u, n
from   coriolis.helpers.io import catch
import pandas as pd

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


# define the file where the parameters are provided by the sizing operation oceane_sizes.txt
# reads the parameters from the file, csv format
# in this file, the table shows the transistor finger width WF in MICRONS
base=pd.read_csv('oceane_sizes.txt', sep=' ', skipinitialspace=True, encoding="utf-8")

# define the list of transistors used in the layout description
# IMPORTANT : the order in the list will define the index of the device
# in the devicesSpecs table
# the order may be different in the csv table
# transistor index  0      1      2      3      4      5       6      7      8
all_transistor = ['mn1', 'mn2', 'mp3', 'mp4', 'mn5', 'mp6',  'mn7', 'mp8', 'mn9']
all_transistor_base = base['Name'].tolist()
print(all_transistor_base)

def toMicrons ( u ): return DbU.toPhysical( u, DbU.UnitPowerMicro )


# describe the circuit for layout generation
class MILLERD ( AnalogDesign ):

    def __init__ ( self ):
        # helpers.setTraceLevel( 100 )
        AnalogDesign.__init__( self )
        return

    def build ( self, editor ):
        print( '  o  Running MILLERD.build().')

       # device parameter list
       # in this list, the transistor width is the total transistor width (WF*M), in micro meter

       #    | 0           | 1         | 2               | 3   | 4      |  5    | 6| 7   |8  |9     |10  | 11    |
       #    | Class       | Instance  | Layout Style    | Type| W      |  L    | M| Mint|Dum|SFirst|Bulk| BulkC |
       #    +=============+===========+=================+=====+========+=======+==+=====+===+======+====+=======+
       #    | 0                  | 1         | 2               | 3   | 4             | 5              | 6     |
       #    | Class              | Instance  | Layout Style    | Type| Cs            | Default Matrix | Dummy |
       #    +====================+===========+=================+=====+===============+================+=======+

       # self.devicesSpecs = \
       #   [ [ Transistor    , 'mn1'     , 'WIP Transistor', NMOS, 6.0    , 0.350 , 2, None,  0, True , 0x2, False ]
       #   , [ Transistor    , 'mn2'     , 'WIP Transistor', NMOS, 6.0    , 0.350 , 2, None,  0, True , 0x2, False ]
       #   , [ Transistor    , 'mp3'     , 'WIP Transistor', PMOS, 20.0   , 0.350 , 4, None,  0, True , 0x1, True  ]
       #   , [ Transistor    , 'mp4'     , 'WIP Transistor', PMOS, 20.0   , 0.350 , 4, None,  0, True , 0x1, True  ]
       #   , [ Transistor    , 'mn5'     , 'WIP Transistor', NMOS, 14.0   , 0.350 , 4, None,  0, True , 0x2, True  ]
       #   , [ Transistor    , 'mp6'     , 'WIP Transistor', PMOS, 200.0  , 0.350 ,16, None,  0, True , 0x1, True  ]
       #   , [ Transistor    , 'mn7'     , 'WIP Transistor', NMOS, 30.0   , 0.350 ,10, None,  0, True , 0x2, True  ]
       #   , [ Transistor    , 'mp8'     , 'WIP Transistor', PMOS, 200.0  , 0.350 ,16, None,  0, True , 0x1, True  ]
       #   , [ Transistor    , 'mn9'     , 'WIP Transistor', NMOS, 30.0   , 0.350 ,10, None,  0, True , 0x2, True  ]
       #  ]

        self.devicesSpecs =  []

        for transistor in all_transistor:
            if transistor in all_transistor_base:
                
                print(transistor, 'is present in the code and in the parameters base.')

                # reading Transistor Name
                name = base.loc[base['Name']==transistor, 'Name'].to_string(index=False)
                print('type name', type(name))
                print(name)

                # reading transistor type, consistent with Coriolis Transistor class
                typeMOS = base.loc[base['Name']==transistor, 'TMOS'].to_string(index=False)
                if   typeMOS == 'NMOS': value = Transistor.NMOS
                elif typeMOS == 'PMOS': value = Transistor.PMOS
                print('type(typeMOS)',typeMOS,type(value),value)
                print(type(typeMOS),typeMOS,type(value),value)

                # reading the transistor finger width in micron
                WF = float(base.loc[base['Name']==transistor, 'WF'].to_string(index=False))
                print('type WF', type(WF))
                print(WF)

                # reading the transistor length in micron
                L = float(base.loc[base['Name']==transistor, 'L'].to_string(index=False))
                print('type L', type(L))
                print(L)
 
                # reading the transistor folds integer 
                M = int(base.loc[base['Name']==transistor, 'M'].to_string(index=False))
                print('type M', type(M))
                print(M)

                # BulkC =(base.loc[base['Name']==transistor, 'BulkC'].bool())
                # BulkC = base.loc[base['Name']==transistor, 'BulkC'].to_string(index=False)
                # This parameters specifies if the bulk of the transistor is connected to the source (internally) or not
                # BulkC= True means that Bulk is connected to the source, the device has 3 (D, G, S) external terminals
                # BulkC= False means that Bulk is NOT connected internally to the source, the device has 4 (D, G, S, B) external terminals
                # The technology process may set constraints on possible connections
                # NB. Electrical sizing and netlist should be set accordingly
                BulkSource = base.loc[base['Name']==transistor, 'BScon'].to_string(index=False)
                if   BulkSource == 'True' : BulkC = True
                elif BulkSource == 'False': BulkC = False
                print('type BulkC', type(BulkC))
                print(BulkC)

                #                         | Class | Instance | Layout Style | Type | W | L | M | Mint | Dum | SFirst | Bulk | BulkC |
                # computing the whole transistor width from finger width and number of fingers
                # Bulk = 0xf means guard ring, 4 side bulk connected around active

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

        # adjusting the bulk terminal, north/south side of the transistor is used
        # mn1
        print(self.devicesSpecs[0][1], 'Bulk', self.devicesSpecs[0][10])
        self.devicesSpecs[0][10]=2
        print(self.devicesSpecs[0][1], 'Bulk', self.devicesSpecs[0][10])

        # mn2
        print(self.devicesSpecs[1][1], 'Bulk', self.devicesSpecs[1][10])
        self.devicesSpecs[1][10]=2
        print(self.devicesSpecs[1][1], 'Bulk', self.devicesSpecs[1][10])


        # describing the terminals, the external ones are not used today

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
          
        # decribing the nets, using instances and internal terminals
        # taking into account 3 or 4 terminals for Transistors

        self.netSpecs = \
          { 'em'     : [ ('mn1' , 'G'), ]
          , 'ep'     : [ ('mn2' , 'G'), ]
          , 's1a'    : [ ('mn1' , 'D'), ('mp3', 'D'), ('mp8', 'G')]
          , 's1b'    : [ ('mn2' , 'D'), ('mp4', 'D'), ('mp6', 'G')]
          , 'sp'     : [ ('mn7' , 'D'), ('mp6', 'D') ]
          , 'sm'     : [ ('mn9' , 'D'), ('mp8', 'D') ]
          , 'vz'     : [ ('mn5' , 'D'), ('mn1', 'S'), ('mn2', 'S')]
          , 'evp1'   : [ ('mn5' , 'G'), ('mn7', 'G'), ('mn9', 'G')]
          , 'nmc1'   : [ ('mp3' , 'G'), ('mp4', 'G')]
          , 'vdd'    : [ ('mp3' , 'S'), ('mp4', 'S')
                       , ('mp6' , 'S'), ('mp8', 'S')]
          , 'vss'    : [ ('mn1' , 'B'), ('mn2', 'B'), ('mn5', 'S' )
                       , ('mn7' , 'S'), ('mn9', 'S')]
          }


        # building the cell, instances and nets

        self.beginCell( 'millerN' )
        self.doDevices()
        self.doNets   ()

        # Varuious examples to show how to access/modify Transistor/Device parameters
        # To read devices parameters from the AnalogDesign DeviceSpec table.
        mn5_W = self.getTransW( 'mn5' )
        print( '1: mn5 W = {}'.format( mn5_W ))

        # To read/set devices parameters directly from the device itself.
        # W parameter, reading.
        mn5 = self.getDevice( 'mn5' )
        print( '2: mn5 = {}'.format( mn5 ))
        print( '3: mn5.W = {}'.format( mn5.getParameter('W') ))
        print( '4: mn5.W = {}'.format( toMicrons( mn5.getParameter('W').getValue() )))

        # W parameter, setting (then reading again).
        mn5.getParameter( "W" ).setValue( u(10.0) )
        print( '5: mn5.W = {}'.format( toMicrons( mn5.getParameter('W').getValue() )))
        # M parameter.
        print( '6: mn5.M = {}'.format( mn5.getParameter('W') ))
        print( '7: mn5.M = {}'.format( mn5.getParameter('M').getValue() ))
        # M parameter, setting.
        mn5.getParameter( "M" ).setValue( 2 )
        print( '8: mn5.M = {}'.format( mn5.getParameter('M').getValue() ))
        # Check: this will raise an exception as MIM_1 is obviously not a transistor.
        #mim1_W = self.getTransW( 'MIM_1' )

        # To read devices parameters from the device.
        mn5_W = self.getDTransW( 'mn5' )
        print( '9: mn5.W = {}'.format( mn5_W ))
 
        # To set


        # Check: this will raise an exception as MIM_1 is obvioulsly not a transistor.
        #mim1_W = self.getDTransW( 'MIM_1' )
        #mim1_Cs = self.getDCapaC( 'MIM_1' )
        #print( 'mimi1_Cs = {}'.format( mim1_Cs ))
    
        # describing the slicing tree
        self.beginSlicingTree()
        self.setToleranceRatioH( 1000000000.0 )
        self.setToleranceRatioW( 1000000000.0 )
        self.setToleranceBandH ( 1000000000.0 )
        self.setToleranceBandW ( 1000000000.0 )

        # #0 level in the slicing tree
        self.pushHNode( Center )
        # #1

        # #horizontal power rail VSS
        self.addHRail( self.getNet('vss'), 'METAL4', 2, "CH1", "IH1" )

        # #1
        self.pushVNode( Center )

        # #2
        self.pushHNode( Center )
        # #3
        # mn5 
        print( '10: mn5.W = {}'.format( toMicrons( mn5.getParameter('W').getValue() )))
        print( '11: mn5.M = {}'.format(            mn5.getParameter('M').getValue() ))
        print('transistor devicesSpecs', self.devicesSpecs[4][1], 'M', self.devicesSpecs[4][6])
        print('transistor devicesSpecs', self.devicesSpecs[4][1], 'Wtotal', self.devicesSpecs[4][4])


        self.addDevice( self.devicesSpecs[4][1], Center, StepParameterRange(2, 2, self.devicesSpecs[4][6]/2,) )
        # #3
        self.pushVNode( Center )
        # #4
        # mn1 and mn2
        self.addSymmetry( 0, 1 )
        # mn1
        self.addDevice( self.devicesSpecs[0][1] , Center, StepParameterRange(self.devicesSpecs[0][6], 1, 1) )
        # mn2
        self.addDevice( self.devicesSpecs[1][1] , Center, StepParameterRange(self.devicesSpecs[1][6], 1, 1) )
        # #4
        self.popNode()
        # #3
        self.popNode()
        # #2
        # mn7 and mn9
        self.addSymmetry( 1, 2 )
        m7_9_max = self.devicesSpecs[6][6]
        m7_9_init = 2
        m7_9_incr = 2
        m7_9_iter = round((m7_9_max - m7_9_init)/m7_9_incr)
        print('m7_9_init' , m7_9_init , 'm7_9_incr' , m7_9_incr , 'm7_9_iter', m7_9_iter , 'm7_9_max' , m7_9_max)
        # mn7
        self.addDevice( self.devicesSpecs[6][1] , Center, StepParameterRange(m7_9_init,m7_9_incr, m7_9_iter) )
        # mn9
        self.addDevice( self.devicesSpecs[8][1] , Center, StepParameterRange(m7_9_init, m7_9_incr, m7_9_iter) )

        self.popNode()
        # #1

        self.pushVNode( Center )

        # #2
        # mp3 and mp4
        self.addSymmetry( 0, 1 )
        # mp3
        self.addDevice( self.devicesSpecs[2][1] , Center, StepParameterRange(1,1,self.devicesSpecs[2][6]) )
        # mp4
        self.addDevice( self.devicesSpecs[3][1] , Center, StepParameterRange(1,1,self.devicesSpecs[3][6]) )
        self.addSymmetry( 2, 3 )
        # mp6
        self.addDevice( self.devicesSpecs[5][1], Center, StepParameterRange(self.devicesSpecs[5][6]/4,5,4) )
        # mp8
        self.addDevice( self.devicesSpecs[7][1] , Center, StepParameterRange(self.devicesSpecs[7][6]/4,5,4) )
 

        # #2
        self.popNode()
        # #1

        # #horizontal power rail VDD
        self.addHRail( self.getNet('vdd'), 'METAL4', 2, "CH2", "IH2" )

        self.popNode()
        # # #0

        self.endSlicingTree()
    
        # self.updatePlacement(  0 )
        self.endCell()
        print( '12: mn5.W = {}'.format( toMicrons( mn5.getParameter('W').getValue() )))
        print( '13: mn5.M = {}'.format(            mn5.getParameter('M').getValue() ))
    
        if editor:
          editor.setCell( self.cell )
          editor.fit()
        return


def scriptMain ( **kw ):
    rvalue = True
    try:
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
    except Exception as e:
        catch( e ) 
        rvalue = False
    sys.stdout.flush()
    sys.stderr.flush()
    return rvalue

