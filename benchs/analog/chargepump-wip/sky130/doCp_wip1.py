#!/usr/bin/python3
#
# This file is part of the Coriolis Software.
#
# +-----------------------------------------------------------------+ 
# |             C O R I O L I S   D E S I G N S                     |
# |      A Collection of Analogic Designs Examples                  | 
# |                                                                 |
# |  Author      :               Dimitri Galayko                    | 
# |                              Marie Minerve Louerat              |
# |  E-mail      :            Jean-Paul.Chaput@lip6.fr              |
# | =============================================================== |
# |  Python      :  "./cp_wip.py"                                   |
# |                                                                 |
# |  Python by Dimitri Galayko Marie-Minerve Louerat                |
# |(19 April  2023)                                                 |
# |  Sizing by Dimitri Galayko    (1 December 2022)                 |
# |  Update by Marie-Minerve Louerat (31 January 2024)              |
# +-----------------------------------------------------------------+
#
#
# Transistors are connected, 
#         layout if described as flatten
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
import pandas as pd

#helpers.setTraceLevel( 100 )

from coriolis.Analog import Device
from coriolis.Analog import Transistor
from coriolis.Analog import CommonDrain
from coriolis.Analog import CommonGatePair
from coriolis.Analog import CommonSourcePair
from coriolis.Analog import CrossCoupledPair
from coriolis.Analog import DifferentialPair
from coriolis.Analog import LevelShifter
from coriolis.Analog import SimpleCurrentMirror
from coriolis.Analog import CapacitorFamily
from coriolis.Analog import MultiCapacitor
from coriolis.Analog import LayoutGenerator
from coriolis.Bora   import ParameterRange
from coriolis.Bora   import StepParameterRange
from coriolis.Bora   import MatrixParameterRange
from coriolis.Bora   import SlicingNode
from coriolis.Bora   import HSlicingNode
from coriolis.Bora   import VSlicingNode
from coriolis.Bora   import DSlicingNode
from coriolis.Bora   import RHSlicingNode
from coriolis.Bora   import RVSlicingNode
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


# define the file where the parameters are provided by the sizing operation chargepump_size_wip.txt
# reads the parameters from the file, csv format
# in this file, the table shows the transistor finger width WF in MICRONS

base=pd.read_csv('chargepump_size_wip.txt', sep=' ', skipinitialspace=True, encoding="utf-8")

# define the list of transistors used in the layout description
# IMPORTANT : the order in the list will define the index of the device
# in the devicesSpecs table
# the order may be different in the csv table
# index order of tansistor in devicesSpecs is set by this list
# transistor index  0      1       2       3       4     5      6     7      8     9
all_transistor = ['MPsw', 'MPsr', 'MNsw', 'MNsr', 'M1', 'M11', 'M2', 'M21', 'M3', 'M31']

all_transistor_base = base['Name'].tolist()
print(all_transistor_base)

