#!/usr/bin/python

import sys		
from   coriolis.Hurricane import *
from   coriolis.CRL       import *
from   coriolis.helpers   import staticInitialization
from   coriolis           import oroshi

staticInitialization( quiet=True )


def toDbU    ( l ): return DbU.fromPhysical( l, DbU.UnitPowerMicro )

def doBreak( level, message ):
    UpdateSession.close()
    Breakpoint.stop( level, message )
    UpdateSession.open()

def toNano  ( value ): return DbU.toPhysical( value, DbU.UnitPowerNano  )
def toMicro ( value ): return DbU.toPhysical( value, DbU.UnitPowerMicro )
def toUnity ( value ): return DbU.toPhysical( value, DbU.UnitPowerUnity )

def  buildSnake( editor ) :
    
    UpdateSession.open()

    cell = AllianceFramework.get().createCell( 'snakeT' )
   #cell.setTerminal( True )

    cell.setAbutmentBox( Box( toDbU(0.0), toDbU(0.0), toDbU(5.5), toDbU(5.5) ) )

    
    if editor:
        UpdateSession.close()
        editor.setCell( cell )
        editor.fit()
        UpdateSession.open()
    
    technology = DataBase.getDB().getTechnology()
    poly       = technology.getLayer( "poly" )
    
    rules                    = oroshi.getRules()
    transistorMinL           = rules.transistorMinL
    transistorMinW           = rules.transistorMinW
    minExtension_active_poly = rules.minExtension_active_poly
    minExtension_poly_active = rules.minExtension_poly_active

    w = transistorMinW
    l = transistorMinL


    gateNet = Net.create( cell, "gate" )
    gateNet.setExternal( True )   
    hg = Horizontal.create( gateNet, poly, toDbU(2.75), toDbU(3.3), toDbU(1.1), toDbU(4.4) ) 
    NetExternalComponents.setExternal( hg )


    UpdateSession.close()
   
    AllianceFramework.get().saveCell( cell, Catalog.State.Views )
    return

def scriptMain( **kw ):
    editor = None
    if 'editor' in kw and kw['editor']:
        editor = kw['editor']
    buildSnake( editor )
    return True
