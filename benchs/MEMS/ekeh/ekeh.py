#!/usr/bin/python

import sys
import Cfg
from   Hurricane import *
import CRL
from   helpers import u
import math


class EShape ( object ):

    def __init__ ( self ):
# input parameters 
        self.N              = 4
        self.dentLength     = u(1.0)
        self.dentWidth      = u(1.0)
        self.dentSpacing    = u(1.0)
        self.handleWidth    = u(1.0)
        self.transformation = Transformation()
#Output parameters
        self.area    = u(0.0); 

        return

    def _dentPoints ( self, i ):
        points = []
        points.append( Point(  self.handleWidth
                            , (self.dentSpacing + self.dentWidth)*i + self.dentWidth) )
        points.append( Point(  self.handleWidth + self.dentLength
                            , (self.dentSpacing + self.dentWidth)*i + self.dentWidth ) )
        points.append( Point(  self.handleWidth + self.dentLength
                            , (self.dentSpacing + self.dentWidth)*i ) )
        points.append( Point(  self.handleWidth
                            , (self.dentSpacing + self.dentWidth)*i ) )
        return points

    def drawLayout ( self, net, layer ):
        self.area=u(0)
        points = []
        points.append( Point( u( 0.0 ), u( 0.0 ) ) )
        points.append( Point( u( 0.0 ), (self.dentSpacing + self.dentWidth)*(self.N-1) + self.dentWidth) )
        for i in range(self.N):
          points += self._dentPoints( self.N-i-1 )
        points.append( Point( self.handleWidth, u(0.0) ) )


        #print( 'ID position.' )
        #for j in range(len(points)):
        # print( '     | %2d %s' % (j,points[j]))
        
        for point in points: self.transformation.applyOn( point )

       # print( 'After transformation.' )
       # for j in range(len(points)):
       #   print( '     | %2d %s' % (j,points[j]))

        Rectilinear.create( net, layer, points )
        #Calculation of the are of the structure
        self.area=self.handleWidth*((self.dentSpacing + self.dentWidth)*(self.N)-self.dentSpacing )+(self.N)*self.dentWidth*self.dentLength;
        #print( self.handleWidth*1e-5, self.dentSpacing*1e-5, self.dentWidth*1e-5, self.dentLength*1e-5, self.N)

        return



class FShape ( object ):

    def __init__ ( self ):
      #input parameters
        self.N              = 4
        self.dentLength     = u(1.0)
        self.dentWidth      = u(1.0)
        self.dentSpacing    = u(1.0)
        self.handleWidth    = u(1.0)
        self.transformation = Transformation()
        self.endLength      = u(1.0) 
        self.mobile         = False
        #output parameter
        self.area           = u(0)
        return

    def _dentPoints ( self, i ):
        points = []
        points.append( Point(  self.handleWidth
                            , (self.dentSpacing + self.dentWidth)*i - self.dentSpacing + self.endLength) )
        points.append( Point(  self.handleWidth + self.dentLength
                            , (self.dentSpacing + self.dentWidth)*i - self.dentSpacing + self.endLength) )
        points.append( Point(  self.handleWidth + self.dentLength
                            , (self.dentSpacing + self.dentWidth)*i - self.dentWidth - self.dentSpacing + self.endLength) )
        points.append( Point(  self.handleWidth
                            , (self.dentSpacing + self.dentWidth)*i - self.dentWidth- self.dentSpacing + self.endLength) )
        return points

    def drawLayout ( self, net, layer ):
        self.area=u(0)
        points = []
        points.append( Point( u( 0.0 ), u( 0.0 ) ) )
        points.append( Point( u( 0.0 ), (self.dentSpacing + self.dentWidth)*self.N - self.dentSpacing + self.endLength ) )
        for i in range(self.N):
          points += self._dentPoints( self.N-i )
        points.append( Point( self.handleWidth, u(0.0) ) )
         
        #print( 'ID position.' )
        #for j in range(len(points)):
        #  print( '     | %2d %s' % (j,points[j]) )

        for point in points: self.transformation.applyOn( point )

       #print( 'After transformation.' )
       #for j in range(len(points)):
       #  print( '     | %2d %s' % (j,points[j]) )

        self.area=self.handleWidth*((self.dentSpacing + self.dentWidth)*self.N - self.dentSpacing+self.endLength)+self.N*self.dentWidth*self.dentLength;
        return Rectilinear.create( net, layer, points )



