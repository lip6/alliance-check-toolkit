#!/usr/bin/python3
#
# This file is part of the Coriolis Software.
#
# +-----------------------------------------------------------------+ 
# |             C O R I O L I S   D E S I G N S                     |
# |      A Collection of Analogic Designs Examples                  | 
# |                                                                 |
# |  Author      :   Sahar Yahiaoui, Dimitri Galayko                | 
# |                  Marie Minerve Louerat, Jean-Paul Chaput        |
# |  E-mail      :   Jean-Paul.Chaput@lip6.fr                       |
# | =============================================================== |
# |  Python      :  "./vco_wip.py"                                  |
# |                                                                 |
# |  Python by   : Sahar Yahiaoui, Dimitri Galayko                  |
# |                Marie-Minerve LOUERAT                            |
# |               (19 April  2023)                                  |
# |                                                                 |
# |  Sizing by   : Dimitri Galayko    (1 December 2022)             |
# |                                                                 |
# +-----------------------------------------------------------------+
#
#
# Worj In Progress
# odd number of inverter cells are connected, 
#         upfront NMOS and PMOS biasing transistors
#         layout if described as flatten
# Folded transistors
# Routing described
# To be checked: feedback wire is long, connectors appear on the wire
#                still some issues to be checked with sizes and transistor names
#                and nets
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

nbinv = 21
if nbinv%2 == 0:
  print('ERROR: the number of inverters must be odd.')

base=pd.read_csv('CMOS_VCO_cell.cir_transistor_size.txt', sep=' ', skipinitialspace=True, encoding="utf-8")

all_transistor = ['MP', 'MN', 'MPc', 'MPb', 'MNb', 'MNc']

all_transistor_base = base['Name'].tolist()
#print(all_transistor_base)

type_dict = {'NMOS': 1, 'PMOS': 2}

class VCO ( AnalogDesign ):

    def __init__ ( self ):
        AnalogDesign.__init__( self )
        return

    def build ( self, editor ):
        print( '  o  Running VCO.build().')

        self.devicesSpecs = []
        for transistor in all_transistor:
            if transistor in all_transistor_base:
                print(transistor, 'is present in the code and in the parameters base.')
                name = base.loc[base['Name']==transistor, 'Name'].to_string(index=False)
                typ = base.loc[base['Name']==transistor, 'Type'].to_string(index=False)
                W = float(base.loc[base['Name']==transistor, 'W'].to_string(index=False))*(10**6)
                L = float(base.loc[base['Name']==transistor, 'L'].to_string(index=False))*(10**6)
                M = int(base.loc[base['Name']==transistor, 'M'].to_string(index=False))
                if name == 'MPc' or name == 'MPb' or name == 'MNb' or name == 'MNc':
                  for i in range(nbinv):
                    #                         | Class | Instance | Layout Style | Type | W | L | M | Mint | Dum | SFirst | Bulk | BulkC |
                    self.devicesSpecs.append([Transistor, name+str(i+1), 'WIP Transistor',  type_dict[typ], W*M, L, M, None, 0, True, 0xf, False])
                else:
                  #                         | Class | Instance | Layout Style | Type | W | L | M | Mint | Dum | SFirst | Bulk | BulkC |
                  self.devicesSpecs.append([Transistor, name, 'WIP Transistor',  type_dict[typ], W*M, L, 1, None, 0, True, 0xf, False])
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
          { 'ctrl'     : { 'isExternal':True }
          , 'm1'       : { 'isExternal':False}
          , 'vdd'      : { 'isExternal':True }
          , 'vss'      : { 'isExternal':True }
          }
        for i in range(1,nbinv+1):
          if i == 1:
            self.netTypes['n'+str(i)]={ 'isExternal':True}
          else:
            self.netTypes['n'+str(i)]={ 'isExternal':False}  
          self.netTypes['pp'+str(i)]={ 'isExternal':False}
          self.netTypes['nn'+str(i)]={ 'isExternal':False}
        #print(self.netTypes)


        self.netSpecs = {}
        for net in self.netTypes:
          self.netSpecs[net]=[]
        self.netSpecs['ctrl'].extend(('MN' , 'G'))
        self.netSpecs['m1'].extend([('MN' , 'D'), ('MP' , 'G'), ('MP' , 'D')])
        self.netSpecs['vdd'].extend([('MP' , 'S'), ('MP' , 'B')])
        self.netSpecs['vss'].extend([('MN' , 'S'), ('MN' , 'B')])
        for i in range(1, nbinv+1):
          #print(i)
          self.netSpecs['ctrl'].extend(('MNc'+str(i), 'G'))
          #print(self.netSpecs['ctrl'])
          self.netSpecs['m1'].extend(('MPc'+str(i), 'G'))
          #print(self.netSpecs['m1'])
          self.netSpecs['pp'+str(i)].extend([('MPc'+str(i), 'D'), ('MPb'+str(i), 'S')])
          #print(self.netSpecs['pp'+str(i)])
          self.netSpecs['nn'+str(i)].extend([('MNc'+str(i), 'D'), ('MNb'+str(i), 'S')])
          #print(self.netSpecs['nn'+str(i)])
          if i == 1:
            self.netSpecs['n'+str(i)].extend([('MPb'+str(i), 'G'), ('MNb'+str(i), 'G'), ('MPb'+str(nbinv), 'D'), ('MNb'+str(nbinv), 'D')])
          else:
            self.netSpecs['n'+str(i)].extend([('MPb'+str(i), 'G'), ('MNb'+str(i), 'G'), ('MPb'+str(i-1), 'D'), ('MNb'+str(i-1), 'D')])
          #print(self.netSpecs['n'+str(i)])
          self.netSpecs['vdd'].extend([('MPc'+str(i), 'S'), ('MPc'+str(i), 'B')])
          #print(self.netSpecs['vdd'])
          self.netSpecs['vss'].extend([('MNc'+str(i), 'S'), ('MNc'+str(i), 'B')])
          #print(self.netSpecs['vss'])
        #print(self.netSpecs)
        

        self.beginCell( 'vcoCell' )
        self.doDevices()
        self.doNets   ()
    
        self.beginSlicingTree()
        self.setToleranceRatioH( 1000000000.0 )
        self.setToleranceRatioW( 1000000000.0 )
        self.setToleranceBandH ( 1000000000.0 )
        self.setToleranceBandW ( 1000000000.0 )

