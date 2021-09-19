#!/usr/bin/env python3

import sys
from   Hurricane import *
from   CRL       import *



def toDbU ( l ): return DbU.fromLambda(l)

af = AllianceFramework.get()


def doBreak ( level, message ):
    UpdateSession.close()
    Breakpoint.stop( level, message )
    UpdateSession.open()


class Model ( object ):

    HorizontalAccess =  1
    VerticalAccess   =  2

    def __init__ ( self, modelName ):
        UpdateSession.open()
        self.fillerCount = 0
        self.af          = AllianceFramework.get()
        self.cell        = af.createCell( modelName )
        self.createNet( 'vss', direction=Net.Direction.IN, isExternal=True, isGlobal=True, type=Net.Type.POWER  )
        self.createNet( 'vdd', direction=Net.Direction.IN, isExternal=True, isGlobal=True, type=Net.Type.GROUND )

        self.build()
        UpdateSession.close()
        return


    def createNet ( self, netName, **attributes ):
        net = self.cell.getNet( netName )
        if not net:
          net = Net.create( self.cell, netName ) 

        if 'direction'  in attributes: net.setDirection( attributes['direction' ] )
        if 'isExternal' in attributes: net.setExternal ( attributes['isExternal'] )
        if 'isGlobal'   in attributes: net.setGlobal   ( attributes['isGlobal'  ] )
        if 'type'       in attributes: net.setType     ( attributes['type'      ] )
        return net

    def getNet ( self, netName ):
        return self.createNet( netName )

    def connect ( self, instanceRef, pin, netRef ):
        if isinstance(instanceRef,str):
          instance = self.getInstance( instanceRef )
        else:
          instance = instanceRef

        if isinstance(netRef,str):
          net = self.getNet( netRef )
        else:
          net = netRef

        masterNet = instance.getMasterCell().getNet(pin)
        if not masterNet:
          print( '[ERROR] Master cell "{}" of instance "{}" has no connector named "{}".' \
                 .format( instance.getMasterCell().getName(), instance.getName(), pin ))

        instance.getPlug( instance.getMasterCell().getNet(pin) ).setNet( net )
        return
 
    def place ( self, instanceRef, x, y, orient ):
        if isinstance(instanceRef,str):
          instance = self.getInstance( instanceRef )
        else:
          instance = instanceRef

        instance.setTransformation ( Transformation( x, y, orient ) )
        instance.setPlacementStatus( Instance.PlacementStatus.PLACED )
        return

    def createInstance ( self, instanceName, modelRef, portmap={}, transf=None ):
        instance = self.cell.getInstance( instanceName )
        if not instance:
          if isinstance(modelRef,str):
            model = af.getCell( modelRef, Catalog.State.Views )
          else:
            model = modelRef
          instance = Instance.create( self.cell, instanceName, model )
          for pin, net in portmap.items():
            self.connect( instance, pin, net )

          if transf:
            self.place( instance, transf[0], transf[1], transf[2] )
        return instance

    def createAccess ( self, termPath, x, y, flags ):
        insName, pinName = termPath.split( '.' )
        instance = self.cell.getInstance( insName )
        if not instance:
          print( '[ERROR] Model "{}" has no instance named "{}"' \
                 .format( self.cell.getName(), insName ))
        try:
          plug = instance.getPlug( instance.getMasterCell().getNet(pinName) )
        except:
          print( '[ERROR] Model "{}" of instance "{}" has no terminal named "{}"' \
                 .format( instance.getMasterCell().getName(), instance.getName(), pinName ))
        
        net      = plug.getNet()
        VIA12    = self.getLayer( 'VIA12' )
        VIA23    = self.getLayer( 'VIA23' )
        METAL2   = self.getLayer( 'METAL2' )

        rp       = RoutingPad.create( net, Occurrence(plug), RoutingPad.BiggestArea )
        rpCenter = rp.getPosition()

        if y is None: y = rpCenter.getY()
        contact1 = Contact.create( rp, VIA12, toDbU(0.0), y-rpCenter.getY() )

        if flags & Model.VerticalAccess:
          contact2 = contact1
          contact1 = Contact.create( net, VIA23, x, y )
          Horizontal.create( contact2, contact1, METAL2, y, toDbU(2.0) )
        return contact1

    def createVertical ( self, contacts, x, width=None, layer=None ):
        def yincrease ( element ): return element.getY()

        contacts.sort( key=yincrease )

        if width is None: width = toDbU(2.0)

        if layer is None: layer = self.getLayer( "METAL3" )
        for i in range(1,len(contacts)):
          Vertical.create( contacts[i-1], contacts[i], layer, x, width )
        return

    def createHorizontal ( self, contactPaths, y, width=None, layer=None ):
        def xincrease (element ): return element.getX()

        if isinstance(contactPaths[0],str):
          contacts = []
          for termPath in contactPaths:
            contacts.append( self.createAccess( termPath, None, y, Model.HorizontalAccess ) )
        else:
          contacts = contactPaths

        if width is None: width = toDbU(2.0)

        contacts.sort( key=xincrease )

        if layer is None: layer = self.getLayer( "METAL2" )
        for i in range(1,len(contacts)):
          Horizontal.create( contacts[i-1], contacts[i], layer, y, width )
        return

    def createSerpentine ( self, contactPaths, ymin, ymax, width=None, layer=None ):
        def xincrease ( item ): return item.getX()

        if isinstance(contactPaths[0],str):
          contacts = []
          for termPath in contactPaths:
            contacts.append( self.createAccess( termPath, None, None, Model.HorizontalAccess ) )
        else:
          contacts = contactPaths

        if len(contacts) != 2:
          print( '[ERROR] Model.createSerpentine() takes exactly two points, not {}.'.frormat(len(contacts)) )


        if layer is None: layer = self.getLayer( "METAL2" )
        if width is None: width = toDbU(2.0)

        contacts.sort( key=xincrease )

        turn0      = contacts[0]
        trackPitch = toDbU(5.0)
        for i in range( (contacts[1].getX() - contacts[0].getX()) // trackPitch ):
          y = ymin
          if i%2: y = ymax

          x = turn0.getX()
          turn1 = Contact.create( turn0.getNet(), layer, x           , y, width, width )
          turn2 = Contact.create( turn0.getNet(), layer, x+trackPitch, y, width, width )
          Vertical  .create( turn0, turn1, layer, x, width )
          Horizontal.create( turn1, turn2, layer, y, width )

          turn0 = turn2

        Vertical.create( turn0, contacts[1], layer, contacts[1].getX(), width )

        return

    def addFillersRow ( self, x, y, orient, length ):
        tieWidth = self.getMasterCell("tie_x0").getAbutmentBox().getWidth()
        i        = 0
        for i in range(length//tieWidth):
          self.createInstance( "filler_%d_i" % self.fillerCount
                             , "tie_x0"
                             , transf=( x+tieWidth*i, y, orient) )
          self.fillerCount += 1
        if length%tieWidth:
          delta = 0
          if length > tieWidth: delta = 1
          self.createInstance( "filler_%d_i" % self.fillerCount
                             , "rowend_x0"
                             , transf=( x+tieWidth*(i+delta), y, orient) )
          self.fillerCount += 1
        return

    def getLayer       ( self, name ): return DataBase.getDB().getTechnology().getLayer( name )
    def getCell        ( self ): return self.cell
    def getMasterCell  ( self, name ): return self.af.getCell( name, Catalog.State.Views )
    def setAbutmentBox ( self, ab ): self.cell.setAbutmentBox( ab )
    def getAbutmentBox ( self ): return self.cell.getAbutmentBox()
    def getCellWidth   ( self, name ): return self.getMasterCell(name).getAbutmentBox().getWidth()

    def save ( self ):
        self.af.saveCell( self.cell, Catalog.State.Views )
        return

    def build ( self ):
        print( '[ERROR] Model.build() base class method should never be called.' )
        return


class RingOscillator ( Model ):

    def build ( self ):
        self.setAbutmentBox( Box( toDbU(0.0), toDbU(0.0), toDbU(1595.0), toDbU(450.0) ) )

        self.createNet(   "en"    , direction=Net.Direction.IN, isExternal=True )
        self.createNet(   "en_b"  )
        self.createNet(  "sel0_e" , direction=Net.Direction.IN, isExternal=True )
        self.createNet(  "sel0"   )
        self.createNet( "nsel0"   )
        self.createNet(  "sel1_e" , direction=Net.Direction.IN, isExternal=True )
        self.createNet(  "sel1"   )
        self.createNet( "nsel1"   )
        self.createNet(  "sel2_e" , direction=Net.Direction.IN, isExternal=True )
        self.createNet(  "sel2"   )
        self.createNet( "nsel2"   )
        self.createNet( "osc_out" , direction=Net.Direction.OUT, isExternal=True )
    
       # Create decoder block.
        self.createInstance(    "en_i", "buf_x2", portmap={ "i":"en"    ,  "q":"en_b"  }, transf=(toDbU( 20.0), toDbU(400.0), Transformation.Orientation.MX) )
        self.createInstance(  "sel0_i", "inv_x1", portmap={ "i":"nsel0" , "nq":"sel0"  }, transf=(toDbU( 20.0), toDbU(400.0), Transformation.Orientation.ID) )
        self.createInstance(  "sel1_i", "inv_x1", portmap={ "i":"nsel1" , "nq":"sel1"  }, transf=(toDbU( 35.0), toDbU(400.0), Transformation.Orientation.ID) )
        self.createInstance(  "sel2_i", "inv_x1", portmap={ "i":"nsel2" , "nq":"sel2"  }, transf=(toDbU( 50.0), toDbU(400.0), Transformation.Orientation.ID) )
        self.createInstance( "nsel0_i", "inv_x1", portmap={ "i":"sel0_e", "nq":"nsel0" }, transf=(toDbU( 80.0), toDbU(400.0), Transformation.Orientation.MX) )
        self.createInstance( "nsel1_i", "inv_x1", portmap={ "i":"sel1_e", "nq":"nsel1" }, transf=(toDbU( 95.0), toDbU(400.0), Transformation.Orientation.MX) )
        self.createInstance( "nsel2_i", "inv_x1", portmap={ "i":"sel2_e", "nq":"nsel2" }, transf=(toDbU(110.0), toDbU(400.0), Transformation.Orientation.MX) )
        
        self.createInstance( "en_osc_nxr2_x1_i", "no3_x1", portmap={ "i0":"nsel0", "i1":"nsel1", "i2":"nsel2", "nq":"en_osc_nxr2_x1" }, transf=(toDbU(0.0), toDbU(  0.0), Transformation.Orientation.ID)  )
        self.createInstance( "en_osc_no2_x1_i" , "no3_x1", portmap={ "i0": "sel0", "i1":"nsel1", "i2":"nsel2", "nq":"en_osc_no2_x1"  }, transf=(toDbU(0.0), toDbU(100.0), Transformation.Orientation.MY)  )
        self.createInstance( "en_osc_na2_x1_i" , "no3_x1", portmap={ "i0":"nsel0", "i1": "sel1", "i2":"nsel2", "nq":"en_osc_na2_x1"  }, transf=(toDbU(0.0), toDbU(100.0), Transformation.Orientation.ID)  )
        self.createInstance( "en_osc_buf_x8_i" , "no3_x1", portmap={ "i0": "sel0", "i1": "sel1", "i2":"nsel2", "nq":"en_osc_buf_x8"  }, transf=(toDbU(0.0), toDbU(200.0), Transformation.Orientation.MY)  )
        self.createInstance( "en_osc_buf_x2_i" , "no3_x1", portmap={ "i0":"nsel0", "i1":"nsel1", "i2": "sel2", "nq":"en_osc_buf_x2"  }, transf=(toDbU(0.0), toDbU(200.0), Transformation.Orientation.ID)  )
        self.createInstance( "en_osc_inv_rc_i" , "no3_x1", portmap={ "i0": "sel0", "i1":"nsel1", "i2": "sel2", "nq":"en_osc_inv_rc"  }, transf=(toDbU(0.0), toDbU(300.0), Transformation.Orientation.MY)  )
        self.createInstance( "en_osc_inv_x4_i" , "no3_x1", portmap={ "i0":"nsel0", "i1": "sel1", "i2": "sel2", "nq":"en_osc_inv_x4"  }, transf=(toDbU(0.0), toDbU(300.0), Transformation.Orientation.ID)  )
        self.createInstance( "en_osc_inv_x1_i" , "no3_x1", portmap={ "i0": "sel0", "i1": "sel1", "i2": "sel2", "nq":"en_osc_inv_x1"  }, transf=(toDbU(0.0), toDbU(400.0), Transformation.Orientation.MY)  )

        xwire = toDbU(10.0)
        vcontacts = \
          [ self.createAccess( "en_i.i", xwire, toDbU(425), Model.VerticalAccess )
          , Contact.create( self.getNet("en")
                          , self.getLayer("METAL3")
                          , xwire
                          , toDbU(528.0)
                          , toDbU(  2.0)
                          , toDbU(  2.0)
                          )
          ]
        self.createVertical( vcontacts, xwire )
        for component in vcontacts[-1].getSlaveComponents():
          NetExternalComponents.setExternal( component )

        xwire = toDbU(75.0)
        vcontacts = \
          [ self.createAccess( "nsel0_i.i", xwire, toDbU(440), Model.VerticalAccess )
          , Contact.create( self.getNet("sel0_e")
                          , self.getLayer("METAL3")
                          , xwire
                          , toDbU(528.0)
                          , toDbU(  2.0)
                          , toDbU(  2.0)
                          )
          ]
        self.createVertical( vcontacts, xwire )
        for component in vcontacts[-1].getSlaveComponents():
          NetExternalComponents.setExternal( component )

        xwire = toDbU(90.0)
        vcontacts = \
          [ self.createAccess( "nsel1_i.i", xwire, toDbU(430), Model.VerticalAccess )
          , Contact.create( self.getNet("sel1_e")
                          , self.getLayer("METAL3")
                          , xwire
                          , toDbU(528.0)
                          , toDbU(  2.0)
                          , toDbU(  2.0)
                          )
          ]
        self.createVertical( vcontacts, xwire )
        for component in vcontacts[-1].getSlaveComponents():
          NetExternalComponents.setExternal( component )

        xwire = toDbU(105.0)
        vcontacts = \
          [ self.createAccess( "nsel2_i.i", xwire, toDbU(420), Model.VerticalAccess )
          , Contact.create( self.getNet("sel2_e")
                          , self.getLayer("METAL3")
                          , xwire
                          , toDbU(528.0)
                          , toDbU(  2.0)
                          , toDbU(  2.0)
                          )
          ]
        self.createVertical( vcontacts, xwire )
        for component in vcontacts[-1].getSlaveComponents():
          NetExternalComponents.setExternal( component )

       # "nsel0" wiring.
        y = toDbU(440.0)
        x = toDbU( 15.0)
        hcontacts = \
          [ self.createAccess( "nsel0_i.nq", toDbU(70.0), y, Model.HorizontalAccess )
          , self.createAccess( "sel0_i.i"  , x          , y, Model.VerticalAccess )
          ]
        self.createHorizontal( hcontacts, y )
        vcontacts = \
          [ hcontacts[-1]
          , self.createAccess( "en_osc_nxr2_x1_i.i0", x, toDbU( 35.0), Model.VerticalAccess )
          , self.createAccess( "en_osc_na2_x1_i.i0" , x, toDbU(135.0), Model.VerticalAccess )
          , self.createAccess( "en_osc_buf_x2_i.i0" , x, toDbU(235.0), Model.VerticalAccess )
          , self.createAccess( "en_osc_inv_x4_i.i0" , x, toDbU(335.0), Model.VerticalAccess )
          ]
        self.createVertical( vcontacts, x )

       # "sel0" wiring.
        y = toDbU(435.0)
        x = toDbU( 20.0)
        hcontacts = \
          [ self.createAccess( "sel0_i.nq", x, y, Model.VerticalAccess )
          ]
        self.createHorizontal( hcontacts, y )
        vcontacts = \
          [ hcontacts[-1]
          , self.createAccess( "en_osc_no2_x1_i.i0" , x, toDbU( 65.0), Model.VerticalAccess )
          , self.createAccess( "en_osc_buf_x8_i.i0" , x, toDbU(165.0), Model.VerticalAccess )
          , self.createAccess( "en_osc_inv_rc_i.i0" , x, toDbU(265.0), Model.VerticalAccess )
          , self.createAccess( "en_osc_inv_x1_i.i0" , x, toDbU(365.0), Model.VerticalAccess )
          ]
        self.createVertical( vcontacts, x )

       # "nsel1" wiring.
        y = toDbU(430.0)
        x = toDbU( 25.0)
        hcontacts = \
          [ self.createAccess( "nsel1_i.nq", toDbU(70.0), y, Model.HorizontalAccess )
          , self.createAccess( "sel1_i.i"  , x          , y, Model.VerticalAccess )
          ]
        self.createHorizontal( hcontacts, y )
        vcontacts = \
          [ hcontacts[-1]
          , self.createAccess( "en_osc_nxr2_x1_i.i1", x, toDbU( 30.0), Model.VerticalAccess )
          , self.createAccess( "en_osc_no2_x1_i.i1" , x, toDbU( 80.0), Model.VerticalAccess )
          , self.createAccess( "en_osc_buf_x2_i.i1" , x, toDbU(230.0), Model.VerticalAccess )
          , self.createAccess( "en_osc_inv_rc_i.i1" , x, toDbU(280.0), Model.VerticalAccess )
          ]
        self.createVertical( vcontacts, x )

       # "sel1" wiring.
        y = toDbU(425.0)
        x = toDbU( 30.0)
        hcontacts = \
          [ self.createAccess( "sel1_i.nq", x, y, Model.VerticalAccess )
          ]
        self.createHorizontal( hcontacts, y )
        vcontacts = \
          [ hcontacts[-1]
          , self.createAccess( "en_osc_na2_x1_i.i1" , x, toDbU(130.0), Model.VerticalAccess )
          , self.createAccess( "en_osc_buf_x8_i.i1" , x, toDbU(180.0), Model.VerticalAccess )
          , self.createAccess( "en_osc_inv_x4_i.i1" , x, toDbU(330.0), Model.VerticalAccess )
          , self.createAccess( "en_osc_inv_x1_i.i1" , x, toDbU(380.0), Model.VerticalAccess )
          ]
        self.createVertical( vcontacts, x )

       # "nsel2" wiring.
        y = toDbU(420.0)
        x = toDbU( 35.0)
        hcontacts = \
          [ self.createAccess( "nsel2_i.nq", toDbU(70.0), y, Model.HorizontalAccess )
          , self.createAccess( "sel2_i.i"  , x          , y, Model.VerticalAccess )
          ]
        self.createHorizontal( hcontacts, y )
        vcontacts = \
          [ hcontacts[-1]
          , self.createAccess( "en_osc_nxr2_x1_i.i2", x, toDbU( 10.0), Model.VerticalAccess )
          , self.createAccess( "en_osc_no2_x1_i.i2" , x, toDbU( 90.0), Model.VerticalAccess )
          , self.createAccess( "en_osc_na2_x1_i.i2" , x, toDbU(110.0), Model.VerticalAccess )
          , self.createAccess( "en_osc_buf_x8_i.i2" , x, toDbU(190.0), Model.VerticalAccess )
          ]
        self.createVertical( vcontacts, x )

       # "sel2" wiring.
        y = toDbU(415.0)
        x = toDbU( 40.0)
        hcontacts = \
          [ self.createAccess( "sel2_i.nq"  , toDbU(40.0), y, Model.VerticalAccess )
          ]
        self.createHorizontal( hcontacts, y )
        vcontacts = \
          [ hcontacts[-1]
          , self.createAccess( "en_osc_buf_x2_i.i2" , x, toDbU(210.0), Model.VerticalAccess )
          , self.createAccess( "en_osc_inv_rc_i.i2" , x, toDbU(270.0), Model.VerticalAccess )
          , self.createAccess( "en_osc_inv_x4_i.i2" , x, toDbU(310.0), Model.VerticalAccess )
          , self.createAccess( "en_osc_inv_x1_i.i2" , x, toDbU(390.0), Model.VerticalAccess )
          ]
        self.createVertical( vcontacts, x )

        
       # Create inv_x1 ring (x100).
        ringLength = 100
        x          = self.getMasterCell( "no3_x1" ).getAbutmentBox().getWidth()
        stageIn    = "osc_inv_x1_na3"
        self.createInstance( stageIn+"_i"
                           , "na3_x1"
                           , portmap={ "i0":"en_b"
                                     , "i1":"en_osc_inv_x1"
                                     , "i2":"osc_inv_x1_%d" % (ringLength-1)
                                     , "nq":stageIn }
                           , transf =(x, toDbU(400.0), Transformation.Orientation.MY)  )
        x += self.getMasterCell( "na3_x1" ).getAbutmentBox().getWidth()
        self.createHorizontal( [ "en_osc_inv_x1_i.nq", "%s_i.i1"%stageIn ], toDbU(375.0) )
        
        for i in range(ringLength):
          stageOut = "osc_inv_x1_%d" % i
          self.createInstance( stageOut+"_i"
                             , "inv_x1"
                             , portmap={ "i":stageIn, "nq":stageOut }
                             , transf =(x, toDbU(400.0), Transformation.Orientation.MY)  )
          x += self.getMasterCell( "inv_x1" ).getAbutmentBox().getWidth()

          self.createHorizontal( [ "%s_i.nq"%stageIn, "%s_i.i" %stageOut ], toDbU(375.0) )
          stageIn = stageOut

        self.createHorizontal( [ "osc_inv_x1_na3_i.i2"
                               , "osc_inv_x1_%d_i.nq" % (ringLength-1) ], toDbU(385.0) )
        
        
       # Create inv_x4 ring (x76).
        ringLength = 76
        x          = self.getMasterCell( "no3_x1" ).getAbutmentBox().getWidth()
        stageIn    = "osc_inv_x4_na3"
        self.createInstance( stageIn+"_i"
                           , "na3_x1"
                           , portmap={ "i0":"en_b"
                                     , "i1":"en_osc_inv_x4"
                                     , "i2":"osc_inv_x4_%d" % (ringLength-1)
                                     , "nq":stageIn }
                           , transf =(x, toDbU(300.0), Transformation.Orientation.ID)  )
        x += self.getMasterCell( "na3_x1" ).getAbutmentBox().getWidth()
        self.createHorizontal( [ "en_osc_inv_x4_i.nq", "%s_i.i1"%stageIn ], toDbU(325.0) )
        
        for i in range(ringLength):
          stageOut = "osc_inv_x4_%d" % i
          self.createInstance( stageOut+"_i"
                             , "inv_x4"
                             , portmap={ "i":stageIn, "nq":stageOut }
                             , transf =(x, toDbU(300.0), Transformation.Orientation.ID)  )
          x += self.getMasterCell( "inv_x4" ).getAbutmentBox().getWidth()

          self.createHorizontal( [ "%s_i.nq"%stageIn, "%s_i.i" %stageOut ], toDbU(325.0) )
          stageIn = stageOut

        self.createHorizontal( [ "osc_inv_x4_na3_i.i2"
                               , "osc_inv_x4_%d_i.nq" % (ringLength-1) ], toDbU(335.0) )
        
       # Create inv_x1, with RC load ring (x50).
        ringLength = 50
        x          = self.getMasterCell( "no3_x1" ).getAbutmentBox().getWidth()
        stageIn    = "osc_inv_rc_na3"
        self.createInstance( stageIn+"_i"
                           , "na3_x1"
                           , portmap={ "i0":"en_b"
                                     , "i1":"en_osc_inv_rc"
                                     , "i2":"osc_inv_rc_%d" % (ringLength-1)
                                     , "nq":stageIn }
                           , transf =(x, toDbU(300.0), Transformation.Orientation.MY)  )
        x += self.getMasterCell( "na3_x1" ).getAbutmentBox().getWidth()
        self.createHorizontal( [ "en_osc_inv_rc_i.nq", "%s_i.i1"%stageIn ], toDbU(275.0) )
        
        serpentineSpacing = toDbU(15.0)
        for i in range(ringLength):
          stageOut = "osc_inv_rc_%d" % i
          self.createInstance( stageOut+"_i"
                             , "inv_x1"
                             , portmap={ "i":stageIn, "nq":stageOut }
                             , transf =(x, toDbU(300.0), Transformation.Orientation.MY)  )
          x += self.getMasterCell( "inv_x1" ).getAbutmentBox().getWidth()
          self.addFillersRow( x, toDbU(300.0), Transformation.Orientation.MY, serpentineSpacing )
          x += serpentineSpacing

          self.createSerpentine( [ "%s_i.nq"%stageIn, "%s_i.i" %stageOut ]
                                 , toDbU(285.0), toDbU(240.0) )
          stageIn = stageOut

        self.createHorizontal( [ "osc_inv_rc_na3_i.i2"
                               , "osc_inv_rc_%d_i.nq" % (ringLength-1) ], toDbU(290.0) )
        
       # Create buf_x2 ring (x75).
        ringLength = 75
        x          = self.getMasterCell( "no3_x1" ).getAbutmentBox().getWidth()
        stageIn    = "osc_buf_x2_na3"
        self.createInstance( stageIn+"_i"
                           , "na3_x1"
                           , portmap={ "i0":"en_b"
                                     , "i1":"en_osc_buf_x2"
                                     , "i2":"osc_buf_x2_%d" % (ringLength-1)
                                     , "nq":stageIn }
                           , transf =(x, toDbU(200.0), Transformation.Orientation.ID)  )
        x += self.getMasterCell( "na3_x1" ).getAbutmentBox().getWidth()
        self.createHorizontal( [ "en_osc_buf_x2_i.nq", "%s_i.i1"%stageIn ], toDbU(225.0) )
        
        for i in range(ringLength):
          stageOut = "osc_buf_x2_%d" % i
          self.createInstance( stageOut+"_i"
                             , "buf_x2"
                             , portmap={ "i":stageIn, "q":stageOut }
                             , transf =(x, toDbU(200.0), Transformation.Orientation.ID)  )
          x += self.getMasterCell( "buf_x2" ).getAbutmentBox().getWidth()

          pin = "q"
          if i == 0: pin = "nq"
          self.createHorizontal( [ "%s_i.%s"%(stageIn,pin), "%s_i.i" %stageOut ], toDbU(225.0) )
          stageIn = stageOut

        self.createHorizontal( [ "osc_buf_x2_na3_i.i2"
                               , "osc_buf_x2_%d_i.q" % (ringLength-1) ], toDbU(235.0) )
        
       # Create buf_x8 ring (x37).
        ringLength = 37
        x          = self.getMasterCell( "no3_x1" ).getAbutmentBox().getWidth()
        stageIn    = "osc_buf_x8_na3"
        self.createInstance( stageIn+"_i"
                           , "na3_x1"
                           , portmap={ "i0":"en_b"
                                     , "i1":"en_osc_buf_x8"
                                     , "i2":"osc_buf_x8_%d" % (ringLength-1)
                                     , "nq":stageIn }
                           , transf =(x, toDbU(200.0), Transformation.Orientation.MY)  )
        x += self.getMasterCell( "na3_x1" ).getAbutmentBox().getWidth()
        self.createHorizontal( [ "en_osc_buf_x8_i.nq", "%s_i.i1"%stageIn ], toDbU(175.0) )
        
        for i in range(ringLength):
          stageOut = "osc_buf_x8_%d" % i
          self.createInstance( stageOut+"_i"
                             , "buf_x8"
                             , portmap={ "i":stageIn, "q":stageOut }
                             , transf =(x, toDbU(200.0), Transformation.Orientation.MY)  )
          x += self.getMasterCell( "buf_x8" ).getAbutmentBox().getWidth()

          pin = "q"
          if i == 0: pin = "nq"
          self.createHorizontal( [ "%s_i.%s"%(stageIn,pin), "%s_i.i" %stageOut ], toDbU(175.0) )
          stageIn = stageOut

        self.createHorizontal( [ "osc_buf_x8_na3_i.i2"
                               , "osc_buf_x8_%d_i.q" % (ringLength-1) ], toDbU(185.0) )
        
       # Create na2_x1 ring (x76).
        ringLength = 76
        x          = self.getMasterCell( "no3_x1" ).getAbutmentBox().getWidth()
        stageIn    = "osc_na2_x1_na3"
        self.createInstance( stageIn+"_i"
                           , "na3_x1"
                           , portmap={ "i0":"en_b"
                                     , "i1":"en_osc_na2_x1"
                                     , "i2":"osc_na2_x1_%d" % (ringLength-1)
                                     , "nq":stageIn }
                           , transf =(x, toDbU(100.0), Transformation.Orientation.ID)  )
        x += self.getMasterCell( "na3_x1" ).getAbutmentBox().getWidth()
        self.createHorizontal( [ "en_osc_na2_x1_i.nq", "%s_i.i1"%stageIn ], toDbU(125.0) )
        
        for i in range(ringLength):
          stageOut = "osc_na2_x1_%d" % i
          self.createInstance( stageOut+"_i"
                             , "na2_x1"
                             , portmap={ "i0":stageIn, "i1":stageIn, "nq":stageOut }
                             , transf =(x, toDbU(100.0), Transformation.Orientation.ID)  )
          x += self.getMasterCell( "na2_x1" ).getAbutmentBox().getWidth()

          deltaY = 0
          if i%2: deltaY = toDbU(5.0)
          self.createHorizontal( [ "%s_i.nq"%stageIn
                                 , "%s_i.i0"%stageOut
                                 , "%s_i.i1"%stageOut ], toDbU(125.0)+deltaY )
          stageIn = stageOut

        self.createHorizontal( [ "osc_na2_x1_na3_i.i2"
                               , "osc_na2_x1_%d_i.nq" % (ringLength-1) ], toDbU(135.0) )
        
       # Create no2_x1 ring (x76).
        ringLength = 76
        x          = self.getMasterCell( "no3_x1" ).getAbutmentBox().getWidth()
        stageIn    = "osc_no2_x1_na3"
        self.createInstance( stageIn+"_i"
                           , "na3_x1"
                           , portmap={ "i0":"en_b"
                                     , "i1":"en_osc_no2_x1"
                                     , "i2":"osc_no2_x1_%d" % (ringLength-1)
                                     , "nq":stageIn }
                           , transf =(x, toDbU(100.0), Transformation.Orientation.MY)  )
        x += self.getMasterCell( "na3_x1" ).getAbutmentBox().getWidth()
        self.createHorizontal( [ "en_osc_no2_x1_i.nq", "%s_i.i1"%stageIn ], toDbU(75.0) )
        
        for i in range(ringLength):
          stageOut = "osc_no2_x1_%d" % i
          self.createInstance( stageOut+"_i"
                             , "no2_x1"
                             , portmap={ "i0":stageIn, "i1":stageIn, "nq":stageOut }
                             , transf =(x, toDbU(100.0), Transformation.Orientation.MY)  )
          x += self.getMasterCell( "no2_x1" ).getAbutmentBox().getWidth()

          deltaY = 0
          if i%2: deltaY = toDbU(5.0)
          self.createHorizontal( [ "%s_i.nq"%stageIn
                                 , "%s_i.i0"%stageOut
                                 , "%s_i.i1"%stageOut ], toDbU(75.0)+deltaY )
          stageIn = stageOut

        self.createHorizontal( [ "osc_no2_x1_na3_i.i2"
                               , "osc_no2_x1_%d_i.nq" % (ringLength-1) ], toDbU(85.0) )
        
       # Create nxr2_x1 ring (x34).
        ringLength = 34
        x          = self.getMasterCell( "no3_x1" ).getAbutmentBox().getWidth()
        stageIn    = "osc_nxr2_x1_na3"
        self.createInstance( stageIn+"_i"
                           , "na3_x1"
                           , portmap={ "i0":"en_b"
                                     , "i1":"en_osc_nxr2_x1"
                                     , "i2":"osc_nxr2_x1_%d" % (ringLength-1)
                                     , "nq":stageIn }
                           , transf =(x, toDbU(0.0), Transformation.Orientation.ID)  )
        x += self.getMasterCell( "na3_x1" ).getAbutmentBox().getWidth()
        self.createHorizontal( [ "en_osc_nxr2_x1_i.nq", "%s_i.i1"%stageIn ], toDbU(25.0) )
        
        for i in range(ringLength):
          stageOut = "osc_nxr2_x1_%d" % i
          self.createInstance( stageOut+"_i"
                             , "nxr2_x1"
                             , portmap={ "i0":stageIn, "i1":stageIn, "nq":stageOut }
                             , transf =(x, toDbU(0.0), Transformation.Orientation.ID)  )
          x += self.getMasterCell( "nxr2_x1" ).getAbutmentBox().getWidth()

          deltaY = 0
          if i%2: deltaY = toDbU(5.0)
          self.createHorizontal( [ "%s_i.nq"%stageIn
                                 , "%s_i.i0"%stageOut
                                 , "%s_i.i1"%stageOut ], toDbU(25.0)+deltaY )
          stageIn = stageOut

        self.createHorizontal( [ "osc_nxr2_x1_na3_i.i2"
                               , "osc_nxr2_x1_%d_i.nq" % (ringLength-1) ], toDbU(35.0) )

       # Can be created only after all the loops.
       # "en_b" wiring.
        x = toDbU(5.0)
        contacts = \
          [ self.createAccess( "osc_nxr2_x1_na3_i.i0", x, toDbU( 15.0), Model.VerticalAccess )
          , self.createAccess( "osc_no2_x1_na3_i.i0" , x, toDbU( 85.0), Model.VerticalAccess )
          , self.createAccess( "osc_na2_x1_na3_i.i0" , x, toDbU(115.0), Model.VerticalAccess )
          , self.createAccess( "osc_buf_x8_na3_i.i0" , x, toDbU(185.0), Model.VerticalAccess )
          , self.createAccess( "osc_buf_x2_na3_i.i0" , x, toDbU(215.0), Model.VerticalAccess )
          , self.createAccess( "osc_inv_rc_na3_i.i0" , x, toDbU(285.0), Model.VerticalAccess )
          , self.createAccess( "osc_inv_x4_na3_i.i0" , x, toDbU(315.0), Model.VerticalAccess )
          , self.createAccess( "osc_inv_x1_na3_i.i0" , x, toDbU(385.0), Model.VerticalAccess )
          , self.createAccess( "en_i.q"              , x, toDbU(415.0), Model.VerticalAccess )
          ]
        self.createVertical( contacts, x )
        
       # big mux block.
        x = self.getAbutmentBox().getWidth()

        self.createInstance( "mux_na2_0_i"
                           , "na2_x1"
                           , portmap={"i1":"osc_nxr2_x1_33", "i0":"osc_no2_x1_75", "nq":"mux_na2_0"}
                           , transf=(x-self.getCellWidth("na2_x1"), toDbU(100.0), Transformation.Orientation.MY)
                           )
        self.createHorizontal( [ "mux_na2_0_i.i0", "osc_no2_x1_75_i.nq" ], toDbU(85.0) )
        ywire = toDbU(  35.0)
        xwire = toDbU(1590.0)
        vcontacts = \
          [ self.createAccess( "osc_nxr2_x1_33_i.nq", xwire, ywire      , Model.VerticalAccess )
          , self.createAccess( "mux_na2_0_i.i1"     , xwire, toDbU(60.0), Model.VerticalAccess )
          ]
        self.createVertical( vcontacts, xwire )

        self.createInstance( "mux_na2_1_i"
                           , "na2_x1"
                           , portmap={"i1": "osc_na2_x1_75", "i0":"osc_buf_x8_36", "nq":"mux_na2_1"}
                           , transf=(x-self.getCellWidth("na2_x1"), toDbU(200.0), Transformation.Orientation.MY)
                           )
        self.createHorizontal( [ "mux_na2_1_i.i0", "osc_buf_x8_36_i.q" ], toDbU(185.0) )
        ywire = toDbU( 135.0)
        xwire = toDbU(1590.0)
        vcontacts = \
          [ self.createAccess( "osc_na2_x1_75_i.nq", xwire, ywire       , Model.VerticalAccess )
          , self.createAccess( "mux_na2_1_i.i1"    , xwire, toDbU(160.0), Model.VerticalAccess )
          ]
        self.createVertical( vcontacts, xwire )

        self.createInstance( "mux_na2_2_i"
                           , "na2_x1"
                           , portmap={"i1": "osc_buf_x2_74", "i0":"osc_inv_rc_49", "nq":"mux_na2_2"}
                           , transf=(x-self.getCellWidth("na2_x1"), toDbU(300.0), Transformation.Orientation.MY)
                           )
        self.createHorizontal( [ "mux_na2_2_i.i0", "osc_inv_rc_49_i.nq" ], toDbU(290.0) )
        ywire = toDbU( 235.0)
        xwire = toDbU(1590.0)
        vcontacts = \
          [ self.createAccess( "osc_buf_x2_74_i.q", xwire, ywire       , Model.VerticalAccess )
          , self.createAccess( "mux_na2_2_i.i1"   , xwire, toDbU(260.0), Model.VerticalAccess )
          ]
        self.createVertical( vcontacts, xwire )

        self.createInstance( "mux_na2_3_i"
                           , "na2_x1"
                           , portmap={"i1": "osc_inv_x4_75", "i0":"osc_inv_x1_99", "nq":"mux_na2_3"}
                           , transf=(x-self.getCellWidth("na2_x1"), toDbU(400.0), Transformation.Orientation.MY)
                           )
        self.createHorizontal( [ "mux_na2_3_i.i0", "osc_inv_x1_99_i.nq" ], toDbU(385.0) )
        ywire = toDbU( 335.0)
        xwire = toDbU(1590.0)
        vcontacts = \
          [ self.createAccess( "osc_inv_x4_75_i.nq", xwire, ywire       , Model.VerticalAccess )
          , self.createAccess( "mux_na2_3_i.i1"    , xwire, toDbU(360.0), Model.VerticalAccess )
          ]
        self.createVertical( vcontacts, xwire )

        self.createInstance( "mux_o4_i"   
                           , "o4_x2"
                           , portmap={"i0":    "mux_na2_0"
                                     ,"i1":    "mux_na2_1"
                                     ,"i2":    "mux_na2_2"
                                     ,"i3":    "mux_na2_3"
                                     ,"q":     "mux_o4"}
                           , transf=( x #-self.getCellWidth("na4_x1")
                                    , toDbU(200.0)
                                    , Transformation.Orientation.MX )
                           )
        xwire = toDbU(1580.0)
        vcontacts = \
          [ self.createAccess( "mux_o4_i.i0"   , xwire, toDbU(215.0), Model.VerticalAccess )
          , self.createAccess( "mux_na2_0_i.nq", xwire, toDbU( 75.0), Model.VerticalAccess )
          ]
        self.createVertical( vcontacts, xwire )
        xwire = toDbU(1585.0)
        vcontacts = \
          [ self.createAccess( "mux_o4_i.i1"   , xwire, toDbU(215.0), Model.VerticalAccess )
          , self.createAccess( "mux_na2_1_i.nq", xwire, toDbU(175.0), Model.VerticalAccess )
          ]
        self.createVertical( vcontacts, xwire )
        xwire = toDbU(1575.0)
        vcontacts = \
          [ self.createAccess( "mux_o4_i.i2"   , xwire, toDbU(225.0), Model.VerticalAccess )
          , self.createAccess( "mux_na2_2_i.nq", xwire, toDbU(275.0), Model.VerticalAccess )
          ]
        self.createVertical( vcontacts, xwire )
        xwire = toDbU(1585.0)
        vcontacts = \
          [ self.createAccess( "mux_o4_i.i3"   , xwire, toDbU(225.0), Model.VerticalAccess )
          , self.createAccess( "mux_na2_3_i.nq", xwire, toDbU(375.0), Model.VerticalAccess )
          ]
        self.createVertical( vcontacts, xwire )

       # Frequency divider block.
        stageIn = "mux_o4"
        x = self.getAbutmentBox().getWidth()
        for i in range(14):
          stageOut = "divider_sff1_%d" % i

          self.createInstance( "divider_sff1_%d_i" % i
                             , "sff1_x4"
                             , portmap={"ck":stageIn, "i" :stageOut+"_nq", "q" :stageOut }
                             , transf=(x, toDbU(400.0), Transformation.Orientation.MX) )
          x -= self.getMasterCell("sff1_x4").getAbutmentBox().getWidth()

          x -= self.getMasterCell("inv_x1").getAbutmentBox().getWidth()
          self.createInstance( "divider_inv_%d_i" % i
                             , "inv_x1"
                             , portmap={"i":stageOut, "nq":stageOut+"_nq"}
                             , transf=(x, toDbU(400.0), Transformation.Orientation.ID) )

          if i > 0:
            self.createHorizontal( [ stageOut+"_i.ck"
                                   , "divider_inv_%d_i.i"%(i-1)
                                   , stageIn+"_i.q" ], toDbU(425.0) )
          self.createHorizontal( [ stageOut+"_i.i", "divider_inv_%d_i.nq"%i ], toDbU(430.0) )
          stageIn = stageOut

        xwire = toDbU(1565.0)
        vcontacts = \
          [ self.createAccess( "mux_o4_i.q"         , xwire, toDbU(225.0), Model.VerticalAccess )
          , self.createAccess( "divider_sff1_0_i.ck", xwire, toDbU(425.0), Model.VerticalAccess )
          ]
        self.createVertical( vcontacts, xwire )

        self.createInstance( "osc_out_i", "inv_x1"
                           , portmap={"i":stageIn,"nq":"osc_out"}
                           , transf=(x, toDbU(400.0), Transformation.Orientation.MX)
                           )
        x -= self.getMasterCell("inv_x1").getAbutmentBox().getWidth()

        self.createHorizontal( [ "osc_out_i.i"
                               , "divider_inv_%d_i.i"%i
                               , stageIn+"_i.q" ], toDbU(425.0) )

        xwire = toDbU(115.0)
        vcontacts = \
          [ self.createAccess( "osc_out_i.nq", xwire, toDbU(425), Model.VerticalAccess )
          , Contact.create( self.getNet("osc_out")
                          , self.getLayer("METAL3")
                          , xwire
                          , toDbU(528.0)
                          , toDbU(  2.0)
                          , toDbU(  2.0)
                          )
          ]
        self.createVertical( vcontacts, xwire )
        for component in vcontacts[-1].getSlaveComponents():
          NetExternalComponents.setExternal( component )
 
        self.addFillers()
        self.buildPower()
        return


    def addFillers ( self ):
        self.addFillersRow( toDbU(1580.0), toDbU(  0.0), Transformation.Orientation.ID, toDbU(15.0) )
        self.addFillersRow( toDbU(1570.0), toDbU(100.0), Transformation.Orientation.MY, toDbU( 5.0) )
        self.addFillersRow( toDbU(1570.0), toDbU(100.0), Transformation.Orientation.ID, toDbU(25.0) )
        self.addFillersRow( toDbU(1530.0), toDbU(200.0), Transformation.Orientation.MY, toDbU(45.0) )
        self.addFillersRow( toDbU(1550.0), toDbU(200.0), Transformation.Orientation.ID, toDbU(10.0) )
        self.addFillersRow( toDbU(1550.0), toDbU(300.0), Transformation.Orientation.MY, toDbU(25.0) )
        self.addFillersRow( toDbU(1570.0), toDbU(300.0), Transformation.Orientation.ID, toDbU(25.0) )
        self.addFillersRow( toDbU(1550.0), toDbU(400.0), Transformation.Orientation.MY, toDbU(25.0) )
        return


    def buildPower ( self ):
        METAL1       = self.getLayer( "METAL1" )
        METAL2       = self.getLayer( "METAL2" )
        METAL3       = self.getLayer( "METAL3" )
        VIA12        = self.getLayer( "VIA12" )
        VIA23        = self.getLayer( "VIA23" )
        powerWidth   = toDbU(24.0)
        powerSpacing = toDbU(10.0)
        ab           = self.getAbutmentBox()
        vdd          = self.getNet( "vdd" )
        vss          = self.getNet( "vss" )
        vddAxis      = Box(ab).inflate( powerSpacing + powerWidth//2 )
        vssAxis      = Box(ab).inflate( powerSpacing + powerWidth//2 + powerWidth + toDbU(10.0) )

       # Building "vdd" power ring.
        westContactsVdd = \
          [ Contact.create( vdd, VIA23, vddAxis.getXMin(), vddAxis.getYMin(), powerWidth, powerWidth )
          , Contact.create( vdd, VIA23, vddAxis.getXMin(), vddAxis.getYMax(), powerWidth, powerWidth )
          ]
        eastContactsVdd = \
          [ Contact.create( vdd, VIA23, vddAxis.getXMax(), vddAxis.getYMin(), powerWidth, powerWidth )
          , Contact.create( vdd, VIA23, vddAxis.getXMax(), vddAxis.getYMax(), powerWidth, powerWidth )
          ]

        for i in range(5):
          ywidth = toDbU(12.0)
          if i == 4: ywidth = toDbU(6.0)
          yaxis = ab.getXMin() + toDbU(50.0) * ( 1 + i*2 )

          westContact = Contact.create( vdd, VIA12, vddAxis.getXMin(), yaxis, powerWidth, ywidth )
          eastContact = Contact.create( vdd, VIA12, vddAxis.getXMax(), yaxis, powerWidth, ywidth )
          self.createHorizontal( [westContact,eastContact], yaxis, ywidth, layer=METAL1 )

          westContact = Contact.create( vdd, VIA23, vddAxis.getXMin(), yaxis, powerWidth, ywidth )
          eastContact = Contact.create( vdd, VIA23, vddAxis.getXMax(), yaxis, powerWidth, ywidth )
          
          westContactsVdd.insert( -1, westContact )
          eastContactsVdd.insert( -1, eastContact )

        self.createVertical( westContactsVdd, vddAxis.getXMin(), powerWidth )
        self.createVertical( eastContactsVdd, vddAxis.getXMax(), powerWidth )

        xcenter = vddAxis.getCenter().getX() + powerWidth//2 + toDbU(5.0)
        accessContactsVdd = \
          [ Contact.create( vdd, VIA23 , xcenter, vddAxis.getYMax(), powerWidth, powerWidth )
          , Contact.create( vdd, METAL3, xcenter,      toDbU(528.0), powerWidth, toDbU(2.0) ) 
          ]

        northContactsVdd = \
          [   westContactsVdd[-1]
          , accessContactsVdd[ 0]
          ,   eastContactsVdd[-1]
          ]
        southContactsVdd = \
          [ westContactsVdd[0]
          , eastContactsVdd[0]
          ]
        self.createHorizontal(  southContactsVdd, vddAxis.getYMin(), powerWidth )
        self.createHorizontal(  northContactsVdd, vddAxis.getYMax(), powerWidth )
        self.createVertical  ( accessContactsVdd, xcenter          , powerWidth )
        for component in accessContactsVdd[-1].getSlaveComponents():
          NetExternalComponents.setExternal( component )

       # Building "vss" power ring.
        westContactsVss = \
          [ Contact.create( vss, VIA23, vssAxis.getXMin(), vssAxis.getYMin(), powerWidth, powerWidth )
          , Contact.create( vss, VIA23, vssAxis.getXMin(), vssAxis.getYMax(), powerWidth, powerWidth )
          ]
        eastContactsVss = \
          [ Contact.create( vss, VIA23, vssAxis.getXMax(), vssAxis.getYMin(), powerWidth, powerWidth )
          , Contact.create( vss, VIA23, vssAxis.getXMax(), vssAxis.getYMax(), powerWidth, powerWidth )
          ]

        for i in range(5):
          ywidth = toDbU(12.0)
          if i == 0: ywidth = toDbU(6.0)
          yaxis = ab.getXMin() + toDbU(50.0) * ( i*2 )

          westContact = Contact.create( vss, VIA12, vssAxis.getXMin(), yaxis, powerWidth, ywidth )
          eastContact = Contact.create( vss, VIA12, vssAxis.getXMax(), yaxis, powerWidth, ywidth )
          self.createHorizontal( [westContact,eastContact], yaxis, ywidth, layer=METAL1 )

          westContact = Contact.create( vss, VIA23, vssAxis.getXMin(), yaxis, powerWidth, ywidth )
          eastContact = Contact.create( vss, VIA23, vssAxis.getXMax(), yaxis, powerWidth, ywidth )
          
          westContactsVss.insert( -1, westContact )
          eastContactsVss.insert( -1, eastContact )

        self.createVertical( westContactsVss, vssAxis.getXMin(), powerWidth )
        self.createVertical( eastContactsVss, vssAxis.getXMax(), powerWidth )

        xcenter = vssAxis.getCenter().getX() - powerWidth//2 - toDbU(5.0)
        accessContactsVss = \
          [ Contact.create( vss, VIA23 , xcenter, vssAxis.getYMax(), powerWidth, powerWidth )
          , Contact.create( vss, METAL3, xcenter,      toDbU(528.0), powerWidth, toDbU(2.0) ) 
          ]
        northContactsVss = \
          [   westContactsVss[-1]
          , accessContactsVss[ 0]
          ,   eastContactsVss[-1]
          ]
        southContactsVss = \
          [ westContactsVss[0]
          , eastContactsVss[0]
          ]
        
        self.createHorizontal(  southContactsVss, vssAxis.getYMin(), powerWidth )
        self.createHorizontal(  northContactsVss, vssAxis.getYMax(), powerWidth )
        self.createVertical  ( accessContactsVss, xcenter          , powerWidth )
        for component in accessContactsVss[-1].getSlaveComponents():
          NetExternalComponents.setExternal( component )

        ab.inflate( powerSpacing + powerWidth*2 + toDbU(20.0) )
        self.setAbutmentBox( ab )
        
        return


def scriptMain ( **kw ):
    editor = None
    if 'editor' in kw and kw["editor"]:
      editor = kw["editor"]

    ringo = RingOscillator( 'ringoscillator' )
    ringo.save()
    if editor:
      editor.setCell( ringo.getCell() )
      editor.fit()
    return True 


if __name__ == "__main__":
    scriptMain()
    sys.exit( 0 )
