
"""
Coriolis Design Technological Rules (DTR) for SkyWater 130nm CMOS General Purpose
=================================================================================

:Version: rev.LIP6-1
:Date:    December 21, 2022
:Authors: Marie-Minerve Louerat

Reference documents: 
    https://skywater-pdk.readthedocs.io/en/main/rules/masks.html
    https://skywater-pdk.readthedosc.io/en/main/rules/periphery.html#x

Beware of the existence of li1 local interconnect using licon to connect to
difftap or to poly and mcon ton connect to metal1

Beware that some rules are context dependent (via spacing at end of line or at
one side, wide metal3)

=====================  =======  ==========  ====================================
SkyWater130 mask       Acronym  Layer name  Coriolis original
purpose                         for rule    layer name
=====================  =======  ==========  ====================================
N-Well                 NWM      nwm         nwell
Low Vt Nch             LVTNM    lvtn        
active diffusion                difftap     active
Poly 1                 P1M      poly        poly
P+ Implant             PSDM     psdm        pImplant
N+ Implant             NSDM     nsdm        nImplant
Local Intr Cont. 1     LICM1    licon       cut0 contact between difftap and li1,
                                            poly and li1
Local Intrcnct 1       LI1M     li          metal metal between poly and metal1
                                            for local interconnect
Contact                CTM1     mcon        cut1 contact between li1 and metal1
Metal 1                MM1      m1          metal1
Via                    VIM      via         cut2
Metal 2                MM2      m2          metal2
Via 2-PLM              VIM2     via2        cut3
Metal 3-PLM            MM3      m3          metal3
Via 2-PLM              VIM3     via3        cut4
Metal 4                MM4      m4          metal4
Via 4                  VIM4     via4        cut5
Metal 5                MM5      m5          metal5
=====================  =======  ==========  ====================================

"""

from   Hurricane            import DbU
from   helpers              import truncPath
from   helpers.io           import vprint
from   helpers.analogtechno import Length, Unit, Area, Asymmetric, loadAnalogTechno, \
                                   addDevice
from   oroshi               import dtr


__all__ = [ 'loadDtr', 'loadDevices' ]


analogTechnologyTable = \
    ( ('Header', 'Sky130', DbU.UnitPowerMicro, 'rev.LIP6-1')
    # ------------------------------------------------------------------------------------
    # ( Rule name          , [Layer1]  , [Layer2]  , Value , Rule flags       , Reference )
    , ('physicalGrid'                              , 0.005 , Length           , 'GSF')
    , ('transistorMinL'                            , 0.38  , Length           , 'lvtn.1a')
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
    , ('minGateExtension'  , 'psdm'    , 'poly'    , 0.45  , Length|Asymmetric, 'N/A')
    , ('minOverlap'        , 'psdm'    , 'difftap' , 0.45  , Length           , 'N/A')
    , ('minEnclosure'      , 'psdm'    , 'difftap' , 0.125 , Length|Asymmetric, 'psd.5a')
    , ('minStrapEnclosure' , 'psdm'    , 'difftap' , 0.125 , Length           , 'psd.5b')
    , ('minSpacing'        , 'nsdm'    , 'psdm'    , 0.25  , Length           , 'N/A')
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
    , ('minSpacing'        , 'licon'   , 'difftap' , 0.06  , Length           , 'licon.5b')
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
    , ('minEnclosure'      , 'm1'      , 'mcon'    , 0.03  , Length|Asymmetric, 'm1.4 and m1.5 : 0.085 end of line')
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

    )


def loadDtr ():
    """
    Load design kit physical rules for SkyWater 130nm.
    """
    loadAnalogTechno( analogTechnologyTable, __file__ )