# describe the circuit for layout generation
class CHARGEPUMP ( AnalogDesign ):

    def __init__ ( self ):
        AnalogDesign.__init__( self )
        return

    def build ( self, editor ):
        print( '  o  Running CHARGEPUMP.build().')

        self.devicesSpecs = []

        for transistor in all_transistor:
            if transistor in all_transistor_base:
                print(transistor, 'is present in the code and in the parameters base.')

                # reading Transistor Name
                name = base.loc[base['Name']==transistor, 'Name'].to_string(index=False)
                print(name)

                # reading transistor type, consistent with Coriolis Transistor class
                typeMOS = base.loc[base['Name']==transistor, 'TMOS'].to_string(index=False)
                if   typeMOS == 'NMOS': value = Transistor.NMOS
                elif typeMOS == 'PMOS': value = Transistor.PMOS
                print('type(typeMOS)',typeMOS,type(value),value)
                print(type(typeMOS),typeMOS,type(value),value)

                # reading the transistor finger width in micron
                WF = float(base.loc[base['Name']==transistor, 'WF'].to_string(index=False))
                print('Wfinger=', WF)

                # reading the transistor length in micron
                L = float(base.loc[base['Name']==transistor, 'L'].to_string(index=False))
                print('L=',L)

                # reading the transistor folds integer 
                M = int(base.loc[base['Name']==transistor, 'M'].to_string(index=False))
                print('M=',M)

                #                         | Class | Instance | Layout Style | Type | W | L | M | Mint | Dum | SFirst | Bulk | BulkC |
                # computing the whole transistor width from finger width and number of fingers
                # BulkC= False means that Bulk is NOT connected internally to the source, the device has 4 (D, G, S, B) external terminals
                # Bulk = 0xf means guard ring, 4 side bulk connected around active

                self.devicesSpecs.append([Transistor, name, 'WIP Transistor', value, WF*M, L, M, None, 0, True, 0xf, False])
                print(self.devicesSpecs)
                print('name:',name,' type:', value, ' Wtotal:', WF*M, ' L:', L)
            else:
                print('ERROR:', transistor, 'is not present in the parameters base.')
                sys.exit( 1 )

        for transistor_base in all_transistor_base:
            if transistor_base not in all_transistor:
                print('ERROR:', transistor_base, 'is present in the parameters base only and not in the code.')
                sys.exit( 1 )
            else:
              pass




        self.netTypes = \
          { 'upmos'    : { 'isExternal':True }
          , 'dnmos'    : { 'isExternal':True }
          , 'n1'       : { 'isExternal':False}
          , 'n2'       : { 'isExternal':False}
          , 'n3'       : { 'isExternal':False}
          , 'n4'       : { 'isExternal':False}
          , 'n5'       : { 'isExternal':False}
          , 'biasp'    : { 'isExternal':False}
          , 'biasn'    : { 'isExternal':True }
          , 'out'      : { 'isExternal':True }
          , 'vdd'      : { 'isExternal':True }
          , 'vss'      : { 'isExternal':True }
          }

        self.netSpecs = \
          { 'upmos'     : [ ('MPsw' , 'G')]
          , 'dnmos'     : [ ('MNsw' , 'G')]
          , 'n1'        : [ ('MPsw' , 'D'), ('MPsr', 'S')]
          , 'n2'        : [ ('MNsr' , 'S'), ('MNsw', 'D')]
          , 'n3'        : [ ('M31' , 'D'), ('M3', 'S')]
          , 'n4'        : [ ('M2' , 'S'), ('M21', 'D')]
          , 'n5'        : [ ('M1' , 'S'), ('M11', 'D')]
          , 'biasp'     : [ ('M3' , 'G'), ('M3', 'D'), ('MPsr', 'G'), ('M2', 'D')]
          , 'biasn'     : [ ('M1' , 'G'), ('M1', 'D'), ('MNsr', 'G'), ('M2', 'G')]
          , 'out'       : [ ('MPsr' , 'D'), ('MNsr', 'D')]
          , 'vdd'       : [ ('M31' , 'S'), ('M31' , 'B'), ('M3' , 'B'), ('MPsw', 'S'), ('MPsw', 'B'), ('MPsr', 'B'), ('M21' , 'G'), ('M11', 'G')]
          , 'vss'       : [ ('M1' , 'B'),('M11' , 'S'), ('M11' , 'B'), ('M2', 'B'), ('M21', 'S'), ('M21', 'B'), ('MNsw', 'S' ), ('MNsw', 'B' ), ('MNsr', 'B'), ('M31' , 'G')]
          }

        self.beginCell( 'chargepumpCell' )
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
        self.addSymmetry( 0, 1 )
        self.addDevice( 'M11'   , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'M21'   , Center, StepParameterRange(1, 1, 1) )
        # #4
        self.popNode()
        # #3
        self.pushVNode( Center )
        # #4
        self.addSymmetry( 0, 1 )
        self.addDevice( 'M1'    , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'M2'    , Center, StepParameterRange(1, 1, 1) )
        # #4
        self.popNode()
        # #3
        self.addDevice( 'M3'    , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'M31'   , Center, StepParameterRange(1, 1, 1) )
        # #3
        self.popNode()
        # #2
        self.pushHNode( Center )
        # #3
        self.addDevice( 'MNsw'   , Center, StepParameterRange(10, 1, 1) )
        self.addDevice( 'MNsr'   , Center, StepParameterRange(10, 1, 1) )
        self.addDevice( 'MPsr'   , Center, StepParameterRange(10, 1, 1) )
        self.addDevice( 'MPsw'   , Center, StepParameterRange(10, 1, 1) )
        # #3
        self.popNode()
        # #2
        self.popNode()
        # #1
        self.addHRail( self.getNet('vdd'), 'METAL4', 2, "CH2", "IH2" )
        # #1
        self.popNode()
        # #0
        self.endSlicingTree()
    
        self.updatePlacement( 0 )
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

    cell = CRL.AllianceFramework.get().getCell( 'chargepumpCell', CRL.Catalog.State.Views )
    if cell:
        UpdateSession.open()
        cell.destroy()
        UpdateSession.close()
        print( 'Previous <chargepumpCell> cell destroyed.')

    design = CHARGEPUMP()
    design.build( editor )
    return True
