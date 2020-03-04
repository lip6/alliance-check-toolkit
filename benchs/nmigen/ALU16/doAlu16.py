#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import re
import traceback
import os.path
import optparse
import Cfg
import Hurricane
from   Hurricane import DbU
from   Hurricane import DataBase
from   Hurricane import UpdateSession
from   Hurricane import Breakpoint
from   Hurricane import Box
from   Hurricane import Transformation
from   Hurricane import Instance
from   Hurricane import Net
from   Hurricane import Contact
from   Hurricane import Vertical
from   Hurricane import Pad
from   Hurricane import Pin
from   Hurricane import NetExternalComponents
import Viewer
import CRL
import Etesian
import Anabatic
import Katana
import Unicorn
from   helpers   import l, u, n
import clocktree.ClockTree
import plugins.RSavePlugin
import plugins.ClockTreePlugin
import symbolic.cmos


af = CRL.AllianceFramework.get()


def toDbU ( l ): return DbU.fromLambda(l)


def createVertical ( contacts, x, layer, width=None):
    def yincrease ( lhs, rhs ): return int(lhs.getY() - rhs.getY())

    contacts.sort( yincrease )

    if width is None: width = l(2.0)

    for i in range(1,len(contacts)):
        print "create vert", contacts[i-1], contacts[i], layer, x, width
        v = Vertical.create( contacts[i-1], contacts[i], layer, x, width )
        print "v", v


def createHorizontal ( contactPaths, y, layer, width=None):
    def xincrease ( lhs, rhs ): return int(lhs.getX() - rhs.getX())

    contacts = contactPaths

    if width is None: width = toDbU(2.0)

    contacts.sort( xincrease )

    for i in range(1,len(contacts)):
        Horizontal.create( contacts[i-1], contacts[i], layer, y, width )


def build_downtrace(net, layer, x, y, y1):

    contacts = \
      [ Contact.create( net, layer, l(x), l(y), l(2.0), l(2.0) )
      , Contact.create( net, layer, l(x), l(y1), l(2.0), l(2.0) )
      ]

    createVertical( contacts, l(x), layer )
    print "slaves", contacts[-1].getSlaveComponents()
    for component in contacts[-1].getSlaveComponents():
        NetExternalComponents.setExternal(component)


def placeAndRoute ( cell ):
    etesian = Etesian.EtesianEngine.create(cell)
    etesian.place()

    katana = Katana.KatanaEngine.create(cell)
    katana.digitalInit      ()
    katana.runGlobalRouter  ( Katana.Flags.NoFlags )
    katana.loadGlobalRouting( Anabatic.EngineLoadGrByNet )
    katana.layerAssign      ( Anabatic.EngineNoNetLayerAssign )
    katana.runNegociate     ( Katana.Flags.NoFlags )
    katana.finalizeLayout   ()
    success = katana.isDetailedRoutingSuccess()
    katana.destroy()

    return success


