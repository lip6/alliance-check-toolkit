# -*- Mode:Python -*-

import os
import os.path


defaultStyle = 'Alliance.Classic [black]'
 
parametersTable = \
    ( ('misc.catchCore'           , TypeBool      , False   )
    , ('misc.info'                , TypeBool      , False   )
    , ('misc.paranoid'            , TypeBool      , False   )
    , ('misc.bug'                 , TypeBool      , False   )
    , ('misc.logMode'             , TypeBool      , False   )
    , ('misc.verboseLevel1'       , TypeBool      , True    )
    , ('misc.verboseLevel2'       , TypeBool      , True    )
    , ('misc.minTraceLevel'       , TypeInt       , 1000    )
    , ('misc.maxTraceLevel'       , TypeInt       , 1000    )
    , ("etesian.effort"           , TypeEnumerate , 2       )
    , ('etesian.uniformDensity'   , TypeBool      , True    )
    , ('etesian.spaceMargin'      , TypePercentage, 15.0    )
    , ('etesian.aspectRatio'      , TypePercentage, 100.0   )
   # Kite parameters.
    , ("kite.eventsLimit"         , TypeInt       , 1000000 )
   #, ('katabatic.topRoutingLayer', TypeString    , 'METAL5')
    , ("kite.hTracksReservedLocal", TypeInt       , 5       )
    , ("kite.vTracksReservedLocal", TypeInt       , 5       )
   # Clock-Tree parameters.
    , ('clockTree.minimumSide'    , TypeInt       , 600     )
    )