########################## FloorPlan 1 (invertor block is duplicated)
  
        # #0
        self.pushHNode( Center )
        # #1
        self.addHRail( self.getNet('vss'), 'METAL4', 2, "CH1", "IH1" )
        # #1
        self.pushVNode( Center )
        # #2
        self.pushHNode( Center )
        # #3
        self.addDevice( 'MN'   , Center, StepParameterRange(int(base.loc[base['Name']=='MN', 'M'].to_string(index=False)), 1, 1) )
        self.addDevice( 'MP'   , Center, StepParameterRange(int(base.loc[base['Name']=='MP', 'M'].to_string(index=False)), 1, 1) )
        # #3
        self.popNode()
        for i in range(nbinv):
          # #2
          self.pushHNode( Center )
          # #3
          self.addDevice( 'MNc'+str(i+1)   , Center, StepParameterRange(int(base.loc[base['Name']=='MNc', 'M'].to_string(index=False)), 1, 1) )
          self.addDevice( 'MNb'+str(i+1)   , Center, StepParameterRange(int(base.loc[base['Name']=='MNb', 'M'].to_string(index=False)), 1, 1) )
          self.addDevice( 'MPb'+str(i+1)   , Center, StepParameterRange(int(base.loc[base['Name']=='MPb', 'M'].to_string(index=False)), 1, 1) )
          self.addDevice( 'MPc'+str(i+1)   , Center, StepParameterRange(int(base.loc[base['Name']=='MPc', 'M'].to_string(index=False)), 1, 1) )
          # #3
          self.popNode()
        # #2
        self.popNode()
        # #1
        self.addHRail( self.getNet('vdd'), 'METAL4', 2, "CH2", "IH2" )
        # #1
        self.popNode()
        # #0
        
########################## Investigation with Floorplan 2 (with matched transistors in slices)
        """
        # #0
        self.pushHNode( Center )
        # #1
        self.addHRail( self.getNet('vss'), 'METAL4', 2, "CH1", "IH1" )
        # #1
        self.pushVNode( Center )
        # #2
        self.pushHNode( Center )
        # #3
        self.addDevice( 'MN'   , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'MP'   , Center, StepParameterRange(1, 1, 1) )
        # #3
        self.popNode()
        # #2
        self.pushHNode( Center )
        # #3
        self.pushVNode( Center )
        # #4
        for i in range(nbinv):
          self.addDevice( 'MNc'+str(i+1)   , Center, StepParameterRange(1, 1, 1) )
        # #4
        self.popNode()
        # #3
        self.pushVNode( Center )
        # #4
        for i in range(nbinv):
          self.addDevice( 'MNb'+str(i+1)   , Center, StepParameterRange(1, 1, 1) )
        # #4
        self.popNode()
        # #3
        self.pushVNode( Center )
        # #4
        for i in range(nbinv):
          self.addDevice( 'MPb'+str(i+1)   , Center, StepParameterRange(1, 1, 1) )
        # #4
        self.popNode()
        # #3
        self.pushVNode( Center )
        # #4
        for i in range(nbinv):
          self.addDevice( 'MPc'+str(i+1)   , Center, StepParameterRange(1, 1, 1) )
        # #4
        self.popNode()
        # #3
        self.popNode()
        # #2
        self.popNode()
        # #1
        self.addHRail( self.getNet('vdd'), 'METAL4', 2, "CH2", "IH2" )
        # #1
        self.popNode()
        # #0
        """
        
        self.endSlicingTree()
    
        self.updatePlacement(  0 )
        self.endCell()
    
        if editor:
          editor.setCell( self.cell )
          editor.fit()
        return

def scriptMain ( **kw ):
    editor = None
    if 'editor' in kw and kw['editor']:
      editor = kw['editor']

    cell = CRL.AllianceFramework.get().getCell( 'vcoCell', CRL.Catalog.State.Views )
    if cell:
        UpdateSession.open()
        cell.destroy()
        UpdateSession.close()
        print( 'Previous <vcoCell> cell destroyed.')

    design = VCO()
    design.build( editor )
    return True