def coriolisSetup ():
    Cfg.Configuration.pushDefaultPriority( Cfg.Parameter.Priority.UserFile )
    
    cellsTop = '~/alliance-check-toolkit/cells'
    env = af.getEnvironment()
    env.addSYSTEM_LIBRARY( library=cellsTop+'/nsxlib', mode=CRL.Environment.Prepend )
    env.addSYSTEM_LIBRARY( library=cellsTop+'/mpxlib', mode=CRL.Environment.Prepend )
    
    
    Cfg.getParamBool      ( 'misc.catchCore'              ).setBool      ( False   )
    Cfg.getParamBool      ( 'misc.info'                   ).setBool      ( False   )
    Cfg.getParamBool      ( 'misc.paranoid'               ).setBool      ( False   )
    Cfg.getParamBool      ( 'misc.bug'                    ).setBool      ( False   )
    Cfg.getParamBool      ( 'misc.logMode'                ).setBool      ( True   )
    Cfg.getParamBool      ( 'misc.verboseLevel1'          ).setBool      ( True    )
    Cfg.getParamBool      ( 'misc.verboseLevel2'          ).setBool      ( True    )
   #Cfg.getParamInt       ( 'misc.minTraceLevel'          ).setInt       ( 111     )
   #Cfg.getParamInt       ( 'misc.maxTraceLevel'          ).setInt       ( 112     )
    Cfg.getParamEnumerate ( 'etesian.effort'              ).setInt       ( 2       )
    Cfg.getParamPercentage( 'etesian.spaceMargin'         ).setPercentage( 20.0    )
    Cfg.getParamPercentage( 'etesian.aspectRatio'         ).setPercentage( 100.0   )
    Cfg.getParamBool      ( 'etesian.uniformDensity'      ).setBool      ( True    )
    Cfg.getParamInt       ( 'anabatic.edgeLenght'         ).setInt       ( 24      )
    Cfg.getParamInt       ( 'anabatic.edgeWidth'          ).setInt       ( 8       )
    Cfg.getParamString    ( 'anabatic.topRoutingLayer'    ).setString    ( 'METAL5')
    Cfg.getParamInt       ( 'katana.searchHalo'           ).setInt       ( 30      )
    Cfg.getParamInt       ( 'katana.eventsLimit'          ).setInt       ( 1000000 )
    Cfg.getParamInt       ( 'katana.hTracksReservedLocal' ).setInt       ( 7       )
    Cfg.getParamInt       ( 'katana.vTracksReservedLocal' ).setInt       ( 6       )
   #Cfg.getParamInt       ( 'clockTree.minimumSide'       ).setInt       ( l(1000) )
    
    env = af.getEnvironment()
    env.setCLOCK( '^clk$|m_clock' )
    env.setPOWER( 'vdd' )
    env.setGROUND( 'vss' )
    
    Cfg.Configuration.popDefaultPriority()


# -------------------------------------------------------------------------------
# add()