class FShapeMobile ( object ):

    def __init__ ( self ):
      #input parameters
        self.N              = 4
        self.dentLength     = u(1.0)
        self.dentWidth      = u(1.0)
        self.dentSpacing    = u(1.0)
        self.handleWidth    = u(1.0)
        self.transformation = Transformation()
        self.endLength      = u(1.0) 
        self.gMin       = u(50.0)
        self.dMax       = u(50.0)
 
        #output parameter
        self.area           = u(0)
        return

    def drawLayout ( self, net, layer ):
        
        self.area = u(0)

        handle=MobileBlock()
        handle.width=self.handleWidth
        handle.length=self.N*(self.dentWidth+self.dentSpacing)-self.dentSpacing+self.endLength
        handle.gMin=self.gMin
        handle.dMax=self.dMax
        handle.isConnectToMobile=True
        handle.transformation=Transformation(0,int(handle.length), Transformation.Orientation.R3)
        self.transformation.applyOn(handle.transformation)
        handle.drawLayout(net, layer)     
        self.area=self.area+handle.area

         
        for i in range(self.N):
          points = []
          points.append( Point( handle.width, handle.length-i*(self.dentWidth+self.dentSpacing) ) )
          points.append( Point( handle.width+self.dentLength, handle.length-i*(self.dentWidth+self.dentSpacing) ) )
          points.append( Point( handle.width+self.dentLength, handle.length-i*(self.dentWidth+self.dentSpacing)-self.dentWidth ) )
          points.append( Point( handle.width, handle.length-i*(self.dentWidth+self.dentSpacing)-self.dentWidth ) )
          for point in points: self.transformation.applyOn( point )
          Rectilinear.create( net, layer, points )
        self.area=self.N*self.dentWidth*self.dentLength+self.area
        return 

class TransducerAO ( object ):

    def __init__ ( self ):
# input parameters 
        self.N              = 4 # numbe of capacitors
        self.dentOverlap     = u(1.0) # recovery length 
        self.dentRoomLeft     = u(1.0) # free motion to left length
        self.dentRoomRight     = u(1.0) # free motion to left length  
        self.dentWidth      = u(1.0)
        self.gap    = u(1.0)
        self.handleWidth    = u(1.0)
        self.endLength      = u(1.0)
        self.transformation = Transformation()
#Output parameters
        self.mobileArea    = u(0.0) 
        self.length         = self.endLength+self.N*self.gap+(self.N+2)*self.dentWidth
        self.width         = self.handleWidth*2+self.dentOverlap+self.dentRoomLeft+self.dentRoomRight 
        self.gMin       = u(50.0)
        self.dMax       = u(50.0)
        self.mobileWithHoles = False

        return

    def geometryCalculation(self):
        self.length        = self.endLength+self.N*self.gap+(self.N+2)*self.dentWidth
        self.width         = self.handleWidth*2+self.dentOverlap+self.dentRoomLeft+self.dentRoomRight 
        
        if self.handleWidth<=self.gMin+2*self.dMax or self.length<= self.gMin+2*self.dMax:
          self.mobileWithHoles=False
        else: 
          self.mobileWithHoles=True
        return


    def drawLayout ( self, net, layer ):
        self.area=u(0)
       
       # parameters of fShape for the fixed part and maybe for the mobile part
        fShapeGenerator = FShape()
        fShapeGenerator.dentLength     = self.dentOverlap + self.dentRoomRight
        fShapeGenerator.dentWidth      = self.dentWidth 
        fShapeGenerator.dentSpacing    = self.dentWidth+2*self.gap 
        fShapeGenerator.handleWidth    = self.handleWidth 
        fShapeGenerator.endLength    = self.endLength 
        fShapeGenerator.transformation = self.transformation
        
           #mobile part: 
        if self.mobileWithHoles == True: 
          fshapemobile=FShapeMobile()
          fshapemobile.N              = self.N//2
          fshapemobile.dentLength     = self.dentOverlap + self.dentRoomLeft
          fshapemobile.dentWidth      = self.dentWidth
          fshapemobile.dentSpacing    = self.dentWidth+2*self.gap
          fshapemobile.handleWidth    = self.handleWidth
          fshapemobile.transformation=self.transformation

          fshapemobile.endLength      = self.endLength 
          fshapemobile.gMin          =     self.gMin 
          fshapemobile.dMax       = self.dMax
          fshapemobile.drawLayout(net, layer)
          self.mobileArea=fshapemobile.area
        else: 
          fShapeGenerator.N              = self.N//2
          fShapeGenerator.drawLayout(net, layer)
          self.mobileArea=fShapeGenerator.area

          #fixed part: 
        fShapeGenerator.N              = self.N//2
        transformPart=Transformation(self.handleWidth*2+self.dentOverlap+self.dentRoomLeft+self.dentRoomRight, self.dentWidth*(self.N+1)+self.gap*self.N+self.endLength+self.endLength-self.gap-self.dentWidth, Transformation.Orientation.R2)
        self.transformation.applyOn(transformPart)

        fShapeGenerator.transformation=transformPart
        fShapeGenerator.N=fShapeGenerator.N+1
        fShapeGenerator.drawLayout(net, layer)
        #print( 'Transd. mobile area (um2):', self.mobileArea*1e-10 )
        return

