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
import helpers
from   helpers         import l, u, n
from   helpers         import showPythonTrace
from   helpers.overlay import UpdateSession
helpers.loadUserSettings()
import plugins.cts
import plugins.cts.clocktree
import plugins.rsave


af = CRL.AllianceFramework.get()


def toDbU ( l ): return DbU.fromLambda(l)


def createVertical ( contacts, x, layer, width=None):

    def yincrease ( lhs, rhs ): return int(lhs.getY() - rhs.getY())

    contacts.sort( yincrease )

    if width is None: width = l(2.0)

    for i in range(1,len(contacts)):
        v = Vertical.create( contacts[i-1], contacts[i], layer, x, width )


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


# -------------------------------------------------------------------------------
# add()

def add ( **kw ):
    editor = None
    if kw.has_key('editor') and kw['editor']:
        editor = kw['editor']
    
    db        = DataBase.getDB()
    METAL2    = db.getTechnology().getLayer( 'METAL2' )
    METAL3    = db.getTechnology().getLayer( 'METAL3' )
    METAL5    = db.getTechnology().getLayer( 'METAL5' )
    BLOCKAGE2 = db.getTechnology().getLayer( 'BLOCKAGE2' )
    BLOCKAGE3 = db.getTechnology().getLayer( 'BLOCKAGE3' )
    BLOCKAGE4 = db.getTechnology().getLayer( 'BLOCKAGE4' )
    BLOCKAGE5 = db.getTechnology().getLayer( 'BLOCKAGE5' )
    
    cell = af.getCell( 'add', CRL.Catalog.State.Logical )
    
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
    plugins.cts.clocktree.computeAbutmentBox( cell, spaceMargin, aspectRatio, cellGauge )
    ab2 = cell.getAbutmentBox()
    
    #height = ab.getHeight()
    #width = ab.getWidth()
    
    with UpdateSession():
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
    
    if True:
        if editor: editor.setCell( cell )
      
        placeAndRoute( cell )
      
        with UpdateSession():
            blockageNet = cell.getNet( 'blockagenet' )
          
            ab = cell.getAbutmentBox()
            ab.inflate( toDbU(-5.0) )
            Pad.create( net, BLOCKAGE2, ab )
            Pad.create( net, BLOCKAGE3, ab )
            Pad.create( net, BLOCKAGE4, ab )
           #Pad.create( net, BLOCKAGE5, ab )
    
    if False:
        with UpdateSession():
            cell.setAbutmentBox( ab )
            for i in range(16):
                if True:
                    net = cell.getNet('b(%d)' % i)
                    x = 20.0*i + 10.0 + 10
                    y = height-10
                    build_downtrace(net, METAL2, x, y, y+10)
    
   #af.saveCell( cell, CRL.Catalog.State.Views )
    plugins.rsave.scriptMain( **kw )


# -------------------------------------------------------------------------------
# sub

def sub ( **kw ):
    editor = None
    if kw.has_key('editor') and kw['editor']:
        editor = kw['editor']
  
    db        = DataBase.getDB()
    METAL2    = db.getTechnology().getLayer( 'METAL2' )
    METAL3    = db.getTechnology().getLayer( 'METAL3' )
    METAL5    = db.getTechnology().getLayer( 'METAL5' )
    BLOCKAGE2 = db.getTechnology().getLayer( 'BLOCKAGE2' )
    BLOCKAGE3 = db.getTechnology().getLayer( 'BLOCKAGE3' )
    BLOCKAGE4 = db.getTechnology().getLayer( 'BLOCKAGE4' )
    BLOCKAGE5 = db.getTechnology().getLayer( 'BLOCKAGE5' )
  
    cell = af.getCell( 'sub', CRL.Catalog.State.Logical )
  
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
    plugins.cts.clocktree.computeAbutmentBox( cell, spaceMargin, aspectRatio, cellGauge )
    ab2 = cell.getAbutmentBox()
  
    #height = ab.getHeight()
    #width = ab.getWidth()
  
    with UpdateSession():
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
  
    if True:
        if editor: editor.setCell( cell )
      
        placeAndRoute( cell )
      
        with UpdateSession():
            blockageNet = cell.getNet( 'blockagenet' )
          
            ab = cell.getAbutmentBox()
            ab.inflate( toDbU(-5.0) )
            Pad.create( net, BLOCKAGE2, ab )
            Pad.create( net, BLOCKAGE3, ab )
            Pad.create( net, BLOCKAGE4, ab )
           #Pad.create( net, BLOCKAGE5, ab )
      
    if False:
      with UpdateSession():
          cell.setAbutmentBox( ab )
          for i in range(16):
              if True:
                  net = cell.getNet('b(%d)' % i)
                  x = 20.0*i + 10.0 + 10
                  y = height-10
                  build_downtrace(net, METAL2, x, y, y+10)
      
   #af.saveCell( cell, CRL.Catalog.State.Views )
    plugins.rsave.scriptMain( **kw )


# -------------------------------------------------------------------------------
# alu16()

def alu16 ( **kw ):

    editor = None
    if kw.has_key('editor') and kw['editor']:
        editor = kw['editor']
  
    db     = DataBase.getDB()
    METAL2 = db.getTechnology().getLayer( 'METAL2' )
    METAL3 = db.getTechnology().getLayer( 'METAL3' )
  
    cell = af.getCell( 'add'  , CRL.Catalog.State.Views   )
    cell = af.getCell( 'sub'  , CRL.Catalog.State.Views   )
    cell = af.getCell( 'alu16', CRL.Catalog.State.Logical )
    if not cell:
        print '[ERROR] Unable to load cell "alu16.vst", aborting .'
        return False

    kw[ 'cell' ] = cell
  
    ab = Box( l(   0.0 )
            , l(   0.0 )
            , l(1150.0 )
            , l( 700.0 ) )
  
    with UpdateSession():
        cell.setAbutmentBox( ab )
    
        ins = cell.getInstance( 'subckt_48_add' )
        ins.setTransformation( Transformation( toDbU(100.0), toDbU(200.0), Transformation.Orientation.ID ) )
        ins.setPlacementStatus( Instance.PlacementStatus.FIXED )
        
        ins = cell.getInstance( 'subckt_49_sub' )
        ins.setTransformation( Transformation( toDbU(650.0), toDbU(200.0), Transformation.Orientation.ID ) )
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
  
    if editor: editor.setCell( cell )
  
    success = placeAndRoute( cell )
   
    cell.setName( cell.getName()+'_r' )
    af.saveCell( cell, CRL.Catalog.State.Views )
    plugins.rsave.scriptMain( **kw )
  
    return success


def scriptMain ( **kw ):
    print af.getEnvironment().getPrint()

    add( **kw )
    sub( **kw )
    success = alu16( **kw )
    return success


if __name__ == '__main__':
   try:
       kw           = {}
       success      = scriptMain( **kw )
       shellSuccess = 0
       if not success: shellSuccess = 1
   except ImportError, e:
       showPythonTrace( __file__, e, False )
       sys.exit(1)
   except Exception, e:
       showPythonTrace( __file__, e )
       sys.exit(2)

   sys.exit( shellSuccess )


