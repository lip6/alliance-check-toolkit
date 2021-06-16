#!/usr/bin/env python
# -*- coding: utf-8 -*-

from   __future__ import print_function
import sys
import os.path
import Cfg
import Hurricane
from   Hurricane  import DbU, DataBase, UpdateSession, Library, Cell, \
                         Net, Pad, Box
import Viewer     
import CRL        
from   helpers         import u
from   helpers.io      import ErrorMessage
from   helpers.overlay import UpdateSession
import Unicorn


af = CRL.AllianceFramework.get()


def convertLogo ( gdsLib, name ):
    print( '     - GDS Logo "{0}.gds" --> "{0}_norm.gds".'.format(name) )
    tech   = DataBase.getDB().getTechnology()
    layers = {}
    for i in range(1,7):
        metalName  = 'METAL{}'.format(i)
        nofillName = 'METAL{}BLK'.format(i)
        layers[ metalName  ] = tech.getLayer( metalName )
        layers[ nofillName ] = tech.getLayer( nofillName )
    CRL.Gds.load( gdsLib, './{}.gds'.format(name) )
    refCell = gdsLib.getCell( 'gds_nazca' )
    with UpdateSession():
        dupAb   = Box()
        dupCell = Cell.create( gdsLib, '{}_norm'.format(name) )
        loneNet = Net.create( dupCell, 'lone_net' ) 
        for instance in refCell.getInstances():
            for net in instance.getMasterCell().getNets():
                #print( net )
                for component in net.getComponents():
                    #print( component )
                    if not isinstance(component,Pad): continue
                    origBb   = component.getBoundingBox()
                    shrinkBb = Box( origBb.getXMin() / 2
                                  , origBb.getYMin() / 2
                                  , origBb.getXMax() / 2
                                  , origBb.getYMax() / 2 )
                    if component.getLayer().getName() == 'METAL6':
                        for i in range(1,7):
                            Pad.create( loneNet
                                      , layers[ 'METAL{}'.format(i) ]
                                      , shrinkBb )
                    elif component.getLayer().getName() == 'METALxBLK':
                        for i in range(1,7):
                            Pad.create( loneNet
                                      , layers[ 'METAL{}BLK'.format(i) ]
                                      , shrinkBb )
                            dupAb.merge( shrinkBb )
        dupCell.setAbutmentBox( dupAb )
        #if name == 'libresoc_logo':
        #    for i in range(1,7):
        #        Pad.create( loneNet
        #                  , layers[ 'METAL{}'.format(i) ]
        #                  , Box( u(6.50), u(7.5), u(7), u(7.75)) )
    CRL.Gds.save( dupCell )
    with UpdateSession():
        refCell.destroy()
    return dupCell


def scriptMain ( **kw ):
    global af
    editor = None
    if kw.has_key('editor') and kw['editor']:
      editor = kw['editor']
    gdsLib = None
    with UpdateSession():
        rootLib = DataBase.getDB().getRootLibrary()
        gdsLib  = rootLib.getLibrary( 'GDS' )
        if not gdsLib:
            print( '  o  Creating GDS library.' )
            gdsLib = Library.create( rootLib, 'GDS' )
            af.wrapLibrary( gdsLib, 0 )
    cell = convertLogo( gdsLib, 'C4MLogo' )
    if editor: editor.setCell( cell )
    cell = convertLogo( gdsLib, 'lip6' )
    if editor: editor.setCell( cell )
    cell = convertLogo( gdsLib, 'sorbonne_logo' )
    if editor: editor.setCell( cell )
    cell = convertLogo( gdsLib, 'libresoc_logo' )
    if editor: editor.setCell( cell )
    return cell
