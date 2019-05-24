# -*- Mode:Python -*-

from helpers import l, u, n


defaultStyle = 'Alliance.Classic [black]'
 
parametersTable = \
    ( ('misc.catchCore'           , TypeBool      , False   )
    , ('misc.info'                , TypeBool      , False   )
    , ('misc.paranoid'            , TypeBool      , False   )
    , ('misc.bug'                 , TypeBool      , False   )
    , ('misc.logMode'             , TypeBool      , True    )
    , ('misc.verboseLevel1'       , TypeBool      , True    )
    , ('misc.verboseLevel2'       , TypeBool      , True    )
   #, ('misc.minTraceLevel'       , TypeInt       , 140     )
   #, ('misc.maxTraceLevel'       , TypeInt       , 150     )
    , ('etesian.spaceMargin'      , TypePercentage, 5.0     )
    , ('etesian.aspectRatio'      , TypePercentage, 100.0   )
    , ('anabatic.edgeLenght'      , TypeInt       , 24      )
    , ('anabatic.edgeWidth'       , TypeInt       , 8       )
   # Kite parameters.
    , ("kite.eventsLimit"         , TypeInt       , 1000000 )
    , ('katabatic.topRoutingLayer', TypeString    , 'METAL5')
    , ("kite.hTracksReservedLocal", TypeInt       , 3       )
    , ("kite.vTracksReservedLocal", TypeInt       , 3       )
    , ('clockTree.minimumSide'    , TypeInt       , l(1000) )
    )

#import os
#
#print '       o  Cleaning up ClockTree previous run.'
#for fileName in os.listdir('.'):
#  if fileName.endswith('.ap') or (fileName.find('_clocked.') >= 0):
#    print '          - <%s>' % fileName
#    os.unlink(fileName)
