# -*- Mode:Python -*-

import os
import os.path

parametersTable = \
    ( ('misc.catchCore'           , TypeBool      , False   )
    , ('misc.info'                , TypeBool      , False   )
    , ('misc.paranoid'            , TypeBool      , False   )
    , ('misc.bug'                 , TypeBool      , False   )
    , ('misc.logMode'             , TypeBool      , False   )
    , ('misc.verboseLevel1'       , TypeBool      , True    )
    , ('misc.verboseLevel2'       , TypeBool      , True    )
    , ('misc.minTraceLevel'       , TypeInt       , 0       )
    , ('misc.maxTraceLevel'       , TypeInt       , 0       )
    , ("etesian.effort"           , TypeEnumerate , 2       )
    , ('etesian.spaceMargin'      , TypePercentage, 15.0    )
    , ('etesian.aspectRatio'      , TypePercentage, 100.0   )
   # Kite parameters.
    , ("kite.eventsLimit"         , TypeInt       , 1000000 )
    , ('katabatic.topRoutingLayer', TypeString    , 'METAL5')
    , ("kite.hTracksReservedLocal", TypeInt       , 3       )
    , ("kite.vTracksReservedLocal", TypeInt       , 3       )
    )


defaultStyle = 'Alliance.Classic [black]'
socCellsTop  = '/soc/alliance/cells'
cwd          = os.path.abspath( os.getcwd() )
cellsTop     = os.path.abspath( cwd+'/..' )

allianceConfig = \
    ( ( 'WORKING_LIBRARY', ( (cellsTop+'/nrf2lib') ) )
    , ( 'SYSTEM_LIBRARY' , ( (cellsTop   +'/nsxlib'  , Environment.Prepend)
                           , (socCellsTop+'/rf2lib'  , Environment.Prepend)
                           , ) )
    ,
    )
