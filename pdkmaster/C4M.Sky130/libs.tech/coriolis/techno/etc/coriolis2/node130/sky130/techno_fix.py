
# SPDX-License-Identifier: GPL-2.0-or-later OR AGPL-3.0-or-later OR CERN-OHL-S-2.0+

from coriolis.helpers   import l, u, n
from coriolis.Hurricane import DataBase, Technology, Layer, BasicLayer, DiffusionLayer, \
                               TransistorLayer, RegularLayer, ContactLayer, ViaLayer, \
                               DbU
from coriolis.helpers.analogtechno import Length, Area, Unit, Asymmetric, \
                                          loadAnalogTechno, addDevice

__all__ = [ "fix" ]


"""
Coriolis Design Technological Rules (DTR) for SkyWater 130nm CMOS General Purpose
=================================================================================

:Version: rev.LIP6-1
:Date:    December 21, 2022
:Date:    February 2, 2023
:Date:    April 20, 2023
:Authors: Marie-Minerve Louerat

Reference documents: 
    https://skywater-pdk.readthedocs.io/en/main/rules/masks.html
    https://skywater-pdk.readthedosc.io/en/main/rules/periphery.html#x

Beware of the existence of li1 local interconnect using licon to connect to
difftap or to poly and mcon ton connect to metal1

Beware that some rules are context dependent (via spacing at end of line or at
one side, wide metal3)

Beware different description exist of MIM capacitors
here met2, capm, met3 and via2 connects met2/capm to met3

=====================  =======  ==========    ====================================
SkyWater130 mask       Acronym  Layer name    Coriolis original
purpose                         for rule      layer name
=====================  =======  ==========    ====================================
N-Well                 NWM      nwm           nwell
Low Vt Nch             LVTNM    lvtn        
active diffusion                difftap       active
Poly 1                 P1M      poly          poly
P+ Implant             PSDM     psdm          pImplant
N+ Implant             NSDM     nsdm          nImplant
Local Intr Cont. 1     LICM1    licon         cut0 contact between difftap and li1,
                                              poly and li1
Local Intrcnct 1       LI1M     li            metal metal between poly and metal1
                                              for local interconnect
Contact                CTM1     mcon          cut1 contact between li1 and metal1
Metal 1                MM1      m1            metal1
Via                    VIM      via           cut2
Metal 2                MM2      m2            metal2
Via 2-PLM              VIM2     via2          cut3
Metal 3-PLM            MM3      m3            metal3
Via 2-PLM              VIM3     via3          cut4
Metal 4                MM4      m4            metal4
Via 4                  VIM4     via4          cut5
Metal 5                MM5      m5            metal5

capm                   CAPM     capm          metcap
Metal 2                MM2      bottom_plate  metbot
=====================  =======  ============  ====================================

"""


