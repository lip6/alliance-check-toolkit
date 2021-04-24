#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os.path
import Cfg
import Hurricane
from   Hurricane  import DbU, DataBase, UpdateSession, Library, Cell
import Viewer     
import CRL        
from   helpers.io      import ErrorMessage
from   helpers.overlay import UpdateSession
import Unicorn


def scriptMain ( **kw ):
    editor = None
    if kw.has_key('editor') and kw['editor']:
      editor = kw['editor']
  
    with UpdateSession():
        rootLib = DataBase.getDB().getRootLibrary()
        gdsLib  = rootLib.getLibrary( 'GDS' )
        if not gdsLib:
            print 'Creating GDS library.'
            gdsLib = Library.create( rootLib, 'GDS' )
       #cell = Cell.create( gdsLib, 'quad_reference' )
        CRL.Gds.load( gdsLib, './PLL.gds' )
        cell = gdsLib.getCell( 'gds_PLL' )
        #cell = Cell.create( gdsLib, 'inv_x1' )
        #CRL.Gds.load( gdsLib, './inv_x1.gds' )
        if editor: editor.setCell( cell )
  
    return cell
