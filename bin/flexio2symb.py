#!/usr/bin/env python3

# This file is part of the Coriolis Software.
# Copyright (c) SU 2020-2021, All Rights Reserved
#
# +-----------------------------------------------------------------+
# |     A l l i a n c e   C h e c k   T o o l k i t                 |
# |   Symbolic Converter for FlexLib018 I/O Pad Cells               |
# |                                                                 |
# |  Author      :                    Jean-Paul CHAPUT              |
# |  E-mail      :            Jean-Paul.Chaput@lip6.fr              |
# | =============================================================== |
# |  Python      :  "./flexio2symb.py"                              |
# +-----------------------------------------------------------------+


import sys
import os
import os.path
import socket
import Cfg
from   Hurricane import Breakpoint
from   Hurricane import DataBase
from   Hurricane import DbU
from   Hurricane import Box
from   Hurricane import Transformation
from   Hurricane import Point
from   Hurricane import Box
from   Hurricane import Layer
from   Hurricane import Net
from   Hurricane import NetExternalComponents
from   Hurricane import RoutingPad
from   Hurricane import Pad
from   Hurricane import Horizontal
from   Hurricane import Vertical
from   Hurricane import Contact
from   Hurricane import Pin
from   Hurricane import Plug
import CRL
import helpers
from   helpers         import trace, dots, l, u, n
from   helpers.io      import ErrorMessage
from   helpers.io      import WarningMessage
from   helpers.io      import vprint
from   helpers.io      import catch
from   helpers.overlay import UpdateSession

NdaDirectory = None
if 'NDA_TOP' in os.environ:
    NdaDirectory = os.environ['NDA_TOP']
if not NdaDirectory:
    hostname = socket.gethostname()
    if hostname.startswith('lepka'):
        NdaDirectory = '/dsk/l1/jpc/crypted/soc/techno'
        if not os.path.isdir(NdaDirectory):
            print( '[ERROR] You forgot to mount the NDA encrypted directory, stupid!' )
    else:
        NdaDirectory = '/users/soft/techno/techno'
helpers.setNdaTopDir( NdaDirectory )

import NDA.node180.flexlib_cm018
NDA.node180.flexlib_cm018.setup()


af   = None
tech = None


# ----------------------------------------------------------------------------
# Class  :  "Converter".

