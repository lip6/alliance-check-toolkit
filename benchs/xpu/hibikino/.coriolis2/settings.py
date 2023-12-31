
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
    , ('misc.verboseLevel1'       , TypeBool      , False   )
    , ('misc.verboseLevel2'       , TypeBool      , True    )
    , ('misc.minTraceLevel'       , TypeInt       , 0       )
    , ('misc.maxTraceLevel'       , TypeInt       , 0       )
    , ('nimbus.spaceMargin'       , TypePercentage, 40.0    )
    , ('nimbus.aspectRatio'       , TypePercentage, 100.0   )
   # Kite parameters.
    , ("kite.eventsLimit"         , TypeInt       , 1000000 )
    , ('katabatic.topRoutingLayer', TypeString    , 'METAL5')
    , ("kite.hTracksReservedLocal", TypeInt       , 4       )
    , ("kite.vTracksReservedLocal", TypeInt       , 3       )
    )

cellsTop = os.path.abspath( os.getcwd()+'/../cells/hibikino' )

allianceConfig = \
    ( ( 'SYSTEM_LIBRARY', ( (cellsTop+'/sxlib_25um'  , Environment.Prepend)
                          , (cellsTop+'/padlib_25um'  , Environment.Prepend)) )
    ,
    )


#print '       o  Cleaning up ClockTree previous run.'
#for fileName in os.listdir('.'):
#  if fileName.endswith('.ap') or (fileName.find('_clocked.') >= 0):
#    print '          - <%s>' % fileName
#    os.unlink(fileName)