class MobileBlock ( object ):

    def __init__ ( self ):
# input parameters 
        self.width      = u(100.0) # numbe of capacitors
        self.length     = u(100.0) # recovery length 
        self.gMin       = u(50.0)
        self.dMax       = u(50.0)
        self.transformation = Transformation()
        self.isConnectToMobile = True 
        

#Output parameters
        self.area    = u(0.0) 

        return

    def drawLayout ( self, net, layer ):

        self.area                      = 0

        if self.isConnectToMobile == True:
          ICTM=0
        else: 
          ICTM=1

        numberEBlocks=int(math.floor((self.length-self.dMax*ICTM)/(self.dMax+self.gMin))) 

        eShapeGenerator = EShape()
        eShapeGenerator.N              = int(math.floor((self.width-self.dMax)/(self.dMax+self.gMin)))+1
        eShapeGenerator.dentLength     = int(math.floor((self.length-(numberEBlocks+ICTM)*self.dMax)/numberEBlocks))
        eShapeGenerator.dentWidth      = self.dMax 
        eShapeGenerator.dentSpacing    = int(math.floor((self.width-(eShapeGenerator.dentWidth*eShapeGenerator.N))/(eShapeGenerator.N-1)))
        eShapeGenerator.handleWidth    = self.dMax

       


        for i in range(numberEBlocks):
          eShapeGenerator.transformation = Transformation( (eShapeGenerator.dentLength+eShapeGenerator.handleWidth)*i, u(0.0), Transformation.Orientation.ID )
          self.transformation.applyOn(eShapeGenerator.transformation)
          eShapeGenerator.drawLayout( net, layer )
          self.area=eShapeGenerator.area+self.area
          #print( 'eShapeGenerator area in MObile Block (um2):', eShapeGenerator.area*1e-10 )

        if self.isConnectToMobile == False: 
          points = []
          points.append(Point((eShapeGenerator.handleWidth+eShapeGenerator.dentLength)*numberEBlocks, 0))
          points.append(Point((eShapeGenerator.handleWidth+eShapeGenerator.dentLength)*numberEBlocks, eShapeGenerator.N*eShapeGenerator.dentWidth+(eShapeGenerator.N-1)*eShapeGenerator.dentSpacing))
          points.append(Point((eShapeGenerator.handleWidth+eShapeGenerator.dentLength)*numberEBlocks+eShapeGenerator.handleWidth, (eShapeGenerator.N)*eShapeGenerator.dentWidth+(eShapeGenerator.N-1)*eShapeGenerator.dentSpacing))
          points.append(Point((eShapeGenerator.handleWidth+eShapeGenerator.dentLength)*numberEBlocks+eShapeGenerator.handleWidth, 0))
          for point in points: self.transformation.applyOn( point )
          Rectilinear.create( net, layer, points )
          self.area=self.area+eShapeGenerator.handleWidth*eShapeGenerator.N*eShapeGenerator.dentWidth+(eShapeGenerator.N-1)*eShapeGenerator.dentSpacing
        #print( "Mobile Block area:", int(self.area*1e-10) )
        return