def add ( **kw ):
    editor = None
    if kw.has_key('editor') and kw['editor']:
      editor = kw['editor']
    
    db = DataBase.getDB()
    print db, dir(db)
    METAL2    = DataBase.getDB().getTechnology().getLayer( 'METAL2' )
    METAL3    = DataBase.getDB().getTechnology().getLayer( 'METAL3' )
    METAL5    = DataBase.getDB().getTechnology().getLayer( 'METAL5' )
    BLOCKAGE2 = DataBase.getDB().getTechnology().getLayer( 'BLOCKAGE2' )
    BLOCKAGE3 = DataBase.getDB().getTechnology().getLayer( 'BLOCKAGE3' )
    BLOCKAGE4 = DataBase.getDB().getTechnology().getLayer( 'BLOCKAGE4' )
    BLOCKAGE5 = DataBase.getDB().getTechnology().getLayer( 'BLOCKAGE5' )
    
    cell = af.getCell( 'add', CRL.Catalog.State.Logical )
    print cell.getNet('a(0)')
    
    if not cell:
      print '[ERROR] Unable to load cell "add.vst", aborting .'
      return False
    
    kw[ 'cell' ] = cell
    
    width  = 350.0
    height = 400.0
    
    ab = Box( l(    0.0 )
            , l(    0.0 )
            , l( width )
            , l( height ) )
    
    cellGauge   = af.getCellGauge()
    spaceMargin = (Cfg.getParamPercentage('etesian.spaceMargin').asPercentage()+5) / 100.0
    aspectRatio =  Cfg.getParamPercentage('etesian.aspectRatio').asPercentage()    / 100.0
    clocktree.ClockTree.computeAbutmentBox( cell, spaceMargin, aspectRatio, cellGauge )
    ab2 = cell.getAbutmentBox()
    print "box", ab, ab.getHeight(), ab.getWidth()
    print "calc box", ab2, ab2.getHeight(), ab2.getWidth()
    
    #height = ab.getHeight()
    #width = ab.getWidth()
    
    UpdateSession.open()
    cell.setAbutmentBox( ab )
    
    for i in range(16):
      if True:
          x   = 20.0*i + 10.0
          y   = height
          pin = Pin.create( cell.getNet('a(%d)' % i)
                          , 'a(%d).0' % i
                          , Pin.Direction.NORTH
                          , Pin.PlacementStatus.FIXED
                          , METAL3
                          , l( x ), l( y - 0 )   # Position.
                          , l( 2.0 )            , l( 2.0 )  # Size.
                          )
          pin.getNet().setExternal( True )
          NetExternalComponents.setExternal( pin )
    for i in range(16):
      if True:
          pin = Pin.create( cell.getNet('o(%d)' % i)
                          , 'o(%d).0' % i
                          , Pin.Direction.SOUTH
                          , Pin.PlacementStatus.FIXED
                          , METAL3
                          , l( 10.0*i + 100.0 ), l( 0)   # Position.
                          , l( 2.0 )            , l( 2.0 )  # Size.
                          )
          pin.getNet().setExternal( True )
          NetExternalComponents.setExternal( pin )
    
    for i in range(16):
      if True:
          net = cell.getNet('b(%d)' % i)
          x = 20.0*i + 10.0 + 10
          y = height - 0
          #build_downtrace(net, METAL3, x, y+11, y)
          #continue
          pin = Pin.create( net
                          , 'b(%d).0' % i
                          , Pin.Direction.NORTH
                          , Pin.PlacementStatus.FIXED
                          , METAL3
                          , l( x   ), l( y - 0 )   # Position.
                          , l( 2.0 ), l( 2.0   )  # Size.
                          )
          pin.getNet().setExternal( True )
          NetExternalComponents.setExternal( pin )
    if False:
      pin = Pin.create( cell.getNet('rst')
                      , 'p_reset.0'
                      , Pin.Direction.WEST
                      , Pin.PlacementStatus.FIXED
                      , METAL2
                      , l(   0.0 )
                      , l( 140.0 )
                      , l(   2.0 )
                      , l(   2.0 )
                      )
      pin.getNet().setExternal( True )
      NetExternalComponents.setExternal( pin )
    
    UpdateSession.close()
    
    if True:
      if editor: editor.setCell( cell )
    
      placeAndRoute( cell )
    
      UpdateSession.open()
      blockageNet = cell.getNet( 'blockagenet' )
    
      ab = cell.getAbutmentBox()
      ab.inflate( toDbU(-5.0) )
      Pad.create( net, BLOCKAGE2, ab )
      Pad.create( net, BLOCKAGE3, ab )
      Pad.create( net, BLOCKAGE4, ab )
     #Pad.create( net, BLOCKAGE5, ab )
      UpdateSession.close()
    
    if False:
      UpdateSession.open()
      cell.setAbutmentBox( ab )
      for i in range(16):
          if True:
              net = cell.getNet('b(%d)' % i)
              x = 20.0*i + 10.0 + 10
              y = height-10
              build_downtrace(net, METAL2, x, y, y+10)
      UpdateSession.close()
    
   #af.saveCell( cell, CRL.Catalog.State.Views )
    plugins.RSavePlugin.ScriptMain( **kw )


# -------------------------------------------------------------------------------
# sub

