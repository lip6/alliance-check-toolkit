
# -*- Mode:Python -*-

import sys
import os
import os.path

defaultStyle = 'Alliance.Classic [black]'
 
parametersTable = \
    ( ('misc.catchCore'    , TypeBool  , False   )
    , ('misc.info'         , TypeBool  , False   )
    , ('misc.paranoid'     , TypeBool  , False   )
    , ('misc.bug'          , TypeBool  , False   )
    , ('misc.logMode'      , TypeBool  , False   )
    , ('misc.verboseLevel1', TypeBool  , True    )
    , ('misc.verboseLevel2', TypeBool  , True    )
   #, ('misc.minTraceLevel', TypeInt   , 535     )
   #, ('misc.maxTraceLevel', TypeInt   , 540     )
   #, ('misc.minTraceLevel', TypeInt   , 144     )
   #, ('misc.maxTraceLevel', TypeInt   , 150     )
    , ('misc.minTraceLevel', TypeInt   , 5360    )
    , ('misc.maxTraceLevel', TypeInt   , 5410    )
    )

