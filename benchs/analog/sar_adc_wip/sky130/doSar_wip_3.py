#!/usr/bin/python
#
# This file is part of the Coriolis Software.
#
# +-----------------------------------------------------------------+ 
# |             C O R I O L I S   D E S I G N S                     |
# |      A Collection of Analogic Designs Examples                  | 
# |                                                                 |
# |  Author      : Marie Minerve Louerat, Jean-Paul Chaput          | 
# |                                                                 |
# |  E-mail      :   Jean-Paul.Chaput@lip6.fr                       |
# | =============================================================== |
# |  Python      :  "./doSar_wip_3.py"                              |
# |                                                                 |
# |  Python by   : Jihane Benhadou, Bouchra Kadri, Igor Zivanovic   |
# |                Marie-Minerve LOUERAT, Jean-Paul Chaput          |
# |                26 April  2023                                   |
# |                26 May 2023                                      |
# |                23 April 2024                                    |
# |                29 April 2024                                    |
# |                14 October 2024                                  |
# |                                                                 |
# |  Sizing by   : Initial version from Oceane by Jacky Porte       |
# |                                                                 |
# +-----------------------------------------------------------------+
#
#
# Work In Progress
# Folded transistors
# Routing described
# No SAR registers in wip_3
# Bug in the capacitor layout generation
# Therefore MultiCapacitor device is used. 
# COND_C_0 and COND_C_1 have to be layouted using the same device MultiCapacitor matrix : COND_C_1_0
# device sizes are provided for testing the layout generation.
# Only one shape is generated.
#
# High level layout illustration :
#     - SAR on South (currently missing)
#     - DAC on North-West
#     - COMPV on North-East
#
# ------------------------------------
#               H-Rail
# ------------------------------------
# |                 ||               | 
# |                 ||               | 
# |                 ||               | 
# |       DAC       ||     COMPV     | 
# |                 ||               | 
# |                 ||               | 
# |                 ||               | 
# |----------------------------------| 
# |                                  | 
# |                SAR               | 
# |                                  | 
# ------------------------------------
#               H-Rail
# ------------------------------------
#
import os
import sys
from   coriolis           import Cfg
from   coriolis.Hurricane import *
from   coriolis           import CRL, helpers
from   coriolis.helpers    import l, u, n
from   coriolis.helpers.io import catch


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

#from sar import SAR

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

#def loadSar ():
#    framework = CRL.AllianceFramework.get()
#
#    #blifName = "sar.blif"
#    #sar = CRL.Blif.load(blifName)
#    sar   = framework.getCell( 'sar_p', CRL.Catalog.State.Views )
#    return sar

class ADC ( AnalogDesign ):

    def __init__ ( self ):
        AnalogDesign.__init__( self )
        return

    def build ( self, editor ):
        print ( '  o  Running ADC.build().' )