def buildTest ( editor ):



    # top level device parameters 

    structHeight                      = 100e-6 # thickness of the structual layer
    transdNCap                        = 300 # number of capacitors per transducer 
    transdDentOverlap                 = u(100.0) #recovery length
    transdDentRoomLeft                = u(100.0) # free motion to left length
    transdDentRoomRight               = u(100.0) # free motion to left length
    transdDentWidth                   = u(10.0)
    transdGap                         = u(7.0)
    transdHandleWidth                 = u(240.0)
    transdEndLength                   = u(50.0)

    transducerNumber=10
    transducerSpacing=u(200.0)

    differentialTransducerSpacing=u(200.0)

    massWidth=u(8000.0)
    dMax     =u(50)
    gMin     =u(20)

    densitySi=2.33e3


    UpdateSession.open()

    MEMSLibrary = DataBase.getDB().getRootLibrary().getLibrary( 'MEMS' )

    cell = Cell.create( MEMSLibrary, 'multimod' )

    net    = Net.create( cell, 'net1' )
    struct = DataBase.getDB().getTechnology().getLayer( 'struct' )



###########TEST SECTION############## - SHOULD BE REMOVED IN THE FINAL SCRIPT####
    ##### test ######
    test_fshapemobile=FShapeMobile()
    test_fshapemobile.N              = 10 
    test_fshapemobile.dentLength     = u(200)
    test_fshapemobile.dentWidth      = u(20)
    test_fshapemobile.dentSpacing    = u(40)
    test_fshapemobile.handleWidth    = u(200)
    test_fshapemobile.transformation = Transformation(u(-2000), u(-2000), Transformation.Orientation.ID)
    test_fshapemobile.endLength      = u(100) 
    test_fshapemobile.gMin       = u(50.0)
    test_fshapemobile.dMax       = u(50.0)
    #test_fshapemobile.drawLayout(net, struct)
    #print( test_fshapemobile.area*1e-22*1e12 )


    ####### test ######
    test_transducerAO=TransducerAO() 
    test_transducerAO.N              = transdNCap # number of capacitors
    test_transducerAO.dentOverlap    = transdDentOverlap # recovery length 
    test_transducerAO.dentRoomLeft   = transdDentRoomLeft # free motion to left length
    test_transducerAO.dentRoomRight  = transdDentRoomRight # free motion to left length  
    test_transducerAO.dentWidth      = transdDentWidth
    test_transducerAO.gap            = transdGap 
    test_transducerAO.handleWidth    = transdHandleWidth 
    test_transducerAO.endLength      = transdEndLength
    test_transducerAO.gMin           = gMin
    test_transducerAO.dMax           = dMax
    test_transducerAO.transformation = Transformation(u(-3000), u(-3000), Transformation.Orientation.ID);
    test_transducerAO.mobileWithHoles=True
    #test_transducerAO.geometryCalculation()
    #test_transducerAO.drawLayout( net, struct )
    #print( test_transducerAO.mobileArea*1e-22*1e12 )

    test_EShape=EShape()
    test_EShape.N   = 10 
    test_EShape.transformation = Transformation(u(-3000), u(-3000), Transformation.Orientation.ID);
    test_EShape.drawLayout( net, struct )
    print( 'test_Eshape.area (um2):', test_EShape.area*1e-10 )


    test_FShape=FShape()
    test_FShape.N   = 5
    test_FShape.transformation = Transformation(u(-3000), u(-3000), Transformation.Orientation.ID);
    #test_FShape.drawLayout( net, struct )

    test_FShapeMobile=FShapeMobile()
    test_FShapeMobile.N   = 3
    test_FShapeMobile.transformation = Transformation(u(-3000), u(-3000), Transformation.Orientation.ID);
    test_FShapeMobile.gMin   = u(1.0) 
    test_FShapeMobile.dMax   = u(1.0) 
    test_FShapeMobile.handleWidth   = u(10.0) 

    #test_FShapeMobile.drawLayout( net, struct )
    
    test_MB=MobileBlock()
    test_MB.width      = u(300.0) 
    test_MB.length     = u(300.0) 
    test_MB.gMin       = u(50.0)
    test_MB.dMax       = u(50.0)
    test_MB.transformation = Transformation(u(-3000), u(-3000), Transformation.Orientation.ID);
    #test_MB.drawLayout( net, struct )
    #print( test_MB.area*1e-10 )





    CRL.Gds.save( cell )

    if editor:
      editor.setCell( cell )
      editor.fit()
    return





