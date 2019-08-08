
# -*- Mode:Python -*-

import os
import os.path
from helpers import l, u, n

defaultStyle = 'Alliance.Classic [black]'
#defaultStyle = 'Printer.Coriolis'
 
parametersTable = \
    ( ('misc.catchCore'           , TypeBool      , False   )
    , ('misc.info'                , TypeBool      , False   )
    , ('misc.paranoid'            , TypeBool      , False   )
    , ('misc.bug'                 , TypeBool      , False   )
    , ('misc.logMode'             , TypeBool      , True    )
    , ('misc.verboseLevel1'       , TypeBool      , False   )
    , ('misc.verboseLevel2'       , TypeBool      , True    )
   #, ('misc.minTraceLevel'       , TypeInt       , 110     )
   #, ('misc.maxTraceLevel'       , TypeInt       , 1000    )
    , ('etesian.spaceMargin'      , TypePercentage, 20.0    )
    , ('etesian.aspectRatio'      , TypePercentage, 100.0   )
    , ('clockTree.minimumSide'    , TypeInt       , l(1000) )
   # Kite parameters.
    , ("kite.eventsLimit"         , TypeInt       , 1000000 )
    , ('katabatic.topRoutingLayer', TypeString    , 'METAL3')
    , ('anabatic.routingGauge'    , TypeString    , 'sxlib' )
   #, ('anabatic.routingGauge'    , TypeString    , 'msxlib')
   #, ('anabatic.routingGauge'    , TypeString    , 'msxlib-2M')
    , ("kite.hTracksReservedLocal", TypeInt       , 0       )
    , ("kite.vTracksReservedLocal", TypeInt       , 0       )
    )

#cellsTop = os.path.abspath( os.getcwd()+'/../cells' )
#allianceConfig = \
#     ( ( 'SYSTEM_LIBRARY', ( (cellsTop+'/nsxlib'  , Environment.Prepend)
#                           , (cellsTop+'/mpxlib'  , Environment.Prepend)) )
#     ,
#     )


#print '       o  Cleaning up ClockTree previous run.'
#for fileName in os.listdir('.'):
#  if fileName.endswith('.ap') or (fileName.find('_clocked.') >= 0):
#    print '          - <%s>' % fileName
#    os.unlink(fileName)