def loadDevices ():
    addDevice( name       = 'DifferentialPairBulkConnected'
            #, spice      = spiceDir+'DiffPairBulkConnected.spi'
             , connectors = ( 'D1', 'D2', 'G1', 'G2', 'S' )
             , layouts    = ( ('Horizontal M2'  , 'DP_horizontalM2.py'    )   
                            , ('Symmetrical'    , 'DP_symmetrical.py'     )   
                            , ('Common centroid', 'DP_2DCommonCentroid.py')
                            , ('Interdigitated' , 'DP_interdigitated.py'  )
                            , ('WIP DP'         , 'wip_dp.py'             )
                            )
             )
    addDevice( name       = 'DifferentialPairBulkUnconnected'
            #, spice      = spiceDir+'DiffPairBulkUnconnected.spi'
             , connectors = ( 'D1', 'D2', 'G1', 'G2', 'S', 'B' )
             , layouts    = ( ('Horizontal M2'  , 'DP_horizontalM2.py'    )   
                            , ('Symmetrical'    , 'DP_symmetrical.py'     )   
                            , ('Common centroid', 'DP_2DCommonCentroid.py')
                            , ('Interdigitated' , 'DP_interdigitated.py'  )
                            , ('WIP DP'         , 'wip_dp.py'             )
                            )
             )
    addDevice( name       = 'LevelShifterBulkUnconnected'
            #, spice      = spiceDir+'LevelShifterBulkUnconnected.spi'
             , connectors = ( 'D1', 'D2', 'S1', 'S2', 'B' )
             , layouts    = ( ('Horizontal M2'  , 'LS_horizontalM2.py'    )   
                            , ('Symmetrical'    , 'LS_symmetrical.py'     )   
                            , ('Common centroid', 'LS_2DCommonCentroid.py')
                            , ('Interdigitated' , 'LS_interdigitated.py'  )
                            )
             )
    addDevice( name       = 'TransistorBulkConnected'
            #, spice      = spiceDir+'TransistorBulkConnected.spi'
             , connectors = ( 'D', 'G', 'S' )
             , layouts    = ( ('Rotate transistor', 'Transistor_rotate.py')
                            , ('Common transistor', 'Transistor_common.py')
                            , ('WIP Transistor'   , 'wip_transistor.py'   )   
                            )
             )
    addDevice( name       = 'TransistorBulkUnconnected'
            #, spice      = spiceDir+'TransistorBulkUnconnected.spi'
             , connectors = ( 'D', 'G', 'S', 'B' )
             , layouts    = ( ('Rotate transistor', 'Transistor_rotate.py')
                            , ('Common transistor', 'Transistor_common.py')
                            , ('WIP Transistor'   , 'wip_transistor.py'   )
                            )
             )
    addDevice( name       = 'CrossCoupledPairBulkConnected'
            #, spice      = spiceDir+'CCPairBulkConnected.spi'
             , connectors = ( 'D1', 'D2', 'S' )
             , layouts    = ( ('Horizontal M2'  , 'CCP_horizontalM2.py'    )
                            , ('Symmetrical'    , 'CCP_symmetrical.py'     )
                            , ('Common centroid', 'CCP_2DCommonCentroid.py')
                            , ('Interdigitated' , 'CCP_interdigitated.py'  )
                            )
             )
    addDevice( name       = 'CrossCoupledPairBulkUnconnected'
            #, spice      = spiceDir+'CCPairBulkUnconnected.spi'
             , connectors = ( 'D1', 'D2', 'S', 'B' )
             , layouts    = ( ('Horizontal M2'  , 'CCP_horizontalM2.py'    )
                            , ('Symmetrical'    , 'CCP_symmetrical.py'     )
                            , ('Common centroid', 'CCP_2DCommonCentroid.py')
                            , ('Interdigitated' , 'CCP_interdigitated.py'  )
                            )
             )
    addDevice( name       = 'CommonSourcePairBulkConnected'
            #, spice      = spiceDir+'CommonSourcePairBulkConnected.spi'
             , connectors = ( 'D1', 'D2', 'S', 'G' )
             , layouts    = ( ('Horizontal M2'  , 'CSP_horizontalM2.py'    )
                            , ('Symmetrical'    , 'CSP_symmetrical.py'     )
                            , ('Interdigitated' , 'CSP_interdigitated.py'  )
                            , ('WIP CSP'        , 'wip_csp.py'             )
                            )
             )
    addDevice( name       = 'CommonSourcePairBulkUnconnected'
            #, spice      = spiceDir+'CommonSourcePairBulkUnconnected.spi'
             , connectors = ( 'D1', 'D2', 'S', 'G', 'B' )
             , layouts    = ( ('Horizontal M2'  , 'CSP_horizontalM2.py'    )
                            , ('Symmetrical'    , 'CSP_symmetrical.py'     )
                            , ('Interdigitated' , 'CSP_interdigitated.py'  )
                            , ('WIP CSP'        , 'wip_csp.py'             )
                            )
             )
    addDevice( name       = 'SimpleCurrentMirrorBulkConnected'
            #, spice      = spiceDir+'CurrMirBulkConnected.spi'
             , connectors = ( 'D1', 'D2', 'S' )
             , layouts    = ( ('Horizontal M2'  , 'SCM_horizontalM2.py'    )
                            , ('Symmetrical'    , 'SCM_symmetrical.py'     )
                            , ('Common centroid', 'SCM_2DCommonCentroid.py')
                            , ('Interdigitated' , 'SCM_interdigitated.py'  )
                            )
             )
    addDevice( name       = 'SimpleCurrentMirrorBulkUnconnected'
            #, spice      = spiceDir+'CurrMirBulkUnconnected.spi'
             , connectors = ( 'D1', 'D2', 'S', 'B' )
             , layouts    = ( ('Horizontal M2'  , 'SCM_horizontalM2.py'    )
                            , ('Symmetrical'    , 'SCM_symmetrical.py'     )
                            , ('Common centroid', 'SCM_2DCommonCentroid.py')
                            , ('Interdigitated' , 'SCM_interdigitated.py'  )
                            )
             )
    addDevice( name       = 'MultiCapacitor'
            #, spice      = spiceDir+'MIM_OneCapacitor.spi'
             , connectors = ( 'T1', 'B1' )
             , layouts    = ( ('Matrix', 'capacitormatrix.py' ),
                            )
             )
    addDevice( name       = 'Resistor'
            #, spice      = spiceDir+'MIM_OneCapacitor.spi'
             , connectors = ( 'PIN1', 'PIN2' )
             , layouts    = ( ('Snake', 'resistorsnake.py' ),
                            )
             )