def buildMEMS ( editor ):


    ######## top level device parameters ###########
    ####### All parameters must be defined here only ########

    # Energy converting differential transducer parameters
    structHeight                      = 100e-6 # thickness of the structual layer
    transdNCap                        = 400 # number of capacitors per transducer 
    transdDentOverlap                 = u(100.0) #overlap length of the transducers fingers
    transdDentRoomLeft                = u(100.0) # free motion to left length
    transdDentRoomRight               = u(100.0) # free motion to left length
    transdDentWidth                   = u(10.0) 
    transdGap                         = u(7.0) # gap between fingers
    transdHandleWidth                 = u(200.0) # Width of the comp handle
    transdEndLength                   = u(80.0) # length of the comb handle end (without fingers)

    transducerNumber=10 # Number of combs of each transducer (in the differential pair) at one side of the mass
    transducerSpacing=u(200.0) # Distance between the combs of the same transducer

    differentialTransducerSpacing=u(200.0) #Distance between the differential transducers


  
    # Sensing transducer parameters (for the capacitance measurement)
    sensingTransducerNumber=2
    sensingTransducerSpacing=u(500)
    PowerToSensingSpacing=u(500)
    differentialSensingTransducerSpacing=u(200)
    

    massWidth=u(8000.0)
    dMax     =u(50)
    gMin     =u(20)

    densitySi=2.33e3
    springK = 10


    UpdateSession.open()

    MEMSLibrary = DataBase.getDB().getRootLibrary().getLibrary( 'MEMS' )

    cell = Cell.create( MEMSLibrary, 'multimod' )

    net    = Net.create( cell, 'net1' )
    struct = DataBase.getDB().getTechnology().getLayer( 'struct' )
    area=u(0);

   # Generating the rigid block (the main mass).
   # parameters of the main mass.
    halfMassLength=(transdHandleWidth*2+transdDentOverlap+transdDentRoomRight+transdDentRoomLeft+transducerSpacing)*transducerNumber-transducerSpacing
    massLength=halfMassLength*2+differentialTransducerSpacing
      # Length of the sensing section: 
    halfSensingLength=(transdHandleWidth*2+transdDentOverlap+transdDentRoomRight+transdDentRoomLeft+sensingTransducerSpacing)*sensingTransducerNumber-sensingTransducerSpacing
    sensingLength=halfSensingLength*2+differentialSensingTransducerSpacing+PowerToSensingSpacing


    mass=MobileBlock()
    mass.width=massWidth
    mass.length=massLength+sensingLength
    mass.gMin=gMin
    mass.dMax=dMax
    mass.isConnectToMobile=False
    mass.drawLayout(net, struct)
    area=area+mass.area

    
   # transducer parameters
    test_transducerAO=TransducerAO() 
    test_transducerAO.N              = transdNCap # numbe of capacitors
    test_transducerAO.dentOverlap    = transdDentOverlap # recovery length 
    test_transducerAO.dentRoomLeft   = transdDentRoomLeft # free motion to left length
    test_transducerAO.dentRoomRight  = transdDentRoomRight # free motion to left length  
    test_transducerAO.dentWidth      = transdDentWidth
    test_transducerAO.gap            = transdGap 
    test_transducerAO.handleWidth    = transdHandleWidth 
    test_transducerAO.endLength      = transdEndLength
    test_transducerAO.gMin           = gMin
    test_transducerAO.dMax           = dMax

    test_transducerAO.geometryCalculation()
 
#upper transducers
    for i in range(transducerNumber):
      test_transducerAO.transformation = Transformation(i*test_transducerAO.width+transducerSpacing*i, massWidth, Transformation.Orientation.ID)
      test_transducerAO.drawLayout( net, struct )
      area=area+test_transducerAO.mobileArea

      test_transducerAO.transformation = Transformation(massLength-i*test_transducerAO.width-transducerSpacing*i, massWidth, Transformation.Orientation.MX)
      test_transducerAO.drawLayout( net, struct )
      area=area+test_transducerAO.mobileArea


