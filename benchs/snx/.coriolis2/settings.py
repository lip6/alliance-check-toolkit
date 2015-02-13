
# -*- Mode:Python -*-

import os
import os.path


defaultStyle = 'Alliance.Classic [black]'
 
parametersTable = \
    ( ('misc.catchCore'           , TypeBool      , False   )
    , ('misc.info'                , TypeBool      , False   )
    , ('misc.paranoid'            , TypeBool      , True    )
    , ('misc.bug'                 , TypeBool      , False   )
    , ('misc.logMode'             , TypeBool      , False   )
    , ('misc.verboseLevel1'       , TypeBool      , True    )
    , ('misc.verboseLevel2'       , TypeBool      , True    )
    , ('misc.traceLevel'          , TypeInt       , 1000    )
    , ('nimbus.spaceMargin'       , TypePercentage, 2.0     )
    , ('nimbus.aspectRatio'       , TypePercentage, 100.0   )
   # Kite parameters.
    , ("kite.eventsLimit"         , TypeInt       , 1000000 )
    , ('katabatic.topRoutingLayer', TypeString    , 'METAL5')
    , ("kite.hTracksReservedLocal", TypeInt       , 4       )
    , ("kite.vTracksReservedLocal", TypeInt       , 4       )
    )

cellsTop = os.path.abspath( os.getcwd()+'/../cells' )

allianceConfig = \
    ( ( 'CLOCK'         , '^ck.*|m_clock')
    , ( 'SYSTEM_LIBRARY', ( (cellsTop+'/msxlib'  , Environment.Append)
                          , (cellsTop+'/mpxlib'  , Environment.Append)) )
    ,
    )

#import os
#
#print '       o  Cleaning up ClockTree previous run.'
#for fileName in os.listdir('.'):
#  if fileName.endswith('.ap') or (fileName.find('_clocked.') >= 0):
#    print '          - <%s>' % fileName
#    os.unlink(fileName)