def sub ( **kw ):
    editor = None
    if kw.has_key('editor') and kw['editor']:
      editor = kw['editor']
  
    db = DataBase.getDB()
    print db, dir(db)
    METAL2    = DataBase.getDB().getTechnology().getLayer( 'METAL2' )
    METAL3    = DataBase.getDB().getTechnology().getLayer( 'METAL3' )
    METAL5    = DataBase.getDB().getTechnology().getLayer( 'METAL5' )
    BLOCKAGE2 = DataBase.getDB().getTechnology().getLayer( 'BLOCKAGE2' )
    BLOCKAGE3 = DataBase.getDB().getTechnology().getLayer( 'BLOCKAGE3' )
    BLOCKAGE4 = DataBase.getDB().getTechnology().getLayer( 'BLOCKAGE4' )
    BLOCKAGE5 = DataBase.getDB().getTechnology().getLayer( 'BLOCKAGE5' )
  
    cell = af.getCell( 'sub', CRL.Catalog.State.Logical )
    print cell.getNet('a(0)')
  
    if not cell:
      print '[ERROR] Unable to load cell "alu16.vst", aborting .'
      return False
    kw[ 'cell' ] = cell
  
    width  = 350.0
    height = 400.0
  
    ab = Box( l(    0.0 )
            , l(    0.0 )
            , l( width )
            , l( height ) )
  
    cellGauge   = af.getCellGauge()
    spaceMargin = (Cfg.getParamPercentage('etesian.spaceMargin').asPercentage()+5) / 100.0
    aspectRatio =  Cfg.getParamPercentage('etesian.aspectRatio').asPercentage()    / 100.0
    clocktree.ClockTree.computeAbutmentBox( cell, spaceMargin, aspectRatio, cellGauge )
    ab2 = cell.getAbutmentBox()
    print "box", ab, ab.getHeight(), ab.getWidth()
    print "calc box", ab2, ab2.getHeight(), ab2.getWidth()
  
    #height = ab.getHeight()
    #width = ab.getWidth()
  
    UpdateSession.open()
    cell.setAbutmentBox( ab )
  
    for i in range(16):
      if True:
          x   = 20.0*i + 10.0
          y   = height
          pin = Pin.create( cell.getNet('a(%d)' % i)
                          , 'a(%d).0' % i
                          , Pin.Direction.NORTH
                          , Pin.PlacementStatus.FIXED
                          , METAL3
                          , l( x ), l( y - 0 )   # Position.
                          , l( 2.0 )            , l( 2.0 )  # Size.
                          )
          pin.getNet().setExternal( True )
          NetExternalComponents.setExternal( pin )
  
    for i in range(16):
      if True:
          pin = Pin.create( cell.getNet('o(%d)' % i)
                          , 'o(%d).0' % i
                          , Pin.Direction.SOUTH
                          , Pin.PlacementStatus.FIXED
                          , METAL3
                          , l( 10.0*i + 100.0 ), l( 0)   # Position.
                          , l( 2.0 )            , l( 2.0 )  # Size.
                          )
          pin.getNet().setExternal( True )
          NetExternalComponents.setExternal( pin )
  
    for i in range(16):
      if True:
          net = cell.getNet('b(%d)' % i)
          x = 20.0*i + 10.0 + 10
          y = height - 0
          #build_downtrace(net, METAL3, x, y+11, y)
          #continue
          pin = Pin.create( net
                          , 'b(%d).0' % i
                          , Pin.Direction.NORTH
                          , Pin.PlacementStatus.FIXED
                          , METAL3
                          , l( x   ), l( y   )  # Position.
                          , l( 2.0 ), l( 2.0 )  # Size.
                          )
          pin.getNet().setExternal( True )
          NetExternalComponents.setExternal( pin )
  
    if False:
      pin = Pin.create( cell.getNet('rst')
                      , 'p_reset.0'
                      , Pin.Direction.WEST
                      , Pin.PlacementStatus.FIXED
                      , METAL2
                      , l(   0.0 )
                      , l( 140.0 )
                      , l(   2.0 )
                      , l(   2.0 )
                      )
      pin.getNet().setExternal( True )
      NetExternalComponents.setExternal( pin )
    UpdateSession.close()
  
    if True:
      if editor: editor.setCell( cell )
  
      placeAndRoute( cell )
  
      UpdateSession.open()
      blockageNet = cell.getNet( 'blockagenet' )
  
      ab = cell.getAbutmentBox()
      ab.inflate( toDbU(-5.0) )
      Pad.create( net, BLOCKAGE2, ab )
      Pad.create( net, BLOCKAGE3, ab )
      Pad.create( net, BLOCKAGE4, ab )
     #Pad.create( net, BLOCKAGE5, ab )
      UpdateSession.close()
  
    if False:
      UpdateSession.open()
      cell.setAbutmentBox( ab )
      for i in range(16):
          if True:
              net = cell.getNet('b(%d)' % i)
              x = 20.0*i + 10.0 + 10
              y = height-10
              build_downtrace(net, METAL2, x, y, y+10)
      UpdateSession.close()
  
   #af.saveCell( cell, CRL.Catalog.State.Views )
    plugins.RSavePlugin.ScriptMain( **kw )


