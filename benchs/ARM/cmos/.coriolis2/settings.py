# -*- Mode:Python -*-

import os
import os.path


defaultStyle = 'Alliance.Classic [black]'
 
parametersTable = \
    ( ('misc.catchCore'             , TypeBool      , False   )
    , ('misc.info'                  , TypeBool      , False   )
    , ('misc.paranoid'              , TypeBool      , False   )
    , ('misc.bug'                   , TypeBool      , False   )
    , ('misc.logMode'               , TypeBool      , False   )
    , ('misc.verboseLevel1'         , TypeBool      , True    )
    , ('misc.verboseLevel2'         , TypeBool      , True    )
   #, ('misc.minTraceLevel'         , TypeInt       , 1000    )
   #, ('misc.maxTraceLevel'         , TypeInt       , 1000    )
    , ("etesian.effort"             , TypeEnumerate , 2       )
    , ('etesian.uniformDensity'     , TypeBool      , True    )
    , ('etesian.spaceMargin'        , TypePercentage, 15.0    )
    , ('etesian.aspectRatio'        , TypePercentage, 100.0   )
    , ('etesian.bloat'              , TypeString    , "nsxlib")
    , ('clockTree.minimumSide'      , TypeInt       , l(1000) )
   # Katana parameters.
    , ("katana.eventsLimit"         , TypeInt       , 1000000 )
   #, ('anabatic.topRoutingLayer'   , TypeString    , 'METAL5')
    , ("katana.hTracksReservedLocal", TypeInt       , 6       )
    , ("katana.vTracksReservedLocal", TypeInt       , 6       )
   # Clock-Tree parameters.
   #, ('clockTree.minimumSide'    , TypeInt       , 600     )
    )
