# -*- Mode:Python -*-

from helpers import l, u, n


defaultStyle = 'Alliance.Classic [black]'
 
parametersTable = \
    ( ('misc.catchCore'             , TypeBool      , False   )
    , ('misc.info'                  , TypeBool      , False   )
    , ('misc.paranoid'              , TypeBool      , False   )
    , ('misc.bug'                   , TypeBool      , False   )
    , ('misc.logMode'               , TypeBool      , True    )
    , ('misc.verboseLevel1'         , TypeBool      , True    )
    , ('misc.verboseLevel2'         , TypeBool      , True    )
   #, ('misc.minTraceLevel'         , TypeInt       , 159     )
   #, ('misc.maxTraceLevel'         , TypeInt       , 160     )
    , ('etesian.spaceMargin'        , TypePercentage, 5.0     )
    , ('etesian.aspectRatio'        , TypePercentage, 100.0   )
    , ('anabatic.edgeLenght'        , TypeInt       , 24      )
    , ('anabatic.edgeWidth'         , TypeInt       , 8       )
   # Kite parameters.
    , ("katana.eventsLimit"         , TypeInt       , 1000000 )
    , ('anabatic.topRoutingLayer'   , TypeString    , 'METAL5')
    , ("katana.hTracksReservedLocal", TypeInt       , 4       )
    , ("katana.vTracksReservedLocal", TypeInt       , 5       )
    , ('clockTree.minimumSide'      , TypeInt       , l(1000) )
    )

#import os
#
#print '       o  Cleaning up ClockTree previous run.'
#for fileName in os.listdir('.'):
#  if fileName.endswith('.ap') or (fileName.find('_clocked.') >= 0):
#    print '          - <%s>' % fileName
#    os.unlink(fileName)
