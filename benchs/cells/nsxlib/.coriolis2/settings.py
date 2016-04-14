# -*- Mode:Python -*-

import os
import os.path


defaultStyle = 'Alliance.Classic [black]'
 
cwd      = os.path.abspath( os.getcwd() )
cellsTop = os.path.abspath( cwd+'/..' )

allianceConfig = \
    ( ( 'WORKING_LIBRARY', ( (cwd+'/check') ) )
    , ( 'SYSTEM_LIBRARY' , ( (cellsTop+'/nsxlib'  , Environment.Prepend)
                           , (cellsTop+'/mpxlib'  , Environment.Prepend)) )
    ,
    )
