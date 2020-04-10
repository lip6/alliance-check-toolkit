#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os.path
import Cfg
import Hurricane
from   Hurricane  import DbU
from   Hurricane  import DataBase
from   Hurricane  import UpdateSession
from   Hurricane  import Library
from   Hurricane  import Cell
import Viewer     
import CRL        
from   helpers.io import ErrorMessage
import Unicorn


def scriptMain ( **kw ):
  editor = None
  if kw.has_key('editor') and kw['editor']:
    editor = kw['editor']

  UpdateSession.open()
  rootLib = DataBase.getDB().getRootLibrary()
  gdsLib  = rootLib.getLibrary( 'GDS' )
  if not gdsLib:
    print 'Creating GDS library.'
    gdsLib = Library.create( rootLib, 'GDS' )
  cell   = Cell.create( gdsLib, 'chip' )
  UpdateSession.close()
  CRL.Gds.load( gdsLib, './chip.gds' )
  if editor: editor.setCell( cell )

  return cell
