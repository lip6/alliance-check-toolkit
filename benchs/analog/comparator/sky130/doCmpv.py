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
# |  Python      :  "./doCmpv.py"                                   |
# |                                                                 |
# |  Layout of the synchronous compact voltage comparator           |
# |                                                                 |
# |  Python by Marie-Minerve LOUERAT (march 5, 2024)                |
# |         reading sizes and layout info from CSV file             |
# +-----------------------------------------------------------------+
#
#
# Synchronous comparator
# Sizes provided by Oceane
# Type N
# 4 NMOS and 4 PMOS structure
# Slicing Tree Structure 
# Routing described
#
# -----------------------------------------------------------------------------
#          MP15 MP11 MP12 MP16    
#                MN5 MN6
#                MN1 MN2
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

# define the file where the inputfile name is provided

#oceane_cmpv10.txt  where the parameters are provided by the sizing operation of oceane with 10Mhz specification
#oceane_cmpv50.txt  where the parameters are provided by the sizing operation of oceane with 50Mhz specification
#oceane_cmpv100.txt where the parameters are provided by the sizing operation of oceane with 100Mhz specification

inputTable=pd.read_csv('inputfile.txt', sep =' ', skipinitialspace=True, encoding="utf8")
print('here-------------------')

sizeName = inputTable.loc[[0], 'inputFileName'].to_string(index=False)
print('there ------------------')
print('type =', type(sizeName))
print('sizeName = ', sizeName)

sliceNumber = eval(inputTable.loc[[0], 'slices'].to_string(index=False))
print('here and there ------------------')
print('type =', type(sliceNumber))
print('sliceNumber= ', sliceNumber)

# define the file where the parameters are provided by the sizing operation oceane_cmpv10.txt
# reads the parameters from the file, csv format
# in this file, the table shows the transistor finger width WF in MICRONS
# sizeName is given in the inputfile.txt file
base=pd.read_csv(sizeName, sep=' ', skipinitialspace=True, encoding="utf-8")


# define the list of transistors used in the layout description
# IMPORTANT : the order in the list will define the index of the device
# in the devicesSpecs table
# the order may be different in the csv table
# transistor index  0      1      2      3      4       5        6       7   
all_transistor = ['mn1', 'mn2', 'mn5', 'mn6', 'mp11', 'mp12',  'mp15', 'mp16']
all_transistor_base = base['Name'].tolist()
print(all_transistor_base)

def toMicrons ( u ): return DbU.toPhysical( u, DbU.UnitPowerMicro )