analogTechnologyTable = \
    ( ('Header', 'Sky130', DbU.UnitPowerMicro, 'rev.LIP6-1')
    # ------------------------------------------------------------------------------------
    # ( Rule name          , [Layer1]  , [Layer2]  , Value , Rule flags       , Reference )
    , ('physicalGrid'                              , 0.005 , Length           , 'GSF')
    , ('transistorMinL'                            , 0.15  , Length           , 'poly.1 and device details')
    #, ('transistorMinL'                            , 0.38  , Length           , 'lvtn.1a')
    , ('transistorMaxL'                            , 38    , Length           , 'rule0002')
    , ('transistorMinW'                            , 0.42  , Length           , 'difftap.2')
    #, ('transistorMinW'                            , 0.36  , Length           , 'difftap.2b')
    , ('transistorMaxW'                            , 4000  , Length           , 'rule0004')

    # N-WELL (nwm)
    , ('minWidth'          , 'nwm'                 , 0.84  , Length           , 'nwell.1')
    , ('minSpacing'        , 'nwm'                 , 1.27  , Length           , 'nwell.2a')
    , ('minArea'           , 'nwm'                 , 0     , Area             , 'N/A')

    # LVTN (lvtn)
    , ('minWidth'          , 'lvtn'                , 0.38  , Length           , 'lvtn.1a')
    , ('minSpacing'        , 'lvtn'                , 0.38  , Length           , 'lvtn.2')
    , ('minArea'           , 'lvtn'                , 0.265 , Area             , 'lvtn.13')
    , ('minEnclosure'      , 'nwm'     , 'lvtn'    , 0.38  , Length|Asymmetric, 'lvtn.10')

    # DIFF (difftap)
    , ('minWidth'          , 'difftap'             , 0.15  , Length           , 'difftap.1')
    , ('minSpacing'        , 'difftap'             , 0.27  , Length           , 'difftap.3')
    , ('minArea'           , 'difftap'             , 0     , Area             , 'N/A')
    , ('minEnclosure'      , 'nwm'     , 'difftap' , 0.18  , Length|Asymmetric, 'difftap.10')

    # Poly1 (poly)
    , ('minWidth'          , 'poly'                , 0.15  , Length           , 'poly.1a')
    , ('minSpacing'        , 'poly'                , 0.21  , Length           , 'poly.2')
    , ('minGateSpacing'    , 'poly'                , 0.21  , Length           , 'poly.2')
    , ('minArea'           , 'poly'                , 0     , Area             , 'N/A')
    , ('minSpacing'        , 'poly'    , 'difftap' , 0.075 , Length           , 'poly.4')
    , ('minExtension'      , 'poly'    , 'difftap' , 0.130 , Length|Asymmetric, 'poly.8')
    , ('minGateExtension'  , 'difftap' , 'poly'    , 0.25  , Length|Asymmetric, 'poly.7')
    , ('minExtension'      , 'difftap' , 'poly'    , 0.25  , Length|Asymmetric, 'poly.7')

    # 4.1.6 PPLUS (psdm)
    , ('minWidth'          , 'psdm'                , 0.38  , Length           , 'psd.1')
    , ('minSpacing'        , 'psdm'                , 0.38  , Length           , 'psd.2')
    , ('minArea'           , 'psdm'                , 0.255 , Area             , 'psd.10b')
    , ('minSpacing'        , 'psdm'    , 'difftap' , 0.130 , Length           , 'psd.7')
    , ('minGateExtension'  , 'psdm'    , 'poly'    , 0.00  , Length|Asymmetric, 'N/A')
    , ('minOverlap'        , 'psdm'    , 'difftap' , 0.00  , Length           , 'N/A')
    , ('minEnclosure'      , 'psdm'    , 'difftap' , 0.125 , Length|Asymmetric, 'psd.5a')
    , ('minStrapEnclosure' , 'psdm'    , 'difftap' , 0.125 , Length           , 'psd.5b')
    , ('minSpacing'        , 'nsdm'    , 'psdm'    , 0.00  , Length           , 'N/A')
    , ('minEnclosure'      , 'psdm'    , 'poly'    , 0     , Length|Asymmetric, 'N/A')
    , ('minLengthEnclosure', 'psdm'    , 'difftap' , 0     , Length|Asymmetric, 'N/A')
    , ('minWidthEnclosure' , 'psdm'    , 'poly'    , 0     , Length|Asymmetric, 'N/A')
    # Error: duplicated rule, needed by "old Pharos".
    , ('minExtension'      , 'psdm'    , 'difftap' , 0.125 , Length|Asymmetric, 'dup. psd.5a')
    , ('minStrapEnclosure' , 'psdm'                , 0.125 , Length           , 'dup. psd.5b')

    # NPLUS (nsdm)
    , ('minWidth'          , 'nsdm'                , 0.38  , Length           , 'nsd.1')
    , ('minSpacing'        , 'nsdm'                , 0.38  , Length           , 'nsd.2')
    , ('minArea'           , 'nsdm'                , 0.265 , Area             , 'nsd.10a')
    , ('minSpacing'        , 'nsdm'    , 'difftap' , 0.130 , Length           , 'nsd.7')
    , ('minGateExtension'  , 'nsdm'    , 'poly'    , 0     , Length|Asymmetric, 'N/A')
    , ('minOverlap'        , 'nsdm'    , 'difftap' , 0     , Length           , 'N/A')
    , ('minEnclosure'      , 'nsdm'    , 'difftap' , 0.125 , Length|Asymmetric, 'nsd.5a')
    , ('minStrapEnclosure' , 'nsdm'    , 'difftap' , 0.125 , Length           , 'nsd.5b')
    , ('minEnclosure'      , 'nsdm'    , 'nwm'     , 0     , Length|Asymmetric, 'N/A')
    , ('minEnclosure'      , 'nsdm'    , 'poly'    , 0     , Length|Asymmetric, 'N/A')
    , ('minLengthEnclosure', 'nsdm'    , 'difftap' , 0     , Length|Asymmetric, 'N/A')
    , ('minWidthEnclosure' , 'nsdm'    , 'poly'    , 0     , Length|Asymmetric, 'N/A')
    , ('minGateEnclosure'  , 'nsdm'    , 'poly'    , 0     , Length|Asymmetric, 'N/A')
    # Error: duplicated rule, needed by "old Pharos".
    , ('minExtension'      , 'nsdm'    , 'difftap' , 0.125 , Length|Asymmetric, 'dup. nsd.5a')
    , ('minStrapEnclosure' , 'nsdm'                , 0.215 , Length           , 'dup. nsd.5b')

    # LICM1 (licon)
    , ('minWidth'          , 'licon'               , 0.17  , Length           , 'licon.1')
    , ('minSpacing'        , 'licon'               , 0.17  , Length           , 'licon.2')
    , ('minGateSpacing'    , 'licon'   , 'poly'    , 0.25  , Length|Asymmetric, 'licon.10')
    , ('minSpacing'        , 'licon'   , 'poly'    , 0.25  , Length|Asymmetric, 'licon.10')
    , ('minSpacing'        , 'licon'   , 'difftap' , 0.19  , Length           , 'licon.14')
    #, ('minSpacing'        , 'licon'   , 'difftap' , 0.06  , Length           , 'licon.5b')
    , ('minEnclosure'      , 'difftap' , 'licon'   , 0.04  , Length|Asymmetric, 'licon.5a and licon.7 : 0.12 isolated tap')
    , ('minEnclosure'      , 'poly'    , 'licon'   , 0.05  , Length|Asymmetric, 'licon.8 and licon.8a : 0.08')
    , ('minEnclosure'      , 'psdm'    , 'licon'   , 0     , Length|Asymmetric, 'N/A')
    , ('minEnclosure'      , 'nsdm'    , 'licon'   , 0     , Length|Asymmetric, 'N/A')
    , ('minGateEnclosure'  , 'psdm'    , 'poly'    , 0     , Length|Asymmetric, 'N/A')
    # Error: duplicated rule, needed by "old Pharos".
    , ('minExtension'      , 'poly'    , 'licon'   , 0.05  , Length|Asymmetric, 'dup. licon.8 and licon.8a')
    , ('minExtension'      , 'psdm'    , 'licon'   , 0.25  , Length|Asymmetric, 'dup.')
    , ('minExtension'      , 'nsdm'    , 'licon'   , 0.25  , Length|Asymmetric, 'dup.')

    # LI1M (li)
    , ('minWidth'          , 'li'                  , 0.17  , Length           , 'li.1')
    , ('minSpacing'        , 'li'                  , 0.17  , Length           , 'li.3')
    , ('minArea'           , 'li'                  , 0.0561, Area             , 'li.6')
    , ('minEnclosure'      , 'li'      , 'licon'   , 0.08  , Length|Asymmetric, 'li.5')
    , ('minEnclosure'      , 'li'      , 'mcon'    , 0.00  , Length|Asymmetric, 'ct.4')

    # CTM1 (mcon)
    , ('minWidth'          , 'mcon'                , 0.17  , Length           , 'ct.1')
    , ('minSpacing'        , 'mcon'                , 0.19  , Length           , 'ct.2')


    # MM1 (m1)
    , ('minWidth'          , 'm1'                  , 0.14  , Length           , 'm1.1')
    , ('minSpacing'        , 'm1'                  , 0.14  , Length           , 'm1.2')
    , ('minArea'           , 'm1'                  , 0.083 , Area             , 'm1.6')
    , ('minEnclosure'      , 'm1'      , 'mcon'    , 0.03  , Length|Asymmetric, 'm1.4 and m1.5 : 0.06 one side')
    # Error: duplicated rule, needed by "old Pharos".
    , ('minExtension'      , 'm1'      , 'mcon'    , 0.03  , Length|Asymmetric, 'm1.4 and m1.5')

    # VIM (via)
    , ('minWidth'          , 'via'                 , 0.15  , Length           , 'via.1a')
    , ('minSpacing'        , 'via'                 , 0.17  , Length           , 'via.2')
    , ('minEnclosure'      , 'm1'      , 'via'     , 0.55  , Length|Asymmetric, 'via.4a and via.5a : 0.085 on one side')
    # Error: duplicated rule, needed by "old Pharos".
    , ('lineExtension'     , 'm1'      , 'via'     , 0.55  , Length|Asymmetric, 'dup. via.a4 and via.5a : 0.085 on one side')

    # MM2 (m2)
    , ('minWidth'          , 'm2'                  , 0.14  , Length           , 'm2.1')
    , ('minSpacing'        , 'm2'                  , 0.14  , Length           , 'm2.2')
    , ('minArea'           , 'm2'                  , 0.0676, Area             , 'm2.6')
    , ('minEnclosure'      , 'm2'      , 'via'     , 0.055 , Length|Asymmetric, 'm2.4 and m2.5 : 0.085 end of line')
    # Error: duplicated rule, needed by "old Pharos".
    , ('minExtension'      , 'm2'      , 'via'     , 0.055 , Length|Asymmetric, 'dup. m2.4 and m2.5 : 0.085 end of line')

    # VIM2 (via2)
    , ('minWidth'          , 'via2'                , 0.20  , Length           , 'via2.1a')
    , ('minSpacing'        , 'via2'                , 0.20  , Length           , 'via2.2')
    , ('minEnclosure'      , 'm2'      , 'via2'    , 0.04  , Length|Asymmetric, 'via2.4 via2.5 : 0.085 and via2.14')

    # MM3 (m3)
    , ('minWidth'          , 'm3'                  , 0.30  , Length           , 'm3.1')
    , ('minSpacing'        , 'm3'                  , 0.30  , Length           , 'm3.2')
    , ('minSpacing'        , 'widem3'              , 0.40  , Length           , 'm3.3d')
    , ('minArea'           , 'm3'                  , 0.24  , Area             , 'm3.6'        )
    , ('minEnclosure'      , 'm3'      , 'via2'    , 0.065 , Length|Asymmetric, 'm3.4')
    # Error: duplicated rule, needed by "old Pharos".
    , ('minExtension'      , 'm3'      , 'via2'    , 0.065 , Length|Asymmetric, 'dup. m3.4')

    # VIM3 (via3)
    , ('minWidth'          , 'via3'                , 0.20  , Length           , 'via3.1')
    , ('minSpacing'        , 'via3'                , 0.20  , Length           , 'via3.2')
    , ('minEnclosure'      , 'm3'      , 'via3'    , 0.060 , Length|Asymmetric, 'via3.4 and via3.5 end of line : 0.090')

    # MM4 (m4)
    , ('minWidth'          , 'm4'                  , 0.30  , Length           , 'm4.1')
    , ('minSpacing'        , 'm4'                  , 0.30  , Length           , 'm4.2')
    , ('minArea'           , 'm4'                  , 0.24  , Area             , 'm4.4a')
    , ('minEnclosure'      , 'm4'      , 'via3'    , 0.065 , Length|Asymmetric, 'm4.3')
    # Error: duplicated rule, needed by "old Pharos".
    , ('minExtension'      , 'm4'      , 'via3'    , 0.065 , Length|Asymmetric, 'dup. m4.3 ')

    # VIM4 (via4)
    , ('minWidth'          , 'via4'                , 0.80  , Length           , 'via4.1')
    , ('minSpacing'        , 'via4'                , 0.80  , Length           , 'via4.2')
    , ('minEnclosure'      , 'm4'      , 'via4'    , 0.19  , Length|Asymmetric, 'via4.4')

    # MM5 (m5)
    , ('minWidth'          , 'm5'                  , 1.6   , Length           , 'm5.1')
    , ('minSpacing'        , 'm5'                  , 1.6   , Length           , 'm5.2')
    , ('minArea'           , 'm5'                  , 4.00  , Area             , 'm5.4')
    , ('minEnclosure'      , 'm5'      , 'via4'    , 0.310 , Length|Asymmetric, 'm5.3')
    # Error: duplicated rule, needed by "old Pharos".
    , ('minExtension'      , 'm5'      , 'via4'    , 0.310 , Length|Asymmetric, 'dup. m5.3 ')


    #capm
    #, ('minWidth'          , 'metcap'              , 1.0  , Length           , 'capm.1')
    #, ('minWidth'          , 'metcapdum'           , 0.5  , Length           , '')
    #, ('maxWidth'          , 'metcap'              , 300.0 , Length           , '')
    #, ('maxWidth'          , 'metbot'              , 350.0 , Length           , '')
    #, ('minSpacing'        , 'metcap'              , 0.84 , Length           , 'capm.2a')
    #, ('minSpacing'        , 'metbot'              , 0.8  , Length           , 'metcap.2b')
    #, ('minSpacing'        , 'cut1'    , 'metcap'  , 0.50 , Length           , '')
    #, ('minSpacing'        , 'cut2'    , 'metcap'  , 0.50 , Length           , 'capm.5')
    #, ('minSpacingOnMetbot', 'cut2'                , 0.2  , Length           , 'via2.2')
    #, ('minSpacingOnMetbot', 'via2'                , 0.2  , Length           , 'via2.2')
    #, ('minSpacingOnMetcap', 'cut2'                , 0.2  , Length           , 'via2.2')
    #, ('minEnclosure'      , 'm2'      , 'metcap'  , 0.14 , Length|Asymmetric, 'capm.3')
    #, ('minEnclosure'      , 'metbot'  , 'cut1'    , 0.055, Length|Asymmetric, 'via.4a')
    #, ('minEnclosure'      , 'metbot'  , 'cut2'    , 0.04 , Length|Asymmetric, 'via2.14')
    #, ('minEnclosure'      , 'metcap'  , 'cut2'    , 0.14 , Length|Asymmetric, 'capm.4')
    #, ('minArea'           , 'metcap'              , 0    , Area             , 'na')
    #, ('minAreaInMetcap'   , 'cut2'                , 0    , Area             , 'na')
    #, ('MIMCap'                                    , 1.25 , Unit             , 'na')
    #, ('MIMPerimeterCap'                           , 0.17 , Unit             , 'na')

      
    #capm
    , ('minWidth'          , 'capm'                , 1.0  , Length           , 'capm.1')
    , ('minWidth'          , 'capmdum'             , 0.5  , Length           , '')
    , ('maxWidth'          , 'capm'                , 30.0 , Length           , '')
    , ('maxWidth'          , 'metbot'              , 35.0 , Length           , '')
    , ('minSpacing'        , 'capm'                , 0.84 , Length           , 'capm.2a')
   #, ('minSpacing'        , 'm3'                  , 0.8  , Length           , 'capm.2b')
    , ('minSpacingWide1'   , 'm2'                  , 0.8  , Length           , 'capm.2b')
    , ('minSpacing'        , 'via'     , 'capm'    , 0.50 , Length           , 'fake')
    , ('minSpacing'        , 'via2'    , 'capm'    , 0.50 , Length           , 'capm.5')
    , ('minSpacingOnMetBot', 'via2'                , 0.2  , Length           , 'via2.2')
    , ('minSpacingOnMetCap', 'via2'                , 0.2  , Length           , 'via2.2')
    , ('minSpacingOnMetBot', 'via'                 , 0.2  , Length           , 'via2.2 fake')
    , ('minSpacingOnMetCap', 'via'                 , 0.2  , Length           , 'via2.2 fake')
    , ('minEnclosure'      , 'm2'      , 'capm'    , 0.14 , Length|Asymmetric, 'capm.3')
    , ('minEnclosure'      , 'm3'      , 'via'     , 0.055, Length|Asymmetric, 'via.4a')
    , ('minEnclosure'      , 'm3'      , 'via2'    , 0.04 , Length|Asymmetric, 'via2.14')
    , ('minEnclosure'      , 'capm'    , 'via'     , 0.14 , Length|Asymmetric, 'capm.4 fake')
    , ('minEnclosure'      , 'capm'    , 'via2'    , 0.14 , Length|Asymmetric, 'capm.4')
    , ('minArea'           , 'capm'                , 0    , Area             , 'na')
    , ('minAreaInMetcap'   , 'via2'                , 0    , Area             , 'na')
    , ('MIMCap'                                    , 1.25 , Unit             , 'na')
    , ('MIMPerimeterCap'                           , 0.17 , Unit             , 'na')
    , ('PIPCap'                                    , 1.25 , Unit             , 'na')
    , ('PIPPerimeterCap'                           , 0.17 , Unit             , 'na')

    )