# Lower transducers
    for i in range(transducerNumber):
      test_transducerAO.transformation = Transformation(i*test_transducerAO.width+transducerSpacing*i, 0, Transformation.Orientation.MY)
      test_transducerAO.drawLayout( net, struct )
      area=area+test_transducerAO.mobileArea

      test_transducerAO.transformation = Transformation(massLength-(i+1)*test_transducerAO.width-transducerSpacing*i+test_transducerAO.width, 0, Transformation.Orientation.R2)
      test_transducerAO.drawLayout( net, struct )
      area=area+test_transducerAO.mobileArea

# Sensing transducers


     #upper transducers
    for i in range(sensingTransducerNumber):
      test_transducerAO.transformation = Transformation(massLength+PowerToSensingSpacing+i*test_transducerAO.width+sensingTransducerSpacing*i, massWidth, Transformation.Orientation.ID)
      test_transducerAO.drawLayout( net, struct )
      area=area+test_transducerAO.mobileArea
    
      test_transducerAO.transformation = Transformation(massLength+sensingLength-i*test_transducerAO.width-sensingTransducerSpacing*i, massWidth, Transformation.Orientation.MX)
      test_transducerAO.drawLayout( net, struct )
      area=area+test_transducerAO.mobileArea
    
    
     # Lower transducers
    for i in range(sensingTransducerNumber):
      test_transducerAO.transformation = Transformation(massLength+PowerToSensingSpacing+i*test_transducerAO.width+sensingTransducerSpacing*i, 0, Transformation.Orientation.MY)
      test_transducerAO.drawLayout( net, struct )
      area=area+test_transducerAO.mobileArea
    
      test_transducerAO.transformation = Transformation(massLength+sensingLength-(i+1)*test_transducerAO.width-sensingTransducerSpacing*i+test_transducerAO.width, 0, Transformation.Orientation.R2)
      test_transducerAO.drawLayout( net, struct )
      area=area+test_transducerAO.mobileArea
     #Sensing transducer support block 

       
    UpdateSession.close()
    cell.setAbutmentBox( cell.getBoundingBox() )


    mobileMass=area*1e-22*structHeight*densitySi
    powerTransdCapacitance0=8.85e-12*transdDentOverlap*structHeight/transdGap*transdNCap*transducerNumber*2
    powerTransdGradientCapa=8.85e-12*structHeight/transdGap*transdNCap*transducerNumber*2*1e11
    powerTransdForce50V=0.5*50*50*powerTransdGradientCapa
    sensingTransdCapacitance0=8.85e-12*transdDentOverlap*structHeight/transdGap*transdNCap*sensingTransducerNumber*2
    
    print( '  o  Saving GDS "%s"...' % cell.getName() )
    #print("single transducer mobile area (um2): %d" %(test_transducerAO.mobileArea*1e-10))
    print ('mobile area (um2) = %1.2e' %(area*1e-10))
    print ('mass (kg) = %1.2e' %(mobileMass))
    print ('one single converter transducer capacitance (pF) = %d' %(powerTransdCapacitance0*1e12))
    print ('one single sensing transducer capacitance (pF) = %d' %(sensingTransdCapacitance0*1e12))
    print ('capacitance gradient (pF/um) = %.2f' %(powerTransdGradientCapa*1e6))
    print ('force at 50V (N) = %1.2e' %(powerTransdForce50V))
    print ('Spring force at maximum displacement and k=%dN/m (N) = %1.2e' %(springK, transdDentRoomLeft*springK*1e-11))
    print('Resonance frequency (Hz) = %.1f' %(1/2.0/3.1415926*math.sqrt(springK/mobileMass)))
    print('Free displacement under 1g, 0 Hz (m) = %.1e' %(mobileMass*10.0/springK))
    print('Power max. with 1Hz under 1g, 0 Hz (W) = %.1e' %(4.0*mobileMass*10.0*100e-6*1.0))


    CRL.Gds.save( cell )

    if editor:
      editor.setCell( cell )
      editor.fit()
    return


def scriptMain ( **kw ):
    editor = None
    if 'editor' in kw and kw['editor']:
      editor = kw['editor']

    cell = CRL.AllianceFramework.get().getCell( 'mems', CRL.Catalog.State.Views )
    if cell:
        UpdateSession.open()
        if editor: editor.removeHistory( cell )
        cell.destroy()
        UpdateSession.close()
        print( 'Previous "mems" cell destroyed.' )


    buildMEMS( editor )
    #buildTest( editor )
    print( (u(100)) )
    return True