#       sarModel = loadSar()
        
        # Capa matrixes
        twoCapa_1x2 = [ [ 0, 1 ],
                      ]

        fourCapa_2x2 = [ [ 0, 1 ]
                       , [ 2, 3 ]
                       ]

        twoCapa_2x2 = [ [ 0, 0 ]
                      , [ 1, 1 ]
                      ]

        twoCapa_2x4 = [ [ 0, 0, 0, 0 ]
                      , [ 1, 1, 1, 1 ]
                      ]  

        twoCapa_4x4 = [ [ 0, 0, 0, 0 ]
                      , [ 0, 0, 0, 0 ]
                      , [ 1, 1, 1, 1 ]
                      , [ 1, 1, 1, 1 ]
                      ]

        mrange_1 = MatrixParameterRange()
        mrange_1.addValue( twoCapa_1x2 )
        mrange_14 = MatrixParameterRange()
        mrange_14.addValue( fourCapa_2x2 )
        mrange_2 = MatrixParameterRange()
        mrange_2.addValue( twoCapa_2x2 )
        mrange_3 = MatrixParameterRange()
        mrange_3.addValue( twoCapa_2x4 )
        mrange_4 = MatrixParameterRange()
        mrange_4.addValue( twoCapa_4x4 )

        #   | 0           | 1         | 2               | 3   | 4      |  5    | 6| 7   |8  |9     |10  | 11    |
        #   | Class       | Instance  | Layout Style    | Type| W      |  L    | M| Mint|Dum|SFirst|Bulk| BulkC |
        #   +=============+===========+=================+=====+========+=======+==+=====+===+======+====+=======+
        self.devicesSpecs = \
          [ 
					# COMPARATOR
					    # N-type differential dynamic amplifier
    					#DifferentialPair (DP) used for MN1 and MN2 transistors
		    					#CommonSourcePair (CSP) used for MP7 and MP8 transistors
				    			#"Normal" Transistor used for MN5 and MP9 transistors
            [ DifferentialPair  , 'mn1_mn2'	, 'WIP DP'	, NMOS, 0.84    , 12.63 , 2, 2   ,  1, True , 0xf, False ]
          , [ CommonSourcePair  , 'mp7_mp8' , 'WIP CSP'	, PMOS, 0.84    , 0.350 , 2, 2	 ,  1, True , 0xf, True  ]
          , [ Transistor  , 'mn5'     , 'WIP Transistor', NMOS, 0.42    , 12.72 , 1, None,  0, True , 0xf, True  ]
          , [ Transistor  , 'mp9'     , 'WIP Transistor', PMOS, 0.84    , 0.350 , 1, None,  0, True , 0xf, True  ]
							# P-type Song Latch
          , [ Transistor  , 'mp11'    , 'WIP Transistor', PMOS, 0.42    , 1.085 , 1, None,  0, True , 0xf, False ]
          , [ Transistor  , 'mp12'    , 'WIP Transistor', PMOS, 0.42    , 1.085 , 1, None,  0, True , 0xf, False ]
          , [ Transistor  , 'mn13'    , 'WIP Transistor', NMOS, 0.42    , 4.805 , 1, None,  0, True , 0xf, True  ]
          , [ Transistor  , 'mn14'    , 'WIP Transistor', NMOS, 0.42    , 4.805 , 1, None,  0, True , 0xf, True  ]
          , [ Transistor  , 'mn15'    , 'WIP Transistor', NMOS, 0.84    , 0.15  , 1, None,  0, True , 0xf, True  ]
          , [ Transistor  , 'mn16'    , 'WIP Transistor', NMOS, 0.84    , 0.15  , 1, None,  0, True , 0xf, True  ]
          , [ Transistor  , 'mp17'    , 'WIP Transistor', PMOS, 0.45    , 1.15  , 1, None,  0, True , 0xf, True  ]
          , [ Transistor  , 'mp18'    , 'WIP Transistor', PMOS, 0.45    , 1.15  , 1, None,  0, True , 0xf, True  ]
					# SAR
    	#	, [ sarModel    , 'sar' ]
					# Digital-to-Analog Converter
					    # Bottom plates NMOS Switches
          , [ Transistor  , 'MNSW0'  , 'WIP Transistor', NMOS, 0.42    , 0.150 , 1, None,  0, True , 0x0, True  ]
          , [ Transistor  , 'MNSW1'  , 'WIP Transistor', NMOS, 0.42    , 0.150 , 1, None,  0, True , 0x0, True  ]
          , [ Transistor  , 'MNSW2'  , 'WIP Transistor', NMOS, 0.42    , 0.150 , 1, None,  0, True , 0x0, True  ]
          , [ Transistor  , 'MNSW3'  , 'WIP Transistor', NMOS, 0.42    , 0.150 , 1, None,  0, True , 0x0, True  ]
          , [ Transistor  , 'MNSW4'  , 'WIP Transistor', NMOS, 0.42    , 0.150 , 1, None,  0, True , 0x0, True  ]
					    # Bottom plates PMOS Switches 
          , [ Transistor  , 'MPSW1'  , 'WIP Transistor', PMOS, 0.42    , 0.350 , 1, None,  0, True , 0x0, True  ]
          , [ Transistor  , 'MPSW2'  , 'WIP Transistor', PMOS, 0.42    , 0.350 , 1, None,  0, True , 0x0, True  ]
          , [ Transistor  , 'MPSW3'  , 'WIP Transistor', PMOS, 0.42    , 0.350 , 1, None,  0, True , 0x0, True  ]
          , [ Transistor  , 'MPSW4'  , 'WIP Transistor', PMOS, 0.42    , 0.350 , 1, None,  0, True , 0x0, True  ]
					    # Bottom plates CMOS Switches (PMOS & NMOS)
          , [ Transistor  , 'MNCSW0' , 'WIP Transistor', NMOS, 0.42    , 0.350 , 1, None,  0, True , 0x0, True  ]
          , [ Transistor  , 'MPCSW0' , 'WIP Transistor', PMOS, 0.42    , 0.350 , 1, None,  0, True , 0x0, True  ]

          , [ Transistor  , 'MNCSW1' , 'WIP Transistor', NMOS, 0.42    , 0.350 , 1, None,  0, True , 0x0, True  ]
          , [ Transistor  , 'MPCSW1' , 'WIP Transistor', PMOS, 0.42    , 0.350 , 1, None,  0, True , 0x0, True  ]

          , [ Transistor  , 'MNCSW2' , 'WIP Transistor', NMOS, 0.42    , 0.350 , 1, None,  0, True , 0x0, True  ]
          , [ Transistor  , 'MPCSW2' , 'WIP Transistor', PMOS, 0.42    , 0.350 , 1, None,  0, True , 0x0, True  ]

          , [ Transistor  , 'MNCSW3' , 'WIP Transistor', NMOS, 0.42    , 0.350 , 1, None,  0, True , 0x0, True  ]
          , [ Transistor  , 'MPCSW3' , 'WIP Transistor', PMOS, 0.42    , 0.350 , 1, None,  0, True , 0x0, True  ]

          , [ Transistor  , 'MNCSW4' , 'WIP Transistor', NMOS, 0.42    , 0.350 , 1, None,  0, True , 0x0, True  ]
          , [ Transistor  , 'MPCSW4' , 'WIP Transistor', PMOS, 0.42    , 0.350 , 1, None,  0, True , 0x0, True  ]
					    # Top plates CMOS Switch
          , [ Transistor  , 'MNTOP'  , 'WIP Transistor', NMOS, 0.42   , 0.350 , 1, None,  0, True , 0x0, True  ]
          , [ Transistor  , 'MPTOP'  , 'WIP Transistor', PMOS, 0.42   , 0.350 , 1, None,  0, True , 0x0, True  ]

       #    | 0                  | 1         | 2            | 3    | 4                      | 5                  | 6     |
       #    | Class              | Instance  | Layout Style | Type | Cs                     | Default Matrix     | Dummy |
       #    +====================+===========+==============+======+========================+====================+=======+
       #   , [ MultiCapacitor     , 'COND_C_0', 'Matrix'     , MIM  , (0.13, 0.13)    , twoCapa_1x2        , False ]
          , [ MultiCapacitor     ,'COND_C_1_0', 'Matrix'     , MIM  ,(0.02, 0.02)            , twoCapa_2x2        , False ]
          , [ MultiCapacitor     ,'COND_C_2'  , 'Matrix'     , MIM  ,(0.04, 0.04)            , twoCapa_2x2        , False ]
          , [ MultiCapacitor     ,'COND_C_3'  , 'Matrix'     , MIM  ,(0.08, 0.08)            , twoCapa_2x4        , False ]
          , [ MultiCapacitor     ,'COND_C_4'  , 'Matrix'     , MIM  ,(0.16, 0.16)            , twoCapa_4x4        , False ]

          ]

        self.netTypes = \
          { 
          # COMPARATOR
              # N-type differential dynamic amplifier
            'ck'    : { 'isExternal':True } # input net from terminal ck
          , 'ep'    : { 'isExternal':True } # input net from terminal Vep
          #, 'rp'    : { 'isExternal':False} # internal net Vrp
          , 'vz'    : { 'isExternal':False} # internal net MN5 - MN1_MN2 - MP9

              # P-type Song Latch
          , 'x'             : { 'isExternal' :False} # internal net X
          , 'y'             : { 'isExternal' :False} # internal net Y
          , 'net_mp11_mp17'  : { 'isExternal':False} # internal net MP11 - MP17
          , 'net_mp12_mp18'  : { 'isExternal':False} # internal net MP12 - MP18
          , 'sp'             : { 'isExternal':False} # output net to terminal qp
          , 'sm'             : { 'isExternal':False} # output net to terminal qm

          # SAR

          # Digital-to-Analog Converter
              # 
          , 'phi0n'  : { 'isExternal':False}
          , 'phi1n'  : { 'isExternal':False}
          , 'phi2n'  : { 'isExternal':False}
          , 'phi3n'  : { 'isExternal':False}
          , 'phi4n'  : { 'isExternal':False}
          , 'phi1p'  : { 'isExternal':False}
          , 'phi2p'  : { 'isExternal':False}
          , 'phi3p'  : { 'isExternal':False}
          , 'phi4p'  : { 'isExternal':False}
          , 'phis'   : { 'isExternal':False}
          , 'phisb'  : { 'isExternal':False}
          , 'b0'     : { 'isExternal':False}
          , 'b1'     : { 'isExternal':False}
          , 'b2'     : { 'isExternal':False}
          , 'b3'     : { 'isExternal':False}
          , 'b4'     : { 'isExternal':False}
          , 'nt'     : { 'isExternal':False}
          , 'vin'    : { 'isExternal':True }

          # VDD and GND
          , 'vdd'   : { 'isExternal':True }  # power supply net
          , 'vss'   : { 'isExternal':True }  # ground net
            
          }
          
          # | Net             | Connector                                                                    |
          # +=================+==============================================================================+
        self.netSpecs = \
          { 
          # COMPARATOR
              # N-type differential dynamic amplifier
            'ck'              : [ ('mp7_mp8' , 'G'), ('mp9' , 'G'), ('mn5', 'G') ]  # input net from terminal ck
          , 'ep'              : [ ('mn1_mn2' , 'G2'), ]  # input net from terminal Vep
          #, 'rp'              : [ ('mn1_mn2' , 'G1'), ]  # internal net Vrp (DAC output) SAME NET AS 'nt' !!!!!
          , 'vz'              : [ ('mn5' , 'D'), ('mn1_mn2', 'S'), ('mp9', 'D')]  # internal net MN5 - MN1_MN2 - MP9

              # P-type Song Latch
          , 'x'               : [ ('mn1_mn2' , 'D2'), ('mp7_mp8', 'D2'), ('mp12', 'G'), ('mn16', 'G') ]
          , 'y'               : [ ('mn1_mn2' , 'D1'), ('mp7_mp8', 'D1'), ('mp11', 'G'), ('mn15', 'G') ]
          , 'sm'              : [ ('mn15', 'D'), ('mn13', 'D'), ('mn14', 'G'), ('mp18', 'G'), ('mp11', 'D')]
          , 'sp'              : [ ('mn16', 'D'), ('mn14', 'D'), ('mn13', 'G'), ('mp17', 'G'), ('mp12', 'D')
                                # to be completed with the appropriate sar input terminal
                                ]
          , 'net_mp11_mp17'   : [ ('mp11', 'S'), ('mp17', 'D') ]
          , 'net_mp12_mp18'   : [ ('mp12', 'S'), ('mp18', 'D') ]

          # SAR

          # Digital-to-Analog Converter
              # 
          , 'phi0n'  : [ ('MNSW0' , 'G') ]
          , 'phi1n'  : [ ('MNSW1' , 'G') ]
          , 'phi2n'  : [ ('MNSW2' , 'G') ]
          , 'phi3n'  : [ ('MNSW3' , 'G') ]
          , 'phi4n'  : [ ('MNSW4' , 'G') ]
          #, 'b0'     : [ ('COND_C_0', 'b0'), ('MNSW0' , 'D'), ('MNCSW0' , 'D'), ('MPCSW0' , 'D') ]
          , 'b0'     : [ ('COND_C_1_0', 'b0'), ('MNSW0' , 'D'), ('MNCSW0' , 'D'), ('MPCSW0' , 'D') ]
          #, 'b0'     : [ ('MNSW0' , 'D'), ('MNCSW0' , 'D'), ('MPCSW0' , 'D') ]
          #, 'b1'     : [ ('COND_C_1', 'b0'), ('MNSW1' , 'D'), ('MPSW1' , 'D'), ('MNCSW1' , 'D'), ('MPCSW1' , 'D') ]
          , 'b1'     : [ ('COND_C_1_0', 'b1'), ('MNSW1' , 'D'), ('MPSW1' , 'D'), ('MNCSW1' , 'D'), ('MPCSW1' , 'D') ]
          #, 'b1'     : [ ('MNSW1' , 'D'), ('MPSW1' , 'D'), ('MNCSW1' , 'D'), ('MPCSW1' , 'D') ]
          , 'b2'     : [ ('COND_C_2', 'b0'), ('MNSW2' , 'D'), ('MPSW2' , 'D'), ('MNCSW2' , 'D'), ('MPCSW2' , 'D') ]
          , 'b3'     : [ ('COND_C_3', 'b0'), ('MNSW3' , 'D'), ('MPSW3' , 'D'), ('MNCSW3' , 'D'), ('MPCSW3' , 'D') ]
          , 'b4'     : [ ('COND_C_4', 'b0'), ('MNSW4' , 'D'), ('MPSW4' , 'D'), ('MNCSW4' , 'D'), ('MPCSW4' , 'D') ]
          , 'phi1p'  : [ ('MPSW1' , 'G') ]
          , 'phi2p'  : [ ('MPSW2' , 'G') ]
          , 'phi3p'  : [ ('MPSW3' , 'G') ]
          , 'phi4p'  : [ ('MPSW4' , 'G') ]
          , 'phis'   : [ ('MNCSW0' , 'G'), ('MNCSW1' , 'G'), ('MNCSW2' , 'G'), ('MNCSW3' , 'G'), ('MNCSW4' , 'G'), ('MNTOP' , 'G')
                       # to be completed with the appropriate sar output terminal
                       ]
          , 'phisb'  : [ ('MPCSW0' , 'G'), ('MPCSW1' , 'G'), ('MPCSW2' , 'G'), ('MPCSW3' , 'G'), ('MPCSW4' , 'G'), ('MPTOP' , 'G')
                       # to be completed with the appropriate sar output terminal
                       ]
          , 'vin'    : [ ('MNCSW0' , 'S'), ('MNCSW1' , 'S'), ('MNCSW2' , 'S'), ('MNCSW3' , 'S'), ('MNTOP' , 'S') 
                       , ('MPCSW0' , 'S'), ('MPCSW1' , 'S'), ('MPCSW2' , 'S'), ('MPCSW3' , 'S'), ('MPTOP' , 'S')]
          , 'nt'     : [ ('MNTOP' , 'D') 
                       , ('MPTOP' , 'D')
          #            , ('COND_C_0', 't0'), ('COND_C_1', 't0'), ('COND_C_2', 't0'), ('COND_C_3', 't0'), ('COND_C_4', 't0')
                       , ('COND_C_1_0','t0'), ('COND_C_2', 't0'), ('COND_C_3', 't0'), ('COND_C_4', 't0')
                       , ('COND_C_1_0','t1'), ('COND_C_2', 't1'), ('COND_C_3', 't1'), ('COND_C_4', 't1')
          #           , ('COND_C_2', 't0'), ('COND_C_3', 't0'), ('COND_C_4', 't0')
                       , ('mn1_mn2' , 'G1') # comparator input Vrp
                       ]

          # VDD net
          , 'vdd'             : [ 
                ('mp7_mp8' , 'S'), ('mp9' , 'S')  # N-type differential dynamic amplifier
              , ('mp11', 'B'), ('mp12', 'B'), ('mp17', 'S'), ('mp18', 'S')  # P-type Song Latch
              , ('MPSW1' , 'S'), ('MPSW2' , 'S'), ('MPSW3', 'S'), ('MPSW4', 'S')  # DAC
          # SAR VDD
              ]

          # GND net
          , 'vss'             : [ 
                ('mn1_mn2' , 'B'), ('mn5' , 'S')  # N-type differential dynamic amplifier
              , ('mn13', 'S'), ('mn14', 'S'), ('mn15', 'S'), ('mn16', 'S') # P-type Song Latch
              , ('MNSW0' , 'S'), ('MNSW1' , 'S'), ('MNSW2' , 'S'), ('MNSW3', 'S'), ('MNSW4', 'S') # DAC
          # SAR VSS
              ]
          }

        #self.readParameters( './sizes/oceane_all_v1.txt' )  # put the oceane file with the sizing

        self.beginCell( 'adc' )
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

        self.addHRail( self.getNet('vss'), 'METAL4', 1, "CH1", "IH1" )
        # #1

        ##### ##### ##### ##### #### SAR ##### ##### ##### ##### #####

        # self.addDevice( 'sar'  , Center, None )

        ##### ##### ##### #####  END SAR ##### ##### ##### ##### #####

        self.pushVNode( Center )
        # #2

        self.pushHNode( Center )
        # #3

        ##### ##### ##### ##### #### DAC ##### ##### ##### ##### ##### 

        self.pushVNode( Center )
        #4
        self.addDevice( 'MNTOP' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'MNCSW4' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'MNSW4' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'MNCSW3' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'MNSW3' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'MNCSW2' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'MNSW2' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'MNCSW1' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'MNSW1' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'MNCSW0' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'MNSW0' , Center, StepParameterRange(1, 1, 1) )

        self.popNode()
        #3

        self.pushVNode( Center )
        #4
        self.addDevice( 'COND_C_4', Center, mrange_4 )

        self.pushHNode( Center )
        #5
        self.addDevice( 'COND_C_3', Center, mrange_3 )

        self.pushVNode( Center )
        #6
        self.addDevice( 'COND_C_2', Center, mrange_2 )

        #self.pushHNode( Center )
        #7
        #self.addDevice( 'COND_C_0', Center, mrange_1 )
        #self.addDevice( 'COND_C_1', Center, mrange_1 )
        self.addDevice( 'COND_C_1_0', Center, mrange_2 )
        #self.popNode()
        #6

        self.popNode()
        #5

        self.popNode()
        #4
        self.popNode()
        #3
        self.pushVNode( Center )
        #4
        self.addDevice( 'MPTOP' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'MPCSW4' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'MPSW4' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'MPCSW3' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'MPSW3' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'MPCSW2' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'MPSW2' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'MPCSW1' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'MPSW1' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'MPCSW0' , Center, StepParameterRange(1, 1, 1) )

        self.popNode()
        #3

        ##### ##### ##### #####  END DAC ##### ##### ##### ##### #####

        self.popNode()
        # #2

        ##### ##### ##### #####   COMPARATOR  ##### ##### ##### #####  

        # 1st vertical slice
        ##### ##### N-type differential dynamic amplifier ##### #####
        self.pushHNode( Center )
        # #3

        self.addDevice( 'mn5'    , Center, StepParameterRange(1, 1, 2) )

        self.addDevice( 'mn1_mn2' , Center, StepParameterRange(1, 1, 1) )

        self.addDevice( 'mp9' , Center, StepParameterRange(1, 1, 1) ) 
 
        self.addDevice( 'mp7_mp8' , Center, StepParameterRange(1, 1, 1) )
        # #3
        
        self.popNode()
        # #2
        
        ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

        # 2nd vertical slice
        ##### ##### ##### P-type Song Latch ##### ##### #####
        # cote gauche
        self.pushHNode( Center )
        # #3

        self.pushVNode( Center )
        # #4
        self.addDevice( 'mn15' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'mn13' , Center, StepParameterRange(1, 1, 1) )
        # #4
        self.popNode()
        # #3
        self.addDevice( 'mp11' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'mp17' , Center, StepParameterRange(1, 1, 1) )
        # #3
        self.popNode()
        # #2

        # cote droit
        self.pushHNode( Center )
        # #3

        self.pushVNode( Center )
        # #4
        self.addDevice( 'mn14' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'mn16' , Center, StepParameterRange(1, 1, 1) )
        # #4
        self.popNode()
        # #3
        self.addDevice( 'mp12' , Center, StepParameterRange(1, 1, 1) )
        self.addDevice( 'mp18' , Center, StepParameterRange(1, 1, 1) )
        # #3
        self.popNode()
        # #2

        self.addSymmetry(2,3) # Symmetry between Vertical Nodes 2 and 3

        ##### ##### ##### ##### ##### ##### ##### ##### #####

        ##### ##### ##### ##### END COMPARATOR ##### ##### ##### #####  

        self.popNode()
        # #1

        self.addHRail( self.getNet('vdd'), 'METAL4', 1, "CH2", "IH2" )

        self.popNode()
        # # #0

        self.endSlicingTree()
    
        self.updatePlacement(  0 )
        self.endCell()
    
        if editor:
          editor.setCell( self.cell )
          editor.fit()
        return


def scriptMain( **kw ):
    editor = None
    if 'editor' in kw and kw['editor']:
      editor = kw['editor']

    cell = CRL.AllianceFramework.get().getCell( 'adc', CRL.Catalog.State.Views )
    if cell:
        UpdateSession.open()
        cell.destroy()
        UpdateSession.close()
        print( 'Previous <adc> cell destroyed.')

    design = ADC()
    design.build( editor )
    return True