def _loadDtr ():
    """
    Load design kit physical rules for SkyWater 130nm.
    """
    loadAnalogTechno( analogTechnologyTable, __file__ )


def _loadDevices ():
    print( 'Loading devices' )
    addDevice( name       = 'DifferentialPairBulkConnected'
            #, spice      = spiceDir+'DiffPairBulkConnected.spi'
             , connectors = ( 'D1', 'D2', 'G1', 'G2', 'S' )
             , layouts    = ( ('Horizontal M2'  , 'coriolis.oroshi.DP_horizontalM2.py'    )   
                            , ('Symmetrical'    , 'coriolis.oroshi.DP_symmetrical.py'     )   
                            , ('Common centroid', 'coriolis.oroshi.DP_2DCommonCentroid.py')
                            , ('Interdigitated' , 'coriolis.oroshi.DP_interdigitated.py'  )
                            , ('WIP DP'         , 'coriolis.oroshi.wip_dp.py'             )
                            )
             )
    addDevice( name       = 'DifferentialPairBulkUnconnected'
            #, spice      = spiceDir+'DiffPairBulkUnconnected.spi'
             , connectors = ( 'D1', 'D2', 'G1', 'G2', 'S', 'B' )
             , layouts    = ( ('Horizontal M2'  , 'coriolis.oroshi.DP_horizontalM2.py'    )   
                            , ('Symmetrical'    , 'coriolis.oroshi.DP_symmetrical.py'     )   
                            , ('Common centroid', 'coriolis.oroshi.DP_2DCommonCentroid.py')
                            , ('Interdigitated' , 'coriolis.oroshi.DP_interdigitated.py'  )
                            , ('WIP DP'         , 'coriolis.oroshi.wip_dp.py'             )
                            )
             )
    addDevice( name       = 'LevelShifterBulkUnconnected'
            #, spice      = spiceDir+'LevelShifterBulkUnconnected.spi'
             , connectors = ( 'D1', 'D2', 'S1', 'S2', 'B' )
             , layouts    = ( ('Horizontal M2'  , 'coriolis.oroshi.LS_horizontalM2.py'    )   
                            , ('Symmetrical'    , 'coriolis.oroshi.LS_symmetrical.py'     )   
                            , ('Common centroid', 'coriolis.oroshi.LS_2DCommonCentroid.py')
                            , ('Interdigitated' , 'coriolis.oroshi.LS_interdigitated.py'  )
                            )
             )
    addDevice( name       = 'TransistorBulkConnected'
            #, spice      = spiceDir+'TransistorBulkConnected.spi'
             , connectors = ( 'D', 'G', 'S' )
             , layouts    = ( ('Rotate transistor', 'coriolis.oroshi.Transistor_rotate.py')
                            , ('Common transistor', 'coriolis.oroshi.Transistor_common.py')
                            , ('WIP Transistor'   , 'coriolis.oroshi.wip_transistor.py'   )   
                            )
             )
    addDevice( name       = 'TransistorBulkUnconnected'
            #, spice      = spiceDir+'TransistorBulkUnconnected.spi'
             , connectors = ( 'D', 'G', 'S', 'B' )
             , layouts    = ( ('Rotate transistor', 'coriolis.oroshi.Transistor_rotate.py')
                            , ('Common transistor', 'coriolis.oroshi.Transistor_common.py')
                            , ('WIP Transistor'   , 'coriolis.oroshi.wip_transistor.py'   )
                            )
             )
    addDevice( name       = 'CrossCoupledPairBulkConnected'
            #, spice      = spiceDir+'CCPairBulkConnected.spi'
             , connectors = ( 'D1', 'D2', 'S' )
             , layouts    = ( ('Horizontal M2'  , 'coriolis.oroshi.CCP_horizontalM2.py'    )
                            , ('Symmetrical'    , 'coriolis.oroshi.CCP_symmetrical.py'     )
                            , ('Common centroid', 'coriolis.oroshi.CCP_2DCommonCentroid.py')
                            , ('Interdigitated' , 'coriolis.oroshi.CCP_interdigitated.py'  )
                            )
             )
    addDevice( name       = 'CrossCoupledPairBulkUnconnected'
            #, spice      = spiceDir+'CCPairBulkUnconnected.spi'
             , connectors = ( 'D1', 'D2', 'S', 'B' )
             , layouts    = ( ('Horizontal M2'  , 'coriolis.oroshi.CCP_horizontalM2.py'    )
                            , ('Symmetrical'    , 'coriolis.oroshi.CCP_symmetrical.py'     )
                            , ('Common centroid', 'coriolis.oroshi.CCP_2DCommonCentroid.py')
                            , ('Interdigitated' , 'coriolis.oroshi.CCP_interdigitated.py'  )
                            )
             )
    addDevice( name       = 'CommonSourcePairBulkConnected'
            #, spice      = spiceDir+'CommonSourcePairBulkConnected.spi'
             , connectors = ( 'D1', 'D2', 'S', 'G' )
             , layouts    = ( ('Horizontal M2'  , 'coriolis.oroshi.CSP_horizontalM2.py'    )
                            , ('Symmetrical'    , 'coriolis.oroshi.CSP_symmetrical.py'     )
                            , ('Interdigitated' , 'coriolis.oroshi.CSP_interdigitated.py'  )
                            , ('WIP CSP'        , 'coriolis.oroshi.wip_csp.py'             )
                            )
             )
    addDevice( name       = 'CommonSourcePairBulkUnconnected'
            #, spice      = spiceDir+'CommonSourcePairBulkUnconnected.spi'
             , connectors = ( 'D1', 'D2', 'S', 'G', 'B' )
             , layouts    = ( ('Horizontal M2'  , 'coriolis.oroshi.CSP_horizontalM2.py'    )
                            , ('Symmetrical'    , 'coriolis.oroshi.CSP_symmetrical.py'     )
                            , ('Interdigitated' , 'coriolis.oroshi.CSP_interdigitated.py'  )
                            , ('WIP CSP'        , 'coriolis.oroshi.wip_csp.py'             )
                            )
             )
    addDevice( name       = 'SimpleCurrentMirrorBulkConnected'
            #, spice      = spiceDir+'CurrMirBulkConnected.spi'
             , connectors = ( 'D1', 'D2', 'S' )
             , layouts    = ( ('Horizontal M2'  , 'coriolis.oroshi.SCM_horizontalM2.py'    )
                            , ('Symmetrical'    , 'coriolis.oroshi.SCM_symmetrical.py'     )
                            , ('Common centroid', 'coriolis.oroshi.SCM_2DCommonCentroid.py')
                            , ('Interdigitated' , 'coriolis.oroshi.SCM_interdigitated.py'  )
                            )
             )
    addDevice( name       = 'SimpleCurrentMirrorBulkUnconnected'
            #, spice      = spiceDir+'CurrMirBulkUnconnected.spi'
             , connectors = ( 'D1', 'D2', 'S', 'B' )
             , layouts    = ( ('Horizontal M2'  , 'coriolis.oroshi.SCM_horizontalM2.py'    )
                            , ('Symmetrical'    , 'coriolis.oroshi.SCM_symmetrical.py'     )
                            , ('Common centroid', 'coriolis.oroshi.SCM_2DCommonCentroid.py')
                            , ('Interdigitated' , 'coriolis.oroshi.SCM_interdigitated.py'  )
                            )
             )
    addDevice( name       = 'MultiCapacitor'
            #, spice      = spiceDir+'MIM_OneCapacitor.spi'
             , connectors = ( 'T1', 'B1' )
             , layouts    = ( ('Matrix', 'coriolis.oroshi.multicapacitor.py' ),
                            )
             )
    #addDevice( name       = 'Resistor'
    #        #, spice      = spiceDir+'MIM_OneCapacitor.spi'
    #         , connectors = ( 'PIN1', 'PIN2' )
    #         , layouts    = ( ('Snake', 'coriolis.oroshi.resistorsnake.py' ),
    #                        )
    #         )