class Converter ( object ):
    """
    Convert the abstract of a FlexLib018 I/O pad cell into a symbolic
    cell. The resulting symbolic cell is in *no way* correct (DRC).
    Their only purpose is to train the P&R chip tools.
    """
    Superior    = 0x0010
    Inferior    = 0x0020
    Inwards     = 0x0040
    AsSegment   = 0x0080
    Two         = 0x0100
    Ten         = 0x0200
    OptionsMask = Two|Ten|AsSegment

    def __init__ ( self, cell ):
        self.realCell  = cell
        self.symbCell  = None
        self.oneLambda = DbU.fromLambda( 1.0 )
        self.tenLambda = 10*self.oneLambda

    def _lengthToSymb ( self, u, rounding ): 
        """
        Pitch the coordinates ``u`` to the symbolic grid, according
        to ``rounding`` (Superior or Inferior).
        """
        pitch = self.oneLambda
        if   rounding&Converter.Two: pitch = 2*self.oneLambda
        elif rounding&Converter.Ten: pitch =   self.tenLambda
        remainder = u % pitch
        if remainder:
            if rounding & Converter.Superior: u = u + (pitch - remainder)
            else:                             u = u -          remainder
        return u

    def _toSymb ( self, v, rounding ): 
        """
        Pitch the coordinates of object ``v`` to the symbolic grid,
        according to ``rounding``. Were ``v`` can be:

        * A scalar, then rounding is Inferior or Superior.
        * A Box, then rounding is:
          
          * Inwards: the pitched box will be fully enclosed in the
            original box.
          * Outwards: the pitched box will fully enclose the original
            box.
        """
        if isinstance(v,long): return _lengthToSymb( v, rounding )
        if isinstance(v,Box):
            hoptions = rounding & Converter.OptionsMask
            voptions = hoptions
            if rounding & Converter.AsSegment:
                if v.getWidth() > v.getHeight():
                    voptions |= Converter.Two
                else:
                    hoptions |= Converter.Two
            if rounding & Converter.Inwards:
                roundings = [ Converter.Superior
                            , Converter.Superior
                            , Converter.Inferior
                            , Converter.Inferior ]
            else:
                roundings = [ Converter.Inferior
                            , Converter.Inferior
                            , Converter.Superior
                            , Converter.Superior ]
            xMin = self._lengthToSymb( v.getXMin(), roundings[0]|hoptions )
            yMin = self._lengthToSymb( v.getYMin(), roundings[1]|voptions )
            xMax = self._lengthToSymb( v.getXMax(), roundings[2]|hoptions )
            yMax = self._lengthToSymb( v.getYMax(), roundings[3]|voptions )
            if xMax - xMin < 2*self.oneLambda:
                xMin -= self.oneLambda
                xMax += self.oneLambda
            if yMax - yMin < 2*self.oneLambda:
                yMin -= self.oneLambda
                yMax += self.oneLambda
            return Box( xMin, yMin, xMax, yMax )
        return v

    def doCell ( self ):
        """Perform the Cell real to symbolic translation"""
        global af
        with UpdateSession():
            self.symbCell = af.createCell( self.realCell.getName()+'dup' )
            vprint( 2, '  o   Convert "{}" -> "{}".'.format(self.realCell.getName()
                                                           ,self.symbCell.getName() ) )
            vprint( 2, '      - ONE Lambda is {}'.format(DbU.toPhysical(self.oneLambda,DbU.UnitPowerMicro)) )
            ab = self._toSymb( self.realCell.getAbutmentBox(), Converter.Ten )
            self.symbCell.setAbutmentBox( ab )
            for net in self.realCell.getNets():
                vprint( 2, '      + {}'.format(net) )
                for component in NetExternalComponents.get(net):
                    if isinstance(component,Horizontal):
                        self._componentToSymbolic( component )
                    elif isinstance(component,Vertical):
                        self._componentToSymbolic( component )
           #self.symbCell.setName( self.realCell.getName() )
            af.saveCell( self.symbCell, CRL.Catalog.State.Physical )

    def _componentToSymbolic ( self, component ):
        global tech
        vprint( 2, '      | {}'.format(component) )
        realNet = component.getNet()
        symbNet = self.symbCell.getNet( component.getNet().getName() )
        if symbNet is None:
            symbNet = Net.create( self.symbCell, component.getNet().getName() )
            symbNet.setExternal( True )
            symbNet.setGlobal( realNet.isGlobal() )
            if realNet.isPower (): symbNet.setType( Net.Type.POWER )
            if realNet.isGround(): symbNet.setType( Net.Type.GROUND )
            if realNet.isClock (): symbNet.setType( Net.Type.CLOCK )
        layerName = component.getLayer().getName()
        if layerName.endswith('.pin'):
            layerName = layerName[:-4]
        layer = tech.getLayer( layerName )
        bb = component.getBoundingBox()
        bb = self._toSymb( bb, Converter.Inwards|Converter.AsSegment )
        if bb.getWidth() > bb.getHeight():
            duplicated = Horizontal.create( symbNet
                                          , layer
                                          , bb.getCenter().getY()
                                          , bb.getHeight()
                                          , bb.getXMin()
                                          , bb.getXMax()
                                          )
        else:
            duplicated = Vertical.create( symbNet
                                        , layer
                                        , bb.getCenter().getX()
                                        , bb.getWidth()
                                        , bb.getYMin()
                                        , bb.getYMax()
                                        )
        vprint( 2, '    D | {}'.format(duplicated) )
        NetExternalComponents.setExternal( duplicated )
        

if __name__ == '__main__':
    try:
        af        = CRL.AllianceFramework.get()
        tech      = DataBase.getDB().getTechnology()
        flexiolib = af.getAllianceLibrary( 1 )
        if not flexiolib:
            raise( ErrorMessage( 2, 'No Library at index 1, please check SYSTEM_LIBRARY in settings.py.' ))
        if flexiolib.getLibrary().getName() != 'FlexIO':
            raise( ErrorMessage( 2, 'Library at index {} is not "FlexIO" ("{}").' \
                                    .format(flexiolib.getLibrary().getName()) ))
        with helpers.overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
            cfg.misc.catchCore           = False
            cfg.misc.info                = False
            cfg.misc.paranoid            = False
            cfg.misc.bug                 = False
            cfg.misc.logMode             = True
            cfg.misc.verboseLevel1       = True
            cfg.misc.verboseLevel2       = True
        for cell in flexiolib.getLibrary().getCells():
            converter = Converter( cell )
            converter.doCell()
    except Exception as e:
        helpers.io.catch( e )
        sys.exit( 1 )
    sys.exit( 0 )