# describe the circuit for layout generation
class CMPV ( AnalogDesign ):

    def __init__ ( self ):
        # helpers.setTraceLevel( 100 )
        AnalogDesign.__init__( self )
        return

    def build ( self, editor ):
        print( '  o  Running CMPV.build().')

       # device parameter list
       # in this list, the transistor width is the total transistor width (WF*M), in micro meter

       #    | 0           | 1         | 2               | 3   | 4      |  5    | 6| 7   |8  |9     |10  | 11    |
       #    | Class       | Instance  | Layout Style    | Type| W      |  L    | M| Mint|Dum|SFirst|Bulk| BulkC |
       #    +=============+===========+=================+=====+========+=======+==+=====+===+======+====+=======+

       # self.devicesSpecs = \
       #   [ [ Transistor    , 'mn1'   , 'WIP Transistor', NMOS, 0.42   , 0.350 , 1, None,  0, True , 0x2, True ]
       #   , [ Transistor    , 'mn2'   , 'WIP Transistor', NMOS, 0.42   , 0.350 , 1, None,  0, True , 0x2, True ]
       #   , [ Transistor    , 'mn5'   , 'WIP Transistor', NMOS, 0.42   , 0.350 , 1, None,  0, True , 0x2, False ]
       #   , [ Transistor    , 'mn6'   , 'WIP Transistor', NMOS, 0.42   , 0.350 , 1, None,  0, True , 0x2, False ]
       #   , [ Transistor    , 'mp11'  , 'WIP Transistor', PMOS, 0.42   , 0.350 , 1, None,  0, True , 0x1, True  ]
       #   , [ Transistor    , 'mp12'  , 'WIP Transistor', PMOS, 0.42   , 0.350 , 1, None,  0, True , 0x1, True  ]
       #   , [ Transistor    , 'mp15'  , 'WIP Transistor', PMOS, 0.42   , 0.350 , 1, None,  0, True , 0x1, True  ]
       #   , [ Transistor    , 'mp16'  , 'WIP Transistor', PMOS, 0.42   , 0.350 , 1, None,  0, True , 0x1, True  ]
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
                WF = eval(base.loc[base['Name']==transistor, 'WF'].to_string(index=False))
                print('type WF', type(WF))
                print(WF)

                # reading the transistor length in micron
                L = eval(base.loc[base['Name']==transistor, 'L'].to_string(index=False))
                print('type L', type(L))
                print(L)
 
                # reading the transistor folds integer 
                M = eval(base.loc[base['Name']==transistor, 'M'].to_string(index=False))
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
        # south for NMOS
        # north for PMOS
        # trying to improve symmetry for matching, by choosing
        # Source First False for transistor with odd name (nm1, nm5, mp11, mp15)
        # Source First True for transistor with even name (nm2, nm6, mp12, mp16)
        # mn1
        print(self.devicesSpecs[0][1], 'Bulk', self.devicesSpecs[0][10])
        self.devicesSpecs[0][10]=2
        print(self.devicesSpecs[0][1], 'Bulk', self.devicesSpecs[0][10])
        self.devicesSpecs[0][9]= False

        # mn2
        print(self.devicesSpecs[1][1], 'Bulk', self.devicesSpecs[1][10])
        self.devicesSpecs[1][10]=2
        print(self.devicesSpecs[1][1], 'Bulk', self.devicesSpecs[1][10])
        self.devicesSpecs[1][9]= True

        # mn5
        print(self.devicesSpecs[2][1], 'Bulk', self.devicesSpecs[2][10])
        self.devicesSpecs[2][10]=2
        print(self.devicesSpecs[2][1], 'Bulk', self.devicesSpecs[2][10])
        self.devicesSpecs[2][9]= False

        #mn6
        print(self.devicesSpecs[3][1], 'Bulk', self.devicesSpecs[3][10])
        self.devicesSpecs[3][10]=2
        print(self.devicesSpecs[3][1], 'Bulk', self.devicesSpecs[3][10])
        self.devicesSpecs[3][9]= True

        # mp11
        print(self.devicesSpecs[4][1], 'Bulk', self.devicesSpecs[4][10])
        self.devicesSpecs[4][10]=1
        print(self.devicesSpecs[4][1], 'Bulk', self.devicesSpecs[4][10])
        self.devicesSpecs[4][9]= False

        # mp12
        print(self.devicesSpecs[5][1], 'Bulk', self.devicesSpecs[5][10])
        self.devicesSpecs[5][10]=1
        print(self.devicesSpecs[5][1], 'Bulk', self.devicesSpecs[5][10])
        self.devicesSpecs[5][9]= True

        # mp15
        print(self.devicesSpecs[6][1], 'Bulk', self.devicesSpecs[6][10])
        self.devicesSpecs[6][10]=1
        print(self.devicesSpecs[6][1], 'Bulk', self.devicesSpecs[6][10])
        self.devicesSpecs[6][9]= False

        # mp16
        print(self.devicesSpecs[7][1], 'Bulk', self.devicesSpecs[7][10])
        self.devicesSpecs[7][10]=1
        print(self.devicesSpecs[7][1], 'Bulk', self.devicesSpecs[7][10])
        self.devicesSpecs[7][9]= True


        # describing the terminals, the external ones are not used today

        self.netTypes = \
          { 'ep'    : { 'isExternal':True }
          , 'er'    : { 'isExternal':True }
          , 'ck'    : { 'isExternal':True }
          , 'd1'    : { 'isExternal':False}
          , 'd2'    : { 'isExternal':False}
          , 'qp'    : { 'isExternal':True }
          , 'qm'    : { 'isExternal':True }
          , 'vdd'   : { 'isExternal':True }
          , 'vss'   : { 'isExternal':True }
            
          }
          
        # describing the nets, using instances and internal terminals
        # taking into account 3 or 4 terminals for Transistors

        self.netSpecs = \
          { 'er'     : [ ('mn2'  , 'G') ]
          , 'ep'     : [ ('mn1'  , 'G') ]
          , 'd1'     : [ ('mn1'  , 'D'), ('mn5' , 'S')]
          , 'd2'     : [ ('mn2'  , 'D'), ('mn6' , 'S')]
          , 'ck'     : [ ('mn5'  , 'G'), ('mn6' , 'G'), ('mp15', 'G'), ('mp16', 'G')]
          , 'qp'     : [ ('mn6'  , 'D'), ('mp12', 'D'), ('mp16', 'D'), ('mp11', 'G')]
          , 'qm'     : [ ('mn5'  , 'D'), ('mp11', 'D'), ('mp15', 'D'), ('mp12', 'G')]
          , 'vdd'    : [ ('mp11' , 'S'), ('mp12', 'S')
                       , ('mp15' , 'S'), ('mp16', 'S')]
          , 'vss'    : [ ('mn1' , 'S'), ('mn2', 'S'), ('mn5', 'B' )
                       , ('mn6' , 'B')]
          }


        # building the cell, instances and nets

        self.beginCell( 'cmpvN' )
        self.doDevices()
        self.doNets   ()

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

        # the designer wants layout with 2 horizontal slices
        # useful for high clock frequenxcy specification, when the N MOS transistors have small "Ls"
        if(sliceNumber == 2):

            print('sliceNumber =' , sliceNumber)
            # #1
            self.pushVNode( Center )
            # #2
            # mn1 and mn2
            self.addSymmetry( 1, 2 )
            # mn5 and mn6
            self.addSymmetry( 0, 3 ) 
            # mn5
            self.addDevice( self.devicesSpecs[2][1] , Center, StepParameterRange(1, 1, 1) )
            # mn1
            self.addDevice( self.devicesSpecs[0][1] , Center, StepParameterRange(1, 1, 1) ) 
            # mn2
            self.addDevice( self.devicesSpecs[1][1] , Center, StepParameterRange(1, 1, 1) )
            # mn6
            self.addDevice( self.devicesSpecs[3][1] , Center, StepParameterRange(1, 1, 1) ) 
            self.popNode()
            # #1

        # the designer wants layout with 3 horizontal slices
        # useful for low clock frequency specification, when the N MOS transistors mn1 and mn2 have large "Ls"
        else:
          
            print('sliceNumber =' , sliceNumber)
            # #1
            self.pushVNode( Center )
            # #2
            # mn1 and mn2
            self.addSymmetry( 0, 1 )
            # mn1
            self.addDevice( self.devicesSpecs[0][1] , Center, StepParameterRange(1, 1, 1) )
            # mn2
            self.addDevice( self.devicesSpecs[1][1] , Center, StepParameterRange(1, 1, 1) )
            # #2
            self.popNode()
            # #1

            self.pushVNode( Center )
            # #2
            # mn5 and mn6
            self.addSymmetry( 0, 1 )
            # mn5
            self.addDevice( self.devicesSpecs[2][1] , Center, StepParameterRange(1, 1, 1) )
            # mn6
            self.addDevice( self.devicesSpecs[3][1] , Center, StepParameterRange(1, 1, 1) )
            # #2
            self.popNode()
            # #1

        self.pushVNode( Center )
        # #2
        # mp11 and mp12
        self.addSymmetry( 0, 3 )
        # mp15 and mp16
        self.addSymmetry( 1, 2)
        # mp15
        self.addDevice( self.devicesSpecs[6][1] , Center, StepParameterRange(1, 1, 1) )
        # mp11
        self.addDevice( self.devicesSpecs[4][1] , Center, StepParameterRange(1, 1, 1) )
        # mp12
        self.addDevice( self.devicesSpecs[5][1] , Center, StepParameterRange(1, 1, 1) )
        # mp16
        self.addDevice( self.devicesSpecs[7][1] , Center, StepParameterRange(1, 1, 1) )
        # #2
        self.popNode()
        # #1

        # #horizontal power rail VDD
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
    rvalue = True
    try:
        editor = None
        #if kw.has_key('editor') and kw['editor']:
        if 'editor' in kw and kw['editor']:
          editor = kw['editor']
    
        cell = CRL.AllianceFramework.get().getCell( 'cmpvN', CRL.Catalog.State.Views )
        if cell:
            UpdateSession.open()
            cell.destroy()
            UpdateSession.close()
            print( 'Previous <millerN> cell destroyed.')
    
        design = CMPV()
        design.build( editor )
    except Exception as e:
        catch( e ) 
        rvalue = False
    sys.stdout.flush()
    sys.stderr.flush()
    return rvalue