def _setupTechnoSymb ():
    tech = DataBase.getDB().getTechnology()
    tech.addLayerAlias( 'nwm'     ,  'nWell'     )
    tech.addLayerAlias( 'difftap' ,  'active'    )
   #tech.addLayerAlias( 'poly'    ,  'poly'      )
    tech.addLayerAlias( 'psdm'    ,  'pImplant'  )
    tech.addLayerAlias( 'nsdm'    ,  'nImplant'  )
    tech.addLayerAlias( 'licon'   ,  'cut0'      )
    tech.addLayerAlias( 'li'      ,  'metal1'    )
    tech.addLayerAlias( 'mcon'    ,  'cut1'      )
    tech.addLayerAlias( 'm1'      ,  'metal2'    )
    tech.addLayerAlias( 'via'     ,  'cut2'      )
    tech.addLayerAlias( 'm2'      ,  'metal3'    )
    tech.addLayerAlias( 'via2'    ,  'cut3'      )
    tech.addLayerAlias( 'm3'      ,  'metal4'    )
    tech.addLayerAlias( 'via3'    ,  'cut4'      )
    tech.addLayerAlias( 'm4'      ,  'metla5'    )
    tech.addLayerAlias( 'via4'    ,  'cut5'      )
    tech.addLayerAlias( 'm5'      ,  'metal6'    )
    tech.addLayerAlias( 'm1.block', 'blockage1'  )
    tech.addLayerAlias( 'm2.block', 'blockage2'  )
    tech.addLayerAlias( 'm3.block', 'blockage3'  )
    tech.addLayerAlias( 'm4.block', 'blockage4'  )
    tech.addLayerAlias( 'm5.block', 'blockage5'  )
    tech.addLayerAlias( 'capm'    ,  'metcap'    )
    tech.addLayerAlias( 'capm'    ,  'metcapdum' )
    tech.addLayerAlias( 'm3'      ,  'metbot'    )

    nWell     = tech.getBasicLayer( 'nwm'     )
    active    = tech.getBasicLayer( 'difftap' )
    poly      = tech.getBasicLayer( 'poly'    )
    pImplant  = tech.getBasicLayer( 'psdm'    )
    nImplant  = tech.getBasicLayer( 'nsdm'    )
    cut0      = tech.getBasicLayer( 'licon'   )
    metal1    = tech.getBasicLayer( 'li'      )
    cut1      = tech.getBasicLayer( 'mcon'    )
    metal2    = tech.getBasicLayer( 'm1'      )
    cut2      = tech.getBasicLayer( 'via'     )
    metal3    = tech.getBasicLayer( 'm2'      )
    cut3      = tech.getBasicLayer( 'via2'    )
    metal4    = tech.getBasicLayer( 'm3'      )
    cut4      = tech.getBasicLayer( 'via3'    )
    metal5    = tech.getBasicLayer( 'm4'      )
    cut5      = tech.getBasicLayer( 'via4'    )
    metal6    = tech.getBasicLayer( 'm5'      )
    blockage1 = tech.getBasicLayer( 'blockage1' )
    blockage2 = tech.getBasicLayer( 'blockage2' )
    blockage3 = tech.getBasicLayer( 'blockage3' )
    blockage4 = tech.getBasicLayer( 'blockage4' )
    blockage5 = tech.getBasicLayer( 'blockage5' )

    # Composite/Symbolic layers.
    NWELL       = RegularLayer   .create( tech, 'NWELL'      , nWell    )
    #PWELL       = RegularLayer   .create( tech, 'PWELL'      , pWell    )
    NTIE        = DiffusionLayer .create( tech, 'NTIE'       , nImplant , active, nWell)
    PTIE        = DiffusionLayer .create( tech, 'PTIE'       , pImplant , active, None)
    NDIF        = DiffusionLayer .create( tech, 'NDIF'       , nImplant , active, None )
    PDIF        = DiffusionLayer .create( tech, 'PDIF'       , pImplant , active, None )
    GATE        = DiffusionLayer .create( tech, 'GATE'       , poly     , active, None )
    NTRANS      = TransistorLayer.create( tech, 'NTRANS'     , nImplant , active, poly, None )
    PTRANS      = TransistorLayer.create( tech, 'PTRANS'     , pImplant , active, poly, nWell )
    POLY        = RegularLayer   .create( tech, 'POLY'       , poly     )
    #POLY2       = RegularLayer   .create( tech, 'POLY2'      , poly2    )
    METAL1      = RegularLayer   .create( tech, 'METAL1'     , metal1   )
    METAL2      = RegularLayer   .create( tech, 'METAL2'     , metal2   )
    METAL3      = RegularLayer   .create( tech, 'METAL3'     , metal3   )
    METAL4      = RegularLayer   .create( tech, 'METAL4'     , metal4   )
    METAL5      = RegularLayer   .create( tech, 'METAL5'     , metal5   )
    #METAL6      = RegularLayer   .create( tech, 'METAL6'     , metal6   )
    #METAL7      = RegularLayer   .create( tech, 'METAL7'     , metal7   )
    #METAL8      = RegularLayer   .create( tech, 'METAL8'     , metal8   )
    #METAL9      = RegularLayer   .create( tech, 'METAL9'     , metal9   )
    #METAL10     = RegularLayer   .create( tech, 'METAL10'    , metal10  )
    CONT_BODY_N = ContactLayer   .create( tech, 'CONT_BODY_N', nImplant , active, cut0, metal1, None )
    CONT_BODY_P = ContactLayer   .create( tech, 'CONT_BODY_P', pImplant , active, cut0, metal1, None )
    CONT_DIF_N  = ContactLayer   .create( tech, 'CONT_DIF_N' , nImplant , active, cut0, metal1, None )
    CONT_DIF_P  = ContactLayer   .create( tech, 'CONT_DIF_P' , pImplant , active, cut0, metal1, None )
    CONT_POLY   = ViaLayer       .create( tech, 'CONT_POLY'  ,              poly, cut0, metal1 )
    
    # VIAs for symbolic technologies.
    VIA12      = ViaLayer    .create( tech, 'VIA12'     , metal1, cut1, metal2  )
    VIA23      = ViaLayer    .create( tech, 'VIA23'     , metal2, cut2, metal3  )
    #VIA23cap   = ViaLayer    .create( tech, 'VIA23cap'  , metcap, cut2, metal3  )
    VIA34      = ViaLayer    .create( tech, 'VIA34'     , metal3, cut3, metal4  )
    VIA45      = ViaLayer    .create( tech, 'VIA45'     , metal4, cut4, metal5  )
    VIA56      = ViaLayer    .create( tech, 'VIA56'     , metal5, cut5, metal6  )
    #VIA67      = ViaLayer    .create( tech, 'VIA67'     , metal6, cut6, metal7  )
    #VIA78      = ViaLayer    .create( tech, 'VIA78'     , metal7, cut7, metal8  )
    #VIA89      = ViaLayer    .create( tech, 'VIA89'     , metal8, cut8, metal9  )
    #VIA910     = ViaLayer    .create( tech, 'VIA910'    , metal9, cut9, metal10 )
    BLOCKAGE1  = RegularLayer.create( tech, 'BLOCKAGE1' , blockage1  )
    BLOCKAGE2  = RegularLayer.create( tech, 'BLOCKAGE2' , blockage2  )
    BLOCKAGE3  = RegularLayer.create( tech, 'BLOCKAGE3' , blockage3  )
    BLOCKAGE4  = RegularLayer.create( tech, 'BLOCKAGE4' , blockage4  )
    BLOCKAGE5  = RegularLayer.create( tech, 'BLOCKAGE5' , blockage5  )
    #BLOCKAGE6  = RegularLayer.create( tech, 'BLOCKAGE6' , blockage6  )
    #BLOCKAGE7  = RegularLayer.create( tech, 'BLOCKAGE7' , blockage7  )
    #BLOCKAGE8  = RegularLayer.create( tech, 'BLOCKAGE8' , blockage8  )
    #BLOCKAGE9  = RegularLayer.create( tech, 'BLOCKAGE9' , blockage9  )
    #BLOCKAGE10 = RegularLayer.create( tech, 'BLOCKAGE10', blockage10 )
    #gcontact   = ViaLayer    .create( tech, 'gcontact'  , gmetalh   , gcut, gmetalv )
    
    tech.setSymbolicLayer( CONT_BODY_N.getName() )
    tech.setSymbolicLayer( CONT_BODY_P.getName() )
    tech.setSymbolicLayer( CONT_DIF_N .getName() )
    tech.setSymbolicLayer( CONT_DIF_P .getName() )
    tech.setSymbolicLayer( CONT_POLY  .getName() )
    tech.setSymbolicLayer( POLY       .getName() )
    #tech.setSymbolicLayer( POLY2      .getName() )
    tech.setSymbolicLayer( METAL1     .getName() )
    tech.setSymbolicLayer( METAL2     .getName() )
    tech.setSymbolicLayer( METAL3     .getName() )
    tech.setSymbolicLayer( METAL4     .getName() )
    tech.setSymbolicLayer( METAL5     .getName() )
    #tech.setSymbolicLayer( METAL6     .getName() )
    #tech.setSymbolicLayer( METAL7     .getName() )
    #tech.setSymbolicLayer( METAL8     .getName() )
    #tech.setSymbolicLayer( METAL9     .getName() )
    #tech.setSymbolicLayer( METAL10    .getName() )
    tech.setSymbolicLayer( BLOCKAGE1  .getName() )
    tech.setSymbolicLayer( BLOCKAGE2  .getName() )
    tech.setSymbolicLayer( BLOCKAGE3  .getName() )
    tech.setSymbolicLayer( BLOCKAGE4  .getName() )
    tech.setSymbolicLayer( BLOCKAGE5  .getName() )
    #tech.setSymbolicLayer( BLOCKAGE6  .getName() )
    #tech.setSymbolicLayer( BLOCKAGE7  .getName() )
    #tech.setSymbolicLayer( BLOCKAGE8  .getName() )
    #tech.setSymbolicLayer( BLOCKAGE9  .getName() )
    #tech.setSymbolicLayer( BLOCKAGE10 .getName() )
    tech.setSymbolicLayer( VIA12      .getName() )
    tech.setSymbolicLayer( VIA23      .getName() )
    tech.setSymbolicLayer( VIA34      .getName() )
    tech.setSymbolicLayer( VIA45      .getName() )
    tech.setSymbolicLayer( VIA56      .getName() )
    #tech.setSymbolicLayer( VIA67      .getName() )
    #tech.setSymbolicLayer( VIA78      .getName() )
    #tech.setSymbolicLayer( VIA89      .getName() )
    #tech.setSymbolicLayer( VIA910     .getName() )
    
    NWELL.setExtentionCap( nWell, l(0.0) )
    #PWELL.setExtentionCap( pWell, l(0.0) )
    
    NTIE.setMinimalSize   (           l(3.0) )
    NTIE.setExtentionCap  ( nWell   , l(1.5) )
    NTIE.setExtentionWidth( nWell   , l(0.5) )
    NTIE.setExtentionCap  ( nImplant, l(1.0) )
    NTIE.setExtentionWidth( nImplant, l(0.5) )
    NTIE.setExtentionCap  ( active  , l(0.5) )
    NTIE.setExtentionWidth( active  , l(0.0) )
    
    PTIE.setMinimalSize   (           l(3.0) )
    PTIE.setExtentionCap  ( nWell   , l(1.5) )
    PTIE.setExtentionWidth( nWell   , l(0.5) )
    PTIE.setExtentionCap  ( nImplant, l(1.0) )
    PTIE.setExtentionWidth( nImplant, l(0.5) )
    PTIE.setExtentionCap  ( active  , l(0.5) )
    PTIE.setExtentionWidth( active  , l(0.0) )
    
    NDIF.setMinimalSize   (           l(3.0) )
    NDIF.setExtentionCap  ( nImplant, l(1.0) )
    NDIF.setExtentionWidth( nImplant, l(0.5) )
    NDIF.setExtentionCap  ( active  , l(0.5) )
    NDIF.setExtentionWidth( active  , l(0.0) )
    
    PDIF.setMinimalSize   (           l(3.0) )
    PDIF.setExtentionCap  ( pImplant, l(1.0) )
    PDIF.setExtentionWidth( pImplant, l(0.5) )
    PDIF.setExtentionCap  ( active  , l(0.5) )
    PDIF.setExtentionWidth( active  , l(0.0) )
    
    GATE.setMinimalSize   (           l(1.0) )
    GATE.setExtentionCap  ( poly    , l(1.5) )
    
    NTRANS.setMinimalSize   (           l( 1.0) )
    NTRANS.setExtentionCap  ( nImplant, l(-1.0) )
    NTRANS.setExtentionWidth( nImplant, l( 2.5) )
    NTRANS.setExtentionCap  ( active  , l(-1.5) )
    NTRANS.setExtentionWidth( active  , l( 2.0) )
    
    PTRANS.setMinimalSize   (           l( 1.0) )
    PTRANS.setExtentionCap  ( nWell   , l(-1.0) )
    PTRANS.setExtentionWidth( nWell   , l( 4.5) )
    PTRANS.setExtentionCap  ( pImplant, l(-1.0) )
    PTRANS.setExtentionWidth( pImplant, l( 4.0) )
    PTRANS.setExtentionCap  ( active  , l(-1.5) )
    PTRANS.setExtentionWidth( active  , l( 3.0) )
    
    POLY .setMinimalSize   (           l(1.0) )
    POLY .setExtentionCap  ( poly    , l(0.5) )
    #POLY2.setMinimalSize   (           l(1.0) )
    #POLY2.setExtentionCap  ( poly    , l(0.5) )
    
    METAL1 .setMinimalSize   (           l(1.0) )
    METAL1 .setExtentionCap  ( metal1  , l(0.5) )
    METAL2 .setMinimalSize   (           l(1.0) )
    METAL2 .setExtentionCap  ( metal2  , l(1.0) )
    METAL3 .setMinimalSize   (           l(1.0) )
    METAL3 .setExtentionCap  ( metal3  , l(1.0) )
    METAL4 .setMinimalSize   (           l(1.0) )
    METAL4 .setExtentionCap  ( metal4  , l(1.0) )
    METAL4 .setMinimalSpacing(           l(3.0) )
    METAL5 .setMinimalSize   (           l(2.0) )
    METAL5 .setExtentionCap  ( metal5  , l(1.0) )
    #METAL6 .setMinimalSize   (           l(2.0) )
    #METAL6 .setExtentionCap  ( metal6  , l(1.0) )
    #METAL7 .setMinimalSize   (           l(2.0) )
    #METAL7 .setExtentionCap  ( metal7  , l(1.0) )
    #METAL8 .setMinimalSize   (           l(2.0) )
    #METAL8 .setExtentionCap  ( metal8  , l(1.0) )
    #METAL9 .setMinimalSize   (           l(2.0) )
    #METAL9 .setExtentionCap  ( metal9  , l(1.0) )
    #METAL10.setMinimalSize   (           l(2.0) )
    #METAL10.setExtentionCap  ( metal10 , l(1.0) )
    
    # Contacts (i.e. Active <--> Metal) (symbolic).
    CONT_BODY_N.setMinimalSize(           l( 1.0) )
    CONT_BODY_N.setEnclosure  ( nWell   , l( 1.5), Layer.EnclosureH|Layer.EnclosureV )
    CONT_BODY_N.setEnclosure  ( nImplant, l( 1.5), Layer.EnclosureH|Layer.EnclosureV )
    CONT_BODY_N.setEnclosure  ( active  , l( 1.0), Layer.EnclosureH|Layer.EnclosureV )
    CONT_BODY_N.setEnclosure  ( metal1  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    
    CONT_BODY_P.setMinimalSize(           l( 1.0) )
    #CONT_BODY_P.setEnclosure  ( pWell   , l( 1.5), Layer.EnclosureH|Layer.EnclosureV )
    CONT_BODY_P.setEnclosure  ( pImplant, l( 1.5), Layer.EnclosureH|Layer.EnclosureV )
    CONT_BODY_P.setEnclosure  ( active  , l( 1.0), Layer.EnclosureH|Layer.EnclosureV )
    CONT_BODY_P.setEnclosure  ( metal1  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    
    CONT_DIF_N.setMinimalSize(           l( 1.0) )
    CONT_DIF_N.setEnclosure  ( nImplant, l( 1.0), Layer.EnclosureH|Layer.EnclosureV )
    CONT_DIF_N.setEnclosure  ( active  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    CONT_DIF_N.setEnclosure  ( metal1  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    
    CONT_DIF_P.setMinimalSize(           l( 1.0) )
    CONT_DIF_P.setEnclosure  ( pImplant, l( 1.0), Layer.EnclosureH|Layer.EnclosureV )
    CONT_DIF_P.setEnclosure  ( active  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    CONT_DIF_P.setEnclosure  ( metal1  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    
    CONT_POLY.setMinimalSize(           l( 1.0) )
    CONT_POLY.setEnclosure  ( poly    , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    CONT_POLY.setEnclosure  ( metal1  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    
    # VIAs (i.e. Metal <--> Metal) (symbolic).
    VIA12 .setMinimalSize   (           l( 1.0) )
    VIA12 .setEnclosure     ( metal1  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    VIA12 .setEnclosure     ( metal2  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    VIA12 .setMinimalSpacing(           l( 4.0) )
    VIA23 .setMinimalSize   (           l( 1.0) )
    VIA23 .setEnclosure     ( metal2  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    VIA23 .setEnclosure     ( metal3  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    VIA23 .setMinimalSpacing(           l( 4.0) )
    VIA34 .setMinimalSize   (           l( 1.0) )
    VIA34 .setEnclosure     ( metal3  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    VIA34 .setEnclosure     ( metal4  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    VIA34 .setMinimalSpacing(           l( 4.0) )
    VIA45 .setMinimalSize   (           l( 1.0) )
    VIA45 .setEnclosure     ( metal4  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    VIA45 .setEnclosure     ( metal5  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    VIA45 .setMinimalSpacing(           l( 4.0) )
    #VIA56 .setMinimalSize   (           l( 1.0) )
    #VIA56 .setEnclosure     ( metal5  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    #VIA56 .setEnclosure     ( metal6  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    #VIA56 .setMinimalSpacing(           l( 4.0) )
    #VIA67 .setMinimalSize   (           l( 1.0) )
    #VIA67 .setEnclosure     ( metal6  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    #VIA67 .setEnclosure     ( metal7  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    #VIA67 .setMinimalSpacing(           l( 4.0) )
    #VIA78 .setMinimalSpacing(           l( 4.0) )
    #VIA78 .setMinimalSize   (           l( 1.0) )
    #VIA78 .setEnclosure     ( metal7  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    #VIA78 .setEnclosure     ( metal8  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    #VIA78 .setMinimalSpacing(           l( 4.0) )
    #VIA89 .setMinimalSize   (           l( 1.0) )
    #VIA89 .setEnclosure     ( metal8  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    #VIA89 .setEnclosure     ( metal9  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    #VIA89 .setMinimalSpacing(           l( 4.0) )
    #VIA910.setMinimalSize   (           l( 1.0) )
    #VIA910.setEnclosure     ( metal9  , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    #VIA910.setEnclosure     ( metal10 , l( 0.5), Layer.EnclosureH|Layer.EnclosureV )
    #VIA910.setMinimalSpacing(           l( 4.0) )
    
    # Blockages (symbolic).
    BLOCKAGE1 .setMinimalSize (             l( 1.0) )
    BLOCKAGE1 .setExtentionCap( blockage1 , l( 0.5) )
    BLOCKAGE2 .setMinimalSize (             l( 2.0) )
    BLOCKAGE2 .setExtentionCap( blockage2 , l( 0.5) )
    BLOCKAGE3 .setMinimalSize (             l( 2.0) )
    BLOCKAGE3 .setExtentionCap( blockage3 , l( 0.5) )
    BLOCKAGE4 .setMinimalSize (             l( 2.0) )
    BLOCKAGE4 .setExtentionCap( blockage4 , l( 0.5) )
    BLOCKAGE5 .setMinimalSize (             l( 2.0) )
    BLOCKAGE5 .setExtentionCap( blockage5 , l( 1.0) )
    #BLOCKAGE6 .setMinimalSize (             l( 2.0) )
    #BLOCKAGE6 .setExtentionCap( blockage6 , l( 1.0) )
    #BLOCKAGE7 .setMinimalSize (             l( 2.0) )
    #BLOCKAGE7 .setExtentionCap( blockage7 , l( 1.0) )
    #BLOCKAGE8 .setMinimalSize (             l( 2.0) )
    #BLOCKAGE8 .setExtentionCap( blockage8 , l( 1.0) )
    #BLOCKAGE9 .setMinimalSize (             l( 2.0) )
    #BLOCKAGE9 .setExtentionCap( blockage9 , l( 1.0) )
    #BLOCKAGE10.setMinimalSize (             l( 2.0) )
    #BLOCKAGE10.setExtentionCap( blockage10, l( 1.0) )


def fix ():
    _setupTechnoSymb()
    _loadDtr()
    _loadDevices()
        