# -------------------------------------------------------------------------------
# alu16()

def alu16 ( **kw ):

    editor = None
    if kw.has_key('editor') and kw['editor']:
      editor = kw['editor']
  
    db = DataBase.getDB()
    print db, dir(db)
    METAL2 = DataBase.getDB().getTechnology().getLayer( 'METAL2' )
    METAL3 = DataBase.getDB().getTechnology().getLayer( 'METAL3' )
  
    cell = af.getCell( 'add'  , CRL.Catalog.State.Views   )
    cell = af.getCell( 'sub'  , CRL.Catalog.State.Views   )
    cell = af.getCell( 'alu16', CRL.Catalog.State.Logical )
    if not cell:
      print '[ERROR] Unable to load cell "alu16.vst", aborting .'
      return False
    kw[ 'cell' ] = cell
  
    ab = Box( l(   0.0 )
            , l(   0.0 )
            , l(1050.0 )
            , l( 700.0 ) )
  
    UpdateSession.open()
    cell.setAbutmentBox( ab )

    ins = cell.getInstance( 'subckt_48_add' )
    ins.setTransformation( Transformation( toDbU(100.0), toDbU(150.0), Transformation.Orientation.ID ) )
    ins.setPlacementStatus( Instance.PlacementStatus.FIXED )
    
    ins = cell.getInstance( 'subckt_49_sub' )
    ins.setTransformation( Transformation( toDbU(600.0), toDbU(150.0), Transformation.Orientation.ID ) )
    ins.setPlacementStatus( Instance.PlacementStatus.FIXED )

    yNorth = cell.getAbutmentBox().getYMax()
  
    for i in range(16):
      Pin.create( cell.getNet('a(%d)' % i)
                , 'a(%d).0' % i
                , Pin.Direction.SOUTH
                , Pin.PlacementStatus.FIXED
                , METAL3
                , l( 60.0*i + 50.0 ) , l( 0.0 )  # Position.
                , l( 2.0 )           , l( 2.0 )  # Size.
                )
      Pin.create( cell.getNet('b(%d)' % i)
                , 'b(%d).0' % i
                , Pin.Direction.SOUTH
                , Pin.PlacementStatus.FIXED
                , METAL3
                , l( 60.0*i + 80.0 ) , l( 0.0 )  # Position.
                , l( 2.0 )           , l( 2.0 )  # Size.
                )
      Pin.create( cell.getNet('o(%d)' % i)
                , 'o(%d).0' % i
                , Pin.Direction.NORTH
                , Pin.PlacementStatus.FIXED
                , METAL3
                , l( 60.0*i + 50.0 ) , yNorth    # Position.
                , l( 2.0 )           , l( 2.0 )  # Size.
                )
  
    Pin.create( cell.getNet('rst')
              , 'rst.0'
              , Pin.Direction.WEST
              , Pin.PlacementStatus.FIXED
              , METAL2
              , l(   0.0 )
              , l( 140.0 )
              , l(   2.0 )
              , l(   2.0 )
              )
    UpdateSession.close()
  
    if editor: editor.setCell( cell )
  
    print "editor", editor, dir(editor)

    success = placeAndRoute( cell )
   
    af.saveCell( cell, CRL.Catalog.State.Views )
    plugins.RSavePlugin.ScriptMain( **kw )
  
    return success


def ScriptMain ( **kw ):
    coriolisSetup()
    add( **kw )
    sub( **kw )
    success = alu16( **kw )
    return success


if __name__ == '__main__':
   try:
     kw           = {}
     success      = ScriptMain( **kw )
     shellSuccess = 0
     if not success: shellSuccess = 1
   except ImportError, e:
     showPythonTrace( __file__, e, False )
     sys.exit(1)
   except Exception, e:
     showPythonTrace( __file__, e )
     sys.exit(2)

   sys.exit( shellSuccess )


