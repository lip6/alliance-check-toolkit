# -*- Mode:Python -*-

import os
import os.path
import helpers


defaultStyle = 'Alliance.Classic [black]'
 
parametersTable = \
    ( ('misc.catchCore'           , TypeBool      , False   )
    , ('misc.info'                , TypeBool      , False   )
    , ('misc.paranoid'            , TypeBool      , False   )
    , ('misc.bug'                 , TypeBool      , False   )
    , ('misc.logMode'             , TypeBool      , True    )
    , ('misc.verboseLevel1'       , TypeBool      , True    )
    , ('misc.verboseLevel2'       , TypeBool      , True    )
   #, ('misc.minTraceLevel'       , TypeInt       , 112     )
   #, ('misc.maxTraceLevel'       , TypeInt       , 1000    )
    , ("etesian.effort"           , TypeEnumerate , 2       )
    , ('etesian.uniformDensity'   , TypeBool      , True    )
    , ('etesian.spaceMargin'      , TypePercentage, 7.0     )
    , ('etesian.aspectRatio'      , TypePercentage, 410.0   )
   # Kite parameters.
    , ('anabatic.routingGauge'    , TypeString    , 'msxlib-2M' )
    , ("kite.eventsLimit"         , TypeInt       , 1000000 )
    , ('katabatic.topRoutingLayer', TypeString    , 'METAL2')
    , ("kite.hTracksReservedLocal", TypeInt       , 0       )
    , ("kite.vTracksReservedLocal", TypeInt       , 0       )
    )

#if helpers.techno == '180/scn6m_deep_09':
#  parametersTable = helpers.overload \
#                    ( parametersTable
#                    , ( ('anabatic.routingGauge', TypeString, 'msxlib')
#                      ,
#                      )
#                    )

cellsTop = os.path.abspath( os.getcwd()+'/../../cells' )
  
allianceConfig = \
    ( ( 'CLOCK'         , '^ck.*|m_clock')
    , ( 'SYSTEM_LIBRARY', ( (cellsTop+'/nsxlib'  , Environment.Prepend)
                          , (cellsTop+'/mpxlib'  , Environment.Prepend)) )
    ,
    )


#print '       o  Cleaning up ClockTree previous run.'
#for fileName in os.listdir('.'):
#  if fileName.endswith('.ap') or (fileName.find('_clocked.') >= 0):
#    print '          - <%s>' % fileName
#    os.unlink(fileName)
